#include "../Library/MainInclude.h"
//#include "../Library/OKBehaviors.h"
//#include "../Library/SubProgram.h"
//#include "../Library/SharedFunctions.h"
//#include "../Library/OKHeader.h"
//#include "../Library/GameVariables/NTSC/OKassembly.h"
//#include "../Library/GameVariables/NTSC/GameOffsets.h"
//#include "../Library/MarioKart3D.h"
//#include "../Library/MarioKartObjects.h"
//#include "../Library/LibraryVariables.h"
//#include "../Library/Struct.h"
#include "../BattleKartVariables.h"
//#include "../BattleKartModel/BattleKartModel.h"
#include "../BattleKartObjects/BattleKartObjects.h"
//#include "../MinimapSprites/ImageData.h"
//#include "../Library/MarioKartMenu.h"
//#include "../Library/CustomLevels.h"
//#include "../Library/PlayerEffects.h"
//Course markers for bot AI
// #include "BattleKartPathData.h"
//#include "../Library/Pathfinding.h"
#include "../BattleKartPaths/BlockFortPaths.h"
//Standard libraries
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>

// #include "../USB/usb.c"
// #include "../USB/usb.h"
// #include "../USB/debug.c"
// #include "../USB/debug.h"

const int keepAwayTimerMax = 150; //Number to set the keep away timer everytime it rests (60 = 1 sec)
const float fractionSpeedWhenHoldingFlag = 0.8; //Fraction of top speed when holding flag
const float fractionSpeedWhenBomb = 1.15; //Fraction of top speed when a bomb in zombombs mode
const float max_bot_distance_path_marker = 400.0; //Distance a bot must get within a path marker to advance to the next marker (in squared pathagorean theorm space)
//float course_height = 0.0; //Store height of course based off initialized player 1's position, used to set base and flag heights when courses are flat
bool bot_wall_zigzag[4]; //array to hold if bot should turn right or left when they hit a wall, to make them zig zag so they don't get stuck in  one place for too long
Bump bot_bump[4];
int bot_path_index[4] = {14,14,14,14}; //Array to store index of what path the bot is on
int bot_path_progression[4] = {0, 0, 0, 0}; //Array to store index of where a bot is when progressing along a path
int bot_path_direction[4] = {1,1,1,1}; //Direction of bot along path, 1 = fowards, -1 = backwards
float bot_distance_from_path_marker[4] = {0., 0., 0., 0.};
ushort bot_buttons[4] = {0, 0, 0, 0};
char bot_x_stick[4] = {0, 0, 0, 0};
// float test_bot_sphere_x[4] = {0., 0., 0., 0.};
// float test_bot_sphere_y[4] = {0., 0., 0., 0.};
// float test_bot_sphere_z[4] = {0., 0., 0., 0.};
float test_bot_sphere_position[4][3] = {
                                        {0., 0., 0.},
                                        {0., 0., 0.},
                                        {0., 0., 0.},
                                        {0., 0., 0.},
                                    };

// //Marker structure for Bot AI path finding
// typedef struct Marker{
//     short     Position[3];
//     short    Group;
// } Marker;


void DisplayBattleKartTitle()
{
    PrintBigText(38,14, 0.87f,"BATTLE KART 64"); //Display title
    PrintBigText(255,12, 0.5f,"By");
    PrintBigText(240,25, 0.5f,"Triclon");

    SpriteBtnL(18, 47, 1.0, false); //Display L, Z, and R button icons
    SpriteBtnZ(18, 62, 1.0, false);
    SpriteBtnR(300, 56, 1.0, false);

    int y=0;
    if (MENU_TAB == 0) //Set y position for arrow icons based on what menu I am on
    {
        y = MENU_Y_GAME * 12;
    }
    else if (MENU_TAB == 1)
    {
         y = MENU_Y_ITEMS * 12;
    }
    else if (MENU_TAB == 2)
    {
        y = MENU_Y_BOTS * 12;
    }
    else if (MENU_TAB == 3)
    {
        y = MENU_Y_OPTIONS * 12;
    }
    SpriteBtnDUp(18, y+82, 1.0, false);
    SpriteBtnDDown(18, y+96, 1.0, false);
    SpriteBtnDLeft(153, y+88, 1.0, false);
    SpriteBtnDRight(305, y+88, 1.0, false);

}

void FlyCamInit()
{
    for (int Pass = 0; Pass < 20; Pass++)
    {
        *(uint*)(&ok_FreeCam + Pass) = 0xFF00FF00;
    }
}

void three_d_camera_test()
{
    // //Copy entire camera structure from P1 to P2
    // for (int i=0; i < 3; i++)
    // {
    //     g_Camera2.camera_pos[i] = g_Camera1.camera_pos[i];
    //     g_Camera2.lookat_pos[i] = g_Camera1.lookat_pos[i];
    //     g_Camera2.up_vector[i] = g_Camera1.up_vector[i];
    //     g_Camera2.camera_direction[i] = g_Camera1.camera_direction[i];
    //     g_Camera2.camera_vector[i] = g_Camera1.camera_vector[i];
    //     g_Camera2.lookat_vector[i] = g_Camera1.lookat_vector[i];
    //     g_Camera2.velocity[i] = g_Camera1.velocity[i];
    // }
    // g_Camera2.flag = g_Camera1.flag;
    // g_Camera2.chase_direction = g_Camera1.chase_direction;
    // g_Camera2.bump = g_Camera1.bump;
    // g_Camera2.shake = g_Camera1.shake;
    // g_Camera2.old_chase_direction = g_Camera1.old_chase_direction;
    // g_Camera2.watch = g_Camera1.watch;
    // g_Camera2.stickdeg = g_Camera1.stickdeg;
    // g_Camera2.screen_view_angle = g_Camera1.screen_view_angle;
    g_Camera2 = g_Camera1;
    g_Camera1.camera_vector[0] = 0.75;
    g_Camera1.lookat_vector[0] = 0.75;
    g_Camera2.lookat_vector[0] = -0.75;
    g_Camera2.camera_vector[0] = -0.75;
    *(char*)(0x800DC533) = 0x2; //Force left right 2 player view
}


//Speed up a player who has turned into a bomb in zombombs
void bombSpeedup(int player)
{
    GlobalPlayer[player].acc_maxcount *= fractionSpeedWhenBomb; //Speed up player who has turned into a bomb
}

//Slow down all players who are bombs in zombombs
void bombSlowdown()
{
    for (int i=0; i<player_count; i++)
    {
        if (*(unsigned char*)(0x800F699C + (0xDD8 * i)) == 0x8) //If player is a bomb
        {
            GlobalPlayer[i].acc_maxcount /= fractionSpeedWhenBomb; //Slow player who has turned into a bomb back to their normal top speed
        }
    }
}

//void BombRolloverWrap(Player* Kart, char Kno)
void CheckHit(int PlayerIndex, int HitType) //Hook into wrapper
{

//     #define     BombThrowRolloverHT     0
// #define     RolloverHT                1
// #define     WheelSpinHT                2
// #define        BrokenHT                3
// #define     ThunderHT                4
// #define        SpinHT                    5
// #define        BombRolloverHT            6
// #define        ProWheelSpinHT            7


    // if (game_mode == 5 && HitType == 0) //If playing Zombombs game mode
    // {    
    //     makePlayerBomb(PlayerIndex);
    // }
}


//Function used for testing, displays player 1's position on the screen
void displayPlayerOnePosition()
{
    loadFont();
    printStringNumber(0x00, 0x00, "X", (int)GlobalPlayer[0].position[0]);
    printStringNumber(0x00, 0x0C, "Y", (int)GlobalPlayer[0].position[1]);
    printStringNumber(0x00, 0x18, "Z", (int)GlobalPlayer[0].position[2]);
}

//Function used for testing, displays game tempo
void displayGameTempo()
{
    loadFont();
    printStringNumber(0x00, 0x00, "GAME TEMPO", *(int*)(0x80150114));

}



//Automatically set race course starting positions based off the 0th path marker (e.g. where the finish line is)
void getStartingPositions()
{
    if (g_courseID != 0x13 && g_courseID != 0x11 && g_courseID != 0x10 && g_courseID != 0xF) //If not in a battle course
    {   
        
        float extraModeScale = 1.0; //Flip everything for extra/mirror mode
        if (g_raceClass == 3)
        {
            extraModeScale = -1.0;
        }

        short* PositionArray = (short*)GetRealAddress(PathTable[g_courseID][0]); //Get 0th marker position
        // printStringNumber(0x20, 0x20, "Marker X = ", (PositionArray[0]));
        // printStringNumber(0x20, 0x2C, "Marker Y = ", (PositionArray[0]));
        // printStringNumber(0x20, 0x38, "Marker Z = ", (PositionArray[0]));
        // printStringNumber(0x20, 0x20, "P1 X = ", (int)(GlobalPlayer[0].position[0]));
        // printStringNumber(0x20, 0x2C, "P1 Y = ", (int)(GlobalPlayer[0].position[1]));
        // printStringNumber(0x20, 0x38, "P1 Z = ", (int)(GlobalPlayer[0].position[2]));

        //Player 1
        GlobalPlayer[0].position[0] = extraModeScale * ((float)(PositionArray[0])+22.5);
        GlobalPlayer[0].position[1] = (float)(PositionArray[1])*scaleHeight+5.0;
        GlobalPlayer[0].position[2] = (float)(PositionArray[2]);
        GlobalPlayer[0].direction[1] = 0x8000;
        //Player 2
        GlobalPlayer[1].position[0] = extraModeScale * ((float)(PositionArray[0])+7.5);
        GlobalPlayer[1].position[1] = (float)(PositionArray[1])*scaleHeight+5.0;
        GlobalPlayer[1].position[2] = (float)(PositionArray[2]);
        GlobalPlayer[1].direction[1] = 0x8000;
        //Player 3
        GlobalPlayer[2].position[0] = extraModeScale * ((float)(PositionArray[0])-7.5);
        GlobalPlayer[2].position[1] = (float)(PositionArray[1])*scaleHeight+5.0;
        GlobalPlayer[2].position[2] = (float)(PositionArray[2]);
        GlobalPlayer[2].direction[1] = 0x8000;
        //Player 4
        GlobalPlayer[3].position[0] = extraModeScale * ((float)(PositionArray[0])-22.5);
        GlobalPlayer[3].position[1] = (float)(PositionArray[1])*scaleHeight+5.0;
        GlobalPlayer[3].position[2] = (float)(PositionArray[2]);
        GlobalPlayer[3].direction[1] = 0x8000;

        // //If course set to flat, set height to be just a bit above zero
        // if (status_options_flatcourses)
        // {
        //     GlobalPlayer[0].position[1] = 5.0;
        //     GlobalPlayer[1].position[1] = 5.0;
        //     GlobalPlayer[2].position[1] = 5.0;
        //     GlobalPlayer[3].position[1] = 5.0;
        // }
        // GlobalLakitu[0] -> activeFlag = 0;
        // GlobalLakitu[0] -> pickupFlag = 0;
        // GlobalLakitu[1] -> activeFlag = 0;
        // GlobalLakitu[1] -> pickupFlag = 0;
        // GlobalLakitu[2] -> activeFlag = 0;
        // GlobalLakitu[2] -> pickupFlag = 0;
        // GlobalLakitu[3] -> activeFlag = 0;
        // GlobalLakitu[3] -> pickupFlag = 0;
    }
}


//Checik if player is holding flag or not, and return true or false
bool isPlayerHoldingFlag(int player)
{

    if (ctf_game_mode == 0) //If single flag mode
    {
        return (player == playerHoldingFlag[0]);
    }
    else  //Else if multiflag mode
    {
        if (ffa_or_teams == 0) //If FFA and 
        {
            for (int i=0; i<player_count; i++)
            {
                if (player == playerHoldingFlag[i])
                {
                    return(true);
                }
            }
            return(false);
        }
        else //else if teams
        {
            if (player < 2) //If team 1
            {
                return(playerHoldingFlag[2] == player);
            }
            else //else if Team 2
            {
                return(playerHoldingFlag[0] == player);
            }
        }
    }

    //return(false); //If player is not carrying a flag, return false
}

