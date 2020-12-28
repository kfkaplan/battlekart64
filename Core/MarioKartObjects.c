#include <stdbool.h>
#include "library/MarioKart.h"
#include "MarioKart3D.h"
#include "SharedFunctions.h"



void CreateObjectRotation(float itemLocation[], short itemRotation[], short objectID)
{
	float itemVelocity[] = {0,0,0};
	short objectIndex = addObjectBuffer(itemLocation,itemRotation,itemVelocity,objectID);
	*(short*)(0x8015F9B8 + (0x70 * objectIndex) + 2) = 0xC000;
}

void CreateObject(float itemLocation[], short objectID)
{
	short itemRotation[] = {0,0,0};
	float itemVelocity[] = {0,0,0};
	short objectIndex = addObjectBuffer(itemLocation,itemRotation,itemVelocity,objectID);
	*(short*)(0x8015F9B8 + (0x70 * objectIndex) + 2) = 0xC000;
}



/*
void loadCoin()
{
	SetSegment(8,(int)(&ok_RedCoin));
	ok_Source = (int)(&CoinROM);
	ok_Target = (int)(&ok_FreeSpace);
	dataLength = 0x4F0;
	runDMA();
	ok_Source = (int)(&ok_FreeSpace);
	ok_Target = (int)(&ok_RedCoin);
	runMIO();
	ok_Source = (int)(&RCSpriteROM);
	ok_Target = (int)(&ok_FreeSpace);
	dataLength = 0x4F0;
	runDMA();
	ok_Source = (int)(&ok_FreeSpace);
	ok_Target = (int)(&ok_RedCoinSprite);
	runMIO();
}



void RedCoinChallenge(long PathOffset)
{
	short objectPositionX[8];
	short objectPositionY[8];
	short objectPositionZ[8];
	float objectFloat[3];
	for (int currentCoin = 0; currentCoin < 8; currentCoin++)
	{
		objectPositionX[currentCoin] = *(short*)(PathOffset);
		objectPositionY[currentCoin] = *(short*)(PathOffset + 2);
		objectPositionZ[currentCoin] = *(short*)(PathOffset + 4);

		if (objectPositionX[currentCoin] == 0xFFFF8000)
		{
			if (currentCoin < 7)
			{
				*tempPointer = 0xD00D0035;
				return; //if there's not 8 coins don't run the function.
			}
			else
			{
				break;
			}
		}
		PathOffset = PathOffset + 8;
	}

	//two loops for above return; ensure 8 coins.

	for (int currentCoin = 0; currentCoin < 8; currentCoin++)
	{
		objectFloat[0] = (float)objectPositionX[currentCoin];
		objectFloat[1] = (float)objectPositionY[currentCoin];
		objectFloat[2] = (float)objectPositionZ[currentCoin];
		CreateObject(objectFloat,47);
	}


}
*/
