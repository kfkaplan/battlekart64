#include "../../Library/MainInclude.h"
#include "../BattleKartVariables.h"
#include "../BattleKartObjects/BattleKartObjects.h"
#include "../BattleKartPaths/BlockFortPaths.h"
//Standard libraries
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>

#define FLATPATH     0
#define RAMPPATH     1
#define DROPPATH     2

#define STANDARD_AI     0
#define SEEKER_AI       1
#define RANDOM_AI       2

#define STOPTURN ((DEG1 * 60) * (DEG1 * 60))
#define DRIFTTURN ((DEG1 * 40) * (DEG1 * 40))
#define WIDETURN ((DEG1 * 25) * (DEG1 * 25))
#define MIDTURN ((DEG1 * 12) * (DEG1 * 12))

#define SHORTTURN ((DEG1 * 5) * (DEG1 * 5))
#define NOTURN ((DEG1 * 2) * (DEG1 * 2))


extern int getRival();

const float max_bot_distance_path_marker = 400.0; //Distance a bot must get within a path marker to advance to the next marker (in squared pathagorean theorm space)
float bot_distance_from_path_marker[4] = {0., 0., 0., 0.};
ushort bot_buttons[4] = {0, 0, 0, 0};
ushort bot_pressed[4] = {0, 0, 0, 0};
char bot_x_stick[4] = {0, 0, 0, 0};
char TripleTap = 0;
Bump bot_bump[4];


float test_bot_sphere_position[4][3] = 
{
    {0., 0., 0.},
    {0., 0., 0.},
    {0., 0., 0.},
    {0., 0., 0.},
};


