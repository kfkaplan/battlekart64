.n64
.open "/Users/kfkaplan/Desktop/N64/unaltered_roms/Mario Kart 64.z64", "BattleKart.z64", 0 //Path to the MK64 rom and output name of battle kart rom
//.include "Core/library/MarioKart.asm"
//.include "Core/library/SubProgram.asm"
.include "Library/GameVariables/NTSC/GameOffsets.asm"
.include "Library/GameVariables/NTSC/OKHeader.asm"
.align 0x10
.importobj "Library/SharedFunctions.o"
.align 0x10
.importobj "Library/MarioKartObjects.o"
.align 0x10
.importobj "Library/MarioKart3D.o"
.align 0x10
.importobj "BattleKartFlag/BattleKartFlag.o"


// .include "library/MarioKartStats.asm"
// .include "library/MarioKartControls.asm"
// .include "library/OverKart.asm"


.org 0x10C7E2
.halfword hi(DisplayHopTable)
.org 0x10C7EA
.halfword lo(DisplayHopTable)
.org 0x10C7D4
.word 0
.org 0x10C7D8
.word 0

.org 0x109AAA
.halfword hi(CollisionJumpTable)
.org 0x109AB2
.halfword lo(CollisionJumpTable)
.org 0x109A90
.word 0
.org 0x109A9C
.word 0

// .definelabel Max_Object, 2000
// .definelabel Object_Array, 0x80600000

// .org 0x100086
// .halfword hi(Object_Array)
// .org 0x10008A
// .halfword lo(Object_Array)

// .org 0x10012A
// .halfword hi(Object_Array)
// .org 0x10012E
// .halfword lo(Object_Array)

// .org 0x1001E6
// .halfword hi(Object_Array)
// .org 0x1001EA
// .halfword lo(Object_Array)

// .org 0x100282
// .halfword hi(Object_Array)
// .org 0x100286
// .halfword lo(Object_Array)

// .org 0x1062C2
// .halfword hi(Object_Array)
// .org 0x1062CE
// .halfword lo(Object_Array)

// .org 0x106436
// .halfword hi(Object_Array)
// .org 0x106446
// .halfword lo(Object_Array)

// .org 0x10669A
// .halfword hi(Object_Array)
// .org 0x1066AE
// .halfword lo(Object_Array)

// .org 0x106C26
// .halfword hi(Object_Array)
// .org 0x106C2E
// .halfword lo(Object_Array)

// .org 0x106EFE
// .halfword hi(Object_Array)
// .org 0x106F0E
// .halfword lo(Object_Array)

// .org 0x107032
// .halfword hi(Object_Array)
// .org 0x10703A
// .halfword lo(Object_Array)

// .org 0x1070CE
// .halfword hi(Object_Array)
// .org 0x1070E2
// .halfword lo(Object_Array)

// .org 0x10727A
// .halfword hi(Object_Array)
// .org 0x10727E
// .halfword lo(Object_Array)

// .org 0x107EDE
// .halfword hi(Object_Array)
// .org 0x107EE2
// .halfword lo(Object_Array)

// .org 0x1080E2
// .halfword hi(Object_Array)
// .org 0x1080E6
// .halfword lo(Object_Array)

// .org 0x1082D6
// .halfword hi(Object_Array)
// .org 0x1082DA
// .halfword lo(Object_Array)

// .org 0x1094E6
// .halfword hi(Object_Array)
// .org 0x1094FE
// .halfword lo(Object_Array)

// .org 0x10959E
// .halfword hi(Object_Array)
// .org 0x1095A2
// .halfword lo(Object_Array)

// .org 0x109616
// .halfword hi(Object_Array)
// .org 0x10961A
// .halfword lo(Object_Array)

// .org 0x10A386
// .halfword hi(Object_Array)
// .org 0x10A39A
// .halfword lo(Object_Array)

// .org 0x10A49A
// .halfword hi(Object_Array)
// .org 0x10A49E
// .halfword lo(Object_Array)

// .org 0x10A4A6
// .halfword hi(Object_Array)
// .org 0x10A4AA
// .halfword lo(Object_Array)

// .org 0x10A676
// .halfword hi(Object_Array)
// .org 0x10A67A
// .halfword lo(Object_Array)

// .org 0x10AB56
// .halfword hi(Object_Array)
// .org 0x10AB5A
// .halfword lo(Object_Array)

// .org 0x10C56E
// .halfword hi(Object_Array)
// .org 0x10C57E
// .halfword lo(Object_Array)

// .org 0x10C7B2
// .halfword hi(Object_Array)
// .org 0x10C7BA
// .halfword lo(Object_Array)

// .org 0x10CB62
// .halfword hi(Object_Array)
// .org 0x10CB6A
// .halfword lo(Object_Array)

// .org 0x1198CA
// .halfword hi(Object_Array)
// .org 0x1198CE
// .halfword lo(Object_Array)

// .org 0x119A86
// .halfword hi(Object_Array)
// .org 0x119AA2
// .halfword lo(Object_Array)

// .org 0x119B0A
// .halfword hi(Object_Array)
// .org 0x119B26
// .halfword lo(Object_Array)

// .org 0x119BFE
// .halfword hi(Object_Array)
// .org 0x119C16
// .halfword lo(Object_Array)

// .org 0x119C7A
// .halfword hi(Object_Array)
// .org 0x119C7E
// .halfword lo(Object_Array)

// .org 0x119CAA
// .halfword hi(Object_Array)
// .org 0x119CAE
// .halfword lo(Object_Array)

// .org 0x119CDA
// .halfword hi(Object_Array)
// .org 0x119CDE
// .halfword lo(Object_Array)

// .org 0x119D0A
// .halfword hi(Object_Array)
// .org 0x119D0E
// .halfword lo(Object_Array)

// .org 0x119D3A
// .halfword hi(Object_Array)
// .org 0x119D3E
// .halfword lo(Object_Array)

// .org 0x119DCA
// .halfword hi(Object_Array)
// .org 0x119DCE
// .halfword lo(Object_Array)

// .org 0x119DFA
// .halfword hi(Object_Array)
// .org 0x119DFE
// .halfword lo(Object_Array)

// .org 0x119E2A
// .halfword hi(Object_Array)
// .org 0x119E2E
// .halfword lo(Object_Array)

// .org 0x119E5A
// .halfword hi(Object_Array)
// .org 0x119E5E
// .halfword lo(Object_Array)

// .org 0x119E8A
// .halfword hi(Object_Array)
// .org 0x119E8E
// .halfword lo(Object_Array)

// .org 0x11A1E6
// .halfword hi(Object_Array)
// .org 0x11A1EE
// .halfword lo(Object_Array)

// .org 0x11A446
// .halfword hi(Object_Array)
// .org 0x11A44A
// .halfword lo(Object_Array)

// .org 0x11A76E
// .halfword hi(Object_Array)
// .org 0x11A776
// .halfword lo(Object_Array)

// .org 0x11A996
// .halfword hi(Object_Array)
// .org 0x11A99A
// .halfword lo(Object_Array)

// .org 0x11AB02
// .halfword hi(Object_Array)
// .org 0x11AB06
// .halfword lo(Object_Array)

// .org 0x11AEA2
// .halfword hi(Object_Array)
// .org 0x11AEA6
// .halfword lo(Object_Array)

// .org 0x11AF9A
// .halfword hi(Object_Array)
// .org 0x11AF9E
// .halfword lo(Object_Array)

// .org 0x11B11E
// .halfword hi(Object_Array)
// .org 0x11B122
// .halfword lo(Object_Array)

// .org 0x11B1E6
// .halfword hi(Object_Array)
// .org 0x11B1EA
// .halfword lo(Object_Array)

// .org 0x11B3A6
// .halfword hi(Object_Array)
// .org 0x11B3AA
// .halfword lo(Object_Array)

// .org 0x11B552
// .halfword hi(Object_Array)
// .org 0x11B556
// .halfword lo(Object_Array)

// .org 0x11B62E
// .halfword hi(Object_Array)
// .org 0x11B63A
// .halfword lo(Object_Array)

// .org 0x11BD2E
// .halfword hi(Object_Array)
// .org 0x11BD32
// .halfword lo(Object_Array)

// .org 0x11C002
// .halfword hi(Object_Array)
// .org 0x11C006
// .halfword lo(Object_Array)

// .org 0x11C086
// .halfword hi(Object_Array)
// .org 0x11C096
// .halfword lo(Object_Array)

// .org 0x11C33E
// .halfword hi(Object_Array)
// .org 0x11C346
// .halfword lo(Object_Array)

// .org 0x11C486
// .halfword hi(Object_Array)
// .org 0x11C48A
// .halfword lo(Object_Array)

// .org 0x11CBD6
// .halfword hi(Object_Array)
// .org 0x11CBDA
// .halfword lo(Object_Array)

// .org 0x11CCA6
// .halfword hi(Object_Array)
// .org 0x11CCAA
// .halfword lo(Object_Array)

// .org 0x11CD1A
// .halfword hi(Object_Array)
// .org 0x11CD1E
// .halfword lo(Object_Array)

// .org 0x11CF8E
// .halfword hi(Object_Array)
// .org 0x11CFAA
// .halfword lo(Object_Array)

// .org 0x11DB42
// .halfword hi(Object_Array)
// .org 0x11DB4A
// .halfword lo(Object_Array)

// .org 0x11DB4E
// .halfword hi(Object_Array)
// .org 0x11DB52
// .halfword lo(Object_Array)

// .org 0x11DBF6
// .halfword hi(Object_Array)
// .org 0x11DBFE
// .halfword lo(Object_Array)

// .org 0x11DC02
// .halfword hi(Object_Array)
// .org 0x11DC06
// .halfword lo(Object_Array)

// .org 0x11E1AE
// .halfword hi(Object_Array)
// .org 0x11E1CA
// .halfword lo(Object_Array)

// .org 0xFB7A
// .halfword hi(Object_Array)
// .org 0xFB92
// .halfword lo(Object_Array)

// .org 0x13656
// .halfword hi(Object_Array)
// .org 0x13666
// .halfword lo(Object_Array)

// .org 0x1438E
// .halfword hi(Object_Array)
// .org 0x143A6
// .halfword lo(Object_Array)

// .org 0x14AD2
// .halfword hi(Object_Array)
// .org 0x14AD6
// .halfword lo(Object_Array)

// .org 0x1BB3A
// .halfword hi(Object_Array)
// .org 0x1BB3E
// .halfword lo(Object_Array)

// .org 0x1BBDE
// .halfword hi(Object_Array)
// .org 0x1BBE2
// .halfword lo(Object_Array)

// .org 0x1BD1A
// .halfword hi(Object_Array)
// .org 0x1BD1E
// .halfword lo(Object_Array)

// .org 0x1BECA
// .halfword hi(Object_Array)
// .org 0x1BECE
// .halfword lo(Object_Array)

// .org 0x1BFBA
// .halfword hi(Object_Array)
// .org 0x1BFBE
// .halfword lo(Object_Array)

// .org 0x1C12E
// .halfword hi(Object_Array)
// .org 0x1C132
// .halfword lo(Object_Array)

// .org 0x1C1BE
// .halfword hi(Object_Array)
// .org 0x1C1C2
// .halfword lo(Object_Array)

// .org 0x1C2B2
// .halfword hi(Object_Array)
// .org 0x1C2B6
// .halfword lo(Object_Array)

// .org 0x1C346
// .halfword hi(Object_Array)
// .org 0x1C34A
// .halfword lo(Object_Array)

// .org 0x1C43E
// .halfword hi(Object_Array)
// .org 0x1C442
// .halfword lo(Object_Array)

// .org 0x1C516
// .halfword hi(Object_Array)
// .org 0x1C522
// .halfword lo(Object_Array)

// .org 0x1C69E
// .halfword hi(Object_Array)
// .org 0x1C6A2
// .halfword lo(Object_Array)

// .org 0x1C736
// .halfword hi(Object_Array)
// .org 0x1C73A
// .halfword lo(Object_Array)

// .org 0xF98E
// .halfword hi(Object_Array)
// .org 0xF996
// .halfword lo(Object_Array)

// .org 0xF9D6
// .halfword hi(Object_Array)
// .org 0xF9DE
// .halfword lo(Object_Array)

// .org 0xFA1E
// .halfword hi(Object_Array)
// .org 0xFA26
// .halfword lo(Object_Array)

// .org 0x100072
// .halfword Max_Object

// .org 0x100106
// .halfword Max_Object

// .org 0x100116
// .halfword Max_Object

// .org 0x1001C2
// .halfword Max_Object

// .org 0x1001D2
// .halfword Max_Object

// .org 0x100262
// .halfword Max_Object

// .org 0x100272
// .halfword Max_Object

// .org 0x100306
// .halfword Max_Object

// .org 0x107EB6
// .halfword Max_Object

// .org 0x1080A2
// .halfword Max_Object

// .org 0x1080B2
// .halfword Max_Object

// .org 0x108276
// .halfword Max_Object

// .org 0x1082E2
// .halfword Max_Object

// .org 0x1082AE
// .halfword Max_Object

// .org 0x10A3AA
// .halfword Max_Object

// .org 0x10A4FE
// .halfword Max_Object

// .org 0x10A4B2
// .halfword Max_Object

// .org 0x10A692
// .halfword Max_Object + 1

// .org 0x10A46A
// .halfword Max_Object - 1

// .org 0x10A63A
// .halfword Max_Object - 1

// .org 0x1070D2
// .halfword hi(Object_Array + (0x70 * Max_Object))

// .org 0x1070DE
// .halfword lo(Object_Array + (0x70 * Max_Object))

// .org 0x10C572
// .halfword hi(Object_Array + (0x70 * Max_Object))

// .org 0x10C57A
// .halfword lo(Object_Array + (0x70 * Max_Object))

// .org 0x10CAE6
// .halfword hi(Object_Array + (0x70 * Max_Object))

// .org 0x10CAEA
// .halfword lo(Object_Array + (0x70 * Max_Object))

// .org 0x10CD02
// .halfword hi(Object_Array + (0x70 * Max_Object))

// .org 0x10CD06
// .halfword lo(Object_Array + (0x70 * Max_Object))




//.definelabel PAYLOAD_ROM, 		0x00D00000
//.definelabel PAYLOAD_RAM, 		0x80600000
.definelabel PAYLOAD_ROM, 		0x00C00000
.definelabel PAYLOAD_RAM, 		0x80500000//(overwrite code for GP mode cpus)
.definelabel DMA_FUNC,    		0x80001158
.definelabel EXCEPTION_HANDLER, 0xD1DB8
.definelabel DMA_MAX_LENGTH, 	org(end_label) - PAYLOAD_RAM
.definelabel VARIABLE_RAM_BASE,  0x80550000// ////Place in ram to store all the battle kart variables
.definelabel ROM_TO_RAM, 0x7ffff400
.definelabel RAM_TO_ROM, -0x7ffff400
.definelabel exceptionHandleJumpback,  EXCEPTION_HANDLER + ROM_TO_RAM + 0x8

/* In Game Functions */
.definelabel FUNCTION_PLAY_SOUND, 0x800C8E10
.definelabel FUNCTION_PLAY_MUSIC, 0x800C8EAC
.definelabel FUNCTION_LOAD_FONT, 0x80057710
.definelabel FUNCTION_DISPLAY_TEXT, 0x800577A4
.definelabel FUNCTION_DISPLAY_TEXT_AND_INT, 0x800577D0
.definelabel FUNCTION_DISPLAY_TEXT_AND_UINT, 0x80057814
.definelabel FUNCTION_FIND_ANGLE, 0x802B5224 //a0=x1 (pointer), a1=y1 (pointer), a2=x2 (pointer), a3=y2 (pointer), v0=returned angle
.definelabel FUNCTION_RNG, 0x802B7E34 //Random number generator, returns a random int16 in v0 between 0 and a0-1
.definelabel FUNCTION_MEMCOPY, 0x800D7FE0 //Like DMA but copy from ram -> ram, a0=output, a1=input, a2=length

/* Game variables */
.definelabel current_screen_state, 0x800DC513 //5 = results screen, 6 = force race to reset
.definelabel player_item_base, 0x80165F5F //Player has an item
.definelabel player_item_offset, 0xE0 //Offset between player item structures
.definelabel player_speed_base, 0x800F6A2C //Word that stores player's speed as a float, offset is 0xDD8
.definelabel player_collision_base, 0x800F69D5 //Byte that stores if you are colliding or not (0x01 - Going backwards when holding break (combines with 0x8 for 0x9), 0x02 - Turn left, 0x04 - Turn right, 0x08 - Colliding with wall or revering, 0x20 - Accelerating)
.definelabel player_count, 0x800DC53B //Byte storing number of players (1=1P, 2=2P, 3=3P, 4=4P)
.definelabel player_count_2, 0x800DC52F //Different byte storing number of players (0=1P, 1=2P, 3=3P or 4P)
.definelabel random_number_generator, 0x802BA290
.definelabel BUTTON_ACTIVATOR_1_P1, 0x800F6914
.definelabel BUTTON_ACTIVATOR_2_P1, 0x800F6915
.definelabel CSTICK_ACTIVATOR_X_P1, 0x8014F0F2
.definelabel CSTICK_ACTIVATOR_Y_P1, 0x8014F0F3
.definelabel angle_p1, 0x800F69BE
.definelabel angle_p2, 0x800F7796
.definelabel angle_p3, 0x800F856E
.definelabel angle_p4, 0x800F9346
.definelabel status_p1, 0x800F6990
// .definelabel status_p2,
// .definelabel status_p3,
// .definelabel status_p4,
.definelabel player_state_offset, 0xDD8
.definelabel balloon_count_p1, 0x8018D8C0
.definelabel in_results, 0x800DC5B9 //Byte storing if in the results screen or not (1=in results screen, 0=not in results screen)
.definelabel in_game, 0x800DC5B9 //Byte storing if in race is running or not (1 = in race, 0 = not in race)
.definelabel game_paused, 0x800EA16C //Byte storing if game is paused or not (> 0 = paused, 0 = not paused), this really is the game tempo which is zero when game is paused
.definelabel bot_respawn_player_offset, 0x30 //Offset between structures storing player coordinates for respawning bots that fall off the course
.definelabel insideMenu, 0x8018D9E3  //23 main 24 character 25 course 0 ingame

/* Battle Kart RAM */
.definelabel MENU_TAB, VARIABLE_RAM_BASE+0x00
.definelabel MENU_TAB_PROGRESS, VARIABLE_RAM_BASE+0x01 //Title menu y-axis movement in progress?  (0 = no, 1 = yes)
.definelabel MENU_Y_MAX, VARIABLE_RAM_BASE+0x02 //Max distance you can move in y in menu
.definelabel status_item_banana, VARIABLE_RAM_BASE+0x03 //item toggle (1=ON, 0=OFF)
.definelabel status_item_bananabunch, VARIABLE_RAM_BASE+0x04
.definelabel status_item_greenshell, VARIABLE_RAM_BASE+0x05
.definelabel status_item_threegreenshells, VARIABLE_RAM_BASE+0x06
.definelabel status_item_redshell, VARIABLE_RAM_BASE+0x07
.definelabel status_item_fakeitembox, VARIABLE_RAM_BASE+0x08
.definelabel status_item_star, VARIABLE_RAM_BASE+0x09
.definelabel status_item_ghost, VARIABLE_RAM_BASE+0x0A
.definelabel status_item_autoitems, VARIABLE_RAM_BASE+0x0B
.definelabel status_item_infgshells, VARIABLE_RAM_BASE+0x0C
.definelabel MENU_Y_GAME, VARIABLE_RAM_BASE+0x0D
.definelabel MENU_Y_ITEMS, VARIABLE_RAM_BASE+0x0E
.definelabel MENU_Y_BOTS, VARIABLE_RAM_BASE+0x0F
.definelabel MENU_Y_OPTIONS, VARIABLE_RAM_BASE+0x10
.definelabel MENU_Y_PROGRESS, VARIABLE_RAM_BASE+0x11
.definelabel MENU_X_PROGRESS, VARIABLE_RAM_BASE+0x12
.definelabel bot_status_p1, VARIABLE_RAM_BASE+0x14 //Bot status (1=ON, 0=OFF)
.definelabel bot_status_p2, VARIABLE_RAM_BASE+0x15
.definelabel bot_status_p3, VARIABLE_RAM_BASE+0x16
.definelabel bot_status_p4, VARIABLE_RAM_BASE+0x17
.definelabel bot_timer_p1, VARIABLE_RAM_BASE+0x18 //Bot timer
.definelabel bot_timer_p2, VARIABLE_RAM_BASE+0x19
.definelabel bot_timer_p3, VARIABLE_RAM_BASE+0x1A
.definelabel bot_timer_p4, VARIABLE_RAM_BASE+0x1B
.definelabel bot_steering_p1, VARIABLE_RAM_BASE+0x1C //Bot steering state (0 = go straight, 1 = turn left, 2 = turn right)
.definelabel bot_steering_p2, VARIABLE_RAM_BASE+0x1D
.definelabel bot_steering_p3, VARIABLE_RAM_BASE+0x1E
.definelabel bot_steering_p4, VARIABLE_RAM_BASE+0x1F
.definelabel bot_controller_input_p1, VARIABLE_RAM_BASE+0x20 //Bot controller input (4 bytes)
.definelabel bot_controller_input_p2, VARIABLE_RAM_BASE+0x24
.definelabel bot_controller_input_p3, VARIABLE_RAM_BASE+0x28
.definelabel bot_controller_input_p4, VARIABLE_RAM_BASE+0x2C
.definelabel status_options_flatcourses, VARIABLE_RAM_BASE+0x30 //Options toggle  (1=ON, 0=OFF)
.definelabel status_options_widescreen, VARIABLE_RAM_BASE+0x31
.definelabel status_options_antialiasing, VARIABLE_RAM_BASE+0x32
.definelabel status_options_3P4Pmusic, VARIABLE_RAM_BASE+0x33
.definelabel status_options_tempo, VARIABLE_RAM_BASE+0x34 //Game Tempo (0 = Default, 1 = 15 FPS, 2 = 20 FPS, 3=30 FPS, 4=60 FPS)
.definelabel status_options_minimap, VARIABLE_RAM_BASE+0x35 //More options toggle  (1=ON, 0=OFF)
.definelabel status_options_ludicrousspeed, VARIABLE_RAM_BASE+0x36 //More options toggle  (1=ON, 0=OFF)
.definelabel status_options_samechars, VARIABLE_RAM_BASE+0x37 //More options toggle  (1=ON, 0=OFF)
.definelabel game_mode, VARIABLE_RAM_BASE+0x38 //Game mode (0=traditional, 1=hot potato, 2=squish, ect.)
.definelabel score_mode, VARIABLE_RAM_BASE+0x39 //Scoring mode 0=Stock, 1=Time, 2=Team Points, 3=Team Time)
.definelabel status_respawn, VARIABLE_RAM_BASE+0x3A // Respawn (0=OFF, 1=ON)
.definelabel max_hp, VARIABLE_RAM_BASE+0x3C // 2 bytes - Max HP
.definelabel p1_score, VARIABLE_RAM_BASE+0x3E // 2 bytes - P1 HP/score
.definelabel p2_score, VARIABLE_RAM_BASE+0x40 // 2 bytes - P2 HP/score
.definelabel p3_score, VARIABLE_RAM_BASE+0x42 // 2 bytes - P3 HP/score
.definelabel p4_score, VARIABLE_RAM_BASE+0x44 // 2 bytes - P4 HP/score
.definelabel max_timer, VARIABLE_RAM_BASE+0x48 //4 bytes - MAX timer
.definelabel timer, VARIABLE_RAM_BASE+0x4C //4 bytes - timer
.definelabel hotpotato_countdown, VARIABLE_RAM_BASE+0x50 //2 bytes- Hot potato countdown
.definelabel hotpotato_countdown_default, VARIABLE_RAM_BASE+0x52 //2 bytes- Hot potato countdown default
.definelabel boot_flag, VARIABLE_RAM_BASE+0x54 //Flag ran in menu to ensure game has booted and DMA copy of code to expansion pak is complete
.definelabel test_flag, VARIABLE_RAM_BASE+0x55
.definelabel bot_rival_p1, VARIABLE_RAM_BASE+0x58 //Stores rival for each bot (0=P1, )
.definelabel bot_rival_p2, VARIABLE_RAM_BASE+0x59
.definelabel bot_rival_p3, VARIABLE_RAM_BASE+0x5A
.definelabel bot_rival_p4, VARIABLE_RAM_BASE+0x5B
.definelabel final_lap_music_flag, VARIABLE_RAM_BASE+0x5C //1 byte -  Play "final lap music" flag whne timer is low (0=Not played, 1=Has played)
.definelabel final_sudden_death_music_flag, VARIABLE_RAM_BASE+0x5D //Play sudden music flag when timer is zero (0=Not played, 1=Has played)
.definelabel who_was_hit_last, VARIABLE_RAM_BASE+0x5E //Who was hit last (and the hot potato) (0=nobody, 1=P2, 2=P2, 3=P3, 4=P4)
.definelabel team_1_score, VARIABLE_RAM_BASE+0x60 //2 bytes - Score for Team 1
.definelabel team_2_score, VARIABLE_RAM_BASE+0x62 //2 bytes - Score for Team 2
.definelabel max_team_points, VARIABLE_RAM_BASE+0x64 //2 bytes - Max team points (for team point score mode)
.definelabel bot_respawn_timer, VARIABLE_RAM_BASE+0x66 //2 bytes, timer for bots when they fall off the course and have to jump back
.definelabel bot_respawn_index,  VARIABLE_RAM_BASE+0x68 //1 byte, index into 3 element array for bot respawning (either = 0, 0xC, or 0x)
.definelabel bot_respawn_flag, VARIABLE_RAM_BASE+0x69 //1 byte, True = bots cannot fall off course, 0 = bots can fall off course
.definelabel bot_ai_type, VARIABLE_RAM_BASE+0x6A //1 byte, 0 = Normal with some tracking and some randomness, 1 = Seeker pure tracking, 2 = Random, no tracking
.definelabel bot_use_items,  VARIABLE_RAM_BASE+0x6B //1 byte, True = bots use items (on by default), 0 = they don't use items and are completely helpless
.definelabel bot_respawn_datastructure, VARIABLE_RAM_BASE+0x70 //3 x 4 bytes each = 12 bytes - Previous positions stored to teleport bots that fall off the map, a 3 element array 

/* Hooks */

// //General menu/titlescreen hook
// .org 0x095858
// 	J testThisHook
// 	NOP

//Title screen
.org 0x957D0
	J titleScreen
	NOP

//1p
.org 0x2214  //RAM address
	J race1P
	NOP

//2p
.org 0x269C  //RAM address
	J race2P
	NOP

//mp
.org 0x28F8  //RAM address
	J raceMP
	NOP


