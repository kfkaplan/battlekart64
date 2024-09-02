#include "../../Library/MainInclude.h"
#include "../BattleKartVariables.h"
#include "../BattleKartObjects/BattleKartObjects.h"
#include "../BattleKartModel/Presents.h"
//Standard libraries
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>
//Paths
#include "../BattleKartPaths/BlockFortPaths.h"
#include "../BattleKartPaths/DoubleDeckerPaths.h"
#include "../BattleKartPaths/SkyscraperPaths.h"
#include "../BattleKartPaths/BigDonutPaths.h"
#include "../BattleKartPaths/RaceCoursePaths.h"




// #define TURNASSIST //Toggle turn assist for bots to help debug pathfinding


extern int getRival();

const float max_bot_distance_path_marker = 400.0; //Distance a bot must get within a path marker to advance to the next marker (in squared pathagorean theorm space)
float bot_distance_from_path_marker[4] = {0., 0., 0., 0.};
bool bot_initialization_flag[] = {0, 0, 0, 0};
ushort bot_buttons[4] = {0, 0, 0, 0};
ushort bot_pressed[4] = {0, 0, 0, 0};
char bot_x_stick[4] = {0, 0, 0, 0};
float bot_topspeed[4] = {0,0,0,0};
float nearest_item_box[4][3] = {{0.0, 0.0, 0.0,}, {0.0, 0.0, 0.0,}, {0.0, 0.0, 0.0,}, {0.0, 0.0, 0.0,}};
float furthest_node[4][3] = {{0.0, 0.0, 0.0,}, {0.0, 0.0, 0.0,}, {0.0, 0.0, 0.0,}, {0.0, 0.0, 0.0,}};
char TripleTap = 0;
Bump bot_bump[4];


//Arrays of path arrays
Marker **CoursePaths[] = {BlockFortPaths_Paths, DoubleDeckerPaths_Paths, Skyscraper_Paths, BigDonut_Paths, 
                        RacePaths_Paths};
Marker **CourseRamps[] = {BlockFortPaths_Ramps, DoubleDeckerPaths_Ramps, Skyscraper_Ramps, BigDonut_Ramps,
                         RacePaths_Ramps};
Marker **CourseDrops[] = {BlockFortPaths_Drops, DoubleDeckerPaths_Drops, Skyscraper_Drops, BigDonut_Drops,
                         RacePaths_Drops};
short *CoursePathLengths[] = {BlockFortPaths_PathLengths, DoubleDeckerPaths_PathLengths, Skyscraper_PathLengths, BigDonut_PathLengths,
                         RacePaths_PathLengths};
short *CourseRampLengths[] = {BlockFortPaths_RampLengths, DoubleDeckerPaths_RampLengths, Skyscraper_RampLengths, BigDonut_RampLengths,
                         RacePaths_RampLengths};
short *CourseDropLengths[] = {BlockFortPaths_DropLengths, DoubleDeckerPaths_DropLengths, Skyscraper_DropLengths, BigDonut_DropLengths,
                         RacePaths_DropLengths};
short *LineCounts[] = {BlockFortPaths_LineCounts, DoubleDeckerPaths_LineCounts, Skyscraper_LineCounts, BigDonut_LineCounts,
                         RacePaths_LineCounts};
//short dummyPathLengths[2] = {0x258, 0x258};
const float BattleLevelHeightChecks[] = {15.0, 9.0, 75.0, 75.0, 
                                    150.0};
const float BattleLevelHeightChecksSquared[] = {15.0*15.0, 9.0*9.0, 75.0*75.0, 75.0*75.0,
                                                    150.0*150.0};
const short BattleLevelPathSearchRadius[] = {250, 350, 150, 400,
                                                     400};
const float turn_towards_rival_radius[] = {90.0, 100, 70, 150, 
                                                    200}; //Distance bot must get to rival to just start turning twoards them wholesale
//Used to index above array of arrays based on course, indexed by g_courseID
const char BattleLevelConverts[20] =     {4, 4, 4, 4, 4, 4, 4, 4, 4, 4 , 4, 4, 4, 4, 4, 0, 2, 1, 4, 3};
short RaceCoursePathLength;

//(Marker **)GetRealAddress(PathTable[g_courseID])}
//*(short *)(&g_pathLength)[g_courseID][0]}



float test_bot_sphere_position[4][3] = 
{
    {0., 0., 0.},
    {0., 0., 0.},
    {0., 0., 0.},
    {0., 0., 0.},
};

void ResetPathfinderBots() //Runs at beginning of game
{
    for (int i=0; i<player_count; i++)
    {
        bot_rival_p1[i] = getRival(i);
        AIPathfinder[i].TargetPath = -1;
        bot_initialization_flag[i] = true;
        for (int j=0; j<3; j++)
        {
            nearest_item_box[i][j] = 0.0;
        }
        if (bot_status_p1[i] > 0) //If player is a bot
        {
            GlobalPlayer[i].acc_maxcount *= 1.1; //Speed up bot to make them faster
            bot_topspeed[i] = GlobalPlayer[i].acc_maxcount;
        }

        randomBotTimers[i] = 0;
        randomBotTargetNodes[i] = 0;
        botFiringTimers[4] = 0;


    } 



    //Set bot paths if in race courses, copy race course mega path to chunked up paths defined by us
    if (BattleLevelConverts[g_courseID] == 4)
    {
        //Marker *RaceCoursePath = (Marker *)GetRealAddress(PathTable[g_courseID+1][0]);




        //Marker *PathArray = (Marker *)GetRealAddress(PathTable[g_courseID][ThisPath]);

        //short RaceCoursePathLength = *(short *)GetRealAddress(PathLengthTable[g_courseID][0]);
        //short RaceCoursePathLength = PathLengthTable[g_courseID][0];
        RaceCoursePathLength = PathLengthTable[g_courseID][0];
        //short RaceCoursePathLength  = 600;
        for (int i=0; i*20<RaceCoursePathLength; i++)
        {

            for(int j=0; j<20; j++)
            {
                int index = i*20 + j;
                short* PositionArray = (short*)(GetRealAddress(PathTable[g_courseID][0]) + index*0x8) ;
                if (PositionArray[0] == 0x8000)
                {
                  //we've reached the end of the list, stop now
                  CoursePathLengths[4][i] = j+1;
                  LineCounts[4][0] = i+1;
                  break;
                }
                if(index < RaceCoursePathLength)
                {
                    CoursePaths[4][i][j].Position[0] = PositionArray[0];
                    CoursePaths[4][i][j].Position[1] = PositionArray[1];
                    CoursePaths[4][i][j].Position[2] = PositionArray[2];                    
                    // CoursePaths[4][i][j].Position[0] = RaceCoursePath[index].Position[0];
                    // CoursePaths[4][i][j].Position[1] = RaceCoursePath[index].Position[1];
                    // CoursePaths[4][i][j].Position[2] = RaceCoursePath[index].Position[2];
                }
            }
        }
        //CoursePathLengths[4] = dummyPathLengths;

        //short *PathLengths = (short *)(&g_pathLength);
       // CoursePathLengths[4] = (short *)PathLengths[g_courseID];
    }

}


void botControl(void *Car, Controller *cont,char kno)
{
    // if(GlobalController[0]->ButtonPressed & BTN_DLEFT) //Debug spawn
    // {
    //     GlobalPlayer[0].position[0] = 450;
    //     GlobalPlayer[0].position[1] = 98;
    //     GlobalPlayer[0].position[2] = 450;
    // }

    int carID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;

    if (bot_status_p1[carID] > 0)
    {
        TripleTap++;
        if ((TripleTap % 3) == 1)
        {
            bot_pressed[carID] |= BTN_A;
        }
        cont->ButtonPressed = bot_pressed[carID];
        cont->ButtonHeld = bot_buttons[carID]; //bot_controller_input_p1[carID]; //Test moving player 2 foward
        cont->AnalogX = bot_x_stick[carID]; //Turn some direction
    }
    
}