//Check if team member is holding flag
bool isTeamMemberHoldingFlag(int player)
{
     if (ffa_or_teams == 0) //If FFA
     {
        return(false); //Return false since no teammates exist
     }
     else //Else if Teams
     {
            if (player < 2) //If team 1
            {
                if (playerHoldingFlag[2] != -1) //If someone holds the other team's flag
                {
                    if (playerHoldingFlag[2] != player) //And if that someone is not the current player
                    {
                        return(true);  //Return true since the teammate is holding
                    }
                }
                
            }
            else //else if Team 2
            {
                if (playerHoldingFlag[0] != -1) //If someone holds the other team's flag
                {
                    if (playerHoldingFlag[0] != player) //And if that someone is not the current player
                    {
                        return(true);  //Return true since the teammate is holding
                    }
                }
            }
            return(false); //Else return false
     }
}

//Check if someone else is holding player's flag or not, and return true or false
bool isSomeoneHoldingPlayerFlag(int player)
{
    if (ffa_or_teams == 0) //If FFA
    {
        return(playerHoldingFlag[player] != -1);
    }
    else //Else if teams
    {
        if (player < 2) //If team 1
        {
            return(playerHoldingFlag[0] != -1);
        }
        else //else if Team 2
        {
            return(playerHoldingFlag[2] != -1);
        }
    }

}

void test_universal_hook()
{
    loadFont();
    printString(0xC, 0x00, "IT WORKS");
}


//Return the between a player and an object (e.g. a flag or base)
short angleToObject(int currentPlayer, float object_x, float object_y)
{

    float objPos[3];

    objPos[0] = object_x;
    objPos[1] = 0.0;
    objPos[2] = object_y;
    // if ((GlobalPlayer[currentPlayer].sterrangle - CalcDirection(GlobalPlayer[currentPlayer].position, objectPosition)) > 0)
    // {
    //     return(0x32); //Turn one direction
    // }
    // else
    // {
    //     return(-0x32); //Turn the other direction
    // }
    short cStickValue;

    cStickValue = ObjectSubBehaviorTurnTarget(GlobalPlayer[currentPlayer].position, GlobalPlayer[currentPlayer].direction[1], objPos, 0x5);
    return cStickValue * 0x32;

}

short angleToBase(int currentPlayer)
{
    int baseNumber;
    if (ffa_or_teams == 0) //If FFA
    {
        baseNumber = currentPlayer; //Set base number to be the current player's base
    }
    else //else if teams
    {
        if(currentPlayer < 2) //If team 1
        {
            baseNumber = 0; //set base number to team 1's base
        }
        else //if team 2
        {
            baseNumber = 1; //Set base number to team 2's base
        }
    }

    return(angleToObject(currentPlayer, (float)basePositions[basePositionSelection][g_courseID][baseNumber][0], (float)basePositions[basePositionSelection][g_courseID][baseNumber][2]));
}

short angleToFlag(int currentPlayer, int flagNumber)
{
    if (ctf_game_mode == 0) //If single flag mode 
    {
        flagNumber = 0;
    }
    else if (ffa_or_teams == 1) //else if teams mode
    {
        if(currentPlayer < 2) //If team 1
        {
            flagNumber = 2; //set base number to team 1's base
        }
        else //if team 2
        {
            flagNumber = 0; //Set base number to team 2's base
        }
    }
    return(angleToObject(currentPlayer, currentFlagPositionsX[flagNumber], currentFlagPositionsY[flagNumber]));
}



//Function returns a bot rival if someone has picked up a flag, or their flag, or just runs the original find rival function if not
int getRival(int currentPlayer) //Note current player is 1,2,3,4, NOT 0,1,2,3
{

    int flag_holder;

    if (game_mode==4 || (game_mode == 3 && ctf_game_mode == 0)) //If game mode is keep away or if 1 flag CTF
    {
        flag_holder = playerHoldingFlag[0];
        if (ffa_or_teams == 0) //If FFA
        {
            if((flag_holder-1 != currentPlayer) && (flag_holder != -1))
            {
                return(flag_holder);
            }
        }
        else //If teams
        {
            
            if ((currentPlayer==0 || currentPlayer==1) && (flag_holder==2 ||flag_holder==3)) //Team 1
            {
                return(flag_holder);
            }
            else if  ((currentPlayer==2 || currentPlayer==3) && (flag_holder==0 || flag_holder==1))//Team 2
            {
                return(flag_holder);
            }
        }
    }
    else if (game_mode==3 && ctf_game_mode == 1) //If game mode is CTF multiflag
    {
        

        if (ffa_or_teams == 0) //If FFA
        {
            flag_holder = playerHoldingFlag[currentPlayer];
            if (flag_holder != -1)
            {
                return(flag_holder);
            }
        }
        else //If teams
        {
            if (currentPlayer==0 || currentPlayer==1) //Team 1
            {
                flag_holder = playerHoldingFlag[0];
                if (flag_holder != -1)
                {
                    return(flag_holder);
                } 
            }
            else if (currentPlayer==2 || currentPlayer==3) //Team 2
            {
                flag_holder = playerHoldingFlag[2];
                if (flag_holder != -1)
                {
                    return(flag_holder);
                } 
            }
        }

    }
    //else if game mode is anything else
    else if (MakeRandomLimmit(4) == 0) //Find a new rival 25% of the time
    {
        int enemy = 0;

        do{
            if (ffa_or_teams == 0) //If FFA
            {    
                    enemy = MakeRandomLimmit(player_count); //Randomly grab a rival
            }
            else //if teams
            {
                if (currentPlayer <= 1) //Team 1
                {
                    enemy = MakeRandomLimmit(2)+2; //Return 2 or 3 (players 3 or 4 on oppositing team)
                }
                else //Team 2
                {
                    enemy = MakeRandomLimmit(2); //Return 0 or 1 (players 1 or 2 on oppositing team)
                }

            }
        }while(currentPlayer == enemy || GlobalPlayer[enemy].flag == 0xC0); //If returned rival is the current player or dead, reroll the dice until a living rival can be found
        //return(getEnemy(currentPlayer)); //Run the old rival finding function that was written in assembly

        return(enemy);
    }
    //Else just return the current rival
    return(bot_rival_p1[currentPlayer]);
    //return(getEnemy(currentPlayer));
}




//Test displaying an object on track's position on the minimap with a dot
void minimap_display_sprite(int input_x, int input_y, int spriteAddress)
{
    // objectPosition[0] = *(float*)(Object + 24); //Get object x and z positions
    // //objectPosition[1] = *(float*)(Object + 28);
    // objectPosition[2] = *(float*)(Object + 32);
    float fx = (float)(input_x) * g_mapScale; //Scale object positions down to map size
    float fz = (float)(input_y) * g_mapScale;

    //GlobalAddressA = marioDotSprite + 8*8*8;


    short x = *(short*)(&g_mapX) + *(short*)(0x8018D2F0) - (*(short*)(0x8018D2B0)/2) +  *(short*)(0x8018D2E0) + (short)fx;  //Calculate x and y positions of object on map (see KWDisplay_radarplayer_sub for details)
    short y = *(short*)(&g_mapY) + *(short*)(0x8018D2F8) - (*(short*)(0x8018D2B8)/2) +  *(short*)(0x8018D2E8) + (short)fz;
    //KWSprite(x,y,8,8,(unsigned short*)(GlobalAddressA)); //Display the sprite
    KWSprite(x,y,8,8,(unsigned short*)spriteAddress); //Display the sprite

    if (player_count == 2 && !one_player_full_screen) //Display on 2nd minimap in 2 player mode if not in 1 player full screen mode
    {
        x = *(short*)(&g_mapX + 1) + *(short*)(0x8018D2F0) - (*(short*)(0x8018D2B0)/2) +  *(short*)(0x8018D2E0) + (short)fx;  //Calculate x and y positions of object on map (see KWDisplay_radarplayer_sub for details)
        y = *(short*)(&g_mapY + 1) + *(short*)(0x8018D2F8) - (*(short*)(0x8018D2B8)/2) +  *(short*)(0x8018D2E8) + (short)fz;
        KWSprite(x,y,8,8,(unsigned short*)spriteAddress); //Display the sprite
        //KWSprite(x,y,8,8,(unsigned short*)(GlobalAddressA)); //Display the sprite
    }

}  

    // float x = *(float*)(0x8018D2C0) + 


    // g_mapX + g_map2X
    // float y = g_mapY + g_map2Y


    //     x = radarx[screen]+rmodex-radarsizex/2+rzerox+(short)(fx);
    //     y = radary[screen]+rmodey-radarsizey/2+rzeroy+(short)(fz);



void ctf_minimap_display_flags_and_bases()
{

    

    //Display bases on minimap
    if (ffa_or_teams == 0) //If FFA
    {
        for (int i=0; i<player_count; i++)
        {
            GlobalAddressA = (long)(&theMinimapSprites) + BaseSpriteOffsets[Characters[i]];
            minimap_display_sprite(basePositions[basePositionSelection][g_courseID][i][0], basePositions[basePositionSelection][g_courseID][i][2], GlobalAddressA); 
            if (ctf_game_mode == 1) //If multiflag
            {
                GlobalAddressA = (long)(&theMinimapSprites) + FlagSpriteOffsets[Characters[i]];
                minimap_display_sprite((int)currentFlagPositionsX[i]+1, (int)currentFlagPositionsY[i], GlobalAddressA);
            }
        }
    }
    else //If teams
    {
        GlobalAddressA = (long)(&theMinimapSprites) + BaseSpriteOffsets[Characters[0]];
        minimap_display_sprite(basePositions[basePositionSelection][g_courseID][0][0], basePositions[basePositionSelection][g_courseID][0][2], GlobalAddressA);
        GlobalAddressA = (long)(&theMinimapSprites) + BaseSpriteOffsets[Characters[2]];
        minimap_display_sprite(basePositions[basePositionSelection][g_courseID][1][0], basePositions[basePositionSelection][g_courseID][1][2], GlobalAddressA);
        if (ctf_game_mode == 1) //If multiflag
        {
            GlobalAddressA = (long)(&theMinimapSprites) + FlagSpriteOffsets[Characters[0]];
            minimap_display_sprite((int)currentFlagPositionsX[0]+1, (int)currentFlagPositionsY[0], GlobalAddressA);
            GlobalAddressA = (long)(&theMinimapSprites) + FlagSpriteOffsets[Characters[2]];
            minimap_display_sprite((int)currentFlagPositionsX[2]+1, (int)currentFlagPositionsY[2], GlobalAddressA);
        }
    }
    if (ctf_game_mode == 0) //If single flag
    {
        GlobalAddressA = (long)(&theMinimapSprites) + FlagSpriteOffsets[0];
        minimap_display_sprite((int)currentFlagPositionsX[0]+1, (int)currentFlagPositionsY[0], GlobalAddressA);
    }
}


void keep_away_minimap_display_flag()
{
    GlobalAddressA = (long)(&theMinimapSprites) + FlagSpriteOffsets[0];
    minimap_display_sprite((int)currentFlagPositionsX[0]+1, (int)currentFlagPositionsY[0], GlobalAddressA);
}



bool detectEmulator()
{
    ConsolePlatform = CheckPlatform(); 
    return(ConsolePlatform);
}


//Set display to 1P only
void onePlayerFullScreen()
{
    if (in_results == 1) //Only run if not in results screen
    {
        GlobalScreen[0]->width = 320; //Set player 1's screen to be full screen
        GlobalScreen[0]->height = 240;
        GlobalScreen[0]->posx = 160;
        GlobalScreen[0]->posy = 120;
        g_mapX = 0x110; //Set minimap to the middle side
        g_mapY = 0x80;
        *(char*)(0x80165801) = 0x00; //Disable player 2's minimap so two minimaps don't show up in 2P mode
        *(float*)(0x800DDB3C) = 0.4; //Try to get zooming to be done as in for 1 player mode
        if (status_options_widescreen)
        {
            g_aspectRatio = 1.777777777777777;
        }
        else
        {
            g_aspectRatio = 1.333333333333333;
        }
        for(int i=1; i<player_count; i++) //Shrink all other player screens to oblivion
        {
            GlobalScreen[i]->width = 1;
            GlobalScreen[i]->height = 1;
            GlobalScreen[i]->posx = 320; //Send screens off to lala land so they don't get in the way
            GlobalScreen[i]->posy = 240;
        }
    }
}