// //exception handler
// .org EXCEPTION_HANDLER 
// 	J 0xE9E80 + ROM_TO_RAM
// 	NOP

//Item reroll
.org 0x7BAD4
	J itemReroll

//Raise big donut to be higher when flat courses are on 
//Set up the hook inside scale height multiplier code
.org 0x111D4C
	J raiseBigDonut
	//note there is no nop because we want the delay slot to run

//Set up hook inside player initializaiotn code for battle mode
.org 0x3D970
	J setRaceCourseStartingPositions
	NOP


//Set up hook for running before course select menu is loaded
.org 0x32FC
	JAL setCourseSelectVSorBattle
	NOP


//Set up hook for running before course is initialized
.org 0x331C
	JAL runAtCourseInitialization
	NOP


// //This code runs from a hook into the exception handler, if the main battle kart code has been DMAed, then the custom code that hooks into the exception handler is jumped to and allowed to run
.org 0xD1DB0
//.org 0xE9E80
// exceptionHandlerBootCheck:
// 	LUI k0, hi(boot_flag)
// 	LBU k0, lo(boot_flag) (k0) //Check if boot has finished and GS code has been copied from rom to ram by waiting for controllers to be set up
// 	// LUI k0, hi(end_label)
// 	// LHU k0, 0x80196500
// 	// LI k1, 0xFF01
// 	BEQ k0, zero, @@branch_boot_finished //If boot has finisehd
		// NOP
		J exceptionHandlerLoop + ROM_TO_RAM //Jump to custom code
		NOP
// 	@@branch_boot_finished:
// 	//If boot has not yet finished completely (e.g. if title screen has not been reached yet), overwrite some of the main game code right after boot

// 	//Enable mirror mode
// 	LUI k0, 0x8019
// 	LI k1, 0xFF00
// 	SH k1, 0xED12 (k0)
// 	//Force crash screen to always display
// 	LI k0, 0x08001192
// 	LUI k1, 0x8000
// 	sw k0, 0x45F0 (k1)
// 	//Force starting lap to be 1, this forces the balloon with the blue shell to display in Luigi's raceway
// 	LUI k0, 0x8001
// 	SH zero, 0xF94A (k0)

// 	J exceptionHandleJumpback //Otherwise jump back to exception handler
// 	NOP


// .org 0x120F4

.org 0xE9E80 
//Runs in exception handler (like a Gameshark), necessary for some stuff
exceptionHandlerLoop:

	// LBU k0, boot_flag
	// LI k1, 1
	// BEQ k0, k1, @@branch_wait_for_boot
	// 	NOP
	// 	J exceptionHandleJumpback
	// 	NOP
	// 	@@branch_wait_for_boot:


	//Enable mirror mode
	LI k0, 0xFF00
	LUI k1, hi(0x8018ED12)
	SH k0, lo(0x8018ED12) (k1)


	//Test not falling off cliff

	// LUI k0, hi(0x800F6A5A)  //If falling over nothingness (pit or off the course)
	// LBU k0, lo(0x800F6A5A) (k0)
	// ANDI k0, k0, 0x1
	// BEQ k0, zero, @@branch_no_fall
	// 	LUI k0, hi(0x800F6A4D)//If not dash boosting
	// 	LBU k1, lo(0x800F6A4D) (k0)
	// 	ANDI k1, k1, 0x10
	// 	BNE k1, zero, @@branch_dash_boosting
	// 		LUI k0, hi(angle_p1) //flip kart angle
	// 		LH k1, lo(angle_p1) (k0)
	// 		ADDI k1, k1, 0x8000
	// 		SH k1, lo(angle_p1) (k0)
	// 		LUI k0, hi(0x800F69C8) //Moon jump
	// 		LI k1, 0x3E08
	// 		SH k1, lo(0x800F69C8) (k0)
	// 		LUI k0, hi(0x800F6A4D)//Turn on dash boost
	// 		LI k1, 0x10
	// 		SB k1, lo(0x800F6A4D) (k0)
	// 		@@branch_dash_boosting:
	// 	@@branch_no_fall: //If no longer falling






	// //Test not falling off cliff
	// // LUI k0, hi(0x800F6A5A)
	// // LBU k0, lo(0x800F6A5A) (k0)
	// // //LI k1, 1
	// // ANDI k0, k0, 0x1
	// LUI k0, hi(0x800F6A5A)
	// LBU k0, lo(0x800F6A5A) (k0)
	// //LI k1, 1
	// ANDI k0, k0, 0x1
	// BEQ k0, zero, @@branch_no_fall //If falling
	// 	//Check fall flag
	// 	LUI k0, hi(bot_fall_flag_p1)
	// 	LHU k1, lo(bot_fall_flag_p1) (k0)
	// 	BNE k1, zero, @@branch_fall_flag_off //If fall flag is off, turn it on and flip kart angle
	// 		LI k1, 0x50 //turn on timer
	// 		SH k1, lo(bot_fall_flag_p1) (k0)
	// 		LUI k0, hi(0x800F6A4D)//If dash boosting, flip the kart angle
	// 		LBU k1, lo(0x800F6A4D) (k0)
	// 		ANDI k1, k1, 0x10
	// 		BNE k1, zero, @@branch_fall_flip_kart_angle
	// 			LUI k0, hi(angle_p1) //flip kart angle
	// 			LH k1, lo(angle_p1) (k0)
	// 			ADDI k1, k1, 0x8000
	// 			SH k1, lo(angle_p1) (k0)
	// 			@@branch_fall_flip_kart_angle:
	// 		LUI k0, hi(0x800F69C8) //Moon jump
	// 		LI k1, 0x3E00
	// 		SH k1, lo(0x800F69C8) (k0)
	// 		LUI k0, hi(0x800F6A4D)//Turn on dash boost
	// 		LI k1, 0x10
	// 		SB k1, lo(0x800F6A4D) (k0)
	// 		@@branch_fall_flag_off:
	// 	LUI k0, hi(bot_fall_flag_p1)
	// 	LHU k1, lo(bot_fall_flag_p1) (k0) ////If fall flag is on, moon jump (this happens after the angle gets flipped)
	// 	BEQ k1, zero, @@branch_fall_flag_on
	// 		// LUI k0, hi(0x800F6A4D)//Turn on dash boost
	// 		// LI k1, 0x10
	// 		// SB k1, lo(0x800F6A4D) (k0)
	// 		ADDI k1, k1, -1 //Decrement timer
	// 		SH k1, lo(bot_fall_flag_p1) (k0)
	// 		BNE k1, zero, @@branch_reset_fall_byte //Reset the fall byte if timer runs out
	// 			LUI k0, hi(0x800F6A5A) //Once no longer over a pit/nothingness, flip falling off
	// 			SB zero, lo(0x800F6A5A) (k0)
	// 			@@branch_reset_fall_byte:
	// 		// LUI k0, hi(0x800F69C8) //Moon jump
	// 		// LI k1, 0x3F00
	// 		// SH k1, lo(0x800F69C8) (k0)
	// 	@@branch_fall_flag_on:
	// 	LUI k0, hi(0x800F6A2C) //add impulse to kart so that it flies back onto the course
	// 	LUI k1, 0x4500
	// 	SW k1, lo(0x800F6A2C) (k0)
	// 	@@branch_no_fall: //If no longer falling




	//Copy battle bot controller input generated by battle bot function to the current button activators (because we need to use the exception handler hook)
	//Player 1
	LBU k0, bot_status_p1 //Check if bot is on
	BEQ k0, zero, @@branch_bot_control_p1
		LUI k0, 0x8019 //Auto selet character for bot
		LI k1, 1
		SB k1, 0xEDE8 (k0)
		LBU k0, 0x800F6990 //check if in game and player is not starting or dead
		LI k1, 0xC0
		BNE k0, k1, @@branch_bot_control_p1
			LBU k0, current_screen_state //Load current screen state
			LI k1, 5 //Results screen state
			BEQ k0, k1, @@branch_bot_control_p1 //Skip copying controller input if on results screen
				LUI k0, 0x8019
				LW k1, bot_controller_input_p1 //Copy controller input into correct button activator
				SW k1, 0x6504 (k0) 
				LI k1, 0xFF010401 //Trick console/emulator into thinking controller is plugged in
				SW k1, 0x6500 (k0)
	@@branch_bot_control_p1:
	//Player 2
	LBU k0, bot_status_p2 //Check if bot is on
	BEQ k0, zero, @@branch_bot_control_p2
		LUI k0, 0x8019 //Auto selet character for bot
		LI k1, 1
		SB k1, 0xEDE9 (k0)
		LBU k0, 0x800F7768 //check if in game and player is not starting or dead
		LI k1, 0xC0
		BNE k0, k1, @@branch_bot_control_p2
			LBU k0, current_screen_state //Load current screen state
			LI k1, 5 //Results screen state
			BEQ k0, k1, @@branch_bot_control_p2 //Skip copying controller input if on results screen
				LUI k0, 0x8019
				LW k1, bot_controller_input_p2 //Copy controller input into correct button activator
				SW k1, 0x650C (k0)
				LI k1, 0xFF010401 //Trick console/emulator into thinking controller is plugged in
				SW k1, 0x6508 (k0)
	@@branch_bot_control_p2:
	//Player 3
	LBU k0, bot_status_p3 //Check if bot is on
	BEQ k0, zero, @@branch_bot_control_p3
		LUI k0, 0x8019 //Auto selet character for bot
		LI k1, 1
		SB k1, 0xEDEA (k0)
		LBU k0, 0x800F8540 //check if in game and player is not starting or dead
		LI k1, 0xC0
		BNE k0, k1, @@branch_bot_control_p3
			LBU k0, current_screen_state //Load current screen state
			LI k1, 5 //Results screen state
			BEQ k0, k1, @@branch_bot_control_p3 //Skip copying controller input if on results screen
				LUI k0, 0x8019
				LW k1, bot_controller_input_p3 //Copy controller input into correct button activator
				SW k1, 0x6514 (k0)
				LI k1, 0xFF010401 //Trick console/emulator into thinking controller is plugged in
				SW k1, 0x6510 (k0)
	@@branch_bot_control_p3:
	//Player 4
	LBU k0, bot_status_p4 //Check if bot is on
	BEQ k0, zero, @@branch_bot_control_p4
		LUI k0, 0x8019 //Auto selet character for bot
		LI k1, 1
		SB k1, 0xEDEB (k0)
		LBU k0, 0x800F9318 //check if in game and player is not starting or dead
		LI k1, 0xC0
		BNE k0, k1, @@branch_bot_control_p4
			LBU k0, current_screen_state //Load current screen state
			LI k1, 5 //Results screen state
			BEQ k0, k1, @@branch_bot_control_p4 //Skip copying controller input if on results screen
				LUI k0, 0x8019
				LW k1, bot_controller_input_p4 //Copy controller input into correct button activator
				SW k1, 0x651C (k0)
				LI k1, 0xFF010401 //Trick console/emulator into thinking controller is plugged in
				SW k1, 0x6518 (k0)
	@@branch_bot_control_p4:




	//Add same character selection if set to on
	LB k0, status_options_samechars
	BEQ k0, zero, @@branch_samechars_on
		LUI k0, 0x800B
		LI k1, 0x7FFFF
		SW zero, 0x3924 (k0)
		SH k1, 0x3936 (k0)
		SW zero, 0x39A4 (k0)
		SH k1, 0x39B6 (k0)
		SW zero, 0x3A38 (k0)
		SH k1, 0x3A4E (k0)
	@@branch_samechars_on:


	J exceptionHandleJumpback
	NOP




// overwrite boot function
.org 0x17EC //RAM address 0x80000BEC
	LUI a0, hi(PAYLOAD_RAM) //RAM address
	LUI a1, hi(PAYLOAD_ROM)
	LUI a2, hi(DMA_MAX_LENGTH)
	JAL DMA_FUNC
	ADDIU a2, a2, lo(DMA_MAX_LENGTH)
	J OriginalBootFunction
	NOP





/* Code to be DMAed (e.g. the rest of Battle Kart)*/

//.headersize 0x7F816EA0
.headersize PAYLOAD_RAM - PAYLOAD_ROM
.org PAYLOAD_RAM

start_label:

/* Text */
text_title_1: .asciiz "BATTLE KART 64"
text_title_2: .asciiz "v1.1b1 by Triclon"
text_Z: .asciiz "Z"
text_L: .asciiz "L"
text_R: .asciiz "R"
text_page_tab_items: .asciiz "ITEMS"
text_page_tab_game: .asciiz "GAME"
text_page_tab_bots: .asciiz "BOTS"
text_page_tab_options: .asciiz "OPTIONS"
text_item_banana: .asciiz "BANANA"
text_item_bananabunch: .asciiz "BANANA BUNCH"
text_item_greenshell: .asciiz "GREEN SHELL"
text_item_threegreenshells: .asciiz "3 GREEN SHELLS"
text_item_redshell: .asciiz "RED SHELL"
text_item_fakeitembox: .asciiz "FAKE ITEM BOX"
text_item_star: .asciiz "STAR"
text_item_ghost: .asciiz "GHOST"
text_item_autoitems: .asciiz "AUTO ITEMS"
text_item_infgshells: .asciiz "INF. G. SHELLS"
text_off: .asciiz "OFF"
text_on: .asciiz "ON"
text_player1: .asciiz "PLAYER 1"
text_player2: .asciiz "PLAYER 2"
text_player3: .asciiz "PLAYER 3"
text_player4: .asciiz "PLAYER 4"
text_options_flatcourses: .asciiz "FLAT COURSES"
text_options_widescreen: .asciiz "WIDESCREEN"
text_options_antialiasing: .asciiz "ANTIALIASING"
text_options_3P4Pmusic: .asciiz "3P/4P MUSIC"
text_options_samechars: .asciiz "SAME CHARS"
text_options_gametempo: .asciiz "GAME TEMPO"
text_options_mimimap: .asciiz "MINIMAP"
text_options_ludicrousspeed: .asciiz "LUDICROUS SPEED"
text_tempo_default: .asciiz "DEFAULT"
text_tempo_15fps: .asciiz "15 FPS"
text_tempo_20fps: .asciiz "20 FPS"
text_tempo_30fps: .asciiz "30 FPS"
text_tempo_60fps: .asciiz "60 FPS"
text_game_mode: .asciiz "MODE"
text_game_traditional: .asciiz "TRADITIONAL"
text_game_hotpotato: .asciiz "HOT POTATO"
text_game_squish: .asciiz "SQUISH"
text_game_testmode: .asciiz "TEST MODE"
text_scoring: .asciiz "SCORING"
text_stock: .asciiz "STOCK"
text_time: .asciiz "TIME      "
text_respawn: .asciiz "RESPAWN"
text_hp: .asciiz "HP"
text_timer: .asciiz "TIMER (MIN)"
text_countdown: .asciiz "COUNTDOWN"
text_angle: .asciiz "ANGLE: "
text_hit: .asciiz "HIT"
text_sudden_death: .asciiz "SUDDEN        DEATH"
text_semicolon: .asciiz ":"
text_semicolon_plus_zero: .asciiz ":0"
text_null: .asciiz "" //A blank spot that is just a null, used to display no text
text_team_points: .asciiz "TEAM POINTS"
text_team_time: .asciiz "TEAM TIME"
text_max_points: .asciiz "MAX POINTS"
text_team: .asciiz "TEAM"
text_score: .asciiz "SCORE"
text_team_1_score: .asciiz "TEAM 1 SCORE"
text_team_2_score: .asciiz "TEAM 2 SCORE"
text_bots_cannot_Fall: .asciiz "BOTS CAN'T FALL"
text_bot_ai_type: .asciiz "BOT AI TYPE"
text_bot_ai_normal: .asciiz "NORMAL"
text_bot_ai_seeker: .asciiz "SEEKER"
text_bot_ai_random: .asciiz "RANDOM"
text_bot_use_items: .asciiz "BOTS USE ITEMS"


//.byte 0x00 //Padding bytes in case the text doesn't use a full word at the end
//.byte 0x00
//.byte 0x00





OriginalBootFunction: //we overwrite this when DMAing our code
	JAL setDefaults //Hook into boot to set default values for battle kart variables
	NOP

	//therefore, make sure it gets ran or the game wont boot
	LUI    T6, 0x8030
	LUI    AT, 0x1FFF
	ORI    AT, AT, 0xFFFF
	ADDIU t6, t6, 0x9F80
	AND t7, t6, at
	LUI at, 0x8015
	J 0x800012AC //jump back to where execution should be on boot
	SW t7, 0x02B4 (at)



//Set game defaults on boot
setDefaults:
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)
	//Run emulator check and store result in t9
	JAL detectEmulator
	NOP
	MOVE t9, v0
	//First blank the ram
	LI a0, VARIABLE_RAM_BASE //Blank ram block start
	LI a1, VARIABLE_RAM_BASE + 0x1000 //Blank ram block end
	JAL blankRam
	NOP
	//Set default variables
	li a0, 1 //Set to be on
	NOR a0, zero, zero //Set to be on
	SB a0, status_item_banana
	SB a0, status_item_bananabunch
	SB a0, status_item_greenshell
	SB a0, status_item_threegreenshells
	SB a0, status_item_redshell
	SB a0, status_item_fakeitembox
	SB a0, status_item_star
	SB a0, status_item_ghost
	SB a0, status_options_minimap
	sb a0, status_options_antialiasing
	sb a0, bot_respawn_flag
	sb a0, bot_use_items
	li a1, 3
	SH a1, max_hp
	li a1, 0x8CBC //Set default time limit to 10 minutes
	SW a1, max_timer
	li a1, 1800 //Set default countdown for hot potato to 30 seconds (times 60 FPS)
	sh a1, hotpotato_countdown_default
	LI a1, 10 //Set default max team points to 10
	SH a1, max_team_points
	BEQ t9, zero, @@branch_set_fps 
		LI a0, 3
		SB a0, status_options_tempo
		@@branch_set_fps:
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30

//Code to hook into exception handler


//Force player starting positions in race courses to avoid crashes when loading race courses in battle mode
setRaceCourseStartingPositions:
	//Load current course
	LBU v1, 0x800DC5A1
	//Jump back if battle course branch out of here...
	LI v0, 0x13 //Big Donut
	BEQ v1, v0, @@branch_starting_positions_end
	LI v0, 0x11 //Double deck
	BEQ v1, v0, @@branch_starting_positions_end
	LI v0, 0x10 //Skyscraper
	BEQ v1, v0, @@branch_starting_positions_end
	LI v0, 0xF //Block fort
	BEQ v1, v0, @@branch_starting_positions_end

	//Positions for luigi's raceway
	LI v0, 0x08
	BNE $v1, $v0, @@branch_starting_positions_luigi_raceway
		NOP
		LUI t1, 0xC2DA
		LUI t2, 0xC301
		LUI t3, 0xC315
		LUI t4, 0xC329
		LUI a2, 0xC232
		LUI a3, 0xC334
	@@branch_starting_positions_luigi_raceway:
	//Positions for moo moo farm
	LI v0, 0x09
	BNE $v1, $v0, @@branch_starting_positions_moo_moo_farm
		NOP
		LUI t1, 0x4220
		LUI t2, 0x41A0
		LUI t3, 0x0000
		LUI t4, 0xC1A0
		LUI a2, 0x41BC
		LUI a3, 0x427C
	@@branch_starting_positions_moo_moo_farm:
	//Positions for koopa troopa beach
	LI v0, 0x06
	BNE $v1, $v0, @@branch_starting_positions_koopa_troopa_beach
		NOP
		LUI t1, 0xC080
		LUI t2, 0xC1C0
		LUI t3, 0xC230
		LUI t4, 0xC280
		LUI a2, 0x40C7
		LUI a3, 0x42DE
	@@branch_starting_positions_koopa_troopa_beach:
	//Positions for kalamari desert
	LI v0, 0x0B
	BNE $v1, $v0, @@branch_starting_positions_kalamari_desert
		NOP
		LUI t1, 0x41F8
		LUI t2, 0x4130
		LUI t3, 0xC110
		LUI t4, 0xC1E8
		LUI a2, 0x40B0
		LUI a3, 0x4403
	@@branch_starting_positions_kalamari_desert:
	//Positions for toad's turnpike
	LI v0, 0x0A
	BNE $v1, $v0, @@branch_starting_positions_toads_turnpike
		NOP
		LUI t1, 0x41F0
		LUI t2, 0x4120
		LUI t3, 0xC120
		LUI t4, 0xC1F0
		LUI a2, 0x40B0
		LUI a3, 0x4238
	@@branch_starting_positions_toads_turnpike:
	//Positions for frappe snowland
	LI v0, 0x05
	BNE $v1, $v0, @@branch_starting_positions_frappe_snowland
		NOP
		LUI t1, 0x41D0
		LUI t2, 0x40C0
		LUI t3, 0xC160
		LUI t4, 0xC208
		LUI a2, 0x40B0
		LUI a3, 0xC370
	@@branch_starting_positions_frappe_snowland:
	//Positions for Chocho Mountain
	LI v0, 0x01
	BNE $v1, $v0, @@branch_starting_positions_chocho_mountain
		NOP
		LUI t1, 0x41C0
		LUI t2, 0x4080
		LUI t3, 0xC180
		LUI t4, 0xC210
		LUI a2, 0x423C
		LUI a3, 0xC428
	@@branch_starting_positions_chocho_mountain:
	//Positions for Mario Raceway
	LI v0, 0x00
	BNE $v1, $v0, @@branch_starting_positions_mario_raceway
		NOP
		LUI t1, 0x41F0
		LUI t2, 0x4120
		LUI t3, 0xC120
		LUI t4, 0xC1F0
		LUI a2, 0x40B0
		LUI a3, 0xC34A
	@@branch_starting_positions_mario_raceway:
	//Positions for Wario Stadium
	LI v0, 0x0E
	BNE $v1, $v0, @@branch_starting_positions_wario_stadium
		NOP
		LUI t1, 0x422C
		LUI t2, 0x41B8
		LUI t3, 0x4040
		LUI t4, 0xC188
		LUI a2, 0x40B0
		LUI a3, 0x41A8
	@@branch_starting_positions_wario_stadium:
	//Positions for Sherbert land
	LI v0, 0x0C
	BNE $v1, $v0, @@branch_starting_positions_sherbert_land
		NOP
		LUI t1, 0x41A0
		LUI t2, 0x0000
		LUI t3, 0xC1A0
		LUI t4, 0xC220
		LUI a2, 0x40B0
		LUI a3, 0x41F8
	@@branch_starting_positions_sherbert_land:
	//Positions for Royal Raceway
	LI v0, 0x07
	BNE $v1, $v0, @@branch_starting_positions_royal_raceway
		NOP
		LUI t1, 0xC200
		LUI t2, 0xC250
		LUI t3, 0xC290
		LUI t4, 0xC2B8
		LUI a2, 0x40B0
		LUI a3, 0xC396
	@@branch_starting_positions_royal_raceway:
	//Positions for Bowser's Castle
	LI v0, 0x02
	BNE $v1, $v0, @@branch_starting_positions_bowsers_castle
		NOP
		LUI t1, 0x4200
		LUI t2, 0x4140
		LUI t3, 0xC100
		LUI t4, 0xC1E0
		LUI a2, 0x40B0
		LUI a3, 0xC31A
	@@branch_starting_positions_bowsers_castle:
	//Positions for DK's Jungle Parkway
	LI v0, 0x12
	BNE $v1, $v0, @@branch_starting_positions_dks_jungle_parkway
		NOP
		LUI t1, 0x4204
		LUI t2, 0x4150
		LUI t3, 0xC0E0
		LUI t4, 0xC1D8
		LUI a2, 0x40AA
		LUI a3, 0x4204
	@@branch_starting_positions_dks_jungle_parkway:
	//Positions for Yoshi's Valley
	LI v0, 0x04
	BNE $v1, $v0, @@branch_starting_positions_yoshis_valley
		NOP
		LUI t1, 0x41D8
		LUI t2, 0x40E0
		LUI t3, 0xC150
		LUI t4, 0xC204
		LUI a2, 0x4339
		LUI a3, 0x4190
	@@branch_starting_positions_yoshis_valley:
	//Positions for Banshee boardwalk
	LI v0, 0x03
	BNE $v1, $v0, @@branch_starting_positions_banshee_boardwalk
		NOP
		LUI t1, 0x420C
		LUI t2, 0x4170
		LUI t3, 0xC0A0
		LUI t4, 0xC1C8
		LUI a2, 0x418C
		LUI a3, 0xC23C
	@@branch_starting_positions_banshee_boardwalk:
	//Positions for Rainbow Road
	LI v0, 0x0D
	BNE $v1, $v0, @@branch_starting_positions_rainbow_road
		NOP
		LUI t1, 0x4210
		LUI t2, 0x4180
		LUI t3, 0xC080
		LUI t4, 0xC1C0
		LI a2, 0x44BD8000
		LUI a3, 0x4198
	@@branch_starting_positions_rainbow_road:

	//If in extra (mirroed) mode, flip the x starting positions from positive to negative
	LBU t5, 0x800DC54B //Load current CCs
	LI a0, 0x3
	BNE t5, a0, @@branch_extra_mode_is_on
		//Positions for Luigi's Raceway
		LI v0, 0x08
		BNE v1, v0, @@branch_mirror_mode_positions_luigis_raceway
			NOP
			LUI t1, 0x4329
			LUI t2, 0x4315
			LUI t3, 0x4301
			LUI t4, 0x42DA
		@@branch_mirror_mode_positions_luigis_raceway:
		//Positions for Moo Moo Farm
		LI v0, 0x09
		BNE v1, v0, @@branch_mirror_mode_positions_moo_moo_farm
			NOP
			LUI t1, 0x41A0
			LUI t2, 0x0000
			LUI t3, 0xC1A0
			LUI t4, 0xC220
		@@branch_mirror_mode_positions_moo_moo_farm:
		//Positions for Koopa Troopa Beach
		LI v0, 0x06
		BNE v1, v0, @@branch_mirror_mode_positions_koopa_troopa_beach
			NOP
			LUI t1, 0x4280
			LUI t2, 0x4230
			LUI t3, 0x41C0
			LUI t4, 0x4080
		@@branch_mirror_mode_positions_koopa_troopa_beach:
		//Positions for Kalamari Desert
		LI v0, 0x0B
		BNE v1, v0, @@branch_mirror_mode_positions_kalamari_desert
			NOP
			LUI t1, 0x4118
			LUI t2, 0x4110
			LUI t3, 0xC130
			LUI t4, 0xC1F8
		@@branch_mirror_mode_positions_kalamari_desert:
		//Positions for Toad's Turnpike
		LI v0, 0x0A
		BNE v1, v0, @@branch_mirror_mode_positions_toads_turnpike
			NOP
			LUI t1, 0x41F0
			LUI t2, 0x4120
			LUI t3, 0xC120
			LUI t4, 0xC1F0
		@@branch_mirror_mode_positions_toads_turnpike:
		//Positions for Frappe Snowland
		LI v0, 0x05
		BNE v1, v0, @@branch_mirror_mode_positions_frappe_snowland
			NOP
			LUI t1, 0x4208
			LUI t2, 0x4160
			LUI t3, 0xC0C0
			LUI t4, 0xC1D0
		@@branch_mirror_mode_positions_frappe_snowland:
		//Positions for Choco Mountain
		LI v0, 0x01
		BNE v1, v0, @@branch_mirror_mode_positions_choco_mountain
			NOP
			LUI t1, 0x4210
			LUI t2, 0x4180
			LUI t3, 0xC080
			LUI t4, 0xC1C0
		@@branch_mirror_mode_positions_choco_mountain:
		//Positions for Mario Raceway
		LI v0, 0x00
		BNE v1, v0, @@branch_mirror_mode_positions_mario_raceway
			NOP
			LUI t1, 0x41F0
			LUI t2, 0x4120
			LUI t3, 0xC120
			LUI t4, 0xC1F0
		@@branch_mirror_mode_positions_mario_raceway:
		//Positions for Wario Stadium
		LI v0, 0x0E
		BNE v1, v0, @@branch_mirror_mode_positions_wario_stadium
			NOP
			LUI t1, 0x4188
			LUI t2, 0xC040
			LUI t3, 0xC1B8
			LUI t4, 0xC22C
		@@branch_mirror_mode_positions_wario_stadium:
		//Positions for Sherbert Land
		LI v0, 0x0C
		BNE v1, v0, @@branch_mirror_mode_positions_sherbert_land
			NOP
			LUI t1, 0x4220
			LUI t2, 0x41A0
			LUI t3, 0x0000
			LUI t4, 0xC1A0
		@@branch_mirror_mode_positions_sherbert_land:
		//Positions for Royal Raceway		
		LI v0, 0x07
		BNE v1, v0, @@branch_mirror_mode_positions_royal_raceway
			NOP
			LUI t1, 0x42B8
			LUI t2, 0x4290
			LUI t3, 0x4250
			LUI t4, 0x4200
		@@branch_mirror_mode_positions_royal_raceway:
		//Positions for Bowser's Castle
		LI v0, 0x02
		BNE v1, v0, @@branch_mirror_mode_positions_bowsers_castle
			NOP
			LUI t1, 0x41E0
			LUI t2, 0x4100
			LUI t3, 0xC140
			LUI t4, 0xC200
		@@branch_mirror_mode_positions_bowsers_castle:
		//Positions for DKs Jungle Parkway
		LI v0, 0x12
		BNE v1, v0, @@branch_mirror_mode_positions_dks_jungle_parkway
			NOP
			LUI t1, 0x41D8
			LUI t2, 0x40E0
			LUI t3, 0xC150
			LUI t4, 0xC204
		@@branch_mirror_mode_positions_dks_jungle_parkway:
		//Positions for Yoshi Valley
		LI v0, 0x04
		BNE v1, v0, @@branch_mirror_mode_positions_yoshi_valley
			NOP
			LUI t1, 0x4204
			LUI t2, 0x4150
			LUI t3, 0xC0E0
			LUI t4, 0xC1D8
		@@branch_mirror_mode_positions_yoshi_valley:
		//Positions for Banshee Boardwalk
		LI v0, 0x03
		BNE v1, v0, @@branch_mirror_mode_positions_banshee_boardwalk
			NOP
			LUI t1, 0x41C8
			LUI t2, 0x40A0
			LUI t3, 0xC170
			LUI t4, 0xC20C
		@@branch_mirror_mode_positions_banshee_boardwalk:
		//Positions for Rainbow Road
		LI v0, 0x0D
		BNE v1, v0, @@branch_mirror_mode_positions_rainbow_road
			NOP
			LUI t1, 0x41C0
			LUI t2, 0x4080
			LUI t3, 0xC180
			LUI t4, 0xC210
		@@branch_mirror_mode_positions_rainbow_road:
	@@branch_extra_mode_is_on:

	//General code for setting positions
	LUI v0, 0x800F
	Lui v1, 0x8010
	//x
	SW t1, 0x69A4 (v0) //P1 x
	SW t2, 0x777C (v0) //P2 x
	SW t3, 0x8554 (v1) //P3 x
	SW t4, 0x932C (v1) //P4 x
	//y
	SW a2, 0x69A8 (v0) //P1 y
	SW a2, 0x7780 (v0) //P2 y
	SW a2, 0x8558 (v1) //P3 y
	SW a2, 0x9330 (v1) //P4 y
	//z
	SW a3, 0x69AC (v0) //P1 z
	SW a3, 0x7784 (v0) //P2 z
	SW a3, 0x855C (v1) //P3 z
	SW a3, 0x9334 (v1) //P4 z
	//Set rotation angle
	LI a0, 0x8000
	SH a0, 0x69BE (v0) //P1 rotation
	SH a0, 0x7796 (v0) //P2 rotation
	SH a0, 0x856E (v1) //P3 rotation
	SH a0, 0x9346 (v1) //P4 rotation

	//Set top speed for 50, 100, and 140 CC since the battle mode top speed is a snail's pace
	LBU a1, 0x800DC54B //Load current CCs
	BNE a1, zero, @@branch_50cc //If 50 CC, set top speed to 43910000 - 290
		NOP
		LI a2, 0x4391
	@@branch_50cc:
	LI a3, 1
	BNE a1, a3, @@branch_100cc //If 100 CC, set top speed to 439B0000 - 310
		NOP
		LI a2, 0x439B
	@@branch_100cc:
	LI a3, 2
	BNE a1, a3, @@branch_150cc //If 150 CC, set top speed to 43A00000 - 320
		NOP
		LI a2, 0x43A0
	@@branch_150cc:
	LI a3, 3
	BNE a1, a3, @@branch_extra //If extra mode, top speed is same as 100 CC, so set top speed to 439B0000 - 310
		NOP
		LI a2, 0x439B
	@@branch_extra:
	LUI a0, 0x800F //Update top speeds for four players
	SH a2, 0x6BA4 (a0)
	SH a2, 0x797C (a0)
	LUI a0, 0x8010
	SH a2, 0x8754 (a0)
	SH a2, 0x952C (a0)

	//Disable Lakitu reverse
	SW zero, 0x8007AA10

	@@branch_starting_positions_end:
	//Run the lines that were after the hook to jump back (This copies the JR overwritten for the hook)
	.word 0x03E00008
	.word 0x27BD0060


