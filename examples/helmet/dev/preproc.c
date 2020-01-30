# 1 "mk1.c"

# 26 "c:\z88dk10\include/spritepack.h"
typedef unsigned char uchar;
typedef unsigned int uint;




extern void *u_malloc;
extern void *u_free;
# 133
struct sp_SS {
uchar row;
uchar col;
uchar height;
uchar width;
uchar hor_rot;
uchar ver_rot;
uchar *first;
uchar *last_col;
uchar *last;
uchar plane;
uchar type;
};




struct sp_CS {
uchar *next_in_spr;
uchar *prev;
uchar spr_attr;
uchar *left_graphic;
uchar *graphic;
uchar hor_rot;
uchar colour;
uchar *next;
uchar unused;
};




struct sp_Rect {
uchar row_coord;
uchar col_coord;
uchar height;
uchar width;
};




struct sp_PSS {
struct sp_Rect *bounds;
uchar flags;
uchar x;
uchar y;
uchar colour;
void *dlist;
void *dirtychars;
uchar dirtybit;
};




struct sp_LargeRect {
uint top;
uint bottom;
uint left;
uint right;
};

struct sp_Interval {
uint x1;
uint x2;
};




struct sp_UDK {
uint fire;
uint right;
uint left;
uint down;
uint up;
};




struct sp_MD {
uchar maxcount;
uint dx;
uint dy;
};

struct sp_UDM {
struct sp_UDK *keys;
void *joyfunc;
struct sp_MD **delta;
uchar state;
uchar count;
uint y;
uint x;
};




struct sp_ListNode {
void *item;
struct sp_ListNode *next;
struct sp_ListNode *prev;
};

struct sp_List {
uint count;
uchar state;
struct sp_ListNode *current;
struct sp_ListNode *head;
struct sp_ListNode *tail;
};




struct sp_HashCell {
void *key;
void *value;
struct sp_HashCell *next;
};

struct sp_HashTable {
uint size;
struct sp_HashCell **table;
void *hashfunc;
void *match;
void *delete;
};




struct sp_HuffmanJoin {
union {
uint freq;
void *parent;
} u;
void *left;
void *right;
};

struct sp_HuffmanLeaf {
union {
uint freq;
void *parent;
} u;
uint c;
};

struct sp_HuffmanCodec {
uint symbols;
void *addr;
uchar bit;
void *root;
union {
struct sp_HuffmanLeaf **heap;
struct sp_HuffmanLeaf **encoder;

} u;
};
# 398
extern void __LIB__ sp_InitIM2(void *default_isr);
extern void __LIB__ *sp_InstallISR(uchar vector, void *isr);
extern void __LIB__ sp_EmptyISR(void);
extern void __LIB__ *sp_CreateGenericISR(void *addr);
extern void __LIB__ sp_RegisterHook(uchar vector, void *hook);
extern void __LIB__ sp_RegisterHookFirst(uchar vector, void *hook);
extern void __LIB__ sp_RegisterHookLast(uchar vector, void *hook);
extern int __LIB__ sp_RemoveHook(uchar vector, void *hook);




extern void __LIB__ sp_Initialize(uchar colour, uchar udg);
extern void __LIB__ *sp_SwapEndian(void *ptr);
extern void __LIB__ sp_Swap(void *addr1, void *addr2, uint bytes);
extern int __LIB__ sp_PFill(uint xcoord, uchar ycoord, void *pattern, uint stackdepth);
extern int __LIB__ sp_StackSpace(void *addr);
extern uint __LIB__ sp_Random32(uint *hi);
extern void __LIB__ sp_Border(uchar colour);
extern uchar __LIB__ sp_inp(uint port);
extern void __LIB__ sp_outp(uint port, uchar value);




extern int __LIB__ sp_IntRect(struct sp_Rect *r1, struct sp_Rect *r2, struct sp_Rect *result);
extern int __LIB__ sp_IntLargeRect(struct sp_LargeRect *r1, struct sp_LargeRect *r2, struct sp_LargeRect *result);
extern int __LIB__ sp_IntPtLargeRect(uint x, uint y, struct sp_LargeRect *r);
extern int __LIB__ sp_IntIntervals(struct sp_Interval *i1, struct sp_Interval *i2, struct sp_Interval *result);
extern int __LIB__ sp_IntPtInterval(uint x, struct sp_Interval *i);




extern struct sp_SS __LIB__ *sp_CreateSpr(uchar type, uchar rows, void *graphic);
extern int __LIB__ sp_AddColSpr(struct sp_SS *sprite, void *graphic);
extern void __LIB__ sp_DeleteSpr(struct sp_SS *sprite);
extern void __LIB__ sp_IterateSprChar(struct sp_SS *sprite, void *hook);

extern void __LIB__ sp_RemoveDList(struct sp_SS *sprite);
extern void __LIB__ sp_MoveSprAbs(struct sp_SS *sprite, struct sp_Rect *clip, int animate, uchar row, uchar col, uchar hpix, uchar vpix);
extern void __LIB__ sp_MoveSprAbsC(struct sp_SS *sprite, struct sp_Rect *clip, int animate, uchar row, uchar col, uchar hpix, uchar vpix);
extern void __LIB__ sp_MoveSprAbsNC(struct sp_SS *sprite, struct sp_Rect *clip, int animate, uchar row, uchar col, uchar hpix, uchar vpix);
extern void __LIB__ sp_MoveSprRel(struct sp_SS *sprite, struct sp_Rect *clip, int animate, char rel_row, char rel_col, char rel_hpix, char rel_vpix);
extern void __LIB__ sp_MoveSprRelC(struct sp_SS *sprite, struct sp_Rect *clip, int animate, char rel_row, char rel_col, char rel_hpix, char rel_vpix);
extern void __LIB__ sp_MoveSprRelNC(struct sp_SS *sprite, struct sp_Rect *clip, int animate, char rel_row, char rel_col, char rel_hpix, char rel_vpix);




extern void __LIB__ sp_PrintAt(uchar row, uchar col, uchar colour, uchar udg);
extern void __LIB__ sp_PrintAtInv(uchar row, uchar col, uchar colour, uchar udg);
extern uint __LIB__ sp_ScreenStr(uchar row, uchar col);
extern void __LIB__ sp_PrintAtDiff(uchar row, uchar col, uchar colour, uchar udg);
extern void __LIB__ sp_PrintString(struct sp_PSS *ps, uchar *s);
extern void __LIB__ sp_ComputePos(struct sp_PSS *ps, uchar x, uchar y);
extern void __LIB__ *sp_TileArray(uchar c, void *addr);
extern void __LIB__ *sp_Pallette(uchar c, void *addr);
extern void __LIB__ sp_GetTiles(struct sp_Rect *r, void *dest);
extern void __LIB__ sp_PutTiles(struct sp_Rect *r, void *src);
extern void __LIB__ sp_IterateDList(struct sp_Rect *r, void *hook);
# 464
extern void __LIB__ *sp_AddMemory(uchar queue, uchar number, uint size, void *addr);
extern void __LIB__ *sp_BlockAlloc(uchar queue);
extern void __LIB__ *sp_BlockFit(uchar queue, uchar numcheck);
extern void __LIB__ sp_FreeBlock(void *addr);
extern void __LIB__ sp_InitAlloc(void);
extern uint __LIB__ sp_BlockCount(uchar queue);




extern void __LIB__ sp_Invalidate(struct sp_Rect *area, struct sp_Rect *clip);
extern void __LIB__ sp_Validate(struct sp_Rect *area, struct sp_Rect *clip);
extern void __LIB__ sp_ClearRect(struct sp_Rect *area, uchar colour, uchar udg, uchar flags);
extern void __LIB__ sp_UpdateNow(void);
extern void __LIB__ sp_UpdateNowEx(unsigned char doSprites);
extern void __LIB__ *sp_CompDListAddr(uchar row, uchar col);
extern void __LIB__ *sp_CompDirtyAddr(uchar row, uchar col, uchar *mask);




extern uchar __LIB__ sp_JoySinclair1(void);
extern uchar __LIB__ sp_JoySinclair2(void);
extern uchar __LIB__ sp_JoyTimexEither(void);
extern uchar __LIB__ sp_JoyTimexLeft(void);
extern uchar __LIB__ sp_JoyTimexRight(void);
extern uchar __LIB__ sp_JoyFuller(void);
extern uchar __LIB__ sp_JoyKempston(void);
extern uchar __LIB__ sp_JoyKeyboard(struct sp_UDK *keys);
extern void __LIB__ sp_WaitForKey(void);
extern void __LIB__ sp_WaitForNoKey(void);
extern uint __LIB__ sp_Pause(uint ticks);
extern void __LIB__ sp_Wait(uint ticks);
extern uint __LIB__ sp_LookupKey(uchar c);
extern uchar __LIB__ sp_GetKey(void);
extern uchar __LIB__ sp_Inkey(void);
extern int __LIB__ sp_KeyPressed(uint scancode);
extern void __LIB__ sp_MouseAMXInit(uchar xvector, uchar yvector);
extern void __LIB__ sp_MouseAMX(uint *xcoord, uchar *ycoord, uchar *buttons);
extern void __LIB__ sp_SetMousePosAMX(uint xcoord, uchar ycoord);
extern void __LIB__ sp_MouseKempston(uint *xcoord, uchar *ycoord, uchar *buttons);
extern void __LIB__ sp_SetMousePosKempston(uint xcoord, uchar ycoord);
extern void __LIB__ sp_MouseSim(struct sp_UDM *m, uint *xcoord, uchar *ycoord, uchar *buttons);
extern void __LIB__ sp_SetMousePosSim(struct sp_UDM *m, uint xcoord, uchar ycoord);




extern void __LIB__ *sp_CharDown(void *scrnaddr);
extern void __LIB__ *sp_CharLeft(void *scrnaddr);
extern void __LIB__ *sp_CharRight(void *scrnaddr);
extern void __LIB__ *sp_CharUp(void *scrnaddr);
extern void __LIB__ *sp_GetAttrAddr(void *scrnaddr);
extern void __LIB__ *sp_GetCharAddr(uchar row, uchar col);
extern void __LIB__ *sp_GetScrnAddr(uint xcoord, uchar ycoord, uchar *mask);
extern void __LIB__ *sp_PixelDown(void *scrnaddr);
extern void __LIB__ *sp_PixelUp(void *scrnaddr);
extern void __LIB__ *sp_PixelLeft(void *scrnaddr, uchar *mask);
extern void __LIB__ *sp_PixelRight(void *scrnaddr, uchar *mask);
# 541
extern struct sp_List __LIB__ *sp_ListCreate(void);
extern uint __LIB__ sp_ListCount(struct sp_List *list);
extern void __LIB__ *sp_ListFirst(struct sp_List *list);
extern void __LIB__ *sp_ListLast(struct sp_List *list);
extern void __LIB__ *sp_ListNext(struct sp_List *list);
extern void __LIB__ *sp_ListPrev(struct sp_List *list);
extern void __LIB__ *sp_ListCurr(struct sp_List *list);
extern int __LIB__ sp_ListAdd(struct sp_List *list, void *item);
extern int __LIB__ sp_ListInsert(struct sp_List *list, void *item);
extern int __LIB__ sp_ListAppend(struct sp_List *list, void *item);
extern int __LIB__ sp_ListPrepend(struct sp_List *list, void *item);
extern void __LIB__ *sp_ListRemove(struct sp_List *list);
extern void __LIB__ sp_ListConcat(struct sp_List *list1, struct sp_List *list2);
extern void __LIB__ sp_ListFree(struct sp_List *list, void *free);

extern void __LIB__ *sp_ListTrim(struct sp_List *list);
extern void __LIB__ *sp_ListSearch(struct sp_List *list, void *match, void *item1);
# 563
extern struct sp_HashTable __LIB__ *sp_HashCreate(uint size, void *hashfunc, void *match, void *delete);
extern struct sp_HashCell __LIB__ *sp_HashRemove(struct sp_HashTable *ht, void *key);
extern void __LIB__ *sp_HashLookup(struct sp_HashTable *ht, void *key);
extern void __LIB__ *sp_HashAdd(struct sp_HashTable *ht, void *key, void *value);
extern void __LIB__ sp_HashDelete(struct sp_HashTable *ht);
# 580
extern void __LIB__ sp_Heapify(void **array, uint n, void *compare);
extern void __LIB__ sp_HeapSiftDown(uint start, void **array, uint n, void *compare);
extern void __LIB__ sp_HeapSiftUp(uint start, void **array, void *compare);
extern void __LIB__ sp_HeapAdd(void *item, void **array, uint n, void *compare);
extern void __LIB__ sp_HeapExtract(void **array, uint n, void *compare);
# 612
extern struct sp_HuffmanCodec __LIB__ *sp_HuffCreate(uint symbols);
extern void __LIB__ sp_HuffDelete(struct sp_HuffmanCodec *hc);
extern void __LIB__ sp_HuffAccumulate(struct sp_HuffmanCodec *hc, uchar c);
extern int __LIB__ sp_HuffExtract(struct sp_HuffmanCodec *hc, uint n);

extern void __LIB__ sp_HuffSetState(struct sp_HuffmanCodec *hc, void *addr, uchar bit);
extern void __LIB__ *sp_HuffGetState(struct sp_HuffmanCodec *hc, uchar *bit);
extern uchar __LIB__ sp_HuffDecode(struct sp_HuffmanCodec *hc);
extern void __LIB__ sp_HuffEncode(struct sp_HuffmanCodec *hc, uchar c);
#asm
# 10 "mk1.c"
LIB SPMoveSprAbs
LIB SPPrintAtInv
LIB SPTileArray
LIB SPInvalidate
LIB SPCompDListAddr
#endasm
# 216 "my/config.h"
struct sp_UDK keys = {
0x017f,
0x01df,
0x02df,
0x01fd,
0x01fb
};
# 13 "prototypes.h"
void break_wall (void);


void bullets_init (void);
void bullets_update (void);
void bullets_fire (void);
void bullets_move (void);


void enems_init (void);
void enems_draw_current (void);
void enems_load (void);
void enems_kill (void);
void enems_move (void);


unsigned char collide (void);
unsigned char cm_two_points (void);
unsigned char rand (void);
unsigned int abs (int n);
void step (void);
void cortina (void);


void hotspots_init (void);
void hotspots_do (void);


void player_init (void);
void player_calc_bounding_box (void);
unsigned char player_move (void);
void player_kill (unsigned char sound);