void botControl(void *Car, Controller *cont,char kno)
{
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


void ProSteeringPlus(int i)
{
    bot_buttons[i] = BTN_A;
    bot_pressed[i] = 0;
    
    if (GlobalUInt64 > STOPTURN)
    {   
        
        bot_buttons[i] |= BTN_B;  //continue braking
        if (GlobalShortA > 0)
        {   
            if (bot_x_stick > 0)
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
    else if (GlobalUInt64 > DRIFTTURN)
    {
        
        bot_pressed[i] = BTN_R | BTN_B;   //tap brake and jump
        bot_buttons[i] |= BTN_B;
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
}


//








void StandardBattleBot(int i)
{
    //Set bot controller
    AIPathfinder[i].TargetPath = -1;
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















//
//










void SeekerBattleBot(int i)
{
    float rival_x = GlobalPlayer[bot_rival_p1[i]].position[0]; //x,y,z coords of rival
    float rival_y = GlobalPlayer[bot_rival_p1[i]].position[1];
    float rival_z = GlobalPlayer[bot_rival_p1[i]].position[2];
    float bot_x = GlobalPlayer[i].position[0]; //x,y,z coordinates of current bot
    float bot_y = GlobalPlayer[i].position[1];
    float bot_z = GlobalPlayer[i].position[2];

    if (TestCollideSphere(GlobalPlayer[bot_rival_p1[i]].position, 25, GlobalPlayer[i].position, 25))
    {
        return StandardBattleBot(i);
    }
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


        //Initialize the path finding if course is just starting
        if ( (AIPathfinder[i].TargetPath == -1) || ( (AIPathfinder[i].TargetPath == 0 && AIPathfinder[i].LastPath==0) && (AIPathfinder[i].Direction == 0) ) )
        {

            //First set up BKPathfinder for bot to follow rival
            AIPathfinder[i].Target[0] = rival_x;
            AIPathfinder[i].Target[1] = rival_y;
            AIPathfinder[i].Target[2] = rival_z;
            UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 200, BlockFortPaths_Paths, BlockFortPaths_PathLengths, 28, i, 0);                            
        }




        int marker_index = AIPathfinder[i].Progression;
        int target_path = AIPathfinder[i].TargetPath;
        int direction = AIPathfinder[i].Direction;
        switch (AIPathfinder[i].PathType) //Get position of current marker to drive towards
        {
            case FLATPATH: //flat paths
                objectPosition[0] = (float)BlockFortPaths_Paths[target_path][marker_index].Position[0];
                objectPosition[1] = (float)BlockFortPaths_Paths[target_path][marker_index].Position[1];
                objectPosition[2] = (float)BlockFortPaths_Paths[target_path][marker_index].Position[2]; 
                break;
            case RAMPPATH: //ramps
                objectPosition[0] = (float)BlockFortPaths_Ramps[target_path][marker_index].Position[0];
                objectPosition[1] = (float)BlockFortPaths_Ramps[target_path][marker_index].Position[1];
                objectPosition[2] = (float)BlockFortPaths_Ramps[target_path][marker_index].Position[2]; 
                break;
            case DROPPATH: //drops 
                objectPosition[0] = (float)BlockFortPaths_Drops[target_path][marker_index].Position[0];
                objectPosition[1] = (float)BlockFortPaths_Drops[target_path][marker_index].Position[1];
                objectPosition[2] = (float)BlockFortPaths_Drops[target_path][marker_index].Position[2]; 
                break;
        }

        if (i == 1)
        {
            
            loadFont();
            //printString(0, 120, "P2 target");
            printStringNumber(0, 130, "Target[0]", AIPathfinder[i].Target[0]);
            printStringNumber(0, 140, "Target[1]", AIPathfinder[i].Target[1]);
            printStringNumber(0, 150, "Target[2]", AIPathfinder[i].Target[2]);
            printStringNumber(0, 160, "Progression",  AIPathfinder[i].Progression);
            printStringNumber(0, 170, "Nearest",  AIPathfinder[i].NearestMarker);
            printStringNumber(0, 180, "Direction",  AIPathfinder[i].Direction);
            printStringNumber(0, 190, "PathType",  AIPathfinder[i].PathType);
            printStringNumber(0, 200, "TargetPath",  AIPathfinder[i].TargetPath);
            

        }





        ///
        ///TURNING - STEERING
        ///


        

        //Find Nearest Marker
        
        float CheckMarkerDistance = 9999999999;

        
        switch (AIPathfinder[i].PathType)
        {
            case FLATPATH:  //If bot is following a flat path
            {   

                //Check if Bot has fallen - compare to last Nearest Marker height
                if (AIPathfinder[i].TargetPath != -1)
                {
                    
                    float diff_y = BlockFortPaths_Paths[AIPathfinder[i].TargetPath][(int)AIPathfinder[i].NearestMarker].Position[1] - bot_y;

                    
                    AIPathfinder[i].NearestMarker = -1;

                    //reset nearest marker 
                    if (diff_y > 20)
                    {
                        //AI has fallen, reset paths.
                        AIPathfinder[i].TargetPath = -1;  
                    }
                    else
                    {
                        for (int ThisMarker = 0; ThisMarker < BlockFortPaths_PathLengths[AIPathfinder[i].TargetPath]; ThisMarker++)
                        {
                            float diff_x = bot_x - BlockFortPaths_Paths[AIPathfinder[i].TargetPath][ThisMarker].Position[0];
                            float diff_z = bot_z - BlockFortPaths_Paths[AIPathfinder[i].TargetPath][ThisMarker].Position[2];
                            diff_y = bot_y - BlockFortPaths_Paths[AIPathfinder[i].TargetPath][ThisMarker].Position[1];
                            if ((diff_y * diff_y) < 324)
                            {   
                                if ((diff_x * diff_x) + (diff_z * diff_z) < CheckMarkerDistance)
                                {
                                    CheckMarkerDistance = (diff_x * diff_x) + (diff_z * diff_z);
                                    AIPathfinder[i].NearestMarker = ThisMarker;
                                }
                            }
                        }
                    }
                }
                
                
                break;
            }
            case RAMPPATH:  //If bot is following a flat path
            {
                
                if (AIPathfinder[i].TargetPath != -1)
                {

                    //Check if Bot has fallen - compare to last Nearest Marker height
                    float diff_y = BlockFortPaths_Paths[AIPathfinder[i].TargetPath][(int)AIPathfinder[i].NearestMarker].Position[1] - bot_y;

                    AIPathfinder[i].NearestMarker = -1;

                    //reset nearest marker 
                    if (diff_y > 20)
                    {
                        //AI has fallen, reset paths.
                        AIPathfinder[i].TargetPath = -1;  
                    }
                    else
                    {
                        for (int ThisMarker = 0; ThisMarker < BlockFortPaths_RampLengths[AIPathfinder[i].TargetPath]; ThisMarker++)
                        {
                            float diff_x = bot_x - BlockFortPaths_Ramps[AIPathfinder[i].TargetPath][ThisMarker].Position[0];
                            float diff_z = bot_z - BlockFortPaths_Ramps[AIPathfinder[i].TargetPath][ThisMarker].Position[2];
                            diff_y = bot_y - BlockFortPaths_Ramps[AIPathfinder[i].TargetPath][ThisMarker].Position[1];
                            if ((diff_y * diff_y) < 625)
                            {   
                                if ((diff_x * diff_x) + (diff_z * diff_z) < CheckMarkerDistance)
                                {
                                    CheckMarkerDistance = (diff_x * diff_x) + (diff_z * diff_z);
                                    AIPathfinder[i].NearestMarker = ThisMarker;
                                }
                            }
                        }
                    }
                }
                
                break;
            }
            case DROPPATH:  //If bot is following a flat path
            {
                GlobalShortA = BlockFortPaths_PathLengths[AIPathfinder[i].TargetPath];
                break;
            }
        }


        
        if (AIPathfinder[i].NearestMarker != -1)
        {

            
            //Check if at current target marker

            GlobalShortA = 3600;
            if (direction > 0)
            {
                if (marker_index > 4)
                {
                    GlobalShortA = 1600;
                }
            }
            else
            {
                if (BlockFortPaths_PathLengths[target_path]-marker_index > 4)
                {
                    GlobalShortA = 1600;
                }
            }


            float x_distance = bot_x - objectPosition[0];
            float y_distance = bot_y - objectPosition[1]; 
            float z_distance = bot_z - objectPosition[2];

            x_distance *= x_distance;
            z_distance *= z_distance;
            y_distance *= y_distance;

            if (x_distance + z_distance + y_distance< GlobalShortA) //If near the next path marker, advance to the next path marker
            {
                marker_index += direction;
                AIPathfinder[i].Progression = marker_index;
            }


            //Now check if the nearest marker is further in the list than the Progression Value.

            if (direction > 0)
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
            marker_index = AIPathfinder[i].Progression;
        }
        



        

        float diff_y = rival_y - bot_y;
        switch (AIPathfinder[i].PathType)
        {
            case FLATPATH:  //If bot is following a flat path
                if ( ( AIPathfinder[i].TargetPath == -1) || (marker_index==0 && direction==-1)  || (marker_index==BlockFortPaths_PathLengths[target_path] && direction==1) || (marker_index < 0) || (marker_index > BlockFortPaths_PathLengths[target_path])) //If bot reaches end of path
                {                               
                    if ((diff_y > -20.0) && (diff_y < 20.0)) //If bots are on same plane
                    {
                        AIPathfinder[i].Target[0] = rival_x;
                        AIPathfinder[i].Target[1] = rival_y;
                        AIPathfinder[i].Target[2] = rival_z;
                        UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 200, BlockFortPaths_Paths, BlockFortPaths_PathLengths, 28, i, 0);
                    }
                    else if (diff_y >= 20.0) //If player is above bot
                    {
                        float nodePosition[] = {0.,0.,0.};
                        int ramp_path_index;
                        //First find nearest ramp
                        ramp_path_index = FindNearestRampNode(GlobalPlayer[i].position, nodePosition, rival_y, BlockFortPaths_Ramps, BlockFortPaths_RampLengths, 12);
                        float diff_x = bot_x - nodePosition[0];
                        float diff_z = bot_z - nodePosition[2];


                        if (diff_x*diff_x + diff_z*diff_z < 40000.0) //If bot is at ramp, use ramp
                        {
                            AIPathfinder[i].Target[0] = rival_x;
                            AIPathfinder[i].Target[1] = rival_y;
                            AIPathfinder[i].Target[2] = rival_z;
                            //UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 300.0, BlockFortPaths_Ramps, BlockFortPaths_RampLengths, 12, i, 1);
                            AIPathfinder[i].LastPath = AIPathfinder[i].TargetPath;
                            AIPathfinder[i].TargetPath = ramp_path_index;
                            AIPathfinder[i].Progression = 0;
                            AIPathfinder[i].Direction = 1;
                            AIPathfinder[i].PathType = 1;
                        }
                        else{// Else find path to nearest ramp
                            AIPathfinder[i].Target[0] = nodePosition[0];
                            AIPathfinder[i].Target[1] = nodePosition[1];
                            AIPathfinder[i].Target[2] = nodePosition[2];
                            UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 200, BlockFortPaths_Paths, BlockFortPaths_PathLengths, 28, i, 0);                                            
                        }

                    }
                    else if (diff_y <= -20.0)
                    {
                        //FOR NOW JUST USE RAMPS, LATER WILL ADD RAMPS AND DROPS
                        float nodePosition[] = {0.,0.,0.};
                        int ramp_path_index;
                        //First find nearest ramp
                        ramp_path_index = FindNearestRampNode(GlobalPlayer[i].position, nodePosition, rival_y, BlockFortPaths_Ramps, BlockFortPaths_RampLengths, 12);
                        float diff_x = bot_x - nodePosition[0];
                        float diff_z = bot_z - nodePosition[2];
                        


                        if (diff_x*diff_x + diff_z*diff_z < 40000.0) //If bot is at ramp, use ramp
                        {
                            AIPathfinder[i].Target[0] = rival_x;
                            AIPathfinder[i].Target[1] = rival_y;
                            AIPathfinder[i].Target[2] = rival_z;
                            // UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 300.0, BlockFortPaths_Ramps, BlockFortPaths_RampLengths, 12, i, 1);
                            AIPathfinder[i].LastPath = AIPathfinder[i].TargetPath;
                            AIPathfinder[i].TargetPath = ramp_path_index;
                            AIPathfinder[i].Progression = BlockFortPaths_RampLengths[ramp_path_index];
                            AIPathfinder[i].Direction = -1;
                            AIPathfinder[i].PathType = 1;
                        }
                        else{// Else find path to nearest ramp
                            AIPathfinder[i].Target[0] = nodePosition[0];
                            AIPathfinder[i].Target[1] = nodePosition[1];
                            AIPathfinder[i].Target[2] = nodePosition[2];
                            UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 200, BlockFortPaths_Paths, BlockFortPaths_PathLengths, 28, i, 0);                                            
                        }
                    }
                }
                break;
            case RAMPPATH: //If bot is following a ramp



                if ( ( AIPathfinder[i].TargetPath == -1) || (marker_index==0 && direction==-1)  || (marker_index==BlockFortPaths_RampLengths[target_path] && direction==1) || (marker_index < 0) || (marker_index > BlockFortPaths_RampLengths[target_path])) //If bot reaches end of path
                {
                    AIPathfinder[i].Target[0] = rival_x; //Done with the ramp so go back to a flat path
                    AIPathfinder[i].Target[1] = rival_y;
                    AIPathfinder[i].Target[2] = rival_z;
                    UpdateBKPath((BKPathfinder*)(&AIPathfinder[i]), 200, BlockFortPaths_Paths, BlockFortPaths_PathLengths, 28, i, 0);                                   
                }
                break;
            case DROPPATH: //If bot is following a drop
                break;
        }



        

        GlobalShortA = (short)(MakeDirection(GlobalPlayer[i].position[0],GlobalPlayer[i].position[2], objectPosition[0], objectPosition[2]) * -1);
        GlobalShortA -= GlobalPlayer[i].direction[1];
        GlobalUInt64 = GlobalShortA * GlobalShortA;
        

        ProSteeringPlus(i);
        


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















//
//










void RandomBattleBot(int i)
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
}






//












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
                switch(bot_ai_type)
                {
                    case STANDARD_AI:
                    {
                        StandardBattleBot(i); 
                        break;
                    }
                    case SEEKER_AI:
                    {
                        SeekerBattleBot(i); 
                        break;
                    }
                    case RANDOM_AI:
                    {
                        RandomBattleBot(i); 
                        break;
                    }
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

