#include "../../Library/MainInclude.h"
#include "../BattleKartVariables.h"
//#include "../BattleKartObjects/BattleKartObjects.h"
#include "../BattleKartObjects/ModelData.h"
#include "../BattleKartModel/Presents.h"
#include "../FirstPersonSprites/32BitFPSKart.h"



//Standard libraries
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>

// #include "../USB/usb.c"
// #include "../USB/usb.h"



#define MaxBKObjectives 30
Object BKObjectiveArray[MaxBKObjectives]; //internal array for Objective Items separate from Shells/Itemboxes

#define BK_PRESENT 1


static void MakeBKObjectiveData(Object *obj, Vector pos, SVector angle, Vector velo, short category)
{
	CopyVector(obj->position,pos);
	CopySVector(obj->angle,angle);
	CopyVector(obj->velocity,velo);
 	obj->category=category;
 	obj->flag=EXISTOBJ;		 //EXIST
	obj->counter=0;
	obj->sparam=0;
	obj->fparam=0;
	obj->radius=0;
    InitialBump((Bump*)&obj->bump);
}


static int AddBKObjective(Vector localPosition, SVector localRotation, Vector localVelocity, short localID, float radius)
{
    for(int i = 0; i < MaxBKObjectives; i++)
	{
	    if(BKObjectiveArray[i].flag == 0)
        {
            MakeBKObjectiveData((Object*)&BKObjectiveArray[i],localPosition,localRotation,localVelocity,localID);
            BKObjectiveArray[i].radius = radius;
            return(i);
        }
	}
    return -1;
}

//Check collisions for BK Objectives.  Returns -1 if no collisions found, or the index of the BKObjective object in BKObjectiveArray if a collision is found 
int checkBKObjectiveCollision(Vector localPosition)
{
    for(int i = 0; i < MaxBKObjectives; i++)
    {
        if(BKObjectiveArray[i].flag != 0)
        {
            float distance = pow(BKObjectiveArray[i].position[0] - localPosition[0], 2) + 
                                pow(BKObjectiveArray[i].position[1] - localPosition[1], 2) +
                                pow(BKObjectiveArray[i].position[2] - localPosition[2], 2);
            if (distance <= pow(BKObjectiveArray[i].radius + GlobalPlayer[0].radius, 2))
            {
                return i;
            }
        }
    } 
    return -1;
}


//Check collisions with presents for Battle Santa
void checkPesentCollision()
{
    int i = checkBKObjectiveCollision(GlobalPlayer[0].position); //Check if P1 collides with a present
    if (i != -1) //If player does collide
    {
        playSound(0x49008016); //sound "menu ok"
        BKObjectiveArray[i].flag = 0; //Delete present
        incrementScore(0); //Increment P1's score
    }
}


void displayNumberOfPresents()
{
    loadFont();
    printStringNumber(0xF0, 0x0, "", p1_score[0]);
}

const int keepAwayTimerMax = 150; //Number to set the keep away timer everytime it rests (60 = 1 sec)
const float fractionSpeedWhenHoldingFlag = 0.8; //Fraction of top speed when holding flag
const float fractionSpeedWhenBomb = 1.15; //Fraction of top speed when a bomb in zombombs mode

//float course_height = 0.0; //Store height of course based off initialized player 1's position, used to set base and flag heights when courses are flat


// float test_bot_sphere_x[4] = {0., 0., 0., 0.};
// float test_bot_sphere_y[4] = {0., 0., 0., 0.};
// float test_bot_sphere_z[4] = {0., 0., 0., 0.};

// //Marker structure for Bot AI path finding
// typedef struct Marker{
//     short     Position[3];
//     short    Group;
// } Marker;

void CopyBump(Camera* LocalCamera, Player LocalPlayer)
{
    LocalCamera->bump.flag_xy = LocalPlayer.bump.flag_xy;
    LocalCamera->bump.flag_yz = LocalPlayer.bump.flag_yz;
    LocalCamera->bump.flag_zx = LocalPlayer.bump.flag_zx;

    LocalCamera->bump.last_xy = LocalPlayer.bump.last_xy;
    LocalCamera->bump.last_yz = LocalPlayer.bump.last_yz;
    LocalCamera->bump.last_zx = LocalPlayer.bump.last_zx;

    LocalCamera->bump.distance_xy = LocalPlayer.bump.distance_xy;
    LocalCamera->bump.distance_yz = LocalPlayer.bump.distance_yz;
    LocalCamera->bump.distance_zx = LocalPlayer.bump.distance_zx;

    for (int ThisVector = 0; ThisVector < 3; ThisVector++)
    {
        LocalCamera->bump.bump_xy[ThisVector] = LocalPlayer.bump.bump_xy[ThisVector];
        LocalCamera->bump.bump_yz[ThisVector] = LocalPlayer.bump.bump_yz[ThisVector];
        LocalCamera->bump.bump_zx[ThisVector] = LocalPlayer.bump.bump_zx[ThisVector];
    }
    LocalCamera->bump.dummy = LocalPlayer.bump.dummy;
}