void simple_coco_init (void);
void simple_coco_shoot (void);
void simple_coco_update (void);




void SetRAMBank(void);


void unpack_RAMn (unsigned char n, unsigned int address, unsigned int destination);
void unpack (unsigned int address, unsigned int destination);


void beep_fx (unsigned char n);


void prepare_level (void);
void game_ending (void);
void game_over (void);
void time_over (void);
void pause_screen (void);
signed int addsign (signed int n, signed int value);
void espera_activa (int espera);
void locks_init (void);
char player_hidden (void);
void run_fire_script (void);
void process_tile (void);
void draw_scr_background (void);
void draw_scr (void);
void select_joyfunc (void);
unsigned char mons_col_sc_x (void);
unsigned char mons_col_sc_y (void);
unsigned char distance (void);
int limit (int val, int min, int max);


void blackout (void);


unsigned char attr (unsigned char x, unsigned char y);
unsigned char qtile (unsigned char x, unsigned char y);
void draw_coloured_tile (void);
void invalidate_tile (void);
void invalidate_viewport (void);
void draw_invalidate_coloured_tile_g (void);
void draw_coloured_tile_gamearea (void);
void draw_decorations (void);
void update_tile (void);
void print_number2 (void);
void draw_objs ();
void print_str (void);
void blackout_area (void);
void clear_sprites (void);


void mem_save (void);
void mem_load (void);
void tape_save (void);
void tape_load (void);
void sg_submenu (void);


void add_tilanim (unsigned char x, unsigned char y, unsigned char t);
void do_tilanims (void);


void ISR (void);
void wyz_init (void);
void wyz_play_sound (unsigned char fx_number);
void wyz_play_music (unsigned char song_number);
void wyz_stop_sound (void);

#pragma  output STACKPTR=61936
# 64 "mk1.c"
unsigned char AD_FREE [(40 + ((3 + 3) * 5)) * 15];
#asm
# 5 "definitions.h"
.vpClipStruct defb 1, 1 + 20, 1, 1 + 30
.fsClipStruct defb 0, 24, 0, 32
#endasm


void *joyfunc = sp_JoyKeyboard;

const void *joyfuncs [] = {
sp_JoyKeyboard, sp_JoyKempston, sp_JoySinclair1
};

unsigned char pad0;
# 22
void *my_malloc(uint bytes) {
return sp_BlockAlloc(0);
}

void *u_malloc = my_malloc;
void *u_free = sp_FreeBlock;



unsigned char safe_byte @ 23296;



struct sp_SS *sp_player;
struct sp_SS *sp_moviles [3];

struct sp_SS *sp_bullets [3];


struct sp_SS *sp_cocos [3];


unsigned char enoffs;



char asm_number;
unsigned int asm_int;
unsigned int asm_int_2;
unsigned int seed;
unsigned char half_life;
# 89
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
unsigned char p_tx, p_ty;
signed int ptgmx, ptgmy;

const unsigned char *spacer = "            ";

unsigned char enit;

unsigned char en_an_base_frame [3];
unsigned char en_an_frame [3];
unsigned char en_an_count [3];
unsigned char *en_an_current_frame [3], *en_an_next_frame [3];
unsigned char en_an_state [3];
# 126
unsigned char en_an_alive [3];
unsigned char en_an_dead_row [3];
unsigned char en_an_rawv [3];


unsigned char _en_x, _en_y;
unsigned char _en_x1, _en_y1, _en_x2, _en_y2;
signed char _en_mx, _en_my;
signed char _en_t;
signed char _en_life;

unsigned char *_baddies_pointer;


unsigned char _en_cx, _en_cy;



unsigned char bullets_x [3];
unsigned char bullets_y [3];
char bullets_mx [3];
char bullets_my [3];
unsigned char bullets_estado [3];
# 153
unsigned char _b_estado;
unsigned char b_it, _b_x, _b_y;
signed char _b_mx, _b_my;



unsigned char cocos_x [3], cocos_y [3];
signed char cocos_mx [3], cocos_my [3];




unsigned char map_attr [150];
unsigned char map_buff [150] @ 61697;


unsigned char brk_buff [150] @ 23297;




unsigned char hotspot_x;
unsigned char hotspot_y;
unsigned char orig_tile;
# 182
unsigned char flags[2];


unsigned char o_pant;
unsigned char n_pant;
unsigned char is_rendering;
unsigned char level = 0;

unsigned char warp_to_level = 0;

unsigned char maincounter;
# 213
unsigned char pushed_any;




unsigned char gpx, gpox, gpy, gpd, gpc, gpt;
unsigned char gpxx, gpyy, gpcx, gpcy;
unsigned char possee, hit_v, hit_h, hit, wall_h, wall_v;
unsigned char gpen_x, gpen_y, gpen_cx, gpen_cy, gpaux;
unsigned char tocado, active;
unsigned char gpit, gpjt;
unsigned char enoffsmasi;
unsigned char *map_pointer;

unsigned char blx, bly;

unsigned char rdx, rdy, rda, rdb, rdc, rdd, rdn;
# 237
int itj;
unsigned char objs_old, keys_old, life_old, killed_old;


unsigned char ammo_old;
# 249
unsigned char *level_str = "LEVEL 0X";
# 256
unsigned char *gen_pt;
unsigned char playing;

unsigned char success;
# 264
unsigned char _x, _y, _n, _t;
unsigned char cx1, cy1, cx2, cy2, at1, at2;
unsigned char x0, y0, x1, y1;
unsigned char ptx1, pty1, ptx2, pty2;
unsigned char *_gp_gen;



const signed char _dx [] = { 0, 8, 0, -8 };
const signed char _dy [] = { -8, 0, 8, 0 };
# 4 "my/ci/extra_vars.h"
unsigned char decos_computer [] = { 0x63, 32, 0x73, 33, 0x83, 34, 0x64, 36, 0x74, 37, 0x84, 38, 0xff };
unsigned char decos_bombs [] = { 0x44, 17, 0x42, 17, 0x71, 17, 0xA2, 17, 0xA4, 17, 0xff };
unsigned char decos_moto [] = { 0x13, 40, 0x23, 41, 0xff };
# 4 "aplib.h"
unsigned int ram_address;
unsigned int ram_destination;
#asm
# 13
; aPPack decompressor
; original source by dwedit
; very slightly adapted by utopian
; optimized by Metalbrain

;hl = source
;de = dest

.depack ld ixl,128
.apbranch1 ldi
.aploop0 ld ixh,1 ;LWM = 0
.aploop call ap_getbit
jr nc,apbranch1
call ap_getbit
jr nc,apbranch2
ld b,0
call ap_getbit
jr nc,apbranch3
ld c,16 ;get an offset
.apget4bits call ap_getbit
rl c
jr nc,apget4bits
jr nz,apbranch4
ld a,b
.apwritebyte ld (de),a ;write a 0
inc de
jr aploop0
.apbranch4 and a
ex de,hl ;write a previous byte (1-15 away from dest)
sbc hl,bc
ld a,(hl)
add hl,bc
ex de,hl
jr apwritebyte
.apbranch3 ld c,(hl) ;use 7 bit offset, length = 2 or 3
inc hl
rr c
ret z ;if a zero is encountered here, it is EOF
ld a,2
adc a,b
push hl
ld iyh,b
ld iyl,c
ld h,d
ld l,e
sbc hl,bc
ld c,a
jr ap_finishup2
.apbranch2 call ap_getgamma ;use a gamma code * 256 for offset, another gamma code for length
dec c
ld a,c
sub ixh
jr z,ap_r0_gamma ;if gamma code is 2, use old r0 offset,
dec a
;do I even need this code?
;bc=bc*256+(hl), lazy 16bit way
ld b,a
ld c,(hl)
inc hl
ld iyh,b
ld iyl,c

push bc

call ap_getgamma

ex (sp),hl ;bc = len, hl=offs
push de
ex de,hl

ld a,4
cp d
jr nc,apskip2
inc bc
or a
.apskip2 ld hl,127
sbc hl,de
jr c,apskip3
inc bc
inc bc
.apskip3 pop hl ;bc = len, de = offs, hl=junk
push hl
or a
.ap_finishup sbc hl,de
pop de ;hl=dest-offs, bc=len, de = dest
.ap_finishup2 ldir
pop hl
ld ixh,b
jr aploop

.ap_r0_gamma call ap_getgamma ;and a new gamma code for length
push hl
push de
ex de,hl

ld d,iyh
ld e,iyl
jr ap_finishup


.ap_getbit ld a,ixl
add a,a
ld ixl,a
ret nz
ld a,(hl)
inc hl
rla
ld ixl,a
ret

.ap_getgamma ld bc,1
.ap_getgammaloop call ap_getbit
rl c
rl b
call ap_getbit
jr c,ap_getgammaloop
ret
#endasm
#asm
#endasm
# 158
void unpack (unsigned int address, unsigned int destination) {
ram_address = address; ram_destination = destination;
#asm

ld hl, (_ram_address)
ld de, (_ram_destination)
call depack
#endasm

}
# 9 "pantallas.h"
extern unsigned char s_title [];
extern unsigned char s_marco [];
extern unsigned char s_ending [];
#asm


._s_title
BINARY "title.bin"
._s_marco
#endasm
#asm
#endasm
#asm
# 24
._s_ending
BINARY "ending.bin"
#endasm



void blackout (void) {
#asm

ld hl, 22528
ld (hl), 0
push hl
pop de
inc de
ld bc, 767
ldir
#endasm

}
# 29 "assets/levels.h"
typedef struct {
unsigned char map_w, map_h;
unsigned char scr_ini, ini_x, ini_y;
unsigned char max_objs;
unsigned char enems_life;
unsigned char d01;
unsigned char d02;
unsigned char d03;
unsigned char d04;
unsigned char d05;
unsigned char d06;
unsigned char d07;
unsigned char d08;
unsigned char d09;
} LEVELHEADER;

typedef struct {
unsigned char np, x, y, st;
} CERROJOS;

typedef struct {
unsigned char x, y;
unsigned char x1, y1, x2, y2;
char mx, my;
unsigned char t, life;
} MALOTE;

typedef struct {
unsigned char xy, tipo, act;
} HOTSPOT;



extern LEVELHEADER level_data [0];
#asm

._level_data defs 16
#endasm


extern unsigned char mapa [0];
#asm
#endasm
#asm
# 74
._mapa defs 1 * 24 * 75
#endasm



extern CERROJOS cerrojos [0];
#asm

._cerrojos defs 128 ; 32 * 4
#endasm


extern unsigned char tileset [0];
#asm

._tileset BINARY "tileset.bin"
#endasm


extern MALOTE malotes [0];
#asm

._malotes defs 1 * 24 * 3 * 10
#endasm


extern HOTSPOT hotspots [0];
#asm

._hotspots defs 1 * 24 * 3
#endasm


extern unsigned char behs [0];
#asm

._behs defs 48
#endasm


extern unsigned char sprites [0];
#asm

._sprites
#endasm
# 8 "./assets/sprites.h"
extern unsigned char sprite_1_a [];
extern unsigned char sprite_1_b [];
extern unsigned char sprite_1_c [];
extern unsigned char sprite_2_a [];
extern unsigned char sprite_2_b [];
extern unsigned char sprite_2_c [];
extern unsigned char sprite_3_a [];
extern unsigned char sprite_3_b [];
extern unsigned char sprite_3_c [];
extern unsigned char sprite_4_a [];
extern unsigned char sprite_4_b [];
extern unsigned char sprite_4_c [];
extern unsigned char sprite_5_a [];
extern unsigned char sprite_5_b [];
extern unsigned char sprite_5_c [];
extern unsigned char sprite_6_a [];
extern unsigned char sprite_6_b [];
extern unsigned char sprite_6_c [];
extern unsigned char sprite_7_a [];
extern unsigned char sprite_7_b [];
extern unsigned char sprite_7_c [];
extern unsigned char sprite_8_a [];
extern unsigned char sprite_8_b [];
extern unsigned char sprite_8_c [];
extern unsigned char sprite_9_a [];
extern unsigned char sprite_9_b [];
extern unsigned char sprite_9_c [];
extern unsigned char sprite_10_a [];
extern unsigned char sprite_10_b [];
extern unsigned char sprite_10_c [];
extern unsigned char sprite_11_a [];
extern unsigned char sprite_11_b [];
extern unsigned char sprite_11_c [];
extern unsigned char sprite_12_a [];
extern unsigned char sprite_12_b [];
extern unsigned char sprite_12_c [];
extern unsigned char sprite_13_a [];
extern unsigned char sprite_13_b [];
extern unsigned char sprite_13_c [];
extern unsigned char sprite_14_a [];
extern unsigned char sprite_14_b [];
extern unsigned char sprite_14_c [];
extern unsigned char sprite_15_a [];
extern unsigned char sprite_15_b [];
extern unsigned char sprite_15_c [];
extern unsigned char sprite_16_a [];
extern unsigned char sprite_16_b [];
extern unsigned char sprite_16_c [];
#asm


defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_1_a
defb 0, 224
defb 15, 192
defb 30, 192
defb 31, 192
defb 31, 192
defb 28, 192
defb 5, 0
defb 58, 0
defb 96, 0
defb 118, 0
defb 52, 0
defb 1, 0
defb 5, 224
defb 5, 224
defb 0, 224
defb 5, 224
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_1_b
defb 0, 63
defb 128, 31
defb 192, 31
defb 64, 7
defb 240, 7
defb 0, 7
defb 192, 7
defb 0, 0
defb 254, 0
defb 194, 0
defb 24, 0
defb 0, 0
defb 128, 31
defb 128, 31
defb 0, 31
defb 192, 31
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_1_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_2_a
defb 0, 255
defb 0, 224
defb 15, 192
defb 30, 192
defb 31, 192
defb 31, 192
defb 4, 128
defb 27, 128
defb 48, 128
defb 59, 128
defb 26, 128
defb 1, 128
defb 44, 128
defb 44, 128
defb 32, 128
defb 0, 128
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_2_b
defb 0, 255
defb 0, 63
defb 128, 31
defb 192, 15
defb 64, 7
defb 240, 7
defb 0, 7
defb 128, 0
defb 127, 0
defb 97, 0
defb 12, 0
defb 192, 0
defb 192, 15
defb 0, 15
defb 224, 15
defb 0, 15
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_2_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_3_a
defb 0, 252
defb 1, 248
defb 3, 248
defb 2, 224
defb 15, 224
defb 0, 224
defb 3, 224
defb 0, 0
defb 127, 0
defb 67, 0
defb 24, 0
defb 0, 0
defb 1, 248
defb 1, 248
defb 0, 248
defb 3, 248
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_3_b
defb 0, 7
defb 240, 3
defb 120, 3
defb 248, 3
defb 248, 3
defb 56, 3
defb 160, 0
defb 92, 0
defb 6, 0
defb 110, 0
defb 44, 0
defb 128, 0
defb 160, 7
defb 160, 7
defb 0, 7
defb 160, 7
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_3_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_4_a
defb 0, 255
defb 0, 252
defb 1, 248
defb 3, 240
defb 2, 224
defb 15, 224
defb 0, 224
defb 1, 0
defb 254, 0
defb 134, 0
defb 48, 0
defb 3, 0
defb 3, 240
defb 0, 240
defb 7, 240
defb 0, 240
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_4_b
defb 0, 255
defb 0, 7
defb 240, 3
defb 120, 3
defb 248, 3
defb 248, 3
defb 32, 1
defb 216, 1
defb 12, 1
defb 220, 1
defb 88, 1
defb 128, 1
defb 52, 1
defb 52, 1
defb 4, 1
defb 0, 1
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_4_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_5_a
defb 0, 240
defb 7, 224
defb 13, 224
defb 11, 224
defb 15, 224
defb 7, 128
defb 40, 0
defb 111, 0
defb 110, 0
defb 53, 0
defb 0, 128
defb 6, 240
defb 0, 240
defb 0, 254
defb 0, 254
defb 0, 254
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_5_b
defb 0, 31
defb 192, 15
defb 224, 1
defb 236, 1
defb 236, 1
defb 204, 0
defb 50, 0
defb 126, 0
defb 236, 0
defb 192, 1
defb 12, 1
defb 204, 1
defb 192, 1
defb 0, 31
defb 192, 31
defb 0, 31
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_5_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_6_a
defb 0, 240
defb 7, 224
defb 13, 224
defb 11, 224
defb 15, 224
defb 7, 128
defb 40, 0
defb 111, 0
defb 110, 0
defb 53, 0
defb 0, 128
defb 6, 240
defb 6, 240
defb 0, 240
defb 6, 240
defb 0, 240
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_6_b
defb 0, 31
defb 192, 15
defb 224, 1
defb 236, 1
defb 236, 1
defb 204, 0
defb 50, 0
defb 126, 0
defb 236, 0
defb 192, 0
defb 12, 1
defb 204, 1
defb 0, 1
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_6_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_7_a
defb 0, 248
defb 3, 240
defb 6, 240
defb 5, 240
defb 7, 192
defb 16, 192
defb 27, 192
defb 24, 0
defb 89, 0
defb 91, 0
defb 88, 0
defb 27, 0
defb 3, 192
defb 24, 192
defb 3, 192
defb 0, 248
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_7_b
defb 0, 15
defb 224, 7
defb 240, 7
defb 240, 7
defb 240, 7
defb 0, 3
defb 232, 1
defb 12, 1
defb 124, 1
defb 120, 1
defb 0, 3
defb 96, 15
defb 0, 15
defb 0, 127
defb 0, 127
defb 0, 127
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_7_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_8_a
defb 0, 248
defb 3, 240
defb 6, 240
defb 5, 240
defb 7, 192
defb 16, 192
defb 27, 192
defb 24, 0
defb 89, 0
defb 91, 0
defb 88, 0
defb 27, 0
defb 0, 192
defb 24, 195
defb 0, 195
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_8_b
defb 0, 15
defb 224, 7
defb 240, 7
defb 240, 7
defb 240, 7
defb 0, 3
defb 232, 1
defb 12, 1
defb 124, 1
defb 120, 1
defb 0, 3
defb 96, 15
defb 96, 15
defb 0, 15
defb 96, 15
defb 0, 15
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_8_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_9_a
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 224
defb 14, 192
defb 31, 128
defb 59, 128
defb 49, 128
defb 0, 132
defb 0, 254
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_9_b
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 225
defb 12, 65
defb 28, 1
defb 184, 1
defb 240, 3
defb 224, 7
defb 0, 15
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_9_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_10_a
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 135
defb 48, 130
defb 56, 128
defb 29, 128
defb 15, 192
defb 7, 224
defb 0, 240
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_10_b
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 7
defb 112, 3
defb 248, 1
defb 220, 1
defb 140, 1
defb 0, 33
defb 0, 127
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_10_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_11_a
defb 0, 255
defb 0, 248
defb 3, 248
defb 3, 248
defb 1, 248
defb 0, 252
defb 0, 254
defb 0, 252
defb 1, 248
defb 3, 248
defb 3, 248
defb 3, 248
defb 1, 248
defb 0, 252
defb 0, 254
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_11_b
defb 0, 255
defb 0, 127
defb 0, 63
defb 128, 31
defb 192, 15
defb 224, 15
defb 96, 15
defb 224, 15
defb 192, 15
defb 128, 31
defb 0, 63
defb 128, 31
defb 192, 31
defb 192, 31
defb 0, 31
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_11_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_12_a
defb 0, 255
defb 0, 254
defb 0, 252
defb 1, 248
defb 3, 240
defb 3, 240
defb 3, 240
defb 1, 240
defb 0, 240
defb 0, 248
defb 0, 252
defb 1, 248
defb 3, 248
defb 3, 248
defb 0, 248
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_12_b
defb 0, 255
defb 0, 31
defb 192, 31
defb 192, 31
defb 128, 31
defb 0, 63
defb 128, 127
defb 192, 63
defb 224, 31
defb 96, 31
defb 224, 31
defb 192, 31
defb 128, 31
defb 0, 63
defb 0, 127
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_12_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_13_a
defb 0, 255
defb 0, 248
defb 3, 240
defb 5, 240
defb 7, 192
defb 20, 128
defb 49, 128
defb 34, 128
defb 53, 128
defb 48, 128
defb 7, 128
defb 3, 240
defb 0, 248
defb 3, 248
defb 0, 248
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_13_b
defb 0, 255
defb 0, 31
defb 192, 15
defb 224, 3
defb 232, 1
defb 44, 1
defb 68, 1
defb 172, 1
defb 76, 1
defb 0, 1
defb 96, 15
defb 0, 15
defb 0, 127
defb 0, 127
defb 0, 127
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_13_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_14_a
defb 0, 255
defb 0, 248
defb 3, 240
defb 5, 192
defb 23, 128
defb 52, 128
defb 34, 128
defb 53, 128
defb 50, 128
defb 0, 128
defb 6, 240
defb 0, 240
defb 0, 254
defb 0, 254
defb 0, 254
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_14_b
defb 0, 255
defb 0, 31
defb 192, 15
defb 224, 15
defb 224, 3
defb 40, 1
defb 140, 1
defb 68, 1
defb 172, 1
defb 12, 1
defb 224, 1
defb 192, 15
defb 0, 31
defb 192, 31
defb 0, 31
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_14_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_15_a
defb 0, 240
defb 7, 224
defb 13, 224
defb 14, 224
defb 15, 224
defb 0, 128
defb 55, 0
defb 112, 0
defb 100, 0
defb 83, 0
defb 48, 0
defb 6, 128
defb 6, 240
defb 0, 240
defb 6, 240
defb 0, 240
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_15_b
defb 0, 31
defb 192, 15
defb 96, 15
defb 224, 15
defb 224, 15
defb 0, 15
defb 192, 3
defb 24, 1
defb 92, 1
defb 140, 1
defb 20, 1
defb 216, 1
defb 0, 3
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_15_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_16_a
defb 0, 248
defb 3, 240
defb 6, 240
defb 7, 240
defb 7, 240
defb 0, 240
defb 3, 192
defb 24, 128
defb 58, 128
defb 49, 128
defb 40, 128
defb 27, 128
defb 0, 192
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_16_b
defb 0, 15
defb 224, 7
defb 176, 7
defb 112, 7
defb 240, 7
defb 0, 1
defb 236, 0
defb 14, 0
defb 38, 0
defb 202, 0
defb 12, 0
defb 96, 1
defb 96, 15
defb 0, 15
defb 96, 15
defb 0, 15
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255

._sprite_16_c
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
defb 0, 255
#endasm
# 12 "assets/extrasprites.h"
extern unsigned char sprite_17_a [];


extern unsigned char sprite_18_a [];


extern unsigned char sprite_19_a [];
extern unsigned char sprite_19_b [];
#asm




._sprite_17_a
BINARY "sprites_extra.bin"
#endasm
#asm




._sprite_18_a
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255

._sprite_18_b
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255

._sprite_18_c
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255
defb 0, 255, 0, 255, 0, 255, 0, 255
#endasm
#asm




._sprite_19_a
BINARY "sprites_bullet.bin"
#endasm
# 19 "my/levelset.h"
typedef struct {
unsigned char map_w, map_h;
unsigned char scr_ini, ini_x, ini_y;
unsigned char max_objs;
unsigned char *c_map_bolts;
unsigned char *c_tileset;
unsigned char *c_enems_hotspots;
unsigned char *c_behs;
# 33
} LEVEL;




extern unsigned char map_bolts_0 [0];
extern unsigned char map_bolts_1 [0];
extern unsigned char map_bolts_2 [0];
extern unsigned char tileset_0 [0];
extern unsigned char tileset_1 [0];
extern unsigned char tileset_2 [0];
extern unsigned char enems_hotspots_0 [0];
extern unsigned char enems_hotspots_1 [0];
extern unsigned char enems_hotspots_2 [0];
extern unsigned char behs_0_1 [0];
extern unsigned char behs_2 [0];
#asm


._map_bolts_0
BINARY "../bin/mapa_bolts0c.bin"
._map_bolts_1
BINARY "../bin/mapa_bolts1c.bin"
._map_bolts_2
BINARY "../bin/mapa_bolts2c.bin"
._tileset_0
BINARY "../bin/tileset0c.bin"
._tileset_1
BINARY "../bin/tileset1c.bin"
._tileset_2
BINARY "../bin/tileset2c.bin"
._enems_hotspots_0
BINARY "../bin/enems_hotspots0c.bin"
._enems_hotspots_1
BINARY "../bin/enems_hotspots1c.bin"
._enems_hotspots_2
BINARY "../bin/enems_hotspots2c.bin"
._behs_0_1
BINARY "../bin/behs0_1c.bin"
._behs_2
BINARY "../bin/behs2c.bin"
#endasm




LEVEL levels [] = {
{ 1, 24, 23, 12, 7, 99, map_bolts_0, tileset_0, enems_hotspots_0, behs_0_1 },
{ 1, 24, 23, 12, 7, 99, map_bolts_1, tileset_1, enems_hotspots_1, behs_0_1 },
{ 1, 24, 23, 6, 8, 99, map_bolts_2, tileset_2, enems_hotspots_2, behs_2 }
};
#asm
# 5 "beeper.h"
;org 60000

;BeepFX player by Shiru
;You are free to do whatever you want with this code



.playBasic
ld a,0
.sound_play
ld hl,sfxData ;address of sound effects data

;di
push ix
push iy

ld b,0
ld c,a
add hl,bc
add hl,bc
ld e,(hl)
inc hl
ld d,(hl)
push de
pop ix ;put it into ix

ld a,(23624) ;get border color from BASIC vars to keep it unchanged
rra
rra
rra
and 7
ld (sfxRoutineToneBorder +1),a
ld (sfxRoutineNoiseBorder +1),a
ld (sfxRoutineSampleBorder+1),a


.readData
ld a,(ix+0) ;read block type
ld c,(ix+1) ;read duration 1
ld b,(ix+2)
ld e,(ix+3) ;read duration 2
ld d,(ix+4)
push de
pop iy

dec a
jr z,sfxRoutineTone
dec a
jr z,sfxRoutineNoise
dec a
jr z,sfxRoutineSample
pop iy
pop ix
;ei
ret



;play sample

.sfxRoutineSample
ex de,hl
.sfxRS0
ld e,8
ld d,(hl)
inc hl
.sfxRS1
ld a,(ix+5)
.sfxRS2
dec a
jr nz,sfxRS2
rl d
sbc a,a
and 16
.sfxRoutineSampleBorder
or 0
out (254),a
dec e
jr nz,sfxRS1
dec bc
ld a,b
or c
jr nz,sfxRS0

ld c,6

.nextData
add ix,bc ;skip to the next block
jr readData



;generate tone with many parameters

.sfxRoutineTone
ld e,(ix+5) ;freq
ld d,(ix+6)
ld a,(ix+9) ;duty
ld (sfxRoutineToneDuty+1),a
ld hl,0

.sfxRT0
push bc
push iy
pop bc
.sfxRT1
add hl,de
ld a,h
.sfxRoutineToneDuty
cp 0
sbc a,a
and 16
.sfxRoutineToneBorder
or 0
out (254),a

dec bc
ld a,b
or c
jr nz,sfxRT1

ld a,(sfxRoutineToneDuty+1) ;duty change
add a,(ix+10)
ld (sfxRoutineToneDuty+1),a

ld c,(ix+7) ;slide
ld b,(ix+8)
ex de,hl
add hl,bc
ex de,hl

pop bc
dec bc
ld a,b
or c
jr nz,sfxRT0

ld c,11
jr nextData



;generate noise with two parameters

.sfxRoutineNoise
ld e,(ix+5) ;pitch

ld d,1
ld h,d
ld l,d
.sfxRN0
push bc
push iy
pop bc
.sfxRN1
ld a,(hl)
and 16
.sfxRoutineNoiseBorder
or 0
out (254),a
dec d
jr nz,sfxRN2
ld d,e
inc hl
ld a,h
and 31
ld h,a
.sfxRN2
dec bc
ld a,b
or c
jr nz,sfxRN1

ld a,e
add a,(ix+6) ;slide
ld e,a

pop bc
dec bc
ld a,b
or c
jr nz,sfxRN0

ld c,7
jr nextData


.sfxData

.SoundEffectsData
defw SoundEffect0Data
defw SoundEffect1Data
defw SoundEffect2Data
defw SoundEffect3Data
defw SoundEffect4Data
defw SoundEffect5Data
defw SoundEffect6Data
defw SoundEffect7Data
defw SoundEffect8Data
defw SoundEffect9Data