//Set big donut to be higher when flat courses are on so we are above the water level in order to avoid the terrible camera issues
raiseBigDonut:
	LBU a0, status_options_flatcourses
	BEQ a0, zero, @@branch_check_if_flat_courses_on
		LBU a0, 0x800DC5A1 //Check if course is Big donut, Grab current course from 0x800DC5A0
		LI a3, 0x13
		BNE a0, a3, @@branch_check_if_flat_courses_on
			NOP
			ADDI t3, t3, 0x80 //Set course height to be higher to get it above the water level
	@@branch_check_if_flat_courses_on:
	J 0x802A8740
	NOP






//Write a bit of custom code to ensure the item function rerolls if an item is zeroed out (ie. turned off)
itemReroll:
	//If all items are off, get ready for a suprise!
	li v0, 0
	lbu a1, status_item_banana
	add v0, v0, a1
	lbu a1, status_item_bananabunch
	add v0, v0, a1
	lbu a1, status_item_greenshell
	add v0, v0, a1
	lbu a1, status_item_threegreenshells
	add v0, v0, a1
	lbu a1, status_item_redshell
	add v0, v0, a1
	lbu a1, status_item_fakeitembox
	add v0, v0, a1
	lbu a1, status_item_star
	add v0, v0, a1
	lbu a1, status_item_ghost
	add v0, v0, a1
	bne v0, zero, @@branch_muahaha
		nop
		li v1, 8 //give this item muahahahah >:)
		J 0x8007AF2C //Jump back
	@@branch_muahaha:
	//If single banana is rolled and this item is disabled, reroll
	li v0, 1
	bne v0, v1, @@branch_banana_rolled
		lbu a1, status_item_banana
		bne a1, zero, @@branch_banana_status_disabled
			nop
			j 0x8007ADB8 //Reroll items
		@@branch_banana_status_disabled:
	@@branch_banana_rolled:
	//If banana bunch is rolled and this item is disabled, reroll
	li v0, 2
	bne v0, v1, @@branch_bananabunch_rolled
		lbu a1, status_item_bananabunch
		bne a1, zero, @@branch_bananabunch_status_disabled
			nop
			j 0x8007ADB8 //Reroll items
		@@branch_bananabunch_status_disabled:
	@@branch_bananabunch_rolled:
	//If green shell is rolled and this item is disabled, reroll
	li v0, 3
	bne v0, v1, @@branch_greenshell_rolled
		lbu a1, status_item_greenshell
		bne a1, zero, @@branch_greenshell_status_disabled
			nop
			j 0x8007ADB8 //Reroll items
		@@branch_greenshell_status_disabled:
	@@branch_greenshell_rolled:
	//If 3 green shells is rolled and this item is disabled, reroll
	li v0, 4
	bne v0, v1, @@branch_threegreenshells_rolled
		lbu a1, status_item_threegreenshells
		bne a1, zero, @@branch_threegreenshells_status_disabled
			nop
			j 0x8007ADB8 //Reroll items
		@@branch_threegreenshells_status_disabled:
	@@branch_threegreenshells_rolled:
	//If a red shell is rolled and this item is disabled, reroll
	li v0, 5
	bne v0, v1, @@branch_redshell_rolled
		lbu a1, status_item_redshell
		bne a1, zero, @@branch_redshell_status_disabled
			nop
			j 0x8007ADB8 //Reroll items
		@@branch_redshell_status_disabled:
	@@branch_redshell_rolled:
	//If a fake item box is rolled and this item is disabled, reroll
	li v0, 9
	bne v0, v1, @@branch_fakeitembox_rolled
		lbu a1, status_item_fakeitembox
		bne a1, zero, @@branch_fakeitembox_status_disabled
			nop
			j 0x8007ADB8 //Reroll items
		@@branch_fakeitembox_status_disabled:
	@@branch_fakeitembox_rolled:
	//If a star is rolled and this item is disabled, reroll
	li v0, 10
	bne v0, v1, @@branch_star_rolled
		lbu a1, status_item_star
		bne a1, zero, @@branch_star_status_disabled
			nop
			j 0x8007ADB8 //Reroll items
		@@branch_star_status_disabled:
	@@branch_star_rolled:
	//If a ghost is rolled and this item is disabled, reroll
	li v0, 11
	bne v0, v1, @@branch_ghost_rolled
		lbu a1, status_item_ghost
		bne a1, zero, @@branch_ghost_status_disabled
			nop
			j 0x8007ADB8 //Reroll items
			nop
		@@branch_ghost_status_disabled:
	@@branch_ghost_rolled:
	//otherwise resume code
	j 0x8007AF2C
	nop



//This function decrements a timer (e.g. time score timer or hot potato battle countdown) based on the game tempo
//a3 is both the input and output ofr the timer to decrement
decrementTimer:
	LW a1, 0x80150114 //Load game tempo to subtract from timer, this is the default
	LBU a0, status_options_tempo //Load game tempo menu option	
	BEQ a0, zero, @@branch_game_tempo_option_on //If game tempo is set on in the menu, use that tempo instead
		LI a2, 5
		SUB a1, a2, a0
		@@branch_game_tempo_option_on:
	SUB a3, a3, a1 //Subtract game tempo
	JR ra
	NOP

//Given a player, return a random other player who is still alive
//Inputs
//a0 = current player (1,2,3,4) (who not to return)
//returns
//v0 = random other player who is still alive (1,2,3, or 4)
getEnemy:
	ADDI sp, sp, -0x50
	SW a0, 0x0020 (sp)
	SW a1, 0x0024 (sp)
	SW a2, 0x002C (sp)
	SW a3, 0x0030 (sp)
	SW ra, 0x0034 (sp)
	//SW t1, 0x0038 (sp)
	SW t2, 0x003C (sp)
	// SW t3, 0x0040 (sp)
	// SW t4, 0x0044 (sp)


	@@branch_rerun_rng:
	JAL FUNCTION_RNG //Run RNG and return "enemy" in v0
	LI a0, 4
	LI a1, 0x800F6990 //Check if selected player is alive
	LI a2, 0xDD8
	MULT v0, a2
	MFLO a2
	ADDU a1, a1, a2
	LBU a1, 0x0000 (a1)
	LI a0, 0xC0
	BNE a1, a0, @@branch_rerun_rng //Check if RNG returned a player who is dead, if so, reroll
	ADDI a1, v0, 1
	LW a0, 0x0020 (sp)
	BEQ v0, a0, @@branch_rerun_rng //Check if RNG returned current player, if it is, reroll
	NOP
	LBU a0, score_mode //If game is in team scoring mode, ensure
	LI a1, 2
	BEQ a0, a1, @@branch_team_scoring_mode
	LI a1, 3
	BEQ a0, a1, @@branch_team_scoring_mode
	NOP
	BEQ zero, zero, @@skip_team_scoring_mode
		@@branch_team_scoring_mode:
		LW a0, 0x20 (sp) //Grab current player
		slti a1, a0, 2 //True if on team 1, false if on team 2
		slti a2, v0, 2 //True if rival is on team 1, flase if on team two
		BEQ a1, a2, @@branch_rerun_rng //If current player and chosen rival on the same team, reroll
		NOP
	@@skip_team_scoring_mode:

	//LI v0, 0//Force target to be player 1 for the moment
	
	//@@branch_skip:

	LW a0, 0x0020 (sp)
	LW a1, 0x0024 (sp)
	LW a2, 0x002C (sp)
	LW a3, 0x0030 (sp)
	LW ra, 0x0034 (sp)
	//LW t1, 0x0038 (sp)
	LW t2, 0x003C (sp)
	// LW t3, 0x0040 (sp)
	// LW t4, 0x0044 (sp)
	JR ra
	ADDI sp, sp, 0x50


//Given two players, this function returns the angle between them
//Inputs
//a0 = first player (1,2,3,4)
//a1 = player to compare to (1,2,3,4)
//returns
//v0 = angle
getAngle:
	ADDI sp, sp, -0x40
	SW ra, 0x0028 (sp)
	SW a0, 0x002C (sp)
	SW a1, 0x0030 (sp)
	SW a2, 0x0034 (sp)
	SW a3, 0x0038 (sp)
	//ADDI a0, a0, -1 //Subtract 1 from player numbers so that 0 counts as player 1
	//ADDI a1, a1, -1
	LI a2, 0xDD8 //Multiply by 0xDD8 so that a0 and a1 become the offsets between the first and second players to compare
	MULT a0, a2
	MFLO a0
	MULT a1, a2 
	MFLO a1
	LI a2, 0x800F69A4 //Set a0 and a1 to be pointers for the positions of the first and second players
	ADDU a0, a2, a0 //Pointer to first player's x coordinate (z is found automatically)
	JAL FUNCTION_FIND_ANGLE //Call built in arctan2 function
	ADDU a1, a2, a1 //Pointer to second player's x coordinate (z is found automatically)
	SUB v0, zero, v0 //Mirror angle
	ADDI v0, v0, 0x8000 //Phase by 180 degrees so that angle points inward instead of outward
	LW ra, 0x0028 (sp)
	LW a0, 0x002C (sp)
	LW a1, 0x0030 (sp)
	LW a2, 0x0034 (sp)
	LW a3, 0x0038 (sp)
	JR ra //Jump back
	ADDI sp, sp, 0x40



//Function processes running the battle bot for a single player
//A0 = Current player (0=P1, 1=P2, 2=P3, 3=P4)
runBot:
	ADDI sp, sp, -0x50 //store registers
	SW a0, 0x0020 (sp) //store current player in stack
	SW a1, 0x0024 (sp)
	SW a2, 0x0028 (sp)
	SW a3, 0x002C (sp)
	SW ra, 0x0030 (sp)
	SW t0, 0x0034 (sp)
	SW t4, 0x0044 (sp)

	
	//Set pointer for current player battle bot and store state in v0
	LI v0, bot_status_p1
	ADD v0, v0, a0
	SW v0, 0x38 (sp)
	//Set pointer for current bot rival
	LI a1, bot_rival_p1 //Get byte to store rival pointer
	ADD a1, a1, a0
	SW a1, 0x3C (sp) //Store rival pointer
	//Set player structure offset and store in t5
	LI a1, player_state_offset //Load player structure offset
	MULT a1, a0 //multiply current player number by structure offset
	MFLO a0
	SW a0, 0x40 (sp) //Store result in stack


	//Copy coordinates into data structure for teleporting back to land if bot falls off course
	//LW a0, 0x0040 (sp)
	LBU a1, bot_respawn_flag
	BEQ a1, zero, @@branch_no_fall
	  	LUI a1, hi(0x800F6A5A) //If falling over nothingness (pit or off the course)
	  	ADDU a1, a1, a0
	  	LBU a1, lo(0x800F6A5A) (a1) 
		ANDI a1, a1, 0x1
		BEQ a1, zero, @@branch_no_fall
			LI a0, bot_respawn_datastructure //Copy x,y,z coords from data structure
			LI a1, bot_respawn_player_offset
			LBU a2, bot_respawn_index
			LW a3, 0x0020 (sp)
			MULT a1, a3
			MFLO a3
			ADDU a0, a0, a3
			ADDI a2, a2, 0xC
			DIV a2, a1
			MFHI a2
			ADDU a0, a0, a2
			LW t1, 0x0000 (a0)
			LW t2, 0x0004 (a0)
			LW t3, 0x0008 (a0)
			LI a1, 0x800F69A4 //paste coordinates to teleport character back
			LW a0, 0x0040 (sp)
			ADDU a1, a1, a0
			SW t1, 0x0000 (a1)
			SW t2, 0x0004 (a1)
			SW t3, 0x0008 (a1)
			LUI a1, hi(angle_p1) //flip kart angle
			ADDU a1, a1, a0
			LH a2, lo(angle_p1) (a1)
			ADDI a2, a2, 0x8000
			SH a2, lo(angle_p1) (a1)
			// LW a3, 0x0020 (sp)
		// 	LW t2, 0x38 (sp) //Load timer,  //Force turning
		// 	SB zero, 0x4 (t2) //Set timer to zero
		// 	SB zero, 0x8 (t2) //Set current bot state to "going straight", this combined with the timer being zero will force the bot to turn
		// // 	LUI a1, hi(0x800F6A4D)  //If not dash boosting
		// 	ADDU a1, a1, a0
		// 	LBU a1, lo(0x800F6A4D) (a1)
		// 	ANDI a1, a1, 0x10
		// 	BNE a1, zero, @@branch_dash_boosting
		// 		LUI a1, hi(angle_p1) //flip kart angle
		// 		ADDU a1, a1, a0
		// 		LH a2, lo(angle_p1 ) (a1)
		// 		ADDI a2, a2, 0x8000
		// 		SH a2, lo(angle_p1) (a1)
		// 		LI a2, 0x4000  //Moon jump
		// 		LUI a1, hi(0x800F69C8)
		// 		ADDU a1, a1, a0
		// 		SH a2, lo(0x800F69C8) (a1)
		// 		// LI a2, 0x10 //feather jump
		// 		// LUI a1, hi(0x800F699E)
		// 		// ADDU a1, a1, a0
		// 		// SB a2, lo(0x800F699E) (a1)
		// 		// // LI a2, 0x2 //shroom boost to accelerate foward
		// 		// LUI a1, hi(0x800F699E)
		// 		// ADDU a1, a1, a0
		// 		// SB a2, lo(0x800F699E) (a1)
		// 		LI a2, 0x80 //Dash zone activator to accelerate foward
		// 		LUI a1, hi(0x800F699D)
		// 		ADDU a1, a1, a0
		// 		SB a2, lo(0x800F699D) (a1)
		// 		// LI a2, 0x10 //Turn on dash boost
		// 		// LUI a1, hi(0x800F6A4D)
		// 		// ADDU a1, a1, a0
		// 		// SB a2, lo(0x800F6A4D) (a1)

		// 		@@branch_dash_boosting:
		// 	LUI a2, 0x4500 //Accelerate foward
		// 	LUI a1, hi(0x800F6A2C)
		// 	ADDU a1, a1, a0
		// 	SW a2, lo(0x800F6A2C) (a1)
		@@branch_no_fall: //If no longer falling


	//Give bots auto items
	LBU a0, status_item_infgshells //If inf. green shells are off, randomly assign items
	BNE a0, zero, @@branch_skip_bot_auto_items
		LBU a2, 0x802BA290 //Load byte from RNG into a2
		SRA a2, a2, 1 //Divide RNG value by 2 to double the probability of getting an item
		LI a0, player_item_base //Load base for player has an item memory loc.
		LI a1, player_item_offset //#Calculate and add offset for current player
		LW v0, 0x20 (sp)
		MULT a1, v0
		MFLO a1
		ADDU a0, a0, a1 //Store total offset for player for item memory location
		ADDI a1, v0, 0x60 //Value to compare RNG to
		BNE a1, a2, @@branch_skip_bot_auto_items //If RNG value == something
			LBU v1, player_count_2 //IF player count is 3 or 4, add 0x1C0 to their item mem location
			LI a2, 3
			BNE v1, a2, @@branch_add_3or4player_offset
				NOP
				ADDIU a0, a0, 0x1C0
				@@branch_add_3or4player_offset:
			LBU a1, 0x0000 (a0)
			BNE a1, zero, @@branch_skip_bot_auto_items //Check if player already has item, if not...
				LI v0, 1
				SB v0, 0x0000 (a0) //Randomly give player item
		@@branch_skip_bot_auto_items:

	//Check if player runs into a wall, if so, initiate turning
	LI a0, player_collision_base //Load mem location of player 1 speed
	LW t5, 0x40 (sp)
	ADDU a0, a0, t5 //Add offset to player 1 speed mem location
	LBU a0, 0x0000 (a0) //Load byte that stores if wall collision is occuring or not
	ANDI a0, a0, 0x8 //Check byte 0x8 to see if wall collision is occuring or not
	BEQ a0, zero, @@branch_hitting_a_wall
	// LW t2, 0x38 (sp) //Load timer
	// 	SB zero, 0x4 (t2) //Set timer to zero
	// 	SB zero, 0x8 (t2) //Set current bot state to "going straight", this combined with the timer being zero will force the bot to turn
		NOP
		JAL FUNCTION_RNG //#Iniate steering, call the RNG for a value between 1 and 2 and store in the player state
		LI a0, 2
		ADDI v0, v0, 1 //add 1 to the result from the RNG
		LW t2, 0x38 (sp)
		SB v0, 0x8 (t2) //Store player steering state back to ram
		JAL FUNCTION_RNG //Call RandomInt funciton to grab a new number for the timer
		LI a0, 0x18
		ADDI v0, v0, 0x10 //add constant to result from RNG
		// LI a0, 0x12
		// ADDI v0, v0, 0x9 //add constant to result from RNG			
		LW t2, 0x38 (sp)
		SB v0, 0x4 (t2) //Store player timer back to ram (this is in delay slot)
		@@branch_hitting_a_wall:

	//Decrement player's counter by game tempo then if timer < 0, turn or go straight
	LW t2, 0x38 (sp)
	JAL decrementTimer
	LBU a3, 0x4 (t2) //Load current bot's 1 byte timer
	SB a3, 0x4 (t2) //Store decremented timer back to RAM
	//If current timer < 0
	SLT a1, a3, zero
	BEQ a1, zero, @@branch_timer_run_out
		NOP
		JAL getEnemy //Randomly find a rival
		LW a0, 0x20 (sp)
		LW a1, 0x3C (sp)
		//LI a1, bot_rival_p1 //Get byte to store rival
		//ADD a1, a1, a0
		SB v0, 0x0000 (a1) //Store rival
		// //If speed is low (e.g. stuck on a wall), set flag to going straight to force turning
		// LI a0, player_speed_base //Load mem location of player 1 speed
		// LI a1, player_state_offset //Load player structure offset
		// LW a2, 0x0020 (sp) //Load current player
		// MULT a1, a2 //multiply current player number by structure offset
		// MFLO a1
		// ADDU a0, a0, a1 //Add offset to player 1 speed mem location
		// LH a0, 0x0000 (a0) //Load top half of current player's speed
		// SLTI a0, a0, 0x43Z0 //If current player speed is < minimum speed
		// BNE a0, zero, @@branch_stuck_on_wall
		//and if current moving straight, initiate turning
		// LBU a0, bot_ai_type
		// LI a1, 1
		// BEQ a0, a1, @@branch_turning //If bot AI set to "seeker", ignore turning and immediately continue going "straight"
		//LI v0, 0 //Set default for timer to zero
		LBU a0, 0x8 (t2) //Load current turning state of player into a0
		BNE a0, zero, @@branch_turning //If player is currently traveling straight
			LBU a0, bot_ai_type
			LI a1, 1
			BEQ a0, a1, @@branch_turning //If bot AI set to "seeker", ignore turning and immediately continue going "straight"
				NOP
				JAL FUNCTION_RNG //#Iniate steering, call the RNG for a value between 1 and 2 and store in the player state
				LI a0, 2
				ADDI v0, v0, 1 //add 1 to the result from the RNG
				LW t2, 0x38 (sp)
				SB v0, 0x8 (t2) //Store player steering state back to ram
				@@branch_seeker:
			JAL FUNCTION_RNG //Call RandomInt funciton to grab a new number for the timer
			LI a0, 0x18
			ADDI v0, v0, 0x10 //add constant to result from RNG
			// LI a0, 0x12
			// ADDI v0, v0, 0x9 //add constant to result from RNG			
			LW t2, 0x38 (sp)
			BEQ zero, zero, @@branch_timer_run_out
			SB v0, 0x4 (t2) //Store player timer back to ram (this is in delay slot)
			@@branch_turning:

		//Else if currently turning, initiate moving straight
		SB zero, 0x8 (t2)
		JAL FUNCTION_RNG //Call RNG to grab new time for going straight
		LI a0, 0x90
		ADDI v0, v0, 0x70 //add a constant to the result from the RNG
		//LI a0, 0x68
		//ADDI v0, v0, 0x40 //add a constant to the result from the RNG
		//LI a0, 0x60
		//ADDI v0, v0, 0x60 //add a constant to the result from the RNG
		LW t2, 0x38 (sp)
		SB v0, 0x4 (t2) //store payer timer back to ram




		@@branch_timer_run_out:

	//Bot controller input
	LI a2, bot_controller_input_p1
	//LI a0, 4 //Offset per player in controller input
	LW v0, 0x20 (sp)
	//MULT a0, v0 //Multiply current player by offset per player
	//MFLO a0
	SLL v0, v0, 2 //Multiply by for for current player by offset per player
	ADD a2, a2, v0 //Store total offset for player for controller input
	//SW a2, 0x38 (sp)

	//Go foward by alwasy pressing A
	//LI a0, 0x80
	//SB a0, 0x0 (a2)
	
	//Go foward, steer left, or steer right depending on the current player state
	LBU a0, 0x8 (t2) //Load state of current player into a0
	//Go straight if state = 0
	BNE a0, zero, @@branch_go_straight
		LI a3, 0x10 //Default turning to go straight at a slight angle to trigger collision detection
		//SB t0, 0x0 (a2)
		//SB zero, 0x2 (a2)
		LBU a0, bot_ai_type //If bot AI type is not random, turn towards rival, else go straight
		LI t0, 2
		BEQ a0, t0, @@branch_go_straight
			LW a1, 0x20 (sp) //Get current bot
			//LI a0, bot_rival_p1 //Grab address for current bot rival
			//ADD a0, a0, a1 
			LW a0, 0x3C (sp)
			JAL getAngle //Find angle between current player and rival
			LBU a0, 0x0000 (a0) //Get rival

			LI t0, 0x800F69BE//Find current player's turn angle
			//LI t1, 0xDD8
			//MULT t1, a1
			//MFLO t1
			//ADDU t0, t0, t1
			LW t5, 0x40 (sp)
			ADDU t0, t0, t5
			LHU t8, 0x0000 (t0) //Grab current player's turn angle and store in t8


			SUB t2, v0, t8 //claculate difference in angle between bot and rival
			SRA t2, t2, 8 //convert half to a byte
			LI t0, 0x100 //Take the modulous so range in angle only 0->255
			DIVU t2, t0
			MFHI t2

			SLTIU a1, t2, 0x80
			// BEQ a1, zero, @@branch_bot_turn_towards_rival_1 //turn one direction towards rival
			// 	NOP
			// 	LI a3, 0x34
			// 	@@branch_bot_turn_towards_rival_1:
			// SLTIU a1, t2, 0xA0
			BNE a1, zero, @@branch_bot_turn_towards_rival_2 //turn other direction towards rival
			LI a3, 0x34  //turn one direction towards rival
				LI a3, -0x34
				@@branch_bot_turn_towards_rival_2:

		@@branch_go_straight:

	LW t2, 0x38 (sp)
	LBU a0, 0x8 (t2) //Load state of current player into a0
	LBU a1, 0x4 (t2) //Load current timer for current player into a1
	LI t0, 0x80 //Press gas (normally when moving straight)

	LBU t3, bot_use_items
	BEQ t3, zero, @@branch_press_z //If bots use items toggle is on
		SLTI t3, a1, 0x38
		SLTI a1, a1, 0x10
		XOR a1, a1, t3
		BEQ a1, zero, @@branch_press_z //Have the bot hold Z if the timer is > 0x30
			NOP
			ADDI t0, t0, 0x20 //Press z
		@@branch_press_z:
	// and Z to hold weapon (normally when moving straight)
	//Go left if state is = 1
	LI a1, 1
	BNE a0, a1, @@branch_turn_left
		NOP
		LI t0, 0xC0 //press gas and breaks (A+B) when turning
		LI a3, 0x50
		@@branch_turn_left:
	//Go right if state is = 2
	LI a1, 2
	BNE a0, a1, @@branch_turn_right
		NOP
		LI t0, 0xC0 //press gas and breaks (A+B) when turning
		LI a3, 0xB0
		@@branch_turn_right:
	SB t0, 0x0 (a2) //Store bot's button presses (A, B, and/or Z)
	SB a3, 0x2 (a2) //Store bots steering
	// //Randomly press Z to fire items
	// JAL FUNCTION_RNG //Call RNG to grab new time for going straight
	// LI a0, 0x100
	// BNE v0, zero, @@branch_press_z
	// 	LI a1, 0x20
	// 	SB a1, 0x0 (a2)
	// 	@@branch_press_z


	LW a0, 0x0020 (sp)
	LW a1, 0x0024 (sp)
	LW a2, 0x0028 (sp)
	LW a3, 0x002C (sp)
	LW ra, 0x0030 (sp)
	LW t0, 0x0034 (sp)
	LW t4, 0x0044 (sp)

	JR ra
	ADDI sp, sp, 0x50 //store registers


