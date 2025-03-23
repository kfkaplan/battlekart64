.n64

//.definelabel BattleSanta, 0 //Sets if Battlekart will be BattleSanta or regular BattleKart, commented=OFF, uncommented=ON

.ifdef BattleSanta
	.open "BattleSantaBase.z64", "BattleKart64.z64", 0 //Path to MK64 rom with mario sprite replaced with santa sprite
	.definelabel save_key, 0x8888999C //Value (2 bytes) to check for if save exists or not, update every new version
.else
	//.open "../Mario Kart 64.z64", "BattleKart64.z64", 0 //Path to the MK64 rom and output name of battle kart rom
	//.open "Farm.z64", "BattleKart64.z64", 0 //Path to the MK64 rom and output name of battle kart rom
	//.open "BattleFarm.z64", "BattleKart64.z64", 0 //Path to the MK64 rom and output name of battle kart rom
	//.open "BattleKart64Base.z64", "BattleKart64.z64", 0 //Path to the MK64 rom and output name of battle kart rom	
	// .open "BASE.z64", "BattleKart64.z64", 0 //Path to the MK64 rom and output name of battle kart rom	
	//.open "OverKart64 V6.z64", "BattleKart64.z64", 0
	// .open "battle.z64", "BattleKart64.z64", 0 //Path to the MK64 rom and output name of battle kart rom
	.open "Test.z64", "BattleKart64.z64", 0 //Path to the MK64 rom and output name of battle kart rom
	.definelabel save_key, 0x8888998C //Value (2 bytes) to check for if save exists or not, update every new version
.endif

//LibraryBUILD3 needs to be start of file
//.align 0x10
.include "../Library/LibraryBUILD1.asm"


.definelabel RAM_END, org(end_label) //For ../Library/OKHeader.asm


.definelabel ok_ModelDataRawSize, filesize("BattleKartObjects/ModelData.raw")
//.align 0x10
.include "../Library/GameVariables/NTSC/GameOffsets.asm"
.include "../Library/GameVariables/NTSC/StatsOffsets.asm"
.include "../Library/OKHeader.asm"
.include "../Library/GameVariables/NTSC/OKAssembly.asm"



.definelabel FlagModel, 0x08001350
.definelabel BaseModel, 0x08002BC0


//Overwrite name in rom header to be battle kart
.org 0x20
.asciiz "BATTLE KART 64 v3.0b8"


// //Bug check for collisionSphere
// .org 0x10A40C
// 	J bug_check
// .org 0x10A40C
// JAL MakeBKTest
// .org 0x10A40C
// JAL MakeBKTest




//Hooks for bomb for killbombkart for zombombs
.org 0xF9B64
	//JAL KillBombKartWrapper
	NOP
.org 0xF9B6C
	//JAL KillBombKartWrapper
	NOP
.org 0xF9BC4
	JAL KillBombKartWrapper
.org 0xF9C2C
	JAL KillBombKartWrapper




//Null out function displaying text which might be causing crash in 3 player CTF mode
.org 0x0F95DC
	NOP
//Null out function EraseInfo3P which was causing a crash when 3P mode goes to results
.org 0xF7AC0
	NOP
// .org 0x002950
// 	NOP
// .org 0x002984
// 	NOP


//.definelabel PAYLOAD_ROM, 		0x00D00000
//.definelabel PAYLOAD_RAM, 		0x80600000
.definelabel PAYLOAD_ROM, 		0x00D00000
.definelabel PAYLOAD_RAM, 		0x80400000//(overwrite code for GP mode cpus)

.definelabel DMA_MAX_LENGTH, 	org(end_label) - PAYLOAD_RAM
.definelabel VARIABLE_RAM_SIZE, 0x800 ////Place in ram to store all the battle kart variables (note: 0x2000 bytes large)
.definelabel VARIABLE_RAM_BASE,  org(VAR_RAM_START)
//.definelabel VARIABLE_RAM_BASE,  nicefont + 0x5000// 
.definelabel ROM_TO_RAM, 0x7ffff400
.definelabel RAM_TO_ROM, -0x7ffff400

/* In Game Functions */
.definelabel DrawRectangle, 0x80098DF8
.definelabel FUNCTION_PLAY_SOUND, 0x800C8E10
.definelabel FUNCTION_PLAY_MUSIC, 0x800C8EAC
.definelabel FUNCTION_LOAD_FONT, 0x80057710
.definelabel FUNCTION_DISPLAY_TEXT, 0x800577A4
.definelabel FUNCTION_DISPLAY_TEXT_AND_INT, 0x800577D0
.definelabel FUNCTION_DISPLAY_TEXT_AND_UINT, 0x80057814
.definelabel FUNCTION_FIND_ANGLE, 0x802B5224 //a0=x1 (pointer), a1=y1 (pointer), a2=x2 (pointer), a3=y2 (pointer), v0=returned angle
.definelabel FUNCTION_RNG, 0x802B7E34 //Random number generator, returns a random int16 in v0 between 0 and a0-1
.definelabel FUNCTION_MEMCOPY, 0x800D7FE0 //Like DMA but copy from ram -> ram, a0=output, a1=input, a2=length
//.definelabel executeItem, 0x802B2FA0  //Funciton that uses item, called as executeItem(car)
.definelabel makeBorder, 0x802A4300 //Function that draws borders between the player screens
.definelabel KartPosControlFull, 0x80028F70


.definelabel drivestickcontrol, 0x800382DC

.definelabel check_bump, 0x802ADDC8 //detect nearby walls
.definelabel checkTriangleZXV, 0x802AAE4C//Detect nearby walls
.definelabel CheckTriangleXYV, 0x802AB288//Detect nearby walls
.definelabel CheckTriangleYZV, 0x802AD278//Detect nearby walls

// //For changing balloon colors
// .definelabel BalloonColorArray, 0x800E4934
// .definelabel BalloonAdjustArray, 0x800E4954
// .definelabel BalloonColorArrayB, 0x800E4974
// .definelabel BalloonAdjustArrayB, 0x800E4994

/* Game variables */
.definelabel current_screen_state, 0x800DC513 //5 = results screen, 6 = force race to reset
.definelabel player_item_base, 0x80165F5F //Player has an item
.definelabel player_item_offset, 0xE0 //Offset between player item structures
.definelabel player_item_animation_base, 0x80165F5F //Player item animation is showing something
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
// .definelabel angle_p3, 0x800F856E
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
.definelabel insideMenu, 0x8018D9E3  //0x23 main 0x24 character 0x25 course 0 ingame
.definelabel scaleHeight, 0x800DC608 //Course scale height (float)
.definelabel inGameAffineMatrix, 0x801502c0 //The pointer for the affine matrix used in game
.definelabel drawTitleScreen, 0x80095574 //Draws the title screen?
.definelabel TexBuffLoadP2, 0x800996BC //Draw stuff to screen

// //Added for usb.c to work
// .definelabel memcpy, 0x800D7FE0
// .definelabel malloc, 0x802A7D1C

/* Battle Kart RAM */
.definelabel save_flag,  VARIABLE_RAM_BASE+0x00 //4 bytes, stores the save flag
.definelabel status_item_banana, VARIABLE_RAM_BASE+0x04 //item toggle (1=ON, 0=OFF)
.definelabel status_item_bananabunch, VARIABLE_RAM_BASE+0x05
.definelabel status_item_greenshell, VARIABLE_RAM_BASE+0x06
.definelabel status_item_threegreenshells, VARIABLE_RAM_BASE+0x07
.definelabel status_item_redshell, VARIABLE_RAM_BASE+0x08
.definelabel status_item_fakeitembox, VARIABLE_RAM_BASE+0x09
.definelabel status_item_star, VARIABLE_RAM_BASE+0x0A
.definelabel status_item_ghost, VARIABLE_RAM_BASE+0x0B
.definelabel status_item_autoitems, VARIABLE_RAM_BASE+0x0C
.definelabel status_item_infgshells, VARIABLE_RAM_BASE+0x0D
.definelabel MENU_Y_GAME, VARIABLE_RAM_BASE+0x0E
.definelabel MENU_Y_ITEMS, VARIABLE_RAM_BASE+0x0F
.definelabel MENU_Y_BOTS, VARIABLE_RAM_BASE+0x10
.definelabel MENU_Y_GRAPHICS, VARIABLE_RAM_BASE+0x11
.definelabel MENU_Y_OPTIONS, VARIABLE_RAM_BASE+0x12
.definelabel MENU_Y_PROGRESS, VARIABLE_RAM_BASE+0x13
.definelabel MENU_X_PROGRESS, VARIABLE_RAM_BASE+0x14
.definelabel bot_status_p1, VARIABLE_RAM_BASE+0x15 //Bot status (0=OFF, 1=Mario, 2=Luigi, 3= Peach, 4=Toad, 5=Yoshi, 6=DK, 7=Wario, 8=Bowser)
.definelabel bot_status_p2, VARIABLE_RAM_BASE+0x16
.definelabel bot_status_p3, VARIABLE_RAM_BASE+0x17
.definelabel bot_status_p4, VARIABLE_RAM_BASE+0x18
// .definelabel bot_run_away_flag_p1, VARIABLE_RAM_BASE+0x18 //1 byte, Bot run away flag (0=OFF (default) bots will attack rivals, 1=ON bots will run away from rivals)
// .definelabel bot_run_away_flag_p2, VARIABLE_RAM_BASE+0x19
// .definelabel bot_run_away_flag_p3, VARIABLE_RAM_BASE+0x1A
// .definelabel bot_run_away_flag_p4, VARIABLE_RAM_BASE+0x1B
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
.definelabel score_mode, VARIABLE_RAM_BASE+0x39 //Scoring mode 0=Stock, 1=Time, 2=Points)
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
.definelabel bot_rival_p1, VARIABLE_RAM_BASE+0x58 //Stores rival for each bot (0=P1, 1=P2, 2=P3, 3=P4)
.definelabel bot_rival_p2, VARIABLE_RAM_BASE+0x59
.definelabel bot_rival_p3, VARIABLE_RAM_BASE+0x5A
.definelabel bot_rival_p4, VARIABLE_RAM_BASE+0x5B
.definelabel final_lap_music_flag, VARIABLE_RAM_BASE+0x5C //1 byte -  Play "final lap music" flag whne timer is low (0=Not played, 1=Has played)
.definelabel final_sudden_death_music_flag, VARIABLE_RAM_BASE+0x5D //Play sudden music flag when timer is zero (0=Not played, 1=Has played)
.definelabel who_was_hit_last, VARIABLE_RAM_BASE+0x5E //Who was hit last (and the hot potato) (0=nobody, 1=P2, 2=P2, 3=P3, 4=P4)
.definelabel bots_target_humans,  VARIABLE_RAM_BASE+0x5F //1 byte, True = if all bots will favor targeting humans as rivals, False=default rival finding behavior
.definelabel team_1_score, VARIABLE_RAM_BASE+0x60 //2 bytes - Score for Team 1
.definelabel team_2_score, VARIABLE_RAM_BASE+0x62 //2 bytes - Score for Team 2
.definelabel max_points, VARIABLE_RAM_BASE+0x64 //2 bytes - Max team points (for team point score mode)
.definelabel bot_respawn_timer, VARIABLE_RAM_BASE+0x66 //2 bytes, timer for bots when they fall off the course and have to jump back
.definelabel bot_respawn_index,  VARIABLE_RAM_BASE+0x68 //1 byte, index into 3 element array for bot respawning (either = 0, 0xC, or 0x)
.definelabel bot_respawn_flag, VARIABLE_RAM_BASE+0x69 //1 byte, True = bots cannot fall off course, 0 = bots can fall off course
.definelabel bot_ai_type, VARIABLE_RAM_BASE+0x6A //1 byte, 0 = Normal with some tracking and some randomness, 1 = Seeker pure tracking, 2 = Random, no tracking
.definelabel bot_use_items,  VARIABLE_RAM_BASE+0x6B //1 byte, True = bots use items (on by default), 0 = they don't use items and are completely helpless
.definelabel course_start_flag, VARIABLE_RAM_BASE+0x6C //Flag to track that course has booted to run code in the inrace loop only once 0=course is loading, 1=course has loaded
.definelabel ffa_or_teams, VARIABLE_RAM_BASE+0x6D  //1 byte, free for all = 0, teams = 1
.definelabel hp_or_points,  VARIABLE_RAM_BASE+0x6F //1` byte, store if scoring is HP (=0) or points(=1)
// .definelabel hit_or_objective, VARIABLE_RAM_BASE+0x70 //1 byte, = 0 if game is scored using hits (score will be displayed as HP/hits), = 1 if game is objective based (score will be displayed as points)
.definelabel ctf_game_mode, VARIABLE_RAM_BASE+0x71  //1 byte, CTF game mode, 0=1 flag, 1=multiflag
//.definelabel ctf_score_mode, VARIABLE_RAM_BASE+0x94 
.definelabel ctf_game_started, VARIABLE_RAM_BASE+0x72 //1 byte, 0=Game has not started, 1=game has started
.definelabel no_items_when_holding_flag,  VARIABLE_RAM_BASE+0x73 //1 byte, 0=can have item when holding flag, 1=can't have item when holding flag
.definelabel slow_when_holding_flag, VARIABLE_RAM_BASE+0x74 //1 byte, 0=normal speed when holding flag, 1=lightning shrunk when holding flag
.definelabel one_player_full_screen, VARIABLE_RAM_BASE+0x75 //1 byte, 0=normal, 1=1 player full screen
.definelabel text_flicker_flag, VARIABLE_RAM_BASE+0x76 //1 byte, 0 or 1
.definelabel in_title_screen,  VARIABLE_RAM_BASE+0x77 //1 byte, 1 if you have been in title screen, 0 if not (going to the main menu sets it to zero)
.definelabel course_height, VARIABLE_RAM_BASE+0x78 //4 bytes, float that stores the course height at course initialization
.definelabel status_restore_defaults, VARIABLE_RAM_BASE+0x7E //1 byte, controles restoring defaults from the menu, 1 = are you sure?  2 = restore the defaults
.definelabel status_bombs_respawn, VARIABLE_RAM_BASE+0x7F //1 byte, stores if bombs can respawn or not in Zombombs game mode
.definelabel zombomb_startup_flag, VARIABLE_RAM_BASE+0x80 //1 byte, 0 if game hasn't started yet, 1 if it has started, resets at beginning of match, used to randomly select player to be a zombie
.definelabel who_won_zombombs,  VARIABLE_RAM_BASE+0x81 //1 byte, used to track if survivors or bombs won game, 0 if survivors won, 1 if zombombs won
.definelabel map_toggle_3p, VARIABLE_RAM_BASE+0x82 //1 byte, 0, minimap in 3P mode is on, 1 mimimap in 3 player mode is off
.definelabel map_button_down_3p, VARIABLE_RAM_BASE+0x83 //1 byte, store if the map toggling button was down or not
.definelabel map_x_3p, VARIABLE_RAM_BASE+0x84 //2 bytes, store the current x position of the map before it gets pushed off the screen
.definelabel bot_angle_p1, VARIABLE_RAM_BASE+0x86 //2 bytes, stores angle for bot to turn to
.definelabel bot_angle_p2, VARIABLE_RAM_BASE+0x88 //2 bytes, stores angle for bot to turn to
.definelabel bot_angle_p3, VARIABLE_RAM_BASE+0x8A //2 bytes, stores angle for bot to turn to
.definelabel bot_angle_p4, VARIABLE_RAM_BASE+0x8B //2 bytes, stores angle for bot to turn to]
.definelabel bot_timer_p1, VARIABLE_RAM_BASE+0x90 //Bot timer, 4 bytes
.definelabel bot_timer_p2, VARIABLE_RAM_BASE+0x94
.definelabel bot_timer_p3, VARIABLE_RAM_BASE+0x98
.definelabel bot_timer_p4, VARIABLE_RAM_BASE+0x9C
.definelabel shooter_health_p1, VARIABLE_RAM_BASE+0xA0 //2 bytes, health for shell shooter
.definelabel shooter_health_p2, VARIABLE_RAM_BASE+0xA4
.definelabel shooter_health_p3, VARIABLE_RAM_BASE+0xA8
.definelabel shooter_health_p4, VARIABLE_RAM_BASE+0xAC
.definelabel shooter_ammo_p1, VARIABLE_RAM_BASE+0xB0//2 bytes, ammo for shell shooter
.definelabel shooter_ammo_p2, VARIABLE_RAM_BASE+0xB4
.definelabel shooter_ammo_p3, VARIABLE_RAM_BASE+0xB8
.definelabel shooter_ammo_p4, VARIABLE_RAM_BASE+0xBC
.definelabel shooter_health_max, VARIABLE_RAM_BASE+0xC0
.definelabel shooter_ammo_max, VARIABLE_RAM_BASE+0xC4
.definelabel being_hit_lowers_score, VARIABLE_RAM_BASE+0xC8 //Set depending on options in menu, 0=Being hit doesn't lower your score, 1=Being hit lowers your score
.definelabel hitting_someone_raises_score, VARIABLE_RAM_BASE+0xC9 //Set depending on options in menu, 0=hitting someone does not rasie your score, 1=hitting someone raises your score
.definelabel p1_hit_by_star, VARIABLE_RAM_BASE+0xCA
.definelabel p2_hit_by_star, VARIABLE_RAM_BASE+0xCB
.definelabel p3_hit_by_star, VARIABLE_RAM_BASE+0xCC
.definelabel p4_hit_by_star, VARIABLE_RAM_BASE+0xCD
.definelabel MENU_TAB, VARIABLE_RAM_BASE+0xCE
.definelabel MENU_TAB_PROGRESS, VARIABLE_RAM_BASE+0xCF //Title menu y-axis movement in progress?  (0 = no, 1 = yes)
.definelabel MENU_Y_MAX, VARIABLE_RAM_BASE+0xD0 //Max distance you can move in y in menu
.definelabel who_hit_p1_last, VARIABLE_RAM_BASE+0xD1 //Who hit player last, 1 byte, used by shell shooter to properly determine score
.definelabel who_hit_p2_last, VARIABLE_RAM_BASE+0xD2
.definelabel who_hit_p3_last, VARIABLE_RAM_BASE+0xD3
.definelabel who_hit_p4_last, VARIABLE_RAM_BASE+0xD4
.definelabel startup_flag, VARIABLE_RAM_BASE+0xD5 //1 byte, flag to store if startup has run or not
.definelabel high_score, VARIABLE_RAM_BASE+0xD6 //2 bytes, variable to store a high score
.definelabel using_hle, VARIABLE_RAM_BASE+0xD8 //1 byte, flag to store if using emulator or not, to set render cull mode
.definelabel lag_fix, VARIABLE_RAM_BASE+0xD9 //1 byte, flag to store if emualtor lag fix is on or not
.definelabel max_coins, VARIABLE_RAM_BASE+0xDA //2 bytes, variable to store max number of coins (0 to 100)
.definelabel hit_coin_loss, VARIABLE_RAM_BASE+0xDC //2 bytes, variable to store number of coins dropped when hit
.definelabel status_first_person, VARIABLE_RAM_BASE+0xDE //1 byte, stores if first person camera mode is on or not
.definelabel respawning_flag_p1, VARIABLE_RAM_BASE+0xE0 //1 byte, stores if player is respawning or not to avoid lakitu contiuously picking a player up when respawning
.definelabel respawning_flag_p2, VARIABLE_RAM_BASE+0xE1 //1 byte, stores if player is respawning or not to avoid lakitu contiuously picking a player up when respawning
.definelabel respawning_flag_p3, VARIABLE_RAM_BASE+0xE2 //1 byte, stores if player is respawning or not to avoid lakitu contiuously picking a player up when respawning
.definelabel respawning_flag_p4, VARIABLE_RAM_BASE+0xE3 //1 byte, stores if player is respawning or not to avoid lakitu contiuously picking a player up when respawning


//NOTE EVERYTHING ABOVE HERE IS SAVED TO THE EPPROM, EVERYTHING BELOW IS NOT, SAVE IS FIRST 512 OR 0x200 BYTES
.definelabel bot_respawn_datastructure, VARIABLE_RAM_BASE+0x200 //3 x 4 bytes each = 12 bytes - Previous positions stored to teleport bots that fall off the map, a 3 element array 


/* Hooks */

//The following hooks and stuff force GP/time/VS mode kart stats 
//(e.g. top speed) to load when loading race courses
.org 0x002174
	JAL hijackdrivestickcontrol
.org 0x002420
	JAL hijackdrivestickcontrol
.org 0x0025C8
	JAL hijackdrivestickcontrol
.org 0x0027E0
	JAL hijackdrivestickcontrol
.org 0x039FC0
	J startSpawnPlayer
	NOP
.org 0x03A6DC
	J endSpawnPlayer
	NOP
.org 0x03A688 //Nop branch in spawnplayer that prevents balloons from loading when in a race course
	NOP

//Hook on top of InitCenterLine
.org 0x03DCB4
	J afterMapDataLoads


//Item reroll
.org 0x7BAD4
	J itemReroll

//Raise big donut to be higher when flat courses are on 
//Set up the hook inside scale height multiplier code
//.org 0x111D4C
.org 0x111DB0
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



// // // .org 0x038EDC// hook into beginning of DriveStickControl
// //.org 0x001628 //read controller hook
.org 0x038E48
	// JAL controllerLoop //Jump to custom code
	JAL botControlWrapper
	NOP

// .org 0x51F0
// JAL controllerLoop
// .org 0x344C
// JAL controllerLoop
// .org 0x349C
// JAL controllerLoop


// .org 0x120F4

//Hijack the execute_item function to prevent players holding flags in CTF mode from 
.org 0x11C890
	JAL hijackExecuteItem

//Hijack the makeBorder function so that it can be toggled on or off
.org 0x002A64
	JAL hijackMakeBorder

// //Hijack hit item box function
// //.org 0x10A2CC
// .org 0x10A328
// 	J hijackHitItemBox



//Hijack voice playing in collision_check_routin which denotes owner of an item, used for scoring
.org 0x109BCC
	JAL hijackItemHits
.org 0x109C34
	JAL hijackItemHits
.org 0x109D3C
	JAL hijackItemHits
.org 0x109E40
	JAL hijackItemHits
.org 0x109F60
	JAL hijackItemHits
.org 0x10A194
	JAL hijackItemHits
.org 0x10A200
	JAL hijackItemHits


//Hooks to hijack checks for  star to denote who used the star and give them a point
//in points scoring modes
.org 0x0F9C94
	J hijackStarCollisionCar1
.org 0x0F9CBC
	J hijackStarCollisionCar2



//Hook into squishing to actually apply proper scoring in squish mode
.org 0x08EDC0
	J hijackSetBrokenWhenSquished


//Everything below is to disable the options and data menus
// .org 0xB105C
// //DATA Controller
// JAL DataMenuController
//Disable the DATA menu
//Only loads the Background image
.org 0x9593C
.word 0x100001FC   //Hardcode Branch Command. 
NOP


//Disable Options/Data Menu Icons
.org 0x095D2C
NOP
.org 0x095D40
NOP


//This is a weird hack to disable the Game Select Menu's Option/Data Menu Toggles.
//It changes the button-check to an invalid value of unused bits- impossible to press.
.org 0x0B3806
.halfword 0x0080
.org 0x0B385E
.halfword 0x0080

// // overwrite boot function
// .org 0x17EC //RAM address 0x80000BEC
// 	LUI a0, hi(PAYLOAD_RAM) //RAM address
// 	LUI a1, hi(PAYLOAD_ROM)
// 	LUI a2, hi(DMA_MAX_LENGTH)
// 	JAL DMA_FUNC
// 	ADDIU a2, a2, lo(DMA_MAX_LENGTH)
// 	J OriginalBootFunction
// 	NOP



// //Test making green shells despawn when they hit a wall
// .org 0x11CF58 //ram location 0x802B3948
// 	//JAL 0x802AC098 //JAL killobject
// 	//MOVE a0, s0 //Move object pointer into A0 to pass to killobject
// 	J 0x802B3AC4
// 	NOP

/* Code to be DMAed (e.g. the rest of Battle Kart)*/

.headersize PAYLOAD_RAM - PAYLOAD_ROM
.org PAYLOAD_RAM



start_label:


/* Text */
.align 0x10

text_title_1: .asciiz "BATTLE KART 64"
text_title_2: .asciiz " v3.0b8 by Triclon"
text_Z: .asciiz "Z"
text_L: .asciiz "L"
text_R: .asciiz "R"
text_page_tab_items: .asciiz "ITEMS"
text_page_tab_game: .asciiz "GAME"
text_page_tab_bots: .asciiz "BOTS"
text_page_tab_gfx: .asciiz "GFX"
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
text_player: .asciiz "PLAYER"
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
text_hp_long: .asciiz "HP              "
text_timer: .asciiz "TIMER (MIN)     "
text_countdown: .asciiz "COUNTDOWN       "
text_angle: .asciiz "ANGLE: "
text_hit: .asciiz "HIT"
text_sudden_death: .asciiz "SUDDEN        DEATH"
text_semicolon: .asciiz ":"
text_semicolon_plus_zero: .asciiz ":0"
text_null: .asciiz "" //A blank spot that is just a null, used to display no text
text_team_points: .asciiz "TEAM POINTS"
text_team_time: .asciiz "TEAM TIME"
text_max_points: .asciiz "MAX POINTS      "
text_team: .asciiz "TEAM"
text_score: .asciiz "SCORE"
text_team_1_score: .asciiz "TEAM 1 SCORE"
text_team_2_score: .asciiz "TEAM 2 SCORE"
text_team_1_hp: .asciiz "TEAM 1 HP"
text_team_2_hp: .asciiz "TEAM 2 HP"
text_bots_cannot_Fall: .asciiz "BOTS CAN'T FALL"
text_bot_ai_type: .asciiz "BOT AI TYPE"
text_bot_ai_mixed: .asciiz "MIXED"
text_bot_ai_seeker: .asciiz "SEEKER"
text_bot_ai_random: .asciiz "RANDOM"
text_bot_use_items: .asciiz "BOTS USE ITEMS"
text_capture_the_flag: .asciiz "CAPTURE THE FLAG"
text_points: .asciiz "POINTS"
text_ctf_game: .asciiz "CTF GAME"
text_1_flag: .asciiz "1 FLAG"
text_multiflag: .asciiz "MULTIFLAG"
text_star: .asciiz "*"
text_hashtag: .asciiz "#"
text_ffa_or_teams: .asciiz "FFA/TEAMS"
text_teams: .asciiz "TEAMS"
text_ffa: .asciiz "FFA"
text_scr: .asciiz "SCR"
text_slow_with_flag: .asciiz "FLAG SLOWDOWN"
text_no_items_with_flag: .asciiz "FLAG NO ITEMS"
text_1p_full_screen: .asciiz "1P FULL SCREEN"
text_keep_away: .asciiz "KEEP AWAY"
text_team_1: .asciiz "TEAM 1"
text_team_2: .asciiz "TEAM 2"
text_p1: .asciiz "P1"
text_p2: .asciiz "P2"
text_p3: .asciiz "P3"
text_p4: .asciiz "P4"
text_restore_defaults: .asciiz "RESET SETTINGS"
text_restore_defaults_are_you_sure: .asciiz "RESET SETTINGS   (ARE YOU SURE?)"
text_zombombs: .asciiz "ZOMBOMBS"
text_bombs_respawn: .asciiz "BOMBS RESPAWN"
text_char_mario: .asciiz "MARIO"
text_char_luigi: .asciiz "LUIGI"
text_char_yoshi: .asciiz "YOSHI"
text_char_toad: .asciiz "TOAD"
text_char_dk: .asciiz "DK"
text_char_wario: .asciiz "WARIO"
text_char_peach: .asciiz "PEACH"
text_char_bowser: .asciiz "BOWSER"
text_bombs_win: .asciiz "BOMBS WIN"
text_survivors_win: .asciiz "SURVIVORS WIN"
text_shell_shooter: .asciiz "Shell SHOOTER"
//text_presents: .asciiz "PRESENTS"
text_coins: .asciiz "COINS"
text_minus_one_when_hit: .asciiz "-1 WHEN HIT"
text_plus_one_hit_enemy: .asciiz "+1 HIT ENEMY"
text_team_1_wins: .asciiz "TEAM 1 WINS"
text_team_2_wins: .asciiz "TEAM 2 WINS"
text_max_health: .asciiz "MAX HEALTH      "
text_max_ammo: .asciiz "MAX AMM0        "
text_using_hle: .asciiz "USING HLE"
text_target_humans: .asciiz "TARGET HUMANS"
text_lag_fix: .asciiz "LAG FIX"
text_max_coins: .asciiz "TOTAL COINS     "
text_hit_coin_loss: .asciiz "HIT COIN LOSS   "
text_first_person: .asciiz "FIRST PERSON"


.align 0x10

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
	ADDI sp, sp, -0x40
	SW ra, 0x20 (sp)
	sw a0, 0x24 (sp)
	sw a1, 0x28 (sp)
	sw a2, 0x2C (sp)
	sw a3, 0x30 (sp)
	// //Run emulator check and store result in t9
	// JAL detectEmulatorOldVersion
	// NOP
	// MOVE t9, v0
	//First blank the ram
	LI a0, VARIABLE_RAM_BASE //Blank ram block start
	LI a1, VARIABLE_RAM_BASE + VARIABLE_RAM_SIZE //Blank ram block end
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
	sb a0, ctf_game_started
	sb a0, using_hle
	SB zero, bot_ai_type //Set bot default AI to be seeker
	li a1, 3
	SH a1, max_hp
	li a1, 0x8CBC //Set default time limit to 10 minutes
	SW a1, max_timer
	li a1, 1800 //Set default countdown for hot potato to 30 seconds (times 60 FPS)
	sh a1, hotpotato_countdown_default
	LI a1, 10 //Set default max team points to 10
	SH a1, max_points
	LI.s f1, 5.0 //Set default shell shooter health (float)
	MFC1 a1, f1
	SW a1, shooter_health_max
	LI.s f1, 50.0 //Set default shell shooter ammo (float)
	MFC1 a1, f1
	SW a1, shooter_ammo_max
	LI a1, 40 //Set default max coins for coin mode to be 40
	SH a1, max_coins
	LI a1, 5 //Set default coins lost on hit
	SH a1, hit_coin_loss
	LI a0, save_key //Store save key in the save flag, if game hasn't saved yet
	SW a0, save_flag
	// BNE t9, zero, @@branch_set_fps 
	// 	LI a0, 3
	// 	SB a0, status_options_tempo
	// 	@@branch_set_fps:
	LW ra, 0x20 (sp)
	lw a0, 0x24 (sp)
	lw a1, 0x28 (sp)
	lw a2, 0x2C (sp)
	lw a3, 0x30 (sp)

	JR ra
	ADDI sp, sp, 0x40



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
	NOP


	// //Set top speed for 50, 100, and 140 CC since the battle mode top speed is a snail's pace
	// LBU a1, 0x800DC54B //Load current CCs
	// BNE a1, zero, @@branch_50cc //If 50 CC, set top speed to 43910000 - 290
	// 	NOP
	// 	LI a2, 0x4391
	// @@branch_50cc:
	// LI a3, 1
	// BNE a1, a3, @@branch_100cc //If 100 CC, set top speed to 439B0000 - 310
	// 	NOP
	// 	LI a2, 0x439B
	// @@branch_100cc:
	// LI a3, 2
	// BNE a1, a3, @@branch_150cc //If 150 CC, set top speed to 43A00000 - 320
	// 	NOP
	// 	LI a2, 0x43A0
	// @@branch_150cc:
	// LI a3, 3
	// BNE a1, a3, @@branch_extra //If extra mode, top speed is same as 100 CC, so set top speed to 439B0000 - 310
	// 	NOP
	// 	LI a2, 0x439B
	// @@branch_extra:
	// LUI a0, 0x800F //Update top speeds for four players
	// SH a2, 0x6BA4 (a0)
	// SH a2, 0x797C (a0)
	// LUI a0, 0x8010
	// SH a2, 0x8754 (a0)
	// SH a2, 0x952C (a0)

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
	//J 0x802A8740
	JR RA
	NOP






//Write a bit of custom code to ensure the item function rerolls if an item is zeroed out (ie. turned off)
itemReroll:

	//If game mode is shell shooter, zero out item and skip 
	LB a0, game_mode
	LI a1, 6
	BEQ a0, a0, @@branch_check_if_shell_shooter
		NOP
		LI v1, 0 //Zero out item
		j 0x8007AF2C //resume code
		nop
		@@branch_check_if_shell_shooter:
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
	LBU a0, status_options_tempo //Load game tempo menu option	
	LW a1, 0x80150114 //Load game tempo to subtract from timer, this is the default
	BEQ a0, zero, @@branch_game_tempo_option_on //If game tempo is set on in the menu, use that tempo instead
		LI a2, 5
		SUB a1, a2, a0
		@@branch_game_tempo_option_on:
	JR ra
	SUB a3, a3, a1 //Subtract game tempo

//This function increments a timer (e.g. time score timer or hot potato battle countdown) based on the game tempo
//a3 is both the input and output ofr the timer to decrement
incrementTimer:
	LBU a0, status_options_tempo //Load game tempo menu option	
	LW a1, 0x80150114 //Load game tempo to subtract from timer, this is the default
	BEQ a0, zero, @@branch_game_tempo_option_on //If game tempo is set on in the menu, use that tempo instead
		LI a2, 5
		SUB a1, a2, a0
		@@branch_game_tempo_option_on:
	JR ra
	ADD a3, a3, a1 //Subtract game tempo


