# BattleKart Audit

## Scope

This audit starts at [BattleKart.asm](./BattleKart.asm) and follows the code it
actually patches, imports, and calls:

- direct hooks and per-frame dispatch in `BattleKart.asm`
- `BattleKartFlag/BattleKartFlag.c`
- `BattleBots/BattleBotAI.c`
- `Library/MarioKartObjects.c`
- the actively included `Library/LIBRARYBUILD*.asm` hooks
- path, custom-course, and boot functions reached from those hooks

Commented implementations and library features with no call path from
`BattleKart.asm` were excluded. A function being present in the `Library`
directory is not sufficient for inclusion: it must be linked, hooked, or
called by the BattleKart assembly/build graph.

The current working trees are dirty, so the findings describe the supplied
working copy rather than a guaranteed clean-HEAD checkout.

## Active call map

The important active entry points are:

1. `GlobalCustomCode` -> `allRunSwitch` -> `allRun`
2. `PrintMenuHook` -> `printMenuSwitch` -> `PrintMenuFunction` -> `menuStuff`
3. `gameCode` -> `inRace` -> mode-specific routines in `BattleKart.asm`
4. `runAtCourseInitialization` -> stock/custom setup, `ResetPathfinderBots`,
   and `beforeCourseLoadsInit`
5. `afterMapDataLoads` -> `BattleInit` -> `getStartingPositions`
6. controller hook -> `botControlWrapper` -> `botControl` -> `ManualStickDrive`
7. per-mode calls into `BattleKartFlag.c`, including CTF, Keep Away, Coins,
   Shell Shooter support, rendering, and collisions

`Library/LIBRARYBUILD1.asm` also installs active hooks for custom courses,
collision, rendering, balloon/item behavior, weather defaults, audio, boot,
and menu code. Only findings tied to these active hooks are listed below.

## Findings

### BKASM-001 - High: Keep Away/one-flag CTF bots target the holder incorrectly

**Active path**

`inRace` -> `runBots` -> `getRival`.

**Evidence**