//This function kills a player
//A0 = player to kill
killPlayer:
	LI a1, balloon_count_p1 //Set balloons to -1 to kill player
	ADDU a1, a1, a0
	ADDU a1, a1, a0
	LHU t5, 0x0000 (a1)
	LI a2, -1
	BEQ a2, t5, @@branch_kill_player //If player is not yet dead
		NOP
		SH a2, 0x0000 (a1) //kill player
		LI a2, player_state_offset //Calculate offset between player structures
		MULT a0, a2
		MFLO t5
		LI a1, 0x800F699C
		ADDU a1, a1, t5
		LI a2, 0x04 //Turn player into a bomb/invisible
		SB a2, 0x0000 (a1) //Store initially at 800F699C for P1
		ADDIU a1, a1, 1
		LI a2, 0x40 //Explode the player
		SB a2, 0x0000 (a1) //Store initially at 800F699D for P1	
		@@branch_kill_player:
	JR RA
	NOP



//This function checks if a player's HP is set to some value (normally zero) and if it is, kills said player
//A0 = player to decrement HP for, P1 = 0, P2 = 1, P3 =2, P4 = 4
//A3 = the value to check againt whichi sthe lowest number of hits
checkIfNotLowestHits:
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)
	LI a1, p1_score //Load current player's hit score
	SLL a2, a0, 1 //Multiply a0 by 2
	ADDU a1, a1, a2
	LHU a2, 0x0000 (a1)
	BEQ a2, a3, @@branch_kill_player //kill player if their hit score is not the lowest
		NOP
		JAL killPlayer
		NOP
		@@branch_kill_player:
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30


//This function handles what happens when the timer reaches zero in time scoring mode
timerReachesZero:
	//Display "SUDDEN DEATH" on screen
	LI a2, text_sudden_death //text pointer
	LI a0, 0x3C //x position
	JAL FUNCTION_DISPLAY_TEXT
	LI a1, 0x60 //y position
	LBU a0, score_mode
	LI a1, 1
	BEQ a0, a1, @@branch_not_teams //If score mode is not teams, run code for handling individual players
	LI a1, 3
	BEQ a0, a1, @@branch_is_teams //If score mode is not teams, run code for handling individual players
	@@branch_not_teams: //Code to run if in regular (non team) time scoring mode
		//Loop to find player(s) lowest number of hits and kill them if they have a higher number of hits
		LBU v0, player_count //Max iterations of loop
		LI v1, 0 //Initialize loop at 0 for player 1
		LI t1, p1_score //pointer for player score
		LI a3, 0x7FFF //Load an implausably large score to start off for comparisons and store the lowest found score here
		@@branch_do_while: //do
			LHU t2, 0x0000 (t1) //Load current player's score
			SLT t4, a3, t2 //If current player's hit score is less than all previous scores
			BNE t4, zero, @@branch_hits_less_than_prev_player
			ADDI v1, v1, 1 //v1++ to increment current player
				ADD a3, t2, zero //Set lowest hit score to current player's score
				@@branch_hits_less_than_prev_player:
			BNE v1, v0, @@branch_do_while //while current player < player_count 
			ADDI t1, t1, 2 //t1 += 2 to increment score pointer
		//Kill all playes who do not have the lowest score
		JAL checkIfNotLowestHits //P1
		LI a0, 0
		JAL checkIfNotLowestHits //P2
		LI a0, 1
		JAL checkIfNotLowestHits //P3
		LI a0, 2
		JAL checkIfNotLowestHits //P4
		LI a0, 3
		BEQ zero, zero, @@branch_finished
	@@branch_is_teams: //Code to run if in team time scoring mode
		LHU t0, team_1_score
		LHU	t1, team_2_score
		BEQ t0, t1, @@branch_finished //If team 1 and 2 scores are equal, it will be sudden death so skip the rest of this code
			NOP
			JAL killPlayer //Always kill player 2
			LI a0, 1
			JAL killPlayer //Always kill player 4
			LI a0, 3
			SLT v0, t0, t1 //If team 1's score < team 2's score
			BEQ v0, zero, @@branch_team_2_won //Team 2 won
				NOP
				JAL killPlayer //Kill player 1 (player 3 will still be alive to score the win)
				LI a0, 0
				@@branch_team_2_won:
			BNE v0, zero, @@branch_team_1_won //Team 1 won
				NOP
				JAL killPlayer //Kill player 3 (player 1 will still be alive to score the win)
				LI a0, 2
				@@branch_team_1_won:
	@@branch_finished:
	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30


//This function displays the timer when in time scoring
processTimeScoring:
	//Check if score mode is time, if not just jump back
	LBU a1, score_mode
	LI a3, 1
	BEQ a1, a3, @@branch_run_time_scoring //If game mode is time, don't just jump back
	LI a3, 3
	BEQ a1, a3, @@branch_run_time_scoring //If game mode is team time, don't just jump back
		NOP
		JR ra //Jump back if score mode is stock or team points
		NOP
		@@branch_run_time_scoring:
	//Store Registers
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)
	//Load timer and store it in the stack
	LW a3, timer
	SW a3, 0x24 (sp)
	//When the timer runs out, run function to kill all players but the one with the lowest number of hits
	SLTI a0, a3, 1 //If timer <= 0
	BEQ a0, zero, @@branch_timer_less_than_zero
		NOP
		J timerReachesZero
		NOP
		@@branch_timer_less_than_zero:
	//Run the timer code
	JAL decrementTimer //Function to decrement timer
	NOP
	SW a3, timer //Store decremented timer
	LI a1, 3600 //Divide timer by 3600 to get minutes
	DIV a3, a1
	MFLO a3 //Grab timer minutes
	SW a3, 0x24 (sp) //store minutes in the stack
	MFHI a3 //Get the modulus (e.g. remainder) of when the timer was divided by minutes above for later use in calculating seconds
	LI a1, 60 //Divide the remainder by 60 to convert it to seconds
	DIV a3, a1
	MFLO a3
	SW a3, 0x28 (sp) //Store seconds to the stack
	//Display the text "TIMER" and minutes
	LW a3, 0x24 (sp) //Load timer minutes from the stack
	LI a0, 0x50 //x position
	LI a2, text_time //text pointer
	JAL FUNCTION_DISPLAY_TEXT_AND_INT
	LI a1, 0x60 //y position

	// //Display semicolon and extra zero in seconds if needed
	LW a3, 0x24 (sp) //Load timer minutes from stack
	SLTI t1, a3, 10
	BNE t1, zero, @@branch_timer_gt_10_min //If minutes > 10, move colon over a bit
	LI a0, 0xB0 //Default x position
		ADDI a0, a0, 8 //Moved x position over slightly
		@@branch_timer_gt_10_min:
	LI a2, text_semicolon //Text pointer for semicolon
	LW a3, 0x28 (sp) //Load seconds from stack
	SLTI t1, a3, 10
	BEQ t1, zero, @@branch_timer_lt_10_sec //If seconds < 10
		NOP
		LI a2, text_semicolon_plus_zero //Set text pointer to semicolon plus a zero
		@@branch_timer_lt_10_sec:
	JAL FUNCTION_DISPLAY_TEXT 
	LI a1, 0x60 //y position
	//Display timer seconds
	LW a3, 0x28 (sp) //Load seconds from stack
	SLTI t1, a3, 10
	BEQ t1, zero, @@branch_timer_sec_gt_10 //If seconds > 10, move x position to the right a little
	LI a0, 0xB0 //x pos (default)
		ADDI a0, a0, 0x8 //Additional rightward movement if seconds >10
		@@branch_timer_sec_gt_10:
	LW t0, 0x24 (sp) //Load minutes from stack
	SLTI t0, t0, 10
	BNE t0, zero, @@branch_timer_min_gt_10 //If minutes > 10, move seconds over a bit
	LUI a2, hi(text_null) //A text pionter to nothing
		ADDI a0, a0, 0x8
		@@branch_timer_min_gt_10:
	ADDIU a2, a2, lo(text_null)
	JAL FUNCTION_DISPLAY_TEXT_AND_INT
	LI a1, 0x60 //y position
	//Play final song music if timer is running out
	LW a3, timer //Load timer
	LBU a1, final_lap_music_flag //Load flag for if "final song" has played or not
	BNE a1, zero, @@branch_final_lap_song //if the final flag song has not been played yet
	SLTI t1, a3, 0xF0 //#and if seconds < 5
		BEQ t1, zero, @@branch_final_lap_song
			LI a0, 1
			SB a0, final_lap_music_flag //Set flag to the final lap song has playe
			JAL FUNCTION_PLAY_MUSIC
			LI a0, 0xC //Set music to be "final lap"
		@@branch_final_lap_song:
	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30


//Display the final results (hits or HP) on the results screen after each battle
displayResults:
	//Store registers
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)
	//Initialize font
	JaL FUNCTION_LOAD_FONT
	NOP
	//Load text pointer "HP" or "HIT" and store in stack
	LBU v0, score_mode
	LI a2, text_hp //Text pointer for "HP" (default)
	BEQ v0, zero, @@branch_score_mode_is_timer //If score mode is timer
		NOP
		LI a2, text_hit ///Text pointer for "HIT"
		@@branch_score_mode_is_timer:
	BNE v0, zero, @@branch_check_to_display_hp //If traditional battle and max hp <= 3, do not display anything
		LBU a0, game_mode
		LHU a1, max_hp
		SLTI a1, a1, 4 //If max HP > 3
		//AND a0, a0, zero //If game mode is traditional
		XOR a0, a1, a0
		BEQ a0, zero, @@branch_check_to_display_hp
			NOP
			BEQ zero, zero, @@branch_skip_disp_results //Just skip displaying the results if that is the case
			NOP
		@@branch_check_to_display_hp:
	SW a2, 0x24 (sp)
	//Load number of players and store in stack
	LBU a3, player_count
	SW a3, 0x28 (sp)
	//Display results for 2P mode
	LI a0, 2
	BNE a3, a0, @@branch_show_results_2p
		LI a0, 0x40 //x position
		LI a1, 0x12 //y position
		LHU a3, p1_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P1
		LW a2, 0x24 (sp) //Load text pointer
		LI a0, 0xA0 //x position
		LI a1, 0x12 //y position
		LHU a3, p2_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P2
		LW a2, 0x24 (sp) //Load text pointer
		@@branch_show_results_2p:
	//Display results for 3P mode
	LI a0, 3
	BNE a3, a0, @@branch_show_results_3p
		LI a0, 0x22 //x position
		LI a1, 0x12 //y position
		LHU a3, p1_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P1
		LW a2, 0x24 (sp) //Load text pointer
		LI a0, 0x70 //x position
		LI a1, 0x12 //y position
		LHU a3, p2_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P2
		LW a2, 0x24 (sp) //Load text pointer
		LI a0, 0xBE //x position
		LI a1, 0x12 //y position
		LHU a3, p3_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P3
		LW a2, 0x24 (sp) //Load text pointer
		@@branch_show_results_3p:
	//Display results for 4P mode
	LI a0, 4
	BNE a3, a0, @@branch_show_results_4p
		LI a0, 0x8 //x position
		LI a1, 0x12 //y position
		LHU a3, p1_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P1
		LW a2, 0x24 (sp) //Load text pointer
		LI a0, 0x4D //x position
		LI a1, 0x12 //y position
		LHU a3, p2_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P2
		LW a2, 0x24 (sp) //Load text pointer
		LI a0, 0x92 //x position
		LI a1, 0x12 //y position
		LHU a3, p3_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P3
		LW a2, 0x24 (sp) //Load text pointer
		LI a0, 0xD7 //x position
		LI a1, 0x12 //y position
		LHU a3, p4_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P4
		LW a2, 0x24 (sp) //Load text pointer
		@@branch_show_results_4p:
	@@branch_skip_disp_results:
	//If a team scoring mode is selected, copy wins from 1P to 2P and 3P to 4P
	LBU v0, score_mode
	LI a0, 2
	BEQ v0, a0, @@branch_team_mode //If team points score mode
	LI a0, 3
	BEQ v0, a0, @@branch_team_mode //or If team time score mode
	NOP
	BEQ zero, zero, @@branch_not_team_mode //Else if not a team scoring mode, skip
		@@branch_team_mode:
		LUI a1, 0x8000
		LBU a0, 0x0335 (a1) //In 3P mode, copy P1 results to P2
		SB a0, 0x0336 (a1)
		LBU a0, 0x0338 (a1) //In 4P mode, copy P1 results to P2
		SB a0, 0x0339 (a1)
		LBU a0, 0x033A (a1) //In 4P mode, copy P3 results to P4
		SB a0, 0x033B (a1)
		LW a3, 0x28 (sp)
		LI a0, 3
		BNE a3, a0, @@branch_show_team_results_3p //Display results for 3P mode
			LI a2, text_score //Display score for team 1
			LHU a3, team_1_score
			LI a0, 0x48
			JAL FUNCTION_DISPLAY_TEXT_AND_INT
			LI a1, 0x5C
			LI a2, text_score //Display score for team 2
			LHU a3, team_2_score 
			LI a0, 0xBC
			JAL FUNCTION_DISPLAY_TEXT_AND_INT
			LI a1, 0x5C
			@@branch_show_team_results_3p:
		LI a0, 4
		BNE a3, a0, @@branch_show_team_results_4p ////Display results for 4P mode
			LI a2, text_score //Display score for team 1
			LHU a3, team_1_score
			LI a0, 0x2C
			JAL FUNCTION_DISPLAY_TEXT_AND_INT
			LI a1, 0x5C
			LI a2, text_score //Display score for team 2
			LHU a3, team_2_score 
			LI a0, 0xB6
			JAL FUNCTION_DISPLAY_TEXT_AND_INT
			LI a1, 0x5C
			@@branch_show_team_results_4p:
		
	@@branch_not_team_mode:
	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30
	//


//This function displays HP or "HITS" for some battle modes
displayHP:
	ADDI sp, sp, -0x30//Store registers
	SW ra, 0x20 (sp)
	LBU a3, player_count
	SW a3, 0x24 (sp) //Store player count in stack for easy retrieval
	LBU v0, score_mode
	// AND a0, v0, zero
	// AND a1, v0, a2
	// OR a0, a1, a0
	LI a2, 2
	BEQ v0, a2, @@branch_team_scoring //If scoring mode is stock or time (not team)
	LI a2, 3
	BEQ v0, a2, @@branch_team_scoring //If scoring mode is stock or time (not team)
			LI a2, text_hp //Text pointer for "HP" (default)
			BEQ v0, zero, @@branch_score_mode_is_timer //If score mode is timer
				NOP
				LI a2, text_hit ///Text pointer for "HIT"
				@@branch_score_mode_is_timer:
			SW a2, 0x28 (sp) //Store text pointer in stack for later retrieval
			//Display HP/HIT for P1
			LI a0, 0x0 //x position
			LHU a3, p1_score //Int to display
			JAL FUNCTION_DISPLAY_TEXT_AND_INT
			LI a1, 0x0 //y position
			//Display HP/HIT for P2
			LI a0, 0x0 //x position (default)
			LI a1, 0x72 //y position (default)
			LI a2, 2
			LW a3, 0x24 (sp) //Load player count
			BEQ a3, a2, @@branch_disp_p2_number_of_players_not_2 //If number of players is not 2, move position to upper right
				NOP
				LI a0, 0xE2 //x position
				LI a1, 0x0 //y position
				@@branch_disp_p2_number_of_players_not_2:
			LHU a3, p2_score //Int to display
			JAL FUNCTION_DISPLAY_TEXT_AND_INT
			LW a2, 0x28 (sp) //text pointer
			//Display HP/HIT for P3
			LW a3, 0x24 (sp) //Load player count
			LI a2, 2
			BEQ a3, a2, @@branch_disp_p3_score //If number of players is not 2, display player 3
				LI a0, 0x0 //x position
				LI a1, 0x72 //y position
				LHU a3, p3_score //int to display
				JAL FUNCTION_DISPLAY_TEXT_AND_INT
				LW a2, 0x28 (sp) //text pointer
				@@branch_disp_p3_score:
			//Display HP/HIT for P4
			LW a3, 0x24 (sp) //Load player count
			LI a2, 4
			BNE a3, a2, @@branch_disp_p4_score //If number of players is 4, display P4's score
				LI a0, 0xE2 //x position
				LI a1, 0x72 //y position
				LHU a3, p4_score //int to display
				JAL FUNCTION_DISPLAY_TEXT_AND_INT
				LW a2, 0x28 (sp) //text pointer
				@@branch_disp_p4_score:
			BEQ zero, zero, @@branch_done_displaying_score
		//Else if branch is team scoring
		@@branch_team_scoring:
			LUI a3, hi(p1_score)
			LHU a0, lo(p3_score) (a3) //Calculate team 1 score
			LHU a1, lo(p4_score) (a3)
			ADDU v0, a1, a0 
			LHU a0, lo(p1_score) (a3) //Calculate team 2 score
			LHU a1, lo(P2_score) (a3)
			ADDU v1, a1, a0 
			SH v0, lo(team_1_score) (a3) //Store team scores
			SH v1, lo(team_2_score) (a3)

			LI a0, 0x77 //x position
			LI a2, text_score //text pointer
			JAL FUNCTION_DISPLAY_TEXT
			LI a1, -0xC //y position

			LI a0, 0x7B //x position
			LI a2, text_null //text pointer
			LHU a3, team_1_score
			SLTI v0, a3, 10 //If score is < 10, move it over a bit
			BEQ v0, zero, @@branch_team_1_score_positioning_a
				NOP
				ADDI a0, a0, 0x4
				@@branch_team_1_score_positioning_a:
			SLTI v0, a3, 100 //If score is < 10, move it over a bit
			BNE v0, zero, @@branch_team_1_score_positioning_b
				NOP
				ADDI a0, a0, -0x4
				@@branch_team_1_score_positioning_b:
			JAL FUNCTION_DISPLAY_TEXT_AND_INT
			LI a1, -0x2 //y position

			LI a0, 0x77 //x position
			LI a2, text_score //text pointer
			JAL FUNCTION_DISPLAY_TEXT
			LI a1, 0xC4 //y position

			LI a0, 0x7B //x position
			LI a2, text_null //text pointer
			LHU a3, team_2_score
			SLTI v0, a3, 10 //If score is < 10, move it over a bit
			BEQ v0, zero, @@branch_team_2_score_positioning
				NOP
				ADDI a0, a0, 0x4
				@@branch_team_2_score_positioning:
			SLTI v0, a3, 100 //If score is < 10, move it over a bit
			BNE v0, zero, @@branch_team_2_score_positioning_b
				NOP
				ADDI a0, a0, -0x4
				@@branch_team_2_score_positioning_b:
			JAL FUNCTION_DISPLAY_TEXT_AND_INT
			LI a1, 0xCE //y position			

	@@branch_done_displaying_score:
	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30

//This function checks if a player's HP is set to some value (normally zerozero and if it is, kills said player)
//a0 = player to decrement HP for, P1 = 0, P2 = 1, P3 =2, P4 = 4
checkIfZeroHP:
	//Store registers
	ADDI sp, sp, -0x30 
	SW ra, 0x1C (sp)
	SW a0, 0x20 (sp)
	SW a1, 0x24 (sp)
	SW a2, 0x28 (sp)
	//SW a3, 0x2C (sp)
	//Load current player's HP
	LI a1, p1_score
	SLL a2, a0, 1 //Multiply a0 by 2
	ADDU a1, a1, a2
	LHU a2, 0x0000 (a1)
	//Kill player if their HP = 0
	BNE a2, zero, @@branch_kill_player_if_hp_zero
		NOP
		JAL killPlayer
		NOP
		@@branch_kill_player_if_hp_zero:
	//Load registers and jump back
	LW ra, 0x1C (sp)
	LW a0, 0x20 (sp)
	LW a1, 0x24 (sp)
	LW a2, 0x28 (sp)
	//LW a3, 0x2C (sp)
	JR ra
	ADDI sp, sp, 0x30

//This function checks if a team has reached the number of points to win and handles the win/lose conditions
checkIfTeamWon:
	ADDI sp, sp, -0x30
	SW ra, 0x1C (sp)
	SW a0, 0x20 (sp)
	SW a1, 0x24 (sp)
	SW a2, 0x28 (sp)
	//SW a3, 0x2C (sp)
	LBU a0, score_mode
	LI a1, 2
	BNE a0, a1, @@branch_skip //Only run if score mode is team points
		LHU t0, max_team_points//Load maximum score
		LHU t1, team_1_score //Load team 1's score
		SLT t2, t1, t0
		BNE t2, zero, @@branch_team_1_won  //If team 1's score is >= the max score, team 1 wins so kill everyone except player 1
			NOP
			JAL killPlayer //Kill player 2
			LI a0, 1
			JAL killPlayer //Kill player 3
			LI a0, 2
			JAL killPlayer //Kill player 4
			LI a0, 3
			@@branch_team_1_won:
		LHU t1, team_2_score //Load team 2's score
		SLT t2, t1, t0	
		BNE t2, zero, @@branch_team_2_won  //If team 2's score is >= the max score, team 2 wins so kill everyone except player 3
			NOP
			JAL killPlayer //Kill player 1`
			LI a0, 0
			JAL killPlayer //Kill player 2
			LI a0, 1
			JAL killPlayer //Kill player 4
			LI a0, 3
			@@branch_team_2_won:
		@@branch_skip:

	LW ra, 0x1C (sp)
	LW a0, 0x20 (sp)
	LW a1, 0x24 (sp)
	LW a2, 0x28 (sp)
	//LW a3, 0x2C (sp)
	JR ra
	ADDI sp, sp, 0x30


//This function processes hits and decrements 1 HP
//$A0 = player to decrement HP for, P1 = 0, P2 = 1, P3 =2, P4 = 4
processHit:
	//Store registers
	ADDI sp, sp, -0x30 
	SW a0, 0x20 (sp)
	SW a1, 0x24 (sp)
	SW a2, 0x28 (sp)
	SW a3, 0x2C (sp)
	//If respawn is on, respawn player who was just hit
	LBU v0, status_respawn
	BEQ v0, zero, @@branch_respawn_on //#If respawn is set to on
		LI a1, player_state_offset //Get player state mem address for forcing lakitu to respawn player
		MULT a0, a1
		MFLO a2
		LUI a1, 0x800F
		ADD a1, a1, a2
		LI a3, 1 //Set bits for respawning
		SB a3, 0x6A5B (a1)
		@@branch_respawn_on:
	//Subtract or add 1 HP from player number stored in a0
	LI a1, p1_score
	SLL a0, a0, 1 //Multiply a0 by 2
	ADDU a1, a1, a0
	LHU a2, 0x0000 (a1)
	LBU v0, score_mode
	BNE v0, zero, @@branch_score_is_stock //If scoring is stock
		NOP
		ADDI a2, a2, -1 //Subtract 1 HP
		@@branch_score_is_stock:
	BEQ v0, zero, @@branch_score_is_timer //If scoring is timer
		NOP
		ADDI a2, a2, 1 //Add 1 hit
		@@branch_score_is_timer:
	SH a2, 0x0000 (a1) //Store HP or hits back to ram
	//Load registers and jump back
	LW a0, 0x20 (sp)
	LW a1, 0x24 (sp)
	LW a2, 0x28 (sp)
	LW a3, 0x2C (sp)
	JR ra
	ADDI sp, sp, 0x30