//This function returns the tempo
getTempo:
	ADDI sp, sp, -0x30
	SW a0, 0x20 (sp)
	SW a1, 0x24 (sp)
	SW a2, 0x28 (sp)
	LBU a0, status_options_tempo //Load game tempo menu option	
	LW v0, 0x80150114 //Load game tempo, this is the default
	BEQ a0, zero, @@branch_game_tempo_option_on //If game tempo is set on in the menu, use that tempo instead
		LI a2, 5
		SUB v0, a2, a0
		@@branch_game_tempo_option_on:
	LW a0, 0x20 (sp)
	LW a1, 0x24 (sp)
	LW a2, 0x28 (sp)
	JR ra
	ADDI sp, sp, 0x30


//Wrap decrement timer in a function for c
//a0 == input
//v0 == output
decrementTimerWrapper:
	ADDI sp, sp, -0x30
	SW ra, 0x0020 (sp)
	JAL decrementTimer
	MOVE a3, a0
	LW ra, 0x0020 (sp)
	MOVE v0, a3
	JR ra //Jump back
	ADDI sp, sp, 0x30

//Wrap decrement timer in a function for c
//a0 == input
//v0 == output
incrementTimerWrapper:
	ADDI sp, sp, -0x30
	SW ra, 0x0020 (sp)
	JAL incrementTimer
	MOVE a3, a0
	LW ra, 0x0020 (sp)
	MOVE v0, a3
	JR ra //Jump back
	ADDI sp, sp, 0x30

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

	// //Only get a new rival some portion of the time
	// JAL FUNCTION_RNG //Run RNG and return "enemy" in v0
	// LI a0, 4 //25% chance of finding a new rival
	// BNE v0, zero, @@branch_getEnemy_continue
	// 	LW a1, -0x14 (sp) //Get memory address for rival (note I am adding 0x50 t0 0x3C for the offset)
	// 	LBU v0, 0x0000 (a1)
	// 	BEQ zero, zero, @@branch_skip
	// 	NOP
	// 	@@branch_getEnemy_continue:

	@@branch_rerun_rng:
	JAL FUNCTION_RNG //Run RNG and return "enemy" in v0
	LI a0, 4
	LI a2, 0xDD8
	MULT v0, a2
	LI a1, 0x800F6990 //Check if selected player is alive
	MFLO a2
	ADDU a1, a1, a2
	LBU a1, 0x0000 (a1)
	LI a0, 0xC0
	BNE a1, a0, @@branch_rerun_rng //Check if RNG returned a player who is dead, if so, reroll
	ADDI a1, v0, 1
	LW a0, 0x0020 (sp)
	BEQ v0, a0, @@branch_rerun_rng //Check if RNG returned current player, if it is, reroll
	NOP
	LBU a0, ffa_or_teams //If game is in team scoring mode, ensure
	BNE a0, zero, @@branch_team_scoring_mode
	NOP
	BEQ zero, zero, @@skip_team_scoring_mode
		@@branch_team_scoring_mode:
		LW a0, 0x20 (sp) //Grab current player
		slti a2, v0, 2 //True if rival is on team 1, flase if on team two
		slti a1, a0, 2 //True if on team 1, false if on team 2
		BEQ a1, a2, @@branch_rerun_rng //If current player and chosen rival on the same team, reroll
		NOP
	@@skip_team_scoring_mode:

	//LI v0, 0//Force target to be player 1 for the moment
	
	@@branch_skip:

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

//Check if player has an item or not
//Inputs
//a0 = player to check
//Returns
//v0 = True if an item is found, false if not
checkItems:
	LI a1, player_item_offset //#Calculate and add offset for current player
	MULT a1, a0
	//LI v0, player_item_base //Load base for player has an item memory loc.
	LI v0, player_item_animation_base //Load base for player has an item animation going memory loc.
	LBU a3, player_count_2 //IF player count is 3 or 4, add 0x1C0 to their item mem location
	LI a2, 3
	MFLO a0
	BNE a3, a2, @@branch_add_3or4player_offset
	ADDU a0, v0, a0 //Store total offset for player for item memory location
		ADDIU a0, a0, 0x1C0
		@@branch_add_3or4player_offset:
	JR RA
	LB v0, 0x0000 (a0)


//Given two players, this function returns the angle between them
//Inputs
//a0 = player to compare to (1,2,3,4)
//a1 = first player (1,2,3,4)
//returns
//v0 = angle
getAngle:
	ADDI sp, sp, -0x40
	SW ra, 0x0028 (sp)
	//SW a0, 0x002C (sp)
	//SW a1, 0x0030 (sp)
	SW a2, 0x0034 (sp)
	SW a3, 0x0038 (sp)
	//ADDI a0, a0, -1 //Subtract 1 from player numbers so that 0 counts as player 1
	//ADDI a1, a1, -1
	LI a2, 0xDD8 //Multiply by 0xDD8 so that a0 and a1 become the offsets between the first and second players to compare
	MULT a0, a2
	MFLO a0
	MULT a1, a2 
	LI a2, 0x800F69A4 //Set a0 and a1 to be pointers for the positions of the first and second players
	ADDU a0, a2, a0 //Pointer to second player's x coordinate (z is found automatically)
	MFLO a1
	JAL FUNCTION_FIND_ANGLE //Call built in arctan2 function
	ADDU a1, a2, a1 //Pointer to first player's x coordinate (z is found automatically)
	SUB v0, zero, v0 //Mirror angle
	//ADDI v0, v0, 0x8000 //Phase by 180 degrees so that angle points inward instead of outward
	LW ra, 0x0028 (sp)
	//LW a0, 0x002C (sp)
	//LW a1, 0x0030 (sp)
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
	SW zero, 0x0048 (sp) //Flag if player has flipped or not

	
	
	//Set pointer for current bot rival
	LI a1, bot_rival_p1 //Get byte to store rival pointer
	ADD a1, a1, a0
	SW a1, 0x3C (sp) //Store rival pointer
	//Set player structure offset and store in t5
	LI a1, player_state_offset //Load player structure offset
	MULT a1, a0 //multiply current player number by structure offset
	//Set pointer for current player battle bot and store state in v0 (inside the mult to save on cycles)
	LI v0, bot_status_p1
	ADD v0, v0, a0
	SW v0, 0x38 (sp)
	//Continue the mult
	MFLO a0
	SW a0, 0x40 (sp) //Store result in stack


	// //Copy coordinates into data structure for teleporting back to land if bot falls off course
	// //LW a0, 0x0040 (sp)
	// LBU a1, bot_respawn_flag
	// BEQ a1, zero, @@branch_no_fall
	//   	LUI t0, hi(0x800F6A5A) //If falling over nothingness (pit or off the course)
	//   	ADDU t0, t0, a0
	//   	LBU a1, lo(0x800F6A5A) (t0) 
	// 	ANDI a1, a1, 0x1
	// 	BEQ a1, zero, @@branch_no_fall
	// 		 //Copy x,y,z coords from data structure
	// 		LI a1, bot_respawn_player_offset
	// 		LW a3, 0x0020 (sp)
	// 		MULT a1, a3
	// 		LBU a2, bot_respawn_index
	// 		LI a0, bot_respawn_datastructure
	// 		ADDI a2, a2, 0xC
	// 		MFLO a3
	// 		DIV a2, a1
	// 		ADDU a0, a0, a3
	// 		LW a3, 0x0040 (sp)
	// 		LI a1, 0x800F69A4 //paste coordinates to teleport character back
	// 		ADDU a1, a1, a3


	// 		LUI t4, hi(angle_p1) //flip kart angle
	// 		ADDU t4, t4, a3
	// 		LH a2, lo(angle_p1) (t4)
	// 		ADDI a2, a2, 0x8000
	// 		SH a2, lo(angle_p1) (t4)

	// 		LI a2, 1 //Store flag that kart angle was flipped
	// 		SW a2, 0x0048 (sp)

	// 		MFHI a2
	// 		ADDU a0, a0, a2
	// 		LW t1, 0x0000 (a0) //This is where the copying and pasting of coordinates happens
	// 		LW t2, 0x0004 (a0)
	// 		LW t3, 0x0008 (a0)
	// 		SW t1, 0x0000 (a1)
	// 		SW t2, 0x0004 (a1)
	// 		SW t3, 0x0008 (a1)


	// 		SB zero, lo(0x800F6A5A) (t0) //Set byte to no longer falling
	// 	@@branch_no_fall: //If no longer falling


	//Give bots auto items
	LBU a0, status_item_infgshells //If inf. green shells are off, randomly assign items
	LUI a2, hi(0x802BA290)
	BNE a0, zero, @@branch_skip_bot_auto_items
		LW v0, 0x20 (sp)
		LI a1, player_item_offset //#Calculate and add offset for current player
		MULT a1, v0
		LBU a2, lo(0x802BA290) (a2) //Load byte from RNG into a2
		SRA a2, a2, 1 //Divide RNG value by 2 to double the probability of getting an item
		LI a0, player_item_base //Load base for player has an item memory loc.
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
	LW t5, 0x40 (sp)
	LI a0, player_collision_base //Load mem location of player 1 speed
	ADDU a0, a0, t5 //Add offset to player 1 speed mem location
	LBU a0, 0x0000 (a0) //Load byte that stores if wall collision is occuring or not
	ANDI a0, a0, 0x8 //Check byte 0x8 to see if wall collision is occuring or not
	BEQ a0, zero, @@branch_hitting_a_wall
	LW t2, 0x38 (sp) //Load timer
		SB zero, 0x4 (t2) //Set timer to zero
		SB zero, 0x8 (t2) //Set current bot state to "going straight", this combined with the timer being zero will force the bot to turn
		JAL FUNCTION_RNG //#Iniate steering, call the RNG for a value between 1 and 2 and store in the player state
		LI a0, 2
		ADDI v0, v0, 1 //add 1 to the result from the RNG
		LW t2, 0x38 (sp)
		SB v0, 0x8 (t2) //Store player steering state back to ram
		JAL FUNCTION_RNG //Call RandomInt funciton to grab a new number for the timer
		LI a0, 0x8
		// LI a0, 0x12
		// ADDI v0, v0, 0x9 //add constant to result from RNG			
		LW t2, 0x38 (sp)
		ADDI v0, v0, 0x18 //add constant to result from RNG
		SB v0, 0x4 (t2) //Store player timer back to ram (this is in delay slot)
		// //flip kart angle
		// LW a0, 0x0048 (sp) //Load flag to check if kart has flipped yet or not
		// BNE a0, zero, @@branch_hitting_a_wall
		// 	LUI a1, hi(angle_p1) 
		// 	ADDU a1, a1, t5 //Add offset to player 
		// 	LH a0, lo(angle_p1) (a1)
		// 	ADDI a0, a0, 0x8000
		// 	SH a0, lo(angle_p1) (a1)
		// 	//Reduce speed
		// 	LUI a1, hi(g_player1SpeedU2)
		// 	ADDU a1, a1, t5 //Add offset to player structure
		// 	L.S F2, lo(g_player1SpeedU2) (a1) //Load address into floating point register
		// 	LI.S F4, 0.85 //Load 0.5 into register
		// 	MUL.S F2, F2, F4 //Reduce speed by the above factor
		// 	S.S F2, lo(g_player1SpeedU2) (a1) //Store register into address
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
		//JAL getEnemy //Randomly find a rival
		JAL getRival //Randonmly find a rival, but also go after flag carriers
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
		LW t2, 0x38 (sp) //Need to reload t2
		LBU a0, 0x8 (t2) //Load current turning state of player into a0
		BNE a0, zero, @@branch_turning //If player is currently traveling straight
			LBU a0, bot_ai_type
			LI a1, 1
			BEQ a0, a1, @@branch_turning //If bot AI set to "seeker", ignore turning and immediately continue going "straight"
				NOP
				JAL FUNCTION_RNG //#Iniate steering, call the RNG for a value between 1 and 2 and store in the player state
				LI a0, 2
				LW t2, 0x38 (sp)
				ADDI v0, v0, 1 //add 1 to the result from the RNG
				SB v0, 0x8 (t2) //Store player steering state back to ram
				@@branch_seeker:
			JAL FUNCTION_RNG //Call RandomInt funciton to grab a new number for the timer
			LI a0, 0x10
			ADDI v0, v0, 0xC //add constant to result from RNG
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
		//LI a0, 0x68
		//ADDI v0, v0, 0x40 //add a constant to the result from the RNG
		//LI a0, 0x60
		//ADDI v0, v0, 0x60 //add a constant to the result from the RNG
		LW t2, 0x38 (sp)
		ADDI v0, v0, 0x70 //add a constant to the result from the RNG
		SB v0, 0x4 (t2) //store payer timer back to ram




		@@branch_timer_run_out:

	//Bot controller input

	
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


			//Check if CTF mode 
			LBU a0, game_mode
			LI a1, 3
			BNE a0, a1, @@branch_bot_playing_ctf
				LW a0, 0x20 (sp) //Get current bot 
				JAL isPlayerHoldingFlag //Run function to determine if bot is holding flag
				NOP
				BEQ v0, zero, @@branch_bring_flag_to_base_ctf //If player is not holding the flag, skip the rest of this
				LW a0, 0x20 (sp) //Get current bot 
					JAL angleToBase
					NOP
					BEQ zero, zero, @@branch_go_straight //Once this is over, skip the rest of the "go straight" code 
					MOVE a3, v0 //Copy returned angle to a3
					@@branch_bring_flag_to_base_ctf:
				JAL isSomeoneHoldingPlayerFlag //If someone is holding player's flag, skip going after flags/bases and go after the person holding the flag
				NOP
				BNE v0, zero, @@branch_bot_playing_ctf
				LW a0, 0x20 (sp) //Get current bot 
				JAL isTeamMemberHoldingFlag //If team member is holding a flag, skip the rest of this code to go after rivals from the other team
				NOP
				BNE v0, zero, @@branch_bot_playing_ctf
				LW a0, 0x20 (sp) //Get current bot 			
				//If bot is holding no flag, send bot to go grab rival's flag
				LW a1, 0x3C (sp) //Load rival
				JAL angleToFlag
				LBU a1, 0x0000 (a1)
				BEQ zero, zero, @@branch_go_straight //Once this is over, skip the rest of the "go straight" code 
				MOVE a3, v0 //Copy returned angle to a3
				@@branch_bot_playing_ctf:

			//Check if Keep away mode
			LBU a0, game_mode
			LI a1, 4
			BNE a0, a1, @@branch_bot_playing_keep_away //Check if current bot is holding a flag
				LW a0, 0x20 (sp) //Get current bot 
				JAL isPlayerHoldingFlag //Run function to determine if bot is holding flag
				NOP
				BEQ v0, zero, @@branch_run_away //If player is not holding the flag, skip the rest of this
				LW a0, 0x20 (sp) //Get current bot
				JAL isTeamMemberHoldingFlag //If team member is holding a flag, skip the rest of this code to go after rivals from the other team
				NOP
				BNE v0, zero, @@branch_bot_playing_keep_away
				LW a0, 0x20 (sp) //Get current bot 		
					LW a1, 0x3C (sp)
					JAL getAngle //Find angle between current player and rival
					LBU a1, 0x0000 (a1) //Get rival
					LW t5, 0x40 (sp)
					LI t0, 0x800F69BE//Find current player's turn angle
					ADDU t0, t0, t5
					LHU t8, 0x0000 (t0) //Grab current player's turn angle and store in t8
					SUB t2, v0, t8 //claculate difference in angle between bot and rival
					SRA t2, t2, 8 //convert half to a byte
					ADDI t2, t2, 0x80 //Phase angle by 30%
					ANDI t2, t2, 0xFF //Take the modulous so range in angle only 0->255 by grabbing only the first byte in the register using andi (see https://stackoverflow.com/questions/32927039/how-to-get-individual-bytes-from-a-register-in-mips-assembly)
					//LI t0, 0x100 //Take the modulous so range in angle only 0->255
					//DIVU t2, t0
					//MFHI t2
					SLTIU a1, t2, 0x80
					BNE a1, zero, @@branch_run_away //turn other direction towards rival
					LI a3, 0x34  //turn one direction towards rival
						LI a3, -0x34
					BEQ zero, zero, @@branch_go_straight //Once this is over, skip the rest of the "go straight" code 
					NOP
					@@branch_run_away:
				//If player is not holding the flag, and flag is just on the course, do this
				LW t0, playerHoldingFlag
				LI a1, -1
				BNE t0, a1, @@branch_bot_playing_keep_away
					LW a0, 0x20 (sp) //Get current bot 
					JAL angleToFlag
					LI a1, 0 //Set flag to go after to zero
					BEQ zero, zero, @@branch_go_straight //Once this is over, skip the rest of the "go straight" code 
					MOVE a3, v0 //Copy returned angle to a3
				@@branch_bot_playing_keep_away:


			LW a0, 0x20 (sp) //Get current bot
			//LI a0, bot_rival_p1 //Grab address for current bot rival
			//ADD a0, a0, a1 
			LW a1, 0x3C (sp)
			JAL getAngle //Find angle between current player and rival
			LBU a1, 0x0000 (a1) //Get rival

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
			// LI t0, 0x100 //Take the modulous so range in angle only 0->255
			// DIVU t2, t0
			// MFHI t2
			ANDI t2, t2, 0xFF //Take the modulous so range in angle only 0->255 by grabbing only the first byte in the register using andi (see https://stackoverflow.com/questions/32927039/how-to-get-individual-bytes-from-a-register-in-mips-assembly)


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


	LI a2, bot_controller_input_p1
	//LI a0, 4 //Offset per player in controller input
	LW v0, 0x20 (sp)
	//MULT a0, v0 //Multiply current player by offset per player
	//MFLO a0
	SLL v0, v0, 2 //Multiply by four for current player by offset per player
	ADD a2, a2, v0 //Store total offset for player for controller input
	//SW a2, 0x38 (sp)

	//Go foward by alwasy pressing A
	//LI a0, 0x80
	//SB a0, 0x0 (a2)


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


//This function kills all players
killAllPlayers:
	ADDI sp, sp, -0x40 //store registers
	SW a0, 0x0020 (sp) 
	SW ra, 0x0030 (sp)
	JAL killPlayer
	LI a0, 0
	JAL killPlayer
	LI a0, 1
	JAL killPlayer
	LI a0, 2
	JAL killPlayer
	LI a0, 3
	LW ra, 0x0030 (sp)
	LW a0, 0x0020 (sp)
	JR RA
	ADDI sp, sp, 0x40 


//This function kills a player
//A0 = player to kill
killPlayer:
	ADDI sp, sp, -0x30 //store registers
	SW a0, 0x0020 (sp) //store current player in stack
	SW a1, 0x0024 (sp)
	SW a2, 0x0028 (sp)
	SW t5, 0x002C (sp)
	LI a1, balloon_count_p1 //Set balloons to -1 to kill player
	ADDU a1, a1, a0
	ADDU a1, a1, a0
	LH t5, 0x0000 (a1)
	LI a2, -1
	BEQ a2, t5, @@branch_kill_player //If player is not yet dead
		NOP
		SH a2, 0x0000 (a1) //kill player
		LI a2, player_state_offset //Calculate offset between player structures
		MULT a0, a2
		LI a1, 0x800F699C
		LI a2, 0x04 //Turn player into a bomb/invisible
		MFLO t5
		ADDU a1, a1, t5
		SB a2, 0x0000 (a1) //Store initially at 800F699C for P1
		ADDIU a1, a1, 1
		LI a2, 0x40 //Explode the player
		SB a2, 0x0000 (a1) //Store initially at 800F699D for P1	
		@@branch_kill_player:
	LW a0, 0x0020 (sp) //store current player in stack
	LW a1, 0x0024 (sp)
	LW a2, 0x0028 (sp)
	LW t5, 0x002C (sp)
	JR RA
	ADDI sp, sp, 0x30 

//This function turns a player into a bomb without necessarily killing them (used in Zombombs)
//A0 = player to turn into a bomb
makePlayerBomb:
	LI a2, player_state_offset //Calculate offset between player structures
	MULT a0, a2
	ADDI sp, sp, -0x30 //store registers
	SW a0, 0x0020 (sp) //store current player in stack
	SW ra, 0x0024 (sp)
	LUI a1, hi(0x800F699C)
	//LI a2, 0x50
	MFLO a0
	ADDU a1, a1, a0
	LBU a3, lo(0x800F6991) (a1) //Bomb status, bit 0x40
	LBU a0, lo(0x800F6A4E) (a1) //Star status, bit 0x02
	ANDI a3, a3, 0x40 //Is player a bomb?
	ANDI a0, a0, 0x02 //Is player using a star?
	OR a3, a3, a0
	BNE a3, zero, @@branch_turn_player_into_bomb //If player is not yet a bomb or using a star, turn them into a bomb
		LI a2, 0x4
		SB a2, lo(0x800F699C) (a1)
		JAL bombSpeedup //Up the top the speed of a player turned into a bomb
		LW a0, 0x20 (sp)
		@@branch_turn_player_into_bomb:
	LW ra, 0x0024 (sp)
	JR RA
	ADDI sp, sp, 0x30


//This function displays the timer when in time scoring
displayTimer:
	//Check if score mode is time, if not just jump back

	LBU a1, score_mode
	// LBU a0, game_mode
	// LI a2, 5
	// BEQ a0, a2, @@branch_run_time_scoring
	// NOP
	LI a2, 1
	BEQ a1, a2, @@branch_run_time_scoring //If time scoring is on
		NOP
		JR ra //Jump back if score mode is stock or team points
		NOP
		@@branch_run_time_scoring:

	//Store Registers
	ADDI sp, sp, -0x40
	//Load timer and store it in the stack
	LW a3, timer
	SW ra, 0x20 (sp)
	//Set y position for timer
	LBU a0, one_player_full_screen
	SW a3, 0x24 (sp)
	BEQ a0, zero, @@branch_set_y_position_for_timer
	LI a1, 0x60 //Default y position
		LI a1, 0xCA //y position for timer if 
		@@branch_set_y_position_for_timer:
	SW a1, 0x30 (sp)


	//When the timer runs out, run function to kill all players but the one with the lowest number of hits
	SLTI a0, a3, 1 //If timer <= 0
	BEQ a0, zero, @@branch_timer_less_than_zero
		//Display "SUDDEN DEATH" on screen
		LI a2, text_sudden_death //text pointer
		LI a0, 0x3C //x position
		JAL FUNCTION_DISPLAY_TEXT
		LW a1, 0x30 (sp) //yposition
		//BREAK Jump back
		LW ra, 0x20 (sp)
		JR ra
		ADDI sp, sp, 0x40
		@@branch_timer_less_than_zero:
	//Run the timer code
	JAL decrementTimer //Function to decrement timer
	NOP
	LI a1, 3600 //Divide timer by 3600 to get minutes
	DIV a3, a1
	SW a3, timer //Store decremented timer
	LI a1, 60 //Divide the remainder by 60 to convert it to seconds
	MFLO a3 //Grab timer minutes
	SW a3, 0x24 (sp) //store minutes in the stack
	MFHI a3 //Get the modulus (e.g. remainder) of when the timer was divided by minutes above for later use in calculating seconds
	DIV a3, a1
	LI a0, 0x50 //x position
	LI a2, text_time //text pointer
	LW a1, 0x30 (sp) //yposition
	MFLO a3
	SW a3, 0x28 (sp) //Store seconds to the stack
	//Display the text "TIMER" and minutes
	JAL FUNCTION_DISPLAY_TEXT_AND_INT
	LW a3, 0x24 (sp) //Load timer minutes from the stack


	// //Display semicolon and extra zero in seconds if needed
	LW a3, 0x24 (sp) //Load timer minutes from stack
	SLTI t1, a3, 10
	BNE t1, zero, @@branch_timer_gt_10_min //If minutes > 10, move colon over a bit
	LI a0, 0xB0 //Default x position
		ADDI a0, a0, 8 //Moved x position over slightly
		@@branch_timer_gt_10_min:
	LW a3, 0x28 (sp) //Load seconds from stack
	LI a2, text_semicolon //Text pointer for semicolon
	SLTI t1, a3, 10
	BEQ t1, zero, @@branch_timer_lt_10_sec //If seconds < 10
		NOP
		LI a2, text_semicolon_plus_zero //Set text pointer to semicolon plus a zero
		@@branch_timer_lt_10_sec:
	JAL FUNCTION_DISPLAY_TEXT 
	LW a1, 0x30 (sp) //y position
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
	LW a1, 0x30 (sp) //y position
	//Play final song music if timer is running out
	LBU a1, final_lap_music_flag //Load flag for if "final song" has played or not
	BNE a1, zero, @@branch_final_lap_song //if the final flag song has not been played yet
		LW a3, timer //Load timer	
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
	ADDI sp, sp, 0x40


//Display the final results (hits or HP) on the results screen after each battle
displayResults:
	//Store registers
	ADDI sp, sp, -0x40
	SW ra, 0x20 (sp)
	//Load number of players and store in stack
	LBU a3, player_count
	SW a3, 0x28 (sp)
	//Initialize font
	JAL FUNCTION_LOAD_FONT
	NOP

	//Display results for zombombs
	LBU a0, game_mode
	LI a1, 5 //value for zombombs game mode
	BNE a0, a1, @@branch_display_results_for_zombombs
		LBU v0, who_won_zombombs
		BEQ v0, zero, @@branch_display_bombs_win //Display text when bombs win
			LI a2, text_bombs_win
			LI a0, 0x68 //x
			JAL FUNCTION_DISPLAY_TEXT
			LI a1, 0x60//y
			BEQ zero, zero, @@branch_skip_disp_results
			NOP
			@@branch_display_bombs_win:
		LI a2, text_survivors_win //Display text when suvivors win
		LI a0, 0x5C //x
		JAL FUNCTION_DISPLAY_TEXT
		LI a1, 0x60//y
		BEQ zero, zero, @@branch_skip_disp_results
		NOP
		@@branch_display_results_for_zombombs:


	//Display team scores (if in teams mode)
	LBU t6, ffa_or_teams
	// LBU t7, hp_or_points
	BEQ t6, zero, @@branch_is_teams
		LUI a1, 0x8000
		LBU a0, 0x0335 (a1) //In 3P mode, copy P1 results to P2
		SB a0, 0x0336 (a1)
		LBU a0, 0x0338 (a1) //In 4P mode, copy P1 results to P2
		SB a0, 0x0339 (a1)
		LBU a0, 0x033A (a1) //In 4P mode, copy P3 results to P4
		SB a0, 0x033B (a1)
		
		LBU a0, score_mode //Store HP or SCORE text pointer in stack depending on game mode
		BNE a0, zero, @@set_teams_results_score_text_to_hp
			NOP
			LI a2, text_hp
			@@set_teams_results_score_text_to_hp:
		BEQ a0, zero, @@set_teams_results_score_text_to_score
			NOP
			LI a2, text_score
			@@set_teams_results_score_text_to_score:
		SW a2, 0x2C (sp)

		LW a3, 0x28 (sp)
		LI a0, 3
		BNE a3, a0, @@branch_show_team_results_3p //Display results for teams in 3P mode
			LW a2, 0x2C (sp) //Display score for team 1
			LH a3, team_1_score
			LI a0, 0x48
			JAL FUNCTION_DISPLAY_TEXT_AND_INT
			LI a1, 0x5C
			LW a2, 0x2C (sp)  //Display score for team 2
			LH a3, team_2_score 
			LI a0, 0xBC
			JAL FUNCTION_DISPLAY_TEXT_AND_INT
			LI a1, 0x5C
			LH v0, team_1_score //Display which team wins
			LH v1, team_2_score
			SLT v0, v1, v0 //Figure out if Team 1 or Team 2 won
			BEQ v0, zero, @@branch_show_team1_won_3p
				NOP
				LI a0, 0x38 //x position
				LI a2, text_team_1_wins
				@@branch_show_team1_won_3p:
			BNE v0, zero, @@branch_show_team2_won_3p
				NOP
				LI a0, 0xAE //x position
				LI a2, text_team_2_wins
				@@branch_show_team2_won_3p:
			JAL FUNCTION_DISPLAY_TEXT
			LI a1, 0x66 //y position\
			@@branch_show_team_results_3p:
		LW a3, 0x28 (sp)
		LI a0, 4
		BNE a3, a0, @@branch_show_team_results_4p ////Display results for teams in  4P mode
			LW a2, 0x2C (sp) //Display score for team 1
			LH a3, team_1_score
			LI a0, 0x2C
			JAL FUNCTION_DISPLAY_TEXT_AND_INT
			LI a1, 0x5C
			LW a2, 0x2C (sp) //Display score for team 2
			LH a3, team_2_score 
			LI a0, 0xB6
			JAL FUNCTION_DISPLAY_TEXT_AND_INT
			LI a1, 0x5C
			LH v0, team_1_score //Display which team wins
			LH v1, team_2_score
			SLT v0, v1, v0 //Figure out if Team 1 or Team 2 won
			BEQ v0, zero, @@branch_show_team1_won_4p
				NOP
				LI a0, 0x18 //x position
				LI a2, text_team_1_wins
				@@branch_show_team1_won_4p:
			BNE v0, zero, @@branch_show_team2_won_4p
				NOP
				LI a0, 0xA4 //x position
				LI a2, text_team_2_wins
				@@branch_show_team2_won_4p:
			JAL FUNCTION_DISPLAY_TEXT
			LI a1, 0x66 //y position
			@@branch_show_team_results_4p:
		// LBU t8, hit_or_objective
		// BEQ t8, zero, @@branch_is_team_points //If score is objective, just display the team score and jump back here
		// 	NOP 	//Jump back
		// 	BEQ zero, zero, @@branch_skip_disp_results
		// 	NOP
		// 	@@branch_is_team_points:



		BEQ zero, zero, @@branch_skip_disp_results
		NOP			
		@@branch_is_teams:
	//Load text pointer "HP" or "HIT" and store in stack
	LBU v0, score_mode
	BNE t6, zero, @@branch_check_to_display_hp //If not teams....
		LBU a0, game_mode
		BNE a0, zero, @@branch_check_to_display_hp //If game is traditional battle game mode
			NOP
			BNE v0, zero, @@branch_check_to_display_hp //If traditional battle and max hp <= 3, do not display anything
				LHU a1, max_hp
				SLTI a1, a1, 4 //If max HP > 3
				//AND a0, a0, zero //If game mode is traditional
				XOR a0, a1, a0
				BEQ a0, zero, @@branch_check_to_display_hp
					NOP
					BEQ zero, zero, @@branch_skip_disp_results //Just skip displaying the results if that is the case
					NOP
		@@branch_check_to_display_hp:
	LI a2, text_hp //Text pointer for "HP" (default)
	BEQ v0, zero, @@branch_score_mode_is_timer_or_points
		NOP
		LI a2, text_scr ///Text pointer for "PTS"
		@@branch_score_mode_is_timer_or_points:
	// BEQ v0, zero, @@branch_score_mode_is_timer //If score mode is timer
	// LBU t6, ffa_or_teams
	// 	LI a2, text_hit ///Text pointer for "HIT"
	// 	@@branch_score_mode_is_timer:
	// BEQ t6, zero, @@branch_display_hits_for_teams //If team scoring, default to "HITS" since there is no individual HP
	// LBU t8, hit_or_objective
	// 	LI a2, text_hit ///Text pointer for "HIT"
	// 	@@branch_display_hits_for_teams: 
	// BEQ t8, zero, @@branch_scoring_is_points //If scoring is objective (e.g. an objective based game mode)
	// 	NOP
	// 	LI a2, text_scr ///Text pointer for "PTS"
	// 	@@branch_scoring_is_points:
	SW a2, 0x24 (sp)
	//Display results for 2P mode
	LW a3, 0x28 (sp)
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
	LW a3, 0x28 (sp)
	LI a0, 3
	BNE a3, a0, @@branch_show_results_3p
		LI a0, 0x22 //x position
		LI a1, 0x12 //y position
		LH a3, p1_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P1
		LW a2, 0x24 (sp) //Load text pointer
		LI a0, 0x70 //x position
		LI a1, 0x12 //y position
		LH a3, p2_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P2
		LW a2, 0x24 (sp) //Load text pointer
		LI a0, 0xBE //x position
		LI a1, 0x12 //y position
		LH a3, p3_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P3
		LW a2, 0x24 (sp) //Load text pointer
		@@branch_show_results_3p:
	//Display results for 4P mode
	LW a3, 0x28 (sp)
	LI a0, 4
	BNE a3, a0, @@branch_show_results_4p
		LI a0, 0x8 //x position
		LI a1, 0x12 //y position
		LH a3, p1_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P1
		LW a2, 0x24 (sp) //Load text pointer
		LI a0, 0x4D //x position
		LI a1, 0x12 //y position
		LH a3, p2_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P2
		LW a2, 0x24 (sp) //Load text pointer
		LI a0, 0x92 //x position
		LI a1, 0x12 //y position
		LH a3, p3_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P3
		LW a2, 0x24 (sp) //Load text pointer
		LI a0, 0xD7 //x position
		LI a1, 0x12 //y position
		LH a3, p4_score //int to display
		JAL FUNCTION_DISPLAY_TEXT_AND_INT //Display results for P4
		LW a2, 0x24 (sp) //Load text pointer
		@@branch_show_results_4p:
	@@branch_skip_disp_results:

	@@branch_not_team_mode:

	//Disable background music (fix for 3&4 P background music
	LBU a0, status_options_3P4Pmusic
	BEQ a0, zero, @@branch_3p4p_music_on	
		LUI a0, 0x803B
		SB zero, 0x03C3 (a0) //Disable BG music for all courses
		SW zero, 0x03C4 (a0)
		SH zero, 0x03C8 (a0)
		SB zero, 0x03CA (a0)
		SB zero, 0x03CF (a0)
		SH zero, 0x03D0 (a0)
		SB zero, 0x03D2 (a0)
		@@branch_3p4p_music_on:

	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x40
	//