//Hijack the makeBorder function so that the border between player screens can be disabled if 1P full screen is enabled
void hijackMakeBorder()
{
    if (one_player_full_screen == false) //If one player full screen is off...
    {
        makeBorder(); //Display the borders, otherwise just return and skip drawing borders
    }
}


//Hijack the executeitem function and check to see if a player is carrying a flag
//If player is carrying flag, don't let them fire the item
void hijackExecuteItem(void *Car)
{
    if ((game_mode == 3 || game_mode == 4) && no_items_when_holding_flag != 0) //If game mode is CTF
    {
        int carID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;
        //bool canFire = true;
        // for (int i=0; i < player_count; i++)
        // {
        //     if (playerHoldingFlag[i] == carID)
        //     {
        //         canFire = false;
        //     }
        // }
        // if (canFire == true)
        // {
        //     executeItem(Car);
        // }
        if (!isPlayerHoldingFlag(carID)) //If player is not carrying a flag
        {
            executeItem(Car);
        }
    }
    else{
        executeItem(Car);
    }
}



void setFlag(int flagNumber)
{
    int x, y, z;
    //CreateObjectSimple(0, 2, 106, 0x0000, 50); //Regenreate the flag at it's spawn point (x, y, z, angle, objid)
    if (ctf_game_mode == 1) //If multiflag
    {
        if (ffa_or_teams == 1) //If teams
        {
            if (flagNumber == 0) //If team 1
            {
                x = multiFlagPositions[basePositionSelection][g_courseID][0][0];
                y = multiFlagPositions[basePositionSelection][g_courseID][0][1];
                z = multiFlagPositions[basePositionSelection][g_courseID][0][2];
                //GlobalShortA = CreateObjectSimple(multiFlagPositions[basePositionSelection][g_courseID][0][0], multiFlagPositions[basePositionSelection][g_courseID][0][1], multiFlagPositions[basePositionSelection][g_courseID][0][2], 0x0000, 50);  //Spawn or regenerate flag at it's spawn point (x, y, z, angle, objid)    
            }
            else //else if Team 2
            {
                x = multiFlagPositions[basePositionSelection][g_courseID][1][0];
                y = multiFlagPositions[basePositionSelection][g_courseID][1][1];
                z = multiFlagPositions[basePositionSelection][g_courseID][1][2];
                //GlobalShortA = CreateObjectSimple(multiFlagPositions[basePositionSelection][g_courseID][1][0], multiFlagPositions[basePositionSelection][g_courseID][1][1], multiFlagPositions[basePositionSelection][g_courseID][1][2], 0x0000, 50);  //Spawn or regenerate flag at it's spawn point (x, y, z, angle, objid)    
            }
        }
        else //Else if game is FFA
        {
            //GlobalShortA = CreateObjectSimple(multiFlagPositions[g_courseID][flagNumber][0], multiFlagPositions[g_courseID][flagNumber][1], multiFlagPositions[g_courseID][flagNumber][2], 0x0000, 50);  //Spawn or regenerate flag at it's spawn point (x, y, z, angle, objid)    
            //GlobalShortA = CreateObjectSimple(multiFlagPositions[basePositionSelection][g_courseID][flagNumber][0], multiFlagPositions[basePositionSelection][g_courseID][flagNumber][1], multiFlagPositions[basePositionSelection][g_courseID][flagNumber][2], 0x0000, 50);  //Spawn or regenerate flag at it's spawn point (x, y, z, angle, objid)    
            x = multiFlagPositions[basePositionSelection][g_courseID][flagNumber][0];
            y = multiFlagPositions[basePositionSelection][g_courseID][flagNumber][1];
            z = multiFlagPositions[basePositionSelection][g_courseID][flagNumber][2];        
        }
    }
    else //Else if single flag
    {

        if (MakeRandomLimmit(4) == 0 || (g_courseID != 0x13 && g_courseID != 0x11 && g_courseID != 0x10 && g_courseID != 0xF))  //If random is zero or if not on a battle course, 
        {
            if (g_raceClass != 3) //If not extra mode
            {
                x = singleFlagPositions[g_courseID][0];
            }
            else //else if extra mode, flip the x position
            {
                x = - singleFlagPositions[g_courseID][0];
            }
            y = singleFlagPositions[g_courseID][1];
            z = singleFlagPositions[g_courseID][2];
        }
        else //or else randomly spawn flag at one of th 4 predetermined multiflag locations for a course
        {
            int random_flag_location_number = MakeRandomLimmit(4);
            int random_starting_position_set = MakeRandomLimmit(3);
            x = multiFlagPositions[random_starting_position_set][g_courseID][random_flag_location_number][0];
            y = multiFlagPositions[random_starting_position_set][g_courseID][random_flag_location_number][1];
            z = multiFlagPositions[random_starting_position_set][g_courseID][random_flag_location_number][2];                
        }
    }
    
    if (status_options_flatcourses) //If courses are flat, set y (height) to match the course height, which is set to player 1's height at course initialization
    {
        y = (int)course_height;
    }

    GlobalShortA = CreateObjectSimple(x, y, z, 0x0000, 50);  //Spawn or regenerate flag at it's spawn point (x, y, z, angle, objid)    
    GlobalAddressA = (long)(&g_SimpleObjectArray);
    *(short*)(GlobalAddressA + (0x70 * GlobalShortA) + 4) = flagNumber; //Store flag number in simple object

    playerHoldingFlag[flagNumber] = -1;
}

void setBase(int posNumber, int baseNumber)
{
    
    int x = basePositions[basePositionSelection][g_courseID][posNumber][0];
    int y = basePositions[basePositionSelection][g_courseID][posNumber][1];
    int z = basePositions[basePositionSelection][g_courseID][posNumber][2];
    if (status_options_flatcourses) //If courses are flat, set y (height) to match the course height, which is set to player 1's height at course initialization
    {
        y = (int)course_height - 5;
    }
    //GlobalShortA = CreateObjectSimple(basePositions[basePositionSelection][g_courseID][posNumber][0], basePositions[basePositionSelection][g_courseID][posNumber][1], basePositions[basePositionSelection][g_courseID][posNumber][2], 0x0000, 51);  //Spawn or flag the flag at it's spawn point (x, y, z, angle, objid)
    GlobalShortA = CreateObjectSimple(x, y, z, 0x0000, 51);  //Spawn or flag the flag at it's spawn point (x, y, z, angle, objid)
    GlobalAddressA = (long)(&g_SimpleObjectArray);
    *(short*)(GlobalAddressA + (0x70 * GlobalShortA) + 4) = baseNumber; //Store base number in simple object
}


