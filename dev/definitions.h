struct sp_UDK keys;
void *joyfunc;				// Puntero a la función de manejo seleccionada.

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
	unsigned char facing_v, facing_h;
#ifdef MAX_AMMO
	unsigned char ammo;
#endif	
} INERCIA;

INERCIA player;

#define FACING_RIGHT 0
#define FACING_LEFT 2
#define FACING_UP 4
#define FACING_DOWN 6

typedef struct {
	unsigned char base_frame;
	unsigned char frame;
	unsigned char count;
	unsigned char *current_frame, *next_frame;
	unsigned char state;
	
#ifdef PLAYER_CAN_FIRE
	unsigned char morido;
#if defined (RANDOM_RESPAWN) || defined (ENABLE_CUSTOM_TYPE_6)
	int x;
	int y;
	int vx;
	int vy;
	unsigned char fanty_activo;
#endif
#endif
#ifdef ENABLE_PURSUERS
	unsigned char alive;
	unsigned char dead_row;
	unsigned char rawv;
#endif
} ANIMADO;

ANIMADO en_an [3];

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
} BULLET;

BULLET bullets [MAX_BULLETS];
#endif

// atributos de la pantalla: Contiene información
// sobre qué tipo de tile hay en cada casilla
unsigned char map_attr [150];
unsigned char map_buff [150];

// posición del objeto (hotspot). Para no objeto,
// se colocan a 240,240, que está siempre fuera de pantalla.
unsigned char hotspot_x;
unsigned char hotspot_y;
unsigned char orig_tile;	// Tile que había originalmente bajo el objeto

unsigned char pant_final;

// Flags para scripting
#ifdef ACTIVATE_SCRIPTING
#define MAX_FLAGS 16
unsigned char flags[MAX_FLAGS];
#endif

// Globalized
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

#ifdef ACTIVATE_SCRIPTING
void __FASTCALL__ draw_scr_background (void);
void __FASTCALL__ draw_scr (void);
#endif
void espera_activa (int espera);

#ifdef USE_TWO_BUTTONS
int key_jump, key_fire;
#endif

#ifdef MODE_128K
void blackout_area (void);
void get_resource (unsigned char res, unsigned int dest);
void espera_activa (int espera);
#endif

unsigned char rand (void);
void saca_a_todo_el_mundo_de_aqui (void);
void draw_coloured_tile (unsigned char x, unsigned char y, unsigned char t);