//This function increments the score, either individual or teams, for use with certain game modes
//a0 = player or team to incrementm, 0=P1, 1=P2, 2=P3, 3=P4
incrementScore:
	LBU a1, ffa_or_teams
	BNE a1, zero, @@branch_increment_individual_scores //Increment individual scores
		NOP
		LI v0, p1_score //Load P1 score memory address as base
		@@branch_increment_individual_scores: //Increment team scores
	BEQ a1, zero, @@branch_increment_team_scores
		NOP
		LI v0, team_1_score
		SRA a0, a0, 1 //Divide a0 by two so P1 and P2 are team 1 and P3 and P4 are team 2
		@@branch_increment_team_scores:
	SLL a0, a0, 1  //Double player or team number to get offset for score
	ADDU v0, v0, a0 //Add offset to base
	LH v1, 0x0000 (v0) //Load player or team's score
	ADDI v1, v1, 1 //Increment score + 1
	JR RA //Jump back
	SH v1, 0x0000 (v0) //Store player or team's score back to ram

//This function changes the score (usually to subtract using negative numbers), either individual or teams, for use with certain game modes
//a0 = player or team to incrementm, 0=P1, 1=P2, 2=P3, 3=P4
//a1 = value to change score by
changeScore:
	LBU v1, ffa_or_teams
	BNE v1, zero, @@branch_increment_individual_scores //Increment individual scores
		NOP
		LI v0, p1_score //Load P1 score memory address as base
		@@branch_increment_individual_scores: //Increment team scores
	BEQ v1, zero, @@branch_increment_team_scores
		NOP
		LI v0, team_1_score
		SRA a0, a0, 1 //Divide a0 by two so P1 and P2 are team 1 and P3 and P4 are team 2
		@@branch_increment_team_scores:
	SLL a0, a0, 1  //Double player or team number to get offset for score
	ADDU v0, v0, a0 //Add offset to base
	LH v1, 0x0000 (v0) //Load player or team's score
	ADD v1, v1, a1 //Change score by a1
	JR RA //Jump back
	SH v1, 0x0000 (v0) //Store player or team's score back to ram

//This function gets the score, either individual or teams, for use with certain game modes
//a0 = player or team to incrementm, 0=P1, 1=P2, 2=P3, 3=P4
getScore:
	LBU a1, ffa_or_teams
	BNE a1, zero, @@branch_increment_individual_scores //Increment individual scores
		NOP
		LI v0, p1_score //Load P1 score memory address as base
		@@branch_increment_individual_scores: //Increment team scores
	BEQ a1, zero, @@branch_increment_team_scores
		NOP
		LI v0, team_1_score
		SRA a0, a0, 1 //Divide a0 by two so P1 and P2 are team 1 and P3 and P4 are team 2
		@@branch_increment_team_scores:
	SLL a0, a0, 1  //Double player or team number to get offset for score
	ADDU v0, v0, a0 //Add offset to base
	JR RA //Jump back
	LH v0, 0x0000 (v0) //Load player or team's score

//This function checks if a player is hit, mostly for dropping the flag in CTF mode
//See old Death Race code for details
//a0 = player or team to incrementm, 0=P1, 1=P2, 2=P3, 3=P4
//returns v0 = 0 player not hit, 1 player is hit
check_if_hit:
	LI a1, player_state_offset
	MULT a0, a1
	LI v0, 0 //v0 stores if player is hit (or not), here we initialize it to zero
	LUI a1, hi(0x800F6A4C) //Check various tumbles
	MFLO a0 //a0 stores the offset to the current player
	ADD a1, a1, a0
	LBU a2, lo(0x800F6A4C) (a1)
	ANDI a3, a2, 0x7
	BEQ a3, zero, @@branch_check_tumble_bits
	//LUI a1, hi(0x800F6A4E) //check spinouts and directional tumbles (delay branch)
	LHU a2, lo(0x800F6A4E) (a1)
		LI v0, 1
		@@branch_check_tumble_bits:
	//ADD a1, a1, a0
	//LHU a2, lo(0x800F6A4E) (a1)
	ANDI a3, a2, 0x04C0
	BEQ a3, zero, @@branch_check_spinouts_and_directional_tumble_bits
	//LUI a1, hi(0x800F6A5B) //check if out of bounds, in water, or picked up by Lakitu for any reason (delay branch)
	LBU a2, lo(0x800F6A5B) (a1)
		LI v0, 1
		@@branch_check_spinouts_and_directional_tumble_bits:
	//ADD a1, a1, a0
	BEQ a2, zero, @@branch_check_out_of_bounds
		NOP
		LI v0, 1
		@@branch_check_out_of_bounds:
	JR ra //Jump back
	NOP


// //Check if hit by bomb
// //a0 = player, 0=P1, 1=P2, 2=P3, 3=P4
// //returns v0 = 0 player not hit bomb, 1 player is hit by bomb
// checkHitBomb:
// 	LI a1, player_state_offset
// 	MULT a0, a1
// 	//LI v0, 0 //v0 stores if player is hit (or not), here we initialize it to zero
// 	LUI a1, hi(0x800F699C)
// 	MFLO a0 //a0 stores the offset to the current player
// 	ADD a1, a1, a0
// 	LHU a1, lo(0x800F699C) (a1)
// 	// BNE a1, zero, @@branch_check_bomb_hit
// 	// 	NOP
// 	// 	LI v0, 1
// 	// 	@@branch_check_bomb_hit:
// 	JR ra
// 	//ANDI v0, a1, 0x01 //Check if bomb hit
// 	ANDI v0, a1, 0x0040 //Check if bomb hit

//This function displays SCORE, HP or "HITS" for some battle modes
displayScore:
	ADDI sp, sp, -0x30//Store registers
	LBU a3, player_count
	SW ra, 0x20 (sp)
	LBU v0, ffa_or_teams
	SW a3, 0x24 (sp) //Store player count in stack for easy retrieval
	BNE v0, zero, @@branch_team_scoring
			LBU v1, score_mode
			BNE v1, zero, @@branch_score_mode_is_hits
				NOP
				LI a2, text_hp //Text pointer for "HP" (default)
				// BEQ v0, zero, @@branch_score_mode_is_timer //If score mode is stock
				// 	NOP
				// 	LI a2, text_scr ///Text pointer for "SCR"
				// 	@@branch_score_mode_is_timer:
				@@branch_score_mode_is_hits:
			BEQ v1, zero, @@branch_score_mode_is_time_or_points
				NOP
				LI a2, text_scr
				@@branch_score_mode_is_time_or_points:
			LBU a0, one_player_full_screen
			SW a2, 0x28 (sp) //Store text pointer in stack for later retrieval
			BNE a0, zero, @@branch_ffa_scoring_1p_full_screen //If not in 1P full screen mode, dispaly the scores in each player's screemn
				//Display HP/HIT for P1
				LI a0, 0x0 //x position
				LH a3, p1_score //Int to display
				JAL FUNCTION_DISPLAY_TEXT_AND_INT
				LI a1, 0x0 //y position
				//Display HP/HIT for P2
				LI a0, 0x0 //x position (default)
				LI a1, 0x72 //y position (default)
				LW a3, 0x24 (sp) //Load player count
				LI a2, 2
				BEQ a3, a2, @@branch_disp_p2_number_of_players_not_2 //If number of players is not 2, move position to upper right
					NOP
					LI a0, 0xE2 //x position
					LI a1, 0x0 //y position
					@@branch_disp_p2_number_of_players_not_2:
				LH a3, p2_score //Int to display
				JAL FUNCTION_DISPLAY_TEXT_AND_INT
				LW a2, 0x28 (sp) //text pointer
				//Display HP/HIT for P3
				LW a3, 0x24 (sp) //Load player count
				LI a2, 2
				BEQ a3, a2, @@branch_disp_p3_score //If number of players is not 2, display player 3
					LI a0, 0x0 //x position
					LI a1, 0x72 //y position
					LH a3, p3_score //int to display
					JAL FUNCTION_DISPLAY_TEXT_AND_INT
					LW a2, 0x28 (sp) //text pointer
					@@branch_disp_p3_score:
				//Display HP/HIT for P4
				LW a3, 0x24 (sp) //Load player count
				LI a2, 4
				BNE a3, a2, @@branch_disp_p4_score //If number of players is 4, display P4's score
					LI a0, 0xE2 //x position
					LI a1, 0x72 //y position
					LH a3, p4_score //int to display
					JAL FUNCTION_DISPLAY_TEXT_AND_INT
					LW a2, 0x28 (sp) //text pointer
					@@branch_disp_p4_score:
				BEQ zero, zero, @@branch_done_displaying_score
				NOP
			@@branch_ffa_scoring_1p_full_screen: //If in 1P full screen mode, display scores in corner of screen
				//Display P1 score
				LI a0, 0x00 //x position
				LI a2, text_p1
				JAL FUNCTION_DISPLAY_TEXT
				LI a1, 0x00 //y position
				LI a0, 0x18 //x position
				LI a1, 0x00 //y position
				LH a3, p1_score //Int to display
				JAL FUNCTION_DISPLAY_TEXT_AND_INT
				LW a2, 0x28 (sp) //text pointer
				// //Display P2 score
				LI a0, 0x00 //x position
				LI a2, text_p2
				JAL FUNCTION_DISPLAY_TEXT
				LI a1, 0x0C //y position
				LI a0, 0x18 //x position
				LI a1, 0x0C //y position
				LH a3, p2_score //Int to display
				JAL FUNCTION_DISPLAY_TEXT_AND_INT
				LW a2, 0x28 (sp) //text pointer
				// Display P3
				LW a3, 0x24 (sp) //Load player count
				LI a2, 2
				BEQ a3, a2, @@branch_disp_p3_score_in_1p_fullscreen //If number of players is not 2, display player 3
					LI a0, 0x00 //x position
					LI a2, text_p3
					JAL FUNCTION_DISPLAY_TEXT
					LI a1, 0x18 //y position
					LI a0, 0x18 //x position
					LI a1, 0x18 //y position
					LH a3, p3_score //Int to display
					JAL FUNCTION_DISPLAY_TEXT_AND_INT
					LW a2, 0x28 (sp) //text pointer
					@@branch_disp_p3_score_in_1p_fullscreen:
				//Display P4
				LW a3, 0x24 (sp) //Load player count
				LI a2, 4
				BNE a3, a2, @@branch_disp_p4_score_in_1p_fullscreen //If number of players is 4, display P4's score
					LI a0, 0x00 //x position
					LI a2, text_p4
					JAL FUNCTION_DISPLAY_TEXT
					LI a1, 0x24 //y position
					LI a0, 0x18 //x position
					LI a1, 0x24 //y position
					LH a3, p4_score //Int to display
					JAL FUNCTION_DISPLAY_TEXT_AND_INT
					LW a2, 0x28 (sp) //text pointer
					@@branch_disp_p4_score_in_1p_fullscreen:
				BEQ zero, zero, @@branch_done_displaying_score
				NOP
		//Else if branch is team scoring
		@@branch_team_scoring:
			// LBU a0, hit_or_objective
			// BNE a0, zero, @@branch_calculate_team_scores //If game is hit based, calculate the team scores
			// 	LUI a3, hi(p1_score)
			// 	LH a0, lo(p3_score) (a3) //Calculate team 1 score
			// 	LH a1, lo(p4_score) (a3)
			// 	ADDU v0, a1, a0 
			// 	LH a0, lo(p1_score) (a3) //Calculate team 2 score
			// 	LH a1, lo(P2_score) (a3)
			// 	SH v0, lo(team_1_score) (a3) //Store team scores
			// 	ADDU v1, a1, a0 
			// 	SH v1, lo(team_2_score) (a3)
			// @@branch_calculate_team_scores:

			LBU a0, one_player_full_screen
			BNE a0, zero, @@branch_team_scoring_1p_full_screen //If not in 1P full screen mode, dispaly the scores in each player's screemn
				LBU t9, score_mode
				BNE t9, zero, @@branch_team_hp_text //Display HP instead of SCORE if in stock scoring mode
					LI a0, 0x84 //x position //Top
					LI a2, text_hp
					JAL FUNCTION_DISPLAY_TEXT
					LI a1, -0xC //y position
					LI a0, 0x84 //x position //Bottom
					LI a2, text_hp
					JAL FUNCTION_DISPLAY_TEXT
					LI a1, 0xC2 //y position
					@@branch_team_hp_text:
				LBU t9, score_mode
				BEQ t9, zero, @@branch_team_score_text
					LI a0, 0x77 //x position //Top
					LI a2, text_score
					JAL FUNCTION_DISPLAY_TEXT
					LI a1, -0xC //y position
					LI a0, 0x77 //x position //Bottom
					LI a2, text_score
					JAL FUNCTION_DISPLAY_TEXT
					LI a1, 0xC2 //y position
					@@branch_team_score_text:



				// LI a0, 0x77 //x position
				// LI a2, text_score
				// BNE t8, zero, @@branch_team_2_hp_or_score_text //Display HP instead of SCORE if in stock scoring mode
				// 	NOP
				// 	LI a0, 0x82 //x position
				// 	LI a2, text_hp
				// 	@@branch_team_2_hp_or_score_text:
				// JAL FUNCTION_DISPLAY_TEXT
				// LI a1, 0xC2 //y position
				
				// //LUI a2, hi(text_score)
				// LI a2, text_score
				// 	NOP
				// 	LI a0, 0x82 //x position
				// 	LI a2, text_hp
				// 	@@branch_team_1_hp_or_score_text:
				// JAL FUNCTION_DISPLAY_TEXT
				// LI a1, -0xC //y position





				LI a0, 0x7B //x position
				LI a2, text_null //text pointer
				LH a3, team_1_score
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



				LI a0, 0x7B //x position
				LI a2, text_null //text pointer
				LH a3, team_2_score
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
				LI a1, 0xCC //y position	
				BEQ zero, zero, @@branch_done_displaying_score
				NOP
			@@branch_team_scoring_1p_full_screen:
				LBU t9, score_mode
				BNE t9, zero, @@branch_fullscreen_team_hp_text //Display HP instead of SCORE if in stock scoring mode
					LI a0, 0x20 //x position		
					LI a2, text_team_1_hp
					LH a3, team_1_score
					JAL FUNCTION_DISPLAY_TEXT_AND_INT
					LI a1, 0x0 //y position
					LI a0, 0xA0 //x position		
					LI a2, text_team_2_hp
					LH a3, team_2_score
					JAL FUNCTION_DISPLAY_TEXT_AND_INT
					LI a1, 0x0 //y position
					@@branch_fullscreen_team_hp_text:
				LBU t9, score_mode
				BEQ t9, zero, @@branch_fullscreen_team_score_text //Display score instead of HP if not in stock scoring mode
					LI a0, 0x0 //x position		
					LI a2, text_team_1_score
					LH a3, team_1_score
					JAL FUNCTION_DISPLAY_TEXT_AND_INT
					LI a1, 0x0 //y position
					LI a0, 0xA0 //x position		
					LI a2, text_team_2_score
					LH a3, team_2_score
					JAL FUNCTION_DISPLAY_TEXT_AND_INT
					LI a1, 0x0 //y position

					@@branch_fullscreen_team_score_text:

	@@branch_done_displaying_score:

	//decrement hit by star bytes until they reach zero, this avoids
	//the double counting 
	LI a0, p1_hit_by_star
	LBU a1, 0x0000 (a0)
	BEQ a1, zero, @@branch_p1_hit_by_star_decrement
		ADDI a1, a1, -1
		SB a1, 0x0000 (a0)
		@@branch_p1_hit_by_star_decrement:
	LBU a1, 0x0001 (a0)
	BEQ a1, zero, @@branch_p2_hit_by_star_decrement
		ADDI a1, a1, -1
		SB a1, 0x0001 (a0)
		@@branch_p2_hit_by_star_decrement:
	LBU a1, 0x0002 (a0)
	BEQ a1, zero, @@branch_p3_hit_by_star_decrement
		ADDI a1, a1, -1
		SB a1, 0x0002 (a0)
		@@branch_p3_hit_by_star_decrement:
	LBU a1, 0x0003 (a0)
	BEQ a1, zero, @@branch_p4_hit_by_star_decrement
		ADDI a1, a1, -1
		SB a1, 0x0003 (a0)
		@@branch_p4_hit_by_star_decrement:


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
	SW a2, 0x28 (sp)
	//SW a3, 0x2C (sp)
	//LBU a2, hp_or_points //Check if stock is on (not timed), and if it is on, check if player has HP=0
	LBU a2, score_mode
	SW a1, 0x24 (sp)	
	BNE a2, zero, @@branch_check_if_zero_hp
		//Load current player's HP
		LI a1, p1_score
		SLL a2, a0, 1 //Multiply a0 by 2
		ADDU a1, a1, a2
		LH a2, 0x0000 (a1)
		//Kill player if their HP = 0
		BNE a2, zero, @@branch_kill_player_if_hp_zero
			NOP
			JAL killPlayer
			NOP
			@@branch_kill_player_if_hp_zero:
		@@branch_check_if_zero_hp:
	//Load registers and jump back
	LW ra, 0x1C (sp)
	LW a0, 0x20 (sp)
	LW a1, 0x24 (sp)
	LW a2, 0x28 (sp)
	//LW a3, 0x2C (sp)
	JR ra
	ADDI sp, sp, 0x30


//This function processes respawning
//$A0 = player to respawn H, P1 = 0, P2 = 1, P3 =2, P4 = 4
processRespawn:
	LUI a1, hi(respawning_flag_p1) //Check if player already respawned
	ADD a1, a1, a0
	LBU a2, lo(respawning_flag_p1) (a1)
	BEQ a2, zero, @@player_respawning
		NOP
		SB zero, lo(respawning_flag_p1) (a1) //Turn off respawn flag but don't yet respawn
		@@player_respawning:



	BNE a2, zero, @@player_not_respawned
		LI a2, 0xFF
		sb a2, lo(respawning_flag_p1) (a1) //Store true in respawn flag
		LI a1, player_state_offset //Get player state mem address for forcing lakitu to respawn player
		MULT a0, a1
		LUI a1, 0x800F
		LI a3, 1 //Set bits for respawning
		MFLO a2
		ADD a1, a1, a2
		// BEQ zero, zero, @@processRespawn_skip_to_end
		SB a3, 0x6A5B (a1)
		@@player_not_respawned:
	// SB zero, lo(respawning_flag_p1) (a1) //Set respawn flag to zero if already respawned
	// @@processRespawn_skip_to_end:
	JR RA
	NOP


//This function processes hits and decrements 1 HP
//$A0 = player to decrement HP for, P1 = 0, P2 = 1, P3 =2, P4 = 3
processHit:
	//Store registers
	ADDI sp, sp, -0x34 
	SW a0, 0x20 (sp)
	SW a1, 0x24 (sp)
	SW a2, 0x28 (sp)
	//SW a3, 0x2C (sp)
	SW ra, 0x30 (sp)


	//Check if player is actively respawning and don't lose score if the they are
	LUI a1, hi(respawning_flag_p1) 
	ADD a1, a1, a0
	LBU a1, lo(respawning_flag_p1) (a1)
	BNE a1, zero, @@branch_subtract_one_hp
		NOP

	//Subtract 1 HP if being_hit_lowers_score is true
	LBU v0, being_hit_lowers_score
	BEQ v0, zero, @@branch_subtract_one_hp
		LBU v0, ffa_or_teams
		BNE v0, zero, @@branch_subtract_one_hp_ffa //If FFA, subtract 1 HP from a single player
			LI a1, p1_score
			SLL a0, a0, 1 //Multiply a0 by 2
			ADDU a1, a1, a0
			LH a2, 0x0000 (a1)
			ADDI a2, a2, -1 //Subtract 1 HP
			SH a2, 0x0000 (a1) //Store HP back to ram
			@@branch_subtract_one_hp_ffa:
		BEQ v0, zero, @@branch_subtract_one_hp_teams //If teams, subtract 1 HP from team
			SLTI a1, a0, 2 //Figure out which team was hit.  P1+P2 are Team 1, P3+P4 are Team 2
			BEQ a1, zero, @@branch_subtract_from_team_one
				LH a2, team_1_score 
				ADDI a2, a2, -1//Subtract 1 HP
				SH a2, team_1_score
				@@branch_subtract_from_team_one:
			BNE a1, zero, @@branch_subtract_from_team_two
				LH a2, team_2_score 
				ADDI a2, a2, -1//Subtract 1 HP
				SH a2, team_2_score
				@@branch_subtract_from_team_two:
			@@branch_subtract_one_hp_teams:
		@@branch_subtract_one_hp:

	// //Subtract or add 1 HP from player number stored in a0
	// LI a1, p1_score
	// SLL a0, a0, 1 //Multiply a0 by 2
	// LBU v0, hp_or_points
	// ADDU a1, a1, a0
	// BNE v0, zero, @@branch_score_is_stock //If scoring is stock
	// LHU a2, 0x0000 (a1)
	// 	ADDI a2, a2, -1 //Subtract 1 HP
	// 	@@branch_score_is_stock:
	// // BEQ v0, zero, @@branch_score_is_timer //If scoring is points or timer
	// // 	NOP
	// // 	ADDI a2, a2, 1 //Add 1 hit
	// // 	@@branch_score_is_timer:
	// SH a2, 0x0000 (a1) //Store HP or hits back to ram


	//If respawn is on, respawn player who was just hit
	LBU v0, status_respawn
	BEQ v0, zero, @@branch_respawn_on //#If respawn is set to on
		LW a0, 0x20 (sp) 
		JAL processRespawn
		NOP
		@@branch_respawn_on:

	//Load registers and jump back
	//LW a3, 0x2C (sp)
	LW ra, 0x30 (sp)
	LW a0, 0x20 (sp)
	LW a1, 0x24 (sp)
	LW a2, 0x28 (sp)
	JR ra
	ADDI sp, sp, 0x34



//This function checks win conditions for time and point matches and kills the losers
winConditions:
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)
	LBU t7, ffa_or_teams //Load if ffa or teams into t7
	LBU t6, score_mode //Load if points/stock or time into t6
	BNE t7, zero, @@branch_ffa //If game is a FFA
		LI a0, 1
		BNE t6, a0, @@branch_ffa_timed //If score mode is FFA timed match
			LW a0, timer
			SLTI a0, a0, 1
			BNE a0, zero, @@branch_ffa_win_by_highest_score //If timer is < zero
			NOP
			B @@branch_done_with_win_conditions
			NOP
			@@branch_ffa_timed:
		LI a0, 2
		BNE t6, a0, @@branch_ffa_points //If score mode is FFA points match
			LUI a1, hi(p1_score)
			LH t0, max_points
			LH a0, lo(p1_score) (a1) //If P1 score >= max_points, end the game
			SLT t1, a0, t0
			BEQ t1, zero, @@branch_ffa_win_by_highest_score
			LH a0, lo(p2_score) (a1)
			SLT t1, a0, t0
			BEQ t1, zero, @@branch_ffa_win_by_highest_score
			LH a0, lo(p3_score) (a1)
			SLT t1, a0, t0
			BEQ t1, zero, @@branch_ffa_win_by_highest_score
			LH a0, lo(p4_score) (a1)
			SLT t1, a0, t0
			BEQ t1, zero, @@branch_ffa_win_by_highest_score
			NOP
			B @@branch_done_with_win_conditions
			NOP
			@@branch_ffa_points:
		@@branch_ffa:
	//LI a0, 1
	BEQ t7, zero, @@branch_teams 	//if scoring is Teams
		NOP
		BNE t6, zero, @@branch_teams_stock //If scoring mode is teams stock
			LUI a1, hi(team_1_score)
			LH a0, lo(team_1_score) (a1)
			SLTI t1, a0, 1
			BEQ t1, zero, @@branch_team_1_loses_stock //If team 1 reaches zero HP, Team 2 wins
				NOP
				JAL killPlayer
				LI a0, 0
				JAL killPlayer
				LI a0, 1
				JAL killPlayer
				LI a0, 3
				B @@branch_done_with_win_conditions
				NOP
				@@branch_team_1_loses_stock:
			LH a0, lo(team_2_score) (a1)
			SLTI t1, a0, 1
			BEQ t1, zero, @@branch_team_2_loses_stock //If team 2 reaches zero HP, Team 1 wins
				NOP
				JAL killPlayer
				LI a0, 1
				JAL killPlayer
				LI a0, 2
				JAL killPlayer
				LI a0, 3
				B @@branch_done_with_win_conditions
				NOP
				@@branch_team_2_loses_stock:
			@@branch_teams_stock:
		LI a0, 1
		BNE t6, a0, @@branch_teams_timed //If score mode is teams timed match	
			LW a0, timer
			SLTI a0, a0, 1
			BNE a0, zero, @@branch_teams_win_by_highest_score //If timer is < zero
			NOP
			B @@branch_done_with_win_conditions
			NOP
			@@branch_teams_timed:
		LI a0, 2
		BNE t6, a0, @@branch_teams_points //If score mode is teams points	
			LUI a1, hi(team_1_score)
			LH t0, max_points
			LH a0, lo(team_1_score) (a1) //If team 1 score >= max_points, end the game
			SLT t1, a0, t0
			BEQ t1, zero, @@branch_teams_win_by_highest_score
			LH a0, lo(team_2_score) (a1) //If team 2 score >= max_points, end the game
			SLT t1, a0, t0
			BEQ t1, zero, @@branch_teams_win_by_highest_score
			NOP
			B @@branch_done_with_win_conditions
			NOP
			@@branch_teams_points:
		@@branch_teams:

	B @@branch_done_with_win_conditions //Done with win conditions so branch out
	NOP

	@@branch_ffa_win_by_highest_score:
		LUI a3, hi(p1_score)
		LH v0, lo(p1_score) (a3)  //First find the maximum score out of all the player scores
		LH v1, lo(p2_score) (a3)
		SLT a2, v0, v1
		BEQ a2, zero, @@branch_timed_ffa_objective_p2_greater
			NOP
			MOVE v0, v1
			@@branch_timed_ffa_objective_p2_greater:
		LH v1, lo(p3_score) (a3)
		SLT a2, v0, v1
		BEQ a2, zero, @@branch_timed_ffa_objective_p3_greater
			NOP
			MOVE v0, v1
			@@branch_timed_ffa_objective_p3_greater:
		LH v1, lo(p4_score) (a3)
		SLT a2, v0, v1
		BEQ a2, zero, @@branch_timed_ffa_objective_p4_greater
			NOP
			MOVE v0, v1
			@@branch_timed_ffa_objective_p4_greater:
		LH v1, lo(p1_score) (a3)//Now kill all players with a score below the max score
		SLT a2, v1, v0
		BEQ a2, zero, @@branch_timed_ffa_objective_p1_dead
			NOP
			JAL killPlayer
			LI a0, 0
			@@branch_timed_ffa_objective_p1_dead:
		LH v1, lo(p2_score) (a3)
		SLT a2, v1, v0
		BEQ a2, zero, @@branch_timed_ffa_objective_p2_dead
			NOP
			JAL killPlayer
			LI a0, 1
			@@branch_timed_ffa_objective_p2_dead:
		LH v1, lo(p3_score) (a3)
		SLT a2, v1, v0
		BEQ a2, zero, @@branch_timed_ffa_objective_p3_dead
			NOP
			JAL killPlayer
			LI a0, 2
			@@branch_timed_ffa_objective_p3_dead:
		LH v1, lo(p4_score) (a3)
		SLT a2, v1, v0
		BEQ a2, zero, @@branch_timed_ffa_objective_p4_dead
			NOP
			JAL killPlayer
			LI a0, 3
			@@branch_timed_ffa_objective_p4_dead:
		B @@branch_done_with_win_conditions //Done with win conditions so branch out
		NOP

	@@branch_teams_win_by_highest_score:
		LUI a3, hi(team_1_score)
		LH v0, lo(team_1_score) (a3)
		LH v1, lo(team_2_score) (a3)
		SLT a0, v1, v0
		BEQ a0, zero, @@branch_timed_teams_hits_team1_greater //Team 1 scored higher
			NOP
			JAL killPlayer
			LI a0, 1
			JAL killPlayer
			LI a0, 2
			JAL killPlayer
			LI a0, 3
			@@branch_timed_teams_hits_team1_greater:
		SLT a0, v0, v1
		BEQ a0, zero, @@branch_timed_teams_hits_team2_greater //Team 2 score is higher
			NOP
			JAL killPlayer
			LI a0, 0
			JAL killPlayer
			LI a0, 1
			JAL killPlayer
			LI a0, 3
			@@branch_timed_teams_hits_team2_greater:
		B @@branch_done_with_win_conditions //Done with win conditions so branch out
		NOP


	// BNE t6, zero, @@branch_not_timed //If game is not timed
	// 	LHU v1, max_points//Load maximum score
	// 	BNE t7, zero, @@branch_not_timed_ffa //If game is a FFA
	// 		LBU t8, hp_or_points //L:oad if hp or points into t8
	// 		BEQ t8, zero, @@branch_not_timed_ffa_is_points //If game is points (if it is HP, the win conditions don't matter)
	// 			LUI a3, hi(p1_score)
	// 			LHU v0, lo(p1_score) (a3)
	// 			BNE v1, v0, @@branch_ffa_is_points_p1 //If P1 has reached max points
	// 				NOP
	// 				JAL killPlayer //Kill player 2
	// 				LI a0, 1
	// 				JAL killPlayer //Kill player 3
	// 				LI a0, 2
	// 				JAL killPlayer //Kill player 4
	// 				LI a0, 3
	// 				@@branch_ffa_is_points_p1:
	// 			LHU v0, lo(p1_score)+0X2 (a3)
	// 			BNE v1, v0, @@branch_ffa_is_points_p2 //If P2 has reached max points
	// 				NOP
	// 				JAL killPlayer //Kill player 1
	// 				LI a0, 0
	// 				JAL killPlayer //Kill player 3
	// 				LI a0, 2
	// 				JAL killPlayer //Kill player 4
	// 				LI a0, 3
	// 				@@branch_ffa_is_points_p2:
	// 			LHU v0, lo(p1_score)+0X4 (a3)
	// 			BNE v1, v0, @@branch_ffa_is_points_p3 //If P3 has reached max points
	// 				NOP
	// 				JAL killPlayer //Kill player 1
	// 				LI a0, 0
	// 				JAL killPlayer //Kill player 2
	// 				LI a0, 1
	// 				JAL killPlayer //Kill player 4
	// 				LI a0, 3
	// 				@@branch_ffa_is_points_p3:
	// 			LHU v0, lo(p1_score)+0x6 (a3)
	// 			BNE v1, v0, @@branch_ffa_is_points_p4 //If P4 has reached max points
	// 				NOP
	// 				JAL killPlayer //Kill player 1
	// 				LI a0, 0
	// 				JAL killPlayer //Kill player 2
	// 				LI a0, 1
	// 				JAL killPlayer //Kill player 3
	// 				LI a0, 2
	// 				@@branch_ffa_is_points_p4:
	// 			@@branch_not_timed_ffa_is_points:
	// 		@@branch_not_timed_ffa:
	// 	BEQ t7, zero, @@branch_not_timed_teams //If game is a teams
	// 		LUI a3, hi(team_1_score)
	// 		LH v0, lo(team_1_score) (a3)
	// 		LH t0, lo(team_2_score) (a3)
	// 		BNE v0, v1, @@branch_not_timed_team_1_wins //If team 1 reaches the max score
	// 				NOP
	// 				JAL killPlayer //Kill player 2
	// 				LI a0, 1
	// 				JAL killPlayer //Kill player 3
	// 				LI a0, 2
	// 				JAL killPlayer //Kill player 4
	// 				LI a0, 3
	// 			@@branch_not_timed_team_1_wins:
	// 		BNE t0, v1, @@branch_not_timed_team_2_wins //If team 2 reaches the max score
	// 				NOP
	// 				JAL killPlayer //Kill player 1
	// 				LI a0, 0
	// 				JAL killPlayer //Kill player 2
	// 				LI a0, 1
	// 				JAL killPlayer //Kill player 4
	// 				LI a0, 3
	// 			@@branch_not_timed_team_2_wins:
	// 		@@branch_not_timed_teams:
	// 	@@branch_not_timed:
	// BEQ t6, zero, @@branch_is_timed //If game is timed
	// 	LW a0, timer
	// 	SLTI a0, a0, 1
	// 	BEQ a0, zero, @@branch_is_timed //If timer is < zero
	// 		NOP
	// 		BNE t7, zero, @@branch_is_timed_ffa //If game is a FFA
	// 			LBU t9, hit_or_objective //Load if game is hit based or objective based	
	// 			LUI a3, hi(p1_score)
	// 			BNE t9, zero, @@branch_is_timed_ffa_hits //If score mode is hits
	// 				LHU v0, lo(p1_score) (a3)  //First find the lowest number of hits out of all the player and team scores
	// 				LHU v1, lo(p2_score) (a3)
	// 				SLTU a2, v1, v0
	// 				BEQ a2, zero, @@branch_timed_ffa_hits_p2_lesser
	// 					NOP
	// 					MOVE v0, v1
	// 					@@branch_timed_ffa_hits_p2_lesser:
	// 				LBU t0, player_count
	// 				SLTI t1, t0, 3
	// 				BNE t1, zero, @@branch_timed_ffa_hits_p4_lesser //Skip if < 3 players
	// 					LHU v1, lo(p3_score) (a3)
	// 					SLTU a2, v1, v0
	// 					BEQ a2, zero, @@branch_timed_ffa_hits_p3_lesser
	// 						NOP
	// 						MOVE v0, v1
	// 						@@branch_timed_ffa_hits_p3_lesser:
	// 					SLTI t1, t0, 4
	// 					BNE t1, zero, @@branch_timed_ffa_hits_p4_lesser //skip if < 4 players
	// 						LHU v1, lo(p4_score) (a3)
	// 						SLTU a2, v1, v0
	// 						BEQ a2, zero, @@branch_timed_ffa_hits_p4_lesser
	// 							NOP
	// 							MOVE v0, v1
	// 							@@branch_timed_ffa_hits_p4_lesser:
	// 				LHU v1, lo(p1_score) (a3)//Now kill all players with a score above the lowest number of hits
	// 				BEQ v0, v1, @@branch_timed_ffa_hits_p1_dead
	// 				LHU v1, lo(p2_score) (a3)
	// 					JAL killPlayer
	// 					LI a0, 0
	// 					@@branch_timed_ffa_hits_p1_dead:
	// 				BEQ v0, v1, @@branch_timed_ffa_hits_p2_dead
	// 				LHU v1, lo(p3_score) (a3)
	// 					JAL killPlayer
	// 					LI a0, 1
	// 					@@branch_timed_ffa_hits_p2_dead:
	// 				BEQ v0, v1, @@branch_timed_ffa_hits_p3_dead
	// 				LHU v1, lo(p4_score) (a3)
	// 					JAL killPlayer
	// 					LI a0, 2
	// 					@@branch_timed_ffa_hits_p3_dead:
	// 				BEQ v0, v1, @@branch_timed_ffa_hits_p4_dead
	// 					NOP
	// 					JAL killPlayer
	// 					LI a0, 3
	// 					@@branch_timed_ffa_hits_p4_dead:
	// 				@@branch_is_timed_ffa_hits:
	// 			BEQ t9, zero, @@branch_is_timed_ffa_objective //If score mode is objective (points) based
	// 				LHU v0, lo(p1_score) (a3)  //First find the maximum score out of all the player and team scores
	// 				LHU v1, lo(p2_score) (a3)
	// 				SLTU a2, v0, v1
	// 				BEQ a2, zero, @@branch_timed_ffa_objective_p2_greater
	// 					NOP
	// 					MOVE v0, v1
	// 					@@branch_timed_ffa_objective_p2_greater:
	// 				LHU v1, lo(p3_score) (a3)
	// 				SLTU a2, v0, v1
	// 				BEQ a2, zero, @@branch_timed_ffa_objective_p3_greater
	// 					NOP
	// 					MOVE v0, v1
	// 					@@branch_timed_ffa_objective_p3_greater:
	// 				LHU v1, lo(p4_score) (a3)
	// 				SLTU a2, v0, v1
	// 				BEQ a2, zero, @@branch_timed_ffa_objective_p4_greater
	// 					NOP
	// 					MOVE v0, v1
	// 					@@branch_timed_ffa_objective_p4_greater:
	// 				LHU v1, lo(p1_score) (a3)//Now kill all players with a score below the max score
	// 				SLTU a2, v1, v0
	// 				BEQ a2, zero, @@branch_timed_ffa_objective_p1_dead
	// 					NOP
	// 					JAL killPlayer
	// 					LI a0, 0
	// 					@@branch_timed_ffa_objective_p1_dead:
	// 				LHU v1, lo(p2_score) (a3)
	// 				SLTU a2, v1, v0
	// 				BEQ a2, zero, @@branch_timed_ffa_objective_p2_dead
	// 					NOP
	// 					JAL killPlayer
	// 					LI a0, 1
	// 					@@branch_timed_ffa_objective_p2_dead:
	// 				LHU v1, lo(p3_score) (a3)
	// 				SLTU a2, v1, v0
	// 				BEQ a2, zero, @@branch_timed_ffa_objective_p3_dead
	// 					NOP
	// 					JAL killPlayer
	// 					LI a0, 2
	// 					@@branch_timed_ffa_objective_p3_dead:
	// 				LHU v1, lo(p4_score) (a3)
	// 				SLTU a2, v1, v0
	// 				BEQ a2, zero, @@branch_timed_ffa_objective_p4_dead
	// 					NOP
	// 					JAL killPlayer
	// 					LI a0, 3
	// 					@@branch_timed_ffa_objective_p4_dead:
	// 				@@branch_is_timed_ffa_objective:
	// 			@@branch_is_timed_ffa:
	// 		BEQ t7, zero, @@branch_is_timed_teams //If game is teams
	// 			LUI a3, hi(team_1_score)
	// 			//BNE t9, zero, @@branch_is_timed_teams_hits //If score mode is hits
	// 			LH v0, lo(team_1_score) (a3)
	// 			LH v1, lo(team_2_score) (a3)
	// 			SLT a0, v1, v0
	// 			BEQ a0, zero, @@branch_timed_teams_hits_team1_greater //Team 1 scored higher
	// 				NOP
	// 				JAL killPlayer
	// 				LI a0, 1
	// 				JAL killPlayer
	// 				LI a0, 2
	// 				JAL killPlayer
	// 				LI a0, 3
	// 				@@branch_timed_teams_hits_team1_greater:
	// 			SLT a0, v0, v1
	// 			BEQ a0, zero, @@branch_timed_teams_hits_team2_greater //Team 2 score is higher
	// 				NOP
	// 				JAL killPlayer
	// 				LI a0, 0
	// 				JAL killPlayer
	// 				LI a0, 1
	// 				JAL killPlayer
	// 				LI a0, 3
	// 				@@branch_timed_teams_hits_team2_greater:
	// 			@@branch_is_timed_teams:
	// 	@@branch_is_timed:


	@@branch_done_with_win_conditions:

	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30


