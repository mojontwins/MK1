// MTE MK1 (la Churrera) v3.99.99 (final)
// Copyleft 2010-2017 by the Mojon Twins

void *joyfunc = sp_JoyKeyboard;		// Puntero a la función de manejo seleccionada.
const void *joyfuncs [] = {
	sp_JoyKeyboard, sp_JoyKempston, sp_JoySinclair1
};
unsigned char pad0;

#define KEY_M 0x047f
#define KEY_H 0x10bf
#define KEY_Y 0x10df
#define KEY_Z 0x02fe

void *my_malloc(uint bytes) {
   return sp_BlockAlloc(0);
}

void *u_malloc = my_malloc;
void *u_free = sp_FreeBlock;

// Globales muy globalizadas

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
#define sgni(n)			(n < 0 ? -1 : 1)
#define saturate(n)		(n < 0 ? 0 : n)
#define WTOP 1
#define WBOTTOM 2
#define WLEFT 3
#define WRIGHT 4

// player
signed int px, py, pcx;
signed int pvx, pvy;
signed char pg, pax, prx;
unsigned char psalto, pcont_salto;
unsigned char *pcurrent_frame, *pnext_frame;
unsigned char psaltando;
unsigned char pframe, psubframe, pfacing;
unsigned char pestado;
unsigned char pct_estado;
unsigned char pgotten;
unsigned char plife, pobjs, pkeys;
unsigned char pfuel;
unsigned char pkilled;
unsigned char pdisparando;
unsigned char pfacing_v, pfacing_h;
unsigned char pammo;
unsigned char pkillme;

#define FACING_RIGHT 0
#define FACING_LEFT 2
#define FACING_UP 4
#define FACING_DOWN 6

const unsigned char *spacer = "            ";

unsigned char en_an_base_frame [3];
unsigned char en_an_frame [3];
unsigned char en_an_count [3];
unsigned char *en_an_current_frame [3], *en_an_next_frame [3];
unsigned char en_an_state [3];
	
#ifdef PLAYER_CAN_FIRE
	unsigned char en_an_morido [3];
	#if defined (RANDOM_RESPAWN) || defined (ENABLE_CUSTOM_TYPE_6)
		int en_an_x [3];
		int en_an_y [3];
		int en_an_vx [3];
		int en_an_vy [3];
		unsigned char en_an_fanty_activo [3];
	#endif
#endif
#ifdef ENABLE_PURSUERS
	unsigned char en_an_alive [3];
	unsigned char en_an_dead_row [3];
	unsigned char en_an_rawv [3];
#endif

#define TYPE_6_IDLE 		0
#define TYPE_6_PURSUING		1
#define TYPE_6_RETREATING	2
#define GENERAL_DYING 		4

#ifdef PLAYER_CAN_FIRE
typedef struct {
	unsigned char x;
	unsigned char y;
	char mx;
	char my;
	unsigned char estado;
#ifdef LIMITED_BULLETS
	unsigned char life;
#endif	
} BULLET;

BULLET bullets [MAX_BULLETS];
#endif

// atributos de la pantalla: Contiene información
// sobre qué tipo de tile hay en cada casilla
unsigned char map_attr [150];
unsigned char map_buff [150] @ FREEPOOL;

// posición del objeto (hotspot). Para no objeto,
// se colocan a 240,240, que está siempre fuera de pantalla.
unsigned char hotspot_x;
unsigned char hotspot_y;
unsigned char orig_tile;	// Tile que había originalmente bajo el objeto

unsigned char pant_final;

// Flags para scripting
#ifdef ACTIVATE_SCRIPTING
#define MAX_FLAGS 32
unsigned char flags[MAX_FLAGS];
#endif

// Globalized
unsigned char o_pant;
unsigned char n_pant;
unsigned char level = 0;
unsigned char maincounter;

// Breakable walls/etc
#ifdef BREAKABLE_WALLS
unsigned char *brk_buff = 23296;
#endif

// Fire zone
#ifdef ENABLE_FIRE_ZONE
unsigned char fzx1, fzy1, fzx2, fzy2, f_zone_ac;
#endif

// Timer
#ifdef TIMER_ENABLE
typedef struct {
	unsigned char on;
	unsigned char t;
	unsigned char frames;
	unsigned char count;
	unsigned char zero;
} CTIMER;
CTIMER ctimer;
#endif

#if defined(ACTIVATE_SCRIPTING) && defined(ENABLE_PUSHED_SCRIPTING)
unsigned char just_pushed;
#endif

// Engine globals (for speed) & size!

unsigned char gpx, gpy, gpd, gpc, gpt;
unsigned char gpxx, gpyy, gpcx, gpcy;
unsigned char possee, hit_v, hit_h, hit, wall_h, wall_v;
unsigned char gpen_x, gpen_y, gpen_cx, gpen_cy, gpen_xx, gpen_yy, gpaux;
unsigned char tocado, active;
unsigned char gpit, gpjt;
unsigned char enoffsmasi;
unsigned char *map_pointer;
#ifdef PLAYER_CAN_FIRE
	unsigned char blx, bly;
#endif
unsigned char rdx, rdy;

// More stuff

#ifdef MSC_MAXITEMS
	unsigned char key_z_pressed = 0;
#endif

int itj;
unsigned char objs_old, keys_old, life_old, killed_old;

#ifdef MAX_AMMO
	unsigned char ammo_old;
#endif

#if defined(TIMER_ENABLE) && defined(PLAYER_SHOW_TIMER)
	unsigned char timer_old;
#endif

#ifdef COMPRESSED_LEVELS
	unsigned char *level_str = "LEVEL 0X";
#endif

#ifdef GET_X_MORE
	unsigned char *getxmore = " GET X MORE ";
#endif

unsigned char *allpurposepuntero;
unsigned char playing;
#ifdef COMPRESSED_LEVELS
	unsigned char mlplaying;
#endif	

unsigned char success;
#ifdef PLAYER_CHECK_MAP_BOUNDARIES
	unsigned char x_pant, y_pant;
#endif

// Some declarations

#ifdef ACTIVATE_SCRIPTING
	void  draw_scr_background (void);
	void  draw_scr (void);
#endif
void espera_activa (int espera);
void draw_scr (void);

#ifdef MODE_128K
	void blackout_area (void);
	void get_resource (unsigned char res, unsigned int dest);
	void espera_activa (int espera);
#endif

unsigned char rand (void);
void saca_a_todo_el_mundo_de_aqui (void);
void draw_coloured_tile (unsigned char x, unsigned char y, unsigned char t);

