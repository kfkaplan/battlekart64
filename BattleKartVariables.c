#include <stdbool.h>
#include "MinimapSprites/ImageData.h"

int playerHoldingFlag[] = {-1, -1, -1, -1};
int flag_count[] = {0,0,0,0};
int flagTimer[] = {0,0,0,0};
char lastButtonPressed[] = {0x00, 0x00, 0x00, 0x00};
//Store current flag positions (x,y) for showing on minimap
float currentFlagPositionsX[] = {-1,-1,-1,-1};
float currentFlagPositionsHeight[] = {-1,-1,-1,-1};
float currentFlagPositionsY[] = {-1,-1,-1,-1};

bool flagDropped[] = {false, false, false, false};
int basePositionSelection = 0; //Base position locations, 0, 1, or 2 (3 possible choices)
int keepAwayTimer = 0;
int keepAwayBotRunAwayTimer = 0;
int keepAwayBotRunAwayNode = 0;




//Flag spawning positions for single flag
int singleFlagPositions[][3] = {
	{1,4,-483}, //0x00 Mario Raceway
	{20,16,-979}, //0x01 Choco Mountain
	{13,5,-1486}, //0x02 Bowser's Castle
	{-3,17,-527}, //0x03 Banshee Boardwalk
	{-8,185,-559}, //0x04 Yoshi Valley
	{13,4,-562}, //0x05 Frappe Snowland
	{-45,6,-219}, //0x06 Koopa Troopa Beach
	{-68,5,-842}, //0x07 Royal Raceway
	{-140,-44,-456}, //0x08 Luigi Raceway
	{-20,22,-529}, //0x09 Moo Moo Farm
	{76,5,-532}, //0x0A Toad's Turnkpike
	{1,12,178}, //0x0B Kalimari Desert
	{33,5,-242}, //0x0C Sherbert Land
	{524,1004,-5359}, //0x0D Rainbow Road
	{5,13,-321}, //0x0E Wario Stadium
	{0,0,0}, //0x0F Block Fort
	{0,490,0}, //0x10 Skyscraper
	{0,52,0},//0x11 Double Deck
	{9,5,-415}, //0x12 DK's Jungle Parkway
	{-880,232,0}, //0x13 Big Donut
};