//This function handles hit detection for all battle modes
//Returns player who was hit as the byte who_was_hit_last
hitDetection:
	//Check each player's balloon count, if player has two balloons, set them back to three and make that player the hot potato
	LI a3, 0 //Set counter to 1
	LI a1, 1 //Load 2 balloons into a1 for comparison
	LI a0, 0x8018D8C0 //Load player balloon memory location
	LI t0, 2 //Set balloons back to 3
	LI t1, 4 //set loop maximum
	@@branch_hit_detection_do_while_loop: //Do
		LHU a2, 0x0000 (a0)
		ADDIU a3, a3, 1 //a3 = a3 + 1
		BNE a2, a1, @@branch_hit_found //If ballons == 2, run the following code
			LUI a2, hi(who_was_hit_last)
			SH t0, 0x0000 (a0)
			BEQ zero, zero, @@branch_break_loop //Break the loop so the hit can be processed before the next player who was hit gets processed, this works around some rare bugs/crashes
			SB a3, lo(who_was_hit_last) (a2) //Store who was hit/player (e.g. this will turn them into the hot potato)	
			@@branch_hit_found:
		BNE a3, t1, @@branch_hit_detection_do_while_loop //WHILE $A3 <= 0x4
		ADDIU a0, a0, 2 //Add offset for next player's balloon count mem location
	@@branch_break_loop:
	JR ra
	NOP



//This function simply resets all player and team scores or HP, it also sets course_height
resetGame:
	LBU a1, status_p1
	LI a2, 0xE0
	BNE a1, a2, @@branch_reset_everything //If game is starting or restarting, force score, HP, and timer to all reset
		//Reset player score or HP
		LBU v0, score_mode
		BNE v0, zero, @@branch_use_hp
		LI a1, 0 //Default reset to 0 if scoring is points
			LHU a1, max_hp //If scoring is stock, reset HP back to max'
			@@branch_use_hp:
		SH a1, p1_score //Reset individual scores to zero or max hp
		SH a1, p2_score
		SH a1, p3_score
		SH a1, p4_score
		//Reset team score
		SH a1, team_1_score //Reset team scores to zero or max hp
		SH a1, team_2_score
		//Reset timer
		LW v1, max_timer //Copy max timer value to timer value
		SW v1, timer
		SB zero, final_lap_music_flag //Reset final lap music flag
		SB zero, final_sudden_death_music_flag //Reset sudden death music flag
		//Reset who was hit last
		SB zero, who_was_hit_last
		//Set course height
		LW a1, 0x800F69A8 //Mem address of player 1 height
		SW a1, course_height //variable to store this as the course height
		//Force bot input to be zero
		LUI a0, hi(bot_controller_input_p1)
		SW zero, lo(bot_controller_input_p1) (a0)
		SW zero, lo(bot_controller_input_p2) (a0)
		SW zero, lo(bot_controller_input_p3) (a0)
		SW zero, lo(bot_controller_input_p4) (a0)
		//Reset zombomb startup flag
		SB zero, zombomb_startup_flag
		//Reset shell shooter health and ammo
		LW a0, shooter_health_max
		SW a0, shooter_health_p1
		SW a0, shooter_health_p2
		SW a0, shooter_health_p3
		SW a0, shooter_health_p4
		LW a0, shooter_ammo_max
		SW a0, shooter_ammo_p1
		SW a0, shooter_ammo_p2
		SW a0, shooter_ammo_p3
		SW a0, shooter_ammo_p4
		LI a0, -1
		SB a0, who_hit_p1_last
		SB a0, who_hit_p2_last
		SB a0, who_hit_p3_last
		SB a0, who_hit_p4_last
		//Reset respawn flags
		SW zero, respawning_flag_p1
		//Fix item boxes on big donut
		LBU a1, 0x800DC5A1 //Load current track from cup course index 0x8018EE0B
		LI a0, 0x13 //Check if Big Donut, if it is, skip the rest of this
		BNE a0, a1, @@branch_course_big_donut		
			LI a0, 0x4375
			SH a0, 0x80160304
			LI a0, 0x4360
			SH a0, 0x80160374
			@@branch_course_big_donut:
		//Find nearest item boxes
		ADDI sp, sp, -0x30
		SW RA, 0x20 (sp)
		JAL GetItemBoxIndexes
		NOP
		LW RA, 0x20 (sp)
		ADDI sp, sp, 0x30
		@@branch_reset_everything:
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
	LBU v1, one_player_full_screen
	BEQ v1, zero, @@branch_countdown_1p_full_screen //If in 1 player full screen mode
		LI t0, 1
		BNE t0, v0, @@branch_1p_full_screen_countdown //If it's not player 1 who is the hot potato, just don't display anything
		LI t0, 2
			LI a0, 0x7C //Set x
			LI a1, 0xB4 //set y
			@@branch_1p_full_screen_countdown:
		BNE t0, v0, @@branch_2p_full_screen_countdown //If it's not player 1 who is the hot potato, just don't display anything
		LI t0, 3
			LI a0, 0x40 //Set x
			LI a1, 0x0C //set y
			@@branch_2p_full_screen_countdown:
		BNE t0, v0, @@branch_3p_full_screen_countdown //If it's not player 1 who is the hot potato, just don't display anything
		LI t0, 4
			LI a0, 0x40 //Set x
			LI a1, 0x18 //set y
			@@branch_3p_full_screen_countdown:
		BNE t0, v0, @@branch_4p_full_screen_countdown //If it's not player 1 who is the hot potato, just don't display anything
			NOP
			LI a0, 0x40 //Set x
			LI a1, 0x24 //set y
			@@branch_4p_full_screen_countdown:
		BEQ zero, zero, @@branch_skip_to_dispaly_countdown
		NOP

		@@branch_countdown_1p_full_screen:
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
	@@branch_skip_to_dispaly_countdown:
	JAL FUNCTION_DISPLAY_TEXT_AND_INT //Run function to display 
	NOP
	@@branch_skip_countdown_display:

	//Set green shell tumble height depending on if game mode is shell shooter or not

	// LI a0, game_mode
	// LI a1, 6
	// BNE a0, a1, @@branch_shell_shooter_set_tumble_height
	// 	LI a2, 0x3C013800
	// 	SW a2, 0x8008C56C
	// 	LI a2, 0x44814000
	// 	SW a2, 0x8008C578
	// 	@@branch_shell_shooter_set_tumble_height:
	// BEQ a0, a1, @@branch_non_shell_shooter_set_tumble_height
	// 	LI a2, 0x00220821
	// 	SW a2, 0x8008C56C
	// 	LI a2, 0xC4283790
	// 	SW a2, 0x8008C578
	// 	@@branch_non_shell_shooter_set_tumble_height:	

	
	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30

//This function processes hits and causes the player to be lightning squished
//a0 = player to decrement HP for, P1 = 0, P2 = 1, P3 =2, P4 = 4
processHitShrink:
	//Store registers
	//ADDI sp, sp, -0x30
	//SW a0, 0x20 (sp)
	//SW a2, 0x28 (sp)

	//Lightning shrink from player number stored in a0
	LI t6, player_state_offset
	MULT a0, t6
	LI t7, 0x800F699E	
	MFLO t6
	ADDU t7, t7, t6
	LI t6, 0x40
	JR RA
	SB t6, 0x0000 (t7)

	// LI a2, player_state_offset
	// MULT a0, a2
	// LI a0, 0x800F6A4C //Make player who is hot potato lightning strink for a split second to indicate the hit
	// MFLO a2
	// ADDU a2, a0, a2
	// LI a0, 0x40
	// SB a0, 0x0000 (a2)

	//Load registers
	//LW a0, 0x20 (sp)
	//LW a2, 0x28 (sp)
	// JR ra
	// NOP
	//ADDI sp, sp, 0x30


//This function returns if the number of players are bombs or not
//returns v0=false if not all players are bombs, =true if all players are bombs
all_players_bombs:
	//Count number of players that are bombs
	LI a0, 0 //Bomb counter
	LI t0, 0 //loop counter
	LI a1, 0x50 //Match to bomb
	LBU a2, player_count //number of players
	LI a3, 0x800F6991 //Base address for if a player is a bomb
	@@branch_bomb_counter_loop:
		LBU t1, 0x0000 (a3)
		BNE t1, a1, @@branch_count_a_bomb //If player is a bomb....
		ADDIU a3, a3, player_state_offset //Increment address to status if player is a bomb (in delay slot)
			ADDIU a0, a0, 1 //Increment bomb counter
			@@branch_count_a_bomb:
		BNE t0, a2, @@branch_bomb_counter_loop
		ADDIU t0, t0, 1 //Increment loop counter
	BNE a2, a0, @@branch_all_players_not_bombs
	LI v0, 0 //not all players are bombs
		LI v0, 0xFF //all players are bombs
		@@branch_all_players_not_bombs:
	JR RA
	NOP


//Run the coins game mode
runGameModeCoins:
	//store registers
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)

	// //Attempt to display snow
	// JAL 0x800517C8 //JAL KWDisplaySnow
	// NOP


	// //Test cutscene
	// JAL TestCutscene
	// NOP

	//Run hit detection to find who as hit last and process 
	JAL hitDetection
	NOP

	//If respawn is on, respawn players that are hit
	LBU v0, status_respawn
	BEQ v0, zero, @@branch_respawn_on //#If respawn is set to on
		LBU a0, who_was_hit_last //Load whoever might have been hit
		BEQ a0, zero, @@branch_respawn_on //If a player was hit, respawn them
			NOP
			//SB zero, who_was_hit_last
			JAL processRespawn
			ADDI a0, a0, -1
		@@branch_respawn_on:

	LBU a0, who_was_hit_last //Load whoever might have been hit
	BEQ a0, zero, @@branch_someone_was_hit //Branch if no one was hit
		ADDI a0, a0, -1 //Subtract one to change who was hit to player index
		JAL DropCoins //Drop coins
		NOP
		SB zero, who_was_hit_last //Blank who was hit last
		@@branch_someone_was_hit:


	JAL PhysicsBKCoins
	NOP

	JAL checkCoinCollision //Check if you collide with a present
	NOP

	//DISPLAY HP and run the time scoring (if it is selected as an option)
	LBU a1, game_paused //Only run counter and display HP and countdown when not paused (game tempo is zero or less)
	LBU a2, in_game
	XOR a1, a2, a1 //Check if game is not paused or in the results screen
	BEQ a1, zero, @@branch_run_counter_and_display_hp
		NOP
		JAL FUNCTION_LOAD_FONT //Load font
		NOP
		JAL displayScore //Display HP
		NOP
		JAL displayTimer //Display timer(if in a time match)
		NOP
		JAL winConditions //If in team points scoring mode, check if a team has won
		NOP
		@@branch_run_counter_and_display_hp:

	// // LBU a1, BattleSantaCutsceneFlag
	// // BNE a1, zero, @@branch_display_stuff
	// 	LBU a1, game_paused //Only run counter and display HP and countdown when not paused (game tempo is zero or less)
	// 	LBU a2, in_game
	// 	XOR a1, a2, a1 //Check if game is not paused or in the results screen
	// 	BEQ a1, zero, @@branch_display_stuff
	// 	NOP
	// 		JAL displayNumberOfPresents //Display the score
	// 		NOP
	// 		JAL displayTimer //Display timer(if in a time match)
	// 		NOP
	// 		@@branch_display_stuff:



	// LW a0, timer
	// SLTI a0, a0, 1
	// BEQ a0, zero, @@branch_presents_endgame_start //If timer is < zero
	// 	NOP
	// 	NOR a0, zero, zero //Set to be on
	// 	SB a0, BattleSantaEndgameFlag
	// 	@@branch_presents_endgame_start:


	// LBU a0, BattleSantaEndgameFlag
	// BEQ a0, zero, @@branch_presents_endgame
	// 	NOP
	// 	JAL BattleSantaEndgame
	// 	NOP
	// 	@@branch_presents_endgame:


	// //Force pause menu to be continue
	// LBU a0, 0x8018DA5F
	// SLTI a1, a0, 0x2A
	// BNE a1, zero, @@branch_force_pause_to_continue
	// 	LI a0, 0x29
	// 	SB a0, 0x8018DA5F
	// 	@@branch_force_pause_to_continue:



	//Test loading custom objects
	LBU a1, course_start_flag
	BNE a1, zero, @@run_at_start_of_course
		LW a1, g_startingIndicator
		LI a2, 3
		BNE a1, a2, @@run_at_start_of_course
		LBU a1, course_start_flag
		BNE a1, zero, @@run_at_start_of_course
			LH a0, max_coins //Spawn max coins
			JAL spawnCoins
			NOP
			//Set course start flag so that the above code only runs once
			LI a0, 1
			SB a0, course_start_flag
			@@run_at_start_of_course:

	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30

//This function handles everything for game mode shell shooter
runGameModeShellShooter:
	//store registers
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)




	//c code for handling shell shooter hud + graphics stuff
	JAL shell_shooter_hud_stuff
	NOP

	//Infinite green shells
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
	//Modify shell behavior when in shell shooter
	LI a0, 0x080ACEB1 //Green shells despawn when they hit a wall instead of bouncing
	LUI a1, 0x802B
	SW a0, lo(0x802B3948) (a1)
	SW zero, lo(0x802B394C) (a1)
	// SW zero, lo(0x802B3500) (a1) //Force shells to always fire (cannot hold behind you)
	//SW zero, lo(0x802B3870) (a1) //Force shells to not change height
	// LI a0, 0x6 //Force shells to fire from in front of player and not behind, by changing a neg.s to mov.s (moves shell from behind to front)
	// SW a0, lo(0x802B3437) (a1)
	// LUI a0, 0xAFA0 //Force shells to fire from in front of player and not behind, by turning the vector that stores the shell's initial position to be zero so the shell spawns at the player's position exactly
	// ORI a0, a0, 0x006C
	// SW a0, lo(0x802B3410) (a1)
	// ORI a0, a0, 0x0070
	// SW a0, lo(0x802B3420) (a1)
	// ORI a0, a0, 0x0074
	// SW a0, lo(0x802B343C) (a1)
	// //SW zero, lo(0x802B365C) (a1) //No swinging! firing starts immediately
	// SH zero, lo(0x802B35F6) (a1)
	// SW zero, lo(0x802B35FA) (a1)

	//Hit detection, HP, and killing player handling
	JAL hitDetection
	NOP
	LBU a0, who_was_hit_last //Load whoever might have been hit
	BEQ a0, zero, @@branch_player_was_hit

		ADDI a0, a0, -1 //Subtract 1 from $a0 to feed into the following functions
		SLL a1, a0, 2 //Multiply by 4 to get offset for current player
		LUI a2, hi(shooter_health_p1)
		ADD a2, a2, a1
		LWC1 f2, lo(shooter_health_p1) (a2) //Load player hp into f2	
		LI.S f4, -1.0 //Load float to decrement hp by into f4
		ADD.S f0, f2, f4 //Current player health decremented
		LI.s f4, 0.1
		C.LT.S f0, f4// if current player HP < 0.1 (zero or less)
		NOP //Delay slot needed for comparison
		BC1F @@branch_hp_too_low //Execute the code below only if the current player's hp is zero or less
			LWC1 f2, shooter_health_max //Load max hp into f2
			JAL processHit
			MOV.S f0, f2 //Copy max HP into current player HP
			JAL checkIfZeroHP
			NOP
			LUI t1, hi(who_hit_p1_last) //Increment score if in a points or time scoring mode
			ADD t1, t1, a0
			LB t2, lo(who_hit_p1_last) (t1)
			SLTI a1, t2, 0
			BNE a1, zero, @@branch_someone_scored
				SW a2, 0x24 (sp) //Store and load a2 because incrementScoreOnHit overwrites it
				MOVE t0, a0 //Copy who was hit to t0
				JAL incrementScoreOnHit
				MOVE a0, t2 //Copy who scored the hit to a0
				LI a0, -1 //set who was hit last back to -1
				SB a0, lo(who_hit_p1_last) (t1)
				LW a2, 0x24 (sp)
				@@branch_someone_scored:
			@@branch_hp_too_low:
		SWC1 f0, lo(shooter_health_p1) (a2) //Store result
		//JAL processHit
		//NOP
		//JAL checkIfZeroHP //Kill player if their HP = 0
		//NOP
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
		JAL displayScore //Display HP
		NOP
		JAL displayTimer //Display timer(if in a time match)
		NOP
		JAL winConditions //If in team points scoring mode, check if a team has won
		NOP
		@@branch_run_counter_and_display_hp:

	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30

//This function handles everything  for the game mode Zombombs
runGameModeZombombs:
	//store registers
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)

	JAL hitDetection
	NOP

	//Bombs win if all players are bombs
	//Count number of players that are bombs
	LI a0, 0 //Bomb counter
	LI t0, 0 //loop counter
	LI a1, 0x50 //Match to bomb
	LBU a2, player_count //number of players
	LI a3, 0x800F6991 //Base address for if a player is a bomb
	@@branch_bomb_counter_loop:
		LBU t1, 0x0000 (a3)
		BNE t1, a1, @@branch_count_a_bomb //If player is a bomb....
		ADDIU a3, a3, player_state_offset //Increment address to status if player is a bomb (in delay slot)
			ADDIU a0, a0, 1 //Increment bomb counter
			@@branch_count_a_bomb:
		BNE t0, a2, @@branch_bomb_counter_loop
		ADDIU t0, t0, 1 //Increment loop counter
	BNE a2, a0, @@branch_bombs_win
		LI a0, 1
		SB a0, who_won_zombombs
		JAL killAllPlayers
		NOP
		@@branch_bombs_win:

	//Display timer if in time scoring
	LBU a1, game_paused //Only run counter and display HP and countdown when not paused (game tempo is zero or less)
	LBU a2, in_game
	XOR a1, a2, a1 //Check if game is not paused or in the results screen
	BEQ a1, zero, @@branch_display_stuff
		NOP
		JAL FUNCTION_LOAD_FONT //load debug font
		NOP
		JAL displayTimer //Display timer(if in a time match)
		NOP
		//End game if timer reaches zero, victory for the survivors
		LW a0, timer
		SLTI a0, a0, 1
		BEQ a0, zero, @@branch_survivors_win //If timer is < zero
			NOP
			SB zero, who_won_zombombs
			JAL bombSlowdown //Slow down all players who were bombs back to their original speed
			NOP
			JAL killAllPlayers //Kill everyone to end the game
			NOP
			@@branch_survivors_win:
		//Kill player randomly at start of a zombombs match
		LBU a0, zombomb_startup_flag
		SLTI a1, a0, 2
		BEQ a1, zero, @@make_player_at_start_a_bomb
			NOP
			LI a2, 2
			ADDIU a0, a0, 1
			SB a0, zombomb_startup_flag
			BNE a0, a2, @@make_player_at_start_a_bomb
				LUI a1, hi(player_count)
				JAL FUNCTION_RNG //Run RNG and random player in v0 to kill
				LBU a0, lo(player_count) (a1)
				JAL makePlayerBomb
				MOVE a0, v0
				@@make_player_at_start_a_bomb:
		@@branch_display_stuff:

	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30


//This function handles everything for keep away mode
runGameModeKeepAway:
	//store registers
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)

	//Run hit detection to find who as hit last and process 
	JAL hitDetection
	NOP

	//If respawn is on, respawn players that are hit
	LBU v0, status_respawn
	BEQ v0, zero, @@branch_respawn_on //#If respawn is set to on
		LBU a0, who_was_hit_last //Load whoever might have been hit
		BEQ a0, zero, @@branch_respawn_on //If a player was hit, respawn them
			NOP
			SB zero, who_was_hit_last
			JAL processRespawn
			ADDI a0, a0, -1
		@@branch_respawn_on:

	//Display timer if in time scoring
	LBU a1, game_paused //Only run counter and display HP and countdown when not paused (game tempo is zero or less)
	LBU a2, in_game
	XOR a1, a2, a1 //Check if game is not paused or in the results screen
	BEQ a1, zero, @@branch_display_stuff
		LBU a0, status_options_minimap
		BEQ a0, zero, @@branch_minimap_is_off //Check if minimap off option has been toggled
			LBU a0, 0x80165800
			BEQ a0, zero, @@branch_minimap_is_off //Check if player 1 intentinoally toggled minimap off or not (stored in the above byte)		
				NOP
				JAL keep_away_minimap_display_flag //Run minmimap display flag function
				NOP
				@@branch_minimap_is_off:
		NOP
		JAL trackKeepAwayScoring //Function tracks the keep away scoring
		NOP
		JAL FUNCTION_LOAD_FONT
		NOP
		JAL displayScore
		NOP
		JAL displayTimer //Display timer(if in a time match)
		NOP
		JAL winConditions
		NOP
		//Function that runs to check if a player holding the flag is hit and to drop the flag if they are hit
		JAL dropFlagAfterHit
		NOP
		LBU a3, flagDropped  //Here we only check if the first flag has dropped since only the first flag matters for keep away
		BEQ a3, zero, @@branch_flag_is_dropped1 //If has been dropped
			LUI t1, hi(flagTimer)
			JAL decrementTimer //Decrement timer
			LW a3, lo(flagTimer) (t1) //(delay slot)
			SW a3, lo(flagTimer) (t1)
			@@branch_flag_is_dropped1:

		@@branch_display_stuff:






	//Test loading custom objects
	LBU a1, course_start_flag
	BNE a1, zero, @@run_at_start_of_course
		NOP
		JAL initKeepAway
		NOP
		//Set course start flag so that the above code only runs once
		LI a0, 1
		SB a0, course_start_flag
		@@run_at_start_of_course:

	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30




//This function handles everything for CTF battle mode
runGameModeCTF:
	//store registers
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)


	//Test pausing at start
	JAL selectStartingPositions
	NOP
	//Run hit detection to find who as hit last and process 
	JAL hitDetection
	NOP
	//If respawn is on, respawn players that are hit
	LBU v0, status_respawn
	BEQ v0, zero, @@branch_respawn_on //#If respawn is set to on
		LBU a0, who_was_hit_last //Load whoever might have been hit
		BEQ a0, zero, @@branch_respawn_on //If a player was hit, respawn them
			NOP
			SB zero, who_was_hit_last
			JAL processRespawn
			ADDI a0, a0, -1
		@@branch_respawn_on:


	//Display timer if in time scoring
	LBU a1, game_paused //Only run counter and display HP and countdown when not paused (game tempo is zero or less)
	LBU a2, in_game
	XOR a1, a2, a1 //Check if game is not paused or in the results screen
	BEQ a1, zero, @@branch_display_stuff
		LBU a0, ctf_game_started
		BEQ a0, zero, @@branch_display_stuff //Check if game has started 
			LBU a0, status_options_minimap
			BEQ a0, zero, @@branch_minimap_is_off //Check if minimap off option has been toggled
				LBU a0, 0x80165800
				BEQ a0, zero, @@branch_minimap_is_off //Check if player 1 intentinoally toggled minimap off or not (stored in the above byte)
					NOP
					JAL ctf_minimap_display_flags_and_bases //Run mimimap base and flag sprite function//Run mimimap base and flag sprite function
					NOP
				@@branch_minimap_is_off:
			JAL FUNCTION_LOAD_FONT
			NOP
			JAL displayScore
			NOP
			JAL displayTimer //Display timer(if in a time match)
			NOP
			JAL winConditions
			NOP


			//Function that runs to check if a player holding the flag is hit and to drop the flag if they are hit
			JAL dropFlagAfterHit
			NOP
			//Decrement flag timer if it is > 0
				//SLL a0, a0, 2 //Multiply flag numnber by
			LBU a3, flagDropped
			BEQ a3, zero, @@branch_flag_is_dropped1 //If has been dropped
				LUI t1, hi(flagTimer)
				JAL decrementTimer //Decrement timer
				LW a3, lo(flagTimer) (t1) //(delay slot)
				SW a3, lo(flagTimer) (t1)
				@@branch_flag_is_dropped1:
			LBU a3, flagDropped + 0x1
			BEQ a3, zero, @@branch_flag_is_dropped2 //If has been dropped
				LUI t1, hi(flagTimer)
				JAL decrementTimer //Decrement timer
				LW a3, lo(flagTimer)+0x4 (t1) //(delay slot)
				SW a3, lo(flagTimer)+0x4 (t1)
				@@branch_flag_is_dropped2:
			LBU a3, flagDropped + 0x2
			BEQ a3, zero, @@branch_flag_is_dropped3 //If has been dropped
				LUI t1, hi(flagTimer)
				JAL decrementTimer //Decrement timer
				LW a3, lo(flagTimer)+0x8 (t1) //(delay slot)
				SW a3, lo(flagTimer)+0x8 (t1)
				@@branch_flag_is_dropped3:
			LBU a3, flagDropped + 0x3
			BEQ a3, zero, @@branch_flag_is_dropped4 //If has been dropped
				LUI t1, hi(flagTimer)
				JAL decrementTimer //Decrement timer
				LW a3, lo(flagTimer)+0xC (t1) //(delay slot)
				SW a3, lo(flagTimer)+0xC (t1)
				@@branch_flag_is_dropped4:


		@@branch_display_stuff:


	//Test loading custom objects
	LBU a1, course_start_flag
	BNE a1, zero, @@run_at_start_of_course
		NOP
		JAL initCTF
		NOP


		//Set course start flag so that the above code only runs once
		LI a0, 1
		SB a0, course_start_flag
		@@run_at_start_of_course:


	//Jump back
	LW ra, 0x20 (sp)
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
		JAL displayScore
		NOP
		JAL displayTimer
		NOP
		JAL winConditions
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
	//Shorten lightning shrink time, otherwise use the default above
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
		JAL checkIfZeroHP
		NOP
		LI a1, 0x800F6A4C //Make player who is hot potato lightning strink for a split second to indicate the hit
		ADDU a1, a1, a3
		LI a2, 0x40
		SB a2, 0x0000 (a1)
		SB zero, who_was_hit_last //Set who is hot back to nothing
		LUI a0, hi(hotpotato_countdown_default)
		LH a1, lo(hotpotato_countdown_default) (a0) //Reset timer to default value
		SH a1, lo(hotpotato_countdown) (a0)
		@@branch_hurt_the_hot_potato:
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
		JAL displayScore //display HP
		NOP
		LBU v0, who_was_hit_last //display countdown
		BEQ v0, zero, @@branch_display_countdown
			NOP
			JAL displayCountdown
			NOP
			@@branch_display_countdown:
		JAL displayTimer //Dispaly timer
		NOP
		JAL winConditions
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
	//LBU a2, hp_or_points
	LBU a2, ffa_or_teams
	BNE a2, zero, @@branch_stock_on //If HP <= 3, in stock (not timed), respawn is off, in FFA mode, just return and use the game's built in ballons and skip all the custom HP code
		LBU a2, score_mode
		BNE a2, zero, @@branch_stock_on
			LBU v1, status_respawn 
			BNE v1, zero, @@branch_stock_on
				LHU a0, max_hp
				LI a1, 3
				SLT a2, a1, a0
				BNE a2, zero, @@branch_stock_on //If max HP <= 3, just jump back
					LW ra, 0x20 (sp)
					JR ra
					ADDI sp, sp, 0x30
		@@branch_stock_on:
	//Hit detection, HP, and killing player handling
	JAL hitDetection
	NOP
	LBU a0, who_was_hit_last //Load whoever might have been hit
	BEQ a0, zero, @@branch_player_was_hit
		ADDI a0, a0, -1 //Subtract 1 from $a0 to feed into the following functions
		JAL processHit
		NOP
		JAL checkIfZeroHP //Kill player if their HP = 0
		NOP
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
		JAL displayScore //Display HP
		NOP
		JAL displayTimer //Display timer(if in a time match)
		NOP
		JAL winConditions //If in team points scoring mode, check if a team has won
		NOP
		@@branch_run_counter_and_display_hp:
	//Jump back
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30