//Pause game to allow player(s) to select starting positions
void selectStartingPositions()
{
    if (ctf_game_started == false)
    {
        int selectionBoxPositionOffset = 0x18*basePositionSelection;
        g_startingIndicator = 0x1; //Force game to not start by forcing g_startingIndicator to be 0x1
        if (basePositionSelection < 4) //Show description and selection box if not selecting custom starting position
        {
            *(float*)0x802BA034 = 1.0; //Set player 1's screen to be full screen


            GraphPtr = DrawRectangle(GraphPtr, 0x10, 0xC, 0x12C, 0x40, 0, 0, 0, 0xA0); //Large box for text and selection
            GraphPtr = DrawRectangle(GraphPtr, 0x7B + selectionBoxPositionOffset, 0x21, 0x8D + selectionBoxPositionOffset, 0x2F, 0x80, 0x80, 0x40, 0xFF); //Small box only for selection
            GraphPtr = DrawRectangle(GraphPtr, 0x7C + selectionBoxPositionOffset, 0x22, 0x8C + selectionBoxPositionOffset, 0x2E, 0x00, 0x00, 0xFF, 0xFF); //Small box only for selection


            loadFont();
            printString(0xC, 0x00, "Please select starting positions");
            printString(0x1C, 0x10, "Press  :  1  2  3  4");
            printString(0x1C, 0x20, "Press   to begin game");


            SpriteBtnA(99, 40, 1.0, false);
            SpriteBtnStart(99, 55, 1.0, false);

            //Set starting positions
            if (*(char*)0x8018EE09 < 3) //If playifng a race course
            {
                getStartingPositions(); //Set starting positions to the race starting positoins
                basePositionSelection = 3; //Force starting positions to be custom
            }
            else if (ffa_or_teams == 0) //If FFA
            {
                for (int i=0; i < player_count; i++) //Set player starting positions for FFA
                {
                    *(float*)((&g_player1LocationX) + (i*0xDD8/4)) = (float)multiFlagPositions[basePositionSelection][g_courseID][i][0] + 5;
                    if (status_options_flatcourses) 
                    {
                        *(float*)((&g_player1LocationY) + (i*0xDD8/4)) = course_height;
                    }
                    else
                    {
                        *(float*)((&g_player1LocationY) + (i*0xDD8/4)) = (float)multiFlagPositions[basePositionSelection][g_courseID][i][1] + 5;
                    }                    
                    *(float*)((&g_player1LocationZ) + (i*0xDD8/4)) = (float)multiFlagPositions[basePositionSelection][g_courseID][i][2] + 5;
                }
            }
            else //If teams
            {
                //Set player 1
                *(float*)((&g_player1LocationX)) = (float)multiFlagPositions[basePositionSelection][g_courseID][0][0] + 5;
                if (status_options_flatcourses) 
                {
                    *(float*)((&g_player1LocationY)) = course_height;
                }
                else
                {
                    *(float*)((&g_player1LocationY)) = (float)multiFlagPositions[basePositionSelection][g_courseID][0][1] + 5;
                }
                *(float*)((&g_player1LocationZ)) = (float)multiFlagPositions[basePositionSelection][g_courseID][0][2] + 5;
                //Set player 2
                *(float*)((&g_player1LocationX) + (1*0xDD8/4)) = (float)multiFlagPositions[basePositionSelection][g_courseID][0][0] - 5;
                if (status_options_flatcourses) 
                {
                    *(float*)((&g_player1LocationY) + (1*0xDD8/4)) = course_height;
                }
                else
                {
                    *(float*)((&g_player1LocationY) + (1*0xDD8/4)) = (float)multiFlagPositions[basePositionSelection][g_courseID][0][1] + 5;
                }
                
                *(float*)((&g_player1LocationZ) + (1*0xDD8/4)) = (float)multiFlagPositions[basePositionSelection][g_courseID][0][2] - 5;
                //Set player 3
                *(float*)((&g_player1LocationX) + (2*0xDD8/4)) = (float)multiFlagPositions[basePositionSelection][g_courseID][1][0] + 5;
                if (status_options_flatcourses) 
                {
                    *(float*)((&g_player1LocationY) + (2*0xDD8/4)) = course_height;
                }
                else
                {
                    *(float*)((&g_player1LocationY) + (2*0xDD8/4)) = (float)multiFlagPositions[basePositionSelection][g_courseID][1][1] + 5;
                }
                *(float*)((&g_player1LocationZ) + (2*0xDD8/4)) = (float)multiFlagPositions[basePositionSelection][g_courseID][1][2] + 5;
                //Set player 4
                *(float*)((&g_player1LocationX) + (3*0xDD8/4)) = (float)multiFlagPositions[basePositionSelection][g_courseID][1][0] - 5;
                if (status_options_flatcourses) 
                {
                    *(float*)((&g_player1LocationY) + (3*0xDD8/4)) = course_height;
                }
                else
                {
                    *(float*)((&g_player1LocationY) + (3*0xDD8/4)) = (float)multiFlagPositions[basePositionSelection][g_courseID][1][1] + 5;
                } 
                *(float*)((&g_player1LocationZ) + (3*0xDD8/4)) = (float)multiFlagPositions[basePositionSelection][g_courseID][1][2] - 5;
            }

        
            //if (lastButtonPressed[0] == 0x00) //If no button is pressed
            //{
                if (GlobalController[0]->ButtonPressed & BTN_A) //If the last button pressed is A
                {
                    playSound(0x49008000); //sound "cursol"
                    basePositionSelection++;
                    if (basePositionSelection > 3)
                    {
                        basePositionSelection = 0;
                    }
                }
                else if (GlobalController[0]->ButtonPressed & BTN_START && basePositionSelection < 3) //If the last button pressed is start and selection is 1, 2, or 3 (preset starting positions)
                {
                    ctf_game_started = true;
                }
                else if (GlobalController[0]->ButtonPressed & BTN_START && basePositionSelection == 3) //If the last button pressed is start and selection is 4 (custom starting positions)
                {
                    basePositionSelection = 4; //Set basePositionSelection to 4 to flag that the players are 
                    for (int i=0; i < player_count; i++)
                    {
                        playSound(0x49008016); //sound "menu ok"
                        GlobalPlayer[i].flag = 0xC000;
                    }
                }
                // else if (basePositionSelection == 4)
                // {
                //     //do stuff
                // }
            //}
            //Set player positions
            // if (basePositionSelection < 3)
            // {

            // }
            if (basePositionSelection == 3)
            {
                GraphPtr = DrawRectangle(GraphPtr, 0x10, 0x50, 0x12C, 0x90, 0, 0, 0, 0xA0); //Large box for text and selection
                loadFont();
                printString(0xC, 0x40, "Custom base positions.  Press ");
                printString(0xC, 0x4C, "start, drive to desired starting");
                printString(0xC, 0x58, "position. Press start again to");
                printString(0xC, 0x64, "set starting position.  Game will");
                printString(0xC, 0x70, "start when all players are ready.");

            }
        }
        else //If selecting a custom 
        {
            bool player_frozen[4];




            //Press start to be ready or not for selecting starting positions
            for (int i=0; i < player_count; i++)
            {
                //if (lastButtonPressed[i] == 0x00 && *(char*)(GlobalController[i]+0x4) & 0x10)
                player_frozen[i] = GlobalPlayer[i].flag & 0x2000; //Store if this player is frozen (or not)
                if (GlobalController[i] -> ButtonPressed & BTN_START)
                {
                    playSound(0x49008016); //sound "menu ok"
                    if (player_frozen[i])
                    {
                        GlobalPlayer[i].flag = 0xC000;
                    }
                    else
                    {
                        GlobalPlayer[i].flag = 0xE000;
                    }
                }
            }

            // //Freeze bots so they don't wander around
            for (int i=0; i<4; i++)
            {
                if (bot_status_p1[i] > 0)
                {
                    player_frozen[i] = true;
                    GlobalPlayer[i].flag = 0xE000;
                }
            }
            // if (bot_status_p1) 
            // {
            //     player_frozen[0] = true;
            //     GlobalPlayer[0].flag = 0xE000;
            // }
            // if (bot_status_p2)
            // {
            //     player_frozen[1] = true;
            //     GlobalPlayer[1].flag = 0xE000;
            // }
            // if (bot_status_p3)
            // {
            //     player_frozen[2] = true;
            //     GlobalPlayer[2].flag = 0xE000;
            // }
            // if (bot_status_p4)
            // {
            //     player_frozen[3] = true;
            //     GlobalPlayer[3].flag = 0xE000;
            // }


            //Display "READY" when ready and start game when everyone is ready
            if (player_count == 2)
            {
                if(player_frozen[0]) {printString(0x78, 0x28, "READY");}
                if(player_frozen[1] && !one_player_full_screen) {printString(0x78, 0x98, "READY");}
                if (player_frozen[0] && player_frozen[1])
                {
                    ctf_game_started = true;
                }

            }
            else if (player_count == 3)
            {
                if(player_frozen[0]) {printString(0x28, 0x28, "READY");}
                if(player_frozen[1] && !one_player_full_screen) {printString(0xC8, 0x28, "READY");}
                if(player_frozen[2] && !one_player_full_screen) {printString(0x28, 0x98, "READY");}
                if (player_frozen[0] && player_frozen[1] && player_frozen[2])
                {
                    ctf_game_started = true;
                }
            }
            else //player_count == 4
            {
                if(player_frozen[0]) {printString(0x28, 0x28, "READY");}
                if(player_frozen[1] && !one_player_full_screen) {printString(0xC8, 0x28, "READY");}
                if(player_frozen[2] && !one_player_full_screen) {printString(0x28, 0x98, "READY");}
                if(player_frozen[3] && !one_player_full_screen) {printString(0xC8, 0x98, "READY");}
                if (player_frozen[0] && player_frozen[1] && player_frozen[2] && player_frozen[3])
                {
                    ctf_game_started = true;
                }
            }
        }

        if (ctf_game_started == true) //If 
        {
            playSound(0x49008016); //sound "menu ok"

            //Set base and flag positions based on if custom positions are set
            if (basePositionSelection == 4)
            {
                for (int i=0; i < player_count; i++)
                {
                    multiFlagPositions[3][g_courseID][i][0] = (int) (*(float*)((&g_player1LocationX) + (i*0xDD8/4)) -5);
                    multiFlagPositions[3][g_courseID][i][1] = (int) (*(float*)((&g_player1LocationY) + (i*0xDD8/4)) -5);
                    multiFlagPositions[3][g_courseID][i][2] = (int) (*(float*)((&g_player1LocationZ) + (i*0xDD8/4)) -5);
                    basePositions[3][g_courseID][i][0] = (int) (*(float*)((&g_player1LocationX) + (i*0xDD8/4)) - 25);
                    basePositions[3][g_courseID][i][1] = (int) (*(float*)((&g_player1LocationY) + (i*0xDD8/4)) -5 );
                    basePositions[3][g_courseID][i][2] = (int) (*(float*)((&g_player1LocationZ) + (i*0xDD8/4)) -25);
                }
                basePositionSelection = 3; //Set basePositionSelection back to 3 so that bases and flags will spawn in the correct position
            }

            //Initialize flag and base objects
            if (ffa_or_teams == 0) //If FFA
            {
                for (int i=0; i < player_count; i++) //Loop through each player and set their individual flags and bases
                {
                    if (ctf_game_mode == 1) //If in multiflag mode
                    {
                        setFlag(i);
                    }
                    setBase(i, i);
                }
            }
            else //else if Teams
            {
                if (ctf_game_mode == 1) //If in multiflag mode
                {
                     setFlag(0);
                     setFlag(2);
                }
                if (basePositionSelection == 3) //If custom positions are set, use player 1 and 3's positions to set the team bases
                {
                    setBase(0, 0);
                    setBase(2, 2);
                }
                else //If preset positions are used, use what used to player 1's base position for Team 2
                {
                    setBase(0, 0);
                    setBase(1, 2);
                }
            }
            if (ctf_game_mode == 0) //If single flag mode
            {
                setFlag(0);
            }
        }

        // for (int i=0; i < player_count; i++)
        // {
        //     lastButtonPressed[i] = *(char*)(GlobalController[i]+0x4);
        // }

        // lastButtonPressed[0] = BUTTON_ACTIVATOR_1_P1;
        // lastButtonPressed[1] = BUTTON_ACTIVATOR_1_P2;
        // lastButtonPressed[2] = BUTTON_ACTIVATOR_1_P3;
        // lastButtonPressed[3] = BUTTON_ACTIVATOR_1_P4;
    }
}





//Initialize flags and bases
void initCTF()
{
    ctf_game_started = false; //Set game_started to false so that base location selection can commence
    //course_height = GlobalPlayer[0].position[1];
    basePositionSelection = 0; //Always start with the first starting position


    //Initialize variables
    for (int i=0; i<4; i++)
    {
        playerHoldingFlag[i] = -1;
        flag_count[i] = 0;
        flagTimer[i] = 0;
        flagDropped[i] = false;

        GlobalAddressA = (long)(&g_PlayerStructTable) + (0xDD8 * i); //Set characters for each player
        GlobalShortA = *(short*)(GlobalAddressA + 0x254);
        Characters[i] = GlobalShortA;

    }

}

//Initialize keep away mode and load single flag
void initKeepAway()
{
    //course_height = GlobalPlayer[0].position[1];

    //Initialize variables
    for (int i=0; i<4; i++)
    {
        playerHoldingFlag[i] = -1;
        flag_count[i] = 0;
        flagTimer[i] = 0;
        flagDropped[i] = false;


        // GlobalAddressA = (long)(&g_PlayerStructTable) + (0xDD8 * i); //Set characters for each player
        // GlobalShortA = *(short*)(GlobalAddressA + 0x254);
        // Characters[i] = GlobalShortA;

    }

    //Set up single flag
    ctf_game_mode = 0;
    setFlag(0);

    //playerHoldingFlag[0] = 0; //TESTING DISPLAYING FLAG, DELETE WHEN DONE


}

//Function to handle keep away scoring with the keep away timer
void trackKeepAwayScoring()
{
    if (playerHoldingFlag[0] != -1) //If someone is holding the flag
    {
        keepAwayTimer = decrementTimerWrapper(keepAwayTimer); //Decrement keep away timer every frame
        if (keepAwayTimer <= 0) //If player has held flag long enough to score
        {
            incrementScore(playerHoldingFlag[0]);
            //playSound(0x49008017);
            keepAwayTimer = keepAwayTimerMax;
        }
    }
}


//Drop flag at location where player is hit
void dropFlagAfterHit()
{

    for (int flagNumber=0; flagNumber < player_count; flagNumber++)
    {
        if (playerHoldingFlag[flagNumber] != -1)
        {
            if (check_if_hit(playerHoldingFlag[flagNumber]) == 1)
            {                  
                
                if (slow_when_holding_flag != 0)
                {
                    GlobalAddressA = (long)&g_PlayerStructTable + (playerHoldingFlag[flagNumber] * 0xDD8) + 0x214;
                    *(float*)(GlobalAddressA) /= fractionSpeedWhenHoldingFlag; //Increase top speed
                }

                GlobalAddressA = (long)&g_PlayerStructTable + (playerHoldingFlag[flagNumber] * 0xDD8);
                objectPosition[0] = *(float*)(GlobalAddressA + 20)-7.0;
                objectPosition[1] = *(float*)(GlobalAddressA + 24)-3.0;
                objectPosition[2] = *(float*)(GlobalAddressA + 28)-7.0;

                GlobalShortA = CreateObject(objectPosition, 50); //Regenreate the flag at the player's current position
                GlobalAddressA = (long)(&g_SimpleObjectArray);
                *(short*)(GlobalAddressA + (0x70 * GlobalShortA) + 4) = flagNumber; //Store flag number in simple object

                playerHoldingFlag[flagNumber] = -1;
                flagDropped[flagNumber] = true;
                flagTimer[flagNumber] = 700;
            }
        }
    }
}