//This function handles hit detection for all battle modes
//Returns player who was hit as the byte who_was_hit_last
hitDetection:
	//Check each player's balloon count, if player has two balloons, set them back to three and make that player the hot potato
	LI a3, 1 //Set counter to 1
	LI a1, 1 //Load 2 balloons into a1 for comparison
	LI a0, 0x8018D8C0 //Load player balloon memory location
	@@branch_hit_detection_do_while_loop: //Do
		LHU a2, 0x0000 (a0)
		BNE a2, a1, @@branch_hit_found //If ballons == 2, run the following code
			LI a2, 2 //Set balloons back to 3
			SH a2, 0x0000 (a0)
			SB a3, who_was_hit_last //Set who was hit/player to be the hot potato 
			@@branch_hit_found:
		ADDIU a0, a0, 2 //Add offset for next player's balloon count mem location
		LI a2, 4
		BNE a3, a2, @@branch_hit_detection_do_while_loop //WHILE $A3 <= 0x4
		ADDIU a3, a3, 1 //a3 = a3 + 1
	JR ra
	NOP

//This function resets the timer when in time scoring
resetTimer:
	LW v1, max_timer //Copy max timer value to timer value
	SW v1, timer
	SB zero, final_lap_music_flag //Reset final lap music flag
	SB zero, final_sudden_death_music_flag //Reset sudden death music flag
	JR ra
	NOP

//This funciton resets HP back to max (or score to zero if game is timed)
resetHP:
	LBU v0, score_mode
	LI a1, 0 //If scoring is timer, reset hits to zero
	BNE v0, zero, @@branch_reset_hp_to_max //If scoring is stock, reset HP back to max'
		NOP
		LHU a1, max_hp
		@@branch_reset_hp_to_max:
	SH a1, p1_score
	SH a1, p2_score
	SH a1, p3_score
	SH a1, p4_score
	JR ra
	NOP

//This function displays and runs the universal countdown
displayCountdown:
	//Store registers
	ADDI sp, sp, -0x30
	SW RA, 0x20 (sp)
	//Display Countdown
	LUI t0, hi(hotpotato_countdown)
	JAL decrementTimer //Function to decrement counter
	LH a3, lo(hotpotato_countdown) (t0)
	SH a3, lo(hotpotato_countdown) (t0)//store decremented counter back to ram
	ADD a3, a3, a1 //Add tempo back before displaying so countdown when paused shows the correct value
	LI a1, 60 //Divide timer by 60 (0x3C) so output display is in secconds
	DIV a3, a1
	MFLO a3 //a3 is the integer to display
	LI a2, text_null //null text pointer
	LBU v1, player_count
	LI t1, 2
	BNE v1, t1, @@branch_number_players_is_2 //If number of players is 2
		LI t0, 1
		LI a0, 0x80 //Set x to middle of screen
		BNE v0, t0, @@branch_p1_is_hot_potato_a //If player 1 is the hot potato
		LI t0, 2
			LI a1, 0x4C //Set y
			@@branch_p1_is_hot_potato_a:
		BNE v0, t0, @@branch_p2_is_hot_potato_a //If player 2 is the hot potato'
			NOP
			LI a1, 0xC0 //Set y
			@@branch_p2_is_hot_potato_a:
		@@branch_number_players_is_2:
	BEQ v1, t1, @@branch_number_players_is_not_2 //If number of players is 2
		LI t0, 1
		BNE v0, t0, @@branch_p1_is_hot_potato_b //If player 1 is the hot potato
		LI t0, 2
			LI a0, 0x34 //set x
			LI a1, 0x4C //set y
			@@branch_p1_is_hot_potato_b:
		BNE v0, t0, @@branch_p2_is_hot_potato_b //If player 2 is the hot potato
		LI t0, 3
			LI a0, 0xCC //set x
			LI a1, 0x4C //set y
			@@branch_p2_is_hot_potato_b:
		BNE v0, t0, @@branch_p3_is_hot_potato_b //If player 3 is the hot potato
		LI t0, 4
			LI a0, 0x34 //set x
			LI a1, 0xC0 //set y
			@@branch_p3_is_hot_potato_b:
		BNE v0, t0, @@branch_p4_is_hot_potato_b //If player 4 is the hot potato
			NOP
			LI a0, 0xCC //set x
			LI a1, 0xC0 //set y
			@@branch_p4_is_hot_potato_b:
		@@branch_number_players_is_not_2:
	JAL FUNCTION_DISPLAY_TEXT_AND_INT //Run function to display 
	NOP
	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30

//This function processes hits and causes the player to be lightning squished
//a0 = player to decrement HP for, P1 = 0, P2 = 1, P3 =2, P4 = 4
processHitShrink:
	//Store registers
	ADDI sp, sp, -0x30
	SW a0, 0x20 (sp)
	SW a1, 0x24 (sp)
	SW a2, 0x28 (sp)
	SW a3, 0x2C (sp)
	//Lightning shrink from player number stored in a0
	LI a1, 0x800F699E
	LI a2, player_state_offset
	MULT a0, a2
	MFLO a2
	ADD a2, a2, a1
	LI a3, 0x40
	SB a3, 0x0000 (a2)
	//Load registers
	LW a0, 0x20 (sp)
	LW a1, 0x24 (sp)
	LW a2, 0x28 (sp)
	LW a3, 0x2C (sp)
	JR ra
	ADDI sp, sp, 0x30


//This function handles everything for squish battle mode
runGameModeSquish:
	//store registers
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)
	//Lengthen lightning shrink time
	LI a1, 0x398 
	SH a1, 0x8008E302 //Store lightning shrink time
	//If game is starting or restarting, reset HP
	LBU a1, status_p1
	LI a2, 0xE0
	BNE a1, a2, @@branch_rest_hp
		NOP
		JAL resetHP
		NOP
		JAL resetTimer
		NOP
		@@branch_rest_hp:
	//Hit detection, HP, and killing player handling
	JAL hitDetection
	NOP
	LBU a0, who_was_hit_last //Load whoever might have been hit
	BEQ a0, zero, @@branch_player_was_hit //If a player was hit
		ADDI a0, a0, -1 //Subtract 1 from a0 to feed into the following functions
		JAL processHitShrink //Shrink player if they are hit
		NOP
		@@branch_player_was_hit:
	//Handle hits (decrement HP) if shurnk player is squished
	LUI t6, 0x800F
	LI t7, 0x08
	LBU a1, 0x6A4C (t6) //P1
	ANDI a2, a1, 0x4
	BEQ a2, zero, @@branch_player1_is_squished //If player is squished
		LI a0, 0
		BEQ zero, zero, @@branch_to_hit_processing
		SB t7, 0x6A4C (t6) //Unflatten player
		@@branch_player1_is_squished:
	LBU a1, 0x7824 (t6) //P2
	ANDI a2, a1, 0x4
	BEQ a2, zero, @@branch_player2_is_squished //If player is squished
		LI a0, 1
		BEQ zero, zero, @@branch_to_hit_processing
		SB t7, 0x7824 (t6) //Unflatten player
		@@branch_player2_is_squished:
	LUI t6, 0x8010
	LBU a1, 0x85FC (t6) //P3
	ANDI a2, a1, 0x4
	BEQ a2, zero, @@branch_player3_is_squished //If player is squished
		LI a0, 2
		BEQ zero, zero, @@branch_to_hit_processing
		SB t7, 0x85FC (t6) //Unflatten player
		@@branch_player3_is_squished:
	LBU a1, 0x93D4 (t6) //P4
	ANDI a2, a1, 0x4
	BEQ a2, zero, @@branch_player4_is_squished //If player is squished
		LI a0, 3
		BEQ zero, zero, @@branch_to_hit_processing
		SB t7, 0x93D4 (t6) //Unflatten player
		@@branch_player4_is_squished:
	BEQ zero, zero, @@branch_over_hit_processing
	NOP
	@@branch_to_hit_processing:
		JAL processHit //Subtract 1 HP from player
		NOP
		LBU a2, score_mode //Check if stock is on (not timed), and if it is on, check if player has HP=0
		BNE a2, zero, @@branch_over_hit_processing
			NOP
			JAL checkIfZeroHP //kill player if their HP = 0
			NOP
	@@branch_over_hit_processing:
	SB zero, who_was_hit_last //Reset who was hit to zero
	//DISPLAY HP and run the time scoring (if it is selected as an option)
	LBU a1, game_paused //Only run counter and display HP and countdown when not paused (game tempo is zero or less)
	LBU a2, in_game
	XOR a1, a2, a1 //Check if game is not paused or in the results screen
	BEQ a1, zero, @@branch_display_hp_and_process_time
		NOP
		JAL FUNCTION_LOAD_FONT
		NOP
		JAL displayHP
		NOP
		JAL processTimeScoring
		NOP
		JAL checkIfTeamWon //If in team points scoring mode, check if a team has won
		NOP
		@@branch_display_hp_and_process_time:
	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30


//This function handles everything for hot potato battle mode
runGameModeHotPotato:
	//Store registers
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)
	//Shorten lightnign shrink time, otherwise use the default above
	LI a1, 0x40 
	SH a1, 0x8008E302 //Store lightning shrink time
	//Check each player's balloon count, if player has two balloons, set them back to three and make that player the hot potato 
	JAL hitDetection
	NOP
	//First turn off smoke for all players so that if a player is no longer the hot potato, the smoke will stop
	LUI a0, 0x800F
	SB zero, 0x6A5A (a0)
	SB zero, 0x7832 (a0)
	LUI a0, 0x8010
	SB zero, 0x860A (a0)
	SB zero, 0x93E2 (a0)
	//Make whoever is hot potato smoke
	LBU a0, who_was_hit_last
	BEQ a0, zero, @@branch_make_hot_potato_smoke //#Run code only if someone actually is the hot potato
		LI a1, player_state_offset //Set offset for player state storing if they smoke
		MULTU a1, a0 //Multiply offset by which player is smoking
		MFLO a1
		LI a0, 0x800F5C82 //Would be 0x800F6A5A but have to subtract offset 0xDD8
		ADDU a0, a0, a1 //a0 = memory address for player state storing if player is smoking
		LI a1, 0x10 //Set player who is hot potato to smoke
		SB a1, 0x0000 (a0)
		@@branch_make_hot_potato_smoke:
	//If timer less than zero, kill whoever is the hot potato and then reset the timer (note this sets the balloons to 0 and turns a person invisible/into a bomb)
	LH a1, hotpotato_countdown
	BGEZ a1, @@branch_hurt_the_hot_potato //If  custom timer is less than zero...
		LBU a0, who_was_hit_last //Load who is the hot potato and store in $a0
		ADDI a0, a0, -1
		LI a2, player_state_offset //Calculate offset between player structures and store offset in $a3
		MULT a0, a2
		MFLO a3
		JAL processHit //Subtract 1 HP from player that is the hot potato
		NOP
		LBU a2, score_mode //Check if stock is on (not timed), and if it is on, check if player has HP=0
		BNE a2, zero, @@branch_kill_the_hot_potato
			NOP
			JAL checkIfZeroHP
			NOP
			@@branch_kill_the_hot_potato:
		LI a1, 0x800F6A4C //Make player who is hot potato lightning strink for a split second to indicate the hit
		ADDU a1, a1, a3
		LI a2, 0x40
		SB a2, 0x0000 (a1)
		SB zero, who_was_hit_last //Set who is hot back to nothing
		LUI a0, hi(hotpotato_countdown_default)
		LH a1, lo(hotpotato_countdown_default) (a0) //Reset timer to default value
		SH a1, lo(hotpotato_countdown) (a0)
		@@branch_hurt_the_hot_potato:
	//If game is starting or restarting, force timer to starting value and ensure nobody is the hot potato
	LBU a1, status_p1
	LI a2, 0xE0
	BNE a1, a2, @@branch_reset_hp_and_timer
		NOP
		JAL resetHP
		NOP
		JAL resetTimer
		NOP
		SB zero, who_was_hit_last //#Set who is the hot potato back to nothing
		@@branch_reset_hp_and_timer:
	//#If nobody is the hot potato, reset hot potato counter to default value
	LBU a1, who_was_hit_last
	BNE a1, zero, @@branch_reset_counter
		LUI a0, hi(hotpotato_countdown_default)
		LH a1, lo(hotpotato_countdown_default) (a0) //Reset timer to default value
		SH a1, lo(hotpotato_countdown) (a0)
		@@branch_reset_counter:
	//Display hp and run time scoring (if it is selected as an option)
	LBU a1, game_paused //Only run counter and display HP and countdown when not paused (game tempo is zero or less)
	LBU a2, in_game
	XOR a1, a2, a1 //Check if game is not paused or in the results screen
	BEQ a1, zero, @@branch_display_hp_and_run_time_scoring
		NOP
		JAL FUNCTION_LOAD_FONT //load font
		NOP
		JAL displayHP //display HP
		NOP
		LBU v0, who_was_hit_last //display countdown
		BEQ v0, zero, @@branch_display_countdown
			NOP
			JAL displayCountdown
			NOP
			@@branch_display_countdown:
		JAL processTimeScoring //Dispaly timer
		NOP
		JAL checkIfTeamWon //If in team points scoring mode, check if a team has won
		NOP
		@@branch_display_hp_and_run_time_scoring:

	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30


//This function handles everything for traditional battle mode
runGameModeTraditionalBattle:
	ADDI sp, sp, -0x30 //store registers
	SW ra, 0x20 (sp)
	//Check if stock is off (not timed), and if it is on, then do a check on if HP < 3
	LBU a2, score_mode
	BNE a2, zero, @@branch_stock_on //If HP <= 3, in stock (not timed), and respawn is off, just return and use the game's built in ballons and skip all the custom HP code
		LBU v1, status_respawn 
		BNE v1, zero, @@branch_stock_on //If respawning is on, do not branch back
			LHU a0, max_hp
			LI a1, 3
			SLT a2, a1, a0
			BNE a2, zero, @@branch_stock_on //If max HP <= 3, just jump back
				LW ra, 0x20 (sp)
				JR ra
				ADDI sp, sp, 0x30
		@@branch_stock_on:
	//If game is starting for restarting, reset HP
	LBU a1, status_p1
	LI a2, 0xE0
	BNE a1, a2, @@branch_rest_hp
		NOP
		JAL resetHP
		NOP
		JAL resetTimer
		NOP
		@@branch_rest_hp:
	//Hit detection, HP, and killing player handling
	JAL hitDetection
	NOP
	LBU a0, who_was_hit_last //Load whoever might have been hit
	BEQ a0, zero, @@branch_player_was_hit
		ADDI a0, a0, -1 //Subtract 1 from $a0 to feed into the following functions
		JAL processHit
		NOP
		LBU a2, score_mode //Check if stock is on (not timed), and if it is on, check if player has HP=0
		BNE a2, zero, @@branch_check_if_zero_hp
			NOP
			JAL checkIfZeroHP //Kill player if their HP = 0
			NOP
			@@branch_check_if_zero_hp:
		SB zero, who_was_hit_last //Reset who was hit to zero
		@@branch_player_was_hit:
	//DISPLAY HP and run the time scoring (if it is selected as an option)
	LBU a1, game_paused //Only run counter and display HP and countdown when not paused (game tempo is zero or less)
	LBU a2, in_game
	XOR a1, a2, a1 //Check if game is not paused or in the results screen
	BEQ a1, zero, @@branch_run_counter_and_display_hp
		NOP
		JAL FUNCTION_LOAD_FONT //Load font
		NOP
		JAL displayHP //Display HP
		NOP
		JAL processTimeScoring //Display timer(if in a time match)
		NOP
		JAL checkIfTeamWon //If in team points scoring mode, check if a team has won
		NOP
		@@branch_run_counter_and_display_hp:
	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30


//Loop that runs in race
inRace:
	addi sp, sp, -0x30 //store registers
	// sw a0, 0x0010 (sp)
	// sw a1, 0x0014 (sp)
	// sw a3, 0x0018 (sp)
	sw ra, 0x001C (sp)

	JAL FUNCTION_LOAD_FONT
	NOP







 //  	LBU a0, 0x800F6A5A //If falling over nothingness (pit or off the course)
	// ANDI a0, a0, 0x1
	// BEQ a0, zero, @@branch_no_fall

		// LBU a0, 0x800F6A4D //If not dash boosting
		// ANDI a0, a0, 0x10
		// BNE a0, zero, @@branch_dash_boosting
		// 	LH a0, angle_p1 //flip kart angle
		// 	ADDI a0, a0, 0x8000
		// 	SH a0, angle_p1
		// 	LI a0, 0x3E00  //Moon jump
		// 	SH a0, 0x800F69C8
		// 	LI a0, 0x80 //Dash zone activator to accelerate foward
		// 	SB a0, 0x800F699D
		// 	// LI a0, 0x10 //Turn on dash boost
		// 	// SB a0, 0x800F6A4D
		// 	// LUI a0, 0x4600 //Accelerate foward
		// 	// SW a0, 0x800F6A2C
		// 	@@branch_dash_boosting:
		// @@branch_no_fall: //If no longer falling


	//Disable antialising if it is set on
	LBU a0, status_options_antialiasing
	BNE a0, zero, @@branch_disableaa_on
		LI a0, 0x3216
		SW a0, 0x800EB3DC
		SW a0, 0x800EB40C
	@@branch_disableaa_on:


	//Set widescreen mode if it is on
	LBU a1, status_options_widescreen
	BEQ a1, zero, @@branch_widescren_on //If widescreeen is on
		LBU a1, player_count //Load number of players
		LI a0, 2
		BNE a0, a1, @@branch_widescreen_2p //
		LI a1, 0x3FDF//aspect ratio for player count is 1, 3, or 4 (default)
			LI a1, 0x4060 //Aspect ratio for 2 Player
		@@branch_widescreen_2p:
		SH a1, 0x80150148
	@@branch_widescren_on:


	//Ludicrious speed (top speed is set to 0x45000000)
	LBU a0, status_options_ludicrousspeed
	BEQ a0, zero, @@branch_ludicrousspeed_on
		LI a2, 0x4500 //Set top speed
		SH a2, 0x800F6BA4 //Update top speeds for all 4 players
		SH a2, 0x800F797C //Update top speeds for all 4 players
		SH a2, 0x800F8754 //Update top speeds for all 4 players
		SH a2, 0x800F952C //Update top speeds for all 4 players
	@@branch_ludicrousspeed_on:


	//Run battle bots (
	LI a0, 0x800F6990 //Only run if two or more players are alive
	LI a1, 0xDD8
	LI a2, 0xC0
	LI v0, 0
	LI v1, 3
	@@branch_count_players_alive:  //loop through v1 and count down from 4 to zero
		LBU t0, 0x0000 (a0)
		BNE t0, a2, @@branch_this_player_is_alive
		ADD a0, a0, a1
			ADDI v0, v0, 1
			@@branch_this_player_is_alive:
		BNE v1, zero, @@branch_count_players_alive
		ADDI v1, v1, -1
	SLTI a0, v0, 2
	BNE a0, zero, @@branch_skip_battle_bots //Only run battle bots if two or more players are alive
		//Run bot respawning timer and index to use when bots fall off cliffs
		LUI a0, hi(bot_respawn_timer)
		JAL decrementTimer //Load respawn timer from ram and decrement it
		LH a3, lo(bot_respawn_timer) (a0)
		LBU t0, bot_respawn_flag
		BEQ t0, zero, @@branch_bot_respawn_copy_coords
		MOVE t0, zero
			LBU t4, bot_respawn_index
			SLT t0, a3, zero //If the bot respawn flag is on and timer is less than zero then copy the coordiantes
			BEQ t0, zero, @@branch_restart_respawn_timer //If respawn timer is <= 0
				ADDI t4, t4, 0xC
				LI a1, 0x30
				BNE t4, a1, @@branch_loop_bot_respawn_index
					NOP
					LI t4, 0 //Loop index
					@@branch_loop_bot_respawn_index:
				SB t4, bot_respawn_index
				LI a3, 16 //Reset the bot respawn timer
				@@branch_restart_respawn_timer:
			SH a3, bot_respawn_timer //Store respawn timer back to RAM

			@@branch_bot_respawn_copy_coords:


		LUI a2, hi(bot_status_p1)
		LBU a1, lo(bot_status_p1) (a2) //P1
		BEQ a1, zero, @@branch_run_bot1
			LI a0, 0
			JAL runBot
			NOP
			BEQ t0, zero, @@branch_copy_coords_p1
				LI v0, 0x800F69A4 //Copy x,y,z coords from ram
				LW t1, 0x0000 (v0)//Use the 64 bitness of the Nintendo 64 for once
				LW t2, 0x0004 (v0)
				LW t3, 0x0008 (v0)
				LI v0, bot_respawn_datastructure //Paste x,y,z coords into structure
				ADDU v0, v0, t4 
				SW t1, 0x0000 (v0)
				SW t2, 0x0004 (v0)
				SW t3, 0x0008 (v0)
				@@branch_copy_coords_p1:
			@@branch_run_bot1:
		LBU a1, lo(bot_status_p2) (a2) //P2
		BEQ a1, zero, @@branch_run_bot2
			LI a0, 1
			JAL runBot
			NOP
			BEQ t0, zero, @@branch_copy_coords_p2
				LI v0, 0x800F69A4 + player_state_offset //Copy x,y,z coords from ram
				LW t1, 0x0000 (v0)
				LW t2, 0x0004 (v0)
				LW t3, 0x0008 (v0)
				LI v0, bot_respawn_datastructure + bot_respawn_player_offset //Paste x,y,z coords into structure
				ADDU v0, v0, t4 
				SW t1, 0x0000 (v0)
				SW t2, 0x0004 (v0)
				SW t3, 0x0008 (v0)
				@@branch_copy_coords_p2:
			@@branch_run_bot2:
		LBU a1, lo(bot_status_p3) (a2) //P3
		BEQ a1, zero, @@branch_run_bot3
			LI a0, 2
			JAL runBot
			NOP
			BEQ t0, zero, @@branch_copy_coords_p3
				LI v0, 0x800F69A4 + 2*player_state_offset //Copy x,y,z coords from ram
				LW t1, 0x0000 (v0)
				LW t2, 0x0004 (v0)
				LW t3, 0x0008 (v0)
				LI v0, bot_respawn_datastructure + 2*bot_respawn_player_offset //Paste x,y,z coords into structure
				ADDU v0, v0, t4 
				SW t1, 0x0000 (v0)
				SW t2, 0x0004 (v0)
				SW t3, 0x0008 (v0)
				@@branch_copy_coords_p3:
			@@branch_run_bot3:
		LBU a1, lo(bot_status_p4) (a2) //P4
		BEQ a1, zero, @@branch_run_bot4
			LI a0, 3
			JAL runBot
			NOP
			BEQ t0, zero, @@branch_copy_coords_p4
				LI v0, 0x800F69A4 + 3*player_state_offset //Copy x,y,z coords from ram
				LW t1, 0x0000 (v0)
				LW t2, 0x0004 (v0)
				LW t3, 0x0008 (v0)
				LI v0, bot_respawn_datastructure + 3*bot_respawn_player_offset //Paste x,y,z coords into structure
				ADDU v0, v0, t4 
				SW t1, 0x0000 (v0)
				SW t2, 0x0004 (v0)
				SW t3, 0x0008 (v0)
				@@branch_copy_coords_p4:
			@@branch_run_bot4:
		@@branch_skip_battle_bots:










	//auto items
	lb a1, status_item_autoitems
	beq a1, zero, @@branch_auto_items_on
		lbu a0, status_item_infgshells //If infinite greenshells are off, randomly assign tiems
		bne a0, zero, @@branch_auto_items_on
			lbu a2, random_number_generator //Load byte from RNG into $a2
			sra a2, a2, 1 //Divide RNG value by two to double the probability of getting an item
			li a0, player_item_base //load base for player has an item memory location
			li a1, 0x50
		@@branch_do_autoitems_loop:
			bne a1, a2, @@branch_autoitems_rng_is_something //if RNG value == something
			addi a1, a1, 1
				lbu a1, 0x0000 (a0)
				bne a1, zero, @@branch_autoitems_rng_is_something //check if player has an item, if not...
					li a3, 1
					sb a3, 0x0000 (a0) //randomly give player item
			@@branch_autoitems_rng_is_something:
			li a3, player_item_base + 7*player_item_offset
			//do, while a0 < a3
			bne a0, a3, @@branch_do_autoitems_loop
			addi a0, a0, player_item_offset //Increment player has an item memory location
	@@branch_auto_items_on:

	//Infinite greem_shells
	lbu a0, status_item_infgshells
	beq a0, zero, @@branch_infgreenshells_on //If set to on
		lui a0, 0x8016
		sb zero, 0x8015F6FF //Allow players to fire infinite green shells
		li a1, 3 //Give all players green shell items that are always on
		sb a1, 0x5F5D (a0)
		sb a1, 0x5F8A (a0)
		sb a1, 0x603D (a0)
		sb a1, 0x606A (a0)
		sb a1, 0x611D (a0)
		sb a1, 0x614A (a0)
		sb a1, 0x61FD (a0)
		sb a1, 0x622A (a0)
		sb a1, 0x62DD (a0)
		sb a1, 0x630A (a0)
		sb a1, 0x63BD (a0)
		sb a1, 0x63EA (a0)
	@@branch_infgreenshells_on:

	// If courses are set to flat, make all item boxes the same height off the ground
	LBU a0, status_options_flatcourses
	BEQ a0, zero, @@branch_flat_courses_set_on //If set to on
		LI a0, 0x8015F9B8 //load beginning of item array
		LI a1, 0x80162508 //load end of item array
		LBU a2, 0x800DC5A1 //Check if course is big donut or skyscraper and set item box height accordingly, Grab current course from 0x800DC5A0
		LI a3, 0x13
		BNE a2, a3, @@branch_item_box_height_big_donut
		LUI t0, 0x4120 //Force default item box height for double deck and box fort
			LUI t0, 0x430D //Item box height for big donut
		@@branch_item_box_height_big_donut:
		LI a3, 0x10
		BNE a2, a3, @@branch_item_box_height_skyscraper
			NOP
			LUI t0, 0x41A0 //Item box height for skyscraper
		@@branch_item_box_height_skyscraper:
	@@branch_item_box_height_DO: //DO while thorugh entire item array
		LHU a2, 0x0000 (a0)
		li a3, 0xC
		bne a2, a3, @@branch_object_is_item_box //If object is an item box
			LHU a2, 0x0006 (a0) //Load item box state to check if it is inialized
			LI a3, 0x2 //If item box is initialized
			BNE a2, a3, @@branch_item_box_initalized
				NOP
				SW t0, 0x001C (a0)
			@@branch_item_box_initalized:
		@@branch_object_is_item_box:
		SLT a3, a0, a1
		BNE a3, zero, @@branch_item_box_height_DO  //WHILE still in the item array
		ADDIU a0, a0, 0x70
	@@branch_flat_courses_set_on:


	//If any player has a blue shell, replace it with triple red shells, for those rare instances someone picks one up from a course item box
	LUI a0, 0x8016
	LI a1, 7 //Blue shell value
	LI a2, 6 //Triple red shell value
	LBU a3, 0x5F5D (a0) //P1 1&2P modes
	BNE a3, a1, @@branch_blue_shell_replace_p1_1p2p_mode //P1 1&2P modes
	LBU a3, 0x603D (a0)
		SB a2, 0x5F5D (a0)
		SB a2, 0x5F8A (a0)
	@@branch_blue_shell_replace_p1_1p2p_mode:
	BNE a3, a1, @@branch_blue_shell_replace_p2_1p2p_mode //P2 1&2P modes
	LBU a3, 0x611D (a0)
		SB a2, 0x603D (a0)
		SB a2, 0x606A (a0)
	@@branch_blue_shell_replace_p2_1p2p_mode:
	BNE a3, a1, @@branch_blue_shell_replace_p1_3p4p_mode //P1 3&4P modes
	LBU a3, 0x61FD (a0)
		SB a2, 0x611D (a0)
		SB a2, 0x614A (a0)
	@@branch_blue_shell_replace_p1_3p4p_mode:
	BNE a3, a1, @@branch_blue_shell_replace_p2_3p4p_mode //P2 3&4P modes
	LBU a3, 0x62DD (a0)
		SB a2, 0x61FD (a0)
		SB a2, 0x622A (a0)
	@@branch_blue_shell_replace_p2_3p4p_mode:
	BNE a3, a1, @@branch_blue_shell_replace_p3_3p4p_mode //P3 3&4P modes
	LBU a3, 0x63BD (a0)
		SB a2, 0x62DD (a0)
		SB a2, 0x630A (a0)
	@@branch_blue_shell_replace_p3_3p4p_mode:
	BNE a3, a1, @@branch_blue_shell_replace_p4_3p4p_mode //P4 3&4P modes
		NOP
		SB a2, 0x63BD (a0)
		SB a2, 0x63EA (a0)
	@@branch_blue_shell_replace_p4_3p4p_mode:

	//Force hot air balloon in Luigi's raceway to always render (credit: micro500 for figuring this out)
	LI a1, 1
	SB a1, 0x80165898


	//run different battle modes
	lbu a0, game_mode //Load game mode (0=traditional, 1=hot potato, and so on and so forth...)
	//Traditional battle mode
	LI a1, 0
	BNE a0, a1, @@branch_game_mode_traditional_battle
		NOP
		JAL runGameModeTraditionalBattle
		NOP
		BEQ zero, zero, @@branch_finished_running_game_mode
		@@branch_game_mode_traditional_battle:
	//Hot potato mode
	LI a1, 1
	BNE a0, a1, @@branch_game_mode_hot_potato
		NOP
		JAL runGameModeHotPotato
		NOP
		BEQ zero, zero, @@branch_finished_running_game_mode
		@@branch_game_mode_hot_potato:
	//Squish mode
	LI a1, 2
	BNE a0, a1, @@branch_game_mode_squish
		NOP
		JAL runGameModeSquish
		NOP
		BEQ zero, zero, @@branch_finished_running_game_mode
		@@branch_game_mode_squish:
	@@branch_finished_running_game_mode:
	// //Test mode
	// LW a1, 0x28 (sp)
	// LI a1, 3
	// BNE a0, a1, @@branch_game_mode_test
	// 	NOP
	// 	JAL runGameModeTest
	// 	NOP
	// 	@@branch_game_mode_test:



	//Display results if on results screen
	LBU a0, in_results
	BNE a0, zero, @@branch_display_results
		NOP
		JAL displayResults
		NOP
		@@branch_display_results:

	// //Set lightning shrink time if game mode is hot potato (or not)
	// LI a1, 0x1CC //Default lightning shrink time
	// LW a0, 0x28 (sp)
	// LI a2, 1
	// BNE a0, a2, @@branch_set_lightning_time_for_hot_potato //If hot potato mode
	// 	NOP
	// 	LI a1, 0x40 //Shorten lightnign shrink time, otherwise use the default above
	// 	@@branch_set_lightning_time_for_hot_potato:
	// LI a2, 2
	// BNE a0, a2, @@branch_set_lightning_time_for_squish //If in squish mode
	// 	NOP
	// 	LI a1, 0x398 //Lengthen lightning shrink time, otherwise use the default above
	// 	@@branch_set_lightning_time_for_squish:
	// SH a1, 0x8008E302 //Store lightning shrink time

	//If Max HP = 0, make everyone a ghost, why would anyone want zero HP anyway?
	LHU a0, max_hp
	BNE a0, zero, @@branch_max_hp_is_zero
		LI a1, 0x8
		SB a1, 0x800F699E
		SB a1, 0x800F7776
		SB a1, 0x800F854E
		SB a1, 0x800F9326

		@@branch_max_hp_is_zero:

	// lw a0, 0x0010 (sp) //load registers
	// lw a1, 0x0014 (sp)
	// lw a3, 0x0018 (sp)
	lw ra, 0x001C (sp)
	// lw t0, 0x0020 (sp)
	jr ra
	addi sp, sp, 0x30