//Loop that runs in race
inRace:
	addi sp, sp, -0x30 //store registers
	sw ra, 0x001C (sp)


	JAL setCullDLParameters
	NOP


	//Fix for 3 player mode minimap togging on and off since the fix for the crash caused hte minimap to be untogglable
	LBU a0, 0x800DC53B
	LI a1, 3
	BNE a0, a1, @@branch_3_player_mimimap //If in 3P mode
		LHU a0, BUTTON_ACTIVATOR_1_P1
		ANDI a0, a0, 0x0001
		BEQ a0, zero, @@branch_3_player_mimimap_button_down //If P1 pressed the c-right button
			LI a1, 1
			SB a1, map_button_down_3p //Store byte that button was down
			B @@branch_3_player_mimimap //skip the rest of this code if the button is down
			NOP
			@@branch_3_player_mimimap_button_down:
		LBU a1, map_button_down_3p
		BEQ a1, zero, @@branch_3_player_mimimap //If button was held down but no longer is...
			LBU a0, map_toggle_3p
			BNE a0, zero, @@branch_3p_map_toggle_off 
				LH a1, 0x8018D2C0
				LI a2, 0x200
				SH a1, map_x_3p //Save current map position before moving it
				SH a2, 0x8018D2C0 //Move map off the screen
				LI a3, 1
				SB a3, map_toggle_3p //Set map toggle 3p byte to on
				@@branch_3p_map_toggle_off:
			BEQ a0, zero, @@branch_3p_map_toggle_on
				LH a1, map_x_3p
				SH a1, 0x8018D2C0
				SB zero, map_toggle_3p
				@@branch_3p_map_toggle_on:
			SB zero, map_button_down_3p //Set button held down byte to zero
		@@branch_3_player_mimimap:
	// JAL displayPlayerOnePosition
	// NOP


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
		//If tempo set to 60 FPS, run a few extra things so that it runs correctly in emulator at 2x speed, source: http://forum.pj64-emu.com/showthread.php?t=8848)
		LI a1, 1
		BNE a0, a1, @@branch_tempo_on
			LUI k0, 0x8000
			SB zero, 0x0FE3 (k0)
			// SB k1, 0x14CF (k0)
			// LI k1, 0x24010001
			LI k1, 0x24190001
			SW k1, 0x1890 (k0)
			SW k1, 0x1894 (k0)
			LI k1, 0x1C
			LUI k0, 0x8012
			SB k1, 0x2CBB (k0)
			// LUI k0, 0x800B
			// LI k1, 0x24010006
			// SW k1, 0xC5D4 (k0)
			LI a0, 0x0001 //hazard fix
			SH a0, 0x800DC55E
	@@branch_tempo_on:	


	//Lag fix (if on)
	LBU a0, lag_fix
	BEQ a0, zero, @@branch_lag_fix
		LI a0, 0xD
		SB a0, 0x800EA6D2
		@@branch_lag_fix:


	// JAL displayGameTempo
	// NOP



	//If 1 player full screen is on, run the external c function
	LBU a0, one_player_full_screen
	BEQ a0, zero, @@branch_one_player_full_screen
		NOP
		JAL onePlayerFullScreen
		NOP
		@@branch_one_player_full_screen:

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

	// JAL DynamicTempo
	// NOP


	JAL runBots //Test running battle bots in c
	NOP

	// //Run battle bots (
	// LI a0, 0x800F6990 //Only run if two or more players are alive
	// LI a1, 0xDD8
	// LI a2, 0xC0
	// LI v0, 0
	// LI v1, 3
	// @@branch_count_players_alive:  //loop through v1 and count down from 4 to zero
	// 	LBU t0, 0x0000 (a0)
	// 	BNE t0, a2, @@branch_this_player_is_alive
	// 	ADD a0, a0, a1
	// 		ADDI v0, v0, 1
	// 		@@branch_this_player_is_alive:
	// 	BNE v1, zero, @@branch_count_players_alive
	// 	ADDI v1, v1, -1
	// SLTI a0, v0, 2
	// BNE a0, zero, @@branch_skip_battle_bots //Only run battle bots if two or more players are alive
	// 	//Run bot respawning timer and index to use when bots fall off cliffs
	// 	LUI a0, hi(bot_respawn_timer)
	// 	JAL decrementTimer //Load respawn timer from ram and decrement it
	// 	LH a3, lo(bot_respawn_timer) (a0)
	// 	LBU t0, bot_respawn_flag
	// 	BEQ t0, zero, @@branch_bot_respawn_copy_coords
	// 	MOVE t0, zero
	// 		LBU t4, bot_respawn_index
	// 		SLT t0, a3, zero //If the bot respawn flag is on and timer is less than zero then copy the coordiantes
	// 		BEQ t0, zero, @@branch_restart_respawn_timer //If respawn timer is <= 0
	// 			ADDI t4, t4, 0xC
	// 			LI a1, 0x30
	// 			BNE t4, a1, @@branch_loop_bot_respawn_index
	// 				NOP
	// 				LI t4, 0 //Loop index
	// 				@@branch_loop_bot_respawn_index:
	// 			SB t4, bot_respawn_index
	// 			LI a3, 16 //Reset the bot respawn timer
	// 			@@branch_restart_respawn_timer:
	// 		SH a3, bot_respawn_timer //Store respawn timer back to RAM

	// 		@@branch_bot_respawn_copy_coords:



		// LUI a2, hi(bot_status_p1)
		// LBU a1, lo(bot_status_p1) (a2) //P1
		// BEQ a1, zero, @@branch_run_bot1
		// 	LI a0, 0
		// 	JAL runBot
		// 	NOP
		// 	BEQ t0, zero, @@branch_copy_coords_p1
		// 		LBU t1, 0x800F6A5A  //If falling over nothingness (pit or off the course)
		// 		ANDI t1, t1, 0x1
		// 		BNE t1, zero, @@branch_copy_coords_p1
		// 			LI v0, 0x800F69A4 //Copy x,y,z coords from ram
		// 			LW t1, 0x0000 (v0)//Use the 64 bitness of the Nintendo 64 for once
		// 			LW t2, 0x0004 (v0)
		// 			LW t3, 0x0008 (v0)
		// 			LI v0, bot_respawn_datastructure //Paste x,y,z coords into structure
		// 			ADDU v0, v0, t4 
		// 			SW t1, 0x0000 (v0)
		// 			SW t2, 0x0004 (v0)
		// 			SW t3, 0x0008 (v0)
		// 		@@branch_copy_coords_p1:
		// 	@@branch_run_bot1:
		// LBU a1, lo(bot_status_p2) (a2) //P2
		// BEQ a1, zero, @@branch_run_bot2
		// 	LI a0, 1
		// 	JAL runBot
		// 	NOP
		// 	BEQ t0, zero, @@branch_copy_coords_p2
		// 		LBU t1, 0x800F6A5A + player_state_offset   //If falling over nothingness (pit or off the course)
		// 		ANDI t1, t1, 0x1
		// 		BNE t1, zero, @@branch_copy_coords_p2
		// 			LI v0, 0x800F69A4 + player_state_offset //Copy x,y,z coords from ram
		// 			LW t1, 0x0000 (v0)
		// 			LW t2, 0x0004 (v0)
		// 			LW t3, 0x0008 (v0)
		// 			LI v0, bot_respawn_datastructure + bot_respawn_player_offset //Paste x,y,z coords into structure
		// 			ADDU v0, v0, t4 
		// 			SW t1, 0x0000 (v0)
		// 			SW t2, 0x0004 (v0)
		// 			SW t3, 0x0008 (v0)
		// 		@@branch_copy_coords_p2:
		// 	@@branch_run_bot2:
		// LBU a1, lo(bot_status_p3) (a2) //P3
		// BEQ a1, zero, @@branch_run_bot3
		// 	LI a0, 2
		// 	JAL runBot
		// 	NOP
		// 	BEQ t0, zero, @@branch_copy_coords_p3
		// 		LBU t1, 0x800F6A5A + 2*player_state_offset   //If falling over nothingness (pit or off the course)
		// 		ANDI t1, t1, 0x1
		// 		BNE t1, zero, @@branch_copy_coords_p3
		// 			LI v0, 0x800F69A4 + 2*player_state_offset //Copy x,y,z coords from ram
		// 			LW t1, 0x0000 (v0)
		// 			LW t2, 0x0004 (v0)
		// 			LW t3, 0x0008 (v0)
		// 			LI v0, bot_respawn_datastructure + 2*bot_respawn_player_offset //Paste x,y,z coords into structure
		// 			ADDU v0, v0, t4 
		// 			SW t1, 0x0000 (v0)
		// 			SW t2, 0x0004 (v0)
		// 			SW t3, 0x0008 (v0)
		// 		@@branch_copy_coords_p3:
		// 	@@branch_run_bot3:
		// LBU a1, lo(bot_status_p4) (a2) //P4
		// BEQ a1, zero, @@branch_run_bot4
		// 	LI a0, 3
		// 	JAL runBot
		// 	NOP
		// 	BEQ t0, zero, @@branch_copy_coords_p4
		// 		LBU t1, 0x800F6A5A + 3*player_state_offset   //If falling over nothingness (pit or off the course)
		// 		ANDI t1, t1, 0x1
		// 		BNE t1, zero, @@branch_copy_coords_p4
		// 			LI v0, 0x800F69A4 + 3*player_state_offset //Copy x,y,z coords from ram
		// 			LW t1, 0x0000 (v0)
		// 			LW t2, 0x0004 (v0)
		// 			LW t3, 0x0008 (v0)
		// 			LI v0, bot_respawn_datastructure + 3*bot_respawn_player_offset //Paste x,y,z coords into structure
		// 			ADDU v0, v0, t4 
		// 			SW t1, 0x0000 (v0)
		// 			SW t2, 0x0004 (v0)
		// 			SW t3, 0x0008 (v0)
		// 		@@branch_copy_coords_p4:
		// 	@@branch_run_bot4:
		// @@branch_skip_battle_bots:







	lbu a0, game_mode //IF game mode is shell shooter, skip autoitems and infinite green shells
	li a1, 6
	beq a0, a1, @@branch_shell_shooter_on 

		//auto items
		lb a1, status_item_autoitems
		beq a1, zero, @@branch_auto_items_on
			lbu a0, status_item_infgshells //If infinite greenshells are off, randomly assign tiems
			bne a0, zero, @@branch_auto_items_on
				lbu a2, random_number_generator //Load byte from RNG into $a2
				li a0, player_item_base //load base for player has an item memory location			
				sra a2, a2, 1 //Divide RNG value by two to double the probability of getting an item
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
	
	@@branch_shell_shooter_on:

	// If courses are set to flat, make all item boxes the same height off the ground
	LBU a0, status_options_flatcourses
	BEQ a0, zero, @@branch_flat_courses_set_on //If set to on


		LUI a0, hi(course_height)
		L.s f2, lo(course_height) (a0) //Set height of item boxes to be the course_height plus some small amount
		LI.s f4, 4.0
		ADD.s f2, f4, f2
		LI a0, 0x8015F9B8 //load beginning of item array
		LI a1, 0x80162508 //load end of item array
		mfc1 t0, f2
		LI t1, 0xC //Item box identifier
		LI t2, 0x2 //Flag for if item box is initialized
		//LW t0, course_height //Load item box height from course_height
		@@branch_item_box_height_DO: //DO while thorugh entire item array
			LHU a2, 0x0000 (a0)
			bne a2, t1, @@branch_object_is_item_box //If object is an item box
				LHU a2, 0x0006 (a0) //Load item box state to check if it is inialized
				BNE a2, t2, @@branch_item_box_initalized //If item box is initialized
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
	LBU a3, 0x5F5D (a0) //P1 1&2P modes
	LI a1, 7 //Blue shell value
	LI a2, 6 //Triple red shell value
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

	//Always run reset game to reset timers, scores, and other things when the game begins
	JAL resetGame
	NOP


	//run different battle modes
	lbu a0, game_mode //Load game mode (0=traditional, 1=hot potato, and so on and so forth...)
	//Traditional battle mode
	LI a1, 0
	BNE a0, a1, @@branch_game_mode_traditional_battle
	LI a1, 1
		JAL runGameModeTraditionalBattle
		NOP
		BEQ zero, zero, @@branch_finished_running_game_mode
		NOP
		@@branch_game_mode_traditional_battle:
	//Hot potato mode
	BNE a0, a1, @@branch_game_mode_hot_potato
	LI a1, 2
		JAL runGameModeHotPotato
		NOP
		BEQ zero, zero, @@branch_finished_running_game_mode
		NOP
		@@branch_game_mode_hot_potato:
	//Squish mode
	BNE a0, a1, @@branch_game_mode_squish
	LI a1, 3
		JAL runGameModeSquish
		NOP
		BEQ zero, zero, @@branch_finished_running_game_mode
		NOP
		@@branch_game_mode_squish:
	//CTF mode
	BNE a0, a1, @@branch_game_mode_ctf
	LI a1, 4
		JAL runGameModeCTF
		NOP
		BEQ zero, zero, @@branch_finished_running_game_mode
		NOP
		@@branch_game_mode_ctf:
	//Keep away mode
	BNE a0, a1, @@branch_game_mode_keep_away
	LI a1, 5
		JAL runGameModeKeepAway
		NOP
		BEQ zero, zero, @@branch_finished_running_game_mode
		NOP
		@@branch_game_mode_keep_away:
	//Zombombs mode
	BNE a0, a1, @@branch_game_mode_zombombs
	LI a1, 6
		JAL runGameModeZombombs
		NOP
		BEQ zero, zero, @@branch_finished_running_game_mode
		NOP
		@@branch_game_mode_zombombs:
	//shell shooter mode
	BNE a0, a1, @@branch_game_mode_shell_shooter
	LI a1, 7
		JAL runGameModeShellShooter
		NOP
		BEQ zero, zero, @@branch_finished_running_game_mode
		NOP
		@@branch_game_mode_shell_shooter:
	BNE a0, a1, @@branch_game_mode_coins
		NOP
		JAL runGameModeCoins
		NOP
		BEQ zero, zero, @@branch_finished_running_game_mode
		NOP
		@@branch_game_mode_coins:
	@@branch_finished_running_game_mode:


	// //Test mode
	// LW a1, 0x28 (sp)
	// LI a1, 3
	// BNE a0, a1, @@branch_game_mode_test
	// 	NOP
	// 	JAL runGameModeTest
	// 	NOP
	// 	@@branch_game_mode_test:

	//Run first person mode if that setting is on
	LBU a0, status_first_person
	BEQ a0, zero, @@branch_first_person
		NOP
		JAL FirstPersonCamera //Force first person perspective	
		NOP
		@@branch_first_person:

	//Display results if on results screen
	LBU a0, in_results
	BNE a0, zero, @@branch_display_results
		NOP
		JAL displayResults
		NOP
		@@branch_display_results:


	//If Max HP = 0, make everyone a ghost, why would anyone want zero HP anyway?
	LHU a0, max_hp
	BNE a0, zero, @@branch_max_hp_is_zero
		LI a1, 0x8
		SB a1, 0x800F699E
		SB a1, 0x800F7776
		SB a1, 0x800F854E
		SB a1, 0x800F9326

		@@branch_max_hp_is_zero:


	JAL customCourseRunEveryFrame
	NOP



	lw ra, 0x001C (sp)
	jr ra
	addi sp, sp, 0x30


//Function display menu option with ON/OFF
//a1 = y position
//a2 = text pointer
//a3 = Status byte
menuDispOnOff:
	LI a0, 0x8 //x position
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
	//addi a0, a0, 0x80 //X position (same as input + 0x88)
	LI a0, 0x90 //x position
	LW ra, 0x001C (sp)
	JR ra
	ADDI sp, sp, 0x20



//Function display HP menu item
//A1 = y position
menuDispHP:
	addi sp, sp, -0x24
	sw ra, 0x20 (sp)

	lh a3, max_hp //load max hp
	li a2, text_hp_long//text pointer for "HP"
	jal FUNCTION_DISPLAY_TEXT_AND_INT
	li a0, 0x8 //x

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
	li a0, 0x8

	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x24

//Function display max team points in menu
//A1 = y position
menuDispMaxPoints:
	addi sp, sp, -0x24
	sw ra, 0x20 (sp)

	LH a3, max_points
	li a2, text_max_points //text pointer
	jal FUNCTION_DISPLAY_TEXT_AND_INT
	li a0, 0x8

	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x24


//Function to display coins in menu
//A1 = y position
menuDispMaxCoins:
	addi sp, sp, -0x24
	sw ra, 0x20 (sp)

	LH a3, max_coins
	li a2, text_max_coins //text pointer
	jal FUNCTION_DISPLAY_TEXT_AND_INT
	li a0, 0x8

	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x24


//A1 = y position
menuDispHitCoinLoss:
	addi sp, sp, -0x24
	sw ra, 0x20 (sp)

	LH a3, hit_coin_loss
	li a2, text_hit_coin_loss //text pointer
	jal FUNCTION_DISPLAY_TEXT_AND_INT
	li a0, 0x8

	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x24


//Function to display max health in shell shooter menu
//A1 = y position
menuDispMaxHealth:
	addi sp, sp, -0x24
	sw ra, 0x20 (sp)

	LUI a3, hi(shooter_health_max)
	LWC1 f0, lo(shooter_health_max) (a3) //Load floating point value
	CVT.W.S f0,f0 //Convert floating point to int
	li a2, text_max_health //text pointer
	MFC1 a3, f0 //Move int to a3
	jal FUNCTION_DISPLAY_TEXT_AND_INT
	li a0, 0x8


	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x24


//Function to display max health in shell shooter menu
//A1 = y position
menuDispMaxAmmo:
	addi sp, sp, -0x24
	sw ra, 0x20 (sp)

	LUI a3, hi(shooter_ammo_max)
	LWC1 f0, lo(shooter_ammo_max) (a3) //Load floating point value
	CVT.W.S f0,f0 //Convert floating point to int
	li a2, text_max_ammo //text pointer
	MFC1 a3, f0 //Move int to a3
	jal FUNCTION_DISPLAY_TEXT_AND_INT
	li a0, 0x8


	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x24


//Function displays the scoring menu item

//a1 = y position
menuDispScoring:
	addi sp, sp, -0x30
	sw ra, 0x20 (sp)
	sw a1, 0x24 (sp)
	//SW a0, 0x28	(sp)

	//Display "SCORING"
	li a2, text_scoring
	li a0, 0x8 //x
	jal FUNCTION_DISPLAY_TEXT
	lw a1, 0x24 (sp) //y
	//Display which scoring mode is selected
	lbu a0, score_mode
	BNE a0, zero, @@branch_disp_stock
	LI t1, 1
		li a2, text_stock
		@@branch_disp_stock:
	BNE a0, t1, @@branch_disp_time
	LI t1, 2
		LI a2, text_time
		@@branch_disp_time:
	BNE a0, t1, @@branch_disp_points
		NOP
		LI a2, text_points
		 @@branch_disp_points:
	// bne a0, zero, @@branch_disp_stock
	// LI t0, 1
	// 	li a2, text_stock //Default text to stock
	// 	LBU t1, ffa_or_teams
	// 	BEQ t1, zero, @@branch_teams
	// 		NOP
	// 		LI a2, text_points
	// 	 	@@branch_teams:
	// 	LW a1, 0x28 (sp)
	// 	BEQ a1, zero, @@branch_force_points
	// 		NOP
	// 		LI a2, text_points
	// 		@@branch_force_points:
	// 	@@branch_disp_stock:
	// //Set to time
	// BNE a0, t0, @@branch_disp_time
	// LI t0, 2
	// 	li a2, text_time
	// 	@@branch_disp_time:

	//Show the selection option
	lw a1, 0x24 (sp) //y
	JAL FUNCTION_DISPLAY_TEXT
	ori a0, zero, 0x90 //x

	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x30




//Function displays the scoring menu item but without "score" instead of "stock"
//a1 = y position
menuDispCTFMode:
	addi sp, sp, -0x24
	sw ra, 0x20 (sp)
	sw a1, 0x24 (sp)

	//Display "CTF GAME"
	li a2, text_ctf_game
	li a0, 0x8 //x
	jal FUNCTION_DISPLAY_TEXT
	lw a1, 0x24 (sp) //y
	//Display which scoring mode is selected
	lbu a0, ctf_game_mode
	//Set 1 flag 
	bne a0, zero, @@branch_1_flag_ffa
	LI t0, 1
		li a2, text_1_flag
		@@branch_1_flag_ffa:
	//Set multiflag
	BNE a0, t0, @@branch_multiflag_ffa
		NOP
		li a2, text_multiflag
		@@branch_multiflag_ffa:

	//Show the selection option
	lw a1, 0x24 (sp) //y
	JAL FUNCTION_DISPLAY_TEXT
	ori a0, zero, 0x90 //x

	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x24


//Function displays bot character
//a1 = y position
//t0 = bot (0, 1, 2, 3)
menuDispBotCharacter:
	addi sp, sp, -0x30
	sw ra, 0x20 (sp)
	SW t0, 0x24 (sp)
	SW a1, 0x28 (sp)

	//Display player number
	LI a2, text_player //text "player"
	ADDI a3, t0, 1 //Player number
	JAL FUNCTION_DISPLAY_TEXT_AND_INT
	LI a0, 0x8 //x position

	LW t0, 0x24 (sp)
	LW a1, 0x28 (sp)
	LUI a0, hi(bot_status_p1) //Load bot status for a given player
	ADD a0, a0, t0
	LBU a0, lo(bot_status_p1) (a0)
	LI t0, 0
	BNE a0, t0, @@branch_bot_character_off //Bot off
	LI t0, 1
		LI a2, text_off
		@@branch_bot_character_off:
	BNE a0, t0, @@branch_bot_character_mario //Bot is Mario
	LI t0, 2
		LI a2, text_char_mario
		@@branch_bot_character_mario:
	BNE a0, t0, @@branch_bot_character_luigi //Bot is Luigi
	LI t0, 3
		LI a2, text_char_luigi
		@@branch_bot_character_luigi:
	BNE a0, t0, @@branch_bot_character_peach //Bot is Peach
	LI t0, 4
		LI a2, text_char_peach
		@@branch_bot_character_peach:
	BNE a0, t0, @@branch_bot_character_toad //Bot is Toad
	LI t0, 5
		LI a2, text_char_toad
		@@branch_bot_character_toad:
	BNE a0, t0, @@branch_bot_character_yoshi //Bot is Yoshi
	LI t0, 6
		LI a2, text_char_yoshi
		@@branch_bot_character_yoshi:
	BNE a0, t0, @@branch_bot_character_dk //Bot is Donkey Kong
	LI t0, 7
		LI a2, text_char_dk
		@@branch_bot_character_dk:
	BNE a0, t0, @@branch_bot_character_wario //Bot is Wario
	LI t0, 8
		LI a2, text_char_wario
		@@branch_bot_character_wario:
	BNE a0, t0, @@branch_bot_character_bowser //Bot is Bowser
		NOP
		LI a2, text_char_bowser
		@@branch_bot_character_bowser:

	JAL FUNCTION_DISPLAY_TEXT
	ori a0, zero, 0x90 //x


	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x30


//Function displays the bot AI type menu item
//a1 = y position
menuDispBotType:
	addi sp, sp, -0x24
	sw ra, 0x20 (sp)
	sw a1, 0x24 (sp)

	//Display "BOT AI TYPE"
	LI a2, text_bot_ai_type
	LI a0, 0x8 //x
	JAL FUNCTION_DISPLAY_TEXT
	LW a1, 0x24 (sp) //y
	//Display which bot AI type is selected
	LBU a0, bot_ai_type
	//Set to seeker
	BNE a0, zero, @@branch_disp_ai_seeker
	LI t0, 1
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
	ori a0, zero, 0x90 //x


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
	li a2, text_countdown //text pointer
	mflo a3 //a33 is the integer ti display
	jal FUNCTION_DISPLAY_TEXT_AND_INT
	li a0, 0x8 //x

	lw ra, 0x20 (sp)
	jr ra
	addi sp, sp, 0x24

//Function displays FFA vs. teams menu item
//a1 = y position
menuDispFFAOrTeams:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)
	SW a1, 0x0024 (sp)

	//Display "FFA/TEAMS"
	LI a2, text_ffa_or_teams
	LI a0, 0x8 //x
	JAL FUNCTION_DISPLAY_TEXT
	LW a1, 0x24 (sp) //y
	//Display selected option
	LBU a0, ffa_or_teams
	BNE a0, zero, @@branch_ffa
	LI a1, 1
		LI a2, text_ffa
		@@branch_ffa:
	BNE a0, a1, @@branch_teams
		NOP
		LI a2, text_teams
		@@branch_teams:
	lw a1, 0x24 (sp) //y
	JAL FUNCTION_DISPLAY_TEXT
	ori a0, zero, 0x90 //x

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024



//Function displays options for coin mode on the "GAME" page of menu
menuDispModeCoins:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)

	//Display FFA or teams menu option
	JAL menuDispFFAOrTeams
	LI a1, 0x4C

	//Display scoring menu option
	JAL menuDispScoring
	LI a1, 0x58 //y

	//If scoring is set to Stock, display HP or POINTS depending on if in FFA or teams
	lbu v0, score_mode
	LI v1, 2
	bne v0, v1, @@branch_selection_points
		NOP
		jal menuDispMaxPoints
		li a1, 0x64 //y
		@@branch_selection_points:
	//If scoring is set to TIME
	LI v1, 1
	BNE v1, v0, @@branch_selection_time
	LI v1, 2		
		jal menuDispTime
		li a1, 0x64 //y
		@@branch_selection_time:


	//Display max coins menu option
	JAL menuDispMaxCoins
	LI a1, 0x70 //y

	//Display hit coin loss menu option
	JAL menuDispHitCoinLoss
	LI a1, 0x7C //y

	//Set max distance you can scroll down in y on menu
	LI a1, 6
	SB a1, MENU_Y_MAX

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024




//Function displays options for shell shooter on the "GAME" page of menu
menuDispModeShellShooter:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)


	//Display FFA or teams menu option
	JAL menuDispFFAOrTeams
	LI a1, 0x4C

	//Display scoring menu option
	JAL menuDispScoring
	LI a1, 0x58 //y


	//If scoring is set to Stock, display HP
	lbu v0, score_mode
	bne v0, zero, @@branch_selection_stock
	LI v1, 1
		jal menuDispHP
		li a1, 0x64 //y
		jal menuDispMaxAmmo
		li a1, 0x70 //y
		jal menuDispMaxHealth
		li a1, 0x7C //y		
		@@branch_selection_stock:
	//If scoring is set to TIME
	BNE v1, v0, @@branch_selection_time
	LI v1, 2		
		jal menuDispTime
		li a1, 0x64 //y
		li a2, text_minus_one_when_hit
		LBU a3, being_hit_lowers_score
		jal menuDispOnOff
		li a1, 0x70 //y
		li a2, text_plus_one_hit_enemy
		LBU a3, hitting_someone_raises_score
		jal menuDispOnOff
		li a1, 0x7C //y
		jal menuDispMaxAmmo
		li a1, 0x88 //y
		jal menuDispMaxHealth
		li a1, 0x94 //y

		@@branch_selection_time:
	//If scoring is set to Points
	BNE v1, v0, @@branch_selection_points
		NOP
		JAL menuDispMaxPoints
		li a1, 0x64 //y
		li a2, text_minus_one_when_hit
		LBU a3, being_hit_lowers_score
		jal menuDispOnOff
		li a1, 0x70 //y
		jal menuDispMaxAmmo
		li a1, 0x7C //y		
		jal menuDispMaxHealth
		li a1, 0x88 //y
		@@branch_selection_points:




	//Set max distance you can scroll down in y on menu
	LI a1, 8
	SB a1, MENU_Y_MAX

	// //Set variable for this mode to be hit based (not objective based)
	// SB zero, hit_or_objective

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024



//Function displays options for test battle mode on the "GAME" page of menu
menuDisplayModeKeepAway:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)

	//Display FFA or teams menu option
	JAL menuDispFFAOrTeams
	LI a1, 0x4C //y

	//Display scoring menu option
	JAL menuDispScoring
	LI a1, 0x58 //y

	//If scoring is set to Stock, display HP or POINTS depending on if in FFA or teams
	lbu v0, score_mode
	LI v1, 2
	bne v0, v1, @@branch_selection_points
		NOP
		jal menuDispMaxPoints
		li a1, 0x64 //y
		@@branch_selection_points:
	//If scoring is set to TIME
	LI v1, 1
	BNE v1, v0, @@branch_selection_time
	LI v1, 2		
		jal menuDispTime
		li a1, 0x64 //y
		@@branch_selection_time:

	//Display no items when holding flag menu option
	li a2, text_no_items_with_flag //text pointer
	lbu a3, no_items_when_holding_flag //status byte
	jal menuDispOnOff
	li a1, 0x70 //y

	//Display slow when holding flag menu option
	li a2, text_slow_with_flag //text pointer
	lbu a3, slow_when_holding_flag //status byte
	jal menuDispOnOff
	li a1, 0x7C //y




	//Set max distance you can scroll down in y on menu
	LI a1, 6
	SB a1, MENU_Y_MAX

	// //Set variable for this mode to be object (not hits)
	// LI a0, 1
	// SB a0, hit_or_objective

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024


//Function displays options for Zombombs battle mode on the "GAME" page of menu
menuDisplayModeZombombs:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)

	jal menuDispTime
	li a1, 0x4C //y


	// //Display bombs reapwn menu option
	// li a2, text_bombs_respawn //text pointer
	// lbu a3, status_bombs_respawn //status byte
	// jal menuDispOnOff
	// li a1, 0x58 //y

	//Set max distance you can scroll down in y on menu
	LI a1, 2
	SB a1, MENU_Y_MAX


	//Set score mode to 

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024


//Function displays options for test battle mode on the "GAME" page of menu
menuDispModeTest:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)



	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024



//Function displays options for CTF mode on the "GAME" page of menu
menuDispModeCTF:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)


	//Display FFA or teams menu option
	JAL menuDispFFAOrTeams
	LI a1, 0x4C //y

	//Display scoring menu option
	JAL menuDispScoring
	LI a1, 0x58 //y



	//If scoring is set to Stock, display HP or POINTS depending on if in FFA or teams
	lbu v0, score_mode
	LI v1, 2
	bne v0, v1, @@branch_selection_points
		NOP
		jal menuDispMaxPoints
		li a1, 0x64 //y
		@@branch_selection_points:
	//If scoring is set to TIME
	LI v1, 1
	BNE v1, v0, @@branch_selection_time
	LI v1, 2		
		jal menuDispTime
		li a1, 0x64 //y
		@@branch_selection_time:

	//Display CTF game mode
	JAL menuDispCTFMode
	LI a1, 0x70 //y


	//Display no items when holding flag menu option
	li a2, text_no_items_with_flag //text pointer
	lbu a3, no_items_when_holding_flag //status byte
	jal menuDispOnOff
	li a1, 0x7C //y

	//Display slow when holding flag menu option
	li a2, text_slow_with_flag //text pointer
	lbu a3, slow_when_holding_flag //status byte
	jal menuDispOnOff
	li a1, 0x88 //y




	//Set max distance you can scroll down in y on menu
	LI a1, 7
	SB a1, MENU_Y_MAX

	// //Set variable for this mode to be object (not hits)
	// LI a0, 1
	// SB a0, hit_or_objective

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024