//Flag spawning positions for multi flag
//[courseID][flagNumber][x,y,z]
int multiFlagPositions[4][20][4][3] = 
	{
		{//Position 1
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x00 Mario Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x01 Choco Mountain
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x02 Bowser's Castle
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x03 Banshee Boardwalk
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x04 Yoshi Valley
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x05 Frappe Snowland
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x06 Koopa Troopa Beach
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x07 Royal Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x08 Luigi Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x09 Moo Moo Farm
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0A Toad's Turnkpike
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0B Kalimari Desert
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0C Sherbert Land
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0D Rainbow Road
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0E Wario Stadium
			{{0,0,600}, {0,0,-600}, {-600,0,0},  {600,0,0}}, //0x0F Block Fort
			{{0,480,280}, {0,480,-280}, {-280,480,0}, {280,480,0}}, //0x10 Skyscraper
			{{680,0,680}, {-680,0,-680}, {-680,0,680}, {680,0,-680}},  //0x11 Double Deck
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x12 DK's Jungle Parkway
			{{0,203,650}, {0,203,-650}, {-650,203,0,}, {650,203,0}} //0x13 Big Donut
		},
		{//Position 2
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x00 Mario Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x01 Choco Mountain
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x02 Bowser's Castle
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x03 Banshee Boardwalk
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x04 Yoshi Valley
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x05 Frappe Snowland
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x06 Koopa Troopa Beach
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x07 Royal Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x08 Luigi Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x09 Moo Moo Farm
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0A Toad's Turnkpike
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0B Kalimari Desert
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0C Sherbert Land
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0D Rainbow Road
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0E Wario Stadium
			{{650,0,650}, {-650,0,-650}, {-650,0,650}, {650,0,-650}}, //0x0F Block Fort
			{{0,480,470}, {0,480,-470}, {-470,480,0}, {470,480,0}}, //0x10 Skyscraper
			{{300,30,300}, {-300,30,-300}, {-300,30,300}, {300,30,-300}},  //0x11 Double Deck
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x12 DK's Jungle Parkway
			{{663,253,663}, {-663,253,-663}, {-663,253,663}, {663,253,-663}} //0x13 Big Donut
		},
		{//Position 3
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x00 Mario Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x01 Choco Mountain
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x02 Bowser's Castle
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x03 Banshee Boardwalk
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x04 Yoshi Valley
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x05 Frappe Snowland
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x06 Koopa Troopa Beach
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x07 Royal Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x08 Luigi Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x09 Moo Moo Farm
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0A Toad's Turnkpike
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0B Kalimari Desert
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0C Sherbert Land
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0D Rainbow Road
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0E Wario Stadium
			{{500,47,540}, {-500,47,-540}, {-500,47,540}, {500,47,-540}}, //0x0F Block Fort
			{{300,480,300}, {-300,480,-300}, {-300,480,300}, {300,480,-300}}, //0x10 Skyscraper
			{{0,60,670}, {0,60,-670}, {-670,60,0}, {670,60, 0}},  //0x11 Double Deck
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x12 DK's Jungle Parkway
			{{750,210,45}, {620,200,-45}, {620,200,45}, {750,211,-45}} //0x13 Big Donut
		},
		{//Position 4 (custom positions default to position 1)
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x00 Mario Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x01 Choco Mountain
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x02 Bowser's Castle
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x03 Banshee Boardwalk
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x04 Yoshi Valley
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x05 Frappe Snowland
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x06 Koopa Troopa Beach
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x07 Royal Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x08 Luigi Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x09 Moo Moo Farm
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0A Toad's Turnkpike
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0B Kalimari Desert
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0C Sherbert Land
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0D Rainbow Road
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0E Wario Stadium
			{{0,0,600}, {0,0,-600}, {-600,0,0},  {600,0,0}}, //0x0F Block Fort
			{{0,480,280}, {0,480,-280}, {-280,480,0}, {280,480,0}}, //0x10 Skyscraper
			{{680,0,680}, {-680,0,-680}, {-680,0,680}, {680,0,-680}},  //0x11 Double Deck
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x12 DK's Jungle Parkway
			{{0,203,650}, {0,203,-650}, {-650,203,0,}, {650,203,0}} //0x13 Big Donut
		},

	};


//Base spawning positions
//[courseID][baseNumber][x,y,z]
int basePositions[4][20][4][3] = 
	{
		{//Position 1
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x00 Mario Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x01 Choco Mountain
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x02 Bowser's Castle
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x03 Banshee Boardwalk
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x04 Yoshi Valley
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x05 Frappe Snowland
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x06 Koopa Troopa Beach
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x07 Royal Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x08 Luigi Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x09 Moo Moo Farm
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0A Toad's Turnkpike
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0B Kalimari Desert
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0C Sherbert Land
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0D Rainbow Road
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0E Wario Stadium
			{{0,0,630}, {0,0,-630}, {-630,0,0}, {630,0,0}}, //0x0F Block Fort
			{{0,480,310}, {0,480,-310}, {-310,480,0}, {310,480,0}}, //0x10 Skyscraper
			{{710,0,710}, {-710,0,-710}, {-710,0,710}, {710,0,-710}},  //0x11 Double Deck
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x12 DK's Jungle Parkway
			{{0,205,680}, {0,205,-680}, {-680,205,0}, {680,205,0}} //0x13 Big Donut
		},
		{//Position 2
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x00 Mario Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x01 Choco Mountain
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x02 Bowser's Castle
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x03 Banshee Boardwalk
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x04 Yoshi Valley
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x05 Frappe Snowland
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x06 Koopa Troopa Beach
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x07 Royal Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x08 Luigi Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x09 Moo Moo Farm
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0A Toad's Turnkpike
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0B Kalimari Desert
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0C Sherbert Land
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0D Rainbow Road
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0E Wario Stadium
			{{680,0,680}, {-680,0,-680}, {-680,0,680}, {680,0,-680}}, //0x0F Block Fort
			{{0,480,500}, {0,480,-500}, {-500,480,0}, {500,480,0}}, //0x10 Skyscraper
			{{330,30,330}, {-330,30,-330}, {-330,30,330}, {330,30,-330}}, //0x11 Double Deck
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x12 DK's Jungle Parkway
			{{683,253,653}, {-683,253,-653}, {-653,253,683}, {653,253,-683}} //0x13 Big Donut
		},
		{//Position 3
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x00 Mario Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x01 Choco Mountain
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x02 Bowser's Castle
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x03 Banshee Boardwalk
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x04 Yoshi Valley
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x05 Frappe Snowland
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x06 Koopa Troopa Beach
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x07 Royal Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x08 Luigi Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x09 Moo Moo Farm
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0A Toad's Turnkpike
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0B Kalimari Desert
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0C Sherbert Land
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0D Rainbow Road
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0E Wario Stadium
			{{530,47,555}, {-530,47,-555}, {-530,47,555}, {530,47,-555}}, //0x0F Block Fort
			{{330,480,330}, {-330,480,-330}, {-330,480,330}, {330,480,-330}}, //0x10 Skyscraper
			{{0,60,700}, {0,60,-700}, {-700,60,0}, {700,60, 0}},  //0x11 Double Deck
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x12 DK's Jungle Parkway
			{{725,210,30}, {645,203,-30}, {645,203,30}, {725,209,-30}} //0x13 Big Donut
		},
		{//Position 4 (custom start positions defulat to position 1)
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x00 Mario Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x01 Choco Mountain
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x02 Bowser's Castle
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x03 Banshee Boardwalk
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x04 Yoshi Valley
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x05 Frappe Snowland
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x06 Koopa Troopa Beach
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x07 Royal Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x08 Luigi Raceway
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x09 Moo Moo Farm
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0A Toad's Turnkpike
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0B Kalimari Desert
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0C Sherbert Land
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0D Rainbow Road
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x0E Wario Stadium
			{{0,0,630}, {0,0,-630}, {-630,0,0}, {630,0,0}}, //0x0F Block Fort
			{{0,480,310}, {0,480,-310}, {-310,480,0}, {310,480,0}}, //0x10 Skyscraper
			{{710,0,710}, {-710,0,-710}, {-710,0,710}, {710,0,-710}},  //0x11 Double Deck
			{{0,0,0}, {0,0,0}, {0,0,0,}, {0,0,0}}, //0x12 DK's Jungle Parkway
			{{0,205,680}, {0,205,-680}, {-680,205,0}, {680,205,0}} //0x13 Big Donut
		},
	};



