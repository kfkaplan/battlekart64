extern long ok_Target; //0x80454D04
extern long ok_Source; //0x80454D08
extern long ok_Pointer; //0x80454D0C
extern short ok_TKMChar; //0x80454D10

#define DEG1 0xB6
#define	SegmentOffset(a)	((unsigned int)(a) & 0x00ffffff)
#define	SegmentNumber(a)	(((unsigned int)(a) << 4) >> 28)
#define	SegmentAddress(num, off)	(((num) << 24) + (off))
#define	PhysToK0(x)	((x)|0x80000000)