//Function displays options for squish battle mode on the "GAME" page of menu
menuDispModeSquish:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)

	//Display FFA or teams menu option
	JAL menuDispFFAOrTeams
	LI a1, 0x4C


	//Display scoring menu option
	JAL menuDispScoring
	LI a1, 0x58 //y

	//If scoring is set to Stock, display HP
	lbu v0, score_mode
	bne v0, zero, @@branch_selection_stock
	LI v1, 1
		jal menuDispHP
		li a1, 0x64 //y
		@@branch_selection_stock:
	//If scoring is set to TIME
	BNE v1, v0, @@branch_selection_time
	LI v1, 2		
		jal menuDispTime
		li a1, 0x64 //y
		li a2, text_minus_one_when_hit
		LBU a3, being_hit_lowers_score
		jal menuDispOnOff
		li a1, 0x70 //y
		li a2, text_plus_one_hit_enemy
		LBU a3, hitting_someone_raises_score
		jal menuDispOnOff
		li a1, 0x7C //y

		@@branch_selection_time:
	//If scoring is set to Points
	BNE v1, v0, @@branch_selection_points
		NOP
		JAL menuDispMaxPoints
		li a1, 0x64 //y
		li a2, text_minus_one_when_hit
		LBU a3, being_hit_lowers_score
		jal menuDispOnOff
		li a1, 0x70 //y
		@@branch_selection_points:



	//Set max distance you can scroll down in y on menu
	LI a1, 6
	SB a1, MENU_Y_MAX


	// //Display FFA or teams menu option
	// JAL menuDispFFAOrTeams
	// LI a1, 0x4C

	// //Display scoring menu option
	// LI a0, 0
	// JAL menuDispScoring
	// LI a1, 0x58 //y


	// //If scoring is set to Stock, display HP or POINTS depending on if in FFA or teams
	// lbu v0, score_mode
	// bne v0, zero, @@branch_selection_stock
	// 	LBU v1, ffa_or_teams
	// 	BNE v1, zero, @@branch_selection_stock_hp
	// 		NOP
	// 		jal menuDispHP
	// 		li a1, 0x64 //y
	// 		@@branch_selection_stock_hp:
	// 	LBU v1, ffa_or_teams
	// 	BEQ v1, zero, @@branch_selection_stock_points
	// 		NOP
	// 		jal menuDispMaxPoints
	// 		li a1, 0x64 //y
	// 		@@branch_selection_stock_points:
	// 	@@branch_selection_stock:
	// //If scoring is set to TIME
	// LI v1, 1
	// BNE v1, v0, @@branch_selection_time
	// LI v1, 2		
	// 	jal menuDispTime
	// 	li a1, 0x64 //y
	// 	@@branch_selection_time:


	// //Display respawn menu option
	// li a2, text_respawn //text pointer
	// lbu a3, status_respawn //status byte
	// jal menuDispOnOff
	// li a1, 0x70 //y

	// //Set max distance you can scroll down in y on menu
	// LI a1, 5
	// SB a1, MENU_Y_MAX

	// //Set variable for this mode to be hit based (not objective based)
	// SB zero, hit_or_objective

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024



//Function displays options for hot potato battle mode on the "GAME" page of menu
menuDispModeHotpotato:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)


	//Display FFA or teams menu option
	JAL menuDispFFAOrTeams
	LI a1, 0x4C

	//Display scoring menu option
	JAL menuDispScoring
	LI a1, 0x58 //y

	//If scoring is set to Stock, display HP or POINTS depending on if in FFA or teams
	lbu v0, score_mode
	bne v0, zero, @@branch_selection_stock
	LI v1, 1	
		jal menuDispHP
		li a1, 0x64 //y:
		@@branch_selection_stock:
	//If scoring is set to TIME
	BNE v1, v0, @@branch_selection_time
	LI v1, 2		
		jal menuDispTime
		li a1, 0x64 //y
		@@branch_selection_time:




	//Display countdown menu option
	jal menuDispCountdown
	li a1, 0x70 //y



	//Set max distance you can scroll down in y on menu
	LI a1, 5
	SB a1, MENU_Y_MAX

	//Set variable for this mode to be hit based (not objective based)
	//SB zero, hit_or_objective

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024


//Function displays options for tradiational battle mode on the "GAME" page of menu
menuDispModeTraditional:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)

	//Display FFA or teams menu option
	JAL menuDispFFAOrTeams
	LI a1, 0x4C


	//Display scoring menu option
	JAL menuDispScoring
	LI a1, 0x58 //y

	//If scoring is set to Stock, display HP
	lbu v0, score_mode
	bne v0, zero, @@branch_selection_stock
	LI v1, 1
		jal menuDispHP
		li a1, 0x64 //y
		@@branch_selection_stock:
	//If scoring is set to TIME
	BNE v1, v0, @@branch_selection_time
	LI v1, 2		
		jal menuDispTime
		li a1, 0x64 //y
		li a2, text_minus_one_when_hit
		LBU a3, being_hit_lowers_score
		jal menuDispOnOff
		li a1, 0x70 //y
		li a2, text_plus_one_hit_enemy
		LBU a3, hitting_someone_raises_score
		jal menuDispOnOff
		li a1, 0x7C //y

		@@branch_selection_time:
	//If scoring is set to Points
	BNE v1, v0, @@branch_selection_points
		NOP
		JAL menuDispMaxPoints
		li a1, 0x64 //y
		li a2, text_minus_one_when_hit
		LBU a3, being_hit_lowers_score
		jal menuDispOnOff
		li a1, 0x70 //y
		@@branch_selection_points:


	//Set max distance you can scroll down in y on menu
	LI a1, 6
	SB a1, MENU_Y_MAX

	// //Set variable for this mode to be hit based (not objective based)
	// SB zero, hit_or_objective

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024




//Function displays "GAME" page of menu
menuDispPageGame:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)

	//Display "MODE"
	LI a2, text_game_mode //text pointer
	LI a0, 0x8 //x
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
	//Display "CAPTURE THE FLAG"
	LI t1, 3
	BNE t0, t1, @@BRANCH_MODE_SELECT_CTF
		NOP
		LI a2, text_capture_the_flag
		@@BRANCH_MODE_SELECT_CTF:
	//Display Keep Away
	LI t1, 4
	BNE t0, t1, @@BRANCH_MODE_SELECT_KEEP_AWAY
		NOP
		LI a2, text_keep_away
		@@BRANCH_MODE_SELECT_KEEP_AWAY:
	//Display zombombs
	LI t1, 5
	BNE t0, t1, @@BRANCH_MODE_SELECT_ZOMBOMBS
		NOP
		LI a2, text_zombombs
		@@BRANCH_MODE_SELECT_ZOMBOMBS:
	//Display Shell Shooter
	LI t1, 6
	BNE t0, t1, @@BRANCH_MODE_SELECT_FPS
		NOP
		LI a2, text_shell_shooter
		@@BRANCH_MODE_SELECT_FPS:
	LI t1, 7
	BNE t0, t1, @@BRANCH_MODE_SELECT_COINS
		NOP
		LI a2, text_coins
		@@BRANCH_MODE_SELECT_COINS:


	//Actually show the selected option
	LI a0, 0x90 //x
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

	//Display CTF
	LBU a0, game_mode	
	LI a1, 3
	BNE a0, a1, @@BRANCH_MODE_DISPLAY_CTF
		NOP
		JAL menuDispModeCTF
		NOP
		@@BRANCH_MODE_DISPLAY_CTF:




	//Display "KEEP AWAY"
	LBU a0, game_mode	
	LI a1, 4
	BNE a0, a1, @@BRANCH_MODE_DISPLAY_KEEP_AWAY
		NOP
		JAL menuDisplayModeKeepAway
		NOP
		@@BRANCH_MODE_DISPLAY_KEEP_AWAY:

	//Display "ZOMBOMBS"
	LBU a0, game_mode	
	LI a1, 5
	BNE a0, a1, @@BRANCH_MODE_DISPLAY_ZOMBOMBS
		NOP
		JAL menuDisplayModeZombombs
		NOP
		@@BRANCH_MODE_DISPLAY_ZOMBOMBS:


	//Display "SHELL SHOOTER"
	LBU a0, game_mode	
	LI a1, 6
	BNE a0, a1, @@BRANCH_MODE_DISPLAY_SHELL_SHOOTER
		NOP
		JAL menuDispModeShellShooter
		NOP
		@@BRANCH_MODE_DISPLAY_SHELL_SHOOTER:
	LBU a0, game_mode	
	LI a1, 6
	BEQ a0, a1, @@BRANCH_MODE_NOT_SHELL_SHOOTER
		//Restore default green shell behavior when not in shell shooter
		li a0, 0x0C0AB026 //Green shells will bounce when they hit a wall
		SW a0, 0x802B3948
		li a0, 0x02202825
		//SW a0, 0x802B3950
		SW a0, 0x802B394C
		li a0, 0x5140018C //Shells can be held behind you
		SW a0, 0x802B3500
		li a0, 0xE6040028 //Restore the ability of green shells to fall
		SW a0, 0x802B3870
		@@BRANCH_MODE_NOT_SHELL_SHOOTER:

	//Display coins
	LBU a0, game_mode	
	LI a1, 7
	BNE a0, a1, @@BRANCH_MODE_DISPLAY_COINS
		NOP
		JAL menuDispModeCoins
		NOP
		@@BRANCH_MODE_DISPLAY_COINS:

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

	//Display "PLAYER 1"
	LI t0, 0
	JAL menuDispBotCharacter
	LI a1, 0x40 //y

	//Display "PLAYER 2"
	LI t0, 1
	JAL menuDispBotCharacter
	LI a1, 0x4C //y

	//Display "PLAYER 3"
	LI t0, 2
	JAL menuDispBotCharacter
	LI a1, 0x58 //y

	//Display "PLAYER 4"
	LI t0, 3
	JAL menuDispBotCharacter
	LI a1, 0x64 //y

	JAL menuDispBotType //Dispaly bot AI type
	LI a1, 0x70 //y

	// LI a2, text_bots_cannot_Fall //Display "BOTS CANNOT FALL"
	// LBU a3, bot_respawn_flag
	// JAL menuDispOnOff
	// LI a1, 0x7C //y

	LI a2, text_bot_use_items //Display "BOTS USE ITEMS"
	LBU a3, bot_use_items
	JAL menuDispOnOff
	//LI a1, 0x88 //y
	LI a1, 0x7C //y


	LI a2, text_1p_full_screen //Display "1P FULL SCREEN"
	LBU a3, one_player_full_screen
	JAL menuDispOnOff
	// LI a1, 0x94 //y
	LI a1, 0x88 //y

	LI a2, text_target_humans //Display "1P FULL SCREEN"
	LBU a3, bots_target_humans
	JAL menuDispOnOff
	LI a1, 0x94 //y	


	//Set max distance you can scroll down in y on menu
	LI a1, 8
	SB a1, MENU_Y_MAX

	LW ra, 0x0020 (sp)
	JR ra
	ADDI sp, sp, 0x0024



//Function displays "OPTIONS" page of menu
menuDispPageGraphics:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x0020 (sp)

	//Display "FIRST PERSON"
	LI a2, text_first_person
	LBU a3, status_first_person
	JAL menuDispOnOff
	LI a1, 0x40 //y

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

	//Display Game Temp
	LI a2, text_options_gametempo
	LI a0, 0x8 //x pos
	JAL FUNCTION_DISPLAY_TEXT //display text
	LI a1, 0x64 //y pos
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
	LI a0, 0x90 //x pos
	JAL FUNCTION_DISPLAY_TEXT //display text
	LI a1, 0x64 //y pos

	//Display lag fix
	li a2, text_lag_fix
	lbu a3, lag_fix
	JAL menuDispOnOff
	li a1, 0x70	

	//Display emulator cull mode
	li a2, text_using_hle
	lbu a3, using_hle
	JAL menuDispOnOff
	li a1, 0x7C


	//Display "MINIMAP"
	LI a2, text_options_mimimap
	LBU a3, status_options_minimap
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
		LI a0, 0x0C023D25 //jal   SetRolloverFall //Re-enable tumbling
		SW a0, 0x8002E154 
		SW a0, 0x8002CA08
		// LI a0, 0x0C01E6D0 //jal   func_80079B40 //re-enable Lakitu for out of bounds
		// SW a0, 0x8007A9D0
		LI a0, 0x0D //re-enable Lakitu for out of bounds
		SB a0, 0x800798E7
	@@BRANCH_FLAT_COURSES_ON:


	//Display "3P/4P MUSIC"
	LI a2, text_options_3P4Pmusic
	LBU a3, status_options_3P4Pmusic
	JAL menuDispOnOff
	LI a1, 0x4C //y

	//Display "SAME CHARS"
	LI a2, text_options_samechars
	LBU a3, status_options_samechars
	JAL menuDispOnOff
	LI a1, 0x58 //y




	//Display "LUDICROUS SPEED"
	LI a2, text_options_ludicrousspeed
	LBU a3, status_options_ludicrousspeed
	JAL menuDispOnOff
	LI a1, 0x64 //y

	//Display respawn
	li a2, text_respawn //text pointer
	lbu a3, status_respawn //status byte
	jal menuDispOnOff
	li a1, 0x70 //y



	//Display restore defaults
	LBU a3, status_restore_defaults
	LI a2, text_restore_defaults
	LI a0, 1
	BNE a3, a0, @@branch_display_restore_defaults_text_1
	LI a0, 3
		LI a2, text_restore_defaults_are_you_sure
		@@branch_display_restore_defaults_text_1:
	BNE a3, a0, @@branch_display_restore_defaults_text_2
	LI a0, 2
		LI a2, text_restore_defaults_are_you_sure
		LI a0, 1
		SB a0, status_restore_defaults
		@@branch_display_restore_defaults_text_2:
	BNE a3, a0, @@branch_display_restore_defaults_text_3
		NOP
		JAL setDefaults
		NOP
		LI a0, 1 
		SB a0, boot_flag//Ensure boot flag is correct
		LI a0, -1
		SB a0, game_mode //Keep game mode from moving to the right one after reset
		@@branch_display_restore_defaults_text_3:
	LI a0, 0x8 //x pos
	JAL FUNCTION_DISPLAY_TEXT //display text
	LI a1, 0x7C //y pos

	//Set max distance you can scroll down in y on the menu
	LI a1, 6
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
//t2 = number min
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
		ADDI a2, t2, -1
		bne t1, a2, @@branch_number_too_low
			nop
			MOVE t1, t0 //Set to max
		@@branch_number_too_low:
		//if number is too high, reset to min
		MOVE a2, t0 //Calculate max + 1
		ADDI a2, a2, 1
		bne t1, a2, @@branch_number_too_high
			nop
			MOVE t1, t2 //set to min
		@@branch_number_too_high:
	@@branch_menu_selection_is_it:
	jr ra
	nop




//Handles toggling for menu for score modes
//with no stock, only time or scoring modes
//A1 = Joystick value
//A2 = Menu item index
//A3 = Current menu index selected
menuTogglePointOrTimeScoreMode:
	LB t1, score_mode //load status pointer
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
		li a2, 0
		bne t1, a2, @@branch_number_too_low
			nop
			LI t1, 2 //Set to max
		@@branch_number_too_low:
		//if number is too high, reset to min
		LI a2, 3
		bne t1, a2, @@branch_number_too_high
			nop
			li t1, 1
		@@branch_number_too_high:
	@@branch_menu_selection_is_it:
	SB t1, score_mode
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



//Function handles toggling a float up or down in the menu 
//A0 = Menu item status pointer
//A1 = Joystick value
//A2 = Menu item index
//A3 = Current menu index selected
//t0 = number max
menuToggleFloat:
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)

	LWC1 f0, (a0) //Load floating point value
	CVT.W.S f0,f0 //Convert floating point to int
	MFC1 t1, f0 //Move int t1

	JAL menuToggleNumber
	NOP

	MTC1 t1, f0 //Move int t1 to float point register
	CVT.S.W f0,f0 //Convert int to float
	SWC1 f0, (a0) //Store floating point value	

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


	//If menu selection is FFA or Teams
	LI a0, ffa_or_teams //Load status pointer
	LI a2, 1 //menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 1 //max number


	//if menu selection is scoring
	LI a0, score_mode //load status pointer
	LI a2, 2 //menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 2 //max number
	

	//if scoring is set to stock
	li a2, 3 //menu index
	lbu v0, score_mode
	bne v0, zero, @@branch_selection_stock
		// LBU t9, ffa_or_teams
		// BNE t9, zero, @@branch_selection_stock_hp
		LI a0, max_hp
		LI t2, 1 //min number
		JAL menuToggleHalf
		LI t0, 9999 //How high can the HP go'

		LI a0, 0xFF //Turn being hit will lower your score on for HP mode
		SB a0, being_hit_lowers_score

		LI a0, 0 //Turn hitting someone will raise your score off for HP mode
		SB a0, hitting_someone_raises_score
		@@branch_selection_stock:
	//If scoring is set to TIME
	LI v1, 1
	BNE v1, v0, @@branch_selection_time
		nop
		jal menuToggleTimer
		nop

		li a0, being_hit_lowers_score //load status pointer
		jal menuToggleOnoff
		li a2, 4 //menu index

		li a0, hitting_someone_raises_score //load status pointer
		jal menuToggleOnoff
		li a2, 5 //menu index


		@@branch_selection_time:
	LI v1, 2
	BNE v1, v0, @@branch_selection_points
		LI a0, max_points
		LI t2, 1 //min number
		JAL menuToggleHalf
		LI t0, 9999 //How high can the HP go

		li a0, being_hit_lowers_score //load status pointer
		jal menuToggleOnoff
		li a2, 4 //menu index

		LI a0, 0xFF //Turn hitting someone will raise your score on for points mode
		SB a0, hitting_someone_raises_score
		@@branch_selection_points:

		//

	lw ra, 0x1C (sp)
	jr ra
	addi sp, sp, 0x24

//Menu toggling on game page for hot potato battle
menuToggleGameHotpotato:
	addi sp, sp, -0x24
	sw ra, 0x1C (sp)

	LI a0, 0xFF //Turn being hit will lower your score on for HP mode
	SB a0, being_hit_lowers_score
	LI a0, 0 //Turn hitting someone will raise your score off for HP mode
	SB a0, hitting_someone_raises_score

	//If menu selection is FFA or Teams
	LI a0, ffa_or_teams //Load status pointer
	LI a2, 1 //menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 1 //max number

	//if scoring is set to stock
	lbu v0, score_mode
	LI a0, 2
	BNE v0, a0, @@branch_hotpotato_points_to_stock //If score mode is points, change back to stock
		NOP
		SB zero, score_mode
		@@branch_hotpotato_points_to_stock:


	//if menu selection is scoring
	LI a0, score_mode //load status pointer
	LI a2, 2 //menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 1 //max number




	//if scoring is set to stock
	li a2, 3 //menu index
	lbu v0, score_mode
	bne v0, zero, @@branch_selection_stock
		// LBU t9, ffa_or_teams
		// BNE t9, zero, @@branch_selection_stock_hp
		LI a0, max_hp
		LI t2, 1 //min number
		JAL menuToggleHalf
		LI t0, 9999 //How high can the HP go'

		LI a0, 0xFF //Turn being hit will lower your score on for HP mode
		SB a0, being_hit_lowers_score

		LI a0, 0 //Turn hitting someone will raise your score off for HP mode
		SB a0, hitting_someone_raises_score
		@@branch_selection_stock:
	//If scoring is set to TIME
	LI v1, 1
	BNE v1, v0, @@branch_selection_time
		nop
		jal menuToggleTimer
		nop
		@@branch_selection_time:
	// 		LI a0, max_hp
	// 		JAL menuToggleHalf
	// 		LI t0, 9999 //How high can the HP go
	// 		SB zero, hp_or_points //Set byte to show we are storing hp and not points
	// 		@@branch_selection_stock_hp:
	// 	BEQ t9, zero, @@branch_selection_stock_points
	// 		LI a0, max_points
	// 		JAL menuToggleHalf
	// 		LI t0, 9999 //How high can the points go
	// 		SB zero, hp_or_points //Set byte to show we are storing points and not hp
	// 		LI t0, 1
	// 		SB t0, hp_or_points //Set byte to show we are storing points and not hp
	// 		@@branch_selection_stock_points:
	// 	@@branch_selection_stock:
	// //If scoring is set to TIME
	// LI v1, 1
	// BNE v1, v0, @@branch_selection_time
	// 	nop
	// 	jal menuToggleTimer
	// 	nop
	// 	LI t0, 1
	// 	SB t0, hp_or_points //Set byte to show we are storing points and not hp
	// 	@@branch_selection_time:


	//If menu selection is countdown
	jal menuToggleCountdown
	li a2, 4 //menu index


	lw ra, 0x1C (sp)
	jr ra
	addi sp, sp, 0x24


//Menu toggling on game page for squish battle
menuToggleGameSquish:
	addi sp, sp, -0x24
	sw ra, 0x1C (sp)

	// LI a0, 0 //Turn hitting someone will raise your score off for squish mode
	// SB a0, hitting_someone_raises_score


	//If menu selection is FFA or Teams
	LI a0, ffa_or_teams //Load status pointer
	LI a2, 1 //menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 1 //max number


	//if menu selection is scoring
	LI a0, score_mode //load status pointer
	LI a2, 2 //menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 2 //max number
	

	//if scoring is set to stock
	li a2, 3 //menu index
	lbu v0, score_mode
	bne v0, zero, @@branch_selection_stock
		// LBU t9, ffa_or_teams
		// BNE t9, zero, @@branch_selection_stock_hp
		LI a0, max_hp
		LI t2, 1 //min number
		JAL menuToggleHalf
		LI t0, 9999 //How high can the HP go'

		LI a0, 0xFF //Turn being hit will lower your score on for HP mode
		SB a0, being_hit_lowers_score

		LI a0, 0 //Turn hitting someone will raise your score off for HP mode
		SB a0, hitting_someone_raises_score
		@@branch_selection_stock:
	//If scoring is set to TIME
	LI v1, 1
	BNE v1, v0, @@branch_selection_time
		nop
		jal menuToggleTimer
		nop

		li a0, being_hit_lowers_score //load status pointer
		jal menuToggleOnoff
		li a2, 4 //menu index

		li a0, hitting_someone_raises_score //load status pointer
		jal menuToggleOnoff
		li a2, 5 //menu index


		@@branch_selection_time:
	LI v1, 2
	BNE v1, v0, @@branch_selection_points
		LI a0, max_points
		LI t2, 1 //min number
		JAL menuToggleHalf
		LI t0, 9999 //How high can the HP go

		li a0, being_hit_lowers_score //load status pointer
		jal menuToggleOnoff
		li a2, 4 //menu index

		LI a0, 0xFF //Turn hitting someone will raise your score on for points mode
		SB a0, hitting_someone_raises_score
		@@branch_selection_points:

		

	// //If menu selection is FFA or Teams
	// LI a0, ffa_or_teams //Load status pointer
	// LI a2, 1 //menu index
	// JAL menuToggleByte
	// LI t0, 1

	// //if menu selection is scoring
	// LI a0, score_mode //load status pointer
	// LI a2, 2 //menu index
	// JAL menuToggleByte
	// LI t0, 1

	// //if scoring is set to stock
	// li a2, 3 //menu index
	// lbu v0, score_mode
	// bne v0, zero, @@branch_selection_stock
	// 	LBU t9, ffa_or_teams
	// 	BNE t9, zero, @@branch_selection_stock_hp
	// 		LI a0, max_hp
	// 		JAL menuToggleHalf
	// 		LI t0, 9999 //How high can the HP go
	// 		SB zero, hp_or_points //Set byte to show we are storing hp and not points
	// 		@@branch_selection_stock_hp:
	// 	BEQ t9, zero, @@branch_selection_stock_points
	// 		LI a0, max_points
	// 		JAL menuToggleHalf
	// 		LI t0, 9999 //How high can the points go
	// 		LI t0, 1
	// 		SB t0, hp_or_points //Set byte to show we are storing points and not hp
	// 		@@branch_selection_stock_points:
	// 	@@branch_selection_stock:
	// //If scoring is set to TIME
	// LI v1, 1
	// BNE v1, v0, @@branch_selection_time
	// 	nop
	// 	jal menuToggleTimer
	// 	nop
	// 	LI t0, 1
	// 	SB t0, hp_or_points //Set byte to show we are storing points and not hp
	// 	@@branch_selection_time:




	lw ra, 0x1C (sp)
	jr ra
	addi sp, sp, 0x24


//Menu toggling on game page for test battle
menuToggleGameCaptureTheFlag:
	addi sp, sp, -0x24
	sw ra, 0x1C (sp)


	LI a0, 0 //Turn being hit will lower your score off for CTF
	SB a0, being_hit_lowers_score
	LI a0, 0 //Turn hitting someone will raise your score off for CTF
	SB a0, hitting_someone_raises_score

	//If menu selection is FFA or Teams
	LI a0, ffa_or_teams //Load status pointer
	LI a2, 1 //menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 1 //max number




	JAL menuTogglePointOrTimeScoreMode
	LI a2, 2 //menu index

	//if scoring is set to stock
	lbu v0, score_mode
	BNE v0, zero, @@branch_hotpotato_points_to_stock //If score mode is stock, change back to point
		LI a0, 2
		SB a0, score_mode
		@@branch_hotpotato_points_to_stock:



	LI a2, 3 //menu index
	lbu v0, score_mode
	LI v1, 2
	BNE v0, v1, @@branch_selection_points //if menu selection is team points
		LI a0, max_points
		LI t2, 1 //min number
		JAL menuToggleHalf
		LI t0, 9999 //How high can the points go
		@@branch_selection_points:
	//If scoring is set to time or team time
	LI v1, 1
	BNE v0, v1, @@branch_selection_time //if menu selection is timer
		nop
		jal menuToggleTimer
		nop
		@@branch_selection_time:





	//if menu selection is ctf scoring
	LI a0, ctf_game_mode //load status pointer
	LI a2, 4 //menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 1 //max number


	//if menu selection is no items when holding flag
	li a0, no_items_when_holding_flag //load status pointer
	jal menuToggleOnoff
	li a2, 5 //menu index


	//if menu selection is slow when holding flag
	li a0, slow_when_holding_flag //load status pointer
	jal menuToggleOnoff
	li a2, 6 //menu index


	lw ra, 0x1C (sp)
	jr ra
	addi sp, sp, 0x24


//Menu toggling on game page for test battle
menuToggleGameKeepAway:
	addi sp, sp, -0x24
	sw ra, 0x1C (sp)

	LI a0, 0 //Turn being hit will lower your score off for CTF
	SB a0, being_hit_lowers_score
	LI a0, 0 //Turn hitting someone will raise your score off for CTF
	SB a0, hitting_someone_raises_score

	//If menu selection is FFA or Teams
	LI a0, ffa_or_teams //Load status pointer
	LI a2, 1 //menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 1 //max number




	JAL menuTogglePointOrTimeScoreMode
	LI a2, 2 //menu index

	//if scoring is set to stock
	lbu v0, score_mode
	BNE v0, zero, @@branch_hotpotato_points_to_stock //If score mode is stock, change back to point
		LI a0, 2
		SB a0, score_mode
		@@branch_hotpotato_points_to_stock:

	LI a2, 3 //menu index
	lbu v0, score_mode
	LI v1, 2
	BNE v0, v1, @@branch_selection_points //if menu selection is team points
		LI a0, max_points
		LI t2, 1 //min number
		JAL menuToggleHalf
		LI t0, 9999 //How high can the points go
		@@branch_selection_points:
	//If scoring is set to time or team time
	LI v1, 1
	BNE v0, v1, @@branch_selection_time //if menu selection is timer
		nop
		jal menuToggleTimer
		nop
		@@branch_selection_time:




	//if menu selection is no items when holding flag
	li a0, no_items_when_holding_flag //load status pointer
	jal menuToggleOnoff
	li a2, 4 //menu index


	//if menu selection is slow when holding flag
	li a0, slow_when_holding_flag //load status pointer
	jal menuToggleOnoff
	li a2, 5 //menu index


	lw ra, 0x1C (sp)
	jr ra
	addi sp, sp, 0x24



//Menu toggling for game mode Zombombs
menuToggleGameZombombs:
	addi sp, sp, -0x24
	sw ra, 0x1C (sp)

	//If menu selection is timer
	jal menuToggleTimer
	LI a2, 1


	lw ra, 0x1C (sp)
	jr ra
	addi sp, sp, 0x24



//Menu toggling on game page for shell shooter battle
menuToggleGameShellShooter:
	addi sp, sp, -0x24
	sw ra, 0x1C (sp)


	// LI a0, 0 //Turn being hit will lower your score on for HP mode
	// SB a0, being_hit_lowers_score
	// LI a0, 0 //Turn hitting someone will raise your score off for HP mode
	// SB a0, hitting_someone_raises_score

	//If menu selection is FFA or Teams
	LI a0, ffa_or_teams //Load status pointer
	LI a2, 1 //menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 1 //max number

	//if menu selection is scoring
	LI a0, score_mode //load status pointer
	LI a2, 2 //menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 2 //max number

	//if scoring is set to stock
	li a2, 3 //menu index
	lbu v0, score_mode
	bne v0, zero, @@branch_selection_stock
		// LBU t9, ffa_or_teams
		// BNE t9, zero, @@branch_selection_stock_hp
		LI a0, max_hp
		LI t2, 1 //min number
		JAL menuToggleHalf
		LI t0, 9999 //How high can the HP go'

		LI a0, 0xFF //Turn being hit will lower your score on for HP mode
		SB a0, being_hit_lowers_score


		//if menu selection is scoring
		LI a0, shooter_ammo_max //load status pointer
		LI a2, 4 //menu index
		JAL menuToggleFloat
		LI t0, 9999

		//if menu selection is scoring
		LI a0, shooter_health_max //load status pointer
		LI a2, 5 //menu index
		JAL menuToggleFloat
		LI t0, 9999

		LI a0, 0 //Turn hitting someone will raise your score off for HP mode
		SB a0, hitting_someone_raises_score
		@@branch_selection_stock:
	//If scoring is set to TIME
	LI v1, 1
	BNE v1, v0, @@branch_selection_time
		nop
		jal menuToggleTimer
		nop

		li a0, being_hit_lowers_score //load status pointer
		jal menuToggleOnoff
		li a2, 4 //menu index

		li a0, hitting_someone_raises_score //load status pointer
		jal menuToggleOnoff
		li a2, 5 //menu index

		//if menu selection is scoring
		LI a0, shooter_ammo_max //load status pointer
		LI a2, 6 //menu index
		JAL menuToggleFloat
		LI t0, 9999

		//if menu selection is scoring
		LI a0, shooter_health_max //load status pointer
		LI a2, 7 //menu index
		JAL menuToggleFloat
		LI t0, 9999
		@@branch_selection_time:
	LI v1, 2
	BNE v1, v0, @@branch_selection_points
		LI a0, max_points
		LI t2, 1 //min number
		JAL menuToggleHalf
		LI t0, 9999 //How high can the HP go

		li a0, being_hit_lowers_score //load status pointer
		jal menuToggleOnoff
		li a2, 4 //menu index

		LI a0, 0xFF //Turn hitting someone will raise your score on for points mode
		SB a0, hitting_someone_raises_score

		//if menu selection is scoring
		LI a0, shooter_ammo_max //load status pointer
		LI a2, 5 //menu index
		JAL menuToggleFloat
		LI t0, 9999

		//if menu selection is scoring
		LI a0, shooter_health_max //load status pointer
		LI a2, 6 //menu index
		JAL menuToggleFloat
		LI t0, 9999
		@@branch_selection_points:





	lw ra, 0x1C (sp)
	jr ra
	addi sp, sp, 0x24