void FirstPersonCamera()
{







    *(long long*)(0x8001A588) = 0x03E0000800000000;
    *(long long*)(0x80019890) = 0x03E0000800000000;
    *(long long*)(0x8001A0DC) = 0x03E0000800000000;
    *(long long*)(0x8001E45C) = 0x03E0000800000000;
    //func_8001E45C
    //*(long long*)(0x8001EE98) = 0x03E0000800000000;
    
    
    
    for (int ThisPlayer = 0; ThisPlayer < player_count; ThisPlayer++)
    {
        if(
            ((GlobalPlayer[ThisPlayer].weapon & HIT_BOMB) == HIT_BOMB) ||
            ((GlobalPlayer[ThisPlayer].weapon & HIT_BOAT) == HIT_BOAT) ||
            ((GlobalPlayer[ThisPlayer].weapon & HIT_REDSHELL) == HIT_REDSHELL) ||
            ((GlobalPlayer[ThisPlayer].weapon & HIT_GREENSHELL) == HIT_GREENSHELL)
        )
        {
            GlobalCamera[ThisPlayer]->lookat_pos[0] += 4;
            GlobalCamera[ThisPlayer]->lookat_pos[1] -= 3;
        }
        else
        {
            float CameraVelocty[3] = {0, 0, 20};
            MakeAlignVector(CameraVelocty, GlobalPlayer[ThisPlayer].direction[1]);
            for (int ThisVector = 0; ThisVector < 3; ThisVector++)
            {
                GlobalCamera[ThisPlayer]->camera_pos[ThisVector] = GlobalPlayer[ThisPlayer].position[ThisVector] ;//+ CameraVelocty[ThisVector] / 2;               
                GlobalCamera[ThisPlayer]->lookat_pos[ThisVector] = GlobalPlayer[ThisPlayer].position[ThisVector] + CameraVelocty[ThisVector];
            }
            GlobalCamera[ThisPlayer]->camera_pos[1] += 4;
            GlobalCamera[ThisPlayer]->lookat_pos[1] += 4;
            GlobalCamera[ThisPlayer]->chase_direction = GlobalPlayer[ThisPlayer].direction[1];

            CheckBump((Bump*)(&GlobalCamera[ThisPlayer]->bump),3, GlobalCamera[ThisPlayer]->camera_pos[0], GlobalCamera[ThisPlayer]->camera_pos[1], GlobalCamera[ThisPlayer]->camera_pos[2]);
        }

        float ux=GlobalCamera[ThisPlayer]->lookat_pos[0]-GlobalCamera[ThisPlayer]->camera_pos[0];
        float uy=GlobalCamera[ThisPlayer]->lookat_pos[1]-GlobalCamera[ThisPlayer]->camera_pos[1];
        float uz=GlobalCamera[ThisPlayer]->lookat_pos[2]-GlobalCamera[ThisPlayer]->camera_pos[2];

        GlobalCamera[ThisPlayer]->camera_direction[1]=Atan2t(ux,uz);
        GlobalCamera[ThisPlayer]->camera_direction[0]=Atan2t(Sqrtf(ux*ux+uz*uz),uy);
        GlobalCamera[ThisPlayer]->camera_direction[2]=0;

        CopyBump(GlobalCamera[ThisPlayer], GlobalPlayer[ThisPlayer]);

    }


    // //Variables for palettes
    // extern int theFirstPersonSprites, PipeBase, PaletteMario, PaletteLuigi, PalettePeach, PaletteToad, PaletteYoshi, PaletteDK, PaletteWario, PaletteBowser;
    // short TireSpin[4] = {0,0,0,0};
    // short TireType[4] = {0,0,0,0};
    // short SteerType[4][2] = {{0,0},{0,0},{0,0},{0,0}};

    // int PaletteAddress[8] = {(int)(&PaletteMario), (int)(&PaletteLuigi), (int)(&PaletteYoshi), (int)(&PaletteToad), 
    // (int)(&PaletteDK), (int)(&PaletteWario), (int)(&PalettePeach), (int)(&PaletteBowser)};


    // for (int ThisPlayer = 0; ThisPlayer < player_count; ThisPlayer++)
    // {
    //   TireSpin[ThisPlayer] += (short)(GlobalPlayer[ThisPlayer].speed);
    //   if (TireSpin[ThisPlayer] >= 12)
    //   {  
    //       TireSpin[ThisPlayer] = 0;
    //       TireType[ThisPlayer]++;
    //       if (TireType[ThisPlayer] == 3)
    //     {
    //         TireType[ThisPlayer] = 0;
    //     }
    //   }
    // }

    // //TEST RENDERING FIRST PERSON GRAPHICS FOR P1

    // //get player steer values.
    // GlobalShortA = GlobalPlayer[0].sterrangle * 25;
    // GlobalShortB = GlobalPlayer[0].sterrangle / -100;

    // //set a "SteeerType" variable based on steer direction left/right
    // SteerType[0][0] = 2;
    // SteerType[0][1] = 2;
    // if (GlobalController[0]->AnalogX < -10)
    // {
    //     SteerType[0][0] = 0;
    //     SteerType[0][1] = 1;
    // }
    // if (GlobalController[0]->AnalogX > 10)
    // {
    //     SteerType[0][0] = 1;
    //     SteerType[0][1] = 0;
    // }


    // //draw the tires, based on how far left/right we're steering. Multiple tire sets. 
    // GlobalIntA = (int)(&theFirstPersonSprites) + tire_left1_Offset + (tire_left1_Size * TireType[0]) + ((tire_left1_Size * 3) * SteerType[0][0]);
    // KWTexture2DRGBA32PT(85 + GlobalShortB,220,0,1.0,(uchar*)(GlobalIntA),(void*)(&V6432B), 64, 64, 64, 16);
    // GlobalIntA = (int)(&theFirstPersonSprites) + tire_left1_Offset + (tire_left1_Size * TireType[0]) + ((tire_left1_Size * 3) * SteerType[0][1]);
    // KWTexture2DRGBA32PT(235 + GlobalShortB,220,0,1.0,(uchar*)(GlobalIntA),(void*)(&V6432BMirror), 64, 64, 64, 16);



    // //draw the pipekart, using the character's palette
    // KWTexture2DCI8XLUBL(96 + GlobalShortB,210,0,1.0,255,(ushort*)(PaletteAddress[GlobalPlayer[0].kart]),(uchar*)(&PipeBase),(void*)(&V128), 128, 128, 128, 16);
    // KWTexture2DCI8XLUBL(224 + GlobalShortB,210,0,1.0,255,(ushort*)(PaletteAddress[GlobalPlayer[0].kart]),(uchar*)(&PipeBase),(void*)(&V128Mirror), 128, 128, 128, 16);


    // //draw the steering wheel, angled by the player steering
    // GlobalIntA = (int)(&theFirstPersonSprites) + steeringwheel_Offset;
    // KWTexture2DRGBA32PT(160 + GlobalShortB,180,GlobalShortA,0.6,(uchar*)(GlobalIntA),(void*)(&V12832B), 128, 128, 128, 8);
        

}


