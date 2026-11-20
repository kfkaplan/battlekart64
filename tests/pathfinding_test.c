#include <assert.h>
#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

#define MainInclude
typedef unsigned int uint;
typedef unsigned short ushort;
typedef float Vector[3];
typedef struct { short Position[3], Group; } Marker;
typedef struct { Vector position; } TestPlayer;
typedef struct { short category, flag; float fparam; Vector position; } Object;
#define MAX_OBJECT 100
#define IBOX 12
#define EXISTOBJ 0x8000
#define HITOBJ 0x4000
#define PythagoreanTheorem(x1, x2, z1, z2) (pow((x1)-(x2), 2) + pow((z1)-(z2), 2))
#include "../Library/Player/Pathfinding.h"

TestPlayer GlobalPlayer[4];
Object g_SimpleObjectArray[MAX_OBJECT];
Vector objectPosition;

bool TestCollideSphere(float a[], float ar, float b[], float br)
{
    float x = a[0] - b[0], y = a[1] - b[1], z = a[2] - b[2];
    return x*x + y*y + z*z <= (ar+br)*(ar+br);
}

#include "pathfinding_core.c"
#include "../BattleKartPaths/BobombFortPaths.c"

static Marker **PathSets[] = {BobFort4_Paths, BobFort4_Ramps, BobFort4_Drops};
static short *LengthSets[] = {BobFort4_PathLengths, BobFort4_RampLengths, BobFort4_DropLengths};

static bool AtTarget(BKPathfinder *bot, Vector position, float radius, float height)
{
    float dy = position[1] - bot->Target[1];
    return dy * dy < height * 0.75f && TestCollideSphere(bot->Target, radius, position, radius);
}

/* Mirrors BattleBotAI.c's Fortress hand-off from path following to direct target steering. */
static bool CanSteerToTarget(BKPathfinder *bot, Vector position, float radius, float height)
{
    return BKRouteAllowsDirectSteer(bot, 0.5f * sqrtf(height)) &&
           AtTarget(bot, position, radius / 225 * 110, height);
}

static int FollowRoute(Vector start, Vector goal, float radius, float height)
{
    BKPathfinder bot = {0};
    bot.TargetPath = -1;
    memcpy(bot.Target, goal, sizeof(Vector));
    Vector position;
    memcpy(position, start, sizeof(Vector));
    bool visited[3][60][2] = {{{false}}};
    for (int hop = 0; hop < 168; hop++)
    {
        if (!UpdateBKRoute(&bot, position, radius, height))
        {
            fprintf(stderr, "No route: start %.0f,%.0f,%.0f -> %.0f,%.0f,%.0f at %.0f,%.0f,%.0f\n",
                    start[0], start[1], start[2], goal[0], goal[1], goal[2],
                    position[0], position[1], position[2]);
            return -1;
        }
        Marker *path = PathSets[(int)bot.PathType][bot.TargetPath];
        short length = LengthSets[(int)bot.PathType][bot.TargetPath];
        assert(bot.Progression >= 0 && bot.Progression <= length);
        assert(bot.PathType != DROPPATH || bot.Direction == 1);
        if (CanSteerToTarget(&bot, position, radius, height))
            return hop;
        if (visited[(int)bot.PathType][bot.TargetPath][bot.Direction > 0])
        {
            fprintf(stderr, "Loop: start %.0f,%.0f,%.0f -> %.0f,%.0f,%.0f, type %d path %d dir %d\n",
                    start[0], start[1], start[2], goal[0], goal[1], goal[2],
                    bot.PathType, bot.TargetPath, bot.Direction);
            return -1;
        }
        visited[(int)bot.PathType][bot.TargetPath][bot.Direction > 0] = true;
        for (int marker = bot.Progression; marker >= 0 && marker <= length; marker += bot.Direction)
        {
            for (int axis = 0; axis < 3; axis++)
                position[axis] = path[marker].Position[axis];
            position[1] += 5;
            bot.NearestMarker = marker;
            bot.NearestMarkerHeight = path[marker].Position[1];
            if (CanSteerToTarget(&bot, position, radius, height))
                return hop;
        }
    }
    return -1;
}