//void DrawLightBulb()
void DrawPerScreen(Camera* LocalCamera)
{  

    
    if (game_mode ==3 || game_mode==4) //If game is ctf or keep away
    {       
        int baseTurn;
        int addTurn;

       
        for (int flagNumber=0; flagNumber < player_count; flagNumber++)
        {
            if (playerHoldingFlag[flagNumber] != -1)
            {
                GlobalAddressA = (long)&g_PlayerStructTable + (playerHoldingFlag[flagNumber] * 0xDD8);

                //GlobalAddressB =  (long)&FlagModel;
                if (ctf_game_mode == 1) //Multi flag
                {
                    GlobalAddressB = FlagOffsets[Characters[flagNumber]];
                }
                else //Single flag
                    GlobalAddressB = BattleFlag;


                baseTurn = *(short*)(GlobalAddressA + 46);
                addTurn = *(short*)(GlobalAddressA + 192);

                objectPosition[0] = *(float*)(GlobalAddressA + 20);
                objectPosition[1] = *(float*)(GlobalAddressA + 24)-3.0;
                objectPosition[2] = *(float*)(GlobalAddressA + 28);

                
                
                objectAngle[0] = 0;
                objectAngle[1] = -(baseTurn + addTurn)+0x3000;
                objectAngle[2] = 0;

                DrawGeometryScale(objectPosition,objectAngle,GlobalAddressB, 0.06);




                //minimap_test();
                currentFlagPositionsX[flagNumber] = objectPosition[0];
                currentFlagPositionsY[flagNumber] = objectPosition[2];

                // //Prevent item usage if holding the flag (if set)
                // if (no_items_when_holding_flag != 0)
                // {
                //     switch(playerHoldingFlag[flagNumber])
                //     {
                // //         case 1:
                //             *(char*)(0x80165F5B) = 0;
                //             *(char*)(0x80165F5D) = 0;
                //             *(char*)(0x80165F8A) = 0;
                //             *(char*)(0x8016611B) = 0;
                //             *(char*)(0x8016611D) = 0;
                //             *(char*)(0x8016614A) = 0;
                //         case 2:
                //             *(char*)(0x8016603D) = 0;
                //             *(char*)(0x8016606A) = 0;
                //             *(char*)(0x801661FD) = 0;
                //             *(char*)(0x8016622A) = 0;
                //         case 3:
                //             *(char*)(0x801662DD) = 0;
                //             *(char*)(0x8016630A) = 0;
                //         case 4:
                //             *(char*)(0x801663BD) = 0;
                //             *(char*)(0x801663EA) = 0;
                //     }
                // }
            }
        }
    }

}


void DisplayFlag(void *Camera, void *Object)
{
    
    

    //camera goes unused but is passed by the game's internal function

    //int flagNumber;

    //GlobalAddressA = *(long*)(&Object);
    int flagNumber = *(short*)(Object + 4);

    objectPosition[0] = *(float*)(Object + 24);
    objectPosition[1] = *(float*)(Object + 28);
    objectPosition[2] = *(float*)(Object + 32);

    //minimap_test();
    currentFlagPositionsX[flagNumber] = objectPosition[0];
    currentFlagPositionsY[flagNumber] = objectPosition[2];

    objectAngle[0] = *(short*)(Object + 16);
    objectAngle[1] = *(short*)(Object + 18);
    objectAngle[2] = *(short*)(Object + 20);
    *(short*)(Object + 18) += DEG1 * 3;

    //GlobalAddressB =  (long)&FlagModel;
    if (ctf_game_mode == 1) //Multi flag
    {
        GlobalAddressB =  FlagOffsets[Characters[flagNumber]];
    }
    else //Single flag
    {
        GlobalAddressB = BattleFlag;
    }

    //If flag has dropped and timer < 0, respawn the flag
    if (flagDropped[flagNumber])
    {
        if (flagTimer[flagNumber] < 0)
        {
            deleteObjectBuffer(Object);
            setFlag(flagNumber);
            flagDropped[flagNumber] = false;
        }
        else if (flagTimer[flagNumber] < 250) //If timer gets lower, flicker the flag faster
        {
            if (flagTimer[flagNumber]%10 < 5)
            {
                 DrawGeometryScale(objectPosition,objectAngle,GlobalAddressB, 0.1);
            }
        }
        else if (flagTimer[flagNumber] < 500)
        {
            if (flagTimer[flagNumber]%30 < 15) //If timer gets lowish, flicker the flag
            {

                 DrawGeometryScale(objectPosition,objectAngle,GlobalAddressB, 0.1);
            }
        }
        else{
            DrawGeometryScale(objectPosition,objectAngle,GlobalAddressB, 0.1);
        }
    }
    else
    {
        DrawGeometryScale(objectPosition,objectAngle,GlobalAddressB, 0.1);
    }

    
}


//Display the base you bring the flags to, for now it is another flag for testing
void DisplayBase(void *Camera, void *Object)
{
    //GlobalAddressB =  (long)&BaseModel;
    //GlobalAddressA = *(long*)(&Object);
    int baseNumber = *(short*)(Object + 4);

    //GlobalAddressB = BaseOffsets[Characters[baseNumber]];


    objectPosition[0] = *(float*)(Object + 24);
    objectPosition[1] = *(float*)(Object + 28);
    objectPosition[2] = *(float*)(Object + 32);

    objectAngle[0] = *(short*)(Object + 16);
    objectAngle[1] = *(short*)(Object + 18);
    objectAngle[2] = *(short*)(Object + 20);
    //*(short*)(GlobalAddressA + 18) += DEG1 * 3;
    DrawGeometryScale(objectPosition, objectAngle, BaseOffsets[Characters[baseNumber]], 0.5);

}


int BaseCollide(void *Car, void *Base)
{
    int carID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;


    //GlobalAddressA = *(long*)(&Base);
    int baseNumber = *(short*)(Base + 4);


    bool canHitBase;
    if (ffa_or_teams == 0)
    {
        canHitBase = carID == baseNumber; //Players can run into their own base
    }
    else
    {  
        canHitBase = false;
        if (baseNumber == 0 && (carID == 0 || carID == 1)){canHitBase = true;} //Teams can run into their own base
        if (baseNumber == 2 && (carID == 2 || carID == 3)){canHitBase = true;}
    }

    objectPosition[0] = *(float*)(Base + 24);
    objectPosition[1] = *(float*)(Base + 28);
    objectPosition[2] = *(float*)(Base + 32);


    if (CollisionCylinder(Car,objectPosition,7.0f,5.0f,0.0f) == 1 && canHitBase)
    {
        //*targetAddress = 0x353500FF;
        //deleteObjectBuffer(Flag);
        //playSound(0x49008017);
        //flag_count++;
        //playerID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;
        for (int flagNumber=0; flagNumber < 4; flagNumber++)
        {
            if (playerHoldingFlag[flagNumber] == carID)
            {
                setFlag(flagNumber); 
                incrementScore(carID);
                playSound(0x49008017);
                flagTimer[flagNumber] = 0;
                if (slow_when_holding_flag != 0)
                {
                    //GlobalAddressA = (long)&g_PlayerStructTable + (carID * 0xDD8) + 0x214;
                    //*(float*)(GlobalAddressA) /= fractionSpeedWhenHoldingFlag; //Increase top speed
                    *(float*)(Car + 0x214) /= fractionSpeedWhenHoldingFlag; //Increase top speed
                }
            }
        }

    }
    // if (flag_count == 8)
    // {
    //     playerID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;
    //     SetStar(Car,playerID);
    //     flag_count++;
    // }

    return(0);
}


int FlagCollide(void *Car, void *Flag)
{
    int flagNumber;
    //GlobalAddressA = *(long*)(&Flag);
    flagNumber = *(short*)(Flag + 4);
    int carID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;



    // if (canHitFlag == false) //Respawn flag if you pick up your own flag
    // {
    //     *targetAddress = 0x353500FF;
    //     deleteObjectBuffer(Flag);
    //     setFlag(flagNumber);
    // }


    if (check_if_hit(carID) == 0 && playerHoldingFlag[0] != carID && playerHoldingFlag[1] != carID && playerHoldingFlag[2] != carID && playerHoldingFlag[3] != carID)   //Only allow players who are not current "being hit" to pick up the flag
    {

        bool canHitFlag=true;
        if (ctf_game_mode == 1) //If multi flag mode, players and teams can't pick up their own flag, they must pick up other flags, if single flag, anyone can pick up the flag
        {
            if (ffa_or_teams == 0)
            {
                canHitFlag = carID != flagNumber; //Players can't pick up their own flag
            }
            else
            {  
                if (flagNumber == 0 && (carID == 0 || carID == 1)){canHitFlag = false;} //Teams can't pick up their own flag
                if (flagNumber == 2 && (carID == 2 || carID == 3)){canHitFlag = false;}
            }
        }

        objectPosition[0] = *(float*)(Flag + 24);
        objectPosition[1] = *(float*)(Flag + 28);
        objectPosition[2] = *(float*)(Flag + 32);
        if ((CollisionCylinder(Car,objectPosition,3.5f,5.0f,0.0f) == 1))
        {
            // //*targetAddress = 0x353500FF;
            // deleteObjectBuffer(Flag);
            // playSound(0x49008017);
            if (canHitFlag) //If not your own flag, pick it up
            {                
                deleteObjectBuffer(Flag);
                playSound(0x49008017);
                flag_count[flagNumber]++;
                playerHoldingFlag[flagNumber] = carID;
                if (slow_when_holding_flag != 0)
                {
                    //GlobalAddressA = (long)&g_PlayerStructTable + (carID * 0xDD8) + 0x214; //Load player top speed
                    //*(float*)(GlobalAddressA) *= fractionSpeedWhenHoldingFlag; //Decrease top speed
                    *(float*)(Car + 0x214) *= fractionSpeedWhenHoldingFlag; //Decrease top speed
                }
                if (no_items_when_holding_flag != 0)
                {

                    SetStarMan(carID, false);
                    SetGhostEffect(carID, false);

                }
                if (game_mode == 4) //If game mode is keep away
                {
                    keepAwayTimer = keepAwayTimerMax; //Reset keep away timer for scoring
                }
            }
            else if(flagTimer[flagNumber] > 0) //If your own flag and it is sitting on the course and hasn't respawned, respawn it
            {
                deleteObjectBuffer(Flag);
                playSound(0x49008017);
                setFlag(flagNumber);
                flagTimer[flagNumber] = 0;
                flagDropped[flagNumber] = false;

            }
        }
        // if (flag_count == 8)
        // {
        //     playerID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;
        //     SetStar(Car,playerID);
        //     flag_count++;
        // }
    }

    return(0);
}


/////MENU STUFF

//Function to handle the ability to select custom courses
void menuStuff()
{

    // //Print an address for debugging
    // loadFont();
    // // printStringUnsignedHex( 0, 10, "", (uint)(&RAM_END) );
    // printStringNumber( 0, 0, "Course Value", courseValue) ;
    // printStringNumber( 0, 0x10, "courseValue", courseValue) ;
    // printStringNumber( 0, 0x20, "HotSwapID", HotSwapID) ;
    // printStringNumber( 0, 0x30, "SYSTEM_Region", SYSTEM_Region) ;
    // printStringNumber( 0, 0x40, "KBGNumber", KBGNumber) ;
    // printStringNumber( 0, 0x50, "MenuChanged", MenuChanged) ;
    // printStringNumber( 0, 0x60, "g_gameMode", g_gameMode);
    // printStringNumber( 0, 0x70, "menuScreenA", menuScreenA);



 
    // //Needed for custom courses
    // SetCloudType((char)OverKartHeader.SkyType);
    // SetWeatherType((char)OverKartHeader.WeatherType);
    // SetWeather3D(OverKartHeader.SkyType == 3);
    // SetWaterType((char)OverKartHeader.WaterType);
    
    
    
    if (SYSTEM_Region == 0x01)
    {
        
        if (HotSwapID > 0)
        {
            if (g_gameMode != 3)
            {
                g_courseID = 0;
            }
            else
            {
                g_courseID = 15;
            }
        }
        if (g_courseID == 0x14)
        {
            g_player1ScreenWidth = 0x0240;
        }
    }



    switch(KBGNumber)
    {
        case 10:
        {
            MenuChanged = 10;
            break;
        }
        case 11:
        {
            scrollLock = false;
            g_startingIndicator = 0;
            if (MenuChanged != 11)
            {
                MenuChanged = 11;
                //saveEEPROM((uint)&SaveGame);
                saveEEPROM((uint)&VARIABLE_RAM_BASE);
            }
            //GameSelectMenu();
            HotSwapID = 0;
            break;
        }
        case 12:
        {
            scrollLock = false;
            //PlayerSelectMenu((short)gameMode[1]);
            //PlayerSelectMenuStart();
            MenuChanged = 12;
            HotSwapID = 0;
            break;
        }         

        case 13:
        {
            scrollLock = false;
            g_startingIndicator = 0;
            if (MenuChanged != 13)
            {
                MenuChanged = 13;
                MenuToggle = 0;
                MenuIndex = 0;            
                HotSwapID = 0;
                stockASM();
                hsLabel = -1;
                courseValue = -1;
            }        
            //PlayerSelectMenuAfter();        
            MapSelectMenu();
            break;
        }

    }


    if (MenuChanged == 13)
    {
    
        DrawBox(60,15,200,40,0,0,0,255);
        if (HotSwapID == 0)
        {
            PrintBigText(75,20, 0.80f,"Original Set");
        }
        else if (HotSwapID < 10)
        {
            PrintBigTextNumber(75,20, 0.80f,"Custom Set  ",HotSwapID);
        }
        else
        {
            PrintBigTextNumber(75,20, 0.80f,"Custom Set ",HotSwapID);
        }
        SpriteBtnCLeft(45,35,1.0,false);
        SpriteBtnCRight(279,35,1.0,false);
        
    }
}