[BattleBotAI.c line 1877](./BattleBots/BattleBotAI.c#L1877) tests:

```c
flag_holder - 1 != currentPlayer
```

before targeting `flag_holder`. `playerHoldingFlag[0]` stores a normal
zero-based player index, just like `currentPlayer`; the subtraction by one is
not appropriate.

**Impact**

- The flag holder can select itself as its rival.
- The preceding player can be incorrectly treated as not being the holder.
- Bots receiving the flag can chase/steer toward themselves instead of
  pursuing a valid opponent, or fail to switch targets as intended.

**Recommended fix**

Compare `flag_holder != currentPlayer`.

Add a four-player table test for current player 0-3 and holder 0-3, including
team mode and `flag_holder == -1`.

### BKASM-002 - High: Rival selection can accept an invalid final candidate

**Active path**

`runBots` -> `getRival` in all modes, plus special Zombombs branches.

**Evidence**

The retry loops in [BattleBotAI.c lines 1936-2000](./BattleBots/BattleBotAI.c#L1936)
contain conditions of the form:

```c
} while (currentPlayer == enemy
         || count < 20
         || otherInvalidCandidateCondition);
```

`count < 20` makes the loop continue for at least 20 iterations, regardless of
whether the candidate has already been valid. After iteration 20, the loop can
exit even if `enemy == currentPlayer`, is dead, is a bomb when disallowed, or is
not a preferred human target.

The Zombombs survivor branch at
[BattleBotAI.c line 1940](./BattleBots/BattleBotAI.c#L1940) also does not
check dead players despite its surrounding comment.

**Impact**

Bots can spend 20 random trials discarding valid targets and then accept an
invalid final target. In Zombombs this can produce self-targeting or targeting
an ineligible player. In ordinary modes it can target a dead kart or the same
kart.

**Recommended fix**

Separate “candidate invalid” from “retry budget exhausted”:

```c
do {
    enemy = ...;
    count++;
} while (candidateIsInvalid(enemy) && count < 20);
```

If the budget is exhausted, explicitly choose a valid fallback or signal no
target. Do not return an unchecked random candidate.

### BKASM-003 - High: Three-player team mode can select player four

**Active path**

`runAtCourseInitialization` allows team mode for three players, then
`runBots` -> `getRival`.

**Evidence**

[BattleKart.asm lines 8531-8540](./BattleKart.asm#L8531) turns off teams only
when `player_count == 2`; three-player teams remain enabled.

In the general team-target branch,
[BattleBotAI.c lines 1978-1988](./BattleBots/BattleBotAI.c#L1978), Team 1 always
chooses:

```c
enemy = MakeRandomLimmit(2) + 2; // 2 or 3
```

Player indices are zero-based, so a three-player game has valid indices 0-2
only. The same problem can occur in related team targeting logic.

**Impact**

Three-player Team 1 bots can target inactive player four. Their steering and
item logic then uses an inactive player state as the objective. It can produce
wandering bots, bad item usage, and invalid collision/scoring assumptions.

**Recommended fix**

Build candidates from the active player count and opposing-team membership.
Disallow team mode in three-player games only if that is an intentional product
rule; otherwise support unequal 2-v-1 teams explicitly.

### BKASM-004 - High: Shell Shooter still runs item-reroll logic

**Active path**

Item roulette hook at [BattleKart.asm line 329](./BattleKart.asm#L329)
`itemReroll`.

**Evidence**

[BattleKart.asm lines 814-821](./BattleKart.asm#L814):

```asm
LI a1, 6
BEQ a0, a0, @@branch_check_if_shell_shooter
NOP
BEQ zero, zero, @@branch_end_item_reroll
LI v1, 0
```

The first branch compares `a0` to itself, so it is always taken. The code meant
for Shell Shooter cannot clear `v1` and jump to the end.

**Impact**

Shell Shooter reaches the normal item enable/reroll table instead of suppressing
the stock rolled item. Depending on the current item fields, this can expose
normal item roulette behavior or create a reroll loop that conflicts with Shell
Shooter's custom ammo/fire implementation.

**Recommended fix**

The comparison must be against `a1` (the Shell Shooter mode value), and the
branch labels should match the intended fall-through direction:

```asm
BNE a0, a1, @@not_shell_shooter
...
```

Test mode 6 with each item toggle and all items disabled.

### BKASM-005 - Medium: Squish scoring attributes kills to the nearest player

**Active path**

Squish hook at `0x08EDC0` ->
`hijackSetBrokenWhenSquished` ->
`find_nearest_player` -> `incrementScoreOnHit`.

**Evidence**

[BattleKart.asm lines 9408-9445](./BattleKart.asm#L9408) asks C for the
nearest player to the squished kart:

[find_nearest_player](./BattleKartFlag/BattleKartFlag.c#L754) scans every
active player except the victim and returns the shortest Euclidean distance.
It does not check who crossed the victim, whether the candidate is alive, or
team membership.

**Impact**

A nearby bystander, dead kart, or teammate can receive the Squish point instead
of the player that actually squished the victim. This is observable whenever
several karts overlap or a prior attacker is no longer nearest.

**Recommended fix**

Record the squashing collision's source player at the original collision hook,
then score that ID. At minimum, exclude dead/inactive players and teammates and
fallback only when the original source truly is unavailable.

### BKASM-006 - Medium: Active flag/base/shell creation assumes object space

**Active paths**

- Shell Shooter: `hijackExecuteItem` -> `MasterCreateObject`
- CTF/Keep Away: `setFlag`, `setBase`, `dropFlagAfterHit` -> `CreateObject*`
- custom item-box loading: `PlaceIBoxes` -> `addObjectBuffer`

**Evidence**

[MasterCreateObject](./Library/MarioKartObjects.c#L14) immediately uses the
short returned by `addObjectBuffer` as `g_SimpleObjectArray[GlobalShortA]`,
without checking a failed allocation.

The active Shell Shooter caller ignores the returned slot and writes to it at
[BattleKartFlag.c lines 1566-1570](./BattleKartFlag/BattleKartFlag.c#L1566).
Flag/base callers likewise store their type/ID fields through the returned
index at [BattleKartFlag.c lines 1862-1872](./BattleKartFlag/BattleKartFlag.c#L1862)
and [BattleKartFlag.c lines 2250-2258](./BattleKartFlag/BattleKartFlag.c#L2250).

`PlaceIBoxes` indexes without checking its returned slot at
[CustomLevels.c lines 711-718](./Library/CustomCourses/CustomLevels.c#L711).

**Impact**

If the stock simple-object table is full, a failed allocation can cause a
negative or invalid index write. Shell Shooter is especially exposed because a
successful shot can consume a slot while shells are already present. CTF
recreation and custom item-box loading can hit the same condition.

**Recommended fix**

Make `MasterCreateObject` handle failure before indexing, and have callers
abort the shot/object placement without consuming ammo or changing flag state.
Guard `PlaceIBoxes` the same way. Add a full-table host test.

### BKASM-007 - Medium: Custom-course objective IDs are used as array indices

**Active path**

`afterMapDataLoads` -> `BattleInit` for every custom course.

**Evidence**

[BattleKartFlag.c lines 455-505](./BattleKartFlag/BattleKartFlag.c#L455) reads
`CustomObjectivePoints[ThisObj].Player` from course data and directly indexes:

- `SpawnPoint[Player]`
- `multiFlagPositionsHolder[...][Player]`
- `basePositionsHolder[...][Player]`

There is no check that `Player` is 0-3 before these writes. The same loaded data
later drives the flag/base creation paths.

**Impact**

A malformed or stale custom-course objective table can corrupt adjacent Battle
Kart state during map startup. Because this runs before gameplay begins, the
result can be an intermittent startup crash or corrupted CTF state.

**Recommended fix**

Reject objective records whose player index is outside 0-3 and validate that
the objective list contains the records required for the selected mode before
creating any objects.

### BKASM-008 - High: Race-course bots leave the path table unterminated

**Active path**

`runAtCourseInitialization` -> `ResetPathfinderBots`, when `ci == 4` for a
stock race course.

**Evidence**

[BattleBotAI.c line 256](./BattleBots/BattleBotAI.c#L256) checks a signed-short
path marker for:

```c
PositionArray[0] == 0x8000
```

`PositionArray[0]` is a `short`; an in-memory `0x8000` marker has the value
`-32768`. The integer literal `0x8000` has the value `32768`. The MIPS compiler
confirms this with:

```text
warning: comparison is always false due to limited range of data type
```

The branch that would set the final chunk length and `LineCounts[ci][0]` to the
actual number of chunks can therefore never execute. The static `RacePaths`
arrays begin with 95 active chunks and lengths of 19 at
[RaceCoursePaths.c lines 2263-2275](./BattleKartPaths/RaceCoursePaths.c#L2263).

**Impact**

Race-course bots can select all 95 placeholder chunks, including chunks beyond
the real course path. Unfilled markers remain zero-valued, so bots can steer
toward `(0, 0, 0)` or use invalid path extents rather than stopping at the
authored path end. The inactive remainder can dominate bot routing on race
courses.

**Recommended fix**

Compare against `(short)0x8000` or `-32768`, and always bound the chunk loop by
the fixed 95-slot table. Also set the final chunk length from
`RaceCoursePathLength` independently of the sentinel so a malformed terminator
cannot leave stale path metadata.

### BKASM-009 - High: Team end-of-match logic kills the wrong players

**Active path**

`inRace` -> mode routine -> `winConditions`.

**Evidence**

The team winner/loser blocks at
[BattleKart.asm lines 2580-2650](./BattleKart.asm#L2580) have incorrect
`killPlayer` argument lists:

| Condition | Intended losing team | Players actually killed |
|---|---|---|
| Team 1 HP reaches zero | P1/P2 (`0,1`) | `0,1,3` |
| Team 2 HP reaches zero | P3/P4 (`2,3`) | `1,2,3` |
| Team 1 wins by score | P3/P4 (`2,3`) | `1,2,3` |
| Team 2 wins by score | P1/P2 (`0,1`) | `0,1,3` |

The final score comparison block is at
[BattleKart.asm lines 2700-2735](./BattleKart.asm#L2700).

**Impact**

Every team result kills one member of the winning team and, in some cases,
leaves a losing player alive. This can make the game declare/animate the wrong
winner, force results screens from inconsistent balloon/player states, and
break subsequent score/winner display.

**Recommended fix**

Kill exactly `0,1` when Team 2 wins and exactly `2,3` when Team 1 wins in every
stock, timed, and point-scoring branch. Prefer a small loop over the losing
team's active player range to avoid duplicated player lists.

### BKASM-010 - High: Zombombs counts an inactive fifth player

**Active path**

`runGameModeZombombs` and bot rival selection through `all_players_bombs`.

**Evidence**

Both bomb-count loops increment the player pointer and counter, then compare
the already-consumed counter at the end:

- [BattleKart.asm lines 3200-3215](./BattleKart.asm#L3200)
- [BattleKart.asm lines 3470-3495](./BattleKart.asm#L3470)

With `player_count == 4`, the loop visits indices 0, 1, 2, 3, and 4 before the
branch ends. With 2 or 3 players, it likewise examines one inactive player past
the configured count.

**Impact**

An inactive player's bomb-state byte can change `a0`, the counted number of
bombs. This can prevent the Zombombs victory condition from recognizing that
all active players are bombs, misclassify the state when bots select rivals,
or read unrelated adjacent player-state memory.

**Recommended fix**

Use an explicit `index < player_count` count loop. Increment the pointer and
counter together at the start/end of one iteration and do not inspect any
player index `>= player_count`.

## Build/integration findings relevant to the active assembly

### BKASM-011 - High: The active ROM patch has no identity check

[BattleKart.asm lines 7-16](./BattleKart.asm#L7) opens a fixed base ROM and uses
absolute [LIBRARYBUILD1.asm](./Library/LIBRARYBUILD1.asm) patches. The assembly
does not assert the original ROM header/revision or expected words at replaced
instructions.

**Impact**

An incorrect US revision, PAL ROM, or modified base ROM can be patched at the
same addresses while all C and BattleKart code otherwise appears to assemble.
Execution then reaches incompatible instruction layouts.

**Recommended fix**

Fail the build if the ROM header/CRC/revision is not the supported build. Assert
representative original instruction words before replacing each hook family.

### BKASM-012 - Medium: Active payload growth has no link-time boundary check

BattleKart places its code at `PAYLOAD_ROM 0x00D00000` /
`PAYLOAD_RAM 0x80400000` and imports BattleKart objects immediately afterward,
ending at `end_label` at
[BattleKart.asm lines 94-99](./BattleKart.asm#L94).

`DMA_MAX_LENGTH` is computed from the assembled end, but no assertion verifies
that the payload remains within the intended ROM/RAM range or avoids other
resident sections.

**Impact**

Future imports, path data, models, or C globals can silently grow into reserved
ROM/RAM and corrupt a working build.

**Recommended fix**

Add explicit maximum-ROM and maximum-RAM assertions. Emit final payload start,
end, size, and DMA length in the build log.

## Explicitly out of scope

Code that is not imported or reached from the BattleKart assembly call graph
was excluded. The implemented CTF mode covered here is the
`BattleKartFlag.c` object-based path invoked by `runGameModeCTF`.

## Validation performed

The existing focused suite was rerun:

```sh
sh tests/run_pathfinding_tests.sh
```

It passed with ASan/UBSan, including all Fortress route/objective cases. The
suite does not cover the mode dispatch, bot rival logic, Shell Shooter, Squish
scoring, object exhaustion, or CTF allocation paths described above.

Shell syntax validation for `BattleKart.sh` also passes. A full armips ROM build
was assembled successfully into an isolated temporary output by changing only
the output ROM filename. The assembled BattleKart path section starts at
`0x8046F100` / ROM `0x00D6F100` and is `0xFD00` bytes. This did not modify the
existing `BattleKart64.z64`.

## Priority

1. Fix BKASM-001, BKASM-002, and BKASM-003 together because they share bot
   target selection.
2. Fix BKASM-004 and add a Shell Shooter item-roll test.
3. Record real Squish collision ownership (BKASM-005).
4. Add allocation-result propagation for active object creators (BKASM-006).
5. Validate custom objective records (BKASM-007).
6. Fix race path termination (BKASM-008).
7. Correct team and Zombombs player enumeration (BKASM-009 and BKASM-010).
8. Add ROM/payload assertions (BKASM-011 and BKASM-012).
