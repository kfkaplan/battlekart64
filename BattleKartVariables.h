extern int playerHoldingFlag[];
extern int flag_count[];
extern int flagTimer[];
extern int keepAwayTimer;
extern bool flagDropped[];
extern unsigned char game_paused;
extern float currentFlagPositionsX[];
extern float currentFlagPositionsY[];
extern int singleFlagPositions[][3];
extern int multiFlagPositions[4][20][4][3];
extern int basePositions[4][20][4][3];
extern char game_mode; // game mode, 3=CTF
extern char player_count; //Byte storing number of players (1=1P, 2=2P, 3=3P, 4=4P)
extern char ffa_or_teams; //1 byte, free for all = 0, teams = 1
extern char ctf_game_mode; //1 byte, CTF game mode, 0=1 flag, 1=multiflag
extern char no_items_when_holding_flag; //1 byte, 0=can have item when holding flag, 1=can't have item when holding flag
extern char slow_when_holding_flag; //1 byte, 0=normal speed when holding flag, 1=lightning shrunk when holding flag
extern long text_null;
//extern char bot_rival_p1[4]; //Array that stores bot rivals
extern char BUTTON_ACTIVATOR_1_P1; //P1 Button Activator 1 (see http://www.bsfree.org/hack/hacking_n64.html#activators_button)
extern void incrementScore(int player);
extern int check_if_hit(int player);
extern bool checkHitBomb(int player);
extern int getEnemy(int player);
extern int decrementTimerWrapper(int timer);
extern int killPlayer(int player);
extern void makePlayerBomb(int player);
extern bool ctf_game_started;
extern char lastButtonPressed[4];
//extern void FUNCTION_DISPLAY_TEXT_AND_INT(int x, int y, long text_address, int value);
//extern long FlagModel; //0x08001350 (model for flag)
//extern long BaseModel; //0x08002BC0 (model for base)
extern long FlagOffsets[];
extern long BaseOffsets[];
extern long FlagSpriteOffsets[];
extern long BaseSpriteOffsets[];
extern long BattleFlag;
extern int Characters[];
extern int basePositionSelection;
extern long marioDotSprite;
extern long theMinimapSprites;
extern bool one_player_full_screen;
extern char in_results;
extern bool status_options_widescreen;
extern bool status_options_flatcourses;
extern float course_height; //Stores height of player 1 at course initialization
extern float scaleHeight; //Course scale height (usually 1.0 but near 0  if flat)
extern char in_title_screen; //1 if in title screen, 0 if not
extern long VARIABLE_RAM_BASE; //Store memory location of where all the variables are stored
extern long RAM_END;
extern char MENU_TAB;
extern char MENU_Y_GAME;
extern char MENU_Y_ITEMS;
extern char MENU_Y_BOTS;
extern char MENU_Y_OPTIONS;
extern char insideMenu;


extern bool checkItems(int player);
extern int getTempo();
extern void executeItem(void* Car);
extern void makeBorder();
extern long unsigned int * DrawRectangle(long unsigned int * graphicPointer, int x1, int y1, int x2, int y2, unsigned int r, unsigned int g, unsigned int b, unsigned int transparency);
extern int checkTriangleZX(Bump *bump,float radius,float p1x,float p1y, float p1z, ushort pointer);
extern int checkTriangleXY(Bump *bump,float radius,float p1x,float p1y, float p1z, ushort pointer);
extern int checkTriangleYZ(Bump *bump,float radius,float p1x,float p1y, float p1z, ushort pointer);
extern ushort check_bump(Bump *bump, float radius,float p1x,float p1y, float p1z);
// extern 
// check_bump(BUMP *bump,float radius,float px,float py,float pz)


//Bot stuff
extern unsigned char bot_ai_type;
extern unsigned char bot_status_p1[4];
extern int bot_timer_p1[4];
extern unsigned char bot_steering_p1[4];
extern uint bot_controller_input_p1[4];
extern unsigned char bot_rival_p1[4];
extern short bot_angle_p1[4];
extern void controllerLoop();

// extern bool bot_timer_p1;
// extern bool bot_timer_p2;
// extern bool bot_timer_p3;
// extern bool bot_timer_p4;