void ProSteeringPlus(int i, int ci, Marker* PathArray[], Marker* RampArray[], Marker* DropArray[])
{


    short TargetPath = AIPathfinder[i].TargetPath;
    short Progression = AIPathfinder[i].Progression; //(int)AIPathfinder[i].Progression;
    //short PathGroup = 0;
    switch (AIPathfinder[i].PathType) //Get position of current marker to drive towards
    {
        case FLATPATH: //flat paths
            objectPosition[0] = (float)PathArray[TargetPath][Progression].Position[0];
            objectPosition[1] = (float)PathArray[TargetPath][Progression].Position[1];
            objectPosition[2] = (float)PathArray[TargetPath][Progression].Position[2]; 
            //PathGroup = PathArray[TargetPath][Progression].Group;
            break;
        case RAMPPATH: //ramps
            objectPosition[0] = (float)RampArray[TargetPath][Progression].Position[0];
            objectPosition[1] = (float)RampArray[TargetPath][Progression].Position[1];
            objectPosition[2] = (float)RampArray[TargetPath][Progression].Position[2]; 
            //PathGroup = RampArray[TargetPath][Progression].Group;
            break;
        case DROPPATH: //drops 
            objectPosition[0] = (float)DropArray[TargetPath][Progression].Position[0];
            objectPosition[1] = (float)DropArray[TargetPath][Progression].Position[1];
            objectPosition[2] = (float)DropArray[TargetPath][Progression].Position[2]; 
            //PathGroup = DropArray[TargetPath][Progression].Group;
            break;
    }


    GlobalShortA = (short)(MakeDirection(GlobalPlayer[i].position[0],GlobalPlayer[i].position[2], objectPosition[0], objectPosition[2]) * -1);
    GlobalShortA -= GlobalPlayer[i].direction[1];
    GlobalUInt64 = GlobalShortA * GlobalShortA;

    bot_buttons[i] = BTN_A;
    bot_pressed[i] = 0;

    //Set top speed
    // if (PathGroup != 0)
    // {
    //      GlobalPlayer[i].acc_maxcount = bot_topspeed[i] * (1.0 - (abs(PathGroup)/255.0));
    // }
    // else
    // {
        GlobalPlayer[i].acc_maxcount = bot_topspeed[i]; //Default top speed
    // }
   
    
    //if ((GlobalUInt64 > STOPTURN) || AIPathfinder[i].SlowDown)
    if ((GlobalUInt64 > STOPTURN)) //| (PathGroup < 0) | (AIPathfinder[i].SlowDown))
    {   
        //if (GlobalPlayer[i].speed > 7) //Slow down on sky scraper to minimize falling
        //{
           // bot_buttons[i] = BTN_B;  //continue braking
        //}
        //else
        //{
        GlobalPlayer[i].acc_maxcount = 0.5 * bot_topspeed[i]; //Slow the bot way down hwen encountering a rival or item box 

        bot_buttons[i] |= BTN_B;  //continue braking
        //}
        // bot_pressed[i] = BTN_R | BTN_B;   //tap brake and jump
        // bot_buttons[i] |= BTN_B;
        if (GlobalShortA > 0)
        {   
            if (abs(bot_x_stick > 0))
            {
                bot_buttons[i] |= BTN_R;  //continue drifting, otherwise stop.    
            }

            bot_x_stick[i] = 127;  
        }
        else
        {
            if (bot_x_stick < 0)
            {
                bot_buttons[i] |= BTN_R;  //continue drifting, otherwise stop.    
            }

            bot_x_stick[i] = -127;  
        }
    }                        
    else if ((GlobalUInt64 > DRIFTTURN) )
    {
        GlobalPlayer[i].acc_maxcount = 0.8 * bot_topspeed[i]; //Slow the bot way down hwen encountering a rival or item box 
        bot_pressed[i] = BTN_R | BTN_B;   //tap brake and jump
        // if (GlobalPlayer[i].speed > 20) //Slow down on sky scraper to minimize falling
        // {
        //     bot_buttons[i] = BTN_B;  //continue braking
        // }
        // else
        // {
        bot_buttons[i] |= BTN_B;
        // }

        if (GlobalShortA > 0)
        {   
            bot_x_stick[i] = 75;
        }
        else
        {
            bot_x_stick[i] = -75;
        }
    }
    else if (GlobalUInt64 > WIDETURN)
    {
        // if (ci == 2) //Slow down on sky scraper to minimize falling
        // {
            bot_buttons[i] |= BTN_B; //Slow down bot for testing path finding
        // }
        if (GlobalShortA > 0)
        {   
            bot_x_stick[i] = 70;
        }
        else
        {
            bot_x_stick[i] = -70;
        }
    }
    else if (GlobalUInt64 > MIDTURN)
    {
        //if (ci == 2) //Slow down on sky scraper to minimize falling
        //{
            // bot_buttons[i] |= BTN_B; //Slow down bot for testing path finding
        //}
        if (GlobalShortA > 0)
        {   
            bot_x_stick[i] = 55;
        }
        else
        {
            bot_x_stick[i] = -55;
        }
    }
    else if (GlobalUInt64 > SHORTTURN)
    {

        // if (ci == 2) //Slow down on sky scraper to minimize falling
        // {
        //     bot_buttons[i] |= BTN_B; //Slow down bot for testing path finding
        // }

        if (GlobalShortA > 0)
        {   
            bot_x_stick[i] = 45;
        }
        else
        {
            bot_x_stick[i] = -45;
        }

    }
    else if (GlobalUInt64 > NOTURN)
    {

        //bot_buttons[i] |= BTN_B; //Slow down bot for testing path finding
        if (GlobalShortA > 0)
        {   
            bot_x_stick[i] = 29;
        }
        else
        {
            bot_x_stick[i] = -29;
        }
    }
    else
    {

        bot_x_stick[i] = 0x00;

    }

    #ifdef TURNASSIST 
    if (GlobalShortA > 0)
    {
        GlobalPlayer[i].direction[1] += 400 * getTempo();
    }
    else
    {
        GlobalPlayer[i].direction[1] -= 400 * getTempo();
    }
    #endif



    // if (pow(GlobalPlayer[i].position[0] - objectPosition[0], 2) + pow(GlobalPlayer[i].position[2] - objectPosition[1], 2)  < 25)
    // {
    //     bot_buttons[i] = 0;
    //     bot_pressed[i] = 0;        
    // }
    

}


//








