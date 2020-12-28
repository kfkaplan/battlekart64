#include <sys/types.h>
#include <math.h>



extern void runDMA();
extern void runRAM();
extern void runTKM();
extern void runMIO();


extern long dataLength; //
extern long *targetAddress; //
extern long *sourceAddress; //
extern long *tempPointer; //
extern long *graphPointer; //

extern int GetRealAddress(long RSPAddress);
extern char* printHex(char *buf, uint num, int nDigits);