static void TestFortressRoutes(float sx, float sy, float sz)
{
    assert(InitBKRouteGraph(PathSets, LengthSets, BobFort4_LineCounts));
    Marker original[84][35];
    for (int path = 0; path < RouteCount; path++)
    for (int marker = 0; marker <= RouteLengths[path]; marker++)
    {
        original[path][marker] = RoutePaths[path][marker];
        RoutePaths[path][marker].Position[0] *= sx;
        RoutePaths[path][marker].Position[1] *= sy;
        RoutePaths[path][marker].Position[2] *= sz;
    }
    RefreshBKRouteLengths();
    int routes = 0, failures = 0, longest = 0;
    for (int source = 0; source < RouteCount * 2 && failures < 8; source++)
    for (int target = 0; target < RouteCount * 2; target++)
    {
        Vector start, goal;
        for (int axis = 0; axis < 3; axis++)
        {
            start[axis] = RouteEndpoint(source)->Position[axis];
            goal[axis] = RouteEndpoint(target)->Position[axis];
        }
        start[1] += 5;
        int hops = FollowRoute(start, goal, 225 * fmaxf(sx, sz), sy == 0 ? 10000000 : 900 * sy * sy);
        routes++;
        if (hops < 0 && ++failures >= 8)
            break;
        if (hops > longest)
            longest = hops;
    }
    printf("Scale %.1f/%.1f/%.1f: %d routes, %d failures, longest %d paths\n",
           sx, sy, sz, routes, failures, longest);
    fflush(stdout);
    assert(failures == 0);
    /* Off-path CTF objectives from the course data; bases sit beside ramp tops, not on markers.
       The last column is the target's height above the authored point (flags +3, karts/dropped flags +5). */
    static const short Objectives[][4] = {
        {-590, 0, 112, 0}, {590, 0, -112, 0}, {-87, -12, -476, 0}, {88, -12, 476, 0},
        {-590, 0, -112, 3}, {590, 0, 112, 3}, {88, -12, -476, 3}, {-87, -12, 476, 3},
        {-528, 0, 0, 5}, {528, 0, 0, 5}, {0, -12, 476, 5}, {0, -12, -476, 5},
        {-590, 0, 112, 5}, {590, 0, -112, 5}, {-590, 0, -112, 5}, {590, 0, 112, 5},
    };
    int objective_routes = 0, objective_failures = 0;
    for (int objective = 0; objective < 16; objective++)
    for (int source = 0; source < RouteCount * 2 && objective_failures < 8; source++)
    {
        Vector start, goal = {(short)(Objectives[objective][0] * sx),
                              (short)(Objectives[objective][1] * sy) + Objectives[objective][3],
                              (short)(Objectives[objective][2] * sz)};
        for (int axis = 0; axis < 3; axis++)
            start[axis] = RouteEndpoint(source)->Position[axis];
        start[1] += 5;
        objective_routes++;
        if (FollowRoute(start, goal, 225 * fmaxf(sx, sz), sy == 0 ? 10000000 : 900 * sy * sy) < 0)
            objective_failures++;
    }
    printf("Scale %.1f/%.1f/%.1f: %d objective routes, %d failures\n",
           sx, sy, sz, objective_routes, objective_failures);
    fflush(stdout);
    assert(objective_failures == 0);
    for (int path = 0; path < RouteCount; path++)
    for (int marker = 0; marker <= RouteLengths[path]; marker++)
        RoutePaths[path][marker] = original[path][marker];
}

static void TestItemBoxes(void)
{
    g_SimpleObjectArray[0] = (Object){IBOX, (short)(EXISTOBJ | HITOBJ), -64, {0, -84, 414}};
    g_SimpleObjectArray[1] = (Object){IBOX, EXISTOBJ, -64, {464, -84, 0}};
    GetItemBoxIndexes();
    Vector position = {0, -59, 275}, target;
    assert(FindNearestItemBox(position, target, 900, true, 8) == 0);
    assert(target[0] == 0 && target[1] == -64 && target[2] == 414);
    g_SimpleObjectArray[0].position[1] = 20; /* Animated height cannot change floors. */
    assert(GetItemBoxNavigationTarget(0, target) && target[1] == -64);
    g_SimpleObjectArray[0].flag = EXISTOBJ; /* Collected box is no longer a target. */
    assert(!GetItemBoxNavigationTarget(0, target));
    assert(FindNearestItemBox(position, target, 900, true, 8) == -1);
    assert(FindNearestItemBox(position, target, 900, true, 0) == 0);
    assert(target[1] == 20); /* Other courses retain the existing target-height behavior. */
}