void StandardBattleBot(int i)
{
    //Set bot controller
    //AIPathfinder[i].TargetPath = -1;
    // switch(bot_steering_p1[i])
    // {
    //     case 0: //follow rival
            switch( ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], AIPathfinder[i].Target, 0x7) ) //Returns -1 or 1, to give direction to turn
            {
                case 0:              
                    if (TestCollideSphere(GlobalPlayer[bot_rival_p1[i]].position, 40, GlobalPlayer[i].position, 40) && !TestCollideSphere(GlobalPlayer[bot_rival_p1[i]].position, 20, GlobalPlayer[i].position, 20))//&& ObjectSubBehaviorTurnTarget(GlobalPlayer[i].position, GlobalPlayer[i].direction[1], AIPathfinder[i].Target, 0x4)==0)  //If near rival, use weapon (note this is meant to only be when near a rival NOT necessarily another type of target)
                    {

                        bot_pressed[i] = BTN_Z;
                        //bot_pressed[i] = 0;
                        bot_buttons[i] = BTN_A + BTN_Z;
                        // if (GlobalPlayer[i].item != 0)
                        // {
                        //     bot_timer_p1[i] = MakeRandomLimmit(160) +  400; //Once bot has used weapon, give them a few more seconds to chase their rival before finding a new rival
                        //     // nearest_item_box[i][0] = 0.0; //Reset nearest item box
                        //     // nearest_item_box[i][1] = 0.0;
                        //     // nearest_item_box[i][2] = 0.0;
                        // }
                    }  
                    else{  //Else just drive straight
                        bot_pressed[i] = 0;
                        bot_buttons[i] = BTN_A;
                    }
                    bot_x_stick[i] = 0x00;
                    break;
                case 1:
                    bot_buttons[i] = BTN_A + BTN_B +BTN_R;
                    bot_x_stick[i] = 0x50;

                    #ifdef TURNASSIST //Toggle turn assist for bots to help debug pathfinding
                    GlobalPlayer[i].direction[1] += 400 * getTempo();
                    #endif

                    break;
                case -1:
                    bot_buttons[i] = BTN_A + BTN_B + BTN_R;
                    bot_x_stick[i] = -0x50;

                    #ifdef TURNASSIST //Toggle turn assist for bots to help debug pathfinding
                    GlobalPlayer[i].direction[1] -= 400 * getTempo();
                    #endif

                    break;
            }
            // break;
    //     case 1: //turn right
    //         bot_buttons[i] = BTN_A + BTN_B;
    //         bot_x_stick[i] = 0x50;
    //         break;
    //     case 2: //turn left
    //         bot_buttons[i] = BTN_A + BTN_B;
    //         bot_x_stick[i] = -0x50;
    //         break;
    // }


}















//
//