.SoundEffect0Data
defb 2 ;noise
defw 8,200,20
defb 2 ;noise
defw 4,2000,5220
defb 0
.SoundEffect1Data
defb 2 ;noise
defw 1,1000,10
defb 2 ;noise
defw 1,1000,1
defb 0
.SoundEffect2Data
defb 1 ;tone
defw 50,100,200,65531,128
defb 0
.SoundEffect3Data
defb 1 ;tone
defw 100,20,500,2,128
defb 0
.SoundEffect4Data
defb 2 ;noise
defw 1,1000,20
defb 1 ;pause
defw 1,1000,0,0,0
defb 2 ;noise
defw 1,1000,1
defb 0
.SoundEffect5Data
defb 1 ;tone
defw 50,200,500,65516,128
defb 0
.SoundEffect6Data
defb 2 ;noise
defw 20,50,257
defb 0
.SoundEffect7Data
defb 1 ;tone
defw 1,1000,2000,0,64
defb 1 ;pause
defw 1,1000,0,0,0
defb 1 ;tone
defw 1,1000,1500,0,64
defb 0
.SoundEffect8Data
defb 2 ;noise
defw 2,2000,32776
defb 0
.SoundEffect9Data
defb 1 ;tone
defw 4,1000,1000,400,128
defb 0
#endasm


void beep_fx (unsigned char n) {

asm_int = n;
#asm

push ix
push iy
ld a, (_asm_int)
call sound_play
pop ix
pop iy
#endasm

}
# 6 "printer.h"
unsigned char attr (unsigned char x, unsigned char y) {
if (x >= 14 || y >= 10) return 0;
return map_attr [x + (y << 4) - y];
}

unsigned char qtile (unsigned char x, unsigned char y) {
return map_buff [x + (y << 4) - y];
}

void draw_coloured_tile (void) {
#asm
#endasm
#asm
#endasm
#asm
#endasm
#asm
#endasm
#asm
#endasm
#asm
#endasm
#asm
#endasm
#asm
#endasm
#asm
#endasm
#asm
#endasm
#asm
#endasm
#asm
#endasm
#asm
# 390
ld a, (__x)
ld c, a
ld a, (__y)
call SPCompDListAddr
ex de, hl




ld a, (__t)
sla a
sla a
add 64

ld hl, _tileset + 2048
ld b, 0
ld c, a
add hl, bc

ld c, a



ld a, (hl)
ld (de), a
inc de
inc hl

ld a, c
ld (de), a
inc de
inc a
ld c, a

inc de
inc de

ld a, (hl)
ld (de), a
inc de
inc hl

ld a, c
ld (de), a
inc a

ex de, hl
ld bc, 123
add hl, bc
ex de, hl
ld c, a

ld a, (hl)
ld (de), a
inc de
inc hl

ld a, c
ld (de), a
inc de
inc a
ld c, a

inc de
inc de

ld a, (hl)
ld (de), a
inc de

ld a, c
ld (de), a
#endasm


}

void invalidate_tile (void) {
#asm

; Invalidate Rectangle
;
; enter: B = row coord top left corner
; C = col coord top left corner
; D = row coord bottom right corner
; E = col coord bottom right corner
; IY = clipping rectangle, set it to "ClipStruct" for full screen

ld a, (__x)
ld c, a
inc a
ld e, a
ld a, (__y)
ld b, a
inc a
ld d, a
ld iy, fsClipStruct
call SPInvalidate
#endasm

}

void invalidate_viewport (void) {
#asm

; Invalidate Rectangle
;
; enter: B = row coord top left corner
; C = col coord top left corner
; D = row coord bottom right corner
; E = col coord bottom right corner
; IY = clipping rectangle, set it to "ClipStruct" for full screen

ld b, 1
ld c, 1
ld d, 1+19
ld e, 1+29
ld iy, vpClipStruct
call SPInvalidate
#endasm

}

void draw_invalidate_coloured_tile_g (void) {
draw_coloured_tile_gamearea ();
invalidate_tile ();
}

void draw_coloured_tile_gamearea (void) {
_x = 1 + (_x << 1); _y = 1 + (_y << 1); draw_coloured_tile ();
}

void draw_decorations (void) {
#asm


ld hl, (__gp_gen)

._draw_decorations_loop
ld a, (hl)
cp 0xff
ret z

ld a, (hl)
inc hl
ld c, a
and 0x0f
ld (__y), a
ld a, c
srl a
srl a
srl a
srl a
ld (__x), a

ld a, (hl)
inc hl
ld (__t), a

push hl

ld b, 0
ld c, a
ld hl, _behs
add hl, bc
ld a, (hl)
ld (__n), a

call _update_tile

pop hl
jr _draw_decorations_loop
#endasm

}

unsigned char utaux = 0;
void update_tile (void) {
#asm
# 575
ld a, (__x)
ld c, a
ld a, (__y)
ld b, a
sla a
sla a
sla a
sla a
sub b
add c
ld b, 0
ld c, a
ld hl, _map_attr
add hl, bc
ld a, (__n)
ld (hl), a
ld hl, _map_buff
add hl, bc
ld a, (__t)
ld (hl), a

call _draw_coloured_tile_gamearea

ld a, (_is_rendering)
or a
ret nz

call _invalidate_tile
#endasm

}

void print_number2 (void) {
rda = 16 + (_t / 10); rdb = 16 + (_t % 10);
#asm

; enter: A = row position (0..23)
; C = col position (0..31/63)
; D = pallette #
; E = graphic #

ld a, (_rda)
ld e, a

ld d, 7

ld a, (__x)
ld c, a

ld a, (__y)

call SPPrintAtInv

ld a, (_rdb)
ld e, a

ld d, 7

ld a, (__x)
inc a
ld c, a

ld a, (__y)

call SPPrintAtInv
#endasm

}


void draw_objs () {
#asm
#endasm
# 713
_x = 27; _y = 23;
# 723
_t = p_objs;

print_number2 ();


}


void print_str (void) {
#asm

ld hl, (__gp_gen)
.print_str_loop
ld a, (hl)
or a
ret z

inc hl

sub 32
ld e, a

ld a, (__t)
ld d, a

ld a, (__x)
ld c, a
inc a
ld (__x), a

ld a, (__y)

push hl
call SPPrintAtInv
pop hl

jr print_str_loop
#endasm

}


void blackout_area (void) {
#asm

ld de, 22528 + 32 * 1 + 1
ld b, 20
.bal1
push bc
ld h, d
ld l, e
ld (hl), 0
inc de
ld bc, 29
ldir
inc de
inc de
pop bc
djnz bal1
#endasm

}


void clear_sprites (void) {
#asm

ld ix, (_sp_player)
ld iy, vpClipStruct
ld bc, 0
ld hl, 0xdede
ld de, 0
call SPMoveSprAbs

xor a
.hide_sprites_enems_loop
ld (_gpit), a

sla a
ld c, a
ld b, 0
ld hl, _sp_moviles
add hl, bc
ld e, (hl)
inc hl
ld d, (hl)
push de
pop ix

ld iy, vpClipStruct
ld bc, 0
ld hl, 0xfefe
ld de, 0

call SPMoveSprAbs

ld a, (_gpit)
inc a
cp 3
jr nz, hide_sprites_enems_loop


xor a
.hide_sprites_bullets_loop
ld (_gpit), a

sla a
ld c, a
ld b, 0
ld hl, _sp_bullets
add hl, bc
ld e, (hl)
inc hl
ld d, (hl)
push de
pop ix

ld iy, vpClipStruct
ld bc, 0
ld hl, 0xfefe
ld de, 0

call SPMoveSprAbs

ld a, (_gpit)
inc a
cp 3
jr nz, hide_sprites_bullets_loop
#endasm


}
# 6 "engine/general.h"
unsigned char collide (void) {



return (gpx + 13 >= cx2 && gpx <= cx2 + 13 && gpy + 12 >= cy2 && gpy <= cy2 + 12);

}

unsigned char cm_two_points (void) {
#asm
# 23
ld a, (_cx1)
cp 15
jr nc, _cm_two_points_at1_reset

ld a, (_cy1)
cp 10
jr c, _cm_two_points_at1_do

._cm_two_points_at1_reset
xor a
jr _cm_two_points_at1_done

._cm_two_points_at1_do
ld a, (_cy1)
ld b, a
sla a
sla a
sla a
sla a
sub b
ld b, a
ld a, (_cx1)
add b
ld e, a
ld d, 0
ld hl, _map_attr
add hl, de
ld a, (hl)

._cm_two_points_at1_done
ld (_at1), a

ld a, (_cx2)
cp 15
jr nc, _cm_two_points_at2_reset

ld a, (_cy2)
cp 10
jr c, _cm_two_points_at2_do

._cm_two_points_at2_reset
xor a
jr _cm_two_points_at2_done

._cm_two_points_at2_do
ld a, (_cy2)
ld b, a
sla a
sla a
sla a
sla a
sub b
ld b, a
ld a, (_cx2)
add b
ld e, a
ld d, 0
ld hl, _map_attr
add hl, de
ld a, (hl)

._cm_two_points_at2_done
ld (_at2), a
#endasm

}

unsigned char rand (void) {
#asm

.rand16
ld hl, _seed
ld a, (hl)
ld e, a
inc hl
ld a, (hl)
ld d, a

;; Ahora DE = [SEED]

ld a, d
ld h, e
ld l, 253
or a
sbc hl, de
sbc a, 0
sbc hl, de
ld d, 0
sbc a, d
ld e, a
sbc hl, de
jr nc, nextrand
inc hl
.nextrand
ld d, h
ld e, l
ld hl, _seed
ld a, e
ld (hl), a
inc hl
ld a, d
ld (hl), a

;; Ahora [SEED] = HL

ld l, e
ret
#endasm

}

unsigned int abs (int n) {
if (n < 0)
return (unsigned int) (-n);
else
return (unsigned int) n;
}
#asm
#endasm
# 158
void cortina (void) {
#asm

;; Antes que nada vamos a limpiar el PAPER de toda la pantalla
;; para que no queden artefactos feos

ld de, 22528 ; Apuntamos con DE a la zona de atributos
ld b, 3 ; Procesamos 3 tercios
.clearb1
push bc

ld b, 0 ; Procesamos los 256 atributos de cada tercio
.clearb2

ld a, (de) ; Nos traemos un atributo
and 199 ; Le hacemos la máscara 11000111 y dejamos PAPER a 0
ld (de), a ; Y lo volvemos a poner

inc de ; Siguiente atributo

djnz clearb2

pop bc
djnz clearb1

;; Y ahora el código original que escribí para UWOL:

ld a, 8

.repitatodo
ld c, a ; Salvamos el contador de "repitatodo" en 'c'

ld hl, 16384
ld a, 12

.bucle
ld b, a ; Salvamos el contador de "bucle" en 'b'
ld a, 0

.bucle1
sla (hl)
inc hl
dec a
jr nz, bucle1

ld a, 0
.bucle2
srl (hl)
inc hl
dec a
jr nz, bucle2

ld a, b ; Restituimos el contador de "bucle" a 'a'
dec a
jr nz, bucle

ld a, c ; Restituimos el contador de "repitatodo" a 'a'
dec a
jr nz, repitatodo
#endasm

}
# 6 "engine/breakable.h"
void break_wall (void) {
gpaux = ((_x)+(_y<<4)-(_y));
if (brk_buff [gpaux] < 1) {
++ brk_buff [gpaux];
gpit = 1;
} else {
gpit = _n = _t = 0; update_tile ();
}



beep_fx (gpit);

}
# 6 "engine/bullets.h"
void bullets_init (void) {
b_it = 0; while (b_it < 3) {
bullets_estado [b_it] = 0; ++ b_it;
}
}

void bullets_update (void) {
#asm


ld de, (_b_it)
ld d, 0

ld hl, _bullets_estado
add hl, de
ld a, (__b_estado)
ld (hl), a

ld hl, _bullets_x
add hl, de
ld a, (__b_x)
ld (hl), a

ld hl, _bullets_y
add hl, de
ld a, (__b_y)
ld (hl), a

ld hl, _bullets_mx
add hl, de
ld a, (__b_mx)
ld (hl), a

ld hl, _bullets_my
add hl, de
ld a, (__b_my)
ld (hl), a
#endasm

}

void bullets_fire (void) {
# 50
if (!p_ammo) return;
-- p_ammo;


for (b_it = 0; b_it < 3; ++ b_it) {
if (bullets_estado [b_it] == 0) {
_b_estado = 1;

switch (p_facing) {
case 2:
_b_x = gpx - 4;
_b_mx = -8;
_b_y = gpy + 6;
_b_my = 0;
break;
case 0:
_b_x = gpx + 12;
_b_mx = 8;
_b_y = gpy + 6;
_b_my = 0;
break;
case 6:
_b_x = gpx + 0;
_b_y = gpy + 12;
_b_my = 8;
_b_mx = 0;
break;
case 4:
_b_x = gpx + 8 - 0;
_b_y = gpy - 4;
_b_my = -8;
_b_mx = 0;
break;
}
# 122
beep_fx (6);
# 133
bullets_update ();

break;
}
}
}

void bullets_move (void) {
for (b_it = 0; b_it < 3; b_it ++) {
if (bullets_estado [b_it]) {
#asm

ld de, (_b_it)
ld d, 0

ld hl, _bullets_x
add hl, de
ld a, (hl)
ld (__b_x), a

ld hl, _bullets_y
add hl, de
ld a, (hl)
ld (__b_y), a

ld hl, _bullets_mx
add hl, de
ld a, (hl)
ld (__b_mx), a

ld hl, _bullets_my
add hl, de
ld a, (hl)
ld (__b_my), a

ld a, 1
ld (__b_estado), a
#endasm


if (_b_mx) {
_b_x += _b_mx;
if (_b_x > 240) {
_b_estado = 0;
}
}

if (_b_my) {
_b_y += _b_my;
if (_b_y > 160) {
_b_estado = 0;
}
}

_x = (_b_x + 3) >> 4;
_y = (_b_y + 3) >> 4;
rda = attr (_x, _y);

if (rda & 16) break_wall ();

if (rda > 7) _b_estado = 0;
# 201
bullets_update ();
}
}
}
# 12 "engine/simple_cocos.h"
void simple_coco_init (void) {
for (enit = 0; enit < 3; ++ enit) cocos_y [enit] = 0xff;
}

