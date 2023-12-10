#define BADDIES_COUNT 65

typedef struct {
	int x, y;
	unsigned char x1, y1, x2, y2;
	char mx, my;
	char t;
#ifdef PLAYER_CAN_FIRE
	unsigned char life;
#endif
} MALOTE;

MALOTE malotes [] = {

    {64,80,64,80,64,128,0,2,3},
    {144,128,144,128,144,80,0,-2,3},
    {80,16,80,16,64,16,-1,0,1},
    {80,80,80,80,80,128,0,1,1},
    {64,128,64,128,64,96,0,-1,1},
    {80,16,80,16,192,16,1,0,2},
    {192,112,192,112,32,112,-1,0,4},
    {128,96,128,96,32,96,-1,0,1},
    {0,0,0,0,0,0,0,0,0},
    {16,128,16,128,208,128,2,0,4},
    {176,64,176,64,64,64,-2,0,2},
    {32,16,32,16,32,112,0,2,3},
    {144,16,144,16,160,64,1,1,3},
    {16,128,16,128,192,128,2,0,4},
    {0,0,0,0,0,0,0,0,0},
    {192,112,192,112,32,112,-2,0,4},
    {16,64,16,64,16,64,0,0,3},
    {208,64,208,64,192,64,0,0,3},
    {192,96,192,96,128,96,-2,0,1},
    {64,64,64,64,144,64,1,0,1},
    {80,32,80,32,16,32,-2,0,1},
    {176,96,176,96,48,96,-2,0,3},
    {112,32,112,32,96,32,0,0,1},
    {208,80,208,80,16,80,-2,0,4},
    {96,16,96,16,96,80,0,2,3},
    {128,32,128,32,128,80,0,2,3},
    {160,16,160,16,160,96,0,2,3},
    {48,112,48,112,176,112,2,0,4},
    {160,64,160,64,160,16,0,-2,1},
    {144,80,144,80,16,32,-1,-1,3},
    {208,64,208,64,16,64,-2,0,1},
    {16,96,16,96,208,96,2,0,1},
    {128,112,128,112,96,128,-1,1,3},
    {192,64,192,64,32,64,-2,0,2},
    {64,96,64,96,208,96,1,0,1},
    {16,32,16,32,192,32,4,0,3},
    {208,96,208,96,96,96,-2,0,1},
    {32,64,32,64,176,64,1,0,1},
    {48,16,48,16,144,16,1,0,3},
    {208,80,208,80,112,80,-2,0,4},
    {16,32,16,32,80,32,2,0,2},
    {192,128,192,128,32,128,-2,0,3},
    {160,32,160,32,16,32,-1,0,1},
    {16,96,16,96,208,96,1,0,2},
    {208,16,208,16,176,80,-2,2,3},
    {16,80,16,80,192,80,1,0,1},
    {80,32,80,32,160,32,1,0,1},
    {208,112,208,112,16,128,-1,1,3},
    {208,112,208,112,128,128,-1,1,1},
    {16,112,16,112,96,128,1,1,2},
    {80,80,80,80,144,80,1,0,3},
    {16,112,16,112,144,112,2,0,1},
    {208,80,208,80,176,128,-1,1,3},
    {48,112,48,112,48,16,0,-1,4},
    {32,32,32,32,208,32,2,0,3},
    {176,64,176,64,144,128,-1,1,1},
    {160,144,160,144,16,144,-1,0,4},
    {32,48,32,48,208,48,1,0,1},
    {208,96,208,96,48,96,-1,0,2},
    {160,144,160,144,160,32,0,-2,4},
    {128,128,128,128,128,16,0,-2,4},
    {192,16,192,16,160,16,-1,0,2},
    {80,16,80,16,16,128,-2,2,3},
    {32,16,32,16,32,128,0,1,1},
    {80,128,80,128,176,128,2,0,4},
    {192,32,192,32,192,128,0,2,3},
    {112,16,112,16,112,112,0,1,3},
    {48,48,48,48,48,112,0,2,3},
    {208,32,208,32,208,112,0,2,3},
    {192,16,192,16,192,144,0,2,4},
    {64,96,64,96,176,96,2,0,2},
    {208,16,208,16,208,64,0,1,1},
    {192,128,192,128,192,16,0,-2,4},
    {144,128,144,128,144,64,0,-1,1},
    {96,16,96,16,96,96,0,1,3},
    {80,128,80,128,80,32,0,-1,4},
    {176,128,176,128,176,48,0,-1,4},
    {208,0,208,0,16,32,-1,1,3},
    {32,128,32,128,32,32,0,-2,4},
    {96,128,96,128,96,32,0,-1,4},
    {176,128,176,128,176,48,0,-1,4},
    {208,80,208,80,144,80,-1,0,4},
    {96,112,96,112,96,16,0,-1,4},
    {208,16,208,16,64,32,-1,1,3},
    {208,80,208,80,128,80,-1,0,4},
    {112,64,112,64,16,64,-1,0,4},
    {192,16,192,16,32,32,-1,1,3},
    {160,32,160,32,32,32,-1,0,4},
    {16,32,16,32,16,96,0,1,4},
    {176,80,176,80,32,80,-2,0,3}
};

typedef struct {
	unsigned char xy, tipo, act;
} HOTSPOT;

HOTSPOT hotspots [] = {

    {24,2,0},
    {224,0,0},
    {209,1,0},
    {224,0,0},
    {224,0,0},
    {224,0,0},
    {210,2,0},
    {224,0,0},
    {210,2,0},
    {212,1,0},
    {224,0,0},
    {210,1,0},
    {20,1,0},
    {224,0,0},
    {224,0,0},
    {224,0,0},
    {224,0,0},
    {209,1,0},
    {18,1,0},
    {224,0,0},
    {215,1,0},
    {224,0,0},
    {224,0,0},
    {66,1,0},
    {34,1,0},
    {224,0,0},
    {224,0,0},
    {18,1,0},
    {224,0,0},
    {224,0,0}
};