void SeekerBattleBot(int i)
{
    float rival_x, rival_y, rival_z;
    //float turn_towards_rival_radius = 60.0; //Distance bot must get to rival to just start turning twoards them wholesale
    short ci = BattleLevelConverts[g_courseID]; //Grab index for current course, used to index path arrays


    float bot_x = GlobalPlayer[i].position[0]; //x,y,z coordinates of current bot
    float bot_y = GlobalPlayer[i].position[1];
    float bot_z = GlobalPlayer[i].position[2];


    if  (*(unsigned char*)(0x800F6990 + (0xDD8 * bot_rival_p1[i])) != 0xC0 ||  *(unsigned char*)(0x800F6991 + (0xDD8 * bot_rival_p1[i])) == 0x50) //If rival is dead or a bomb, get a new rival
    {
        bot_rival_p1[i] = getRival(i);
    }

    // bool hitting_wall = GlobalPlayer[i].wallhitcount != 0; //Store if bot is hitting wall, move towards nearest node
    // if (hitting_wall)
    // {

    //     int TargetPath = AIPathfinder[i].TargetPath;
    //     if (TargetPath != -1) //Crash catch
    //     {
    //         int NearestMarker = AIPathfinder[i].NearestMarker;
    //         float NearestMarkerX=0.0;
    //         float NearestMarkerY=0.0;
    //         float NearestMarkerZ=0.0;

    //         switch (AIPathfinder[i].PathType)
    //         {
    //             case FLATPATH:  //If bot is following a flat path
    //             {   
    //                 NearestMarkerX = CoursePaths[ci][TargetPath][NearestMarker].Position[0];
    //                 NearestMarkerY = CoursePaths[ci][TargetPath][NearestMarker].Position[1];
    //                 NearestMarkerZ = CoursePaths[ci][TargetPath][NearestMarker].Position[2];
    //                 // AIPathfinder[i].Target[0] = CoursePaths[ci][TargetPath][NearestMarker].Position[0];
    //                 // AIPathfinder[i].Target[1] = CoursePaths[ci][TargetPath][NearestMarker].Position[1];
    //                 // AIPathfinder[i].Target[2] = CoursePaths[ci][TargetPath][NearestMarker].Position[2];
    //                 break;
    //             }
    //             case RAMPPATH:
    //             {
    //                 NearestMarkerX = CoursePaths[ci][TargetPath][NearestMarker].Position[0];
    //                 NearestMarkerY = CoursePaths[ci][TargetPath][NearestMarker].Position[1];
    //                 NearestMarkerZ = CoursePaths[ci][TargetPath][NearestMarker].Position[2];
    //                 // AIPathfinder[i].Target[0] = CourseRamps[ci][TargetPath][NearestMarker].Position[0];
    //                 // AIPathfinder[i].Target[1] = CourseRamps[ci][TargetPath][NearestMarker].Position[1];
    //                 // AIPathfinder[i].Target[2] = CourseRamps[ci][TargetPath][NearestMarker].Position[2];
    //                 break;
    //             }
    //             case DROPPATH: 
    //             {
    //                 NearestMarkerX = CoursePaths[ci][TargetPath][NearestMarker].Position[0];
    //                 NearestMarkerY = CoursePaths[ci][TargetPath][NearestMarker].Position[1];
    //                 NearestMarkerZ = CoursePaths[ci][TargetPath][NearestMarker].Position[2];
    //                 // AIPathfinder[i].Target[0] = CourseDrops[ci][TargetPath][NearestMarker].Position[0];
    //                 // AIPathfinder[i].Target[1] = CourseDrops[ci][TargetPath][NearestMarker].Position[1];
    //                 // AIPathfinder[i].Target[2] = CourseDrops[ci][TargetPath][NearestMarker].Position[2];
    //                 break;
    //             }
    //             break;
    //         }
    //         float distanceCheck = pow(GlobalPlayer[i].position[0]-NearestMarkerX, 2) + pow(GlobalPlayer[i].position[1]-NearestMarkerX, 2) + pow(GlobalPlayer[i].position[2]-NearestMarkerX, 2);
         
    //         if (distanceCheck < 250) //If near the nearest marker
    //         {
    //             AIPathfinder[i].Target[0] = NearestMarkerX;
    //             AIPathfinder[i].Target[1] = NearestMarkerY;
    //             AIPathfinder[i].Target[2] = NearestMarkerZ;   
    //             return StandardBattleBot(i); 
    //         }
    //         else{ //Else too far from nearest marker (and probably have fallen, so reset path finding)
    //             AIPathfinder[i].TargetPath = -1;
    //         }
    //         //return StandardBattleBot(i); 
    //     }
    //     //return StandardBattleBot(i);    
    // }


    //if (GlobalPlayer[i].item == 0 && !(GlobalPlayer[i].slip_flag & STAR) && PythagoreanTheorem(bot_x, AIPathfinder[i].Target[0], bot_z, AIPathfinder[i].Target[2]) > 100.0)
    if (game_mode == 3 && isPlayerHoldingFlag(i)) //If game mode is CTF and current bot is holding a flag, bot will drive towards its base
    {

        int baseNumber = getBaseNumber(i);
        

        rival_x = (float)basePositionsHolder[basePositionSelection][baseNumber][0];
        rival_y = (float)basePositionsHolder[basePositionSelection][baseNumber][1];
        rival_z = (float)basePositionsHolder[basePositionSelection][baseNumber][2];
    }
    else if ((checkItems(i) == 0) && !(GlobalPlayer[i].slip_flag & STAR) && !isPlayerHoldingFlag(i) && (game_mode != 6))// || hitting_wall)
    {

        if ((nearest_item_box[i][0] == 0.0))
        {
            //float item_box_position[3] = {0.0, 0.0, 0.0};
            if (FindNearestItemBox(GlobalPlayer[i].position, nearest_item_box[i], BattleLevelHeightChecksSquared[ci], ci) != -1) //If an item box is found on the same level, target that, as long as bot is not hitting wall
            {
                rival_x = nearest_item_box[i][0]; //x,y,z coords of rival
                rival_y = nearest_item_box[i][1];
                rival_z = nearest_item_box[i][2];   
                bot_rival_p1[i] = getRival(i); //Grab a new rival
                bot_timer_p1[i] = MakeRandomLimmit(1200) +  3000; //Reset bot timer 50-70 seconds. (600 = 10 seconds)
            }
            else //else target rival
            {
                rival_x = GlobalPlayer[bot_rival_p1[i]].position[0]; //x,y,z coords of rival
                rival_y = GlobalPlayer[bot_rival_p1[i]].position[1];
                rival_z = GlobalPlayer[bot_rival_p1[i]].position[2];    
            }            
        }
        else
        {
            rival_x = nearest_item_box[i][0]; //x,y,z coords of rival
            rival_y = nearest_item_box[i][1];
            rival_z = nearest_item_box[i][2];   
        }


    }
    else if (game_mode == 4 && playerHoldingFlag[0] == -1) //If game mode is Keep Away and flag has dropped, all bots target flag
    {
        rival_x = currentFlagPositionsX[0]; //x,y,z coords of rival
        rival_y = currentFlagPositionsHeight[0];
        rival_z = currentFlagPositionsY[0];  
    }
    else if (game_mode == 4 && playerHoldingFlag[0] == i)
    {
        keepAwayBotRunAwayTimer = decrementTimerWrapper(keepAwayBotRunAwayTimer); //Give bots holding the flag random nodes to run away too
        if (keepAwayBotRunAwayTimer <= 0)
        {
            keepAwayBotRunAwayTimer = 300 + MakeRandomLimmit(800);    
            keepAwayBotRunAwayNode =  MakeRandomLimmit(LineCounts[ci][0]);
        }    
        rival_x = CoursePaths[ci][keepAwayBotRunAwayNode][0].Position[0];
        rival_y = CoursePaths[ci][keepAwayBotRunAwayNode][0].Position[1];
        rival_z = CoursePaths[ci][keepAwayBotRunAwayNode][0].Position[2];
    }
    else if (bot_ai_type == RANDOM_AI || (game_mode==5 && (*(unsigned char*)(0x800F6991 + (0xDD8 * i)) != 0x50)))  //If bot AI mode is set to RANDOM or if in zombombs and player is not a bomb, run to a random node
    {


        randomBotTimers[i] = decrementTimerWrapper(randomBotTimers[i]); //Give bots holding the flag random nodes to run away too
        if (randomBotTimers[i] <= 0)
        {
            randomBotTimers[i] = 300 + MakeRandomLimmit(800);
            randomBotTargetNodes[i] = MakeRandomLimmit(LineCounts[ci][0]);
        }
        rival_x = CoursePaths[ci][randomBotTargetNodes[i]][0].Position[0];
        rival_y = CoursePaths[ci][randomBotTargetNodes[i]][0].Position[1];
        rival_z = CoursePaths[ci][randomBotTargetNodes[i]][0].Position[2];
        // //If near near target node, find a different node, commented out for now because it seems to cause a glitch where bots get stuck
        // objectPosition[0] = (float)rival_x;
        // objectPosition[1] = (float)rival_y;
        // objectPosition[2] = (float)rival_z;
        // if (TestCollideSphere(objectPosition, turn_towards_rival_radius[ci], GlobalPlayer[i].position, turn_towards_rival_radius[ci]))
        // {
        //     keepAwayBotRunAwayTimer = 0;    
        // }
    }
    else if (game_mode == 7) //Battle Santa, bots will run away to the furthest node
    {
        keepAwayBotRunAwayTimer = decrementTimerWrapper(keepAwayBotRunAwayTimer);
        if (keepAwayBotRunAwayTimer <= 0)
        {
            keepAwayBotRunAwayTimer = 350;
            FindFurthestNode(GlobalPlayer[0].position, furthest_node[i], CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0]);       
            if (AIPathfinder[i].TargetPath == AIPathfinder[i].LastPath)
            {
                int use_this_path = MakeRandomLimmit(LineCounts[ci][0]);
                furthest_node[i][0] = CoursePaths[ci][use_this_path][0].Position[0];
                furthest_node[i][1] = CoursePaths[ci][use_this_path][0].Position[1];
                furthest_node[i][2] = CoursePaths[ci][use_this_path][0].Position[2];
            }
        }        
        rival_x = furthest_node[i][0];
        rival_y = furthest_node[i][1];
        rival_z = furthest_node[i][2];         
                
    }
    else if (game_mode == 3 && ctf_game_mode == 1) //If game mode is CTF and multiflag
        if (isSomeoneHoldingPlayerFlag(i) )//If someone has the player's flag, go for the person carrying the flag
        {
            bot_rival_p1[i] = getRival(i); //Grab a new rival
            rival_x = GlobalPlayer[bot_rival_p1[i]].position[0]; //x,y,z coords of rival
            rival_y = GlobalPlayer[bot_rival_p1[i]].position[1];
            rival_z = GlobalPlayer[bot_rival_p1[i]].position[2];  
        }
        else
        {
            int flagNumber = getBaseNumber(bot_rival_p1[i]);
            rival_x = currentFlagPositionsX[flagNumber];
            rival_y = currentFlagPositionsHeight[flagNumber];
            rival_z = currentFlagPositionsY[flagNumber];            
        }
    else if (game_mode == 3 && ctf_game_mode == 0) //If someone does not have the flag, go for the flag
    {
        if (isSomeoneHoldingPlayerFlag(0))
        {
            bot_rival_p1[i] = getRival(i); //Grab a new rival
        }
        rival_x = currentFlagPositionsX[0];
        rival_y = currentFlagPositionsHeight[0];
        rival_z = currentFlagPositionsY[0];                      
    }
    else{ //else target rival
        rival_x = GlobalPlayer[bot_rival_p1[i]].position[0]; //x,y,z coords of rival
        rival_y = GlobalPlayer[bot_rival_p1[i]].position[1];
        rival_z = GlobalPlayer[bot_rival_p1[i]].position[2];        
        // nearest_item_box[i][0] = 0.0; //Reset nearest item box
        // nearest_item_box[i][1] = 0.0;
        // nearest_item_box[i][2] = 0.0;
    }




    // if (bot_timer_p1[i] <= 0) //If bot timer is <= 0, roll the dice and maybe get a new rival
    // {
    //     bot_rival_p1[i] = getRival(i);
    //     bot_timer_p1[i] = MakeRandomLimmit(160) +  500; //Reset bot timer
        
    //     AIPathfinder[i].Target[0] = GlobalPlayer[0].position[0]; //Reset path finding in case bot gets lost
    //     AIPathfinder[i].Target[1] = GlobalPlayer[0].position[1];
    //     AIPathfinder[i].Target[2] = GlobalPlayer[0].position[2];
    //     UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 300, BlockFortPaths_Paths, BlockFortPaths_PathLengths, i, 0); 
    // }



    // //TESTING AI MOVING TOWARDS A POINT
    // if (g_courseID == 0xF)
    // {
    //     *Paths_Paths = *BlockFortPaths_Paths;
    //     *Paths_PathLengths = BlockFortPaths_PathLengths;
    //     *Paths_Ramps = BlockFortPaths_Ramps;
    //     *Paths_RampLengths = BlockFortPaths_RampLengths;
    //     *Paths_Drops = BlockFortPaths_Drops;
    //     *Paths_DropLengths = BlockFortPaths_DropLengths;
    // }

    //Initialize the path finding if course is just starting
    //if ( PathfinderComplete((BKPathfinder*)&AIPathfinder[i], CoursePathLengths[ci], CourseRampLengths[ci], CourseDropLengths[ci]) )
    if (bot_initialization_flag[i] == true)
    {

        //First set up BKPathfinder for bot to follow rival
        bot_initialization_flag[i] = false;
        AIPathfinder[i].Target[0] = rival_x;
        AIPathfinder[i].Target[1] = rival_y;
        AIPathfinder[i].Target[2] = rival_z;
        UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), BattleLevelPathSearchRadius[ci], CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0, BattleLevelHeightChecksSquared[ci]);       
        if (AIPathfinder[i].TargetPath == -1)
        {
            // int random_drop = MakeRandomLimmit(LineCounts[ci][2])
            float dropNodePosition[] = {0.,0.,0.};
            int drop_path_index = FindNearestDropNode(GlobalPlayer[i].position, dropNodePosition, rival_y, CourseDrops[ci], CourseDropLengths[ci], LineCounts[ci][2], BattleLevelHeightChecksSquared[ci]);
            if (drop_path_index != -1) //crash catch
            {
                AIPathfinder[i].LastPath = 0;
                AIPathfinder[i].TargetPath = drop_path_index;
                AIPathfinder[i].Progression = 0;
                AIPathfinder[i].Direction = 1;
                AIPathfinder[i].PathType = 2;
                AIPathfinder[i].NearestMarker = 0;
                AIPathfinder[i].NearestMarkerHeight = (float)CourseDrops[ci][drop_path_index][0].Position[1];
                AIPathfinder[i].ProgressTimer = 0;                
            }



            // AIPathfinder[i].Target[0] = CourseDrops[ci][drop_path_index][CourseDropLengths[ci][drop_path_index]].position[0]
            // AIPathfinder[i].Target[1] = CourseDrops[ci][drop_path_index][CourseDropLengths[ci][drop_path_index]].position[1]
            // AIPathfinder[i].Target[2] = CourseDrops[ci][drop_path_index][CourseDropLengths[ci][drop_path_index]].position[2]
        }

    }


    ///
    ///TURNING - STEERING
    ///


    

    //Find Nearest Marker
    
    float CheckMarkerDistance = 99999999;
    short TargetPath = AIPathfinder[i].TargetPath;

    if (TargetPath != -1) //Check if Bot has fallen
    {
        switch (AIPathfinder[i].PathType)
        {
            case FLATPATH:  //If bot is following a flat path
            {   
    
            //compare to last Nearest Marker height
                
                // if (AIPathfinder[i].NearestMarker >= CoursePathLengths[ci][TargetPath]) //Catch the crash
                // {
                //     // //reset paths
                //     // AIPathfinder[i].TargetPath = -1;  
                //     // TargetPath = -1;
                //     break;
                // }

                 //reset nearest marker                    
                //if ((float)CoursePaths[ci][TargetPath][AIPathfinder[i].NearestMarker].Position[1] - bot_y > 25)
                if (AIPathfinder[i].NearestMarkerHeight - bot_y > BattleLevelHeightChecks[ci])
                {
                    //AI has fallen, reset paths.
                    AIPathfinder[i].TargetPath = -1;  
                    TargetPath = -1;
                }
                else
                {
                    for (int ThisMarker = 0; ThisMarker <= CoursePathLengths[ci][TargetPath]; ThisMarker++)
                    {
                        if (pow(GlobalPlayer[i].position[1] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[1], 2) < BattleLevelHeightChecksSquared[ci]) //If height is not too far off
                        {   
                            GlobalFloatA =  pow(GlobalPlayer[i].position[0] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[0], 2) + 
                                            pow(GlobalPlayer[i].position[2] - (float)CoursePaths[ci][TargetPath][ThisMarker].Position[2], 2)   ;
                            if (GlobalFloatA < CheckMarkerDistance)
                            {
                                CheckMarkerDistance = GlobalFloatA;
                                AIPathfinder[i].NearestMarker = ThisMarker;
                                AIPathfinder[i].NearestMarkerHeight = (float)CoursePaths[ci][TargetPath][ThisMarker].Position[1];
                            }
                        }
                    }
                }                
                
                break;
            }
            case RAMPPATH:  //If bot is following a ramp path
            {
                
                //compare to last Nearest Marker height
                //reset nearest marker 
                // if ((float)CourseRamps[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 15)
                // {
                //     //AI has fallen, reset paths.
                //     AIPathfinder[i].TargetPath = -1; 
                //     TargetPath = -1;
                // }
                // else
                // {
                    for (int ThisMarker = 0; ThisMarker <= CourseRampLengths[ci][TargetPath]; ThisMarker++)
                    {
                        if (pow(GlobalPlayer[i].position[1] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[1], 2) < BattleLevelHeightChecksSquared[ci]*2.0)
                        {   
                            GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[0], 2) + 
                                            pow(GlobalPlayer[i].position[2] - (float)CourseRamps[ci][TargetPath][ThisMarker].Position[2], 2)   ;
                            if (GlobalFloatA < CheckMarkerDistance)
                            {
                                CheckMarkerDistance = GlobalFloatA;
                                AIPathfinder[i].NearestMarker = ThisMarker;
                                AIPathfinder[i].NearestMarkerHeight = (float)CourseRamps[ci][TargetPath][ThisMarker].Position[1];
                            }
                        }
                    }
                // }                
                break;
            }
            case DROPPATH:  //If bot is following a drop path
            {
                //compare to last Nearest Marker height
                //reset nearest marker 

                // //This apparently was for debugging
                // *(uint*)(0x80700000) = (uint)ci;
                // *(uint*)(0x80700004) = (uint)TargetPath;
                // *(uint*)(0x80700008) = (uint)i;
                // *(float*)(0x8070000C) = (float)bot_y;
                // *(uint*)(0x80700010) = (uint)AIPathfinder[i].Progression;

                // if ((float)CourseDrops[ci][TargetPath][AIPathfinder[i].Progression].Position[1] - bot_y > 30)
                // {
                //     //AI has fallen, reset paths.
                //     AIPathfinder[i].TargetPath = -1; 
                //     TargetPath = -1;
                // }
                // else
                // {
                    for (int ThisMarker = 0; ThisMarker <= CourseDropLengths[ci][TargetPath]; ThisMarker++)
                    {
                        if (pow(GlobalPlayer[i].position[1] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[1], 2) < BattleLevelHeightChecksSquared[ci]*2.0)
                        {   
                            GlobalFloatA = pow(GlobalPlayer[i].position[0] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[0], 2) + 
                                            pow(GlobalPlayer[i].position[2] - (float)CourseDrops[ci][TargetPath][ThisMarker].Position[2], 2);
                            if (GlobalFloatA < CheckMarkerDistance)
                            {
                                CheckMarkerDistance = GlobalFloatA;
                                AIPathfinder[i].NearestMarker = ThisMarker;
                                AIPathfinder[i].NearestMarkerHeight = (float)CourseDrops[ci][TargetPath][ThisMarker].Position[1];
                            }
                        }
                    }
                // }
                break;
            }
        }
    }



    

    // if (i == 1) //Bot debugging wall o' text
    // {
        
    //     loadFont();
    //     printString(0, 120, "P2 target");

    //     printStringNumber(140, 10, "P1 x", GlobalPlayer[0].position[0]);
    //     printStringNumber(140, 20, "P1 y", GlobalPlayer[0].position[1]);
    //     printStringNumber(140, 30, "P1 z", GlobalPlayer[0].position[2]);


    //     printStringUnsignedHex(50,40,"paths address",(uint)&CoursePaths[4]);
    //     printStringUnsignedHex(50,50,"gcourseID", g_courseID);
    //     printStringNumber(50, 60, "Course conversion", ci);
    //     printStringNumber(50, 70, "RaceCoursePathLength", RaceCoursePathLength);
    //     printStringUnsignedHex(50, 80, "P2 stick control", bot_x_stick[1]);
    //     printStringUnsignedHex(50, 90, "P2 button control", bot_buttons[1]);

    //     // printStringNumber(50,0,"", PathLengthTable[0][0]);
    //     // printStringNumber(50,10,"",   PathLengthTable[1][0]);
    //     // printStringNumber(50,20,"",  PathLengthTable[2][0]);
    //     // printStringNumber(50,30,"",  PathLengthTable[3][0]);
    //     // printStringNumber(50,40,"",  PathLengthTable[4][0]);
    //     // printStringNumber(50,50,"",  PathLengthTable[5][0]);
    //     // printStringNumber(50,60,"",  PathLengthTable[6][0]);
    //     // printStringNumber(50,70,"",  PathLengthTable[7][0]);
    //     // printStringNumber(50,80,"",  PathLengthTable[8][0]);
    //     // printStringNumber(50,90,"",  PathLengthTable[9][0]);
    //     // printStringNumber(50,100,"",  PathLengthTable[10][0]);
    //     // printStringNumber(50,110,"",  PathLengthTable[11][0]);
    //     // printStringNumber(50,120,"",  PathLengthTable[12][0]);
    //     // printStringNumber(50,130,"",  PathLengthTable[13][0]);
    //     // printStringNumber(50,140,"",  PathLengthTable[14][0]);
    //     // printStringNumber(50,150,"",  PathLengthTable[15][0]);
    //     // printStringNumber(50,160,"",  PathLengthTable[16][0]);
    //     // printStringNumber(50,170,"",  PathLengthTable[17][0]);
    //     // printStringNumber(50,180,"",  PathLengthTable[18][0]);
    //     // printStringNumber(50,190,"",  PathLengthTable[19][0]);
    //     // printStringNumber(50,200,"",  PathLengthTable[20][0]);



    //     printStringNumber(0, 120, "Distance", AIPathfinder[i].Distance);
    //     printStringNumber(0, 130, "Target[0]", AIPathfinder[i].Target[0]);
    //     printStringNumber(0, 140, "Target[1]", AIPathfinder[i].Target[1]);
    //     printStringNumber(0, 150, "Target[2]", AIPathfinder[i].Target[2]);
    //     printStringNumber(0, 160, "Progression",  AIPathfinder[i].Progression);
    //     printStringNumber(0, 170, "Nearest",  AIPathfinder[i].NearestMarker);
    //     printStringNumber(0, 180, "Direction",  AIPathfinder[i].Direction);
    //     printStringNumber(0, 190, "PathType",  AIPathfinder[i].PathType);
    //     printStringNumber(0, 200, "TargetPath",  AIPathfinder[i].TargetPath);
    //     printStringNumber(0, 210, "LastPath",  AIPathfinder[i].LastPath);


    //     printStringNumber(140, 120, "ixbox x", nearest_item_box[1][0]);
    //     printStringNumber(140, 130, "ixbox y", nearest_item_box[1][1]);
    //     printStringNumber(140, 140, "ixbox z", nearest_item_box[1][2]);
    //     printStringNumber(140, 150, "ixbox count", ItemBoxCount);


    //     printStringNumber(140, 160, "bot x", bot_x);
    //     printStringNumber(140, 170, "bot y", bot_y);
    //     printStringNumber(140, 180, "bot z", bot_z);
    //     printStringNumber(140, 190, "Rival", bot_rival_p1[i]);
    //     printStringNumber(140, 200, "ProgressTimer", AIPathfinder[i].ProgressTimer);

    //     // printStringHex(140, 210, "The fuck?", *(unsigned int*)(0x8028EFF0));
    //     // *(unsigned int*)(0x8028EFF0) = 0x00000000;
    // }



    
    if (TargetPath != -1) //If bot has NOT fallen
    {

        


        //Check if at current target marker

        
        //GlobalFloatA = 3200.0;
        
        // if (AIPathfinder[i].Direction > 0)
        // {
        //     if (AIPathfinder[i].Progression > 3)
        //     {
        //         GlobalFloatA = 3200.0;
        //     }
        // }
        // else
        // {
        //     if (CoursePathLengths[ci][TargetPath]-AIPathfinder[i].Progression <= 3)
        //     {
        //         GlobalFloatA = 3200.0;
        //     }
        // }

        short Progression = AIPathfinder[i].Progression;
        switch (AIPathfinder[i].PathType) //Get position of current marker to drive towards
        {

            case FLATPATH: //flat paths
                objectPosition[0] = (float)CoursePaths[ci][TargetPath][Progression].Position[0];
                objectPosition[1] = (float)CoursePaths[ci][TargetPath][Progression].Position[1];
                objectPosition[2] = (float)CoursePaths[ci][TargetPath][Progression].Position[2]; 
                GlobalIntA = CoursePathLengths[ci][TargetPath];
                break;
            case RAMPPATH: //ramps
                objectPosition[0] = (float)CourseRamps[ci][TargetPath][Progression].Position[0];
                objectPosition[1] = (float)CourseRamps[ci][TargetPath][Progression].Position[1];
                objectPosition[2] = (float)CourseRamps[ci][TargetPath][Progression].Position[2]; 
                GlobalIntA = CourseRampLengths[ci][TargetPath];
                break;
            case DROPPATH: //drops 
                objectPosition[0] = (float)CourseDrops[ci][TargetPath][Progression].Position[0];
                objectPosition[1] = (float)CourseDrops[ci][TargetPath][Progression].Position[1];
                objectPosition[2] = (float)CourseDrops[ci][TargetPath][Progression].Position[2]; 
                GlobalIntA = CourseDropLengths[ci][TargetPath];
                break;
        }

        if (Progression <= 0 || Progression >= GlobalIntA) //If first or last node
        {
            GlobalFloatA = 5000.0;  //Square of radius to get within node to go to next node
        }
        else //If an inbetween node
        {
            GlobalFloatA = 3500.0;  //Square of radius to get within node to go to next node
        }
        

        if (pow(bot_x-objectPosition[0], 2) + pow(bot_y-objectPosition[1], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
        // if (pow(bot_x-objectPosition[0], 2) + pow(bot_z-objectPosition[2], 2) < GlobalFloatA)//If near the next path marker, advance to the next path marker
        {
            AIPathfinder[i].Progression += AIPathfinder[i].Direction;
            AIPathfinder[i].ProgressTimer = 0;
        }
        else
        {
            AIPathfinder[i].ProgressTimer++;
        }

        if (AIPathfinder[i].Progression > GlobalIntA)
        {
            AIPathfinder[i].Progression = GlobalIntA;
        }
        else if (AIPathfinder[i].Progression < 0)
        {
            AIPathfinder[i].Progression = 0;
        }

        //Now check if the nearest marker is further in the list than the Progression Value.

        if (AIPathfinder[i].Direction > 0)
        {
            if (AIPathfinder[i].NearestMarker > AIPathfinder[i].Progression)
            {
                AIPathfinder[i].Progression = AIPathfinder[i].NearestMarker;
            }
        }
        else
        {
            if (AIPathfinder[i].NearestMarker < AIPathfinder[i].Progression)
            {
                AIPathfinder[i].Progression = AIPathfinder[i].NearestMarker;
            }
        }
    }
    else //else if bot HAS fallen
    {
        for (int j=0; j<3; j++) //Clear nearest item box so bot doesn't get stuck trying to go for an item box not on their level
        {
            nearest_item_box[i][j] = 0.0;
        }

       //GlobalPlayer[i].weapon |= HIT_BOAT;//For debugging, give a player who hit a wall a star


        //return; //Skip the rest of the code and do nothing to avoid any sort of crashes
    }
    



    

    float diff_y = rival_y - bot_y;
    switch (AIPathfinder[i].PathType)
    {
        case FLATPATH:  //If bot is following a flat path
            if ( PathfinderComplete((BKPathfinder*)&AIPathfinder[i], CoursePathLengths[ci], CourseRampLengths[ci], CourseDropLengths[ci]) )
            {                               
                // if ((diff_y > -15.0) && (diff_y < 15.0)) //If bots are on same plane
                // {
                //     AIPathfinder[i].Target[0] = rival_x;
                //     AIPathfinder[i].Target[1] = rival_y;
                //     AIPathfinder[i].Target[2] = rival_z;
                //     UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);
                // }
                if (ci == 4) //Race course path finding
                {
                    AIPathfinder[i].Target[0] = rival_x;
                    AIPathfinder[i].Target[1] = rival_y;
                    AIPathfinder[i].Target[2] = rival_z;
                    UpdateRacePath((BKPathfinder*)(&AIPathfinder[i]), BattleLevelPathSearchRadius[ci], CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i);                    
                }
                else if (diff_y >= BattleLevelHeightChecks[ci] && LineCounts[ci][1] > 0) //If target is above bot and ramps exist, look for ramps
                {
                    float nodePosition[] = {0.,0.,0.};
                    int ramp_path_index;
                    //First find nearest ramp
                    ramp_path_index = FindNearestRampNode(GlobalPlayer[i].position, nodePosition, rival_y, CourseRamps[ci], CourseRampLengths[ci], LineCounts[ci][1], BattleLevelHeightChecksSquared[ci]);
                    //float diff_x = bot_x - nodePosition[0];
                    //float diff_z = bot_z - nodePosition[2];

                    if (ramp_path_index == -1) //If no path is found in the middle of a fall
                    {
                        return; //end function here to avoid errors
                    }
                    //if (diff_x*diff_x + diff_z*diff_z < RAMPDISTANCESQUARE) //If bot is at ramp, use ramp
                    if (PythagoreanTheorem(bot_x, nodePosition[0], bot_z, nodePosition[2]) < RAMPDISTANCESQUARE) //If bot is at ramp, use ramp
                    {
                        AIPathfinder[i].Target[0] = rival_x;
                        AIPathfinder[i].Target[1] = rival_y;
                        AIPathfinder[i].Target[2] = rival_z;
                        //UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 300.0, BlockFortPaths_Ramps, BlockFortPaths_RampLengths, 12, i, 1);
                        AIPathfinder[i].LastPath = TargetPath;
                        AIPathfinder[i].TargetPath = ramp_path_index;
                        AIPathfinder[i].Progression = 0;
                        AIPathfinder[i].Direction = 1;
                        AIPathfinder[i].PathType = 1;
                        AIPathfinder[i].NearestMarker = 0;
                        AIPathfinder[i].NearestMarkerHeight = (float)CourseRamps[ci][ramp_path_index][0].Position[1];
                        AIPathfinder[i].ProgressTimer = 0;
                    }
                    else{// Else find path to nearest ramp
                        AIPathfinder[i].Target[0] = nodePosition[0];
                        AIPathfinder[i].Target[1] = nodePosition[1];
                        AIPathfinder[i].Target[2] = nodePosition[2];
                        UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), BattleLevelPathSearchRadius[ci], CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0, BattleLevelHeightChecksSquared[ci]);                                            
                    }
                    
                }
                else if (diff_y <= -BattleLevelHeightChecks[ci] && (LineCounts[ci][1] > 0 || LineCounts[ci][2] > 0)) //If target is below bot and ramps or drops exist, look for ramps and drops
                {
                    //FOR NOW JUST USE RAMPS, LATER WILL ADD RAMPS AND DROPS
                    float rampNodePosition[] = {0.,0.,0.};
                    float dropNodePosition[] = {0.,0.,0.};
                    //First find nearest ramp and drop
                    int ramp_path_index = FindNearestRampNode(GlobalPlayer[i].position, rampNodePosition, rival_y, CourseRamps[ci], CourseRampLengths[ci], LineCounts[ci][1], BattleLevelHeightChecksSquared[ci]);
                    int drop_path_index = FindNearestDropNode(GlobalPlayer[i].position, dropNodePosition, rival_y, CourseDrops[ci], CourseDropLengths[ci], LineCounts[ci][2], BattleLevelHeightChecksSquared[ci]);
                    if (ramp_path_index == -1 && drop_path_index == -1)//If no path is found in the middle of a fall
                    {
                        // nearest_item_box[i][0] = 0.0; //Reset nearest item box
                        // nearest_item_box[i][1] = 0.0;
                        // nearest_item_box[i][2] = 0.0;
                        // AIPathfinder[i].Target[0] = rival_x; //Try to just do normal path finding
                        // AIPathfinder[i].Target[1] = rival_y;
                        // AIPathfinder[i].Target[2] = rival_z;
                        // UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), PATHDISTANCECHECK, CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0);
                        // break; //Break here to avoid errors
                        return; //End function here to avoid errors
                    }

                    // float diff_x_ramps = GlobalPlayer[i].position[0] - rampNodePosition[0];
                    // float diff_z_ramps = GlobalPlayer[i].position[2] - rampNodePosition[2];
                    // float diff_x_drops = GlobalPlayer[i].position[0] - dropNodePosition[0];
                    // float diff_z_drops = GlobalPlayer[i].position[2] - dropNodePosition[2];
                    //float dist_to_nearest_ramp = diff_x_ramps*diff_x_ramps + diff_z_ramps*diff_z_ramps;
                    //float dist_to_nearest_drop = diff_x_drops*diff_x_drops + diff_z_drops*diff_z_drops;
                    float dist_to_nearest_ramp = PythagoreanTheorem(GlobalPlayer[i].position[0], rampNodePosition[0], GlobalPlayer[i].position[2], rampNodePosition[2]);
                    float dist_to_nearest_drop = PythagoreanTheorem(GlobalPlayer[i].position[0], dropNodePosition[0], GlobalPlayer[i].position[2], dropNodePosition[2]);
                    if (dist_to_nearest_ramp < dist_to_nearest_drop || drop_path_index == -1) //If a ramp is closer than a drop, use the ramp
                    {
                        if (dist_to_nearest_ramp < RAMPDISTANCESQUARE) //If bot is at ramp, use ramp
                        {
                            AIPathfinder[i].Target[0] = rival_x;
                            AIPathfinder[i].Target[1] = rival_y;
                            AIPathfinder[i].Target[2] = rival_z;
                            // UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 300.0, BlockFortPaths_Ramps, BlockFortPaths_RampLengths, 12, i, 1);
                            AIPathfinder[i].LastPath = TargetPath;
                            AIPathfinder[i].TargetPath = ramp_path_index;
                            AIPathfinder[i].Progression = CourseRampLengths[ci][ramp_path_index];
                            AIPathfinder[i].Direction = -1;
                            AIPathfinder[i].PathType = 1;
                            AIPathfinder[i].NearestMarker = CourseRampLengths[ci][ramp_path_index];
                            AIPathfinder[i].NearestMarkerHeight = (float)CourseRamps[ci][ramp_path_index][CourseRampLengths[ci][ramp_path_index]].Position[1];
                            AIPathfinder[i].ProgressTimer = 0;
                        }
                        else{// Else find path to nearest ramp
                            AIPathfinder[i].Target[0] = rampNodePosition[0];
                            AIPathfinder[i].Target[1] = rampNodePosition[1];
                            AIPathfinder[i].Target[2] = rampNodePosition[2];
                            UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), BattleLevelPathSearchRadius[ci], CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0, BattleLevelHeightChecksSquared[ci]);                                            
                        }
                    }
                    else //else if a drop is closer than a ramp, use the drop
                    {
                        if (dist_to_nearest_drop < RAMPDISTANCESQUARE) //If bot is at drop, use drop
                        {
                            AIPathfinder[i].Target[0] = rival_x;
                            AIPathfinder[i].Target[1] = rival_y;
                            AIPathfinder[i].Target[2] = rival_z;
                            // UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 300.0, BlockFortPaths_Ramps, BlockFortPaths_RampLengths, 12, i, 1);
                            AIPathfinder[i].LastPath = TargetPath;
                            AIPathfinder[i].TargetPath = drop_path_index;
                            AIPathfinder[i].Progression = 0;
                            AIPathfinder[i].Direction = 1;
                            AIPathfinder[i].PathType = 2;
                            AIPathfinder[i].NearestMarker = 0;
                            AIPathfinder[i].NearestMarkerHeight = (float)CourseDrops[ci][drop_path_index][0].Position[1];
                            AIPathfinder[i].ProgressTimer = 0;
                        }
                        else{// Else find path to nearest drop
                            AIPathfinder[i].Target[0] = dropNodePosition[0];
                            AIPathfinder[i].Target[1] = dropNodePosition[1];
                            AIPathfinder[i].Target[2] = dropNodePosition[2];
                            UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), BattleLevelPathSearchRadius[ci], CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0, BattleLevelHeightChecksSquared[ci]);                                            
                        }
                    }


                }
                else //Else target is on same plane (or course is flat) so just use regular paths
                {
                    AIPathfinder[i].Target[0] = rival_x;
                    AIPathfinder[i].Target[1] = rival_y;
                    AIPathfinder[i].Target[2] = rival_z;
                    UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), BattleLevelPathSearchRadius[ci], CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0, BattleLevelHeightChecksSquared[ci]);
                }
            }
            break;
        case RAMPPATH: //If bot is following a ramp



            if ( PathfinderComplete((BKPathfinder*)&AIPathfinder[i], CoursePathLengths[ci], CourseRampLengths[ci], CourseDropLengths[ci]) )
            {
                AIPathfinder[i].Target[0] = rival_x; //Done with the ramp so go back to a flat path
                AIPathfinder[i].Target[1] = rival_y;
                AIPathfinder[i].Target[2] = rival_z;
                UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), BattleLevelPathSearchRadius[ci], CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0, BattleLevelHeightChecksSquared[ci]);                                   
            }
            break;
        case DROPPATH: //If bot is following a drop
            if ( PathfinderComplete((BKPathfinder*)&AIPathfinder[i], CoursePathLengths[ci], CourseRampLengths[ci], CourseDropLengths[ci]) )
            {
                AIPathfinder[i].Target[0] = rival_x; //Done with the ramp so go back to a flat path
                AIPathfinder[i].Target[1] = rival_y;
                AIPathfinder[i].Target[2] = rival_z;
                UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), BattleLevelPathSearchRadius[ci], CoursePaths[ci], CoursePathLengths[ci], LineCounts[ci][0], i, 0, BattleLevelHeightChecksSquared[ci]);                                   
            }
            break;
    }




    if (AIPathfinder[i].TargetPath == -1)//If no path is found, just move around as standard bot for a little bit until a path can be reacquired
    {
        nearest_item_box[i][0] = 0.0; //Reset nearest item box
        nearest_item_box[i][1] = 0.0;
        nearest_item_box[i][2] = 0.0;
        return StandardBattleBot(i);
    }


    if (TestCollideSphere(AIPathfinder[i].Target, turn_towards_rival_radius[ci], GlobalPlayer[i].position, turn_towards_rival_radius[ci]) && (pow(bot_y-rival_y, 2) < BattleLevelHeightChecksSquared[ci]*0.25))
    {   
        nearest_item_box[i][0] = 0.0; //Reset nearest item box
        nearest_item_box[i][1] = 0.0;
        nearest_item_box[i][2] = 0.0;


        GlobalPlayer[i].acc_maxcount = 0.75 * bot_topspeed[i]; //Slow the bot down when encountering a rival or item box 
        
        return StandardBattleBot(i);
    }
    

    

    ProSteeringPlus(i, ci, CoursePaths[ci], CourseRamps[ci], CourseDrops[ci]);

    //Occasionally fire weapon, more often if in RANDOM AI
    int multiplier = 3;
    if (bot_ai_type == RANDOM_AI)
    {
        multiplier = 1;
    }
    botFiringTimers[i] = decrementTimerWrapper(botFiringTimers[i]); //decrement the current bot's timer
    if (botFiringTimers[i] <= 0)
    {
        bot_pressed[i] = BTN_Z;
        bot_buttons[i] = BTN_A + BTN_Z;
        botFiringTimers[i] = (250 + MakeRandomLimmit(500)) * multiplier;
    }
        

}