const int BlueCoin= 0x080014F0;
const int GoldCoin= 0x08002860;
const int N64Coin= 0x080037B8;
const int RedCoin= 0x08004B20;
const int RedFlag= 0x08005DF8;
const int BlueFlag= 0x080070C8;
const int BowserFlag= 0x08008398;
const int DKFlag= 0x08009668;
const int LuigiFlag= 0x0800A938;
const int MarioFlag= 0x0800BC08;
const int PeachFlag= 0x0800CED8;
const int BattleFlag= 0x0800E1A8;
const int ToadFlag= 0x0800F478;
const int WarioFlag= 0x08010748;
const int YoshiFlag= 0x08011A18;
const int BowserMushroom= 0x080130C0;
const int DKMushroom= 0x08014770;
const int LuigiMushroom= 0x08015E20;
const int MarioMushroom= 0x080174D0;
const int PeachMushroom= 0x08018B80;
const int RedMushroom= 0x0801A230;
const int ToadMushroom= 0x0801B8E0;
const int WarioMushroom= 0x0801CF90;
const int YoshiMushroom= 0x0801E640;
const int TargetMarker= 0x0801F010;
const int SoccerBall= 0x080200C0;




const long marioDotSprite = 0x0D02CCD8;


long FlagOffsets[] = {MarioFlag, LuigiFlag, YoshiFlag, ToadFlag, DKFlag, WarioFlag, PeachFlag,  BowserFlag}; //Pointers to flag models
long BaseOffsets[] = {RedMushroom, LuigiMushroom, YoshiMushroom, ToadMushroom, DKMushroom, WarioMushroom, PeachMushroom, BowserMushroom}; //Pointers to base models]
long FlagSpriteOffsets[] = {FlagIconMario, FlagIconLuigi, FlagIconYoshi, FlagIconToad, FlagIconDK, FlagIconWario, FlagIconPeach,  FlagIconBowser}; //Pointers for minimap flag sprites
long BaseSpriteOFfsets[] = {BaseIconMario, BaseIconLuigi, BaseIconYoshi, BaseIconToad, BaseIconDK, BaseIconwario, BaseIconPeach,  BaseIconBowser}; //Pointers for minimap base sprites
int Characters[] = {0,0,0,0}; //Array holds which characters each player is