//Returns the nearest player to current player
int find_nearest_player(int current_player)
{
    int nearest_player = 0;
    float furthest_distance = 999999999.0;
    float distanceCheck;
    float x = GlobalPlayer[current_player].position[0];
    float y = GlobalPlayer[current_player].position[1];
    float z = GlobalPlayer[current_player].position[2];
    for (int i=0; i<player_count; i++)
    {

        if (i != current_player)
        {
            distanceCheck = pow(GlobalPlayer[i].position[0]-x, 2) + pow(GlobalPlayer[i].position[1]-y, 2) + pow(GlobalPlayer[i].position[2]-z, 2);
            if (distanceCheck < furthest_distance)
            {
                nearest_player = i;
                furthest_distance = distanceCheck;
            }
        }
    }
    return nearest_player;
}





void DropCoins(int PlayerIndex)
{
    //IFrames[PlayerIndex] = 90;
    //Hey do you want iframes eventually? 

    objectPosition[0] = GlobalPlayer[PlayerIndex].position[0]; 
    objectPosition[1] = GlobalPlayer[PlayerIndex].position[1];
    objectPosition[2] = GlobalPlayer[PlayerIndex].position[2];
    objectAngle[0] = 0;
    objectAngle[1] = 0;
    objectAngle[2] = 0;

    objectVelocity[0] = -3 + (MakeRandomLimmit(6));
    objectVelocity[1] = 4;
    objectVelocity[2] = -4 + (MakeRandomLimmit(8));
    MakeAlignVector(objectVelocity,(GlobalPlayer[PlayerIndex].direction[1]));
    AddBKObjective(objectPosition, objectAngle, objectVelocity, BK_PRESENT, 3.0);
    
}

void DisplayBattleSantaTitle()
{
    PrintBigText(38,14, 1.15f,"BATTLE SANTA 64"); //Display title
    PrintBigText(60,50, 0.5f,"By");
    PrintBigText(50,65, 0.5f,"Triclon and DeadHamster");    


    //Automatically load Double Deck from title screen
    if ( (GlobalController[0]->ButtonPressed & BTN_A) || (GlobalController[0]->ButtonPressed & BTN_START) )
    {
        
        //StartGame
        KBGNumber = 0xFF;

        g_ScreenSplitA = 4;
        g_ScreenSplitB = 3;
        g_cupSelect = 0;
        g_courseSelect = 0;
        g_courseID = 0x11;
        *(char*)(0x8018EDF1) = 0;
        //g_raceClass = Difficulty;
        g_playerCount = 4;
        g_gameMode = 3;
        g_menuMultiplayerSelection = 4;

        
        //courseValue = MapToggle;
        

        g_NewSequenceMode = 4;

        
    }

}

// void setBattleSantaCharacters()
// {
//     GlobalPlayer[0].kart = 0;
//     GlobalPlayer[1].kart = 4; //Set to DK
//     GlobalPlayer[2].kart = 5; //Set to wario
//     GlobalPlayer[3].kart = 7; //Set to bowser
// }

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

// //void BombRolloverWrap(Player* Kart, char Kno)
// void CheckHit(int PlayerIndex, int HitType) //Hook into wrapper
// {

