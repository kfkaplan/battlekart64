//#include "../Library/OKBehaviors.h"
#include "../Library/SubProgram.h"
#include "../Library/SharedFunctions.h"
//#include "../Library/OKHeader.h"
#include "../Library/GameVariables/NTSC/OKassembly.h"
#include "../Library/GameVariables/NTSC/GameOffsets.h"
#include "../Library/MarioKart3D.h"
#include "../Library/MarioKartObjects.h"
#include "../Library/LibraryVariables.h"
#include "../Library/Struct.h"
#include "../BattleKartVariables.h"
//#include "../BattleKartModel/BattleKartModel.h"
#include "../BattleKartObjects/BattleKartObjects.h"
//#include "../MinimapSprites/ImageData.h"
#include "../Library/MarioKartMenu.h"
//#include "../Library/CustomLevels.h"
//#include "../Library/PlayerEffects.h"
#include <stdbool.h>

// #include "../USB/usb.c"
// #include "../USB/usb.h"
// #include "../USB/debug.c"
// #include "../USB/debug.h"

const int keepAwayTimerMax = 150; //Number to set the keep away timer everytime it rests (60 = 1 sec)
const float fractionSpeedWhenHoldingFlag = 0.8; //Fraction of top speed when holding flag

//float course_height = 0.0; //Store height of course based off initialized player 1's position, used to set base and flag heights when courses are flat





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
    if (MakeRandomLimmit(4) == 0) //Find a new rival 25% of the time
    {
        return(getEnemy(currentPlayer)); //Run the old rival finding function that was written in assembly
    }
    else
    {
        return(bot_rival_p1[currentPlayer]);
    }
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
            printString(0x1C, 0x10, "Press A:  1  2  3  4");
            printString(0x1C, 0x20, "Press START to begin game");


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

            //Freeze bots so they don't wander around
            if (bot_status_p1) 
            {
                player_frozen[0] = true;
                GlobalPlayer[0].flag = 0xE000;
            }
            if (bot_status_p2)
            {
                player_frozen[1] = true;
                GlobalPlayer[1].flag = 0xE000;
            }
            if (bot_status_p3)
            {
                player_frozen[2] = true;
                GlobalPlayer[2].flag = 0xE000;
            }
            if (bot_status_p4)
            {
                player_frozen[3] = true;
                GlobalPlayer[3].flag = 0xE000;
            }


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
        FlagCount[i] = 0;
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
        FlagCount[i] = 0;
        flagTimer[i] = 0;
        flagDropped[i] = false;


        // GlobalAddressA = (long)(&g_PlayerStructTable) + (0xDD8 * i); //Set characters for each player
        // GlobalShortA = *(short*)(GlobalAddressA + 0x254);
        // Characters[i] = GlobalShortA;

    }

    //Set up single flag
    ctf_game_mode = 0;
    setFlag(0);

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
void dropFlag()
{

    for (int flagNumber=0; flagNumber < player_count; flagNumber++)
    {
        if (playerHoldingFlag[flagNumber] != -1)
        {
            if (checkHit(playerHoldingFlag[flagNumber]) == 1)
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

void DrawLightBulb()
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
        //FlagCount++;
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
    // if (FlagCount == 8)
    // {
    //     playerID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;
    //     SetStar(Car,playerID);
    //     FlagCount++;
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


    if (checkHit(carID) == 0 && playerHoldingFlag[0] != carID && playerHoldingFlag[1] != carID && playerHoldingFlag[2] != carID && playerHoldingFlag[3] != carID)   //Only allow players who are not current "being hit" to pick up the flag
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
                FlagCount[flagNumber]++;
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
        // if (FlagCount == 8)
        // {
        //     playerID = (*(long*)&Car - (long)&g_PlayerStructTable) / 0xDD8;
        //     SetStar(Car,playerID);
        //     FlagCount++;
        // }
    }

    return(0);
}


/////MENU STUFF

//Function to handle the ability to select custom courses
void menuStuff()
{

    //Print an address for debugging
    loadFont();
    // printStringUnsignedHex( 0, 10, "", (uint)(&RAM_END) );
    //printStringNumber( 0, 10, "Course Value", courseValue) ;
    //printStringNumber( 0, 0x10, "courseValue", courseValue) ;
    //printStringNumber( 0, 0x1C, "HotSwapID", HotSwapID) ;


 
    //Needed for custom courses
    SetCloudType((char)OverKartHeader.SkyType);
    SetWeatherType((char)OverKartHeader.WeatherType);
    SetWeather3D(OverKartHeader.SkyType == 3);
    SetWaterType((char)OverKartHeader.WaterType);
    
    
    
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
                
                
                // resetMap();
                // setAlwaysAdvance();                
                HotSwapID = 0;
                stockASM();
                hsLabel = -1;
                courseValue = -1;
                setPreviews();
                previewRefresh();
            }    

            switch(g_gameMode)
            {
                //GRAND PRIX

                case 0:
                {
                    if (courseValue != (g_cupSelect * 4))
                    {
                        FreeSpaceAddress = (int)&ok_Storage;
                        break;
                    }    
                }
                case 1:
                case 2:
                case 3:
                {
                    if (courseValue != (g_cupSelect * 4)  + g_courseSelect)
                    {
                        FreeSpaceAddress = (int)&ok_Storage;
                        break;
                    }
                }
            }    

            //PlayerSelectMenuAfter();        
            MapSelectMenu();


            
            break;
            
        }
    }
    //     case 10:
    //     {    
    //         if (MenuChanged != 10)
    //         {    
                
    //             MenuChanged = 10;
                
    //         }
    //         break;
    //     }
    //     case 11:
    //     {
            
    //         if (in_title_screen == 1) //Save settings to EPPROM when going from title screen with battle kart menu to main menu
    //         {
    //             in_title_screen = 0;
    //             saveEEPROM((uint)&VARIABLE_RAM_BASE);
    //         }

    //         if (MenuChanged != 11)
    //         {
    //             MenuChanged = 11;
    //         }
    //         HotSwapID = 0;
    //         break;
    //     }
    //     case 12:
    //     {
    //         scrollLock = false;            
    //         MenuChanged = 12;
    //         HotSwapID = 0;
    //         break;
    //     }            
    //     case 13:
    //     {
    //         scrollLock = false;
    //         g_startingIndicator = 0;
    //         if (MenuChanged != 13)
    //         {
    //             MenuChanged = 13;                
                
    //             //resetMap();
    //             //setAlwaysAdvance();                
    //             HotSwapID = 0;
    //             stockASM();
    //             hsLabel = -1;
    //             courseValue = -1;
    //             setPreviews();
    //             previewRefresh();
    //         }    

    //         switch(g_gameMode)
    //         {
    //             //GRAND PRIX

    //             case 0:
    //             {
    //                 if (courseValue != (g_cupSelect * 4))
    //                 {
    //                     FreeSpaceAddress = (int)&ok_Storage;
    //                     break;
    //                 }    
    //             }
    //             case 1:
    //             case 2:
    //             case 3:
    //             {
    //                 if (courseValue != (g_cupSelect * 4)  + g_courseSelect)
    //                 {
    //                     FreeSpaceAddress = (int)&ok_Storage;
    //                     break;
    //                 }
    //             }
    //         }    
    
    //         MapSelectMenu(); //This turns on/off the menu for custom courses


            
    //         break;
            
    //     }
    //     default:
    //     {
    //         hsLabel = -1;
    //         MenuChanged = -1;
    //         break;
            
    //     }
    // }



    // if (HotSwapID > 0)
    // {
    //     if (g_gameMode != 3)
    //     {
    //         g_courseID = 0;
    //     }
    //     else
    //     {
    //         g_courseID = 15;
    //     }
    // }
    // if (g_courseID == 0x14)
    // {
    //         g_player1ScreenWidth = 0x0240;
    // }




    // if (KBGNumber == 11)
    // {
    //     if (in_title_screen == 1)
    //     {
    //         in_title_screen = 0;
    //         saveEEPROM((uint)&VARIABLE_RAM_BASE);
    //     }
    // }
    // if (KBGNumber == 13) //Custom course select
    // {
    //     if (g_gameMode == 3)
    //     {
    //         GlobalShortA = 4;
    //     }
    //     else
    //     {
    //         GlobalShortA = 1;
    //     }
    //     if (menuScreenA == GlobalShortA)
    //     {
    //         if ((GlobalController[0]->ButtonPressed & BTN_L) == BTN_L)
    //         {
    //             swapHS(0);
    //         }
    //         else if ((GlobalController[0]->ButtonPressed & BTN_R) == BTN_R)
    //         {
    //             swapHS(1);
    //         }
    //     }



    //     if (HotSwapID > 0)
    //     {
    //         if (g_gameMode != 3)
    //         {
    //             g_courseID = 0;
    //         }
    //         else
    //         {
    //             g_courseID = 15;
    //         }
    //     }

    //     MapSelectMenu();
    // }
    // else
    // {
    //     hsLabel = -1;
    // }
}

