#include <stdbool.h>
#include "library/SubProgram.h"
#include "library/MarioKart.h"
#include "SharedFunctions.h"

int CoinCount = 0;



void DrawGeometry(float objectPosition[], short objectAngle[], int F3DEXAddress)
{
	float AffineMatrix[4][4];
	CreateModelingMatrix(AffineMatrix,objectPosition,objectAngle);
	if(SetMatrix(AffineMatrix,0) == 0)
	{
		return;
	}
	else
	{
		*(long*)*graphPointer = (long)(0xB7000000);
		*graphPointer = *graphPointer + 4;
		*(long*)*graphPointer = (long)(0x00000200);
		*graphPointer = *graphPointer + 4;
		*(long*)*graphPointer = (long)(0xB6000000);
		*graphPointer = *graphPointer + 4;
		*(long*)*graphPointer = (long)(0x00020000);
		*graphPointer = *graphPointer + 4;
		*(long*)*graphPointer = (long)(0x06000000);
		*graphPointer = *graphPointer + 4;
		*(long*)*graphPointer = (long)(F3DEXAddress);
		*graphPointer = *graphPointer + 4;
	}
}


void DrawPaths(long RSPInput)
{
	int pathOffset = GetRealAddress(RSPInput);

	int F3DEXAddress = 0x0D001780;
	short objectPosition[] = {0,0,0,0};
	float objectFloat[] = {0,0,0};
	short objectAngle[] = {0,0,0};
	do
	{
		objectPosition[0] = *(short*)(pathOffset);
		objectPosition[1] = *(short*)(pathOffset + 2);
		objectPosition[2] = *(short*)(pathOffset + 4);
		objectPosition[3] = *(short*)(pathOffset + 6);

		if (objectPosition[0] == 0xFFFF8000)
		{
			break;
		}
		else
		{

			objectFloat[0] = (float)objectPosition[0];
			objectFloat[1] = (float)objectPosition[1];
			objectFloat[2] = (float)objectPosition[2];
			DrawGeometry(objectFloat,objectAngle,F3DEXAddress);

		}
		pathOffset = pathOffset + 8;
	} while (1 == 1);

}

void DisplayObject(void *Camera, void *Object)
{
	int objectID = (short)((*(long*)(*(long*)(&Object)) >> 16) & 0x0000FFFF);

	objectID = objectID - 2;//alligns ID with original jump routine.
	switch (objectID)
	{
		case 45:
		{
			//DisplayRedCoin(Camera,Object);
			break;
		}
		default:
		{
			break;
		}
	}



}






//kept for example
/*
void DisplayRedCoin(void *Camera, void *Object)
{
	//camera goes unused but is passed by the game's internal function



	float objectPosition[] = {0,0,0};
	short objectAngle[] = {0,0,0};
	int F3DEXAddress = RedCoin_RSP;

	int objectAddress = *(long*)(&Object);
	objectPosition[0] = *(float*)(objectAddress + 24);
	objectPosition[1] = *(float*)(objectAddress + 28);
	objectPosition[2] = *(float*)(objectAddress + 32);


	objectAngle[0] = *(short*)(objectAddress + 16);
	objectAngle[1] = *(short*)(objectAddress + 18);
	objectAngle[2] = *(short*)(objectAddress + 20);
	*(short*)(objectAddress + 18) += DEG1 * 3;


	DrawGeometry(objectPosition,objectAngle,F3DEXAddress);

	for(int currentSprite = 1; currentSprite <= CoinCount; currentSprite++)
	{
		KWSprite((currentSprite* 16),230,16,16,(short*)&ok_RedCoinSprite);
	}
}



int RedCoinCollide(void *Car, void *Coin)
{
	float objectPosition[3];
	int objectAddress = *(long*)(&Coin);
	objectPosition[0] = *(float*)(objectAddress + 24);
	objectPosition[1] = *(float*)(objectAddress + 28);
	objectPosition[2] = *(float*)(objectAddress + 32);
	if ((CollisionCylinder(Car,objectPosition,3.0f,5.0f,0.0f) == 1))
	{
		deleteObjectBuffer(Coin);
		playSound(0x49008017);
		CoinCount++;
	}
	if (CoinCount == 8)
	{
		int playerID = ((long)&Car - (long)&g_PlayerStateTable) / 0xDD8;
		SetStar(Car,playerID);
	}

	return(0);
}
*/
//kept for example
