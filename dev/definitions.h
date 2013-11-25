// Churrera Engine
// ===============
// Copyleft 2010, 2011 by The Mojon Twins

// definitions.h
// Contains type definitions and global variables

struct sp_UDK keys;
void *joyfunc;				// Pointer to the control function selected

void *my_malloc(uint bytes) {
   return sp_BlockAlloc(0);
}

void *u_malloc = my_malloc;
void *u_free = sp_FreeBlock;

// Globalized globals

unsigned char kempston_is_attached;
struct sp_SS *sp_player;
struct sp_SS *sp_moviles [3];
#ifdef PLAYER_CAN_FIRE
struct sp_SS *sp_bullets [MAX_BULLETS];
#endif
struct sp_Rect spritesClipValues;
struct sp_Rect *spritesClip;

unsigned char enoffs;

// Aux

extern char asm_number[1];
extern unsigned int asm_int [1];
extern unsigned int asm_int_2 [1];
extern unsigned int seed [1];
unsigned char half_life;
unsigned char jetpac_frame_counter;

#asm
._asm_number 
	defb 0
._asm_int
	defw 0
._asm_int_2
	defw 0
._seed	
	defw 0
#endasm

#define EST_NORMAL 		0
#define EST_PARP 		2
#define EST_MUR 		4
#define EST_DIZZY		8
#define sgni(n)			(n < 0 ? -1 : 1)
#define min(a,b)		(a < b ? a : b)
#define ctileoff(n) 	(n > 0 ? 1 : 0)
#define saturate(n)		(n < 0 ? 0 : n)

typedef struct {
	int x, y, cx;
	int vx, vy;
	char g, ax, rx;
	unsigned char salto, cont_salto;
	unsigned char *current_frame, *next_frame;
	unsigned char saltando;
	unsigned char frame, subframe, facing;
	unsigned char estado;
	unsigned char ct_estado;
	unsigned char gotten;
	unsigned char life, objs, keys;
	unsigned char fuel;
	unsigned char killed;
	unsigned char disparando;
} INERCIA;

INERCIA player;

typedef struct {
	unsigned char frame;
	unsigned char count;
	unsigned char *current_frame, *next_frame;
#ifdef PLAYER_CAN_FIRE
	unsigned char morido;
#endif
#if defined(RANDOM_RESPAWN) || defined (USE_TYPE_6)
	int x;
	int y;
	int vx;
	int vy;
#ifdef RANDOM_RESPAWN
	unsigned char fanty_activo;
#endif
#ifdef USE_TYPE_6
	unsigned char state;
#endif	
#endif
} ANIMADO;

ANIMADO en_an [3];

#define TYPE_6_IDLE 		0
#define TYPE_6_PURSUING		1
#define TYPE_6_RETREATING	2

#ifdef PLAYER_CAN_FIRE
typedef struct {
	unsigned char x;
	unsigned char y;
	char mx;
	unsigned char estado;
} BULLET;

BULLET bullets [MAX_BULLETS];
#endif

// Tile behaviour array and tile array for the current screen

unsigned char map_attr [150];
unsigned char map_buff [150];

// Hotspot related shortcut variables. hotspot_x and hotspot_y contain
// the pixel coordinates of the current screen hotspot.
// If hotspot is empty / deactivated, they are set to (240, 240),
// which is always out of the screen.

unsigned char hotspot_x;
unsigned char hotspot_y;
unsigned char orig_tile;	// Original background tile

unsigned char pant_final = SCR_FIN;
unsigned char n_pant;

unsigned char f_zone_ac;
unsigned char fzx1, fzx2, fzy1, fzy2;