//     // #define     BombThrowRolloverHT     0
//     // #define     RolloverHT                1
//     // #define     WheelSpinHT                2
//     // #define        BrokenHT                3
//     // #define     ThunderHT                4
//     // #define        SpinHT                    5
//     // #define        BombRolloverHT            6
//     // #define        ProWheelSpinHT            7

    
//     // if (game_mode == 7) 
//     // {    
//     //     DropCoins(PlayerIndex);
//     // }
// }


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


int getBaseNumber(int currentPlayer)
{
    if (ffa_or_teams == 0) //If FFA
    {
        return(currentPlayer); //Set base number to be the current player's base
    }
    else //else if teams
    {
        if(currentPlayer < 2) //If team 1
        {
            return(0); //set base number to team 1's base
        }
        else //if team 2
        {
            return(1); //Set base number to team 2's base
        }
    }
}

short angleToBase(int currentPlayer)
{
    int baseNumber = getBaseNumber(currentPlayer);

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
    else if (game_mode == 6) //If game mode is Shell Shooter
    {
        int carID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;


        if (shooter_ammo_p1[carID] > 0.0)
        {
            //Play sound for firing shell, here the "explosion" sound
            playSound(0x19018010);

            //Set shell angle and position
            objectAngle[0] = 0;
            objectAngle[1] = 0;
            objectAngle[2] = carID; //Owner of shell is stored in angle[2]
            objectPosition[0] = GlobalPlayer[carID].position[0]; 
            objectPosition[1] = GlobalPlayer[carID].position[1];
            objectPosition[2] = GlobalPlayer[carID].position[2];
            objectVelocity[0] = 0;
            objectVelocity[1] = 0;
            objectVelocity[2] = 11;
            // //take the Z offset and allign it to the player angle
            MakeAlignVector(objectVelocity,(GlobalPlayer[carID].direction[1]));
            // //add alligned offset to player position.
            objectPosition[0] += objectVelocity[0]; 
            objectPosition[1] += objectVelocity[1];
            objectPosition[2] += objectVelocity[2];

            //
            objectVelocity[0] = 0.0;
            objectVelocity[1] = 0.0;
            objectVelocity[2] = 7.5;
            MakeAlignVector(objectVelocity,(GlobalPlayer[carID].direction[1]));
            objectVelocity[0] += GlobalPlayer[carID].velocity[0];
            objectVelocity[2] += GlobalPlayer[carID].velocity[2];


            //put shell ID and hitbox radius here
            int objID = MasterCreateObject(objectPosition, objectAngle, objectVelocity, 0x07, 4.0); 
            g_SimpleObjectArray[objID].sparam = 2;
            //g_SimpleObjectArray[objID].angle[2] = carID; //Store owner of shell



            //Decrement ammo
            shooter_ammo_p1[carID] -= 1.0;            
        }


    }
    else{
        executeItem(Car);
    }
}




void flash_screen_when_hit(int carID)
{
    if (one_player_full_screen)
    {
        if (carID == 0)
        {
            GraphPtr = DrawRectangle(GraphPtr, 0x000, 0x000, 0x140, 0x140, 0xFF, 0, 0, 0x48); //Large box for text and selection
        }
    }
    else if (player_count == 2)
    {
        if (carID == 0)
        {
            GraphPtr = DrawRectangle(GraphPtr, 0x000, 0x000, 0x140, 0x78, 0xFF, 0, 0, 0x48); //Large box for text and selection
        }
        else //if carID == 1
        {
            GraphPtr = DrawRectangle(GraphPtr, 0x000, 0x78, 0x140, 0x140, 0xFF, 0, 0, 0x48); //Large box for text and selection
        }
    }
    else
    {

        if (carID == 0)
        {
            GraphPtr = DrawRectangle(GraphPtr, 0x000, 0x000, 0xA0, 0x78, 0xFF, 0, 0, 0x48); //Large box for text and selection
        }
        else if (carID == 1)
        {
            GraphPtr = DrawRectangle(GraphPtr, 0xA0, 0x000, 0x140, 0x78, 0xFF, 0, 0, 0x48); //Large box for text and selection
        }
        else if (carID == 2)
        {
            GraphPtr = DrawRectangle(GraphPtr, 0x000, 0x78, 0xA0, 0x140, 0xFF, 0, 0, 0x48); //Large box for text and selection
        }
        else //if carID == 3
        {
            GraphPtr = DrawRectangle(GraphPtr, 0xA0, 0x78, 0x140, 0x140, 0xFF, 0, 0, 0x48); //Large box for text and selection
        }
    }
}