static void TestOneWayAndMissingRoutes(void)
{
    Marker ramp[] = {{{0, 40, 0}, 1}, {{100, 0, 0}, 1}};
    Marker *ramps[] = {ramp};
    short lengths[] = {1};
    Marker **sets[] = {NULL, NULL, ramps};
    short *sizes[] = {NULL, NULL, lengths};
    short counts[] = {0, 0, 1};
    BKPathfinder bot = {0};
    bot.Target[1] = 40;
    Vector position = {100, 0, 0};
    assert(InitBKRouteGraph(sets, sizes, counts));
    assert(!UpdateBKRoute(&bot, position, 225, 900));
    assert(bot.TargetPath == -1); /* A drop cannot be used to climb back up. */
    position[0] = 0;
    position[1] = 40;
    bot.Target[0] = 100;
    bot.Target[1] = 0;
    assert(UpdateBKRoute(&bot, position, 225, 900));
    assert(bot.PathType == DROPPATH && bot.Direction == 1);
    for (int group = 10; group <= 11; group++)
    {
        sets[0] = ramps;
        sizes[0] = lengths;
        counts[0] = 1;
        counts[2] = 0;
        ramp[0].Group = group;
        assert(InitBKRouteGraph(sets, sizes, counts));
        bool allowed = UpdateBKRoute(&bot, position, 225, 900);
        assert(allowed == (group == 10));
        if (!allowed)
            assert(bot.TargetPath == -1);
    }
    position[0] = 10000;
    assert(!UpdateBKRoute(&bot, position, 225, 900));
    counts[0] = 0;
    assert(!InitBKRouteGraph(sets, sizes, counts));
    assert(!UpdateBKRoute(&bot, position, 225, 900));
    counts[0] = BK_ROUTE_PATHS + 1;
    assert(!InitBKRouteGraph(sets, sizes, counts));
}

int main(void)
{
    assert(InitBKRouteGraph(PathSets, LengthSets, BobFort4_LineCounts));
    int stuck = 0;
    for (int path = 0; path < 60; path++)
    for (int side = 0; side < 2; side++)
    for (int goal = 0; goal < 60; goal++)
    {
        BKPathfinder test = {0};
        test.TargetPath = path;
        test.LastPath = -1;
        test.Direction = side ? 1 : -1;
        test.Progression = test.NearestMarker = side ? BobFort4_PathLengths[path] : 0;
        for (int axis = 0; axis < 3; axis++)
        {
            GlobalPlayer[0].position[axis] = BobFort4_Paths[path][test.Progression].Position[axis];
            test.Target[axis] = BobFort4_Paths[goal][0].Position[axis];
        }
        if (fabsf(test.Target[1] - GlobalPlayer[0].position[1]) >= 30 ||
            TestCollideSphere(test.Target, 110, GlobalPlayer[0].position, 110))
            continue;
        assert(UpdateBKRoute(&test, GlobalPlayer[0].position, 225, 900));
        if (test.TargetPath >= 0 && test.PathType == FLATPATH && test.Progression ==
            (test.Direction > 0 ? BobFort4_PathLengths[test.TargetPath] : 0))
        {
            if (stuck < 8)
                printf("No-op: from %d/%d toward %d -> %d/%d at marker %d\n",
                       path, side, goal, test.TargetPath, test.Direction, test.Progression);
            stuck++;
        }
    }
    printf("Already-completed path selections: %d\n", stuck);
    fflush(stdout);
    assert(stuck == 0);
    BKPathfinder bot = {0};
    bot.TargetPath = 20; /* BobFort4_Path23: the eastern lower-floor spur. */
    bot.LastPath = -1;
    bot.Direction = 1;
    bot.PathType = FLATPATH;
    bot.Progression = bot.NearestMarker = BobFort4_PathLengths[20];
    bot.Target[0] = 0;
    bot.Target[1] = -64;
    bot.Target[2] = 0;
    GlobalPlayer[0].position[0] = 464;
    GlobalPlayer[0].position[1] = -64;
    GlobalPlayer[0].position[2] = 0;
    assert(UpdateBKRoute(&bot, GlobalPlayer[0].position, 225, 900));
    printf("Lower spur -> center: path=%d direction=%d marker=%d\n",
           bot.TargetPath, bot.Direction, bot.Progression);
    assert(!(bot.TargetPath == 20 && bot.Direction == 1 && bot.Progression == 7));
    /* Team 1's base is beside the level top of ramp 0 (BobFort4_Path72); hand off there, not mid-slope. */
    bot.PathType = RAMPPATH;
    bot.TargetPath = 0;
    bot.Distance = 20.0f;
    bot.Target[0] = -590;
    bot.Target[1] = 0;
    bot.Target[2] = 112;
    bot.NearestMarkerHeight = BobFort4_Ramps[0][29].Position[1];
    assert(BKRouteAllowsDirectSteer(&bot, 15));
    bot.NearestMarkerHeight = BobFort4_Ramps[0][13].Position[1];
    assert(!BKRouteAllowsDirectSteer(&bot, 15));
    TestItemBoxes();
    TestFortressRoutes(1, 1, 1);
    TestFortressRoutes(0.5f, 0.5f, 0.5f);
    TestFortressRoutes(2, 2, 2);
    TestFortressRoutes(2, 1, 0.5f);
    TestFortressRoutes(1, 0, 1);
    TestOneWayAndMissingRoutes();
    puts("Pathfinding tests passed");
    return 0;
}
