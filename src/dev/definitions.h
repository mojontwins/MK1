// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

#asm
	.vpClipStruct defb VIEWPORT_Y, VIEWPORT_Y + 20, VIEWPORT_X, VIEWPORT_X + 30
	.fsClipStruct defb 0, 24, 0, 32
#endasm	

//void *joyfunc = sp_JoyKeyboard;		// Puntero a la función de manejo seleccionada.
unsigned int (*joyfunc)(struct sp_UDK *) = sp_JoyKeyboard;

const void *joyfuncs [] = {
	sp_JoyKeyboard, sp_JoyKempston, sp_JoySinclair1
};

unsigned char pad0;
#ifdef USE_TWO_BUTTONS
	unsigned char isJoy;
#endif

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

unsigned char safe_byte 		@ 23296;

unsigned int ram_address 		@ 23297;
unsigned int ram_destination 	@ 23299;

#ifdef MODE_128K
	unsigned char ram_page 		@ 23301;
#endif
	
// Globales muy globalizadas

struct sp_SS *sp_player;
struct sp_SS *sp_moviles [MAX_ENEMS];
#ifdef PLAYER_CAN_FIRE
	struct sp_SS *sp_bullets [MAX_BULLETS];
#endif
#ifdef ENABLE_ORTHOSHOOTERS
	struct sp_SS *sp_cocos [MAX_ENEMS];
#endif

unsigned int enoffs;

// Aux

char asm_number;
unsigned int asm_int 			@ 23302;
unsigned int asm_int_2;
unsigned int seed;
unsigned char half_life;

#define EST_NORMAL 			0
#define EST_PARP 			2
#define EST_MUR 			4
#define sgni(n)				(n < 0 ? -1 : 1)
#define saturate(n)			(n < 0 ? 0 : n)
#define WTOP 				1
#define WBOTTOM 			2
#define WLEFT 				3
#define WRIGHT 				4
#define COORDS(x,y)			((x)+(y<<4)-(y))

// Vertical engine selector 
// for advanced masters of the universe
// with a picha or toto very gordo

#define VENG_KEYS			1
#define VENG_JUMP 			2
#define VENG_BOOTEE			3
#define VENG_JETPAC 		4

#define TYPE_6_IDLE 		0
#define TYPE_6_PURSUING		1
#define TYPE_6_RETREATING	2
#define GENERAL_DYING 		4

#define FACING_RIGHT 		0
#define FACING_LEFT			2
#define FACING_UP 			4
#define FACING_DOWN 		6

#ifdef VENG_SELECTOR 
	unsigned char veng_selector;
#endif

// player
signed int p_x, p_y;
signed int p_vx, p_vy;
unsigned char *p_current_frame, *p_next_frame;
unsigned char p_saltando, p_cont_salto;
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
unsigned char p_kill_amt;
unsigned char p_tx, p_ty;
#ifdef PLAYER_HAS_JETPAC
	unsigned char p_jetpac_on;
#endif
signed int ptgmx, ptgmy;
#ifdef DIE_AND_RESPAWN
	unsigned char safe_n_pant, safe_gpx, safe_gpy;
	#ifndef PLAYER_GENITAL
		unsigned char was_possee;
	#endif
#endif

unsigned char *spacer = "            ";

unsigned char enit;

unsigned char en_an_base_frame [MAX_ENEMS];
unsigned char en_an_frame [MAX_ENEMS];
unsigned char en_an_count [MAX_ENEMS];
unsigned char *en_an_current_frame [MAX_ENEMS], *en_an_next_frame [MAX_ENEMS];
unsigned char en_an_state [MAX_ENEMS];

#if defined (ENABLE_FANTIES)
	int en_an_x [MAX_ENEMS];
	int en_an_y [MAX_ENEMS];
	int en_an_vx [MAX_ENEMS];
	int en_an_vy [MAX_ENEMS];
	int _en_an_x, _en_an_y, _en_an_vx, _en_an_vy;
#endif

#ifdef ENABLE_PURSUERS
	unsigned char en_an_alive [MAX_ENEMS];
	unsigned char en_an_dead_row [MAX_ENEMS];
	unsigned char en_an_rawv [MAX_ENEMS];
#endif

unsigned char _en_x, _en_y;
unsigned char _en_x1, _en_y1, _en_x2, _en_y2;
signed char _en_mx, _en_my;
signed char _en_t;
signed char _en_life;

unsigned char *_baddies_pointer;

#if defined PLAYER_CAN_FIRE || defined ENABLE_PURSUERS
	unsigned char _en_cx, _en_cy;
#endif

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

#ifdef ENABLE_SIMPLE_COCOS
	unsigned char cocos_x [MAX_ENEMS], cocos_y [MAX_ENEMS];
	signed char cocos_mx [MAX_ENEMS], cocos_my [MAX_ENEMS];