void display_hp_and_ammo_bars(int carID)
{
    if (one_player_full_screen)
    {
        if (carID == 0)
        {
            //STUFF
        }
    }
    else if (player_count == 2)
    {
        if (carID == 0)
        {
            GraphPtr = DrawRectangle(GraphPtr, 0x000, 0x000, 0x140, 0x78, 0xFF, 0, 0, 0x48); //Large box for text and selection
        }
        else //if carID == 1
        {
            GraphPtr = DrawRectangle(GraphPtr, 0x000, 0x78, 0x140, 0x140, 0xFF, 0, 0, 0x48); //Large box for text and selection
        }
    }
    else
    {

        if (carID == 0)
        {
            GraphPtr = DrawRectangle(GraphPtr, 0x000, 0x000, 0xA0, 0x78, 0xFF, 0, 0, 0x48); //Large box for text and selection
        }
        else if (carID == 1)
        {
            GraphPtr = DrawRectangle(GraphPtr, 0xA0, 0x000, 0x140, 0x78, 0xFF, 0, 0, 0x48); //Large box for text and selection
        }
        else if (carID == 2)
        {
            GraphPtr = DrawRectangle(GraphPtr, 0x000, 0x78, 0xA0, 0x140, 0xFF, 0, 0, 0x48); //Large box for text and selection
        }
        else //if carID == 3
        {
            GraphPtr = DrawRectangle(GraphPtr, 0xA0, 0x78, 0x140, 0x140, 0xFF, 0, 0, 0x48); //Large box for text and selection
        }
    }
}