//



//At bootup, one time, you'll want to run the following for custom courses to work
void bootCustomCourseStuff()
{

    loadHeaderOffsets();
    NopSplashCheckCode();

    nopASM = 0;
    HotSwapID = 0;

    FreeSpaceAddress = (int)&ok_Storage;

    copyCourseTable(1);

}    

//For custom coureses
void MapStartup(short InputID)
{
    LoadCustomHeader(courseValue + gpCourseIndex);
    SetCustomData();
    LoadMapData(InputID);
}
void InitialMapCode()
{
    
    InitialMap();
    if ((HotSwapID > 0) && (g_gameMode == 3))
    {
        SearchListFile(0x06000000 | OverKartHeader.SurfaceMapPosition);
        MakeCollision();
    }
}

void XLUDisplay(Screen* PlayerScreen)
{    
    if ((OverKartHeader.Version > 4) && (HotSwapID > 0))
    {    
        if (g_gameMode != 3)
        {
            DisplayGroupmap(GetRealAddress(SegmentAddress(6,OverKartHeader.XLUSectionViewPosition)), PlayerScreen);
        }
        else
        {
            *(long*)*graphPointer = (long)(0x06000000);
            *graphPointer = *graphPointer + 4;
            *(long*)*graphPointer = (long)(SegmentAddress(6,OverKartHeader.XLUSectionViewPosition));
            *graphPointer = *graphPointer + 4;
        }
    }
}


//For Zombombs

void infectPlayersHitByBombs()
{
    for (int i=0; i<player_count; i++)
    {
        if (checkHitBomb(i))
        {
            killPlayer(i); //If ap layer is hit by a bomb, kill them and turn them into a bomb as well
        }
    }
}