#endif

// atributos de la pantalla: Contiene información
// sobre qué tipo de tile hay en cada casilla
unsigned char map_attr [150] @ 23296+16+150;
unsigned char map_buff [150] @ FREEPOOL;
// Breakable walls/etc
#ifdef BREAKABLE_WALLS
	unsigned char brk_buff [150] @ 23296+16;
#endif

// posición del objeto (hotspot). Para no objeto,
// se colocan a 240,240, que está siempre fuera de pantalla.
unsigned char hotspot_x;
unsigned char hotspot_y;
unsigned char hotspot_destroy;
unsigned char orig_tile;	// Tile que había originalmente bajo el objeto

// Flags para scripting
#ifndef MAX_FLAGS
	#define MAX_FLAGS 16
#endif
unsigned char flags[MAX_FLAGS];	

// Globalized
unsigned char o_pant;
unsigned char n_pant;
unsigned char is_rendering;
unsigned char level, slevel;
#ifndef ACTIVATE_SCRIPTING
	unsigned char warp_to_level = 0;
#endif
unsigned char maincounter;

// Fire zone
#ifdef ENABLE_FIRE_ZONE
	unsigned char fzx1, fzy1, fzx2, fzy2, f_zone_ac;
#endif

// Timer
#ifdef TIMER_ENABLE
	unsigned char timer_on;
	unsigned char timer_t;
	unsigned char timer_frames;
	unsigned char timer_count;
	unsigned char timer_zero;
#endif

#if defined(ACTIVATE_SCRIPTING) && defined(ENABLE_PUSHED_SCRIPTING)
	unsigned char just_pushed;
#endif

// Engine globals (for speed) & size!

unsigned char gpx, gpox, gpy, gpd, gpc;
unsigned char gpxx, gpyy, gpcx, gpcy;
unsigned char possee, hit_v, hit_h, hit, wall_h, wall_v;
unsigned char gpen_x, gpen_y, gpen_cx, gpen_cy, gpaux;
unsigned char tocado, active;
unsigned char gpit, gpjt;
unsigned int enoffsmasi;
unsigned char *map_pointer;
#ifdef PLAYER_CAN_FIRE
	unsigned char blx, bly;
#endif
unsigned char rdx, rdy, rda, rdb, rdc, rdd, rdn, rdt;

// More stuff

#ifdef MSC_MAXITEMS
	unsigned char key_z_pressed = 0;
#endif

int itj;
unsigned char objs_old, keys_old, life_old, killed_old;

#ifdef MAX_AMMO
	unsigned char ammo_old;
#endif

#if defined TIMER_ENABLE && TIMER_X != 99
	unsigned char timer_old;
#endif

#ifdef COMPRESSED_LEVELS
	#ifdef LANG_ES
		unsigned char *level_str = "NIVEL 0X";
	#else
	unsigned char *level_str = "LEVEL 0X";
	#endif
	unsigned char silent_level = 0;
#endif

#ifdef GET_X_MORE
	unsigned char *getxmore = " GET X MORE ";
#endif

unsigned char *gen_pt;
unsigned char playing;

unsigned char success;
#ifdef PLAYER_CHECK_MAP_BOUNDARIES
	unsigned char x_pant, y_pant;
#endif

unsigned char _x, _y, _n, _t;
unsigned char cx1, cy1, cx2, cy2, at1, at2;
unsigned char x0, y0, x1, y1;
unsigned char ptx1, pty1, ptx2, pty2, pty2b;
unsigned char *_gp_gen;

#ifdef ENABLE_TILANIMS
	unsigned char tait;
	unsigned char max_tilanims;
	unsigned char tacount;
	unsigned char tilanims_xy [MAX_TILANIMS];
	unsigned char tilanims_ft [MAX_TILANIMS];
#endif

#if defined USE_AUTO_TILE_SHADOWS || defined USE_AUTO_SHADOWS || defined ENABLE_TILANIMS
	unsigned char xx, yy;
#endif

#if defined USE_AUTO_TILE_SHADOWS || defined USE_AUTO_SHADOWS
	unsigned char c1, c2, c3, c4;
	unsigned char t1, t2, t3, t4;
	unsigned char nocast, _ta;
#endif

#ifdef USE_AUTO_TILE_SHADOWS
	unsigned a1, a2, a3;
	unsigned char *gen_pt_alt;
	unsigned char t_alt;
#endif

#if defined ENABLE_SIMPLE_COCOS
	// UP RIGHT DOWN LEFT
	const signed char _dx [] = { 0, COCOS_V, 0, -COCOS_V };
	const signed char _dy [] = { -COCOS_V, 0, COCOS_V, 0 };
#endif

#ifdef MODE_128K
	unsigned char song_playing = 0;
	unsigned char player_on = 1;
#endif

unsigned char isrc;