void shell_shooter_hud_stuff()
{
    int scaled_health;
    int scaled_ammo;
    //test heart sprite
    // int x = 10;
    // int y = 10;
    // //int spriteAddress = HeartSpriteROM;
    // KWSprite(x,y,8,8,(unsigned short*)HeartSpriteROM); //Display the sprite
    //test heart sprite
    //GlobalAddressA = (long)(&theMinimapSprites) + FlagSpriteOffsets[0];
    // KWSprite(10,10,128,128,(unsigned short*)BattleFlag); //Display the sprite

    if (one_player_full_screen)
    {
        scaled_health = (int)(46.0 * (shooter_health_p1[0] / shooter_health_max));
        scaled_ammo = (int)(46.0 * (shooter_ammo_p1[0] / shooter_ammo_max));
        GraphPtr = DrawRectangle(GraphPtr, 0x10, 0xC8, 0x16, 0x98, 0x80, 0x80, 0x80, 0x80); //HP
        GraphPtr = DrawRectangle(GraphPtr, 0x11, 0xC7-scaled_health, 0x15, 0xC7, 0xFF, 0x30, 0x30, 0xB0);
        GraphPtr = DrawRectangle(GraphPtr, 0x18, 0xC8, 0x1E, 0x98, 0x80, 0x80, 0x80, 0x80); //Ammo
        GraphPtr = DrawRectangle(GraphPtr, 0x19, 0xC7-scaled_ammo, 0x1D, 0xC7, 0x80, 0xFF, 0x80, 0xB0);
    }
    else if (player_count == 2)
    {
        //P1
        scaled_health = (int)(46.0 * (shooter_health_p1[0] / shooter_health_max));
        scaled_ammo = (int)(46.0 * (shooter_ammo_p1[0] / shooter_ammo_max));
        GraphPtr = DrawRectangle(GraphPtr, 0x10, 0x50, 0x16, 0x20, 0x80, 0x80, 0x80, 0x80); //HP
        GraphPtr = DrawRectangle(GraphPtr, 0x11, 0x4F-scaled_health, 0x15, 0x4F, 0xFF, 0x30, 0x30, 0xB0);
        GraphPtr = DrawRectangle(GraphPtr, 0x18, 0x50, 0x1E, 0x20, 0x80, 0x80, 0x80, 0x80); //Ammo
        GraphPtr = DrawRectangle(GraphPtr, 0x19, 0x4F-scaled_ammo, 0x1D, 0x4F, 0x80, 0xFF, 0x80, 0xB0);
        //P2
        scaled_health = (int)(46.0 * (shooter_health_p1[1] / shooter_health_max));
        scaled_ammo = (int)(46.0 * (shooter_ammo_p1[1] / shooter_ammo_max));
        GraphPtr = DrawRectangle(GraphPtr, 0x10, 0xC8, 0x16, 0x98, 0x80, 0x80, 0x80, 0x80); //HP
        GraphPtr = DrawRectangle(GraphPtr, 0x11, 0xC7-scaled_health, 0x15, 0xC7, 0xFF, 0x30, 0x30, 0xB0);
        GraphPtr = DrawRectangle(GraphPtr, 0x18, 0xC8, 0x1E, 0x98, 0x80, 0x80, 0x80, 0x80); //Ammo
        GraphPtr = DrawRectangle(GraphPtr, 0x19, 0xC7-scaled_ammo, 0x1D, 0xC7, 0x80, 0xFF, 0x80, 0xB0);        
    }
    else{
        //P1
        scaled_health = (int)(46.0 * (shooter_health_p1[0] / shooter_health_max));
        scaled_ammo = (int)(46.0 * (shooter_ammo_p1[0] / shooter_ammo_max));
        GraphPtr = DrawRectangle(GraphPtr, 0x10, 0x50, 0x16, 0x20, 0x80, 0x80, 0x80, 0x80); //HP
        GraphPtr = DrawRectangle(GraphPtr, 0x11, 0x4F-scaled_health, 0x15, 0x4F, 0xFF, 0x30, 0x30, 0xB0);
        GraphPtr = DrawRectangle(GraphPtr, 0x18, 0x50, 0x1E, 0x20, 0x80, 0x80, 0x80, 0x80); //Ammo
        GraphPtr = DrawRectangle(GraphPtr, 0x19, 0x4F-scaled_ammo, 0x1D, 0x4F, 0x80, 0xFF, 0x80, 0xB0);
        //P2
        scaled_health = (int)(46.0 * (shooter_health_p1[1] / shooter_health_max));
        scaled_ammo = (int)(46.0 * (shooter_ammo_p1[1] / shooter_ammo_max));
        GraphPtr = DrawRectangle(GraphPtr, 0xB0, 0x50, 0xB6, 0x20, 0x80, 0x80, 0x80, 0x80); //HP
        GraphPtr = DrawRectangle(GraphPtr, 0xB1, 0x4F-scaled_health, 0xB5, 0x4F, 0xFF, 0x30, 0x30, 0xB0);
        GraphPtr = DrawRectangle(GraphPtr, 0xB8, 0x50, 0xBE, 0x20, 0x80, 0x80, 0x80, 0x80); //Ammo
        GraphPtr = DrawRectangle(GraphPtr, 0xB9, 0x4F-scaled_ammo, 0xBD, 0x4F, 0x80, 0xFF, 0x80, 0xB0);
        //P3
        scaled_health = (int)(46.0 * (shooter_health_p1[2] / shooter_health_max));
        scaled_ammo = (int)(46.0 * (shooter_ammo_p1[2] / shooter_ammo_max));
        GraphPtr = DrawRectangle(GraphPtr, 0x10, 0xC8, 0x16, 0x98, 0x80, 0x80, 0x80, 0x80); //HP
        GraphPtr = DrawRectangle(GraphPtr, 0x11, 0xC7-scaled_health, 0x15, 0xC7, 0xFF, 0x30, 0x30, 0xB0);
        GraphPtr = DrawRectangle(GraphPtr, 0x18, 0xC8, 0x1E, 0x98, 0x80, 0x80, 0x80, 0x80); //Ammo
        GraphPtr = DrawRectangle(GraphPtr, 0x19, 0xC7-scaled_ammo, 0x1D, 0xC7, 0x80, 0xFF, 0x80, 0xB0);
        //P4
        if (player_count == 4)
        {
            scaled_health = (int)(46.0 * (shooter_health_p1[3] / shooter_health_max));
            scaled_ammo = (int)(46.0 * (shooter_ammo_p1[3] / shooter_ammo_max));
            GraphPtr = DrawRectangle(GraphPtr, 0xB0, 0xC8, 0xB6, 0x98, 0x80, 0x80, 0x80, 0x80); //HP
            GraphPtr = DrawRectangle(GraphPtr, 0xB1, 0xC7-scaled_health, 0xB5, 0xC7, 0xFF, 0x30, 0x30, 0xB0);
            GraphPtr = DrawRectangle(GraphPtr, 0xB8, 0xC8, 0xBE, 0x98, 0x80, 0x80, 0x80, 0x80); //Ammo
            GraphPtr = DrawRectangle(GraphPtr, 0xB9, 0xC7-scaled_ammo, 0xBD, 0xC7, 0x80, 0xFF, 0x80, 0xB0);            
        }


        // loadFont(); //Debug text
        // printStringNumber(0x80, 0x20, "Who hit P1 last", who_hit_p1_last[0]);
        // printStringNumber(0x80, 0x2C, "Who hit P2 last", who_hit_p1_last[1]);
        // printStringNumber(0x80, 0x34, "Who hit P3 last", who_hit_p1_last[2]);
        // printStringNumber(0x80, 0x40, "Who hit P4 last", who_hit_p1_last[3]);
        // printStringNumber(0x20, 0x20, "Health", shooter_health_p1[0]);
        // printStringNumber(0x20, 0x2C, "ammo p1", shooter_ammo_p1[0]);
        // printStringNumber(0x20, 0x34, "ammo p2", shooter_ammo_p1[1]);
        // printStringNumber(0x20, 0x40, "ammo p3", shooter_ammo_p1[2]);
        // printStringNumber(0x20, 0x4C, "ammo p4", shooter_ammo_p1[3]);

        // printFloat(0x20, 0x84, shooter_health_max);
        // printFloat(0x20, 0x90, shooter_ammo_max);
    }

    for (int i=0; i < player_count; i++) //Loop through each player
    {
        if (check_if_hit(i)) //Flash screen red if hit
        {
            flash_screen_when_hit(i);
        }

        if (GlobalPlayer[i].slip_flag & ROLLOVER) //Stop tumble if player is tumbling
        {
            //GlobalPlayer[i].slip_flag &= ~N_JUMP;
            if (shooter_health_p1[i] > 1.0)  //Stop tumble if player is tumbling and their HP is > 1, otherwise let them tumble like normal
            { 
                GlobalPlayer[i].slip_flag &= ~ROLLOVER; 
                who_was_hit_last = i + 1; //Since this preempts the usual hit detection, set who was hit last so that the hit is properly recorded and processed
            }

        }

        // //Make HUD item boxes go live off the screen somewhere so we don't see them
        // GlobalHud[i]->itemX = 500;
        // GlobalHud[i]->itemY = 500;
        // GlobalHud[i]->itemX2 = 500;
        // GlobalHud[i]->itemY2 = 500;
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

    keepAwayBotRunAwayTimer = 0;
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



void DisplayBKObjectives()
{
    //This function will loop through all BKObjectives and if an object exists it will be drawn
    //This function needs to be called from DrawPerScreen so that the perspective has been set.
    
    for (int ThisObjective = 0; ThisObjective < MaxBKObjectives; ThisObjective++)
    {
        if (BKObjectiveArray[ThisObjective].flag != 0)
        {
            switch(BKObjectiveArray[ThisObjective].category)
            {
                
                case BK_PRESENT:
                {
                    GlobalAddressB = (long)PresentBlue;
                    UpdateObjectGravity((Object*)&BKObjectiveArray[ThisObjective]);
                    UpdateObjectVelocity((Object*)&BKObjectiveArray[ThisObjective]);
                    
                    UpdateObjectFrictionScale((Object*)&BKObjectiveArray[ThisObjective],0.5);
                    UpdateObjectBump((Object*)&BKObjectiveArray[ThisObjective]);
                    
                    if(BKObjectiveArray[ThisObjective].bump.distance_zx < 0)
                    {
                        BKObjectiveArray[ThisObjective].velocity[1] = 0;
                    }
                    
                    objectPosition[0] = BKObjectiveArray[ThisObjective].position[0];
                    objectPosition[1] = BKObjectiveArray[ThisObjective].position[1];
                    objectPosition[2] = BKObjectiveArray[ThisObjective].position[2];

                    
                    BKObjectiveArray[ThisObjective].angle[1] += DEG1 * 3;
                    objectAngle[0] = BKObjectiveArray[ThisObjective].angle[0];
                    objectAngle[1] = BKObjectiveArray[ThisObjective].angle[1];
                    objectAngle[2] = BKObjectiveArray[ThisObjective].angle[2];


                    DrawGeometryScale(objectPosition,objectAngle,GlobalAddressB, 0.025f);
                    break;
                }
            }
        }
    }


}

//void DrawLightBulb()
void DrawPerScreen(Camera* LocalCamera)
{  
    //This function will draw the array of BKObjective Objects. 
    DisplayBKObjectives();


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
                currentFlagPositionsHeight[flagNumber] = objectPosition[1];
                currentFlagPositionsY[flagNumber] = objectPosition[2];


                float player_x, player_y, player_z, distance;

                int current_camera = (*(long*)&LocalCamera - (long)&g_CameraTable) / 0xB8;

                if ((playerHoldingFlag[flagNumber] != current_camera))
                {

                    
                    int angle = (LocalCamera->camera_direction[1]-(DEG1 * 180));
                    float sinB = sinT(angle);
                    float cosB = cosT(angle);

                    inGameAffineMatrix[0][0] =  cosB;
                    inGameAffineMatrix[1][0] =  0.0f;
                    inGameAffineMatrix[2][0] =  sinB;
                    inGameAffineMatrix[0][1] =  0.0f;
                    inGameAffineMatrix[1][1] =  1.0f;
                    inGameAffineMatrix[2][1] =  0.0f;
                    inGameAffineMatrix[0][2] = -sinB;
                    inGameAffineMatrix[1][2] =  0.0f;
                    inGameAffineMatrix[2][2] =  cosB;
                    inGameAffineMatrix[0][3] =  0.0f;
                    inGameAffineMatrix[1][3] =  0.0f;
                    inGameAffineMatrix[2][3] =  0.0f;
                    inGameAffineMatrix[3][3] =  1.0f; 

                    player_x = GlobalPlayer[playerHoldingFlag[flagNumber]].position[0];
                    player_y = GlobalPlayer[playerHoldingFlag[flagNumber]].position[1];
                    player_z = GlobalPlayer[playerHoldingFlag[flagNumber]].position[2];

                    distance = Sqrtf( pow(player_x - LocalCamera->camera_pos[0], 2)
                               + pow(player_y - LocalCamera->camera_pos[1], 2)
                               + pow(player_z - LocalCamera->camera_pos[2], 2)      );

                    inGameAffineMatrix[3][0] = player_x;// + offsetPosition[0];
                    inGameAffineMatrix[3][1] = player_y + distance*5e-2;// + offsetPosition[1];
                    inGameAffineMatrix[3][2] = player_z;// + offsetPosition[2];                
                    
                    ScalingMatrix(inGameAffineMatrix, distance*1.7e-3);    
                    if(SetMatrix(inGameAffineMatrix,0) == 0)
                    {
                        return;
                    }
                    gSPDisplayList(GraphPtrOffset++, TargetMarker);
                }

            }
        }
    }
    else if (game_mode == 2) //Display a flag on shrunk players in squish game mode
    {
        float player_x, player_y, player_z, distance;

        int current_camera = (*(long*)&LocalCamera - (long)&g_CameraTable) / 0xB8;

        for (int i=0; i<player_count; i++)
        {
            if ((i != current_camera) && (GlobalPlayer[i].slip_flag & THUNDER))
            {

                //GlobalAddressA = (long)&g_PlayerStructTable + (i * 0xDD8);
                
                int angle = (LocalCamera->camera_direction[1]-(DEG1 * 180));
                float sinB = sinT(angle);
                float cosB = cosT(angle);

                inGameAffineMatrix[0][0] =  cosB;
                inGameAffineMatrix[1][0] =  0.0f;
                inGameAffineMatrix[2][0] =  sinB;
                inGameAffineMatrix[0][1] =  0.0f;
                inGameAffineMatrix[1][1] =  1.0f;
                inGameAffineMatrix[2][1] =  0.0f;
                inGameAffineMatrix[0][2] = -sinB;
                inGameAffineMatrix[1][2] =  0.0f;
                inGameAffineMatrix[2][2] =  cosB;
                inGameAffineMatrix[0][3] =  0.0f;
                inGameAffineMatrix[1][3] =  0.0f;
                inGameAffineMatrix[2][3] =  0.0f;
                inGameAffineMatrix[3][3] =  1.0f; 

                player_x = GlobalPlayer[i].position[0];
                player_y = GlobalPlayer[i].position[1];
                player_z = GlobalPlayer[i].position[2];

                distance = Sqrtf( pow(player_x - LocalCamera->camera_pos[0], 2)
                           + pow(player_y - LocalCamera->camera_pos[1], 2)
                           + pow(player_z - LocalCamera->camera_pos[2], 2)      );

                inGameAffineMatrix[3][0] = player_x;// + offsetPosition[0];
                inGameAffineMatrix[3][1] = player_y + distance*5e-2;// + offsetPosition[1];
                inGameAffineMatrix[3][2] = player_z;// + offsetPosition[2];                
                
                ScalingMatrix(inGameAffineMatrix, distance*1.7e-3);    
                if(SetMatrix(inGameAffineMatrix,0) == 0)
                {
                    return;
                }
                gSPDisplayList(GraphPtrOffset++, TargetMarker);
            }
        }

    }

}