void simple_coco_shoot (void) {
#asm

ld de, (_enit)
ld d, 0

ld hl, _cocos_y
add hl, de

ld a, (hl)
cp 160
ret c

ld a, (__en_y)
add 4
ld (hl), a

ld hl, _cocos_x
add hl, de
ld a, (__en_x)
add 4
ld (hl), a

ld a, (_rda)

ld e, a
ld d, 0
ld hl, __dx
add hl, de
ld b, (hl)
ld hl, __dy
add hl, de
ld c, (hl)

ld de, (_enit)
ld d, 0

ld hl, _cocos_mx
add hl, de
ld (hl), b

ld hl, _cocos_my
add hl, de
ld (hl), c
#endasm

}

void simple_coco_update (void) {
for (enit = 0; enit < 3; ++ enit) if (cocos_y [enit] < 160) {
#asm

._simple_coco_update_do


ld de, (_enit)
ld d, 0

ld hl, _cocos_y
add hl, de
ld b, (hl)

ld hl, _cocos_x
add hl, de
ld c, (hl)

ld hl, _cocos_my
add hl, de
ld a, (hl)
add b
ld (_rdy), a

ld hl, _cocos_mx
add hl, de
ld a, (hl)
add c
ld (_rdx), a


cp 240
jr c, _simple_coco_update_keep_going

ld a, 0xff
ld (_rdy), a
jr _simple_coco_update_continue

._simple_coco_update_keep_going
# 105
._simple_coco_update_continue

ld de, (_enit)
ld d, 0

ld hl, _cocos_y
add hl, de
ld a, (_rdy)
ld (hl), a

ld hl, _cocos_x
add hl, de
ld a, (_rdx)
ld (hl), a

._simple_coco_update_done
#endasm

}
}
# 2 "engine/c_levels.h"
void prepare_level (void) {
# 21
unpack ((unsigned int) levels [level].c_map_bolts, (unsigned int) (mapa));
unpack ((unsigned int) levels [level].c_tileset, (unsigned int) (tileset + 512));
unpack ((unsigned int) levels [level].c_enems_hotspots, (unsigned int) (malotes));
unpack ((unsigned int) levels [level].c_behs, (unsigned int) (behs));
# 33
if (warp_to_level == 0)

{
n_pant = levels [level].scr_ini;
gpx = levels [level].ini_x << 4; p_x = gpx << 6;
gpy = levels [level].ini_y << 4; p_y = gpy << 6;
}
# 45
}
#asm
#endasm
#asm
#endasm
# 49 "engine.h"
const unsigned char *player_frames [] = {
sprite_1_a, sprite_2_a, sprite_3_a, sprite_4_a,
sprite_5_a, sprite_6_a, sprite_7_a, sprite_8_a
};
# 71
const unsigned char *enem_frames [] = {
sprite_9_a, sprite_10_a, sprite_11_a, sprite_12_a,
sprite_13_a, sprite_14_a, sprite_15_a, sprite_16_a
};
# 6 "my/fixed_screens.h"
void lame_sound (void) {
gpit = 4; do {
beep_fx (rda);
beep_fx (rdb);
} while (-- gpit);
beep_fx (9);
}


void game_ending (void) {
sp_UpdateNow();
blackout ();
#asm
# 23
ld hl, _s_ending
ld de, 16384
call depack
#endasm
# 31
rda = 7; rdb = 2;
lame_sound ();


espera_activa (500);
}

void game_over (void) {
_x = 10; _y = 11; _t = 79; _gp_gen = spacer; print_str ();
_x = 10; _y = 12; _t = 79; _gp_gen = " GAME OVER! "; print_str ();
_x = 10; _y = 13; _t = 79; _gp_gen = spacer; print_str ();
sp_UpdateNow ();



rda = 7; rdb = 2;
lame_sound ();


espera_activa (500);
}
# 80
void zone_clear (void) {
_x = 10; _y = 11; _t = 79; _gp_gen = spacer; print_str ();
_x = 10; _y = 12; _t = 79; _gp_gen = " ZONE CLEAR "; print_str ();
_x = 10; _y = 13; _t = 79; _gp_gen = spacer; print_str ();
sp_UpdateNowEx (0);
espera_activa (250);
}
# 78 "engine.h"
signed int addsign (signed int n, signed int value) {
if (n >= 0) return value; else return -value;
}
# 86
void espera_activa (int espera) {
while (sp_GetKey ());
do {

gpjt = 250; do { gpit = 1; } while (--gpjt);
#asm
#endasm
# 96
if (sp_GetKey ()) break;
} while (--espera);
}
# 129
void process_tile (void) {
# 135
if ((pad0 & 0x80) == 0)


{
if (qtile (x0, y0) == 14 && attr (x1, y1) == 0 && x1 < 15 && y1 < 10) {
rda = map_buff [((x1)+(y1<<4)-(y1))];
# 149
_x = x0; _y = y0; _t = 0; _n = 0; update_tile ();
_x = x1; _y = y1; _t = 14; _n = 10; update_tile ();
# 156
beep_fx (2);




pushed_any = 1;
# 172
}
}



if (qtile (x0, y0) == 15 && p_keys) {
for (gpit = 0; gpit < 32; ++ gpit) {
if (cerrojos [gpit].x == x0 && cerrojos [gpit].y == y0 && cerrojos [gpit].np == n_pant) {
cerrojos [gpit].st = 0;
break;
}
}
_x = x0; _y = y0; _t = 0; _n = 0; update_tile ();
-- p_keys;




beep_fx (8);
# 194
}

}


void draw_scr_background (void) {



map_pointer = mapa + (n_pant * 75);


seed = n_pant;

_x = 1; _y = 1;



for (gpit = 0; gpit < 150; ++ gpit) {
#asm
#endasm
#asm
# 258
ld a, (_gpit)
and 1
jr nz, _draw_scr_packed_existing
._draw_scr_packed_new
ld hl, (_map_pointer)
ld a, (hl)
ld (_gpc), a
inc hl
ld (_map_pointer), hl

srl a
srl a
srl a
srl a
jr _draw_scr_packed_done

._draw_scr_packed_existing
ld a, (_gpc)
and 15

._draw_scr_packed_done
ld (__t), a

ld b, 0
ld c, a
ld hl, _behs
add hl, bc
ld a, (hl)

ld bc, (_gpit)
ld b, 0
ld hl, _map_attr
add hl, bc
ld (hl), a

ld a, (__t)
or a
jr nz, _draw_scr_packed_noalt

._draw_scr_packed_alt
call _rand
ld a, l
and l
cp 1
jr z, _draw_scr_packed_alt_subst

ld a, (__t)
jr _draw_scr_packed_noalt

._draw_scr_packed_alt_subst
ld a, 19
ld (__t), a

._draw_scr_packed_noalt
ld hl, _map_buff
add hl, bc

ld (hl), a
#endasm
#asm
# 322
ld hl, _brk_buff
add hl, bc
xor a
ld (hl), a
#endasm



draw_coloured_tile ();
#asm
# 340
ld a, (__x)
add 2
cp 30 + 1
jr c, _advance_worm_no_inc_y

ld a, (__y)
add 2
ld (__y), a

ld a, 1

._advance_worm_no_inc_y
ld (__x), a
#endasm

}
}

void draw_scr (void) {
is_rendering = 1;
# 368
draw_scr_background ();
#asm
# 386
ld a, 240
ld (_hotspot_y), a




ld a, (_n_pant)
ld b, a
sla a
add b

ld c, a
ld b, 0



ld hl, _hotspots
add hl, bc



ld a, (hl)
ld b, a

srl a
srl a
srl a
srl a
ld (__x), a

ld a, b
and 15
ld (__y), a

inc hl
ld b, (hl)
inc hl
ld c, (hl)



xor a
or b
jr z, _hotspots_setup_done

xor a
or c
jr z, _hotspots_setup_done

._hotspots_setup_do
ld a, (__x)
ld e, a
sla a
sla a
sla a
sla a
ld (_hotspot_x), a

ld a, (__y)
ld d, a
sla a
sla a
sla a
sla a
ld (_hotspot_y), a



sub d
add e

ld e, a
ld d, 0
ld hl, _map_buff
add hl, de
ld a, (hl)
ld (_orig_tile), a


ld a, b
cp 3
jp nz, _hotspots_setup_set

._hotspots_setup_set_refill
xor a
._hotspots_setup_set
add 16
ld (__t), a

call _draw_coloured_tile_gamearea

._hotspots_setup_done
#endasm
#asm
# 496
ld hl, _cerrojos
ld b, 32
._open_locks_loop
push bc

ld a, (_n_pant)
ld c, a

ld a, (hl)
inc hl

cp c
jr nz, _open_locks_done

ld a, (hl)
inc hl

ld d, a

ld a, (hl)
inc hl

ld e, a

ld a, (hl)
inc hl

or a
jr nz, _open_locks_done

._open_locks_do
ld a, d
ld (__x), a
ld a, e
ld (__y), a

sla a
sla a
sla a
sla a
sub e
add d

ld b, 0
ld c, a
xor a

push hl

ld hl, _map_attr
add hl, bc
ld (hl), a
ld hl, _map_buff
add hl, bc
ld (hl), a

ld (__t), a

call _draw_coloured_tile_gamearea

pop hl

._open_locks_done

pop bc
dec b
jr nz, _open_locks_loop
#endasm



enems_load ();
# 8 "my/ci/entering_screen.h"
if (flags [1]) {
_gp_gen = "BOMBS ARE SET! RETURN TO BASE!";
} else {
_gp_gen = " SET 5 BOMBS IN EVIL COMPUTER";
}
_x = 1; _y = 0; _t = 71;
print_str ();



if (n_pant == 0) {
_gp_gen = decos_computer; draw_decorations ();

if (flags [1]) {
_gp_gen = decos_bombs; draw_decorations ();
} else {
_gp_gen = " SET BOMBS IN EVIL COMPUTER ";
_x = 1; _y = 0; _t = 71;
print_str ();
}
}



if (n_pant == 21 && level == 0) {
_gp_gen = decos_moto; draw_decorations ();
flags [0] = 1;
}



if (n_pant == 23 && flags [1]) {
beep_fx (0);
success = 1;
playing = 0;
}
# 580 "engine.h"
bullets_init ();



simple_coco_init ();


invalidate_viewport ();
is_rendering = 0;
}

void select_joyfunc (void) {
#asm



; Music generated by beepola
call musicstart
#endasm



while (1) {
gpjt = sp_GetKey ();
if (gpjt >= '1' && gpjt <= '3') {
joyfunc = joyfuncs [gpjt - '1'];
break;
}
}
#asm
# 613
di
#endasm


}


unsigned char mons_col_sc_x (void) {
cx1 = cx2 = (_en_mx > 0 ? _en_x + 15 : _en_x) >> 4;
cy1 = _en_y >> 4; cy2 = (_en_y + 15) >> 4;
cm_two_points ();

return (at1 || at2);
# 628
}

unsigned char mons_col_sc_y (void) {
cy1 = cy2 = (_en_my > 0 ? _en_y + 15 : _en_y) >> 4;
cx1 = _en_x >> 4; cx2 = (_en_x + 15) >> 4;
cm_two_points ();

return (at1 || at2);
# 639
}
# 6 "engine/player.h"
void player_init (void) {
# 14
p_vy = 0;
p_vx = 0;
p_cont_salto = 1;
p_saltando = 0;
p_frame = 0;
p_subframe = 0;

p_facing = 6;
p_facing_v = p_facing_h = 0xff;
# 26
p_estado = 0;
p_ct_estado = 0;
# 31
p_objs = 0;
p_keys = 0;
p_killed = 0;
p_disparando = 0;




p_ammo = 99;
# 58
}


void player_calc_bounding_box (void) {
#asm


ld a, (_gpx)
add 4
srl a
srl a
srl a
srl a
ld (_ptx1), a
ld a, (_gpx)
add 11
srl a
srl a
srl a
srl a
ld (_ptx2), a
ld a, (_gpy)
add 8
srl a
srl a
srl a
srl a
ld (_pty1), a
ld a, (_gpy)
add 15
srl a
srl a
srl a
srl a
ld (_pty2), a
#endasm
#asm
#endasm
#asm
#endasm
# 154
}

