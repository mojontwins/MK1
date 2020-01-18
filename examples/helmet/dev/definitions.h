// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

#define FIXBITS 6	// DON'T touch this

#asm
	.vpClipStruct defb VIEWPORT_Y, VIEWPORT_Y + 20, VIEWPORT_X, VIEWPORT_X + 30
	.fsClipStruct defb 0, 24, 0, 32
#endasm	

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

// Safe stuff in low(est) RAM

unsigned char safe_byte @ 23296;

// Globales muy globalizadas

struct sp_SS *sp_player;
struct sp_SS *sp_moviles [3];
#ifdef PLAYER_CAN_FIRE
	struct sp_SS *sp_bullets [MAX_BULLETS];
#endif

unsigned char enoffs;

// Aux

char asm_number;
unsigned int asm_int;
unsigned int asm_int_2;
unsigned int seed;
unsigned char half_life;

#define EST_NORMAL 		0
#define EST_PARP 		2
#define EST_MUR 		4
#define sgni(n)			(n < 0 ? -1 : 1)
#define saturate(n)		(n < 0 ? 0 : n)
#define WTOP 1
#define WBOTTOM 2
#define WLEFT 3
#define WRIGHT 4
#define COORDS(x,y)		((x)+(y<<4)-(y))

// Vertical engine selector 
// for advanced masters of the universe
// with a picha or toto very gordo

#define VENG_KEYS		1
#define VENG_JUMP 		2
#define VENG_BOOTEE		3
#define VENG_JETPAC 	4

#ifdef VENG_SELECTOR 
	unsigned char veng_selector;
#endif

// player
signed int p_x, p_y;
signed int p_vx, p_vy;
signed char p_g, p_ax, p_rx;
unsigned char p_salto, p_cont_salto;
unsigned char *p_current_frame, *p_next_frame;
unsigned char p_saltando;
unsigned char p_frame, p_subframe, p_facing;
unsigned char p_estado;
unsigned char p_ct_estado;
unsigned char p_gotten, pregotten;
unsigned char p_life, p_objs, p_keys;
unsigned char p_fuel;
unsigned char p_killed;
unsigned char p_disparando;
unsigned char p_facing_v, p_facing_h;
unsigned char p_ammo;
unsigned char p_killme;
signed int ptgmx, ptgmy;

#define FACING_RIGHT 0
#define FACING_LEFT 2
#define FACING_UP 4
#define FACING_DOWN 6

const unsigned char *spacer = "            ";

unsigned char enit;

unsigned char en_an_base_frame [3];
unsigned char en_an_frame [3];
unsigned char en_an_count [3];
unsigned char *en_an_current_frame [3], *en_an_next_frame [3];
unsigned char en_an_state [3];
	
#ifdef PLAYER_CAN_FIRE
	unsigned char en_an_morido [3];
#endif

#if defined (ENABLE_FANTIES)
	int en_an_x [3];
	int en_an_y [3];
	int en_an_vx [3];
	int en_an_vy [3];
#endif

#ifdef ENABLE_PURSUERS
	unsigned char en_an_alive [3];
	unsigned char en_an_dead_row [3];
	unsigned char en_an_rawv [3];
#endif

unsigned char _en_x, _en_y;
unsigned char _en_x1, _en_y1, _en_x2, _en_y2;
signed char _en_mx, _en_my;
signed char _en_t;
signed char _en_life;
int _en_an_x, _en_an_y, _en_an_vx, _en_an_vy;
unsigned char *_baddies_pointer;

#if defined PLAYER_CAN_FIRE || defined ENABLE_PURSUERS
	unsigned char _en_cx, _en_cy;
#endif

#define TYPE_6_IDLE 		0
#define TYPE_6_PURSUING		1
#define TYPE_6_RETREATING	2
#define GENERAL_DYING 		4

#ifdef PLAYER_CAN_FIRE
	unsigned char bullets_x [MAX_BULLETS];
	unsigned char bullets_y [MAX_BULLETS];
	char bullets_mx [MAX_BULLETS];
	char bullets_my [MAX_BULLETS];
	unsigned char bullets_estado [MAX_BULLETS];
	#ifdef LIMITED_BULLETS
		unsigned char bullets_life [MAX_BULLETS];
	#endif		

	unsigned char _b_estado;
	unsigned char b_it, _b_x, _b_y;
	signed char _b_mx, _b_my;
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
#ifndef MAX_FLAGS
	#define MAX_FLAGS 16
#endif
unsigned char flags[MAX_FLAGS];

// Globalized
unsigned char o_pant;
unsigned char n_pant;
unsigned char is_rendering;
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

#ifdef FIRE_TO_PUSH	
	unsigned char pushed_any;
#endif	

// Engine globals (for speed) & size!

unsigned char gpx, gpox, gpy, gpd, gpc, gpt;
unsigned char gpxx, gpyy, gpcx, gpcy;
unsigned char possee, hit_v, hit_h, hit, wall_h, wall_v;
unsigned char gpen_x, gpen_y, gpen_cx, gpen_cy, gpaux;
unsigned char tocado, active;
unsigned char gpit, gpjt;
unsigned char enoffsmasi;
unsigned char *map_pointer;
#ifdef PLAYER_CAN_FIRE
	unsigned char blx, bly;
#endif
unsigned char rdx, rdy, rda, rdb, rdc, rdd, rdn;

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

unsigned char *gen_pt;
unsigned char playing;
#ifdef COMPRESSED_LEVELS
	unsigned char mlplaying;
#endif	

unsigned char success;
#ifdef PLAYER_CHECK_MAP_BOUNDARIES
	unsigned char x_pant, y_pant;
#endif

unsigned char _x, _y, _n, _t;
unsigned char cx1, cy1, cx2, cy2, at1, at2;
unsigned char x0, y0, x1, y1;
unsigned char ptx1, pty1, ptx2, pty2;
unsigned char *_gp_gen;

// Some declarations

void draw_scr_background (void);
void draw_scr (void);
void espera_activa (int espera);
void draw_scr (void);
void blackout_area (void);
void get_resource (unsigned char res, unsigned int dest);
void espera_activa (int espera);
unsigned char rand (void);
void clear_sprites (void);
void draw_coloured_tile (void);
void draw_coloured_tile_gamearea (void);
void enems_load (void);