void DisplayFlagOnSquishedPlayers()
{

    short baseTurn;
    short addTurn;
    for (int i=0; i<player_count; i++)
    {
        // if (GlobalPlayer[i].slip_flag & THUNDER) //If player is squished
        // {
            // DrawGeometryScale(GlobalPlayer[i].position, GlobalPlayer[i].direction, BattleFlag, 0.1); //Drag flag on them
        // }


                GlobalAddressA = (long)&g_PlayerStructTable + (i * 0xDD8);


                baseTurn = *(short*)(GlobalAddressA + 46);
                addTurn = *(short*)(GlobalAddressA + 192);

                objectPosition[0] = *(float*)(GlobalAddressA + 20);
                objectPosition[1] = *(float*)(GlobalAddressA + 24)-3.0;
                objectPosition[2] = *(float*)(GlobalAddressA + 28);

                
                
                objectAngle[0] = 0;
                objectAngle[1] = -(baseTurn + addTurn)+0x3000;
                objectAngle[2] = 0;

                DrawGeometryScale(objectPosition, objectAngle, BattleFlag, 0.06);

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


void BaseCollide(void *Car, void *Base)
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

}


void FlagCollide(void *Car, void *Flag)
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
                    SetVSGhost((Player*)&GlobalPlayer[carID], (char)carID);

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
            MapSelectMenuDefault();
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
	*sourceAddress = (int)&g_MUSSequenceTable.pointer[3].address;
	*targetAddress = (int)&ok_Sequence;
	runRAM();

	*sourceAddress = (int)&g_MUSInstrumentTable.pointer[3];
	*targetAddress = (int)&ok_Instrument;
	runRAM();

    *sourceAddress = (int)&g_BombTable;
    *targetAddress = (long)&ok_Bomb;    
    dataLength = 0xA8;
    runRAM();

    
	*(long*)(&ok_USAudio) = g_MUSRawAudioTable.pointer[0].address;
	*(long*)(&ok_USAudio + 1) = g_MUSInstrumentTable.pointer[0].address;


	*(long*)(&ok_MRSong) = g_MUSSequenceTable.pointer[3].address;
	*(long*)(&ok_MRSong + 1) = g_MUSSequenceTable.pointer[3].length;
    
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

void DisplayObject(void *Camera, Object *Object)
{

    switch (Object->category)
    {
        
		case 48:
		{
			GlobalAddressB = (long)PresentBlue;
			UpdateObjectGravity(Object);
			UpdateObjectVelocity(Object);
			
			UpdateObjectFrictionScale(Object,0.5);
			UpdateObjectBump(Object);
			
			if(Object->bump.distance_zx < 0)
			{
				Object->velocity[1] = 0;
			}
			
			objectPosition[0] = Object->position[0];
			objectPosition[1] = Object->position[1];
			objectPosition[2] = Object->position[2];

			
			Object->angle[1] += DEG1 * 3;
			objectAngle[0] = Object->angle[0];
			objectAngle[1] = Object->angle[1];
			objectAngle[2] = Object->angle[2];


			DrawGeometryScale(objectPosition,objectAngle,GlobalAddressB, 0.05f);
		}
			break;
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


void CollideObject(Player* car, Object* Object)
{
    objectIndex = (short)((*(long*)(*(long*)(&Object)) >> 16) & 0x0000FFFF);
    switch (objectIndex)
    {
        case 12:
        {
            return ItemboxCollideCheck(car, Object);
            break;
        }
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
            return;
            break;
        }
    }
    return;
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