race1P:
	ADDI sp, sp, -0x20
	JAL inRace
	SW ra, 0x001C (sp) //push ra to the stack
	LW ra, 0x001C (sp) //pop ra from the stack
	ADDI sp, sp, 0x20
	LUI a0, 0x800E
	LHU a0, 0xC520 (a0)
	LUI a1, 0x800E
	J 0x8000161C
	NOP






race2P:
	ADDI sp, sp, -0x20
	JAL inRace
	SW ra, 0x001C (sp) //push ra to the stack
	LW ra, 0x001C (sp) //pop ra from the stack
	ADDI sp, sp, 0x20
	LUI t3, 0x800E
	LW t3, 0xC5E8 (t3)
	J 0x80001AA4
	NOP







raceMP:
	ADDI sp, sp, -0x20
	JAL inRace
	SW ra, 0x001C (sp) //push ra to the stack
	LW ra, 0x001C (sp) //pop ra from the stack
	ADDI sp, sp, 0x20
	LUI v0, 0x800E
	LW v0, 0xC5E8 (v0)
	J 0x80001D00
	NOP

//Function display menu option with ON/OFF
//a1 = y position
//a2 = text pointer
//a3 = Status byte
menuDispOnOff:
	LI a0, 0x3C //x position
	ADDI sp, sp, 0xFFE0 //Store registers in stack so I can save them while running disp text function
	SW a0, 0x0010 (sp)
	SW a1, 0x0014 (sp)
	SW ra, 0x001C (sp)
	JAL FUNCTION_DISPLAY_TEXT //Display text for menu option
	SW a3, 0x0018 (sp)
	LW a0, 0x0010 (sp) //Load the registers back out of the stack
	LW a1, 0x0014 (sp)
	LW a3, 0x0018 (sp)
	LI a2, text_off //Text pointer for off
	BEQ a3, zero, @@BRANCH_MOVE_POINTER_TO_ON//Move pointer to "ON if the item status = 1"
		NOP
		ADDI a2, a2, 4 //Move to text pointer for on
	@@BRANCH_MOVE_POINTER_TO_ON:
	JAL FUNCTION_DISPLAY_TEXT
	addi a0, a0, 0x88 //X position (same as input + 0x88)
	LW ra, 0x001C (sp)
	JR ra
	ADDI sp, sp, 0x20



//Function display HP menu item
//A1 = y position
menuDispHP:
	addi sp, sp, -0x24
	sw ra, 0x20 (sp)

	lhu a3, max_hp //load max hp
	li a2, text_hp//text pointer for "HP"
	jal FUNCTION_DISPLAY_TEXT_AND_INT
	li a0, 0x76 //x

	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x24


//Function display timer menu item
//A1 = y position
menuDispTime:
	addi sp, sp, -0x24
	sw ra, 0x20 (sp)

	lw a3, max_timer
	li a2, 0xE10 //Divide timer by 3600 (0xE10) so output display is in minutes
	div a3, a2
	mflo a3 //a3 is the integer to display
	li a2, text_timer //text pointer
	jal FUNCTION_DISPLAY_TEXT_AND_INT
	li a0, 0x40

	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x24

//Function display max team points in menu
//A1 = y position
menuDispTeamPoints:
	addi sp, sp, -0x24
	sw ra, 0x20 (sp)

	LHU a3, max_team_points
	li a2, text_max_points //text pointer
	jal FUNCTION_DISPLAY_TEXT_AND_INT
	li a0, 0x40

	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x24


//Function displays the scoring menu item
//a1 = y position
menuDispScoring:
	addi sp, sp, -0x24
	sw ra, 0x20 (sp)
	sw a1, 0x24 (sp)

	//Display "SCORING"
	li a2, text_scoring
	li a0, 0x3C //x
	jal FUNCTION_DISPLAY_TEXT
	lw a1, 0x24 (sp) //y
	//Display which scoring mode is selected
	lbu a0, score_mode
	//Set to stock
	bne a0, zero, @@branch_disp_stock
	LI t0, 1
		li a2, text_stock
		@@branch_disp_stock:
	//Set to time
	BNE a0, t0, @@branch_disp_time
	LI t0, 2
		li a2, text_time
		@@branch_disp_time:
	//Set to team points
	BNE a0, t0, @@branch_disp_team_points
	LI t0, 3
		li a2, text_team_points
		@@branch_disp_team_points:
	//set to team time
	BNE a0, t0, @@branch_disp_team_time
		NOP
		li a2, text_team_time
		@@branch_disp_team_time:
	//Show the selection option
	lw a1, 0x24 (sp) //y
	JAL FUNCTION_DISPLAY_TEXT
	ori a0, zero, 0x88 //x

	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x24



//Function displays the bot AI type menu item
//a1 = y position
menuDispBotType:
	addi sp, sp, -0x24
	sw ra, 0x20 (sp)
	sw a1, 0x24 (sp)

	//Display "BOT AI TYPE"
	LI a2, text_bot_ai_type
	LI a0, 0x3C //x
	JAL FUNCTION_DISPLAY_TEXT
	LW a1, 0x24 (sp) //y
	//Display which bot AI type is selected
	LBU a0, bot_ai_type
	//Set to normal
	BNE a0, zero, @@branch_disp_ai_normal
	LI t0, 1
		LI a2, text_bot_ai_normal
		@@branch_disp_ai_normal:
	//Set to seeker
	BNE a0, t0, @@branch_disp_ai_seeker
	LI t0, 2
		LI a2, text_bot_ai_seeker
		@@branch_disp_ai_seeker:
	//Set to random
	BNE a0, t0, @@branch_disp_ai_random
		NOP
		LI a2, text_bot_ai_random
		@@branch_disp_ai_random:
	//Show the  option
	lw a1, 0x24 (sp) //y
	JAL FUNCTION_DISPLAY_TEXT
	ori a0, zero, 0xB8 //x


	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x24

//Function display countdown menu item
//$A1 = y position
menuDispCountdown:
	addi sp, sp, -0x24
	sw ra, 0x20 (sp)

	lhu a3, hotpotato_countdown_default //load default countdown
	li a2, 60 //Divide timer by 60 so output display is in seconds
	div a3, a2
	mflo a3 //a33 is the integer ti display
	li a2, text_countdown //text pointer
	jal FUNCTION_DISPLAY_TEXT_AND_INT
	li a0, 0x5D //x

	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x24

//Function displays options for test battle mode on the "GAME" page of menu
menuDispModeTest:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)



	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024




//Function displays options for squish battle mode on the "GAME" page of menu
menuDispModeSquish:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)

	//Display scoring menu option
	JAL menuDispScoring
	LI a1, 0x4C //y

	//If scoring is set to Stock
	lbu v0, score_mode
	bne v0, zero, @@branch_selection_hp
	LI v1, 1
		jal menuDispHP
		li a1, 0x58 //y
		@@branch_selection_hp:
	//If scoring is set to TIME
	BNE v1, v0, @@branch_selection_time
	LI v1, 2		
		jal menuDispTime
		li a1, 0x58 //y
		@@branch_selection_time:
	//If scoring is set to TEAM POINTS
	BNE v1, v0, @@branch_selection_team_points
	LI v1, 3
		jal menuDispTeamPoints
		li a1, 0x58 //y
		@@branch_selection_team_points:
	//If scoring is set to TEAM TIME
	BNE v1, v0, @@branch_selection_team_time
		li a1, 0x58 //y
		jal menuDispTime
		nop
		@@branch_selection_team_time:


	//Display respawn menu option
	li a2, text_respawn //text pointer
	lbu a3, status_respawn //status byte
	jal menuDispOnOff
	li a1, 0x64 //y

	//Set max distance you can scroll down in y on menu
	LI a1, 4
	SB a1, MENU_Y_MAX

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024



//Function displays options for hot potato battle mode on the "GAME" page of menu
menuDispModeHotpotato:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)

	//Display scoring menu option
	JAL menuDispScoring
	LI a1, 0x4C //y

	//If scoring is set to Stock
	lbu v0, score_mode
	bne v0, zero, @@branch_selection_hp
	LI v1, 1
		jal menuDispHP
		li a1, 0x58 //y
		@@branch_selection_hp:
	//If scoring is set to TIME
	BNE v1, v0, @@branch_selection_time
	LI v1, 2		
		jal menuDispTime
		li a1, 0x58 //y
		@@branch_selection_time:
	//If scoring is set to TEAM POINTS
	BNE v1, v0, @@branch_selection_team_points
	LI v1, 3
		jal menuDispTeamPoints
		li a1, 0x58 //y
		@@branch_selection_team_points:
	//If scoring is set to TEAM TIME
	BNE v1, v0, @@branch_selection_team_time
		li a1, 0x58 //y
		jal menuDispTime
		nop
		@@branch_selection_team_time:



	//Display countdown menu option
	jal menuDispCountdown
	li a1, 0x64 //y

	//Display respawn menu option
	li a2, text_respawn //text pointer
	lbu a3, status_respawn //status byte
	jal menuDispOnOff
	li a1, 0x70 //y

	//Set max distance you can scroll down in y on menu
	LI a1, 5
	SB a1, MENU_Y_MAX

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024


//Function displays options for tradiational battle mode on the "GAME" page of menu
menuDispModeTraditional:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)

	//Display scoring menu option
	JAL menuDispScoring
	LI a1, 0x4C //y

	//If scoring is set to Stock
	lbu v0, score_mode
	bne v0, zero, @@branch_selection_hp
	LI v1, 1
		jal menuDispHP
		li a1, 0x58 //y
		@@branch_selection_hp:
	//If scoring is set to TIME
	BNE v1, v0, @@branch_selection_time
	LI v1, 2		
		jal menuDispTime
		li a1, 0x58 //y
		@@branch_selection_time:
	//If scoring is set to TEAM POINTS
	BNE v1, v0, @@branch_selection_team_points
	LI v1, 3
		jal menuDispTeamPoints
		li a1, 0x58 //y
		@@branch_selection_team_points:
	//If scoring is set to TEAM TIME
	BNE v1, v0, @@branch_selection_team_time
		li a1, 0x58 //y
		jal menuDispTime
		nop
		@@branch_selection_team_time:

	//Display respawn menu option
	li a2, text_respawn //text pointer
	lbu a3, status_respawn //status byte
	jal menuDispOnOff
	li a1, 0x64 //y

	//Set max distance you can scroll down in y on menu
	LI a1, 4
	SB a1, MENU_Y_MAX

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024




//Function displays "GAME" page of menu
menuDispPageGame:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)

	//Display "MODE"
	LI a2, text_game_mode //text pointer
	LI a0, 0x3C //x
	JAL FUNCTION_DISPLAY_TEXT
	LI a1, 0x40 //y
	//Display exactly what mode is selected 
	LBU t0, game_mode
	//Display "TRADITIONAL"
	BNE t0, zero, @@BRANCH_MODE_SELECT_TRADITIONAL
		NOP
		LI a2, text_game_traditional
	@@BRANCH_MODE_SELECT_TRADITIONAL:
	//Display "HOT POTATO"
	LI t1, 1
	BNE t0, t1, @@BRANCH_MODE_SELECT_HOTPOTATO
		NOP
		LI a2, text_game_hotpotato
	@@BRANCH_MODE_SELECT_HOTPOTATO:
	//Display "SQUISH"
	LI t1, 2
	BNE t0, t1, @@BRANCH_MODE_SELECT_SQUISH
		NOP
		LI a2, text_game_squish
	@@BRANCH_MODE_SELECT_SQUISH:
	//Display "TEST MODE"
	LI t1, 3
	BNE t0, t1, @@BRANCH_MODE_SELECT_TEST
		NOP
		LI a2, text_game_testmode
	@@BRANCH_MODE_SELECT_TEST:
	//Actually show the selected option
	LI a0, 0x70 //x
	JAL FUNCTION_DISPLAY_TEXT
	LI a1, 0x40 //y


	//If tradiational battle mode is selected, display only the options for that mode
	LBU a0, game_mode
	BNE a0, zero, @@BRANCH_MODE_DISPLAY_TRADITIONAL
		NOP
		JAL menuDispModeTraditional
		NOP
	@@BRANCH_MODE_DISPLAY_TRADITIONAL:
	//Display "HOT POTATO"
	LBU a0, game_mode	
	LI a1, 1
	BNE a0, a1, @@BRANCH_MODE_DISPLAY_HOTPOTATO
		NOP
		JAL menuDispModeHotpotato
	@@BRANCH_MODE_DISPLAY_HOTPOTATO:
	//Display "SQUISH"
	LBU a0, game_mode	
	LI a1, 2
	BNE a0, a1, @@BRANCH_MODE_DISPLAY_SQUISH
		NOP
		JAL menuDispModeSquish
		NOP
	@@BRANCH_MODE_DISPLAY_SQUISH:
	//Display "TEST MODE"
	LBU a0, game_mode	
	LI a1, 3
	BNE a0, a1, @@BRANCH_MODE_DISPLAY_TEST
		NOP
		JAL menuDispModeTest
		NOP
	@@BRANCH_MODE_DISPLAY_TEST:



	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024

//Function displays "ITEMS" page of menu
menuDispPageItems:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)

	
	LI a2, text_item_banana //Display "BANANA"
	LBU a3, status_item_banana
	JAL menuDispOnOff
	LI a1, 0x40 //y

	LI a2, text_item_bananabunch //Display "BANNANA BUNCH"
	LBU a3, status_item_bananabunch
	JAL menuDispOnOff
	LI a1, 0x4C //y

	LI a2, text_item_greenshell //Display "GREEN SHELL"
	LBU a3, status_item_greenshell
	JAL menuDispOnOff
	LI a1, 0x58 //y

	LI a2, text_item_threegreenshells //Display "3 GREEN SHELLS"
	LBU a3, status_item_threegreenshells
	JAL menuDispOnOff
	LI a1, 0x64 //y

	LI a2, text_item_redshell //Display "Red Shell"
	LBU a3, status_item_redshell
	JAL menuDispOnOff
	LI a1, 0x70 //y

	LI a2, text_item_fakeitembox //Display "Fake item box"
	LBU a3, status_item_fakeitembox
	JAL menuDispOnOff
	LI a1, 0x7C //y

	LI a2, text_item_star //Display "Fake item box"
	LBU a3, status_item_star
	JAL menuDispOnOff
	LI a1, 0x88 //y

	LI a2, text_item_ghost //Display "Fake item box"
	LBU a3, status_item_ghost
	JAL menuDispOnOff
	LI a1, 0x94 //y


	LI a2, text_item_autoitems //Display "auto items"
	LBU a3, status_item_autoitems
	JAL menuDispOnOff
	LI a1, 0xA0 //y

	LI a2, text_item_infgshells //Display "inf. g. shells"
	LBU a3, status_item_infgshells
	JAL menuDispOnOff
	LI a1, 0xAC //y

	//Set shell hit height if infinite green shells are turned back off, otherwise set hit height to default
	LBU a2, status_item_infgshells //Load status
	BNE a2, zero, @@BRANCH_INFGSHELLS_OFF //If infinite green shells are turned back off
		LUI a1, 0x3C01 //Restore greenshell hit height
		ORI a1, a1, 0x3FB9 //Here is where the actual height is set (Default = 0x3F89, 0x3DCC is about 0.1 times lower)
	@@BRANCH_INFGSHELLS_OFF:
	BEQ a2, zero, @@BRANCH_INFGSHELLS_ON
		LUI a0, 0x8019
		ori a1, a1, 0x3DCC //Here is where the actual height is set 
	@@BRANCH_INFGSHELLS_ON:
	SW a1, 0xC56C (a0)
	LI a1, 0x44814000
	SW a1, 0xC578 (a0)

	//Set max distance you can scroll down in y on menu
	LI a1, 10
	SB a1, MENU_Y_MAX

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024


//Function displays "BOTS" page of menu
menuDispPageBots:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)

	LI a2, text_player1 //Display "PLAYER 1"
	LBU a3, bot_status_p1
	JAL menuDispOnOff
	LI a1, 0x40 //y

	LI a2, text_player2 //Display "PLAYER 2"
	LBU a3, bot_status_p2
	JAL menuDispOnOff
	LI a1, 0x4C //y

	LI a2, text_player3 //Display "PLAYER 3"
	LBU a3, bot_status_p3
	JAL menuDispOnOff
	LI a1, 0x58 //y

	LI a2, text_player4 //Display "PLAYER 4"
	LBU a3, bot_status_p4
	JAL menuDispOnOff
	LI a1, 0x64 //y

	JAL menuDispBotType //Dispaly bot AI type
	LI a1, 0x70 //y

	LI a2, text_bots_cannot_Fall //Display "BOTS CANNOT FALL"
	LBU a3, bot_respawn_flag
	JAL menuDispOnOff
	LI a1, 0x7C //y

	LI a2, text_bot_use_items //Display "BOTS CANNOT FALL"
	LBU a3, bot_use_items
	JAL menuDispOnOff
	LI a1, 0x88 //y

	//Set max distance you can scroll down in y on menu
	LI a1, 7
	SB a1, MENU_Y_MAX

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024


//Function displays "OPTIONS" page of menu
menuDispPageOptions:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)

	//Display "Flat Courses"
	LI a2, text_options_flatcourses
	LBU a3, status_options_flatcourses
	JAL menuDispOnOff
	LI a1, 0x40 //y

	//Restore regular course scaling if flat courses are turned back off
	lbu a0, status_options_flatcourses //load status
	BNE a0, 0, @@BRANCH_FLAT_COURSES_ON //If turned off, flatten the battle courses
		LUI a0, 0x3F80
		SW a0, 0x800DC608
	@@BRANCH_FLAT_COURSES_ON:

	//Display "WIDESCREEN"
	LI a2, text_options_widescreen
	LBU a3, status_options_widescreen
	JAL menuDispOnOff
	LI a1, 0x4C //y

	//Display "ANTIALIASING"
	LI a2, text_options_antialiasing
	LBU a3, status_options_antialiasing
	JAL menuDispOnOff
	LI a1, 0x58 //y

	//Display "3P/4P MUSIC"
	LI a2, text_options_3P4Pmusic
	LBU a3, status_options_3P4Pmusic
	JAL menuDispOnOff
	LI a1, 0x64 //y

	//Display "SAME CHARS"
	LI a2, text_options_samechars
	LBU a3, status_options_samechars
	JAL menuDispOnOff
	LI a1, 0x70 //y

	//Display Game Temp
	LI a2, text_options_gametempo
	LI a0, 0x3C //x pos
	JAL FUNCTION_DISPLAY_TEXT //display text
	LI a1, 0x7C //y pos
	//Display selected option
	LBU a0, status_options_tempo
	//Set to default
	BNE a0, zero, @@BRANCH_TEMPO_DEFAULT
		NOP
		LI a2, text_tempo_default
	@@BRANCH_TEMPO_DEFAULT:
	//Set to 15 FPS
	LI a1, 1
	BNE a0, a1, @@BRANCH_TEMPO_15FPS
		NOP
		LI a2, text_tempo_15fps
	@@BRANCH_TEMPO_15FPS:
	//Set to 20 FPS
	LI a1, 2
	BNE a0, a1, @@BRANCH_TEMPO_20FPS
		NOP
		LI a2, text_tempo_20fps
	@@BRANCH_TEMPO_20FPS:
	//Set to 30 FPS
	LI a1, 3
	BNE a0, a1, @@BRANCH_TEMPO_30FPS
		NOP
		LI a2, text_tempo_30fps
	@@BRANCH_TEMPO_30FPS:
	//Set to 60 FPS
	LI a1, 4
	BNE a0, a1, @@BRANCH_TEMPO_60FPS
		NOP
		LI a2, text_tempo_60fps
	@@BRANCH_TEMPO_60FPS:
	//Show the selected option
	LI a0, 0xA4 //x pos
	JAL FUNCTION_DISPLAY_TEXT //display text
	LI a1, 0x7C //y pos

	//Display "MINIMAP"
	LI a2, text_options_mimimap
	LBU a3, status_options_minimap
	JAL menuDispOnOff
	LI a1, 0x88 //y

	//Display "LUDICROUS SPEED"
	LI a2, text_options_ludicrousspeed
	LBU a3, status_options_ludicrousspeed
	JAL menuDispOnOff
	LI a1, 0x94 //y

	//Set max distance you can scroll down in y on the menu
	LI a1, 8
	SB a1, MENU_Y_MAX

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024



//Function handles toggling an option on/off in the menu
//a0 = Menu item status pointer
//a1 = Joystick value
//a2 = Menu item index
//a3 = Current menu index selected
menuToggleOnoff:
	BNE a3, a2, @@BRANCH_SKIP  //If menu selection is this
		li a2, 1
		BEQ a1, a2, @@BRANCH_DO_SOMETHING//If joystick was right
		li a2, 2
		BEQ a1, a2, @@BRANCH_DO_SOMETHING //If joystick was left
			NOP
			BEQ zero, zero, @@BRANCH_SKIP//If joystick was something else, just skip the rest of the code
			NOP
		@@BRANCH_DO_SOMETHING:
			LI a1, 4 //Set menu selection in progress byte to state indicating the selection has finished
			LBU a2, 0x0000 (a0) //Load item status
			NOR a2, a2, zero //Not instruction to flip the bit in a0
			SB a2,  0x0000 (a0) //Store flipped item status
	@@BRANCH_SKIP:
	JR ra
	NOP