//

//Run every frame while in game, needed for custom courses to work
void customCourseRunEveryFrame()
{


    // loadFont();
    // printStringUnsignedHex(10,10, "thing", *(uint*)(0x800F6990));


    //Needed for custom courses
    SetCloudType((char)OverKartHeader.SkyType);
    SetWeatherType((char)OverKartHeader.WeatherType);
    SetWeather3D(OverKartHeader.SkyType == 3);
    SetWaterType((char)OverKartHeader.WaterType);
}



//At bootup, one time, you'll want to run the following for custom courses to work
void bootCustomCourseStuff()
{

    loadBigFont();
    loadHeaderOffsets();    
    loadHudButtons();
    SetupFontF3D();

    dataLength = 8;
    *sourceAddress = (long)((long)(&g_SequenceTable) + (3 * 8) + 4);    
    *targetAddress = (long)&ok_Sequence;
    runRAM();

    *sourceAddress = (long)((long)(&g_InstrumentTable) + (3 * 8) + 4);
    *targetAddress = (long)&ok_Instrument;
    runRAM();

    *sourceAddress = (int)&g_BombTable;
    *targetAddress = (long)&ok_Bomb;    
    dataLength = 0xA8;
    runRAM();

    *(long*)(&ok_USAudio) = *(long*)(&g_RawAudio + 1);
    *(long*)(&ok_USAudio + 1) = *(long*)(&g_InstrumentTable + 1);


    *(long*)(&ok_MRSong) = *(long*)(&g_SequenceTable + (3 * 2) + 1);
    *(long*)(&ok_MRSong + 1) = *(long*)(&g_InstrumentTable + (3 * 2) + 1);
    
    FreeSpaceAddress = (int)&ok_Storage;

    copyCourseTable(1);
    NopSplashCheckCode();
    FlyCamInit();
    nopASM = 0;
    HotSwapID = 0;
    // asm_SongA = 0x240E0001;
    // asm_SongB = 0x240E0001;

}    

// //For custom coureses
// void MapStartup(short InputID)
// {
//     LoadCustomHeader(courseValue + gpCourseIndex);
//     SetCustomData();
//     LoadMapData(InputID);

// }
// void InitialMapCode()
// {
    
//     InitialMap();
//     if ((HotSwapID > 0) && (g_gameMode == 3))
//     {
//         SearchListFile(0x06000000 | OverKartHeader.SurfaceMapPosition);
//         MakeCollision();
//     }
// }

// void XLUDisplay(Screen* PlayerScreen)
// {    
//     if ((OverKartHeader.Version > 4) && (HotSwapID > 0))
//     {    
//         if (g_gameMode != 3)
//         {
//             DisplayGroupmap(GetRealAddress(SegmentAddress(6,OverKartHeader.XLUSectionViewPosition)), PlayerScreen);
//         }
//         else
//         {
//             *(long*)*graphPointer = (long)(0x06000000);
//             *graphPointer = *graphPointer + 4;
//             *(long*)*graphPointer = (long)(SegmentAddress(6,OverKartHeader.XLUSectionViewPosition));
//             *graphPointer = *graphPointer + 4;
//         }
//     }
// }


//For Zombombs

// void infectPlayersHitByBombs()
// {
//     for (int i=0; i<player_count; i++)
//     {
//         if (checkHitBomb(i))
//         {
//             killPlayer(i); //If ap layer is hit by a bomb, kill them and turn them into a bomb as well
//         }
//     }
// }

//

void botControl(void *Car, Controller *cont,char kno)
{
    int carID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;

    if (bot_status_p1[carID] > 0)
    {
        cont->ButtonHeld = bot_buttons[carID]; //bot_controller_input_p1[carID]; //Test moving player 2 foward
        cont->AnalogX = bot_x_stick[carID]; //Turn some direction
    }
    
}