unsigned char player_move (void) {
wall_v = wall_h = 0;
#asm
#endasm
# 226
{


if ( ! ((pad0 & 0x01) == 0 || (pad0 & 0x02) == 0)) {
p_facing_v = 0xff;
if (p_vy > 0) {
p_vy -= 64;
if (p_vy < 0) p_vy = 0;
} else if (p_vy < 0) {
p_vy += 64;
if (p_vy > 0) p_vy = 0;
}
}

if ((pad0 & 0x01) == 0) {
p_facing_v = 4;
if (p_vy > -256) p_vy -= 48;
}

if ((pad0 & 0x02) == 0) {
p_facing_v = 6;
if (p_vy < 256) p_vy += 48;
}
}
# 266
p_y += p_vy;
# 274
if (p_y < 0) p_y = 0;
if (p_y > 9216) p_y = 9216;

gpy = p_y >> 6;



player_calc_bounding_box ();

hit_v = 0;
cx1 = ptx1; cx2 = ptx2;

if (p_vy < 0)
# 290
{
cy1 = cy2 = pty1;
cm_two_points ();

if ((at1 & 8) || (at2 & 8)) {



p_vy = 0;



gpy = ((pty1 + 1) << 4) - 8;
# 311
p_y = gpy << 6;

wall_v = 1;
}
}


if (p_vy > 0)
# 322
{
cy1 = cy2 = pty2;
cm_two_points ();


if ((at1 & 8) || (at2 & 8))
# 334
{



p_vy = 0;



gpy = (pty2 - 1) << 4;
# 349
p_y = gpy << 6;

wall_v = 2;
}
}


if (p_vy) hit_v = ((at1 & 1) || (at2 & 1));


gpxx = gpx >> 4;
gpyy = gpy >> 4;
# 436
if ( ! ((pad0 & 0x04) == 0 || (pad0 & 0x08) == 0)) {

p_facing_h = 0xff;

if (p_vx > 0) {
p_vx -= 64;
if (p_vx < 0) p_vx = 0;
} else if (p_vx < 0) {
p_vx += 64;
if (p_vx > 0) p_vx = 0;
}
}

if ((pad0 & 0x04) == 0) {

p_facing_h = 2;

if (p_vx > -256) {
# 457
p_vx -= 48;
}
}

if ((pad0 & 0x08) == 0) {

p_facing_h = 0;

if (p_vx < 256) {
p_vx += 48;
# 470
}
}

p_x = p_x + p_vx;
# 480
if (p_x < 0) p_x = 0;
if (p_x > 14336) p_x = 14336;

gpox = gpx;
gpx = p_x >> 6;


player_calc_bounding_box ();

hit_h = 0;
cy1 = pty1; cy2 = pty2;


if (p_vx < 0)
# 497
{
cx1 = cx2 = ptx1;
cm_two_points ();

if ((at1 & 8) || (at2 & 8)) {



p_vx = 0;



gpx = ((ptx1 + 1) << 4) - 4;
# 514
p_x = gpx << 6;
wall_h = 3;
}

else hit_h = ((at1 & 1) || (at2 & 1));

}


if (p_vx > 0)
# 527
{
cx1 = cx2 = ptx2;
cm_two_points ();

if ((at1 & 8) || (at2 & 8)) {



p_vx = 0;



gpx = (ptx1 << 4) + 4;
# 544
p_x = gpx << 6;
wall_h = 4;
}

else hit_h = ((at1 & 1) || (at2 & 1));

}
# 556
if (p_facing_v != 0xff) {
p_facing = p_facing_v;
} else if (p_facing_h != 0xff) {
p_facing = p_facing_h;
}
# 570
cx1 = p_tx = (gpx + 8) >> 4;
cy1 = p_ty = (gpy + 8) >> 4;



if (wall_v == 1) {


cy1 = (gpy + 7) >> 4;
# 585
if (attr (cx1, cy1) == 10) {
x0 = x1 = cx1; y0 = cy1; y1 = cy1 - 1;
process_tile ();
}

} else if (wall_v == 2) {


cy1 = (gpy + 16) >> 4;
# 600
if (attr (cx1, cy1) == 10) {
x0 = x1 = cx1; y0 = cy1; y1 = cy1 + 1;
process_tile ();
}
} else


if (wall_h == 3) {


cx1 = (gpx + 3) >> 4;
# 615
if (attr (cx1, cy1) == 10) {
y0 = y1 = cy1; x0 = cx1; x1 = cx1 - 1;
process_tile ();
}
} else if (wall_h == 4) {


cx1 = (gpx + 12) >> 4;
# 626
if (attr (cx1, cy1) == 10) {
y0 = y1 = cy1; x0 = cx1; x1 = cx1 + 1;
process_tile ();
}
}
# 638
if ((pad0 & 0x80) == 0 && p_disparando == 0) {

p_disparando = 1;

if (pushed_any == 0)

bullets_fire ();

else pushed_any = 0;

}

if ((pad0 & 0x80))
p_disparando = 0;
# 658
hit = 0;
if (hit_v) {
hit = 1;
p_vy = addsign (-p_vy, 256);
} else if (hit_h) {
hit = 1;
p_vx = addsign (-p_vx, 256);
}

if (hit) {

if (p_estado == 0) {
p_estado = 2;
p_ct_estado = 50;
# 678
p_killme = 4;

}
}
# 689
if (p_vx || p_vy) {
++ p_subframe;
if (p_subframe == 4) {
p_subframe = 0;
p_frame = !p_frame;
# 697
}
}

p_next_frame = player_frames [p_facing + p_frame];
# 723
}

void player_kill (unsigned char sound) {
p_killme = 0;

if (p_life == 0) return;
-- p_life;




beep_fx (sound);
# 747
}
# 7 "engine/enengine.h"
void enems_pursuers_init (void) {
en_an_alive [enit] = 0;
en_an_dead_row [enit] = 11 + (rand () & 7);
}
# 28
void enems_draw_current (void) {
_en_x = malotes [enoffsmasi].x;
_en_y = malotes [enoffsmasi].y;
#asm


; enter: IX = sprite structure address
; IY = clipping rectangle, set it to "ClipStruct" for full screen
; BC = animate bitdef displacement (0 for no animation)
; H = new row coord in chars
; L = new col coord in chars
; D = new horizontal rotation (0..7) ie horizontal pixel position
; E = new vertical rotation (0..7) ie vertical pixel position


ld a, (_enit)
sla a
ld c, a
ld b, 0
ld hl, _sp_moviles
add hl, bc
ld e, (hl)
inc hl
ld d, (hl)
push de
pop ix


ld iy, vpClipStruct



ld hl, _en_an_current_frame
add hl, bc
ld e, (hl)
inc hl
ld d, (hl)

ld hl, _en_an_next_frame
add hl, bc
ld a, (hl)
inc hl
ld h, (hl)
ld l, a

or a
sbc hl, de

push bc

ld b, h
ld c, l


ld a, (__en_y)
srl a
srl a
srl a
add 1
ld h, a

ld a, (__en_x)
srl a
srl a
srl a
add 1
ld l, a


ld a, (__en_x)
and 7
ld d, a

ld a, (__en_y)
and 7
ld e, a

call SPMoveSprAbs



pop bc

ld hl, _en_an_current_frame
add hl, bc
ex de, hl

ld hl, _en_an_next_frame
add hl, bc

ldi
ldi
#endasm

}

void enems_load (void) {

enoffs = n_pant * 3;

for (enit = 0; enit < 3; ++ enit) {
en_an_frame [enit] = 0;
en_an_state [enit] = 0;
en_an_count [enit] = 3;
enoffsmasi = enoffs + enit;



malotes [enoffsmasi].t &= 0xEF;




malotes [enoffsmasi].life = 2;




switch (malotes [enoffsmasi].t & 0x1f) {
case 1:
case 2:
case 3:
case 4:
en_an_base_frame [enit] = (malotes [enoffsmasi].t - 1) << 1;
break;


case 5:




en_an_base_frame [enit] = 0 << 1;

en_an_state [enit] = malotes [enoffsmasi].t >> 6;
break;
# 181
case 7:
enems_pursuers_init ();
break;
# 188
default:
en_an_next_frame [enit] = sprite_18_a;
}

malotes [enoffsmasi].t &= 0x1f;
# 195
}
}

void enems_kill (void) {
if (_en_t != 7) _en_t |= 16;
++ p_killed;
# 211
}