//Function handles toggling the timer up or down in the menu for deathmatch mode
//A0 = Menu item status pointer
//A1 = Joystick value
//A2 = Menu item index
//A3 = Current menu index selected
menuToggleTimer:
	bne a3, a2, @@branch_menu_selection_is_timer
		lw a0, max_timer //load max timer
		li a2, 2
		bne a1, a2, @@branch_joystick_left //if joystick was left
			nop
			addi a0, a0, -3600 //Subtract 60 seconds
			li a1, 4 //Set menu selection in progress byte to state indicating the selection has finished
		@@branch_joystick_left:
		li a2, 1
		bne a1, a2, @@branch_joystick_right //if joystick was right
			nop
			addi a0, a0, 3600 //add 60 seconds
			li a1, 4 //Set menu selection in progress byte to state indicating the selection has finished
		@@branch_joystick_right:
		//if timer is too low, reset to min
		slti a2, a0, 3600
		beq a2, zero, @@branch_timer_too_low
			nop
			li a0, 3600
		@@branch_timer_too_low:
		sw a0, max_timer //store updated max timer		
	@@branch_menu_selection_is_timer:

	jr ra
	nop


//Function handles toggling a half up or down in the menu 
//A0 = Menu item status pointer
//A1 = Joystick value
//A2 = Menu item index
//A3 = Current menu index selected
//t0 = number max
//t1 = number value
menuToggleNumber:
	//if menu selection is HP
	bne a2, a3, @@branch_menu_selection_is_it
		li a2, 2
		bne a1, a2, @@branch_joystick_left //if joystick was left
			nop
			addi t1, t1, -1 //Subtract 1
			li a1, 4 //Set menu selection in progress byte to state indicating the selection has finished
		@@branch_joystick_left:
		li a2, 1
		bne a1, a2, @@branch_joystick_right //if joystick was right
			nop
			addi t1, t1, 1 //add 1
			li a1, 4 //Set menu selection in progress byte to state indicating the selection has finished
		@@branch_joystick_right:
		//if number is too low, reset to max
		li a2, -1
		bne t1, a2, @@branch_number_too_low
			nop
			MOVE t1, t0 //Set to max
		@@branch_number_too_low:
		//if number is too high, reset to min
		MOVE a2, t0 //Calculate max + 1
		ADDI a2, a2, 1
		bne t1, a2, @@branch_number_too_high
			nop
			li t1, 0
		@@branch_number_too_high:
	@@branch_menu_selection_is_it:
	jr ra
	nop



//Function handles toggling a half up or down in the menu 
//A0 = Menu item status pointer
//A1 = Joystick value
//A2 = Menu item index
//A3 = Current menu index selected
//t0 = number max
menuToggleHalf:
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)

	JAL menuToggleNumber
	LH t1, 0x0000 (a0)
	SH t1, 0x0000 (a0)


	LW ra, 0x20 (sp)
	jr ra
	ADDI sp, sp, 0x30







//Function handles toggling a byte up or down in the menu 
//A0 = Menu item status pointer
//A1 = Joystick value
//A2 = Menu item index
//A3 = Current menu index selected
//t0 = number max
menuToggleByte:
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)

	JAL menuToggleNumber
	LB t1, 0x0000 (a0)
	SB t1, 0x0000 (a0)

	LW ra, 0x20 (sp)
	jr ra
	ADDI sp, sp, 0x30




//Function handles toggling the countdown up or down in the menu
//A0 = Menu item status pointer
//A1 = Joystick value
//A2 = Menu item index
//A3 = Current menu index selected
menuToggleCountdown:
	bne a3, a2, @@branch_menu_countdown_selected
		lhu a0, hotpotato_countdown_default //load countdown timer default
		li a2, 2 //If joystick was left
		bne a1, a2, @@branch_joystick_left
			nop
			addi a0, a0, -0x12C //subtract 5 seconds
			li a1, 4 //Set menu selection in progress byte to state indicating the selection has finished
		@@branch_joystick_left:
		li a2, 1 //If joystick was right
		bne a1, a2, @@branch_joystick_right
			nop
			addi a0, a0, 0x12c //add 5 seconds
			li a1, 4 //Set menu selection in progress byte to state indicating the selection has finished
		@@branch_joystick_right:
		//If countdown default is too low, reset to min
		slti a2, a0, 0
		beq a2, zero, @@branch_countdown_too_low
			nop
			li a0, 0
		@@branch_countdown_too_low:
		sh a0, hotpotato_countdown_default //store updated countdown default
	@@branch_menu_countdown_selected:
	jr ra
	nop


//Menu toggling on game page for traditional battle
menuToggleGameTraditional:
	addi sp, sp, -0x24
	sw ra, 0x1C (sp)

	//if menu selection is scoring
	LI a0, score_mode //load status pointer
	LI a2, 1 //menu index
	JAL menuToggleByte
	LI t0, 3
	

	//if scoring is set to stock
	lbu v0, score_mode
	li a2, 2
	BNE v0, zero, @@branch_selection_hp //if menu selection is hp
		LI a0, max_hp
		JAL menuToggleHalf
		LI t0, 9999 //How high can the HP go
		@@branch_selection_hp:
	LI v1, 2
	BNE v0, v1, @@branch_selection_team_points //if menu selection is team points
		LI a0, max_team_points
		JAL menuToggleHalf
		LI t0, 9999 //How high can the points go
		@@branch_selection_team_points:
	//If scoring is set to time or team time
	LI v1, 1
	BNE v0, v1, @@branch_selection_time //if menu selection is timer
		nop
		jal menuToggleTimer
		nop
		@@branch_selection_time:
	LI v1, 3
	BNE v0, v1, @@branch_selection_team_time //if menu selection is timer
		nop
		jal menuToggleTimer
		nop
		@@branch_selection_team_time:

	//if menu selection is respawn
	li a0, status_respawn //load status pointer
	jal menuToggleOnoff
	li a2, 3 //menu index

	lw ra, 0x1C (sp)
	jr ra
	addi sp, sp, 0x24

//Menu toggling on game page for hot potato battle
menuToggleGameHotpotato:
	addi sp, sp, -0x24
	sw ra, 0x1C (sp)

	//if menu selection is scoring
	LI a0, score_mode //load status pointer
	LI a2, 1 //menu index
	JAL menuToggleByte
	LI t0, 3

	//if scoring is set to stock
	lbu v0, score_mode
	li a2, 2
	BNE v0, zero, @@branch_selection_hp //if menu selection is hp
		LI a0, max_hp
		JAL menuToggleHalf
		LI t0, 9999 //How high can the HP go
		@@branch_selection_hp:
	LI v1, 2
	BNE v0, v1, @@branch_selection_team_points //if menu selection is team points
		LI a0, max_team_points
		JAL menuToggleHalf
		LI t0, 9999 //How high can the points go
		@@branch_selection_team_points:
	//If scoring is set to time or team time
	LI v1, 1
	BNE v0, v1, @@branch_selection_time //if menu selection is timer
		nop
		jal menuToggleTimer
		nop
		@@branch_selection_time:
	LI v1, 3
	BNE v0, v1, @@branch_selection_team_time //if menu selection is timer
		nop
		jal menuToggleTimer
		nop
		@@branch_selection_team_time:

	//If menu selection is countdown
	jal menuToggleCountdown
	li a2, 3 //menu index


	//if menu selection is respawn
	li a0, status_respawn //load status pointer
	jal menuToggleOnoff
	li a2, 4 //menu index

	lw ra, 0x1C (sp)
	jr ra
	addi sp, sp, 0x24


//Menu toggling on game page for squish battle
menuToggleGameSquish:
	addi sp, sp, -0x24
	sw ra, 0x1C (sp)

	//if menu selection is scoring
	LI a0, score_mode //load status pointer
	LI a2, 1 //menu index
	JAL menuToggleByte
	LI t0, 3

	//if scoring is set to stock
	lbu v0, score_mode
	li a2, 2
	BNE v0, zero, @@branch_selection_hp //if menu selection is hp
		LI a0, max_hp
		JAL menuToggleHalf
		LI t0, 9999 //How high can the HP go
		@@branch_selection_hp:
	LI v1, 2
	BNE v0, v1, @@branch_selection_team_points //if menu selection is team points
		LI a0, max_team_points
		JAL menuToggleHalf
		LI t0, 9999 //How high can the points go
		@@branch_selection_team_points:
	//If scoring is set to time or team time
	LI v1, 1
	BNE v0, v1, @@branch_selection_time //if menu selection is timer
		nop
		jal menuToggleTimer
		nop
		@@branch_selection_time:
	LI v1, 3
	BNE v0, v1, @@branch_selection_team_time //if menu selection is timer
		nop
		jal menuToggleTimer
		nop
		@@branch_selection_team_time:

	//if menu selection is respawn
	li a0, status_respawn //load status pointer
	jal menuToggleOnoff
	li a2, 3 //menu index

	lw ra, 0x1C (sp)
	jr ra
	addi sp, sp, 0x24




//Menu toggling on game page for test battle
menuToggleGameTest:
	addi sp, sp, -0x24
	sw ra, 0x1C (sp)


	lw ra, 0x1C (sp)
	jr ra
	addi sp, sp, 0x24

//Handling toggling menu options on the game page
menuToggleGame:
	addi sp, sp, -0x24
	sw ra, 0x1C (sp)


	//If menu selection is mode
	LI a0, game_mode //load status pointer
	LI a2, 0 //menu index
	JAL menuToggleByte
	LI t0, 2 //max value

	// //If menu selection is mode
	// bne a3, zero, @@branch_mode_select
	// 	lbu a0, game_mode //load game mode
	// 	li a2, 2 //if joystick was left
	// 	bne a1, a2, @@branch_joystick_left
	// 		nop
	// 		addi a0, a0, -1 //subtract 1 from game mode vriable
	// 		li a1, 4 //set menu selection in progress byte to state indicating the selection has finished
	// 	@@branch_joystick_left:
	// 	li a2, 1 //if joystick was right
	// 	bne a1, a2, @@branch_joystick_right
	// 		nop
	// 		addi a0, a0, 1 //add 1 to game mode vriable
	// 		li a1, 4 //set menu selection in progress byte to state indicating the selection has finished
	// 	@@branch_joystick_right:	
	// 	//if game mode is too low, loop to max
	// 	li a2, -1
	// 	bne a0, a2, @@branch_too_low
	// 		nop
	// 		li a0, 3
	// 	@@branch_too_low:
	// 	//if game mode is too high, loop to min
	// 	li a2, 4
	// 	bne a0, a2, @@branch_too_high
	// 		nop
	// 		li a0, 0
	// 	@@branch_too_high:
	// 	sb a0, game_mode //store updated game mode
	// @@branch_mode_select:

	//If mode is traditional battle
	lbu a0, game_mode //load game mode
	bne a0, zero, @@branch_traditional_mode
		nop
		jal menuToggleGameTraditional
		nop
	@@branch_traditional_mode:

	//If mode is hot potato
	lbu a0, game_mode //load game mode
	li a2, 1
	bne a0, a2, @@branch_hotpotato_mode
		nop
		jal menuToggleGameHotpotato
		nop
	@@branch_hotpotato_mode:

	//If mode is squish
	lbu a0, game_mode //load game mode
	li a2, 2
	bne a0, a2, @@branch_squish_mode
		nop
		jal menuToggleGameSquish
		nop
	@@branch_squish_mode:

	//If mode is squish
	lbu a0, game_mode //load game mode
	li a2, 3
	bne a0, a2, @@branch_test_mode
		nop
		jal menuToggleGameTest
		nop
	@@branch_test_mode:


	lw ra, 0x1C (sp)
	jr ra
	addi sp, sp, 0x24


//Handling toggling of menu options on the items page
menuToggleItems:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x001C (sp)

	//If menu selection is Banana
	li a0, status_item_banana //Load status pointer
	JAL menuToggleOnoff
	li a2, 0 //Load menu index

	//If menu selection is Banana Bunch
	li a0, status_item_bananabunch //Load status pointer
	JAL menuToggleOnoff
	li a2, 1 //Load menu index

	//If menu selection is Green shell
	li a0, status_item_greenshell//Load status pointer
	JAL menuToggleOnoff
	li a2, 2 //Load menu index

	//If menu selection is Triple Green Shells
	li a0, status_item_threegreenshells //Load status pointer
	JAL menuToggleOnoff
	li a2, 3 //Load menu index

	//If menu selection is Red Shell
	li a0, status_item_redshell //Load status pointer
	JAL menuToggleOnoff
	li a2, 4 //Load menu index

	//If menu selection is Fake Item Box
	li a0, status_item_fakeitembox //Load status pointer
	JAL menuToggleOnoff
	li a2, 5 //Load menu index

	//If menu selection is Star
	li a0, status_item_star //Load status pointer
	JAL menuToggleOnoff
	li a2, 6 //Load menu index

	//If menu selection is Ghost
	li a0, status_item_ghost //Load status pointer
	JAL menuToggleOnoff
	li a2, 7 //Load menu index

	//If menu selection is Auto Items
	li a0, status_item_autoitems //Load status pointer
	JAL menuToggleOnoff
	li a2, 8 //Load menu index

	//If menu selection is Inf. Green Shells
	li a0, status_item_infgshells //Load status pointer
	JAL menuToggleOnoff
	li a2, 9 //Load menu index

	LW ra, 0x001C (sp)
	JR ra
	ADDI sp, sp, 0x0024


//Handling toggling of menu options on the bots page
menuToggleBots:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x001C (sp)

	//If menu selection is Player 1 on/off
	li a0, bot_status_p1 //Load status pointer
	JAL menuToggleOnoff
	li a2, 0 //Load menu index

	//If menu selection is Player 2 on/off
	li a0, bot_status_p2 //Load status pointer
	JAL menuToggleOnoff
	li a2, 1 //Load menu index

	//If menu selection is Player 3 on/off
	li a0, bot_status_p3//Load status pointer
	JAL menuToggleOnoff
	li a2, 2 //Load menu index

	//If menu selection is Player 4 on/off
	li a0, bot_status_p4 //Load status pointer
	JAL menuToggleOnoff
	li a2, 3 //Load menu index


	//If menu selection is bot AI type
	li a0, bot_ai_type //Load status pointer
	LI a2, 4 //menu index
	JAL menuToggleByte
	LI t0, 2 //max value


	//If menu selection is bots can fall on/off
	li a0, bot_respawn_flag //Load status pointer
	JAL menuToggleOnoff
	li a2, 5 //Load menu index

	//If menu sleection is bots use items
	LI a0, bot_use_items
	JAL menuToggleOnoff
	li a2, 6 //Load menu index


	LW ra, 0x001C (sp)
	JR ra
	ADDI sp, sp, 0x0024


//Handling toggling of menu options on the options page
menuToggleOptions:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x001C (sp)

	//If menu selection is flat courses
	LI a0, status_options_flatcourses //Load status pointer
	JAL menuToggleOnoff
	LI a2, 0 //Load menu index

	//If menu selection is widescreen
	LI a0, status_options_widescreen //Load status pointer
	JAL menuToggleOnoff
	LI a2, 1 //Load menu index

	//If menu selection is antialiasing
	LI a0, status_options_antialiasing //Load status pointer
	JAL menuToggleOnoff
	LI a2, 2 //Load menu index

	//If menu selection is 3P/4P music
	LI a0, status_options_3P4Pmusic //Load status pointer
	JAL menuToggleOnoff
	LI a2, 3 //Load menu index

	//If menu selection is all chars select
	LI a0, status_options_samechars //Load status pointer
	JAL menuToggleOnoff
	LI a2, 4 //Load menu index

	//If menu selection is game tempo
	LI a2, 5 //menu index
	LI a0, status_options_tempo //status pointer
	JAL menuToggleByte
	LI t0, 4 //max value

	// BNE a3, a2, @@BRANCH_SELECTION_TEMPO
	// 	LBU a0, status_options_tempo //Load game tempo status
	// 	Li a2, 2
	// 	BNE a1, a2, @@BRANCH_JOYSTICK_LEFT //If joystick is left
	// 		NOP
	// 		ADDI a0, a0, -1 //Subtract 1 from variable
	// 		Li a1, 4 //Set menu selection in progress byte to state indicating the selection has finished
	// 	@@BRANCH_JOYSTICK_LEFT:
	// 	LI a2, 1
	// 	BNE a1, a2, @@BRANCH_JOYSTICK_RIGHT
	// 		NOP
	// 		ADDI a0, a0, 1 //Add 1 to variable
	// 		Li a1, 4 //Set menu selection in progress byte to state indicating the selection has finished
	// 	@@BRANCH_JOYSTICK_RIGHT:
	// 	LI a2, -1
	// 	BNE a0, a2, @@BRANCH_SELECTION_LOW //If option status is too low, loop to max 
	// 		NOP
	// 		LI a0, 3
	// 	@@BRANCH_SELECTION_LOW:
	// 	LI a2, 4
	// 	BNE a0, a2, @@BRANCH_SELECTION_HIGH //If option status is too high, loop to min
	// 		NOP
	// 		LI a0, 0
	// 	@@BRANCH_SELECTION_HIGH:
	// 	SB a0, status_options_tempo //Store updated tempo
	// @@BRANCH_SELECTION_TEMPO:



	//Tempo control
	LBU v0, status_options_tempo //(0 = Default, 1 = 15 FPS, 2 = 20 FPS, 3=30 FPS)
	LUI v1, 0x8000
	BNE v0, zero, @@branch_tempo_off //If tempo is set to default
		LI a0, 0x3C0F8015 //1P tempo default code
		SW a0, 0x15C4 (v1)
		LI a0, 0x8DEF0114
		SW a0, 0x15C8 (v1)
		LI a0, 0x3C098015 //2P default tempo code
		SW a0, 0x1A38 (v1)
		LI a0, 0x8D290114
		SW a0, 0x1A3C (v1)
		LI a0, 0x3C0A8015 //3/4P default dempo code
		SW a0, 0x1C90 (v1)
		LI a0, 0x8D4A0114
		SW a0, 0x1C94 (v1)
	@@branch_tempo_off:
	BEQ v0, zero, @@branch_tempo_on //If tempo is not set to default
		//Set assembly
		LI a0, 0x240F //1P tempo
		SH a0, 0x15C4 (v1)
		SH a0, 0x15C8 (v1)
		LI a0, 0x2409 //2P tempo
		SH a0, 0x1A38 (v1)
		SH a0, 0x1A3C (v1)
		LI a0, 0x240A //3P/4P tempo
		SH a0, 0x1C90 (v1)
		SH a0, 0x1C94 (v1)
		//Set tempo number
		LI a2, 5
		SUB a0, a2, v0
		SH a0, 0x15C6 (v1) //1P tempo
		SH a0, 0x15CA (v1)
		SH a0, 0x1A3A (v1) //2P tempo
		SH a0, 0x1A3E (v1)
		SH a0, 0x1C92 (v1) //3P/4P tempo
		SH a0, 0x1C96 (v1)
		// //If tempo set to 60 FPS, run a few extra things so that it runs correctly in emulator at 2x speed, source: http://forum.pj64-emu.com/showthread.php?t=8848)
		// LI k1, 1
		// BNE k0, k1, @@branch_tempo_on
		// 	LUI k0, 0x8000
		// 	SB zero, 0x0FE3 (k0)
		// 	SB k1, 0x14CF (k0)
		// 	LI k1, 0x24010001
		// 	SW k1, 0x1890 (k0)
		// 	SW k1, 0x1894 (k0)
		// 	LUI k0, 0x800B
		// 	LI k1, 0x24010006
		// 	SW k1, 0xC5D4 (k0)
	@@branch_tempo_on:


	//If menu selection is minimap
	LI a0, status_options_minimap //Load status pointer
	JAL menuToggleOnoff
	LI a2, 6 //Load menu index

	//Control if minimap is on or off
	LB v0, status_options_minimap
	BNE v0, zero, @@BRANCH_MINIMMAP_ONOFF
		LI v1, 0x0C01 //default
		LI v1, 0x2400 //Minimap off
	@@BRANCH_MINIMMAP_ONOFF:
	SH v1, 0x80059D08

	//If menu selection is ludicrious speed
	LI a0, status_options_ludicrousspeed //Load status pointer
	JAL menuToggleOnoff
	LI a2, 7 //Load menu index


	LW ra, 0x001C (sp)
	JR ra
	ADDI sp, sp, 0x0024



//Function plays menu move curisor sound
menuPlaySound:
	ADDI sp, sp, 0xFFDC
	SW a0, 0x0010 (sp)
	SW a1, 0x0014 (sp)
	SW a2, 0x0018 (sp)
	SW a3, 0x001C (sp)
	SW ra, 0x0020 (sp)
	LUI a0, 0x4900 //Load sound ID for menu cursor move
	JAL FUNCTION_PLAY_SOUND //Run function to play sound
	ORI a0, a0, 0x8000
	LW a0, 0x0010 (sp)
	LW a1, 0x0014 (sp)
	LW a2, 0x0018 (sp)
	LW a3, 0x001C (sp)
	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024