//Bot artificial intelligence
void runBots()
{

    loadFont();
    //printStringNumber(80,120, "g_courseID", g_courseID);


    if (game_paused == 0) //Skip code if game is paused
    {
        for (int i=0; i<player_count; i++) //Loop through each bot
        {

                //Bot goes straight or turning at random
            if(bot_status_p1[i] > 0) //If bot is on
            {   
                bot_timer_p1[i] = decrementTimerWrapper(bot_timer_p1[i]); //decrement the current bot's timer
                //int angle_difference = abs(bot_angle_p1[i] - GlobalPlayer[i].direction[1]);
                //bool hitting_wall = GlobalPlayer[i].wallhitcount != 0;
                
               //  objectPosition[0] = 20.0; //Set up vector IN FRONT of player
               //  objectPosition[1] = -6.0;
               //  objectPosition[2] = 70.0;
               //  MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1]);


               //  bool hitting_wall_left = check_bump((Bump*)(uint)(&bot_bump[i]), 10.0, GlobalPlayer[i].position[0]+objectPosition[0], GlobalPlayer[i].position[1]+objectPosition[1], GlobalPlayer[i].position[2]+objectPosition[2]) != 0x4000;

               //  objectPosition[0] = -20.0; //Set up vector IN FRONT of player
               //  objectPosition[1] = -6.0;
               //  objectPosition[2] = 70.0;
               //  MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1]);


               //  bool hitting_wall_right = check_bump((Bump*)(uint)(&bot_bump[i]), 10.0, GlobalPlayer[i].position[0]+objectPosition[0], GlobalPlayer[i].position[1]+objectPosition[1], GlobalPlayer[i].position[2]+objectPosition[2]) != 0x4000;
               //  //bool hitting_wall = checkTriangleXY((Bump*)(uint)(&GlobalPlayer[i].bump), 10.0, hitPosition0, hitPosition1, hitPosition2, GlobalPlayer[i].bump.last_xy) || checkTriangleYZ((Bump*)(uint)(&GlobalPlayer[i].bump), 10.0, hitPosition0, hitPosition1, hitPosition2, GlobalPlayer[i].bump.last_yz);


               //  objectPosition[0] = 0.0; //Set up vector IN FRONT of player
               //  objectPosition[1] = -5.0;
               //  objectPosition[2] = 70.0;
               //  MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1]);

                // bool cliff_detection = check_bump((Bump*)(uint)(&bot_bump[i]), 10.0, GlobalPlayer[i].position[0]+objectPosition[0], GlobalPlayer[i].position[1]+objectPosition[1], GlobalPlayer[i].position[2]+objectPosition[2]) == 0x0000;


               //  // //DEBUGGING TEXT FOR AI CLIFF AND WALL AVOIDANCE, UNCOMMENT TO DISPLAY
               //  // if (i==1)
               //  // {
               //  //     loadFont();     
               //  //     if (hitting_wall_left)
               //  //     {   
               //  //         printString(0x00, 0x10, "P2 hitting a wall left");
               //  //     }
               //  //     else if (hitting_wall_right)
               //  //     {   
               //  //         printString(0x00, 0x10, "P2 hitting a wall right");
               //  //     }                    
               //  //     else
               //  //     {
               //  //         printString(0x00, 0x10, "P2 not hititng a wall");
               //  //     }
               //  //     if (cliff_detection)
               //  //     {
               //  //         printString(0x00, 0x20, "P2 found a cliff, OH NO!");
               //  //     }       
               //  //     printStringHex(0x00, 0x30, "P2 flag_xy", bot_bump[i].flag_xy);
               //  //     printStringHex(0x00, 0x3C, "P2 flag_yz", bot_bump[i].flag_yz);
               //  //     printStringHex(0x00, 0x48, "P2 flag_zx", bot_bump[i].flag_zx);

               //  // }

               // //If following a path marker, ignore cliffs and walls
               //  if (bot_path_progression[i] > 0)
               //  {
               //      hitting_wall_left = false;
               //      hitting_wall_right = false;
               //      bot_steering_p1[i] = 0;
               //  }


               //  //if (!hitting_wall && bot_steering_p1[i] == 10 && angle_difference < 0x3800) //If after hitting a wall, no longer hitting a wall (having turned ~20 degrees)
               //  if ((!hitting_wall_left && !hitting_wall_right) && bot_steering_p1[i] == 10)
               //  {
               //      bot_steering_p1[i] = 0;
               //      bot_timer_p1[i] = MakeRandomLimmit(20) +  30; //Reset bot timer
               //  }
               //  // else if (hitting_wall && angle_difference < 0xE000) //IF having turned a bit but still hitting the wall, reset angle and 
               //  // {
               //  //     bot_angle_p1[i] = GlobalPlayer[i].direction[1] + 0x8000; //Bot will turn to this angle (~100 degrees)
               //  // }
               //  else if (bot_steering_p1[i] == 10)//Steer right after hitting a wall
               //  {
               //      // if (GlobalPlayer[i].speed <= 1)
               //      // {
               //          if (bot_wall_zigzag[i])
               //          {
               //              bot_controller_input_p1[i] = 0x80005000; //Preess A+B, turn right, go backwards
               //              if (cliff_detection)
               //              {
               //                  GlobalPlayer[i].direction[1] += 500*getTempo();
               //              }
               //          }
               //          else
               //          {
               //              bot_controller_input_p1[i] = 0x8000B000; //Preess A+B, turn right, go backwards'
               //              if (cliff_detection)
               //              {
               //                  GlobalPlayer[i].direction[1] -= 500*getTempo();
               //              }
               //          }
               //  }
               //  else if (hitting_wall_left) //If bot hits a wall
               //  {
               //      bot_steering_p1[i] = 10;  //Set bot steering state to either 10 or 11 to tell bot which way to turn
               //      //bot_timer_p1[i] = 30; //Reset timer which will now be used to let the bot turn out of being stuck on the wall
               //      //bot_angle_p1[i] = GlobalPlayer[i].direction[1] + 0x8000; //Bot will turn to this angle (~100 degrees)
               //      bot_wall_zigzag[i] = 1; //Flip direction bot will turn every time it hits a wall
               //      //bot_wall_zigzag[i] = !bot_wall_zigzag[i];
               //      bot_controller_input_p1[i] = 0x8000B000; //Preess B+R (to hop, turn left)
               //  }
               //  else if (hitting_wall_right)
               //  {
               //      bot_steering_p1[i] = 10;  //Set bot steering state to either 10 or 11 to tell bot which way to turn
               //      //bot_timer_p1[i] = 30; //Reset timer which will now be used to let the bot turn out of being stuck on the wall
               //      //bot_angle_p1[i] = GlobalPlayer[i].direction[1] + 0x8000; //Bot will turn to this angle (~100 degrees)
               //      bot_wall_zigzag[i] = 0; //Flip direction bot will turn every time it hits a wall
               //      //bot_wall_zigzag[i] = !bot_wall_zigzag[i];
               //      bot_controller_input_p1[i] = 0x80005000; //Preess B+R (to hop, turn left)                    
               //  }
               // else if (bot_ai_type == 0) //Normal bot AI type
                if (bot_ai_type == 0) ///Normal bot AI type
                {
                    if (bot_timer_p1[i] <= 0) //If bot timer is <= 0, roll the dice and maybe get a new rival
                    {
                        bot_rival_p1[i] = getRival(i);
                        bot_timer_p1[i] = MakeRandomLimmit(16) +  50; //Reset bot timer
                        if (bot_steering_p1[i] == 0) //If bot was going straight
                        {               
                            bot_steering_p1[i] = MakeRandomLimmit(2) + 1; //Set bot to turn right or left
                            bot_timer_p1[i] = MakeRandomLimmit(8) +  8; //Reset bot timer
                        }
                        else
                        {
                            bot_steering_p1[i] = 0; //Set bot to go straight
                            bot_timer_p1[i] = MakeRandomLimmit(16) +  16; //Reset bot timer
                        }
                    }
                    //Set bot controller
                    switch(bot_steering_p1[i])
                    {
                        case 0: //follow rival
                            switch( ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], GlobalPlayer[bot_rival_p1[i]].position, 0x7) ) //Returns -1 or 1, to give direction to turn
                            {
                                case 0:
                                    bot_buttons[i] = BTN_A;
                                    bot_x_stick[i] = 0x00;
                                    break;
                                case 1:
                                    bot_buttons[i] = BTN_A;
                                    bot_x_stick[i] = 0x50;
                                    break;
                                case -1:
                                    bot_buttons[i] = BTN_A;
                                    bot_x_stick[i] = -0x50;
                                    break;
                            }
                            break;
                        case 1: //turn right
                            bot_buttons[i] = BTN_A;
                            bot_x_stick[i] = 0x50;
                            break;
                        case 2: //turn left
                            bot_buttons[i] = BTN_A;
                            bot_x_stick[i] = -0x50;
                            break;
                    }
                }
                else if (bot_ai_type == 1) //Seeker bot AI type
                {
                    float rival_x = GlobalPlayer[0].position[0]; //x,y,z coords of rival
                    float rival_y = GlobalPlayer[0].position[1];
                    float rival_z = GlobalPlayer[0].position[2];
                    float bot_x = GlobalPlayer[i].position[0]; //x,y,z coordinates of current bot
                    float bot_y = GlobalPlayer[i].position[1];
                    float bot_z = GlobalPlayer[i].position[2];
                    // if (bot_timer_p1[i] <= 0) //If bot timer is <= 0, roll the dice and maybe get a new rival
                    // {
                    //     bot_rival_p1[i] = getRival(i);
                    //     bot_timer_p1[i] = MakeRandomLimmit(160) +  500; //Reset bot timer
                        
                    //     AIPathfinder[i].Target[0] = GlobalPlayer[0].position[0]; //Reset path finding in case bot gets lost
                    //     AIPathfinder[i].Target[1] = GlobalPlayer[0].position[1];
                    //     AIPathfinder[i].Target[2] = GlobalPlayer[0].position[2];
                    //     UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 300, BlockFortPaths_Paths, BlockFortPaths_PathLengths, 28, i, 0); 
                    // }

 
                    //TESTING AI MOVING TOWARDS A POINT
                    if (g_courseID == 0xF)
                    {


                        // printStringNumber(0,110,"P2 Target Path", AIPathfinder[1].TargetPath);
                        // printStringNumber(0,120,"P2 Last Path", AIPathfinder[1].LastPath);
                        // // printFloat(0,130,AIPathfinder[1].Distance);
                        // printStringNumber(0,130,"P2 path progress", AIPathfinder[1].Progression);
                        // printStringNumber(0,140,"P2 path direction", AIPathfinder[1].Direction);
                        // printStringNumber(0,150,"P2 path type", AIPathfinder[1].PathType);

                        // // printStringNumber(0, 150, "", BlockFortPaths_Paths[AIPathfinder[1].TargetPath][AIPathfinder[1].Progression].Position[0]);
                        // // printStringNumber(40, 150, "", BlockFortPaths_Paths[AIPathfinder[1].TargetPath][AIPathfinder[1].Progression].Position[1]);
                        // // printStringNumber(80, 150, "", BlockFortPaths_Paths[AIPathfinder[1].TargetPath][AIPathfinder[1].Progression].Position[2]);
                        // //printStringUnsignedHex(10, 160, "P2 controller input", bot_controller_input_p1[1]);

                        // // printStringUnsignedHex(10, 160, "P2 Bot buttons",  bot_buttons[1]);
                        // // printStringNumber(10, 170, "P2 Bot x stick value",  bot_x_stick[1]);
                        // // printStringUnsignedHex(10, 160, "P1 controller thing",  *(uint*)(0x1FC007C0));
                        // // printStringUnsignedHex(10, 170, "P1 controller thing2", *(uint*)(0x1FC007C4));
                        // printStringNumber(10, 180, "P2 BOT TIMER", bot_timer_p1[1]);
                        // printStringUnsignedNumber(10, 190, "P2 bot status", bot_status_p1[1]);

                        // printStringUnsignedHex(10, 200, "insideMenu", insideMenu);

                        if ((AIPathfinder[i].TargetPath == 0 && AIPathfinder[i].LastPath==0) && (AIPathfinder[i].Direction == 0))//Initialize the path finding if course is just starting
                        {

                            //First set up BKPathfinder for P2 to follow P1
                            AIPathfinder[i].Target[0] = rival_x;
                            AIPathfinder[i].Target[1] = rival_y;
                            AIPathfinder[i].Target[2] = rival_z;
                            UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 300, BlockFortPaths_Paths, BlockFortPaths_PathLengths, 28, i, 0);                            
                        }




                        int marker_index = AIPathfinder[i].Progression;
                        int target_path = AIPathfinder[i].TargetPath;
                        int direction = AIPathfinder[i].Direction;
                        switch (AIPathfinder[i].PathType) //Get position of current marker to drive towards
                        {
                            case 0: //flat paths
                                objectPosition[0] = (float)BlockFortPaths_Paths[target_path][marker_index].Position[0];
                                objectPosition[1] = (float)BlockFortPaths_Paths[target_path][marker_index].Position[1];
                                objectPosition[2] = (float)BlockFortPaths_Paths[target_path][marker_index].Position[2]; 
                                break;
                            case 1: //ramps
                                objectPosition[0] = (float)BlockFortPaths_Ramps[target_path][marker_index].Position[0];
                                objectPosition[1] = (float)BlockFortPaths_Ramps[target_path][marker_index].Position[1];
                                objectPosition[2] = (float)BlockFortPaths_Ramps[target_path][marker_index].Position[2]; 
                                break;
                            case 2: //drops 
                                objectPosition[0] = (float)BlockFortPaths_Drops[target_path][marker_index].Position[0];
                                objectPosition[1] = (float)BlockFortPaths_Drops[target_path][marker_index].Position[1];
                                objectPosition[2] = (float)BlockFortPaths_Drops[target_path][marker_index].Position[2]; 
                                break;
                        }


                        float x_distance = bot_x - objectPosition[0];
                        //float y_distance = bot_y;
                        float z_distance = bot_z - objectPosition[2];
                        float distance_from_marker = x_distance*x_distance + z_distance*z_distance;

                        if (distance_from_marker < 400) //If near the next path marker, advance to the next path marker
                        {
                            marker_index += direction;
                            AIPathfinder[i].Progression = marker_index;
                        }

                        float diff_y = rival_y - bot_y;
                        switch (AIPathfinder[i].PathType)
                        {
                            case 0:  //If bot is following a flat path
                                if ( (marker_index==0 && direction==-1)  || (marker_index==BlockFortPaths_PathLengths[target_path]-1 && direction==1) || (marker_index < 0) || (marker_index > BlockFortPaths_PathLengths[target_path]-1)) //If bot reaches end of path
                                {                               
                                    if ((diff_y > -20.0) && (diff_y < 20.0)) //If bots are on same plane
                                    {
                                        AIPathfinder[i].Target[0] = rival_x;
                                        AIPathfinder[i].Target[1] = rival_y;
                                        AIPathfinder[i].Target[2] = rival_z;
                                        UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 300.0, BlockFortPaths_Paths, BlockFortPaths_PathLengths, 28, i, 0);
                                    }
                                    else if (diff_y >= 20.0) //If player is above bot
                                    {
                                        float nodePosition[] = {0.,0.,0.};
                                        //First find nearest ramp
                                        FindNearestPathNode(GlobalPlayer[i].position, nodePosition, BlockFortPaths_Ramps, BlockFortPaths_RampLengths, 12);
                                        float diff_x = bot_x - nodePosition[0];
                                        float diff_z = bot_z - nodePosition[2];
                                        if (diff_x*diff_x + diff_z*diff_z < 22500.0) //If bot is at ramp, use ramp
                                        {
                                            AIPathfinder[i].Target[0] = rival_x;
                                            AIPathfinder[i].Target[1] = rival_y;
                                            AIPathfinder[i].Target[2] = rival_z;
                                            UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 300.0, BlockFortPaths_Ramps, BlockFortPaths_RampLengths, 12, i, 1);
                                        }
                                        else{// Else find path to nearest ramp
                                            AIPathfinder[i].Target[0] = nodePosition[0];
                                            AIPathfinder[i].Target[1] = nodePosition[1];
                                            AIPathfinder[i].Target[2] = nodePosition[2];
                                            UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 300.0, BlockFortPaths_Paths, BlockFortPaths_PathLengths, 28, i, 0);                                            
                                        }

                                    }
                                    else if (diff_y <= -20.0)
                                    {
                                        //FOR NOW JUST USE RAMPS, LATER WILL ADD RAMPS AND DROPS
                                        float nodePosition[] = {0.,0.,0.};
                                        //First find nearest ramp
                                        FindNearestPathNode(GlobalPlayer[i].position, nodePosition, BlockFortPaths_Ramps, BlockFortPaths_RampLengths, 12);
                                        float diff_x = bot_x - nodePosition[0];
                                        float diff_z = bot_z - nodePosition[2];
                                        if (diff_x*diff_x + diff_z*diff_z < 22500.0) //If bot is at ramp, use ramp
                                        {
                                            AIPathfinder[i].Target[0] = rival_x;
                                            AIPathfinder[i].Target[1] = rival_y;
                                            AIPathfinder[i].Target[2] = rival_z;
                                            UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 300.0, BlockFortPaths_Ramps, BlockFortPaths_RampLengths, 12, i, 1);
                                        }
                                        else{// Else find path to nearest ramp
                                            AIPathfinder[i].Target[0] = nodePosition[0];
                                            AIPathfinder[i].Target[1] = nodePosition[1];
                                            AIPathfinder[i].Target[2] = nodePosition[2];
                                            UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 300.0, BlockFortPaths_Paths, BlockFortPaths_PathLengths, 28, i, 0);                                            
                                        }
                                    }
                                }
                                break;
                            case 1: //If bot is following a ramp
                                if ( (marker_index==0 && direction==-1)  || (marker_index==BlockFortPaths_RampLengths[target_path]-1 && direction==1) || (marker_index < 0) || (marker_index > BlockFortPaths_RampLengths[target_path]-1)) //If bot reaches end of path
                                {
                                    AIPathfinder[i].Target[0] = rival_x; //Done with the ramp so go back to a flat path
                                    AIPathfinder[i].Target[1] = rival_y;
                                    AIPathfinder[i].Target[2] = rival_z;
                                    UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 300.0, BlockFortPaths_Paths, BlockFortPaths_PathLengths, 28, i, 0);                                   
                                }
                                break;
                            case 2: //If bot is following a drop
                                break;
                        }





                        switch( ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], objectPosition, 0x9) ) //Returns -1 or 1, to give direction to turn
                        {

                            case 0:
                                bot_buttons[i] = BTN_A;
                                bot_x_stick[i] = 0x00;
                                break;
                            case 1:
                                bot_buttons[i] = BTN_A + BTN_B;
                                bot_x_stick[i] = 0x70;
                                break;
                            case -1:
                                bot_buttons[i] = BTN_A + BTN_B;
                                bot_x_stick[i] = -0x70;
                                break;
                        }

                        //Testing pathfinding



                    }

                    //TESTING AI MOVING TOWARDS A POINT

                    else{

                        switch( ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], GlobalPlayer[bot_rival_p1[i]].position, 0x7) ) //Returns -1 or 1, to give direction to turn
                        {
                            case 0:
                                bot_buttons[i] = BTN_A;
                                bot_x_stick[i] = 0x00;
                                break;
                            case 1:
                                bot_buttons[i] = BTN_A;
                                bot_x_stick[i] = 0x50;
                                break;
                            case -1:
                                bot_buttons[i] = BTN_A;
                                bot_x_stick[i] = -0x50;
                                break;
                        }
                    //TESTING AI MOVING TOWARDS A POINT

                    }




                }
                else if (bot_ai_type == 2) //Random bot AI type
                {



                    float x_distance = GlobalPlayer[i].position[0]-test_bot_sphere_position[i][0];
                    float y_distance = GlobalPlayer[i].position[1]-test_bot_sphere_position[i][1];
                    float z_distance = GlobalPlayer[i].position[2]-test_bot_sphere_position[i][2];
                    bot_distance_from_path_marker[i] = x_distance*x_distance + y_distance*y_distance + z_distance*z_distance;

                    if  (y_distance*y_distance > 200.0) //If elevation has changed signifcantly
                    {
                        short randomness=0x800;
                        objectPosition[0] = 0.0; //Set up vector IN FRONT of player
                        objectPosition[1] = 0.0;
                        objectPosition[2] = 180.0;
                        MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1] + MakeRandomLimmit(randomness) - (randomness/2));   
                        test_bot_sphere_position[i][0] = objectPosition[0] + GlobalPlayer[i].position[0];
                        test_bot_sphere_position[i][1] = objectPosition[1] + GlobalPlayer[i].position[1];
                        test_bot_sphere_position[i][2] = objectPosition[2] + GlobalPlayer[i].position[2];
                    }
                    else if ((bot_distance_from_path_marker[i] <= 62500.0) || (test_bot_sphere_position[i][0] == 0.0)) //If bot comes near point or if game is started
                    {   
                        short randomness=0x1000;
                        int bumpCheckValue1, bumpCheckValue2, bumpCheckValue3;
                        // int bumpCheckValue_up;
                        // int bumpCheckValue_down;
                        int count=0;
                        do{
                            count++;

                            objectPosition[0] = 0.0; //Set up vector IN FRONT of player
                            objectPosition[1] = -5.0;
                            objectPosition[2] = 70.0;                            
                            MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1]);
                            objectPosition[0] += GlobalPlayer[i].position[0];
                            objectPosition[1] += GlobalPlayer[i].position[1];
                            objectPosition[2] += GlobalPlayer[i].position[2];
                            bumpCheckValue3= check_bump((Bump*)(uint)(&bot_bump[i]), 10.0, objectPosition[0], objectPosition[1], objectPosition[2]);


                            objectPosition[0] = 0.0; //Set up vector IN FRONT of player
                            objectPosition[1] = 0.0;
                            objectPosition[2] = 300.0;
                            MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1] + MakeRandomLimmit(randomness) - (randomness/2));   
                            objectPosition[0] += GlobalPlayer[i].position[0];
                            objectPosition[1] += GlobalPlayer[i].position[1];
                            objectPosition[2] += GlobalPlayer[i].position[2];
                            bumpCheckValue1 = check_bump((Bump*)(uint)(&bot_bump[i]), 10.0, objectPosition[0], objectPosition[1], objectPosition[2]);
                            bumpCheckValue2 = check_bump((Bump*)(uint)(&bot_bump[i]), 10.0, objectPosition[0], objectPosition[1]-5.0, objectPosition[2]);
 
                            //bumpCheckValue3 = check_bump((Bump*)(uint)(&bot_bump[i]), 20.0, objectPosition[0], objectPosition[1]+5.0, objectPosition[2]);

                            // bumpCheckValue_up = check_bump((Bump*)(uint)(&bot_bump[i]), 10.0, objectPosition[0], objectPosition[1]-20, objectPosition[2]);
                            // bumpCheckValue_down = check_bump((Bump*)(uint)(&bot_bump[i]), 10.0, objectPosition[0], objectPosition[1]+20, objectPosition[2]);
                            randomness += 0x80;
                        }while((bumpCheckValue1 != 0x4000 && bumpCheckValue2 != 0x4000 && bumpCheckValue3 != 0x4000) && count < 100);
                        test_bot_sphere_position[i][0] = objectPosition[0];
                        test_bot_sphere_position[i][1] = objectPosition[1];
                        test_bot_sphere_position[i][2] = objectPosition[2];
                    }

                    switch( ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], test_bot_sphere_position[i], 0x7) ) //Returns -1 or 1, to give direction to turn
                    {
                        case 0:
                            bot_buttons[i] = BTN_A;
                            bot_x_stick[i] = 0x00;
                            //bot_controller_input_p1[i] = 0x80000000; //Press A, go foward
                            break;
                        case 1:
                            bot_buttons[i] = BTN_A;
                            bot_x_stick[i] = 0x50;
                            // bot_controller_input_p1[i] = 0x80005000; //Preess A+B, turn right
                            break;
                        case -1:
                            bot_buttons[i] = BTN_A;
                            bot_x_stick[i] = -0x50;
                            //bot_controller_input_p1[i] = 0x8000B000; //Preess A+B, turn left
                            break;
                    }

                   // //Bot straight -> turn -> straight -> turn   sequence
                   //  if (bot_timer_p1[i] <= 0) //If bot timer is <= 0, swap bot behavior between steering and straight
                   //  {   
                   //      if (bot_steering_p1[i] == 0) //If bot was going straight
                   //      {               
                   //          bot_steering_p1[i] = MakeRandomLimmit(2) + 1; //Set bot to turn right or left
                   //          bot_timer_p1[i] = MakeRandomLimmit(8) +  8; //Reset bot timer
                   //      }
                   //      else
                   //      {
                   //          bot_steering_p1[i] = 0; //Set bot to go straight
                   //          bot_timer_p1[i] = MakeRandomLimmit(16) +  16; //Reset bot timer
                   //      }
                   //  }
                   //  //Set bot controller
                   //  switch(bot_steering_p1[i])
                   //  {
                   //      case 0:
                   //          bot_controller_input_p1[i] = 0x80000000; //Press A, go foward
                   //          break;
                   //      case 1:
                   //          bot_controller_input_p1[i] = 0x80005000; //Preess A, turn right
                   //          break;
                   //      case 2:
                   //          bot_controller_input_p1[i] = 0x8000B000; //Preess A, turn left
                   //          break;
                   //  }
                }
     
            }




            // if (i==0)
            // {
            //     objectPosition[0] = 0.0; //Set up vector IN FRONT of player
            //     objectPosition[1] = 0.0;
            //     objectPosition[2] = 50.0;
            //     MakeAlignVector(objectPosition, GlobalPlayer[i].direction[1] + GlobalPlayer[i].slipang);
            //     float hitPosition0 = GlobalPlayer[i].position[0] + objectPosition[0];
            //     float hitPosition1 = GlobalPlayer[i].position[1] + objectPosition[1];
            //     float hitPosition2 = GlobalPlayer[i].position[2] + objectPosition[2];
            //     // bool hitting_wall = checkTriangleXY((Bump*)(uint)(&GlobalPlayer[i].bump), 10.0, hitPosition0, hitPosition1, hitPosition2, GlobalPlayer[i].bump.last_xy) || checkTriangleYZ((Bump*)(uint)(&GlobalPlayer[i].bump), 10.0, hitPosition0, hitPosition1, hitPosition2, GlobalPlayer[i].bump.last_yz);

                
            //     loadFont();   
            //     printStringHex(0x00, 0x10, "P1 check_bump", check_bump((Bump*)(uint)(&bot_bump[i]), 20.0, hitPosition0, hitPosition1, hitPosition2));
            //     // if (hitting_wall)
            //     // {   
            //     //     printString(0x00, 0x10, "P1 hitting a wall");
            //     // }
            //     // else
            //     // {
            //     //     printString(0x00, 0x20, "P1 not hititng a wall");
            //     // }
            // }




        }
    }





    // loadFont();
    // printStringNumber(0x00, 0x10, "P1 near wall XY", checkTriangleXY((Bump*)(uint)(&GlobalPlayer[0].bump), 25.0, GlobalPlayer[0].position[0], GlobalPlayer[0].position[1], GlobalPlayer[0].position[2], GlobalPlayer[0].bump.last_xy) );
    // printStringNumber(0x00, 0x20, "P1 near wall YZ", checkTriangleYZ((Bump*)(uint)(&GlobalPlayer[0].bump), 25.0, GlobalPlayer[0].position[0], GlobalPlayer[0].position[1], GlobalPlayer[0].position[2], GlobalPlayer[0].bump.last_yz) );

    //extern static int checkTriangleZX(long unsigned int *bump,float radius,float p1x,float p1y, float p1z, ushort pointer)
    // printStringUnsignedHex(0x00, 0x10, "P2 rival", bot_rival_p1[1]);
    // printStringUnsignedHex(0x00, 0x20, "P3 rival", bot_rival_p1[2]);
    // printStringUnsignedHex(0x00, 0x30, "P4 rival", bot_rival_p1[3]);


    // printStringNumber(0x00, 0x00, "Bot P2 timer ", bot_timer_p1[1]);
    // printStringNumber(0x00, 0x10, "Bot P2 rival  ", bot_rival_p1[1]);
    // printStringUnsignedHex(0x00, 0x20, "Bot P2 input", bot_controller_input_p1[1] );

}