void enems_move (void) {
tocado = p_gotten = ptgmx = ptgmy = 0;

for (enit = 0; enit < 3; enit ++) {
active = 0;
enoffsmasi = enoffs + enit;
#asm
# 227
ld hl, (_enoffsmasi)
ld h, 0


add hl, hl
ld d, h
ld e, l
add hl, hl
add hl, hl

add hl, de
# 248
ld de, _malotes
add hl, de

ld (__baddies_pointer), hl

ld a, (hl)
ld (__en_x), a
inc hl

ld a, (hl)
ld (__en_y), a
inc hl

ld a, (hl)
ld (__en_x1), a
inc hl

ld a, (hl)
ld (__en_y1), a
inc hl

ld a, (hl)
ld (__en_x2), a
inc hl

ld a, (hl)
ld (__en_y2), a
inc hl

ld a, (hl)
ld (__en_mx), a
inc hl

ld a, (hl)
ld (__en_my), a
inc hl

ld a, (hl)
ld (__en_t), a


inc hl

ld a, (hl)
ld (__en_life), a
#endasm




_en_cx = _en_x; _en_cy = _en_y;
# 319
switch (_en_t) {
case 1:
case 2:
case 3:
case 4:

case 5:
#asm
# 21 "./engine/enem_mods/enem_type_lineal.h"
ld a, 1
ld (_active), a

ld a, (__en_mx)
ld c, a
ld a, (__en_x)
add a, c
ld (__en_x), a

ld c, a
ld a, (__en_x1)
cp c
jr z, _enems_lm_change_axis_x
ld a, (__en_x2)
cp c


jr z, _enems_lm_change_axis_x

call _mons_col_sc_x
xor a
or l

jr z, _enems_lm_change_axis_x_done
# 49
._enems_lm_change_axis_x
ld a, (__en_mx)
neg
ld (__en_mx), a

._enems_lm_change_axis_x_done

ld a, (__en_my)
ld c, a
ld a, (__en_y)
add a, c
ld (__en_y), a

ld c, a
ld a, (__en_y1)
cp c
jr z, _enems_lm_change_axis_y
ld a, (__en_y2)
cp c


jr z, _enems_lm_change_axis_y

call _mons_col_sc_y
xor a
or l

jr z, _enems_lm_change_axis_y_done
# 81
._enems_lm_change_axis_y
ld a, (__en_my)
neg
ld (__en_my), a

._enems_lm_change_axis_y_done
#endasm
# 329 "engine/enengine.h"
if (_en_t == 5) {
# 6 "./engine/enem_mods/enem_type_orthoshooters.h"
if ((rand()&15) == 1) {
rda = en_an_state [enit];
simple_coco_shoot ();
}
# 331 "engine/enengine.h"
}

break;
# 341
case 7:
#asm
# 8 "./engine/enem_mods/enem_type_pursuers_asm.h"
ld bc, (_enit)
ld b, 0
ld hl, _en_an_alive
add hl, bc
ld a, (hl)

cp 1
jp z, _eij_state_appearing

cp 2
jp z, _eij_state_moving

._eij_state_idle
ld hl, _en_an_dead_row
add hl, bc
ld a, (hl)
or a
jr nz, _eij_state_still_idle

ld a, (__en_x1)
ld (__en_x), a
ld a, (__en_y1)
ld (__en_y), a

ld hl, _en_an_alive
add hl, bc
ld a, 1
ld (hl), a


push bc
call _rand
ld de, 5
ex de, hl
call l_div
ex de, hl
ld de, 1
call l_asl
ld a, l
pop bc

cp 5
jr c, _eij_rawv_set

ld a, 2

._eij_rawv_set
ld hl, _en_an_rawv
add hl, bc
ld (hl), a

call _rand
ld a, l
and 7
add 11

ld hl, _en_an_dead_row
add hl, bc
ld (hl), a


ld a, 1
ld (__en_life), a

jp _eij_state_done

._eij_state_still_idle
dec a
ld (hl), a
jp _eij_state_done

._eij_state_appearing
ld hl, _en_an_dead_row
add hl, bc
ld a, (hl)
or a
jr nz, _eij_state_still_appearing


ld a, 3*2
# 95
ld hl, _en_an_base_frame
add hl, bc
ld (hl), a

ld a, 2
ld hl, _en_an_alive
add hl, bc
ld (hl), a
jp _eij_state_done

._eij_state_still_appearing
dec a
ld (hl), a
ld hl, _en_an_next_frame
add hl, bc
add hl, bc
ld de, _sprite_17_a
ex de, hl
call l_pint
jp _eij_state_done

._eij_state_moving
ld a, 1
ld (_active), a

ld hl, _en_an_rawv
add hl, bc
ld a, (hl)
ld (_rda), a

ld a, (_p_estado)
or a
jr nz, _eij_state_done

._eij_state_moving_x
call _rand
ld a, l
and 3
jr z, _eij_state_moving_y

ld a, (__en_x)
ld d, a
ld a, (_gpx)
cp d
jr z, _eij_state_moving_y

jr c, _eij_state_moving_x_left

._eij_state_moving_x_right
ld a, (_rda)
ld (__en_mx), a
jr _eij_state_moving_x_set

._eij_state_moving_x_left
ld a, (_rda)
neg
ld (__en_mx), a

._eij_state_moving_x_set
add d
ld (__en_x), a

call _mons_col_sc_x
xor a
or l
jr z, _eij_state_moving_y

ld a, (__en_cx)
ld (__en_x), a

._eij_state_moving_y
call _rand
ld a, l
and 3
jr z, _eij_state_done

ld a, (__en_y)
ld d, a
ld a, (_gpy)
cp d
jr z, _eij_state_done

jr c, _eij_state_moving_y_up

._eij_state_moving_y_down
ld a, (_rda)
ld (__en_my), a
jr _eij_state_moving_y_set

._eij_state_moving_y_up
ld a, (_rda)
neg
ld (__en_my), a

._eij_state_moving_y_set
add d
ld (__en_y), a

call _mons_col_sc_y
xor a
or l
jr z, _eij_state_done

ld a, (__en_cy)
ld (__en_y), a

._eij_state_done
#endasm
# 343 "engine/enengine.h"
break;
# 350
}

if (active) {

if (en_an_base_frame [enit] != 99) {
#asm
# 364
ld bc, (_enit)
ld b, 0

ld hl, _en_an_count
add hl, bc
ld a, (hl)
inc a
ld (hl), a

cp 4
jr nz, _enems_move_update_frame_done

xor a
ld (hl), a

ld hl, _en_an_frame
add hl, bc
ld a, (hl)
xor 1
ld (hl), a

ld hl, _en_an_base_frame
add hl, bc
ld d, (hl)
add d ; A = en_an_base_frame [enit] + en_an_frame [enit]]

sla c ; Index 16 bits; it never overflows.
ld hl, _en_an_next_frame
add hl, bc
ex de, hl ; DE -> en_an_next_frame [enit]

sla a
ld c, a
ld b, 0

ld hl, _enem_frames
add hl, bc ; HL -> enem_frames [en_an_base_frame [enit] + en_an_frame [enit]]

ldi
ldi ; Copy 16 bit
._enems_move_update_frame_done
#endasm

}
# 437
{
cx2 = _en_x; cy2 = _en_y;
if (!tocado && collide () && p_estado == 0) {
# 467
{
tocado = 1;
# 482
p_killme = 4;
# 511
p_estado = 2;
p_ct_estado = 50;

}
}
}




if (_en_t >= 3)

{
for (gpjt = 0; gpjt < 3; gpjt ++) {
if (bullets_estado [gpjt] == 1) {
blx = bullets_x [gpjt] + 3;
bly = bullets_y [gpjt] + 3;
if (blx >= _en_x && blx <= _en_x + 15 && bly >= _en_y && bly <= _en_y + 15) {
# 534
_en_x = _en_cx;
_en_y = _en_cy;
en_an_next_frame [enit] = sprite_17_a;
bullets_estado [gpjt] = 0;



_en_life --;


if (_en_life == 0) {
enems_draw_current ();
sp_UpdateNow ();
#asm
#endasm
# 553
beep_fx (5);

en_an_next_frame [enit] = sprite_18_a;


enems_pursuers_init ();


enems_kill ();
}




beep_fx (1);

}
}
}

}

}
#asm
# 581
ld hl, (__baddies_pointer)

ld a, (__en_x)
ld (hl), a
inc hl

ld a, (__en_y)
ld (hl), a
inc hl

ld a, (__en_x1)
ld (hl), a
inc hl

ld a, (__en_y1)
ld (hl), a
inc hl

ld a, (__en_x2)
ld (hl), a
inc hl

ld a, (__en_y2)
ld (hl), a
inc hl

ld a, (__en_mx)
ld (hl), a
inc hl

ld a, (__en_my)
ld (hl), a
inc hl

ld a, (__en_t)
ld (hl), a
inc hl


ld a, (__en_life)
ld (hl), a
#endasm


}
# 629
}
# 14 "engine/hotspots.h"
void hotspots_do (void) {

cx2 = hotspot_x; cy2 = hotspot_y; if (collide ()) {

_x = hotspot_x >> 4; _y = hotspot_y >> 4; _t = orig_tile;
draw_invalidate_coloured_tile_g ();
gpit = 0;


if (hotspots [n_pant].act) {
hotspots [n_pant].act = 0;
switch (hotspots [n_pant].tipo) {

case 1:
# 47
++ p_objs;
# 55
beep_fx (9);
# 78
break;



case 2:
p_keys ++;



beep_fx (7);

break;


case 3:
p_life += 5;
if (p_life > 30)
p_life = 30;



beep_fx (8);

break;


case 4:
if (99 - p_ammo > 50)
p_ammo += 50;
else
p_ammo = 99;



beep_fx (9);

break;
# 143
}

}
hotspot_x = hotspot_y = 240;
}
}
# 7 "mainloop.h"
void main (void) {
#asm




di
#endasm
#asm
#endasm
# 27
cortina ();


sp_Initialize (7, 0);
sp_Border (0x00);
sp_AddMemory(0, (40 + ((3 + 3) * 5)), 14, AD_FREE);


gen_pt = tileset;
gpit = 0; do {
sp_TileArray (gpit, gen_pt);
gen_pt += 8;
gpit ++;
} while (gpit);
# 56
sp_player = sp_CreateSpr (0x00, 3, sprite_2_a);
sp_AddColSpr (sp_player, sprite_2_b);
sp_AddColSpr (sp_player, sprite_2_c);
p_current_frame = p_next_frame = sprite_2_a;

for (gpit = 0; gpit < 3; gpit ++) {
sp_moviles [gpit] = sp_CreateSpr(0x00, 3, sprite_9_a);
sp_AddColSpr (sp_moviles [gpit], sprite_9_b);
sp_AddColSpr (sp_moviles [gpit], sprite_9_c);
en_an_current_frame [gpit] = en_an_next_frame [gpit] = sprite_9_a;
}



for (gpit = 0; gpit < 3; gpit ++) {



sp_bullets [gpit] = sp_CreateSpr (0x40, 2, sprite_19_a);

sp_AddColSpr (sp_bullets [gpit], sprite_19_a+32);
}



for (gpit = 0; gpit < 3; gpit ++) {



sp_cocos [gpit] = sp_CreateSpr (0x40, 2, sprite_19_a);

sp_AddColSpr (sp_cocos [gpit], sprite_19_a+32);
}
# 93
while (1) {
# 99
sp_UpdateNow();
blackout ();
#asm
# 106
ld hl, _s_title
ld de, 16384
call depack
#endasm
# 116
select_joyfunc ();
# 132
level = 2;



p_life = 30;
# 142
warp_to_level = 0;


while (1)


{

prepare_level (level);
# 7 "my/level_screen.h"
{

blackout_area ();


level_str [7] = 49 + level;
_x = 12; _y = 12; _t = 71; _gp_gen = level_str; print_str ();
sp_UpdateNow ();



beep_fx (1);


espera_activa (100);
}
#asm
#endasm
# 6 "mainloop/game_loop.h"
playing = 1;
player_init ();
# 29
maincounter = 0;
# 4 "./my/ci/entering_game.h"
flags [0] = flags [1] = 0;
# 49 "mainloop/game_loop.h"
p_killme = success = half_life = 0;

objs_old = keys_old = life_old = killed_old = 0xff;

ammo_old = 0xff;
# 87
o_pant = 0xff;
while (playing) {

if (sp_KeyPressed (0x047f)) { ++ p_objs; beep_fx (0); }
if (sp_KeyPressed (0x10bf)) { ++ n_pant; beep_fx (0); }
if (sp_KeyPressed (0x10df)) { -- n_pant; beep_fx (0); }


pad0 = (joyfunc) (&keys);

if (o_pant != n_pant) {
# 99
draw_scr ();
o_pant = n_pant;
}
# 7 "./mainloop/hud.h"
if (p_objs != objs_old) {
draw_objs ();
objs_old = p_objs;
}



if (p_life != life_old) {
_x = 3; _y = 23; _t = p_life; print_number2 ();
life_old = p_life;
}



if (p_keys != keys_old) {
_x = 22; _y = 23; _t = p_keys; print_number2 ();
keys_old = p_keys;
}
# 37
if (p_ammo != ammo_old) {
_x = 8; _y = 23; _t = p_ammo; print_number2 ();
ammo_old = p_ammo;
}
# 164 "mainloop/game_loop.h"
maincounter ++;
half_life = !half_life;


player_move ();


enems_move ();



simple_coco_update ();


if (p_killme) player_kill (p_killme);



bullets_move ();
# 199
if (o_pant == n_pant) {
# 6 "./mainloop/update_sprites.h"
for (enit = 0; enit < 3; enit ++) {
enoffsmasi = enoffs + enit;
enems_draw_current ();
}

if ( (p_estado & 2) == 0 || half_life == 0 ) {
#asm


ld ix, (_sp_player)
ld iy, vpClipStruct

ld hl, (_p_next_frame)
ld de, (_p_current_frame)
or a
sbc hl, de
ld b, h
ld c, l

ld a, (_gpy)
srl a
srl a
srl a
add 1
ld h, a

ld a, (_gpx)
srl a
srl a
srl a
add 1
ld l, a

ld a, (_gpx)
and 7
ld d, a

ld a, (_gpy)
and 7
ld e, a

call SPMoveSprAbs
#endasm

} else {
#asm


ld ix, (_sp_player)
ld iy, vpClipStruct

ld hl, (_p_next_frame)
ld de, (_p_current_frame)
or a
sbc hl, de
ld b, h
ld c, l

ld hl, 0xfefe
ld de, 0
call SPMoveSprAbs
#endasm

}

p_current_frame = p_next_frame;


for (gpit = 0; gpit < 3; gpit ++) {
if (bullets_estado [gpit] == 1) {
rdx = bullets_x [gpit]; rdy = bullets_y [gpit];
#asm


ld a, (_gpit)
sla a
ld c, a
ld b, 0
ld hl, _sp_bullets
add hl, bc
ld e, (hl)
inc hl
ld d, (hl)
push de
pop ix

ld iy, vpClipStruct
ld bc, 0

ld a, (_rdy)
srl a
srl a
srl a
add 1
ld h, a

ld a, (_rdx)
srl a
srl a
srl a
add 1
ld l, a

ld a, (_rdx)
and 7
ld d, a

ld a, (_rdy)
and 7
ld e, a

call SPMoveSprAbs
#endasm

} else {
#asm


ld a, (_gpit)
sla a
ld c, a
ld b, 0
ld hl, _sp_bullets
add hl, bc
ld e, (hl)
inc hl
ld d, (hl)
push de
pop ix

ld iy, vpClipStruct
ld bc, 0

ld hl, 0xfefe
ld de, 0

call SPMoveSprAbs
#endasm

}
}



for (gpit = 0; gpit < 3; gpit ++) {
if (cocos_y [gpit] < 160) {
rdx = cocos_x [gpit]; rdy = cocos_y [gpit];
#asm


ld a, (_gpit)
sla a
ld c, a
ld b, 0
ld hl, _sp_cocos
add hl, bc
ld e, (hl)
inc hl
ld d, (hl)
push de
pop ix

ld iy, vpClipStruct
ld bc, 0

ld a, (_rdy)
srl a
srl a
srl a
add 1
ld h, a

ld a, (_rdx)
srl a
srl a
srl a
add 1
ld l, a

ld a, (_rdx)
and 7
ld d, a

ld a, (_rdy)
and 7
ld e, a

call SPMoveSprAbs
#endasm

} else {
#asm


ld a, (_gpit)
sla a
ld c, a
ld b, 0
ld hl, _sp_cocos
add hl, bc
ld e, (hl)
inc hl
ld d, (hl)
push de
pop ix

ld iy, vpClipStruct
ld bc, 0

ld hl, 0xfefe
ld de, 0

call SPMoveSprAbs
#endasm

}
}
# 202 "mainloop/game_loop.h"
sp_UpdateNow();
}



if (p_estado == 2) {
p_ct_estado --;
if (p_ct_estado == 0)
p_estado = 0;
}



hotspots_do ();
# 79 "./mainloop/flick_screen.h"
if (gpy == 0 && p_vy < 0 && n_pant >= 1) {
n_pant -= 1;

gpy = 144;
p_y = 9216;
}

if (gpy == 144 && p_vy > 0) {




if (n_pant < 1 * 24 - 1) {
n_pant += 1;

gpy = p_y = 0;
if (p_vy > 256) p_vy = 256;
}
# 109
}
# 287 "mainloop/game_loop.h"
if (0
# 301
) {
success = 1;
playing = 0;
}


if (p_life == 0
# 314
) {
playing = 0;
}
# 4 "./my/ci/extra_routines.h"
if (n_pant == 0 && flags [1] == 0 && gpy < 96 && p_objs == 5) {
flags [1] = 1;


_gp_gen = decos_bombs;
for (gpit = 0; gpit < 5; ++ gpit) {
rda = *_gp_gen; _gp_gen += 2;
_x = rda >> 4; _y = rda & 15; _t = 17;
update_tile ();
sp_UpdateNow ();
beep_fx (0);
}

_x = 1; _y = 0; _t = 71;
_gp_gen = "  DONE! NOW GO BACK TO BASE!  ";
print_str ();
}

if (flags [0]) {
if (gpx < 64 && gpy >= 16 && gpy < 80) {
flags [0] = 0;
beep_fx (9);
_x = 1; _y = 0; _t = 71;
_gp_gen = " HALF NEW MOTORBIKE FOR SALE! ";
print_str ();
}
}
# 319 "mainloop/game_loop.h"
}
sp_WaitForNoKey ();
# 175 "mainloop.h"
if (success) {
# 180
zone_clear ();




if (warp_to_level == 0)

++ level;

if (level >= 3
# 193
) {
game_ending ();
break;
}
} else {
# 205
game_over ();
# 211
break;
}
# 222
}

clear_sprites ();
}
}
#asm
# 2 "music.h"
; *****************************************************************************
; * Phaser1 Engine, with synthesised drums
; *
; * Original code by Shiru - .http
; * Modified by Chris Cowley
; *
; * Produced by Beepola v1.05.01
; ******************************************************************************

.musicstart
LD HL,MUSICDATA ; <- Pointer to Music Data. Change
; this to play a different song
LD A,(HL) ; Get the loop start pointer
LD (PATTERN_LOOP_BEGIN),A
INC HL
LD A,(HL) ; Get the song end pointer
LD (PATTERN_LOOP_END),A
INC HL
LD E,(HL)
INC HL
LD D,(HL)
INC HL
LD (INSTRUM_TBL),HL
LD (CURRENT_INST),HL
ADD HL,DE
LD (PATTERN_ADDR),HL
XOR A
LD (PATTERN_PTR),A ; Set the pattern pointer to zero
LD H,A
LD L,A
LD (NOTE_PTR),HL ; Set the note offset (within this pattern) to 0

.player
DI
PUSH IY
;LD A,BORDER_COL
xor a
LD H,$00
LD L,A
LD (CNT_1A),HL
LD (CNT_1B),HL
LD (DIV_1A),HL
LD (DIV_1B),HL
LD (CNT_2),HL
LD (DIV_2),HL
LD (OUT_1),A
LD (OUT_2),A
JR MAIN_LOOP