//Menu toggling on game page for test battle
menuToggleGameCoins:
	addi sp, sp, -0x24
	sw ra, 0x1C (sp)


	LI a0, 0 //Turn being hit will lower your score off for CTF
	SB a0, being_hit_lowers_score
	LI a0, 0 //Turn hitting someone will raise your score off for CTF
	SB a0, hitting_someone_raises_score

	//If menu selection is FFA or Teams
	LI a0, ffa_or_teams //Load status pointer
	LI a2, 1 //menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 1 //max number


	JAL menuTogglePointOrTimeScoreMode
	LI a2, 2 //menu index

	//if scoring is set to stock
	lbu v0, score_mode
	BNE v0, zero, @@branch_hotpotato_points_to_stock //If score mode is stock, change back to point
		LI a0, 2
		SB a0, score_mode
		@@branch_hotpotato_points_to_stock:



	LI a2, 3 //menu index
	lbu v0, score_mode
	LI v1, 2
	BNE v0, v1, @@branch_selection_points //if menu selection is team points
		LI a0, max_points
		LI t2, 1 //min number
		JAL menuToggleHalf
		LI t0, 9999 //How high can the points go
		@@branch_selection_points:
	//If scoring is set to time or team time
	LI v1, 1
	BNE v0, v1, @@branch_selection_time //if menu selection is timer
		nop
		jal menuToggleTimer
		nop
		@@branch_selection_time:


	LI a0, max_coins //Load status pointer
	LI a2, 4 //menu index
	LI t2, 1 //min number
	JAL menuToggleHalf
	LI t0, 100

	LI a0, hit_coin_loss //Load status pointer
	LI a2, 5 //menu index
	LI t2, 1 //min number
	LI t0, 100
	JAL menuToggleHalf
	NOP
	



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
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 7 //max value



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


	//If mode is capture the flag
	lbu a0, game_mode //load game mode
	li a2, 3
	bne a0, a2, @@branch_ctf_mode
		nop
		jal menuToggleGameCaptureTheFlag
		nop
	@@branch_ctf_mode:

	//If mode is keep away
	lbu a0, game_mode //load game mode
	li a2, 4
	bne a0, a2, @@branch_keepaway_mode
		nop
		jal menuToggleGameKeepAway
		nop
	@@branch_keepaway_mode:


	//If mode is zombombs
	lbu a0, game_mode //load game mode
	li a2, 5
	bne a0, a2, @@branch_zombombs_mode
		nop
		jal menuToggleGameZombombs
		nop
	@@branch_zombombs_mode:


	//If mode is shell shooter
	lbu a0, game_mode //load game mode
	li a2, 6
	bne a0, a2, @@branch_shell_shooter_mode
		nop
		jal menuToggleGameShellShooter
		nop
	@@branch_shell_shooter_mode:


	//If mode is shell shooter
	lbu a0, game_mode //load game mode
	li a2, 7
	bne a0, a2, @@branch_coin_mode
		nop
		jal menuToggleGameCoins
		nop
	@@branch_coin_mode:


	// //If mode is test
	// lbu a0, game_mode //load game mode
	// li a2, 4
	// bne a0, a2, @@branch_test_mode
	// 	nop
	// 	jal menuToggleGameTest
	// 	nop
	// @@branch_test_mode:


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
	li a2, 0 //Load menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 8 //max value

	//If menu selection is Player 2 on/off
	li a0, bot_status_p2 //Load status pointer
	li a2, 1 //Load menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 8 //max value

	//If menu selection is Player 3 on/off
	li a0, bot_status_p3//Load status pointer
	li a2, 2 //Load menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 8 //max value

	//If menu selection is Player 4 on/off
	li a0, bot_status_p4 //Load status pointer
	li a2, 3 //Load menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 8 //max value


	//If menu selection is bot AI type
	li a0, bot_ai_type //Load status pointer
	LI a2, 4 //menu index
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 1 //max value


	// //If menu selection is bots can fall on/off
	// li a0, bot_respawn_flag //Load status pointer
	// JAL menuToggleOnoff
	// li a2, 5 //Load menu index

	//If menu sleection is bots use items
	LI a0, bot_use_items
	JAL menuToggleOnoff
	// li a2, 6 //Load menu index
	li a2, 5 //Load menu index



	//If menu sleection is 1P full screen
	LI a0, one_player_full_screen
	JAL menuToggleOnoff
	// li a2, 7 //Load menu index
	li a2, 6 //Load menu index


	//Set camera zoom distance based on 1P full screen mode being on or off 
	LI a0, 0x1040000A
	SW a0, 0x8001C6E8 //Store default assembly code for the init camera code
	LBU a2, one_player_full_screen
	BEQ a2, zero, @@branch_fix_camera_zoom_in_1_player_full_screen
		LI a0, 0x080071DA //assembly instruction J 0x8001C768
		SW a0, 0x8001C6E8 //Store jump that forces player 1 zoom

		SW zero, 0x80001D08 //Do not render the other screens to save on processing power
		SW zero, 0x80001D10
		SW zero, 0x80001D18
		SW zero, 0x80001D20
		@@branch_fix_camera_zoom_in_1_player_full_screen:
	BNE a2, zero, @@branch_no_fix_camera_zoom_in_1_player_full_screen
		LI a0, 0x1440000B //Restore code to render all 4 screens if not in 1P full screen mode
		SW a0, 0x80001D08
		LI a0, 0x0C0A9AEC
		SW a0, 0x80001D10
		LI a0, 0x0C0A9BA5
		SW a0, 0x80001D18
		LI a0, 0x0C0A9C5E
		SW a0, 0x80001D20
		@@branch_no_fix_camera_zoom_in_1_player_full_screen:

	//If menu sleection is Target Humans
	LI a0, bots_target_humans
	JAL menuToggleOnoff
	li a2, 7 //Load menu index


	LW ra, 0x001C (sp)
	JR ra
	ADDI sp, sp, 0x0024


//Handle toggling of menu options on the graphics page
menuToggleGraphics:
	ADDI sp, sp, 0xFFDC
	SW ra, 0x001C (sp)



	//If menu selection is first person
	LI a0, status_first_person //Load status pointer
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

	//If menu selection is game tempo
	LI a2, 3 //menu index
	LI a0, status_options_tempo //status pointer
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 4 //max value


	//If menu selection is using HLE
	LI a0, lag_fix //Load status pointer
	JAL menuToggleOnoff
	LI a2, 4 //Load menu index




	//If menu selection is using HLE
	LI a0, using_hle //Load status pointer
	JAL menuToggleOnoff
	LI a2, 5 //Load menu index


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



	//If menu selection is 3P/4P music
	LI a0, status_options_3P4Pmusic //Load status pointer
	JAL menuToggleOnoff
	LI a2, 1 //Load menu index

	//If menu selection is all chars select
	LI a0, status_options_samechars //Load status pointer
	JAL menuToggleOnoff
	LI a2, 2 //Load menu index




	//If menu selection is ludicrious speed
	LI a0, status_options_ludicrousspeed //Load status pointer
	JAL menuToggleOnoff
	LI a2, 3 //Load menu index



	//If menu selection is ludicrious speed
	LI a0, status_respawn //Load status pointer
	JAL menuToggleOnoff
	LI a2, 4 //Load menu index




	//If menu is restore defaults
	LI a0, status_restore_defaults
	LI a2, 5 //menu index 
	LI t2, 0 //min number
	JAL menuToggleByte
	LI t0, 3 //max value




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
	LW ra, 0x0020 (sp)
	LW a3, 0x001C (sp)

	JR ra
	ADDI sp, sp, 0x0024


.ifdef BattleSanta
	titleMenu: //This is the title menu for Battle Santa
		ADDI sp, sp, -0x48 
		SW ra, 0x0038 (sp)

		//Set up normal defaults
		LI a0, 1 //Set in title screen flag
		SB a0, in_title_screen	

		//set boot flag
		LB a0, boot_flag
		BNE a0, zero, @@run_boot_flag

			SW zero, 0x8009F890 //Disable Mario Kart 64 logo in the title screen
			LI a0, 0x8000  //Move the copyright 1996 nintendo notice way off screen so we don't see it
			SH a0, 0x8019BEC4

			LI a0, 1 //Set background to be on in game
			SB a0, gBackgroundFlag
			JAL setDefaults //Set defaults as the first thing that happens
			NOP

			JAL bootCustomCourseStuff
			NOP
			//Load flag and base models for capture the flag into segment 8
			LI a1, theModels
			JAL SetSegment
			LI a0, 8
			// //Disable  flag, "press start" and the Mario Raceway time on title screen and zero out timer for demo
			// lui a0, 0x8019
			// SW zero, 0xDA30 (a0) //g_mflagID
			// SW zero, 0xDA58 (a0) //g_mpressstartID
			// SW zero, 0xDA80 (a0) //g_mracewayTime
			// SW zero, 0xEE00 (a0) //Stop title demo counter at 8018EE00 from counting anything
			//Set up battle santa defaults
			LI a0, 1
			SB a0, 0x800e86a8 //Set P1 to luigi (santa)
			LI a0, 4
			SB a0, 0x800e86a9
			LI a0, 6
			SB a0, bot_status_p2 //set P2 to DK
			LI a0, 5
			SB a0, 0x800e86aA
			LI a0, 7
			SB a0, bot_status_p3 //Set P3 to Wario
			LI a0, 7
			SB a0, 0x800e86aB
			LI a0, 8
			SB a0, bot_status_p4 //Set P4 to Bowser
			LI a0, 7
			SB a0, game_mode //Set game mode to "coins"
			SB zero, bot_ai_type //Set bot AI type to 'seeker'

			li a1, 0x8CBC/2 //Set default time limit to 5 minutes
			SW a1, max_timer

			//turn on some items
			SB zero, status_item_banana
			//SB zero, status_item_bananabunch
			//SB zero, status_item_greenshell
			//SB zero, status_item_threegreenshells
			///SB zero, status_item_redshell
			SB zero, status_item_fakeitembox
			//SB zero, status_item_star
			SB zero, status_item_ghost

			// LI 	a0, 1
			// NOR a0, zero, zero //Set to be on
			// SB a0, bot_run_away_flag_p1
			// SB a0, bot_run_away_flag_p2
			// SB a0, bot_run_away_flag_p3
			// SB a0, bot_run_away_flag_p4 //Set bot run away flags to be true
			SB a0, one_player_full_screen //Use 1p full screen mode
			//SH zero, p1_score //Set p1 score to zero
			LI a0, 1
			SB a0, score_mode //Set score mode to timer
			LI a0, 1 //Set boot flag at end here
			SB a0, boot_flag
			@@run_boot_flag:

		JAL DisplayBattleSantaTitle
		NOP



		//Disable  flag, "press start" and the Mario Raceway time on title screen and zero out timer for demo
		lui a0, 0x8019
		SW zero, 0xDA30 (a0) //g_mflagID
		SW zero, 0xDA58 (a0) //g_mpressstartID
		SW zero, 0xDA80 (a0) //g_mracewayTime
		SW zero, 0xEE00 (a0) //Stop title demo counter at 8018EE00 from counting anything



		LW ra, 0x0038 (sp)
		JR ra  //Jump back
		ADDI sp, sp, 0x48 


.else
	titleMenu: //Standard Battle Kart Title Menu
		ADDI sp, sp, -0x48 
		SW ra, 0x0038 (sp)


		LI a0, 1 //Set in title screen flag
		SB a0, in_title_screen


		//set boot flag
		LB a0, boot_flag
		BNE a0, zero, @@run_boot_flag
			NOP

			LI a0, 1 //Set background to be on in game
			SB a0, gBackgroundFlag

			JAL setDefaults //Set defaults as the first thing that happens
			NOP
					
			
			LUI a0, hi(VARIABLE_RAM_BASE)
	        JAL loadEEPROM //Load stored variables from save file
	        ADDIU a0, a0, lo(VARIABLE_RAM_BASE)
			LW a0, save_flag //Load save_flag and compare to the save_key
			LI a1, save_key
			BEQ a0, a1, @@run_if_no_good_save
				NOP
				JAL setDefaults //Set default values for battle kart variables
				NOP
			@@run_if_no_good_save:

			JAL bootCustomCourseStuff
			NOP

			//Load flag and base models for capture the flag into segment 8
			LI a1, theModels
			JAL SetSegment
			LI a0, 8

			LI a0, 1 //Set boot flag at end here
			SB a0, boot_flag

			@@run_boot_flag:
		// //Force crash screen to always display
		// LI a0, 0x08001192
		// LUI a1, hi(0x800045F0)
		// SW a0, lo(0x800045F0) (a1)
		//Force starting lap to be 1, this forces the balloon with the blue shell to display in Luigi's raceway
		SH zero, 0x8000F94A


		//Disable  flag, "press start" and the Mario Raceway time on title screen and zero out timer for demo
		lui a0, 0x8019
		SW zero, 0xDA30 (a0) //g_mflagID
		SW zero, 0xDA58 (a0) //g_mpressstartID
		SW zero, 0xDA80 (a0) //g_mracewayTime
		SW zero, 0xEE00 (a0) //Stop title demo counter at 8018EE00 from counting anything



		JAL setCullDLParameters
		NOP

		JAL menuFunction
		NOP


		LW ra, 0x0038 (sp)
		JR ra  //Jump back
		ADDI sp, sp, 0x48 
.endif



//Function to display the Battle Kart 64 menu
menuFunction:
	ADDI sp, sp, -0x48 
	SW ra, 0x0038 (sp)

	//Display a semi-transparent background for the menu
	LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ORI a1, zero, 0x10 //x1
	ORI a2, zero, 0xC //y1
	ORI a3, zero, 0x12E //x2
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
	ORI a1, zero, 0x10 //x1
	ORI a2, zero, 0xC //y1
	ORI a3, zero, 0x12 //x2
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
	ORI a1, zero, 0x12E //x1
	ORI a2, zero, 0xC //y1
	ORI a3, zero, 0x130 //x2
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
	ORI a1, zero, 0x10 //x1
	ORI a2, zero, 0xDA //y1
	ORI a3, zero, 0x12E //x2
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
	ORI a1, zero, 0x10 //x1
	ORI a2, zero, 0xC //y1
	ORI a3, zero, 0x12E //x2
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
	ORI a1, zero, 0x10 //x1
	ORI a2, zero, 0x2F //y1
	ORI a3, zero, 0x12E //x2
	ORI t6, zero, 0x31 //y2
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
	ORI a1, zero, 0x10 //x1
	ORI a2, zero, 0x40 //y1
	ORI a3, zero, 0x12E //x2
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
		LI t7, 0x1A
	@@branch_menu_tab_items:
	BNE a3, a1, @@branch_menu_tab_game //If page == 1, set x position to t7
		LI a1, 0x2
		LI t7, 0x4D
	@@branch_menu_tab_game:
	BNE a3, a1, @@branch_menu_tab_bots //If page == 2, set x position to t7
		LI a1, 0x3
		LI t7, 0x7F
	@@branch_menu_tab_bots:
	BNE a3, a1, @@branch_menu_tab_gfx//If page == 3, set x position to t7
		LI a1, 0x4
		LI t7, 0xAC
	@@branch_menu_tab_gfx:
	BNE a3, a1, @@branch_menu_tab_options//If page == 4, set x position to t7
		NOP
		LI t7, 0xE3
	@@branch_menu_tab_options:
	SW t7, 0x0040 (sp) //Store result in stack so it can be accessed even after running jal 0x80098DF8

	//Display tab background gradient
	LW t7, 0x0040 (sp)
	lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ADDI a1, t7, 0x00 //x1
	LI a2, 0x31 //y1
	ADDI a3, t7, 0x38 //x2
	LI t6, 0x40 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	LI t6, 0x30
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298

	//Display tab background gradient
	LW t7, 0x0040 (sp)
	lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ADDI a1, t7, 0x02 //x1
	LI a2, 0x31 //y1
	ADDI a3, t7, 0x36 //x2
	LI t6, 0x40 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	LI t6, 0x38
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298


	//Display tab background gradient
	LW t7, 0x0040 (sp)
	lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ADDI a1, t7, 0x04 //x1
	LI a2, 0x31 //y1
	ADDI a3, t7, 0x34 //x2
	LI t6, 0x40 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	LI t6, 0x40
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298


	//Display tab background gradient
	LW t7, 0x0040 (sp)
	lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ADDI a1, t7, 0x06 //x1
	LI a2, 0x31 //y1
	ADDI a3, t7, 0x32 //x2
	LI t6, 0x40 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	LI t6, 0x48
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298


	//Display tab background gradient
	LW t7, 0x0040 (sp)
	lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ADDI a1, t7, 0x08 //x1
	LI a2, 0x31 //y1
	ADDI a3, t7, 0x30 //x2
	LI t6, 0x40 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	LI t6, 0x50
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298


	//Display tab background gradient
	LW t7, 0x0040 (sp)
	lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ADDI a1, t7, 0x0A //x1
	LI a2, 0x31 //y1
	ADDI a3, t7, 0x2E //x2
	LI t6, 0x40 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	LI t6, 0x58
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298


	//Display tab background gradient
	LW t7, 0x0040 (sp)
	lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ADDI a1, t7, 0x0C //x1
	LI a2, 0x31 //y1
	ADDI a3, t7, 0x2C //x2
	LI t6, 0x40 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	LI t6, 0x60
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298


	//Display tab background gradient
	LW t7, 0x0040 (sp)
	lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ADDI a1, t7, 0x0E //x1
	LI a2, 0x31 //y1
	ADDI a3, t7, 0x2A //x2
	LI t6, 0x40 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	LI t6, 0x68
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298

	//Display tab background gradient
	LW t7, 0x0040 (sp)
	lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	ADDI a1, t7, 0x10 //x1
	LI a2, 0x31 //y1
	ADDI a3, t7, 0x28 //x2
	LI t6, 0x40 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	LI t6, 0x70
	SW t6, 0x0014 (sp) //u32 r
	SW t6, 0x0018 (sp) //u32 g
	SW t6, 0x001C (sp) //u32 b
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298


	// //Display left side of tab
	// LW t7, 0x0040 (sp) //Load stored x position of tab that was stored in the stack
	// lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	// ADDI a1, t7, 0x00 //x1
	// LI a2, 0x30 //y1
	// ADDI a3, t7, 0x02 //x2
	// LI t6, 0x40 //y2
	// SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	// LI t6, 0x80
	// SW t6, 0x0014 (sp) //u32 r
	// SW t6, 0x0018 (sp) //u32 g
	// SW t6, 0x001C (sp) //u32 b
	// JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	// NOP
	// SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298

	// //Display right side of tab
	// LW t7, 0x0040 (sp) //Load stored x position of tab that was stored in the stack
	// lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	// ADDI a1, t7, 0x3C //x1
	// LI a2, 0x30 //y1
	// ADDI a3, t7, 0x3E //x2
	// LI t6, 0x40 //y2
	// SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	// LI t6, 0x80
	// SW t6, 0x0014 (sp) //u32 r
	// SW t6, 0x0018 (sp) //u32 g
	// SW t6, 0x001C (sp) //u32 b
	// JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	// NOP
	// SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298


	// //Display top of tab
	// LW t7, 0x0040 (sp) //Load stored x position of tab that was stored in the stack
	// lw a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	// ADDI a1, t7, 0x00 //x1
	// LI a2, 0x2F //y1
	// ADDI a3, t7, 0x3E //x2
	// LI t6, 0x31 //y2
	// SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	// LI t6, 0x80
	// SW t6, 0x0014 (sp) //u32 r
	// SW t6, 0x0018 (sp) //u32 g
	// SW t6, 0x001C (sp) //u32 b
	// JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	// NOP
	// SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298


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
	//LI a1, 0x34 //x1
	//LI a3, 0x106 //x2
	LI a1, 0x12 //x1
	LI a3, 0x12E //x2
	ADDI t6, a2, 0xE //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	SW zero, 0x0014 (sp) //u32 r
	SW zero, 0x0018 (sp) //u32 g
	li t6, 0xC0
	SW t6, 0x001C (sp) //transparency
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
	ADDI a2, a1, 0x52 //a1 is the y positiion
	LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	//LI a1, 0x34 //x1
	//LI a3, 0x106 //x2
	LI a1, 0x1A //x1
	LI a3, 0x126 //x2
	ADDI t6, a2, 0xC //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	SW zero, 0x0014 (sp) //u32 r
	SW zero, 0x0018 (sp) //u32 g
	li t6, 0xB0
	SW t6, 0x001C (sp) //transparency
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
	ADDI a2, a1, 0x53 //a1 is the y positiion
	LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	//LI a1, 0x34 //x1
	//LI a3, 0x106 //x2
	LI a1, 0x22 //x1
	LI a3, 0x11E //x2
	ADDI t6, a2, 0xA //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	SW zero, 0x0014 (sp) //u32 r
	SW zero, 0x0018 (sp) //u32 g
	li t6, 0xA0
	SW t6, 0x001C (sp) //transparency
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
	ADDI a2, a1, 0x54 //a1 is the y positiion
	LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	//LI a1, 0x34 //x1
	//LI a3, 0x106 //x2
	LI a1, 0x2A //x1
	LI a3, 0x116 //x2
	ADDI t6, a2, 0x8 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	SW zero, 0x0014 (sp) //u32 r
	SW zero, 0x0018 (sp) //u32 g
	li t6, 0x90
	SW t6, 0x001C (sp) //transparency
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
	ADDI a2, a1, 0x55 //a1 is the y positiion
	LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	//LI a1, 0x34 //x1
	//LI a3, 0x106 //x2
	LI a1, 0x32 //x1
	LI a3, 0x10E //x2
	ADDI t6, a2, 0x6 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	SW zero, 0x0014 (sp) //u32 r
	SW zero, 0x0018 (sp) //u32 g
	li t6, 0x80
	SW t6, 0x001C (sp) //transparency
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
	ADDI a2, a1, 0x56 //a1 is the y positiion
	LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	//LI a1, 0x34 //x1
	//LI a3, 0x106 //x2
	LI a1, 0x3A //x1
	LI a3, 0x106 //x2
	ADDI t6, a2, 0x4 //y2
	SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	SW zero, 0x0014 (sp) //u32 r
	SW zero, 0x0018 (sp) //u32 g
	li t6, 0x70
	SW t6, 0x001C (sp) //transparency
	JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	NOP
	SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298


	// //Display currently selected item as a long skinny rectangle
	// LBU a1, MENU_TAB
	// LI a3, MENU_Y_GAME //Load current menu selection and set the Y position based on that, $A1 is the y position
	// ADDU a3, a3, a1
	// LBU a1, 0x0000 (a3)
	// LI a2, 12 //multiply a1 by 12
	// MULT a1, a2
	// MFLO a1
	// ADDI a2, a1, 0x54 //a1 is the y positiion
	// LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	// //LI a1, 0x34 //x1
	// //LI a3, 0x106 //x2
	// LI a1, 0x42 //x1
	// LI a3, 0xFE //x2
	// ADDI t6, a2, 0x9 //y2
	// SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	// SW zero, 0x0024 (sp) //u32 r
	// SW zero, 0x0018 (sp) //u32 g
	// li t6, 0xD0
	// SW t6, 0x001C (sp) //transparency
	// JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	// NOP
	// SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298


	// //Display currently selected item as a long skinny rectangle
	// LBU a1, MENU_TAB
	// LI a3, MENU_Y_GAME //Load current menu selection and set the Y position based on that, $A1 is the y position
	// ADDU a3, a3, a1
	// LBU a1, 0x0000 (a3)
	// LI a2, 12 //multiply a1 by 12
	// MULT a1, a2
	// MFLO a1
	// ADDI a2, a1, 0x51 //a1 is the y positiion
	// LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	// //LI a1, 0x34 //x1
	// //LI a3, 0x106 //x2
	// LI a1, 0x42 //x1
	// LI a3, 0xFE //x2
	// ADDI t6, a2, 0x8 //y2
	// SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	// SW zero, 0x0024 (sp) //u32 r
	// SW zero, 0x0018 (sp) //u32 g
	// li t6, 0xD0
	// SW t6, 0x001C (sp) //transparency
	// JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	// NOP
	// SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298




	// //Display currently selected item as a long skinny rectangle
	// LBU a1, MENU_TAB
	// LI a3, MENU_Y_GAME //Load current menu selection and set the Y position based on that, $A1 is the y position
	// ADDU a3, a3, a1
	// LBU a1, 0x0000 (a3)
	// LI a2, 12 //multiply a1 by 12
	// MULT a1, a2
	// MFLO a1
	// ADDI a2, a1, 0x53 //a1 is the y positiion
	// LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	// //LI a1, 0x34 //x1
	// //LI a3, 0x106 //x2
	// LI a1, 0x52 //x1
	// LI a3, 0xEE //x2
	// ADDI t6, a2, 0x7 //y2
	// SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	// SW zero, 0x0024 (sp) //u32 r
	// SW zero, 0x0018 (sp) //u32 g
	// li t6, 0xD0
	// SW t6, 0x001C (sp) //transparency
	// JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	// NOP
	// SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298



	// //Display currently selected item as a long skinny rectangle
	// LBU a1, MENU_TAB
	// LI a3, MENU_Y_GAME //Load current menu selection and set the Y position based on that, $A1 is the y position
	// ADDU a3, a3, a1
	// LBU a1, 0x0000 (a3)
	// LI a2, 12 //multiply a1 by 12
	// MULT a1, a2
	// MFLO a1
	// ADDI a2, a1, 0x55 //a1 is the y positiion
	// LW a0, 0x80150298 //Load dlistBuffer from to 0x80150298 to $a0
	// //LI a1, 0x34 //x1
	// //LI a3, 0x106 //x2
	// LI a1, 0x62 //x1
	// LI a3, 0xDE //x2
	// ADDI t6, a2, 0x6 //y2
	// SW t6, 0x0010 (sp) //(argument passing starts at offset of 0x10 in stack)
	// SW zero, 0x0014 (sp) //u32 r
	// SW zero, 0x0018 (sp) //u32 g
	// li t6, 0xF0
	// SW t6, 0x001C (sp) //transparency
	// JAL 0x80098DF8 //Call drawBox function 0x80098DF8
	// NOP
	// SW v0, 0x80150298 //Store dlistBuffer back to 0x80150298




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
		LI a3, 4
	@@BRANCH_MENU_TAB_TOO_LOW:
	BNE a3, 5,  @@BRANCH_MENU_TAB_TOO_HIGH //if menu page is too high, reset to min
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
	BNE a2, a0, @@BRANCH_MENU_GRAPHICS_PAGE_TOGGLE
		NOP
		JAL menuToggleGraphics
		NOP
	@@BRANCH_MENU_GRAPHICS_PAGE_TOGGLE:


	//Menu toggling for page OPTIONS
	LBU a2, MENU_TAB //Load current menu tab page
	LI a0, 4
	BNE a2, a0, @@BRANCH_MENU_OPTIONS_PAGE_TOGGLE
		NOP
		JAL menuToggleOptions
		NOP
	@@BRANCH_MENU_OPTIONS_PAGE_TOGGLE:


	//Store menu selection in progress byte back to ram
	SB a1, MENU_X_PROGRESS

	JAL DisplayBattleKartTitle
	NOP


	//Load font
	JAL 0x80057710
	NOP


	// LB a0, text_flicker_flag
	// ADDI a0, a0, 1
	// SLTI a1, a0, 30
	// BNE a1, zero, @@reset_text_flicker_flag
	// 	NOP
	// 	LI a0, 0 
	// 	@@reset_text_flicker_flag:
	// SB a0, text_flicker_flag
	// SLTI a1, a0, 15
	// BEQ a1, zero, @@text_flicker_a
	// 	//Set font color (divide RGB values by 8)
	// 	LI a0, 31 //R
	// 	LI a1, 20 //G
	// 	LI a2, 8 //B
	// 	LI a3, 21 //R shadow
	// 	LI t0, 8 //G shadow
	// 	LI t1, 0 //B shadow
	// 	SW t0, 0x10 (sp)	
	// 	JAL SetFontColor
	// 	SW t1, 0x14 (sp)
	// 	SB zero, text_flicker_flag
	// 	BEQ zero, zero, @@text_flicker_done
	// 	NOP
	// 	@@text_flicker_a:

	// //Set font color (divide RGB values by 8)
	// LB a0, text_flicker_flag
	// SLTI a1, a0, 15
	// BNE a1, zero, @@text_flicker_b
	// 	LI a0, 28 //R
	// 	LI a1, 28 //G
	// 	LI a2, 28 //B
	// 	LI a3, 10 //R shadow
	// 	LI t0, 10 //G shadow
	// 	LI t1, 19 //B shadow
	// 	SW t0, 0x10 (sp)	
	// 	JAL SetFontColor
	// 	SW t1, 0x14 (sp)
	// 	LI a0, 1
	// 	SB a0, text_flicker_flag
	// 	@@text_flicker_b:


	// @@text_flicker_done:


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
	BNE t0, 3, @@BRANCH_SHOW_MENU_PAGE_GRAPHICS //Tab 4 == page for Graphics
		NOP
		JAL menuDispPageGraphics
		NOP
	@@BRANCH_SHOW_MENU_PAGE_GRAPHICS:
	BNE t0, 4, @@BRANCH_SHOW_MENU_PAGE_OPTIONS //Tab 3 == page for Options
		NOP
		JAL menuDispPageOptions
		NOP
	@@BRANCH_SHOW_MENU_PAGE_OPTIONS:





	// //Display title "BATTLE KART 64"
	// LI a0, 0x54 //a0 is the X pos
	// LI a2, text_title_1 //text pointer
	// JAL FUNCTION_DISPLAY_TEXT //Print text
	// LI a1, 0x00 //a1 is the y pos

	// //Display title "VX.X BY TRICLON"
	// LI a0, 0x48 //a0 is the X pos
	// LI a2, text_title_2 //text pointer
	// JAL FUNCTION_DISPLAY_TEXT //Print text
	// LI a1, 0x0C //a1 is the y pos

	//Display "Z", "L", and "R for menu pages
	//Z
	// LI a0, -0x6 //a0 is the X pos
	// LI a2, text_Z //text pointer
	// JAL FUNCTION_DISPLAY_TEXT //Print text
	// LI a1, 0x25 //a1 is the y pos
	//L
	// LI a0, -0x6 //a0 is the X pos
	// LI a2, text_L //text pointer
	// JAL FUNCTION_DISPLAY_TEXT //Print text
	// LI a1, 0x19 //a1 is the y pos
	//R
	// LI a0, 0x116 //a0 is the X pos
	// LI a2, text_R //text pointer
	// JAL FUNCTION_DISPLAY_TEXT //Print text
	// LI a1, 0x20 //a1 is the y pos

	//Display text for page tab names

	//Game
	LI a0, 0x12 //a0 is the X pos
	LI a2, text_page_tab_game //text pointer
	JAL FUNCTION_DISPLAY_TEXT //Print text
	LI a1, 0x21 //a1 is the y pos
	//Items
	LI a0, 0x40 //a0 is the X pos
	LI a2, text_page_tab_items //text pointer
	JAL FUNCTION_DISPLAY_TEXT //Print text
	LI a1, 0x21 //a1 is the y pos
	//Bots
	LI a0, 0x78 //a0 is the X pos
	LI a2, text_page_tab_bots //text pointer
	JAL FUNCTION_DISPLAY_TEXT //Print text
	LI a1, 0x21 //a1 is the y pos
	//Rendering
	LI a0, 0xA8 //a0 is the X pos
	LI a2, text_page_tab_gfx //text pointer
	JAL FUNCTION_DISPLAY_TEXT //Print text
	LI a1, 0x21 //a1 is the y pos
	//options
	LI a0, 0xD0 //a0 is the X pos
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

	LW ra, 0x0038 (sp)
	JR ra  //Jump back
	ADDI sp, sp, 0x48 


//Function to blank a chunk of ram (needs to be double 0x8 aligned)
//a0 = start address
//a1 = end address
blankRam:
	SW zero, (a0)
	BNE a0, a1, blankRam
	ADDI a0, a0, 0x4
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

	// JAL setCullDLParameters
	// NOP

	//For some game modes when in time scoring mode, this checks for if hitting someone and being hit doesn't affect the score, this fixes a bug for when both of those settings are off by turning on being hit means you lose a point
	lbu a0, score_mode //If score mode is timer
	LI a1, 1
	BNE a0, a1, @@skip_time_score_check //and if both hitting someone or being hit doesn't change the score
	LBU a0, hitting_someone_raises_score
	BNE a0, zero, @@skip_time_score_check
	LBU a0, being_hit_lowers_score
	BNE a0, zero, @@skip_time_score_check
	LBU a0, game_mode //If game mode is traditional, squish, or shell shooter
	BEQ a0, zero, @@time_score_check
	LI a1, 2
	BEQ a0, a1, @@time_score_check
	LI a1, 6
	BEQ a0, a1, @@time_score_check
	NOP
	BEQ zero, zero, @@skip_time_score_check
		@@time_score_check:
		LI a0, 0xFF
		SB a0, being_hit_lowers_score //set being hit lowers score to 1
	@@skip_time_score_check:


	//Error catch, if playing two player and teams scoring is on, turn off teams scoring
	LBU a0, player_count  //Grab number of players
	LI a1, 2 //If 2 players
	BNE a0, a1, @@branch_in_2p_mode_with_teams_on
	LBU a0, ffa_or_teams
	BEQ a0, zero, @@branch_in_2p_mode_with_teams_on //If game mode is not teams
		NOP
		SB zero, ffa_or_teams //Set to FFA mode if 2P and teams is on
		@@branch_in_2p_mode_with_teams_on:



	//Set zombombs score mode to be timed, if zombombs is loaded
	LBU a0, game_mode
	LI a1, 5
	BNE a0, a1, @@branch_set_zombombs_score_mode
		LI a1, 1
		SB a1, score_mode
		@@branch_set_zombombs_score_mode:


	//For hot potato always have hits decrement your HP or score
	LBU a0, game_mode
	LI a1, 1
	BNE a0, a1, @@branch_set_hot_potato_to_always_decrement_score
		LI a0, 0xFF //Turn being hit will lower your score on for HP mode
		SB a0, being_hit_lowers_score
		LI a0, 0 //Turn hitting someone will raise your score off for HP mode
		SB a0, hitting_someone_raises_score
		@@branch_set_hot_potato_to_always_decrement_score:




	//Set course start flag to zero so that we know the course is in the middle of loading
	SB zero, course_start_flag

	//

	//Flatten courses
	LUI a0, hi(status_options_flatcourses)
	LBU a1, lo(status_options_flatcourses) (a0)
	BEQ a1, zero, @@branch_flatten_battle_courses
		LUI a1, 0x800E
		LUI a0, 0x3CCC
		SW a0, 0xC608 (a1)
		SW zero, 0x8002E154 //disable tumbling
		SW zero, 0x8002CA08
		// SW zero, 0x8007A9D0 //disable Laktiu from picking you up if you go off course (still should pick you up in the water)
		//disable Laktiu from picking you up if you go off course (still should pick you up in the water)
		LI a0, 0x11
		SB a0, 0x800798E7
	@@branch_flatten_battle_courses:




	//Turn on music in 3P/4P mode if set to on
	LBU a0, status_options_3P4Pmusic
	BEQ a0, zero, @@branch_3p4p_music_on
		NOP
		SW zero, 0x8028ECAC
		SW zero, 0x8028F9D4
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
				LBU a0, ffa_or_teams
				BNE a0, zero, @@skip_balloon_display_code //If game mode is not teams
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


	// //Test setting starting positiosn automatically in race courses
	// JAL getStartingPositions
	// NOP


	// .ifdef BattleSanta
	// 	JAL makeItSnow
	// 	NOP
	// .endif
	

	JAL 0x80002A18//Run InitialRaceSequence which was overwritten by the hook
	NOP
	


	//DeadHamster
	JAL ResetPathfinderBots
	NOP
	//End DeadHamster <3

	// SB zero, 0x800F6A5B //Disable lakitu
	// SB zero, 0x800f7833
	// SB zero, 0x800f860b
	// SB zero, 0x800f93e3

	JAL beforeCourseLoadsInit
	NOP




	LW ra, 0x20 (sp)
	JR RA
	ADDI sp, sp, 0x30