//
//










void RandomBattleBot(int i)
{
    float x_distance_squared = pow(GlobalPlayer[i].position[0]-test_bot_sphere_position[i][0], 2);
    float y_distance_squared = pow(GlobalPlayer[i].position[1]-test_bot_sphere_position[i][1], 2);
    float z_distance_squared = pow(GlobalPlayer[i].position[2]-test_bot_sphere_position[i][2], 2);
    bot_distance_from_path_marker[i] = x_distance_squared + y_distance_squared + z_distance_squared;

    if  (y_distance_squared > 200.0) //If elevation has changed signifcantly
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
}






//












//Bot artificial intelligence
void runBots()
{

    //loadFont();
    //printStringNumber(80,120, "g_courseID", g_courseID);


    if (game_paused == 0) //Skip code if game is paused
    {
        for (int i=0; i<player_count; i++) //Loop through each bot
        {

                //Bot goes straight or turning at random
            if(bot_status_p1[i] > 0) //If bot is on
            {   
                bot_timer_p1[i] = decrementTimerWrapper(bot_timer_p1[i]); //decrement the current bot's timer

                
                if (bot_timer_p1[i] <= 0) //If bot timer is <= 0, roll the dice and maybe get a new rival
                {
                    //bot_rival_p1[i] = 0;
                    bot_rival_p1[i] = getRival(i);
                    bot_timer_p1[i] = MakeRandomLimmit(1200) +  3000; //Reset bot timer 50-70 seconds. (600 = 10 seconds)
                    // if (bot_steering_p1[i] == 0) //If bot was going straight
                    // {               
                    //     bot_steering_p1[i] = MakeRandomLimmit(2) + 1; //Set bot to turn right or left
                    //     bot_timer_p1[i] = MakeRandomLimmit(8) +  8; //Reset bot timer
                    // }
                    // else
                    // {
                    //     bot_steering_p1[i] = 0; //Set bot to go straight
                    //     bot_timer_p1[i] = MakeRandomLimmit(16) +  16; //Reset bot timer
                    // }
                }
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
                SeekerBattleBot(i); 
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




//Function returns a bot rival if someone has picked up a flag, or their flag, or just runs the original find rival function if not
int getRival(int currentPlayer) //Note current player is 1,2,3,4, NOT 0,1,2,3
{
    //return 0; //Test always having player 1 as the rival

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
    else if (game_mode == 5 && player_count == 2) //Error catch to get rid of lag 
    {
        if (currentPlayer == 1)
        {
            return 0;
        }
        else
        {
            return 1;
        }
    }
    //else if game mode is anything else
    //else if (MakeRandomLimmit(4) == 0) //Find a new rival 25% of the time
    else //Turn off random chance of getting a rival for now
    {
        int count = 0;
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
            count++;
        }while(currentPlayer == enemy ||  *(unsigned char*)(0x800F6991 + (0xDD8 * enemy)) == 0x50 || count < 20); //If returned rival is the current player, dead or a bomb, reroll the dice until a living rival can be found
        //return(getEnemy(currentPlayer)); //Run the old rival finding function that was written in assembly

        return(enemy);
    }
    //Else just return the current rival
    return(bot_rival_p1[currentPlayer]);
    //return(getEnemy(currentPlayer));
}