titleScreen:

	.word 0x0C02555D //#Run lines that were replaced by hook first, COMMENTING OUT DISABLES TITLE SCREEN LOGO AND BACKGROUND which is what I want
	.word 0x00000000

	// //set boot flag
	// LI a0, 1
	// SB a0, boot_flag
	//Force crash screen to always display
	LI a0, 0x08001192
	LUI a1, hi(0x800045F0)
	SW a0, lo(0x800045F0) (a1)
	//Force starting lap to be 1, this forces the balloon with the blue shell to display in Luigi's raceway
	SH zero, 0x8000F94A


	//Disable  flag, "press start" and the Mario Raceway time on title screen and zero out timer for demo
	lui a0, 0x8019
	SW zero, 0xDA30 (a0) //g_mflagID
	SW zero, 0xDA58 (a0) //g_mpressstartID
	SW zero, 0xDA80 (a0) //g_mracewayTime
	SW zero, 0xEE00 (a0) //Stop title demo counter at 8018EE00 from counting anything


	ADDI sp, sp, 0xFFB8 //Store registers
	SW a0, 0x0028 (sp)
	SW a1, 0x002C (sp)
	SW a2, 0x0030 (sp)
	SW a3, 0x0034 (sp)
	SW ra, 0x0038 (sp)
	SW t6, 0x003C (sp)



	//Display a semi-transparent background for the menu
	LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ORI a1, zero, 0x1C //x1
	ORI a2, zero, 0xC //y1
	ORI a3, zero, 0x11C //x2
	ORI t6, zero, 0xDC //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	SW zero, 0x0014 (sp) //u32 r
	SW zero, 0x0018 (sp) //u32 g
	SW zero, 0x001C (sp) //u32 b
	ORI t6, zero, 0xC8 //transparency
	SW $t6, 0x0020 (sp)
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298

	//Display menu border left
	LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ORI a1, zero, 0x1C //x1
	ORI a2, zero, 0xC //y1
	ORI a3, zero, 0x1E //x2
	ORI t6, zero, 0xDC //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	ORI t6, zero, 0x80
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	ORI t6, zero, 0xFF //transparency
	SW $t6, 0x0020 (sp)
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298

	//Display menu border right
	LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ORI a1, zero, 0x11C //x1
	ORI a2, zero, 0xC //y1
	ORI a3, zero, 0x11E //x2
	ORI t6, zero, 0xDC //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	ORI t6, zero, 0x80
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	ORI t6, zero, 0xFF //transparency
	SW $t6, 0x0020 (sp)
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298

	//Display menu border bottom
	LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ORI a1, zero, 0x1C //x1
	ORI a2, zero, 0xDA //y1
	ORI a3, zero, 0x11C //x2
	ORI t6, zero, 0xDC //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	ORI t6, zero, 0x80
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	ORI t6, zero, 0xFF //transparency
	SW $t6, 0x0020 (sp)
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298

	//Display menu border top
	LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ORI a1, zero, 0x1C //x1
	ORI a2, zero, 0xC //y1
	ORI a3, zero, 0x11C //x2
	ORI t6, zero, 0xE //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	ORI t6, zero, 0x80
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	ORI t6, zero, 0xFF //transparency
	SW $t6, 0x0020 (sp)
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298

	//Display menu seperator between battle kart and credit title and tabs
	LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ORI a1, zero, 0x1C //x1
	ORI a2, zero, 0x2A //y1
	ORI a3, zero, 0x11C //x2
	ORI t6, zero, 0x2C //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	ORI t6, zero, 0x80
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	ORI t6, zero, 0xFF //transparency
	SW $t6, 0x0020 (sp)
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298

	//Display menu seperator between tabs and rest of menu
	LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ORI a1, zero, 0x1C //x1
	ORI a2, zero, 0x40 //y1
	ORI a3, zero, 0x11C //x2
	ORI t6, zero, 0x42 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	ORI t6, zero, 0x80
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	ORI t6, zero, 0xFF //transparency
	SW $t6, 0x0020 (sp)
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298



	//Display tab border
	LBU a3, MENU_TAB //Load current page
	BNE a3, zero, @@branch_menu_tab_items //If page == 0, set x position to t7
		LI a1, 0x1
		LI t7, 0x22
	@@branch_menu_tab_items:
	BNE a3, a1, @@branch_menu_tab_game //If page == 1, set x position to t7
		LI a1, 0x2
		LI t7, 0x5E
	@@branch_menu_tab_game:
	BNE a3, a1, @@branch_menu_tab_bots //If page == 2, set x position to t7
		LI a1, 0x3
		LI t7, 0x9A
	@@branch_menu_tab_bots:
	BNE a3, a1, @@branch_menu_tab_options//If page == 3, set x position to t7
		NOP
		LI t7, 0xD6
	@@branch_menu_tab_options:
	SW t7, 0x0040 (sp) //Store result in stack so it can be accessed even after running jal 0x80098DF8



	//Display tab background
	lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ADDI a1, t7, 0x00 //x1
	LI a2, 0x30 //y1
	ADDI a3, t7, 0x3E //x2
	LI t6, 0x40 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	LI t6, 0x50
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298

	//Display left side of tab
	LW t7, 0x0040 (sp) //Load stored x position of tab that was stored in the stack
	lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ADDI a1, t7, 0x00 //x1
	LI a2, 0x32 //y1
	ADDI a3, t7, 0x02 //x2
	LI t6, 0x40 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	LI t6, 0x80
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298

	//Display right side of tab
	LW t7, 0x0040 (sp) //Load stored x position of tab that was stored in the stack
	lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ADDI a1, t7, 0x3C //x1
	LI a2, 0x32 //y1
	ADDI a3, t7, 0x3E //x2
	LI t6, 0x40 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	LI t6, 0x80
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298


	//Display top of tab
	LW t7, 0x0040 (sp) //Load stored x position of tab that was stored in the stack
	lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ADDI a1, t7, 0x00 //x1
	LI a2, 0x30 //y1
	ADDI a3, t7, 0x3E //x2
	LI t6, 0x32 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	LI t6, 0x80
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298


	//Display currently selected item as a long skinny rectangle
	LBU a1, MENU_TAB
	LI a3, MENU_Y_GAME //Load current menu selection and set the Y position based on that, $A1 is the y position
	ADDU a3, a3, a1
	LBU a1, 0x0000 (a3)
	LI a2, 12 //multiply a1 by 12
	MULT a1, a2
	MFLO a1
	ADDI a2, a1, 0x51 //a1 is the y positiion
	LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	LI a1, 0x34 //x1
	LI a3, 0x106 //x2
	ADDI t6, a2, 0xE //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	SW zero, 0x0014 (sp) //u32 r
	SW zero, 0x0018 (sp) //u32 g
	li t6, 0xFF
	SW t6, 0x001C (sp) //transparency
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298





	//Use Z and R buttons to move through menu pages
	LHU a0, BUTTON_ACTIVATOR_1_P1 //Load P1 buttons pressed
	LBU a3, MENU_TAB //Load current menu tab
	LBU a1, MENU_TAB_PROGRESS //Load current menu tab movement in progress byte
	BNE a1, zero, @@BRANCH_MENU_TAB_MOVE_SKIP
		ANDI a2, a0, 0x2020
		BEQ a2, zero, @@BRANCH_MENU_TAB_MOVE_LEFT //If Z or L is pressed, move menu page left
			NOP
			JAL menuPlaySound //Play menu sound
			ADDI a3, a3, -1
			LI a1, 1 //Menu selection in progress byte set
		@@BRANCH_MENU_TAB_MOVE_LEFT:
		ANDI a2, a0, 0x0010
		BEQ a2, zero, @@BRANCH_MENU_TAB_MOVE_RIGHT //If R button is pressed, move menu tab right
			NOP
			JAL menuPlaySound //Play menu sound
			ADDI a3, a3, 1
			LI a1, 1 //Menu selection in progress byte set
		@@BRANCH_MENU_TAB_MOVE_RIGHT:
	@@BRANCH_MENU_TAB_MOVE_SKIP:
	BNE a0, zero, @@BRANCH_MENU_TAB_PROGRESS_BYTE_RESET //Reset menu page move in progress byte if no buttons are pressed
		NOP
		LI a1, 0 //Menu tab movement byte in progress reset to zero
	@@BRANCH_MENU_TAB_PROGRESS_BYTE_RESET:
	BNE a3, -1,  @@BRANCH_MENU_TAB_TOO_LOW //if menu page is too low, reset to max
		NOP
		LI a3, 3
	@@BRANCH_MENU_TAB_TOO_LOW:
	BNE a3, 4,  @@BRANCH_MENU_TAB_TOO_HIGH //if menu page is too high, reset to min
		NOP
		LI a3, 0
	@@BRANCH_MENU_TAB_TOO_HIGH:
	SB a3, MENU_TAB //Store menu selection in progress and menu selection bytes back to ram
	SB a1, MENU_TAB_PROGRESS



	//Move menu selection y-axis or option based on P1 C-stick y-axis (Using c-stick activator #2 D014F0F3 00??)
	lbu a1, MENU_Y_PROGRESS //Load value of menu y movmement in progress byte
	lbu a3, MENU_TAB //Load current menu page
	li a0, MENU_Y_GAME
	ADDU a3, a0, a3
	LB a3, 0x0000 (a3) //Load current menu selection, which will vary based on page
	LBU a0, CSTICK_ACTIVATOR_Y_P1 //Load value of P1's joystick y-axis into a0
	SRL a0, a0, 6 //Divide joystick value by 32
	lbu v0, BUTTON_ACTIVATOR_1_P1 //Add d-pad support, load button activator
	li v1, 0x08
	BNE v0, v1, @@BRANCH_MENU_DUP_PRESSED //If D-up is held, set joystick value to what it would be if it was up
		NOP
		li a0, 1
	@@BRANCH_MENU_DUP_PRESSED:
	li v1, 0x04
	BNE v0, v1, @@BRANCH_MENU_DDOWN_PRESSED //If D-up is held, set joystick value to what it would be if it was up
		NOP
		li a0, 2
	@@BRANCH_MENU_DDOWN_PRESSED:
	BNE a1, zero, @@BRANCH_MENU_Y_SELECTION_SKIP_IF_SELECTION_IN_PROGRESS //If menu selection in progress, skip moving the menu selection since it is already in the process of moving
		li a2, 0x1
		BNE a0, a2, @@BRANCH_MENU_Y_MOVE_UP //If c-stick is up and the value is high enough, move menu selection up
			NOP
			JAL menuPlaySound//play menu sound
			ADDI a3, a3, -1 //move up
			li a1, 1 //Menu selection in progress byte set
		@@BRANCH_MENU_Y_MOVE_UP:
		li a2, 0x2
		BNE a0, a2, @@BRANCH_MENU_Y_MOVE_DOWN //If c-stick is down and the value is high enough, move menu selection down
			NOP
			JAL menuPlaySound//play menu sound
			ADDI a3, a3, 1 //move down
			li a1, 1 //Menu selection in progress byte set
		@@BRANCH_MENU_Y_MOVE_DOWN:
	@@BRANCH_MENU_Y_SELECTION_SKIP_IF_SELECTION_IN_PROGRESS:
	BEQ a0, zero, @@BRANCH_MENU_Y_IN_PROGRESS_JOYSTICK_DOWN //Reset menu selection in progress byte if joystick is not moved far enough (up or down a little)
		li a2, 3
		BNE a0, a2, @@BRANCH_MENU_Y_IN_PROGRESS_JOYSTICK_UP
		NOP
		@@BRANCH_MENU_Y_IN_PROGRESS_JOYSTICK_DOWN:
		li a1, 0
	@@BRANCH_MENU_Y_IN_PROGRESS_JOYSTICK_UP:
	li a2, -1 //if menu selection is too low, reset to min
	BNE a3, a2, @@BRANCH_MENU_Y_TOO_LOW
		NOP
		li a3, 0
	@@BRANCH_MENU_Y_TOO_LOW:
	lbu a2, MENU_Y_MAX //if menu selection is too high, reset to max, grab max menu scroll distance
	BNE a3, a2, @@BRANCH_MENU_Y_TOO_HIGH
		ADDI a2, a2, -1
		ADD a3, a2, zero //Subtract 1 and put value back to max possible scroll down distance
	@@BRANCH_MENU_Y_TOO_HIGH:
	lbu a2, MENU_TAB //Load current menu page
	li a0, MENU_Y_GAME
	ADDU a2, a0, a2 //Load current menu selection, which will vary based on page
	SB a1, MENU_Y_PROGRESS //Store value of menu y movmement in progress byte
	SB a3, (0x0000) (a2) //Store value of y position in menu for current menu page



	//Move menu selection x-axis or option based on P1 C-stick x-axis (Using c-stick activator #2 D014F0F2 00??)
	LBU a1, MENU_X_PROGRESS //Load value of menu x movmement in progress byte
	LBU a0, CSTICK_ACTIVATOR_X_P1 //Load value of P1's joystick x-axis into $A0
	SRL a0, a0, 6 //Divide joystick value by 32
	//Add d-pad support
	lbu v0, BUTTON_ACTIVATOR_1_P1 //Load button activator
	li v1, 2
	BNE v0, v1, @@BRANCH_MENU_DLEFT_PRESSED //If D-up is held, set joystick value to what it would be if it was up
		NOP
		li a0, 2
	@@BRANCH_MENU_DLEFT_PRESSED:
	LI v1, 1
	BNE v0, v1, @@BRANCH_MENU_DRIGHT_PRESSED //If D-up is held, set joystick value to what it would be if it was up
		NOP
		li a0, 1
	@@BRANCH_MENU_DRIGHT_PRESSED:
	LI a2, 4
	BEQ a1, a2, @@BRANCH_MENU_X_SELECTION_SKIP_IF_SELECTION_IN_PROGRESS //If menu selection in progress, skip moving the menu selection since it is already in the process of moving
		LI a2, 1
		BNE a0, a2, @@BRANCH_MENU_X_SELECTION_CSTICK_LEFT //If c-stick is left and the value is high enough, move menu selection left
			NOP
			JAL menuPlaySound//play menu sound
			li a1, 1 
		@@BRANCH_MENU_X_SELECTION_CSTICK_LEFT:
		LI a2, 2
		BNE a0, a2, @@BRANCH_MENU_X_SELECTION_CSTICK_RIGHT //If c-stick is right and the value is high enough, move menu selection right
			NOP
			JAL menuPlaySound//play menu sound
			li a1, 2
		@@BRANCH_MENU_X_SELECTION_CSTICK_RIGHT:
	@@BRANCH_MENU_X_SELECTION_SKIP_IF_SELECTION_IN_PROGRESS:
	BEQ a0, zero, @@BRANCH_MENU_X_SELECTION_RESET_IN_PROGRESS_BYTE //Rest menu selection in progress byte if joystick is not moved far enough
	li a2, 3
	BEQ a0, a2, @@BRANCH_MENU_X_SELECTION_RESET_IN_PROGRESS_BYTE
		NOP
		BEQ zero, zero, @@BRANCH_MENU_X_SELECTION_RESET_EXIT
			NOP
			@@BRANCH_MENU_X_SELECTION_RESET_IN_PROGRESS_BYTE:
			li a1, 0
		@@BRANCH_MENU_X_SELECTION_RESET_EXIT:

	//Menu toggling only for page 1 GAME
	LBU a2, MENU_TAB //Load current menu tab page
	BNE a2, zero, @@BRANCH_MENU_GAME_PAGE_TOGGLE
		NOP
		JAL menuToggleGame
		NOP
	@@BRANCH_MENU_GAME_PAGE_TOGGLE:


	//Menu toggling only for page 2 ITEMS
	LBU a2, MENU_TAB //Load current menu tab page
	LI a0, 1
	BNE a2, a0, @@BRANCH_MENU_ITEMS_PAGE_TOGGLE
		NOP
		JAL menuToggleItems
		NOP
	@@BRANCH_MENU_ITEMS_PAGE_TOGGLE:

	//Menu toggling only for page BOTS
	LBU a2, MENU_TAB //Load current menu tab page
	LI a0, 2
	BNE a2, a0, @@BRANCH_MENU_BOTS_PAGE_TOGGLE
		NOP
		JAL menuToggleBots
		NOP
	@@BRANCH_MENU_BOTS_PAGE_TOGGLE:

	//Menu toggling for page OPTIONS
	LBU a2, MENU_TAB //Load current menu tab page
	LI a0, 3
	BNE a2, a0, @@BRANCH_MENU_OPTIONS_PAGE_TOGGLE
		NOP
		JAL menuToggleOptions
		NOP
	@@BRANCH_MENU_OPTIONS_PAGE_TOGGLE:


	//Store menu selection in progress byte back to ram
	SB a1, MENU_X_PROGRESS


	//Load font
	JAL 0x80057710
	NOP



	//Display page corrisponding to whatever tab is selected
	LBU t0, MENU_TAB
	BNE t0, zero, @@BRANCH_SHOW_MENU_PAGE_GAME 	//Tab 0 == page for Game
		NOP
		JAL menuDispPageGame
		NOP
	@@BRANCH_SHOW_MENU_PAGE_GAME: 
	BNE t0, 1, @@BRANCH_SHOW_MENU_PAGE_ITEMS //Tab 1 == page for Items
		NOP
		JAL menuDispPageItems
		NOP
	@@BRANCH_SHOW_MENU_PAGE_ITEMS:
	BNE t0, 2, @@BRANCH_SHOW_MENU_PAGE_BOTS //Tab 2 == page for Bots
		NOP
		JAL menuDispPageBots
		NOP
	@@BRANCH_SHOW_MENU_PAGE_BOTS:
	BNE t0, 3, @@BRANCH_SHOW_MENU_PAGE_OPTIONS //Tab 3 == page for Options
		NOP
		JAL menuDispPageOptions
		NOP
	@@BRANCH_SHOW_MENU_PAGE_OPTIONS:



	//Display title "BATTLE KART 64"
	LI a0, 0x54 //a0 is the X pos
	LI a2, text_title_1 //text pointer
	JAL FUNCTION_DISPLAY_TEXT //Print text
	LI a1, 0x00 //a1 is the y pos

	//Display title "VX.X BY TRICLON"
	LI a0, 0x48 //a0 is the X pos
	LI a2, text_title_2 //text pointer
	JAL FUNCTION_DISPLAY_TEXT //Print text
	LI a1, 0x0C //a1 is the y pos

	//Display "Z", "L", and "R for menu pages
	//Z
	LI a0, 0x00 //a0 is the X pos
	LI a2, text_Z //text pointer
	JAL FUNCTION_DISPLAY_TEXT //Print text
	LI a1, 0x25 //a1 is the y pos
	//L
	LI a0, 0x00 //a0 is the X pos
	LI a2, text_L //text pointer
	JAL FUNCTION_DISPLAY_TEXT //Print text
	LI a1, 0x19 //a1 is the y pos
	//R
	LI a0, 0x10B //a0 is the X pos
	LI a2, text_R //text pointer
	JAL FUNCTION_DISPLAY_TEXT //Print text
	LI a1, 0x20 //a1 is the y pos

	//Display text for page tab names
	//Items
	LI a0, 0x54 //a0 is the X pos
	LI a2, text_page_tab_items //text pointer
	JAL FUNCTION_DISPLAY_TEXT //Print text
	LI a1, 0x21 //a1 is the y pos
	//Game
	LI a0, 0x1E //a0 is the X pos
	LI a2, text_page_tab_game //text pointer
	JAL FUNCTION_DISPLAY_TEXT //Print text
	LI a1, 0x21 //a1 is the y pos
	//Bots
	LI a0, 0x97 //a0 is the X pos
	LI a2, text_page_tab_bots //text pointer
	JAL FUNCTION_DISPLAY_TEXT //Print text
	LI a1, 0x21 //a1 is the y pos
	//options
	LI a0, 0xC6 //a0 is the X pos
	LI a2, text_page_tab_options //text pointer
	JAL FUNCTION_DISPLAY_TEXT //Print text
	LI a1, 0x21 //a1 is the y pos

	// //If max HP is zero, set to 1
	// LHU a0, max_hp
	// BNE a0, zero, @@branch_hp_is_zero
	// 	LI a1, 9999
	// 	SH a1, max_hp
	// 	@@branch_hp_is_zero:


	// not s1, zero //Set boot flag
	// sb s1, boot_flag


	LW a0, 0x0028 (sp)
	LW a1, 0x002C (sp)
	LW a2, 0x0030 (sp)
	LW a3, 0x0034 (sp)
	LW ra, 0x0038 (sp)
	LW t6, 0x003C (sp)
	ADDI sp, sp, 0x48 



	J 0x80094bd8 //Jump back to after title screen hook
	NOP


//Function to blank a chunk of ram (needs to be double 0x8 aligned)
//a0 = start address
//a1 = end address
blankRam:
	SW zero, (a0)
	BNE a0, a1, blankRam
	ADDI a0, a0, 0x4
	JR ra
	NOP

//Function to detect if game is running in an emulator or not
//Run before blanking any ram in the expansion pak memory
//v0 = boolean that is 1 if on emulator, 0 if on console
detectEmulator:
	LW a0, 0x80700000 //Chunk of ram to check
	LI v0, 0 //Default return value
	BNE a0, zero, @@branch_emulator_detected
		NOP
		LI v0, 1
		@@branch_emulator_detected:
	JR ra
	NOP



//Set the course select menu to VS or Battle mode dependong on
//the circumstances
setCourseSelectVSorBattle:
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)

	LBU a0, player_count  //Grab number of players
	LI a1, 2 //If 2 players
	BNE a0, a1, @@branch_course_select_control_2p
		LUI a1, hi(0x800E86AD)
		LBU a0, lo(0x800E86AD) (a1)
		LI a1, 1 //If VS mode selected
		BNE a0, a1, @@branch_course_init_skip
			LI a1, 2 //Force VS mode to ensure course selection menu is correct
			LUI a0, 0x800E
			SH a1, 0xC53E (a0)
		BEQ zero, zero, @@branch_course_init_skip
		NOP
		@@branch_course_select_control_2p:
	LI a1, 3 //If 3 players
	BNE a0, a1, @@branch_course_select_control_3p
		LUI a1, hi(0x800E86AE)
		LBU a0, lo(0x800E86AE) (a1)
		BNE a0, zero, @@branch_course_init_skip  //If VS mode selected
			LI a1, 2 //Force VS mode to ensure course selection menu is correct
			LUI a0, 0x800E
			SH a1, 0xC53E (a0)
		BEQ zero, zero, @@branch_course_init_skip
		NOP
		@@branch_course_select_control_3p:
	LI a1, 4 //If 4 players
	BNE a0, a1, @@branch_course_select_control_4p
		LUI a1, hi(0x800E86AF)
		LBU a0, lo(0x800E86AF) (a1)
		BNE a0, zero, @@branch_course_init_skip  //If VS mode selected
			LI a1, 2 //Force VS mode to ensure course selection menu is correct
			LUI a0, 0x800E
			SH a1, 0xC53E (a0)
		@@branch_course_select_control_4p:
	@@branch_course_init_skip:

	JAL 0x8000262C//Run InitialMapselectSequence which was overwritten by the hook
	NOP
	LW ra, 0x20 (sp)
	JR RA
	ADDI sp, sp, 0x30


runAtCourseInitialization:
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)


	// //Load flag for capture the flag into segment 8
	// LI a1, theFlag
	// JAL SetSegment
	// LI a0, 8


	// //Test loading the flag into a course
	// LI a0, 0 //x position
	// LI a1, 5 //y position
	// LI a2, 0 //z position
	// LI a3, 0x0000 //rotation
	// //LI t6, 50 //flag
	// LI t6, 12 //item box
	// SW t6, 0x10 (sp) //Object ID (argument passing starts at offset of 0x10 in stack)
	// JAL CreateObjectSimple
	// NOP


	//Flatten courses
	LUI a0, hi(status_options_flatcourses)
	LBU a1, lo(status_options_flatcourses) (a0)
	BEQ a1, zero, @@branch_flatten_battle_courses
		LUI a1, 0x800E
		LUI a0, 0x3CCC
		SW a0, 0xC608 (a1)
	@@branch_flatten_battle_courses:




	//Turn on music in 3P/4P mode if set to on
	LBU a0, status_options_3P4Pmusic
	BEQ a0, zero, @@branch_3p4p_music_on
		LI a1, 0x240E0002
		SW a1, 0x8028EC9C
		LI a1, 0x24090002
		SW a1, 0x8028F9C4
		LBU a2, 0x800DC513 //Check if game has finished (0x800DC513==5)
		LI a3, 5
		BNE a2, a3, @@branch_3p4p_music_game_finished
			LUI a0, 0x803B
			SB zero, 0x03C3 (a0) //Disable BG music for all courses
			SW zero, 0x03C4 (a0)
			SH zero, 0x03C8 (a0)
			SB zero, 0x03CA (a0)
			SB zero, 0x03CF (a0)
			SH zero, 0x03D0 (a0)
			SB zero, 0x03D2 (a0)
		@@branch_3p4p_music_game_finished:
	@@branch_3p4p_music_on:


	//Default lose HP/balloons when falling off course, certain game modes might overwrite this
	LI a0, 0x0C01AE2D
	LUI a1, 0x8009
	SW a0, 0x0F78 (a1)
	//If respawn mode is on,  turn off losing balloons/HP when falling off course
	LBU a0, status_respawn
	BEQ a0, zero, @@branch_respawn_mode_on
		NOP
		SW zero, 0x0F78 (a1)
		@@branch_respawn_mode_on:



	//If game mode is traditional, and HP is <= 4, set the number of ballons displayed to be this and set the max balloons so that the game's own code can take care of that
	LUI a0, 0x8007 //Default zero out left and right baloons
	SW zero, 0xB82C (a0)
	SW zero, 0xB850 (a0)
	LBU a1, status_respawn
	BNE a1, zero, @@skip_balloon_display_code //If respawning is on, display only one balloon, and skip the rest of  this code
		LUI a0, 0x8007 //Default max balloon count to three
		LI a1, 2
		SH a1, 0xB86E (a0)
		LBU a0, score_mode //check if stock is on (not timed), and if it is on run the following code below
		BNE a0, zero, @@skip_balloon_display_code
			LBU a0, game_mode //Load game mode
			BNE a0, zero, @@skip_balloon_display_code //If game mode is traditional battle
				//HP = 1
				LHU a0, max_hp //Load max HP
				LI a1, 1
				BNE a0, a1, @@branch_hp_equals_1 //If HP == 1
					LUI a0, 0x8007 //Set max ballon count to one
					SH zero, 0xB86E (a0)
					@@branch_hp_equals_1:
				//HP = 2
				LHU a0, max_hp //Load max HP
				LI a1, 2
				BNE a0, a1, @@branch_hp_equals_2 //If HP == 2
					LI a0, 0x0C01A943 //Load instruction that causes balloons to load "JAL 0x8006A50C" into $a2
					LUI a1, 0x8007
					SW a0, 0xB82C (a1) //display left balloon
					LUI a0, 0x8007 //Set max balloon count to two
					LI a1, 1
					SH a1, 0xB86E (a0)
					@@branch_hp_equals_2:
				//HP = 3
				LHU a0, max_hp
				LI a1, 3
				BNE a0, a1, @@branch_hp_equals_3 //If HP == 3
					LI a0, 0x0C01A943 //Load instruction that causes balloons to load "JAL 0x8006A50C" into $a2
					LUI a1, 0x8007
					SW a0, 0xB82C (a1) //Display left balloon
					SW a0, 0xB850 (a1) //Display right balloon
					@@branch_hp_equals_3:
		@@skip_balloon_display_code:


	//Force all courses to load in battle mode
	//If starting a battle course, use default initialization, otherwise use big donut initialization
	LUI a0, 0x8004 //By default, do not force battle mode initialization for big donut
	LI a1, 0x01600008
	SW a1, 0xC1E8 (a0)
	LBU a1, 0x800DC5A1 //Load current track from cup course index 0x8018EE0B
	LI a0, 0x13 //Check if Big Donut, if it is, skip the rest of this
	BEQ a0, a1, @@branch_course_init_skip
	LI a0, 0x11 //Check if double deck, if it is, skip the rest of this
	BEQ a0, a1, @@branch_course_init_skip
	LI a0, 0x10 //check if Skyscraper, if it is, skip the rest of this
	BEQ a0, a1, @@branch_course_init_skip
	LI a0, 0xF //check if block Fort, if it is, skip the rest of this
	BEQ a0, a1, @@branch_course_init_skip
		LI a1, 0x0800F263 //Force battle mode initialization for Big Donut
		LUI a0, 0x8004
		SW a1, 0xC1E8 (a0)
	@@branch_course_init_skip:

	LI a1, 3 //Always Force battle mode upon course initialization
	LUI a0, 0x800E
	SH a1, 0xC53E (a0)


	JAL 0x80002A18//Run InitialRaceSequence which was overwritten by the hook
	NOP

	LW ra, 0x20 (sp)
	JR RA
	ADDI sp, sp, 0x30

// testThisHook:
// 	ADDI sp, sp, -0x30
// 	SW ra, 0x20 (sp)

// 	JAL FUNCTION_LOAD_FONT
// 	NOP

// 	LI a0, 0
// 	LI a1, 0
// 	LI a2, text_sudden_death
// 	JAL FUNCTION_DISPLAY_TEXT
// 	NOP

// 	LW ra, 0x20 (sp)
// 	JR ra
// 	ADDI sp, sp, 0x30

// // .align 0x10
// // .importobj "MarioKart.o"

// .align 0x10
// .importobj "Core/SharedFunctions.o"

// .align 0x10
// .importobj "Core/MarioKartObjects.o"

// .align 0x10
// .importobj "Core/MarioKart3D.o"


.align 0x10
DisplayHop:
MOVE  $a0, $s1
//JAL   DisplayObject
JAL DisplayFlag
MOVE  $a1, $s0
J     0x802A34D4
NOP

.align 0x10
CollisionHop:
LW    $t4, 0xbc($a3)
MOVE  $a0, $a3
LW    $ra, 0x1c($sp)
//JAL  CollideObject
JAL ObjectCollide
MOVE  $a1, $s0
J     0x802A0D44
LW    $ra, 0x1c($sp)


DisplayHopTable:
.word 0x802A31E4, 0x802A31FC, 0x802A3214, 0x802A32EC
.word 0x802A3318, 0x802A3330, 0x802A3348, 0x802A34C0
.word 0x802A3378, 0x802A34D4, 0x802A34D4, 0x802A34D4
.word 0x802A34D4, 0x802A3390, 0x802A33A4, 0x802A33B8
.word 0x802A33CC, 0x802A322C, 0x802A33E4, 0x802A34D4  //19
.word 0x802A34D4, 0x802A33FC, 0x802A34D4, 0x802A3428
.word 0x802A3244, 0x802A34D4, 0x802A325C, 0x802A328C
.word 0x802A32A4, 0x802A32BC, 0x802A32D4, 0x802A3274
.word 0x802A34D4, 0x802A3414, 0x802A34D4, 0x802A345C
.word 0x802A3440, 0x802A34AC, 0x802A3470, 0x802A3484  //39
.word 0x802A3360, 0x802A34D4, 0x802A3498, 0x802A3300
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word DisplayHop, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4 //59
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4  //79
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4 //99


CollisionJumpTable:
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09D4
.word 0x802A04E0, 0x802A063C, 0x802A0858, 0x802A04AC
.word 0x802A0968, 0x802A0D40, 0x802A0CBC, 0x802A0AA4
.word 0x802A0D40, 0x802A0D40, 0x802A0D40, 0x802A0D40
.word 0x802A0D40, 0x802A09B0, 0x802A0D40, 0x802A0D40 //19
.word 0x802A0D40, 0x802A098C, 0x802A0D40, 0x802A09B0
.word 0x802A09B0, 0x802A0D40, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A0D40, 0x802A0D40, 0x802A0D40, 0x802A0D40
.word 0x802A0D40, 0x802A0D40, 0x802A0D40, 0x802A0D40 //39
.word 0x802A0744, 0x802A0C34, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word CollisionHop, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0 //59
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0 //79
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0 //99

//Include binary file of the flag used for capture the flag
theFlag:
	.incbin "FlagData.raw.bin"//[,start[,size]]
	.import "FlagData.raw.bin"//[,start[,size]]


end_label:



.close
