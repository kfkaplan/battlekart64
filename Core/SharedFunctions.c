#include <sys/types.h>
#include <math.h>
#include <stdbool.h>
#include "library/SubProgram.h"
#include "library/MarioKart.h"




long dataLength = 0; //
short *TKMChar = &ok_TKMChar;
long *targetAddress = &ok_Target;
long *sourceAddress = &ok_Source;
long *tempPointer = &ok_Pointer;
long *graphPointer = &GraphPtrOffset;


void runDMA()
{
	DMA(*targetAddress, *sourceAddress, dataLength);
}
void runRAM()
{
	ramCopy(*targetAddress, *sourceAddress, dataLength);
}
void runMIO()
{
	decodeMIO0(*sourceAddress, *targetAddress);
}
void runTKM()
{
	decodeTKMK(*sourceAddress, tempPointer, *targetAddress, 0xBE);
}


int GetRealAddress(int RSPAddress)
{
	int number = SegmentNumber(RSPAddress);
	int offset = SegmentOffset(RSPAddress);

	return(PhysToK0(SegmentTable[number] + offset));
}


static const char *hex = "0123456789ABCDEF";
char* printHex(char *buf, uint num, int nDigits) {
    //print hex number into buffer.
    //will zero-pad to specified number of digits.
    //will truncate numbers larger than specified length.
    //returns pointer to null terminator.
    char *bufEnd = &buf[nDigits];
    *bufEnd = 0;
    while(nDigits--) {
        buf[nDigits] = hex[num & 0xF];
        num >>= 4;
    }
    return bufEnd;
}