KillBombKartWrapper:
	ADDI sp, sp, -0x40
	SW ra, 0x20 (sp)
	SW a3, 0x24 (sp)
	SW a2, 0x28 (sp)
	SW a0, 0x2C (sp)
	SW a1, 0x30 (sp)

	LBU t6, game_mode //If game mode is zombombs
	LI t7, 5
	BNE t6, t7, @@branch_game_mode_zombombs
		NOP
		//STUFF
		JAL 0x80027D00 //JAL CheckKartNumber, Get kart number for car1
		LW a0, 0x24 (sp)
		//JAL killPlayer //Kill first kart
		JAL makePlayerBomb
		MOVE a0, v0
		JAL 0x80027D00 //JAL CheckKartNumber, Get kart number for car2
		LW a0, 0x28 (sp)
		//JAL killPlayer //Kill second kart
		JAL makePlayerBomb
		MOVE a0, v0
		BEQ zero, zero, @@skip
		NOP
		@@branch_game_mode_zombombs:
	JAL 0x8008FC1C //JAL KillBombKart
	NOP
	@@skip:

	LW ra, 0x20 (sp)
	LW a3, 0x24 (sp)
	LW a2, 0x28 (sp)
	LW a0, 0x2C (sp)
	LW a1, 0x30 (sp)
	JR ra
	ADDI sp, sp, 0x40


//Run code to find starting positions for race courses after the map data loads
afterMapDataLoads:
	.word 0x0C00F03C //Run jal   func_8003C0F0
	NOP

	JAL BattleInit //initialization for custom battle courses
	NOP

	JAL getStartingPositions
	NOP

	LBU a0, ffa_or_teams
	BEQ a0, zero, @@branch_set_team_ballon_colors
		NOP
		JAL setTeamBallonColorsRedVsBlue
		NOP
		@@branch_set_team_ballon_colors:
	LBU a0, ffa_or_teams
	BNE a0, zero, @@branch_set_ffa_ballon_colors
		NOP
		JAL SetBalloonDefaults
		NOP
		@@branch_set_ffa_ballon_colors:
	
	J 0x8003D0BC //Jump back
	NOP



//Jump to hook for 
.align 0x10
//runMinimapCode:
gameCode:
	ADDI sp, sp, -0x30
	SW ra, 0x20 (sp)

	// JAL setBKCheckAddress
	// NOP

	JAL 0x80057C60 //run KWSetViewportFull to ensure whole minimap is rendered
	NOP
	JAL inRace //Test in race hook in the minimap code
	NOP
	// lbu a0, game_mode //Load game mode (0=traditional, 1=hot potato, and so on and so forth...)
	// LI a1, 3
	// BNE a0, a1, @@branch_game_mode_ctf //If game mode is CTF
	// 	NOP
	// 	JAL minimap_display_flags_and_bases
	// 	NOP
	// 	@@branch_game_mode_ctf:
	JAL 0x80057CE4 //run KWReturnViewportto go back to what viewport used to be
	NOP
	// JAL 0x80093E20 //run KawanoDrawFinal which is what the hook overwrote
	// NOP
	LW ra, 0x20 (sp)
	JR ra
	ADDI sp, sp, 0x30 //End of hook, jump back



//Include binary file of the flag and base used for capture the flag
.align 0x10
theModels:
	// .import "BattleKartObjects/BattleKartObjects.raw" //OLD
	// .import "BattleKartModel/Presents.raw"
	.import "BattleKartObjects/ModelData.raw" //2024 model data
	//.import "BattleKartObjects/ModelData2023.raw" //2023 model data backup

//Include binary file for flag and base minimap sprites for CTF mode
.align 0x10
theMinimapSprites:
	.import "MinimapSprites/ImageData.RAW"
.align 0x10

//Import kart and steering wheel grpahics for first person mode
.align 0x10
theFirstPersonSprites:
	.import "FirstPersonSprites/32BitFPSKart.RAW"
.align 0x10
PipeBase:
	.import "FirstPersonSprites/PipeKart/PipeKart.RAW"
.align 0x10

.align 0x10
PaletteMario:
.import "FirstPersonSprites/PipeKart/Mario.PALETTE"
.align 0x10
PaletteLuigi:
.import "FirstPersonSprites/PipeKart/Luigi.PALETTE"
.align 0x10
PalettePeach:
.import "FirstPersonSprites/PipeKart/Peach.PALETTE"
.align 0x10
PaletteToad:
.import "FirstPersonSprites/PipeKart/Toad.PALETTE"
.align 0x10
PaletteYoshi:
.import "FirstPersonSprites/PipeKart/Yoshi.PALETTE"
.align 0x10
PaletteDK:
.import "FirstPersonSprites/PipeKart/DK.PALETTE"
.align 0x10
PaletteWario:
.import "FirstPersonSprites/PipeKart/Wario.PALETTE"
.align 0x10
PaletteBowser:
.import "FirstPersonSprites/PipeKart/Bowser.PALETTE"



//Import DeadHamster's stuff at the bottom fo the ram
.align 0x10
.importobj "BattleKartFlag/BattleKartFlag.o"
.align 0x10
.importobj "BattleBots/BattleBotAI.o"
.align 0x10
// .importobj "BattleKartFlag/BattleKartPathData.o"
// .align 0x10
.importobj "BattleKartVariables.o"
.align 0x10

//Import paths for bot AI
.importobj "BattleKartPaths/BlockFortPaths.o"
.importobj "BattleKartPaths/DoubleDeckerPaths.o"
.importobj "BattleKartPaths/SkyscraperPaths.o"
.importobj "BattleKartPaths/BigDonutPaths.o"
.importobj "BattleKartPaths/RaceCoursePaths.o"
.importobj "BattleKartPaths/SkyShroomsCoursePaths.o"
.importobj "BattleKartPaths/BobombFortPaths.o"
.importobj "BattleKartPaths/KoopaIslandPaths.o"
.importobj "BattleKartPaths/ShellShockedPaths.o"


// //Import battle kart custom weather code
// .importobj "BattleWeather/BattleKartWeather.o"


//universalHook:
//allRun:
PrintMenuFunction:

	ADDIU sp, sp, -0x30
	SW ra, 0x20 (sp)
	//JAL test_universal_hook
	//NOP


	JAL menuStuff
	NOP

	.ifndef BattleSanta //Only enable if not battle santa
		//Enable mirror mode
		LI a0, 0xFF00
		LUI a1, hi(0x8018ED12)
		SH a0, lo(0x8018ED12) (a1)
	.endif

	LUI a0, hi(currentMenu)
	LW a0, lo(currentMenu) (a0)
	LI a1, 0x24 //value for character selection menu
	BNE a0, a1, @@branch_in_character_select_menu
		//Add same character selection if set to on
		LB a0, status_options_samechars
		BEQ a0, zero, @@branch_samechars_on
			LUI a0, 0x800B
			LI a1, 0x7FFFF
			SW zero, 0x3924 (a0)
			SH a1, 0x3936 (a0)
			SW zero, 0x39A4 (a0)
			SH a1, 0x39B6 (a0)
			SW zero, 0x3A38 (a0)
			SH a1, 0x3A4E (a0)
			@@branch_samechars_on:
		//Bots auto select character in cahracter selection screen
		LBU a0, bot_status_p1 //Check if bot is on
		LUI a2, 0x8019 //Load mem address hi for bot character setting and selection
		LI a1, 1 //Auto selet character for bot
		BEQ a0, zero, @@branch_bot_menu_select_p1
			// LUI a1, 0x8019 //Auto selet character for bot
			// LI a1, 1
			// SB a1, 0xEDE8 (a0)
			//ADDI a0, a0, -1 //Set bot character
			NOP
			SB a0, 0xEDE4 (a2)
			@@branch_bot_menu_select_p1:
		LBU a0, bot_status_p2 //Check if bot is on
		BEQ a0, zero, @@branch_bot_menu_select_p2
			NOP
			SB a0, 0xEDE5 (a2)	
			SB a1, 0xEDE9 (a2)//Auto selet character for bot
			@@branch_bot_menu_select_p2:
		LBU a0, bot_status_p3 //Check if bot is on
		BEQ a0, zero, @@branch_bot_menu_select_p3
			NOP
			SB a0, 0xEDE6 (a2)
			SB a1, 0xEDEA (a2) //Auto selet character for bot
			@@branch_bot_menu_select_p3:
		LBU a0, bot_status_p4 //Check if bot is on
		BEQ a0, zero, @@branch_bot_menu_select_p4
			NOP
			SB a0, 0xEDE7 (a2)
			SB a1, 0xEDEB (a2) //Auto selet character for bot
			@@branch_bot_menu_select_p4:

		@@branch_in_character_select_menu:

	// J 0x80001F64
	// LW ra, 0x14 (sp)
	LW ra, 0x20 (sp)
	JR ra
	ADDIU sp, sp, 0x30





//Runs in controller input, used for setting bot controller inputs
controllerLoop:


	ADDIU sp, sp, -0x30	//Run two instructions overwritten by hook, this handles storing the RA so we dont have to worry about it later
	sw ra, 0x14 (sp)
	SW a0, 0x18 (sp)
	sw a1, 0x1C (sp)
	sw a2, 0x20 (sp)


	//If on results screen, skip bot constrols
	LUI a0, hi(insideMenu)
	LBU a0, lo(insideMenu) (a0) //Load current screen state
	//LI a1, 5 //Results screen state
	//LI a1, 3 //In race and players can move state
	BNE a0, zero, @@branch_skip_bot_control


	//If doing ctf but game hasn't started yet, skip bot controls
	LUI a0, hi(ctf_game_started)
	LBU a0, lo(ctf_game_started) (a0)
	BEQ a0, zero, @@branch_skip_bot_control
	NOP



	//Copy battle bot controller input generated by battle bot function to the current button activators (because we need to use the exception handler hook)
	//Player 1
	LBU a0, bot_status_p1 //Check if bot is on
	BEQ a0, zero, @@branch_bot_control_p1
		LBU a0, 0x800F6990 //check if in game and player is not starting or dead
		//LI a1, 0xC0
		ANDI a1, a0, 0xC0
		//BNE a0, a1, @@branch_bot_control_p1
		BEQ a1, zero, @@branch_bot_control_p1
			LUI a0, 0x8019
			LW a1, bot_controller_input_p1 //Copy controller input into correct button activator
			SW a1, 0x6504 (a0) 
			LI a1, 0xFF010401 //Trick console/emulator into thinking controller is plugged in
			SW a1, 0x6500 (a0)
	@@branch_bot_control_p1:
	//Player 2
	LBU a0, bot_status_p2 //Check if bot is on
	BEQ a0, zero, @@branch_bot_control_p2
		LBU a0, 0x800F7768 //check if in game and player is not starting or dead
		//LI a1, 0xC0
		ANDI a1, a0, 0xC0
		//BNE a0, a1, @@branch_bot_control_p2
		BEQ a1, zero, @@branch_bot_control_p2
			LUI a0, 0x8019
			LW a1, bot_controller_input_p2 //Copy controller input into correct button activator
			SW a1, 0x650C (a0)
			LI a1, 0xFF010401 //Trick console/emulator into thinking controller is plugged in
			SW a1, 0x6508 (a0)
	@@branch_bot_control_p2:
	//Player 3
	LBU a0, bot_status_p3 //Check if bot is on
	BEQ a0, zero, @@branch_bot_control_p3
		LBU a0, 0x800F8540 //check if in game and player is not starting or dead
		//LI a1, 0xC0
		ANDI a1, a0, 0xC0
		//BNE a0, a1, @@branch_bot_control_p3
		BEQ a1, zero, @@branch_bot_control_p3
			LUI a0, 0x8019
			LW a1, bot_controller_input_p3 //Copy controller input into correct button activator
			SW a1, 0x6514 (a0)
			LI a1, 0xFF010401 //Trick console/emulator into thinking controller is plugged in
			SW a1, 0x6510 (a0)
	@@branch_bot_control_p3:
	//Player 4
	LBU a0, bot_status_p4 //Check if bot is on
	BEQ a0, zero, @@branch_bot_control_p4
		LBU a0, 0x800F9318 //check if in game and player is not starting or dead
		//LI a1, 0xC0
		ANDI a1, a0, 0xC0
		//BNE a0, a1, @@branch_bot_control_p4
		BEQ a1, zero, @@branch_bot_control_p4
			LUI a0, 0x8019
			LW a1, bot_controller_input_p4 //Copy controller input into correct button activator
			SW a1, 0x651C (a0)
			LI a1, 0xFF010401 //Trick console/emulator into thinking controller is plugged in
			SW a1, 0x6518 (a0)
	@@branch_bot_control_p4:
	@@branch_skip_bot_control:


	// .word 0x27BDFFE8
	// .word 0xAFBF0014
	// J 0x800381B4
	// NOP
	// J 0x80038248 //Jump back
	// NOP

	LW a0, 0x18 (sp)
	LW a1, 0x1C (sp)
	.word 0x0C00DF3F //JAL ManualStickDrive 
	LW a2, 0x20 (sp)


 	LW ra, 0x14 (sp)
	JR RA
	ADDIU sp, sp, 0x30	//Run two instructions overwritten by hook, this handles storing the RA so we dont have to worry about it later
	// // J 0x80000A30 //Jump back to ReadController
	// NOP


	// lw ra, 0x001C (sp)
	// .word 0x3C02800E //run instructions hook overwrote 
	// .word 0x8C42C52C
	// J 0x800382E4 //Jump to back to DriveStickControl
	// addi sp, sp, 0x30
	// .word 0x3C03800E
	// .word 0x3C04800E
	// J 0x80000A84
	// NOP


//Control bot acceleratiron and turning
botControlWrapper:
	ADDIU sp, sp, -0x30	//Run two instructions overwritten by hook, this handles storing the RA so we dont have to worry about it later
	sw ra, 0x14 (sp)
	SW a0, 0x18 (sp)
	sw a1, 0x1C (sp)
	sw a2, 0x20 (sp)


	JAL botControl
	NOP

	LW a0, 0x18 (sp)
	LW a1, 0x1C (sp)
	.word 0x0C00DF3F //JAL ManualStickDrive 
	LW a2, 0x20 (sp)


 	LW ra, 0x14 (sp)
	JR RA
	ADDIU sp, sp, 0x30	//Run two instructions overwritten by hook, this handles storing the RA so we dont have to worry about it later

//Function that hijacks hitting an itembox
hijackHitItemBox:
	// LBU t1, game_mode //check if running shell shooter, if so, skip getting an item
	// LI t2, 6
	// BEQ t1, t2, @@branch_skip_for_shell_shooter
	// 	NOP
	// 	.word 0x0C01EAFF //jal   KwanmRouletteStart, runs if not shell shooter
	// 	NOP
	// 	J 0x802A0D20 //Jump back
	// 	NOP
	// 	@@branch_skip_for_shell_shooter:

	LUI t1, hi(shooter_ammo_p1)
	LWC1 f2, lo(shooter_ammo_max) (t1) //Load ammo max to f2	
	SLL t2, a0, 2 //get offset for current player
	ADD t2, t1, t2 //t1 stores the address of the current player's ammo
	LWC1 f0, lo(shooter_ammo_p1) (t2) //Load current player ammo into f0
	C.LT.S f0, f2// if current player ammo count < max ammo
	NOP //Delay slot needed for comparison
	BC1F @@branch_increment_ammo //Execute the code below only if the current player's ammo is < max ammo
		LI.S f4, 5.0 //Load float to increment ammo by into f4
		ADD.S f0, f0, f4 //Current ammo incremented
		C.LT.S f0, f2// if current player ammo count < max ammo
		NOP
		BC1T @@branch_max_ammo //If ammo > max ammo
			NOP
			MOV.S f0, f2 //Copy max ammo to current ammo
			@@branch_max_ammo:
		SWC1 f0, lo(shooter_ammo_p1) (t2) //Store result
		@@branch_increment_ammo:
	// J 0x802A0D20 //Jump back
	JR RA
	NOP//Run instruction overwritten by hook

//Hijack where Na_plyvoice_start runs when an item hits someone to increment the score of the owner
//a0 = player who scored hit
//t0 = player who was hit
hijackItemHits:
	ADDIU sp, sp, -0x30	//Run two instructions overwritten by hook, this handles storing the RA so we dont have to worry about it later
	sw ra, 0x14 (sp)
	SW a0, 0x18 (sp)
	sw a1, 0x1C (sp)
	sw a2, 0x20 (sp)

	LBU a2, game_mode
	LI a3, 2
	BEQ a2, a3, @@branch_skip_score_increment //Skip if in squish mode because hits won't actually award points directly, you need to squish them
	LI a3, 6
	BEQ a2, a3, @@branch_skip_score_increment
		NOP
		JAL incrementScoreOnHit
		NOP
		@@branch_skip_score_increment:
	LBU a2, game_mode	
	LI a3, 6
	BNE a2, a3, @@branch_score_increment_for_shell_shooter //For shell shooter, store who scored hit last
		LUI a2, hi(who_hit_p1_last)
		ADD a2, a2, t0
		SB a0, lo(who_hit_p1_last) (a2)
		@@branch_score_increment_for_shell_shooter:


	// LBU a2, hitting_someone_raises_score
	// BEQ a2, zero, @@branch_skip_score_increment //Skip if in increment scoring is not set
	// 	LBU a2, ffa_or_teams
	// 	BNE a2, zero, @@branch_ffa_item_hit_scoring //Increment individual scores
	// 		NOP
	// 		LI a1, p1_score
	// 		@@branch_ffa_item_hit_scoring:
	// 	BEQ a2, zero, @@branch_teams_item_hit_scoring
	// 		NOP
	// 		LI a1, team_1_score
	// 		SRA a0, a0, 1   //Divide a0 by two so P1 and P2 are team 1 and P3 and P4 are team 2
	// 		SRA a2, t0, 1
	// 		BEQ a0, a2, @@branch_skip_score_increment //If a player hits someone on their own team, skip the rest of this
	// 			NOP
	// 		@@branch_teams_item_hit_scoring:
	// 	SLL a0, a0, 1  //Double player or team number to get offset for score
	// 	ADDU a1, a1, a0 //Add offset to base
	// 	LHU a2, 0x0000 (a1) //Increment score by 1
	// 	ADDI a2, a2, 1
	// 	SH a2, 0x000 (a1)
	// @@branch_skip_score_increment:

	LW a0, 0x18 (sp)
	LW a1, 0x1C (sp)
 	JAL 0x800C90F4 //JAL NaPlyvoiceStart
 	LW a2, 0x20 (sp)

 	LW ra, 0x14 (sp)
 	JR ra
	ADDIU sp, sp, 0x30	//Run two instructions overwritten by hook, this handles storing the RA so we dont have to worry about it later

//On a hit in points+time scoring, handle incrementing individual or team score increments f
//a0 = player who scored hit
//t0 = player who was hit
incrementScoreOnHit:
	LBU a2, hitting_someone_raises_score
	BEQ a2, zero, @@branch_skip_score_increment //Skip if in increment scoring is not set
	//LBU a2, game_mode
	//LI a3, 2
	//BEQ a2, a3, @@branch_skip_score_increment //Skip if game mode is squish
		LUI a2, hi(0x800F699C) ///Skip if player that was hit was using a star
		LI a3, player_state_offset
		MULT a3, t0
		MFLO a3
		ADDU a2, a2, a3
		LBU a1, lo(0x800F6A4E) (a2) //Star status, bit 0x02
		ANDI a3, a1, 0x02 //Is player using a star?
		BNE a3, zero, @@branch_skip_score_increment
		LBU a1, lo(0x800F6A4C) (a2) //Ghost status, bit 0x80
		ANDI a3, a1, 0x80 //Is player using a ghost?
		BNE a3, zero, @@branch_skip_score_increment
		LBU a2, ffa_or_teams
		BNE a2, zero, @@branch_ffa_item_hit_scoring //Increment individual scores
			NOP
			LI a1, p1_score
			@@branch_ffa_item_hit_scoring:
		BEQ a2, zero, @@branch_teams_item_hit_scoring
			NOP
			LI a1, team_1_score
			SRA a0, a0, 1   //Divide a0 by two so P1 and P2 are team 1 and P3 and P4 are team 2
			SRA a2, t0, 1
			BEQ a0, a2, @@branch_skip_score_increment //If a player hits someone on their own team, skip the rest of this
				NOP
			@@branch_teams_item_hit_scoring:
		SLL a0, a0, 1  //Double player or team number to get offset for score
		ADDU a1, a1, a0 //Add offset to base
		LHU a2, 0x0000 (a1) //Increment score by 1
		ADDI a2, a2, 1
		SH a2, 0x000 (a1)
	@@branch_skip_score_increment:
	JR RA
	NOP

//Check if someone was hit with a star this frame
// t0, player to check
// returns v0=0, not already hit, v0=1 already hit
checkIfHitWithStar:
	LUI v0, hi(p1_hit_by_star)
	ADDU v0, v0, t0
	JR RA
	LBU v0, lo(p1_hit_by_star) (v0)


//Increment score for a car that hits another with a star if the scoring mode
//is set to points/time with hits +1 turned on
hijackStarCollisionCar1:
	ADDIU sp, sp, -0x40
	SW a0, 0x18 (sp)
	sw a1, 0x1C (sp)
	sw a2, 0x20 (sp)
	sw t5, 0x24 (sp)
	SW at, 0x28 (sp)
	SW t0, 0x2C (sp)
	SW v0, 0x30 (sp)
 	SW a3, 0x34 (sp)


	LW t5, 0x800DC4DC //Find which player has the star
	SUBU a0, a3, t5 //Subtract base pointer from car1 pointer
	LI at, 0xDD8
	DIV a0, at //Divide by 0xDD8 to get P1=0, P2=1, P3=2, P4=3 for car1
	SUBU t0, a2, t5 //Subtract base pointer from car2 pointer
	MFLO t5
	DIV t0, at //Divide by 0xDD8 to get P1=0, P2=1, P3=2, P4=3 for car2
	ANDI a0, t5, 0xFF //Not sure why I need to do this but apparently I do to get P1=0, P2=1, P3=2, P4=3 for car1
	MFLO t5
	ANDI t0, t5, 0xFF //Not sure why I need to do this but apparently I do to get  P1=0, P2=1, P3=2, P4=3 for car2

 //Store results before 
	SB t0, 0x15 (sp)
	JAL checkIfHitWithStar //Check if car already hit and skip if so
	SB a0, 0x14 (sp)
	BNE v0, zero, @@branch_skip
	LBU a0, game_mode
	LI t0, 2
	BEQ a0, t0, @@branch_skip //Skip if game mode is squish	
		LBU  a0, 0x14 (sp)
		JAL incrementScoreOnHit //Up the score for whoever used the star to hit someone
		LBU t0, 0x15 (sp)
		LI a0, 10
		LUI a1, hi(p1_hit_by_star)
		ADDU a1, a1, t0
		SB a0, lo(p1_hit_by_star) (a1)
		@@branch_skip:

	LW a0, 0x18 (sp)
	LW a1, 0x1C (sp)
 	LW a2, 0x20 (sp)
 	LW t5, 0x24 (sp)
 	LW at, 0x28 (sp)
 	LW t0, 0x2C (sp)
 	LW v0, 0x30 (sp)
 	LW a3, 0x34 (sp)

 	J 0x802906C4
	ADDIU sp, sp, 0x40	




//Increment score for a car that hits another with a star if the scoring mode
//is set to points/time with hits +1 turned on
hijackStarCollisionCar2:
	ADDIU sp, sp, -0x40
	SW a0, 0x18 (sp)
	sw a1, 0x1C (sp)
	sw a2, 0x20 (sp)
	sw t5, 0x24 (sp)
	SW at, 0x28 (sp)
	SW t0, 0x2C (sp)
 	SW v0, 0x30 (sp)
 	SW a3, 0x34 (sp)



	LW t5, 0x800DC4DC //Find which player has the star
	SUBU t0, a3, t5 //Subtract base pointer from car1 pointer
	LI at, 0xDD8
	DIV t0, at //Divide by 0xDD8 to get P1=0, P2=1, P3=2, P4=3 for car1
	SUBU a0, a2, t5 //Subtract base pointer from car2 pointer
	MFLO t5
	DIV a0, at //Divide by 0xDD8 to get P1=0, P2=1, P3=2, P4=3 for car2
	ANDI t0, t5, 0xFF //Not sure why I need to do this but apparently I do to get P1=0, P2=1, P3=2, P4=3 for car1
	MFLO t5
	ANDI a0, t5, 0xFF //Not sure why I need to do this but apparently I do to get  P1=0, P2=1, P3=2, P4=3 for car2

	SB t0, 0x15 (sp)
	JAL checkIfHitWithStar //Check if car already hit and skip if so
	SB a0, 0x14 (sp)
	BNE v0, zero, @@branch_skip
	LBU a0, game_mode
	LI t0, 2
	BEQ a0, t0, @@branch_skip //Skip if game mode is squish
		LBU  a0, 0x14 (sp)
		JAL incrementScoreOnHit //Up the score for whoever used the star to hit someone
		LBU t0, 0x15 (sp)
		LI a0, 10
		LUI a1, hi(p1_hit_by_star)
		ADDU a1, a1, t0
		SB a0, lo(p1_hit_by_star) (a1)
		@@branch_skip:


	LW a0, 0x18 (sp)
	LW a1, 0x1C (sp)
 	LW a2, 0x20 (sp)
 	LW t5, 0x24 (sp)
 	LW at, 0x28 (sp)
 	LW t0, 0x2C (sp)
 	LW v0, 0x30 (sp)
 	LW a3, 0x34 (sp)

 	J 0x802906C4
	ADDIU sp, sp, 0x40	



//Hook to properly apply score incrementing in squish mode
hijackSetBrokenWhenSquished:
	ADDIU sp, sp, -0x40
	SW a0, 0x20 (sp)
	SW a1, 0x24 (sp)
	SW a2, 0x28 (sp)
	SW a3, 0x2C (sp)
	SW t0, 0x30 (sp)

	LBU a2, game_mode
	LI a3, 2
	BNE a2, a3, @@branch_skip_if_not_squish_mode //If not squish mode, skip
		

			//MOVE t0, a0 //Store current player (who was squished) in t0
		LW a3, 0x800DC4DC //Find which player was hit
		SUBU a0, a0, a3 //Subtract base pointer from car1 pointer
		LI a3, 0xDD8
		DIV a0, a3
		MFLO a0 //Load squished player into a0
		ANDI a0, a0, 0xFF //Not sure why I need to do this but apparently I do to get P1=0, P2=1, P3=2, P4=3 for car1
		JAL find_nearest_player //Grab who squished the current player by finding the nearest player
		SW a0, 0x34 (sp)


	// LW t5, 0x800DC4DC //Find which player has the star
	// SUBU a0, a3, t5 //Subtract base pointer from car1 pointer
	// LI at, 0xDD8
	// DIV a0, at //Divide by 0xDD8 to get P1=0, P2=1, P3=2, P4=3 for car1
	// SUBU t0, a2, t5 //Subtract base pointer from car2 pointer
	// MFLO t5
	// DIV t0, at //Divide by 0xDD8 to get P1=0, P2=1, P3=2, P4=3 for car2
	// ANDI a0, t5, 0xFF //Not sure why I need to do this but apparently I do to get P1=0, P2=1, P3=2, P4=3 for car1
	// MFLO t5
	// ANDI t0, t5, 0xFF //Not sure why I need to do this but apparently I do to get  P1=0, P2=1, P3=2, P4=3 for car2

		//MOVE t0, v0
		LW t0, 0x34 (sp)
		JAL incrementScoreOnHit
		// JAL incrementScore
		//LW a0, 0x34 (sp)
		MOVE a0, v0
		//LBU a0, lo(who_squished_p1) (a2)
		@@branch_skip_if_not_squish_mode:

	LW a0, 0x20 (sp)
	LW a1, 0x24 (sp)
	LW a2, 0x28 (sp)
	LW a3, 0x2C (sp)
	LW t0, 0x30 (sp)
	ADDIU sp, sp, 0x40

	JAL 0x8008DABC //JAL SetBroken (was overwritten by hook so we run it here)
	NOP
	J 0x8008E1C8 //Jump back out of hook
	NOP


//Hijack jump to drivestickcontrol to use VS mode handling in race courses even though we are still in battle mode
hijackdrivestickcontrol:
	ADDIU sp, sp, -0x40
	SW ra, 0x14 (sp)

	LUI t8, hi(0x8018EE09)
	LBU t9, lo(0x8018EE09) (t8)
	SLTI t9, t9, 3
    BEQ t9, zero, @@default_branch //If in a race course
    	LI t9, 2 //Temporarily force VS mode
		LUI t8, 0x800E
		JAL drivestickcontrol
		SH t9, 0xC53E (t8)
    	LI t9, 3 //Set mode back to battle
		LUI t8, 0x800E
		BEQ zero, zero, @@end_hijack
		SH t9, 0xC53E (t8)
	@@default_branch:
	JAL drivestickcontrol
	NOP
	@@end_hijack:
	LW ra, 0x14 (sp)
	JR ra
	ADDIU sp, sp, 0x40




startSpawnPlayer:  //Force VS mode handling on race courses to load vs mode stats instead of battle mode stats
	LUI t8, hi(0x8018EE09)
	LBU t9, lo(0x8018EE09) (t8)
	SLTI t9, t9, 3
    BEQ t9, zero, @@default_branch //If in a race course
		LI t9, 2 //Temporarily force VS mode
		LUI t8, 0x800E
		SH t9, 0xC53E (t8)
		@@default_branch:
	//Run two lines hook overrode and jump back to the beginning of spawnplayer
	.word 0x27BDFFD8
	.word 0x44802000
	J 0x800393C8
	NOP

endSpawnPlayer: //Go back to battle mode when done running spawnplayer
		LI t9, 3 //Back to battle mode
		LUI t8, 0x800E
		JR RA
		SH t9, 0xC53E (t8)






//Run every frame, useful for running things at boot like replacing the spinning Nintendo logo
allRun:
	ADDIU sp, sp, -0x40
	SW ra, 0x14 (sp)

	LI a0, 35
	LH a1, startupSwitch
	BEQ a0, a1, @@branch_run_only_at_startup
		NOP
		.ifdef BattleSanta
			JAL loadChristmasLogo
		.else
			JAL loadLogo
		.endif
		NOP
		LI a0, 35
		SH a0, startupSwitch
		@@branch_run_only_at_startup:

	// JAL runFPSCounter
	// NOP

	LW ra, 0x14 (sp)
	JR ra
	ADDIU sp, sp, 0x40

// //For custom courses




.align 0x10
set0:
.import "../Library/data/Stock.png.MIO0"            ;;  87c
.align 0x10
set0end:

.align 0x10
set1:
.import "../Library/data/Set1.png.MIO0"            ;;  7f5
.align 0x10
set1end:

.align 0x10
set2:
.import "../Library/data/Set2.png.MIO0"            ;;  7fc
.align 0x10
set2end:

.align 0x10
set3:
.import "../Library/data/Set3.png.MIO0"            ;;  808
.align 0x10
set3end:

.align 0x10
set4:
.import "../Library/data/Set4.png.MIO0"            ;;  800
.align 0x10
set4end:


.align 0x10
PressRforOptionsGraphic:
.import "ROption.bin"



.align 0x10000


VAR_RAM_START:
.fill VARIABLE_RAM_SIZE //Create space for battle kart 64 variables

.align 0x40



.align 0x10
.include "../Library/LibraryBUILD2.asm"
end_label:





.headersize 0


//Texturex and stuff for previews and crash screens, outside of ram





.align 0x10

RAMCheck:
     .import "Data/BKRAMCheck.bin"
     .align 0x10
RAMCheckEnd:

 .definelabel OverWriteFonts, 1

 .align 0x10
 NiceFontROM:
 .import "../library/data/nice_font.mio0.bin"

 .align 0x10
 HudButtonsROM:
 .import "../library/data/hud_buttons.mio0.bin"

 .align 0x10
 BigFontROM:
 .import "data/Newfont.MIO0"




 //Christmas Kimura logo
 .align 0x10
.ifdef BattleSanta
	LogoROM:
 	.import "Data/ChristmasLogo.bin" ;; 0xD388
.else
	LogoROM:
 	.import "Data/Logo.bin" ;; 0xD388	
.endif




//LibraryBUILD3 needs to be EOF
.align 0x10
.include "../Library/LibraryBUILD3.asm"
.align 0x10
.include "../Library/LibraryBUILD4.asm"
.align 0x10

.close