void DisplayObject(void *Camera, Object *Object)
{
    objectIndex = (short)((*(long*)(*(long*)(&Object)) >> 16) & 0x0000FFFF);



    switch (objectIndex)
    {
        case 50:
        {
            DisplayFlag(Camera, Object);
            break;
        }
        case 51:
        {   
            DisplayBase(Camera, Object);
            break;
        }
    }
}


int CollideObject(Player* car, Object* Object)
{
    objectIndex = (short)((*(long*)(*(long*)(&Object)) >> 16) & 0x0000FFFF);
    switch (objectIndex)
    {
        case 50:
        {
            return FlagCollide(car, Object);
            break;
        }
        case 51:
        {   
            return BaseCollide(car, Object);
            break;
        }   
        // case 10:
        //     // loadFont();
        //     // printStringUnsignedHex(0x00, 0x10, "Camera", *(unsigned int*)Camera);
        //     // printStringUnsignedHex(0x00, 0x20, "Object", *(unsigned int*)Object);
        //     return 0;
        //     break;
        // case 47:
        // {
        //     return RedCoinCollide(Camera,Object);

        //     break;
        // }
        // case 48:
        // case 49:
        // {
        //     return GoldCoinCollide(Camera,Object);

        //     break;
        // }
        default:
        {
            return 0;
            break;
        }
    }
    return 0;
}

void allRun()
{
    //nothing goes here
}



uint BKCheckAddress = 0x80600000;
void MakeBKTest(uint A, uint B)
{
    *(uint*)(BKCheckAddress) = A;
    BKCheckAddress+=4;
    *(uint*)(BKCheckAddress) = B;
    BKCheckAddress+=4;
}

void setBKCheckAddress()
{
    BKCheckAddress = 0x80600000;
}

// void MakeBKTest(uint A, uint B)
// {
//     *(uint*)0x80600000 = A;
//     *(uint*)0x80600004 = B;
// }

// //Check why collision sphere is crashing by saving the first two arguments to ram
// void bug_check(uint thing1, uint thing2)
// {
//     *(uint*)0x80600000 = thing1;
//     *(uint*)0x80600004 = thing2;
//     loadFont();
//     printStringUnsignedHex(0x00, 0x10, "Thing 1", thing1);
//     printStringUnsignedHex(0x00, 0x20, "Thing 2", thing2);
//     //*(uint*)0x82000000 = 1; //Force a crash
// }