; ********************************************************************************************************
; * NEXT_PATTERN
; *
; * Select the next pattern in sequence (and handle looping if weve reached PATTERN_LOOP_END
; * Execution falls through to PLAYNOTE to play the first note from our next pattern
; ********************************************************************************************************
.next_pattern
LD A,(PATTERN_PTR)
INC A
INC A
DEFB $FE ; CP n
.pattern_loop_end DEFB 0
JR NZ,NO_PATTERN_LOOP
; Handle Pattern Looping at and of song
DEFB $3E ; LD A,n
.pattern_loop_begin DEFB 0
.no_pattern_loop LD (PATTERN_PTR),A
LD HL,$0000
LD (NOTE_PTR),HL ; Start of pattern (NOTE_PTR = 0)

.main_loop
LD IYL,0 ; Set channel = 0

.read_loop
LD HL,(PATTERN_ADDR)
LD A,(PATTERN_PTR)
LD E,A
LD D,0
ADD HL,DE
LD E,(HL)
INC HL
LD D,(HL) ; Now DE = Start of Pattern data
LD HL,(NOTE_PTR)
INC HL ; Increment the note pointer and...
LD (NOTE_PTR),HL ; ..store it
DEC HL
ADD HL,DE ; Now HL = address of note data
LD A,(HL)
OR A
JR Z,NEXT_PATTERN ; select next pattern

BIT 7,A
JP Z,RENDER ; Play the currently defined note(S) and drum
LD IYH,A
AND $3F
CP $3C
JP NC,OTHER ; Other parameters
ADD A,A
LD B,0
LD C,A
LD HL,FREQ_TABLE
ADD HL,BC
LD E,(HL)
INC HL
LD D,(HL)
LD A,IYL ; IYL = 0 for channel 1, or = 1 for channel 2
OR A
JR NZ,SET_NOTE2
LD (DIV_1A),DE
EX DE,HL

DEFB $DD,$21 ; LD IX,nn
.current_inst
DEFW $0000

LD A,(IX+$00)
OR A
JR Z,L809B ; Original code jumps into byte 2 of the DJNZ (invalid opcode FD)
LD B,A
.l8098 ADD HL,HL
DJNZ L8098
.l809b LD E,(IX+$01)
LD D,(IX+$02)
ADD HL,DE
LD (DIV_1B),HL
LD IYL,1 ; Set channel = 1
LD A,IYH
AND $40
JR Z,READ_LOOP ; No phase reset

LD HL,OUT_1 ; Reset phaser
RES 4,(HL)
LD HL,$0000
LD (CNT_1A),HL
LD H,(IX+$03)
LD (CNT_1B),HL
JR READ_LOOP

.set_note2
LD (DIV_2),DE
LD A,IYH
LD HL,OUT_2
RES 4,(HL)
LD HL,$0000
LD (CNT_2),HL
JP READ_LOOP

.set_stop
LD HL,$0000
LD A,IYL
OR A
JR NZ,SET_STOP2
; Stop channel 1 note
LD (DIV_1A),HL
LD (DIV_1B),HL
LD HL,OUT_1
RES 4,(HL)
LD IYL,1
JP READ_LOOP
.set_stop2
; Stop channel 2 note
LD (DIV_2),HL
LD HL,OUT_2
RES 4,(HL)
JP READ_LOOP

.other CP $3C
JR Z,SET_STOP ; Stop note
CP $3E
JR Z,SKIP_CH1 ; No changes to channel 1
INC HL ; Instrument change
LD L,(HL)
LD H,$00
ADD HL,HL
LD DE,(NOTE_PTR)
INC DE
LD (NOTE_PTR),DE ; Increment the note pointer

DEFB $01 ; LD BC,nn
.instrum_tbl
DEFW $0000

ADD HL,BC
LD (CURRENT_INST),HL
JP READ_LOOP

.skip_ch1
LD IYL,$01
JP READ_LOOP

.exit_player
LD HL,$2758
EXX
POP IY
EI
RET

.render
AND $7F ; L813A
CP $76
JP NC,DRUMS
LD D,A
EXX
DEFB $21 ; LD HL,nn
.cnt_1a DEFW $0000
DEFB $DD,$21 ; LD IX,nn
.cnt_1b DEFW $0000
DEFB $01 ; LD BC,nn
.div_1a DEFW $0000
DEFB $11 ; LD DE,nn
.div_1b DEFW $0000
DEFB $3E ; LD A,n
.out_1 DEFB $0
EXX
EX AF,AF ; beware!
DEFB $21 ; LD HL,nn
.cnt_2 DEFW $0000
DEFB $01 ; LD BC,nn
.div_2 DEFW $0000
DEFB $3E ; LD A,n
.out_2 DEFB $00

.play_note
; Read keyboard
LD E,A
XOR A
IN A,($FE)
OR $E0
INC A

.player_wait_key
JR NZ,EXIT_PLAYER
LD A,E
LD E,0

.l8168 EXX
EX AF,AF ; beware!
ADD HL,BC
OUT ($FE),A
JR C,L8171
JR L8173
.l8171 XOR $10
.l8173 ADD IX,DE
JR C,L8179
JR L817B
.l8179 XOR $10
.l817b EX AF,AF ; beware!
OUT ($FE),A
EXX
ADD HL,BC
JR C,L8184
JR L8186
.l8184 XOR $10
.l8186 NOP
JP L818A

.l818a EXX
EX AF,AF ; beware!
ADD HL,BC
OUT ($FE),A
JR C,L8193
JR L8195
.l8193 XOR $10
.l8195 ADD IX,DE
JR C,L819B
JR L819D
.l819b XOR $10
.l819d EX AF,AF ; beware!
OUT ($FE),A
EXX
ADD HL,BC
JR C,L81A6
JR L81A8
.l81a6 XOR $10
.l81a8 NOP
JP L81AC

.l81ac EXX
EX AF,AF ; beware!
ADD HL,BC
OUT ($FE),A
JR C,L81B5
JR L81B7
.l81b5 XOR $10
.l81b7 ADD IX,DE
JR C,L81BD
JR L81BF
.l81bd XOR $10
.l81bf EX AF,AF ; beware!
OUT ($FE),A
EXX
ADD HL,BC
JR C,L81C8
JR L81CA
.l81c8 XOR $10
.l81ca NOP
JP L81CE

.l81ce EXX
EX AF,AF ; beware!
ADD HL,BC
OUT ($FE),A
JR C,L81D7
JR L81D9
.l81d7 XOR $10
.l81d9 ADD IX,DE
JR C,L81DF
JR L81E1
.l81df XOR $10
.l81e1 EX AF,AF ; beware!
OUT ($FE),A
EXX
ADD HL,BC
JR C,L81EA
JR L81EC
.l81ea XOR $10

.l81ec DEC E
JP NZ,L8168

EXX
EX AF,AF ; beware!
ADD HL,BC
OUT ($FE),A
JR C,L81F9
JR L81FB
.l81f9 XOR $10
.l81fb ADD IX,DE
JR C,L8201
JR L8203
.l8201 XOR $10
.l8203 EX AF,AF ; beware!
OUT ($FE),A
EXX
ADD HL,BC
JR C,L820C
JR L820E
.l820c XOR $10

.l820e DEC D
JP NZ,PLAY_NOTE

LD (CNT_2),HL
LD (OUT_2),A
EXX
EX AF,AF ; beware!
LD (CNT_1A),HL
LD (CNT_1B),IX
LD (OUT_1),A
JP MAIN_LOOP

; ************************************************************
; * DRUMS - Synthesised
; ************************************************************
.drums
ADD A,A ; On entry A=$75+Drum number (i.e. $76 to $7E)
LD B,0
LD C,A
LD HL,DRUM_TABLE - 236
ADD HL,BC
LD E,(HL)
INC HL
LD D,(HL)
EX DE,HL
JP (HL)

.drum_tone1 LD L,16
JR DRUM_TONE
.drum_tone2 LD L,12
JR DRUM_TONE
.drum_tone3 LD L,8
JR DRUM_TONE
.drum_tone4 LD L,6
JR DRUM_TONE
.drum_tone5 LD L,4
JR DRUM_TONE
.drum_tone6 LD L,2
.drum_tone
LD DE,3700
LD BC,$0101

xor a
.dt_loop0 OUT ($FE),A
DEC B
JR NZ,DT_LOOP1
XOR 16
LD B,C
EX AF,AF ; beware!
LD A,C
ADD A,L
LD C,A
EX AF,AF ; beware!
.dt_loop1 DEC E
JR NZ,DT_LOOP0
DEC D
JR NZ,DT_LOOP0
JP MAIN_LOOP

.drum_noise1 LD DE,2480
LD IXL,1
JR DRUM_NOISE
.drum_noise2 LD DE,1070
LD IXL,10
JR DRUM_NOISE
.drum_noise3 LD DE,365
LD IXL,101
.drum_noise
LD H,D
LD L,E

xor a
LD C,A
.dn_loop0 LD A,(HL)
AND 16
OR C
OUT ($FE),A
LD B,IXL
.dn_loop1 DJNZ DN_LOOP1
INC HL
DEC E
JR NZ,DN_LOOP0
DEC D
JR NZ,DN_LOOP0
JP MAIN_LOOP

.pattern_addr DEFW $0000
.pattern_ptr DEFB 0
.note_ptr DEFW $0000

; **************************************************************
; * Frequency Table
; **************************************************************
.freq_table
DEFW 178,189,200,212,225,238,252,267,283,300,318,337
DEFW 357,378,401,425,450,477,505,535,567,601,637,675
DEFW 715,757,802,850,901,954,1011,1071,1135,1202,1274,1350
DEFW 1430,1515,1605,1701,1802,1909,2023,2143,2270,2405,2548,2700
DEFW 2860,3030,3211,3402,3604,3818,4046,4286,4541,4811,5097,5400

; *****************************************************************
; * Synth Drum Lookup Table
; *****************************************************************
.drum_table
DEFW DRUM_TONE1,DRUM_TONE2,DRUM_TONE3,DRUM_TONE4,DRUM_TONE5,DRUM_TONE6
DEFW DRUM_NOISE1,DRUM_NOISE2,DRUM_NOISE3


.musicdata
DEFB 0 ; Pattern loop begin * 2
DEFB 8 ; Song length * 2
DEFW 12 ; Offset to start of song (length of instrument table)
DEFB 1 ; Multiple
DEFW 5 ; Detune
DEFB 1 ; Phase
DEFB 0 ; Multiple
DEFW 20 ; Detune
DEFB 0 ; Phase
DEFB 1 ; Multiple
DEFW 15 ; Detune
DEFB 0 ; Phase

.patterndata DEFW PAT0
DEFW PAT0
DEFW PAT1
DEFW PAT1

; *** Pattern data - $00 marks the end of a pattern ***
.pat0
DEFB $BD,0
DEFB 171
DEFB 152
DEFB 126
DEFB 3
DEFB 188
DEFB 188
DEFB 4
DEFB 171
DEFB 126
DEFB 3
DEFB 168
DEFB 152
DEFB 125
DEFB 3
DEFB 188
DEFB 188
DEFB 4
DEFB 190
DEFB 126
DEFB 3
DEFB 171
DEFB 152
DEFB 126
DEFB 3
DEFB 171
DEFB 188
DEFB 126
DEFB 3
DEFB 190
DEFB 126
DEFB 3
DEFB 168
DEFB 159
DEFB 125
DEFB 3
DEFB 188
DEFB 157
DEFB 4
DEFB 190
DEFB 156
DEFB 126
DEFB 3
DEFB 171
DEFB 152
DEFB 126
DEFB 3
DEFB 188
DEFB 188
DEFB 4
DEFB 171
DEFB 126
DEFB 3
DEFB 168
DEFB 152
DEFB 125
DEFB 3
DEFB 188
DEFB 188
DEFB 4
DEFB 168
DEFB 124
DEFB 3
DEFB 166
DEFB 152
DEFB 125
DEFB 3
DEFB 166
DEFB 188
DEFB 124
DEFB 3
DEFB 190
DEFB 126
DEFB 3
DEFB 168
DEFB 159
DEFB 124
DEFB 3
DEFB 188
DEFB 157
DEFB 121
DEFB 3
DEFB 190
DEFB 156
DEFB 122
DEFB 3
DEFB 168
DEFB 154
DEFB 123
DEFB 3
DEFB 169
DEFB 188
DEFB 4
DEFB 171
DEFB 126
DEFB 3
DEFB 169
DEFB 154
DEFB 125
DEFB 3
DEFB 188
DEFB 188
DEFB 4
DEFB 190
DEFB 126
DEFB 3
DEFB 190
DEFB 154
DEFB 126
DEFB 3
DEFB 190
DEFB 188
DEFB 126
DEFB 3
DEFB 190
DEFB 126
DEFB 3
DEFB 190
DEFB 159
DEFB 125
DEFB 3
DEFB 190
DEFB 157
DEFB 4
DEFB 190
DEFB 156
DEFB 126
DEFB 3
DEFB $BD,4
DEFB 164
DEFB 157
DEFB 126
DEFB 3
DEFB 188
DEFB 188
DEFB 4
DEFB 164
DEFB 126
DEFB 3
DEFB 188
DEFB 157
DEFB 125
DEFB 3
DEFB 159
DEFB 188
DEFB 126
DEFB 3
DEFB 161
DEFB 125
DEFB 3
DEFB 164
DEFB 157
DEFB 126
DEFB 3
DEFB 188
DEFB 188
DEFB 4
DEFB 166
DEFB 126
DEFB 3
DEFB 188
DEFB 159
DEFB 126
DEFB 3
DEFB 164
DEFB 157
DEFB 126
DEFB 3
DEFB 190
DEFB 156
DEFB 125
DEFB 3
DEFB $00
.pat1
DEFB $BD,2
DEFB 159
DEFB 152
DEFB 126
DEFB 3
DEFB 161
DEFB 152
DEFB 124
DEFB 3
DEFB 159
DEFB 152
DEFB 126
DEFB 3
DEFB 164
DEFB 152
DEFB 125
DEFB 3
DEFB 166
DEFB 152
DEFB 4
DEFB 171
DEFB 152
DEFB 126
DEFB 3
DEFB 169
DEFB 152
DEFB 126
DEFB 3
DEFB 168
DEFB 152
DEFB 126
DEFB 3
DEFB 164
DEFB 152
DEFB 126
DEFB 3
DEFB 166
DEFB 152
DEFB 125
DEFB 3
DEFB 190
DEFB 152
DEFB 4
DEFB 168
DEFB 152
DEFB 126
DEFB 3
DEFB $BD,0
DEFB 159
DEFB 154
DEFB 126
DEFB 3
DEFB 161
DEFB 154
DEFB 4
DEFB 159
DEFB 154
DEFB 126
DEFB 3
DEFB 164
DEFB 154
DEFB 125
DEFB 3
DEFB 166
DEFB 154
DEFB 4
DEFB 171
DEFB 154
DEFB 124
DEFB 3
DEFB 169
DEFB 154
DEFB 125
DEFB 3
DEFB 168
DEFB 154
DEFB 124
DEFB 3
DEFB 164
DEFB 154
DEFB 126
DEFB 3
DEFB 166
DEFB 154
DEFB 124
DEFB 3
DEFB 190
DEFB 154
DEFB 121
DEFB 3
DEFB 164
DEFB 154
DEFB 122
DEFB 3
DEFB 190
DEFB 157
DEFB 123
DEFB 3
DEFB 190
DEFB 157
DEFB 4
DEFB 190
DEFB 157
DEFB 126
DEFB 3
DEFB 190
DEFB 157
DEFB 125
DEFB 3
DEFB 190
DEFB 157
DEFB 4
DEFB 190
DEFB 157
DEFB 126
DEFB 3
DEFB 190
DEFB 157
DEFB 126
DEFB 3
DEFB 190
DEFB 157
DEFB 126
DEFB 3
DEFB 190
DEFB 157
DEFB 126
DEFB 3
DEFB 190
DEFB 157
DEFB 125
DEFB 3
DEFB 190
DEFB 157
DEFB 4
DEFB 190
DEFB 157
DEFB 126
DEFB 3
DEFB $BD,2
DEFB 173
DEFB 159
DEFB 126
DEFB 3
DEFB 190
DEFB 159
DEFB 4
DEFB 171
DEFB 159
DEFB 126
DEFB 3
DEFB 190
DEFB 159
DEFB 125
DEFB 3
DEFB 164
DEFB 159
DEFB 126
DEFB 3
DEFB 190
DEFB 159
DEFB 125
DEFB 3
DEFB 159
DEFB 159
DEFB 126
DEFB 3
DEFB 190
DEFB 159
DEFB 4
DEFB 161
DEFB 159
DEFB 126
DEFB 3
DEFB 161
DEFB 159
DEFB 126
DEFB 3
DEFB 164
DEFB 159
DEFB 126
DEFB 3
DEFB 190
DEFB 159
DEFB 125
DEFB 3
DEFB $00
#endasm
