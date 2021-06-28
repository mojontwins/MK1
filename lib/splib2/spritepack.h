
#ifndef _SPRITEPACK_H
#define _SPRITEPACK_H

/*
 *      Sprite Pack V2.2 for the Z88DK Small C+ Cross Compiler
 * 
 *      Visit http://www.geocities.com/aralbrec
 *      for a tutorial introduction.
 *
 *      Z88DK: http://z88dk.sourceforge.net/
 *
 *      The library supports all the video modes of the
 *      Spectrum and Timex machines and a number of
 *      input devices.  The package should be customized
 *      by editing the SPconfig.def file and then compiled to
 *      create a customized lib by running the makefile.
 *
 *      Alvin Albrecht 08.2003
 */

#undef NULL
#define NULL 0

#ifndef NOREDEF
typedef unsigned char uchar;
typedef unsigned int uint;
#endif

/* User's Memory Allocation Policy */

extern void *u_malloc;      /* void *(*u_malloc)(uint bytes) */
extern void *u_free;        /* void  (*u_free)(void *addr)   */


/* sprite types */

#define sp_MASK_SPRITE    0x00
#define sp_OR_SPRITE      0x40
#define sp_XOR_SPRITE     0x80
#define sp_LOAD_SPRITE    0xc0


/* masks for joystick functions */

#define sp_FIRE           0x80
#define sp_RIGHT          0x08
#define sp_LEFT           0x04
#define sp_DOWN           0x02
#define sp_UP             0x01


/* masks for mouse buttons */

#define sp_MLEFT          0x01
#define sp_BUT1           0x01
#define sp_MMID           0x04
#define sp_BUT3           0x04
#define sp_MRIGHT         0x02
#define sp_BUT2           0x02


/* Print String Struct Flags */

#define sp_PSS_INVALIDATE   0x01
#define sp_PSS_XWRAP        0x02
#define sp_PSS_YINC         0x04


/* Clear Rectangle Flags */

#define sp_CR_TILES         0x01
#define sp_CR_SPRITES       0x02
#define sp_CR_ALL           0x03


/* Colour Attributes */

#define BLACK          0x00
#define BLUE           0x01
#define RED            0x02
#define MAGENTA        0x03
#define GREEN          0x04
#define CYAN           0x05
#define YELLOW         0x06
#define WHITE          0x07
#define INK_BLACK      0x00
#define INK_BLUE       0x01
#define INK_RED        0x02
#define INK_MAGENTA    0x03
#define INK_GREEN      0x04
#define INK_CYAN       0x05
#define INK_YELLOW     0x06
#define INK_WHITE      0x07
#define PAPER_BLACK    0x00
#define PAPER_BLUE     0x08
#define PAPER_RED      0x10
#define PAPER_MAGENTA  0x18
#define PAPER_GREEN    0x20
#define PAPER_CYAN     0x28
#define PAPER_YELLOW   0x30
#define PAPER_WHITE    0x38
#define BRIGHT         0x40
#define FLASH          0x80
#define TRANSPARENT    0x80


/* AY Chip Port Addresses - don't use, incomplete

#define AYREG_2068     0xf5
#define AYDAT_2068     0xf6
#define AYREG_128      0xfffd
#define AYDAT_128      0xbffd
#define AYREG_FULLER   0x3f
#define AYDAT_FULLER   0x5f

struct sp_AYSTATE {
   uint  mask;
   uchar R13, R12, R11, R10, R9, R8, R7, R6, R5, R4, R3, R2, R1, R0;
};

struct sp_AYPSG2 {
   uchar      count;
   uchar     *addr;
   uint       map;
};

*/


/* SP's Sprite Struct */

struct sp_SS {
   uchar row;           /* -------- */
   uchar col;           /* struct   */
   uchar height;        /* sp_Rect  */
   uchar width;         /* -------- */
   uchar hor_rot;
   uchar ver_rot;
   uchar *first;        /* big endian!! */
   uchar *last_col;
   uchar *last;
   uchar plane;
   uchar type;
};


/* SP's Char Struct */

struct sp_CS {
   uchar *next_in_spr;  /* big endian!! */
   uchar *prev;         /* big endian!! */
   uchar spr_attr;      /* sprite type (bits 6..7) | sprite plane (bits 0..5) */
   uchar *left_graphic;
   uchar *graphic;
   uchar hor_rot;
   uchar colour;        /* attribute in spectrum mode, threshold in hi-colour mode */
   uchar *next;         /* big endian!! */
   uchar unused;
};


/* Small Rectangles with 8-bit coordinates (used by SP where units are characters) */

struct sp_Rect {
   uchar row_coord;     /* coordinate of top left corner */
   uchar col_coord;
   uchar height;        /* size */
   uchar width;
};


/* SP's Print String Struct */

struct sp_PSS {
   struct sp_Rect *bounds;  /* bounding rectangle for printed text */
   uchar flags;             /* bit 0=invalidate?, 1=xwrap?, 2=yinc?, 3=onscreen? (res) */
   uchar x;                 /* current x coordinate relative to bounding rect */
   uchar y;                 /* current y coordinate relative to bounding rect */
   uchar colour;            /* current attribute */
   void *dlist;             /* reserved */
   void *dirtychars;        /* reserved */
   uchar dirtybit;          /* reserved */
};


/* Large Rectangles with 16-bit coordinates (not used by SP itself) */

struct sp_LargeRect {
   uint top;            /* Interval #1 */
   uint bottom;
   uint left;           /* Interval #2 */
   uint right;
};

struct sp_Interval {    /* [x1,x2]    */
   uint x1;             /* left side  */
   uint x2;             /* right side */
};


/* user defined keys structure */

struct sp_UDK {
   uint fire;     /* These are word long scan codes.       */
   uint right;    /* Use "LookupKey" to get scan codes.    */
   uint left;
   uint down;
   uint up;
};


/* structures for simulated mouse */

struct sp_MD {       /* mouse delta */
   uchar             maxcount;
   uint              dx;
   uint              dy;
};

struct sp_UDM {
   struct sp_UDK    *keys;        /* parameter if JoyKeyboard() is used else ignored */
   void             *joyfunc;     /* joystick function for reading input */
   struct sp_MD    **delta;       /* pointer to array of sp_MD; last max count must be 255 */
   uchar             state;       /* current index into delta array */
   uchar             count;       /* current count */
   uint              y;           /* current (x,y) coordinate, fixed point */
   uint              x;
};


/* LIST structures for linked list ADT */

struct sp_ListNode {              /* Invisible to User */
   void               *item;
   struct sp_ListNode *next;
   struct sp_ListNode *prev;
};

struct sp_List {
   uint               count;      /* number of NODEs in list */
   uchar              state;      /* state of curr ptr: 1 = INLIST, 0 = BEFORE, 2 = AFTER */
   struct sp_ListNode *current;   /* points at current NODE in list, big endian */
   struct sp_ListNode *head;      /* points at first NODE in list, big endian */
   struct sp_ListNode *tail;      /* points at last NODE in list, big endian */
};


/* HASH TABLE structures for hashtable ADT */

struct sp_HashCell {
   void *key;
   void *value;
   struct sp_HashCell *next;
};

struct sp_HashTable {
   uint               size;       /* size of table */
   struct sp_HashCell **table;    /* table of 'buckets'*/
   void               *hashfunc;  /* uint (*hashfunc)(void *key, uint size) */
   void               *match;     /* int (*match)(void *key1, void *key2); also set crry if = */
   void               *delete;    /* void (*delete)(struct sp_HashCell *hc); delete key,value */
};


/* Huffman Codec Structs */

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
   uint c;                /* msb = 0 to indicate leaf node, lsb is symbol */
};

struct sp_HuffmanCodec {
   uint     symbols;      /* no. of source symbols 1..256       */
   void     *addr;        /* current memory address pointer     */
   uchar    bit;          /* current bit within memory address  */
   void     *root;        /* root of decoder tree               */
   union {
      struct sp_HuffmanLeaf **heap;     /* array accumulates symbol frequencies             */ 
      struct sp_HuffmanLeaf **encoder;  /* arr indexed by symbol pts at leaves in dec. tree */
                  /* ^ only required if encoding, can free this array after sp_HuffExtract  */
   } u;
};


/* SP Variables -- declare these in your main.c file exactly once if needed */

/*

extern struct sp_Rect *sp_ClipStruct;
#asm
LIB SPCClipStruct
._sp_ClipStruct         defw SPCClipStruct
#endasm

extern uchar *sp_NullSprPtr;
#asm
LIB SPNullSprPtr
._sp_NullSprPtr         defw SPNullSprPtr
#endasm

extern uchar *sp_CompNullSprPtr;        // for COMPRESSed sprites
#asm
LIB SPCompNullSprPtr
._sp_CompNullSprPtr     defw SPCompNullSprPtr
#endasm

extern uchar *sp_KeyDebounce;           // requires sp_GetKey()
#asm
XREF SPkeydebounce
._sp_KeyDebounce        defw SPkeydebounce
#endasm

extern uchar *sp_KeyStartRepeat;        // requires sp_GetKey()
#asm
XREF SPkeystartrepeat
._sp_KeyStartRepeat     defw SPkeystartrepeat
#endasm

extern uchar *sp_KeyRepeatPeriod;       // requires sp_GetKey()
#asm
XREF SPkeyrepeatperiod
._sp_KeyRepeatPeriod    defw SPkeyrepeatperiod
#endasm

extern uchar *sp_KeyTransTable;
#asm
LIB SPkeytranstbl
._sp_KeyTransTable      defw SPkeytranstbl
#endasm

extern uint *sp_GenericISRSize;         // requires sp_CreateGenericISR()
#asm
XREF GENERICISRSIZE
._sp_GenericISRSize     defw GENERICISRSIZE
#endasm

extern uint *sp_MouseAMXdx;             // requires sp_MouseAMXInit()
#asm
XREF SPAMXDX
._sp_MouseAMXdx         defw SPAMXDX
#endasm

extern uint *sp_MouseAMXdy;             // requires sp_MouseAMXInit()
#asm
XREF SPAMXDY
._sp_MouseAMXdy         defw SPAMXDY
#endasm

extern uchar *sp_Screen;                // for DISP_TMXDUAL double buffering
#asm
XREF SPScreen
._sp_Screen             defw SPScreen
#endasm

extern uint *sp_Random32Seed;           // requires sp_Random32()
#asm
XREF SPRand32Seed
._sp_Random32Seed       defw SPRand32Seed
#endasm

extern uchar *sp_AY_RegPort;
#asm
LIB SPAYReg
._sp_AY_Reg              defw SPAYReg
#endasm

extern uchar *sp_AY_DataPort;
#asm
LIB SPAYReg
XREF SPAYData
._sp_AY_Data             defw SPAYData
#endasm

extern uchar *sp_BorderClr;             // requires sp_Border()
#asm
XREF SPBorderClr
._sp_BorderClr           defw SPBorderClr
#endasm

*/


/* interrupt mode 2 */

extern void __LIB__  sp_InitIM2(void *default_isr);           /* void (*default_isr)(void)  */
extern void __LIB__ *sp_InstallISR(uchar vector, void *isr);          /* void (*isr)(void)  */
extern void __LIB__  sp_EmptyISR(void);
extern void __LIB__ *sp_CreateGenericISR(void *addr);
extern void __LIB__  sp_RegisterHook(uchar vector, void *hook);       /* void (*hook)(void) */
extern void __LIB__  sp_RegisterHookFirst(uchar vector, void *hook);  /* void (*hook)(void) */
extern void __LIB__  sp_RegisterHookLast(uchar vector, void *hook);   /* void (*hook)(void) */
extern int  __LIB__  sp_RemoveHook(uchar vector, void *hook);         /* void (*hook)(void) */


/* miscellaneous functions */

extern void __LIB__  sp_Initialize(uchar colour, uchar udg);
extern void __LIB__ *sp_SwapEndian(void *ptr);
extern void __LIB__  sp_Swap(void *addr1, void *addr2, uint bytes);
extern int  __LIB__  sp_PFill(uint xcoord, uchar ycoord, void *pattern, uint stackdepth);
extern int  __LIB__  sp_StackSpace(void *addr);    /* returns "SP - addr" */
extern uint __LIB__  sp_Random32(uint *hi);        /* returns 32 bit random number */
extern void __LIB__  sp_Border(uchar colour);      /* set border colour */
extern uchar __LIB__ sp_inp(uint port);
extern void __LIB__  sp_outp(uint port, uchar value);


/* rectangle, interval and point intersections (miscellaneous directory) */

extern int  __LIB__  sp_IntRect(struct sp_Rect *r1, struct sp_Rect *r2, struct sp_Rect *result);
extern int  __LIB__  sp_IntLargeRect(struct sp_LargeRect *r1, struct sp_LargeRect *r2, struct sp_LargeRect *result);
extern int  __LIB__  sp_IntPtLargeRect(uint x, uint y, struct sp_LargeRect *r);
extern int  __LIB__  sp_IntIntervals(struct sp_Interval *i1, struct sp_Interval *i2, struct sp_Interval *result);
extern int  __LIB__  sp_IntPtInterval(uint x, struct sp_Interval *i);


/* sprites */

extern struct sp_SS __LIB__ *sp_CreateSpr(uchar type, uchar rows, void *graphic);
extern int  __LIB__  sp_AddColSpr(struct sp_SS *sprite, void *graphic);
extern void __LIB__  sp_DeleteSpr(struct sp_SS *sprite);
extern void __LIB__  sp_IterateSprChar(struct sp_SS *sprite, void *hook);
                                       /* void (*hook)(struct sp_CS *cs)) */
extern void __LIB__  sp_RemoveDList(struct sp_SS *sprite);
extern void __LIB__  sp_MoveSprAbs(struct sp_SS *sprite, struct sp_Rect *clip, int animate, uchar row, uchar col, uchar hpix, uchar vpix);
extern void __LIB__  sp_MoveSprAbsC(struct sp_SS *sprite, struct sp_Rect *clip, int animate, uchar row, uchar col, uchar hpix, uchar vpix);
extern void __LIB__  sp_MoveSprAbsNC(struct sp_SS *sprite, struct sp_Rect *clip, int animate, uchar row, uchar col, uchar hpix, uchar vpix);
extern void __LIB__  sp_MoveSprRel(struct sp_SS *sprite, struct sp_Rect *clip, int animate, char rel_row, char rel_col, char rel_hpix, char rel_vpix);
extern void __LIB__  sp_MoveSprRelC(struct sp_SS *sprite, struct sp_Rect *clip, int animate, char rel_row, char rel_col, char rel_hpix, char rel_vpix);
extern void __LIB__  sp_MoveSprRelNC(struct sp_SS *sprite, struct sp_Rect *clip, int animate, char rel_row, char rel_col, char rel_hpix, char rel_vpix);


/* background tiles */

extern void __LIB__  sp_PrintAt(uchar row, uchar col, uchar colour, uchar udg);
extern void __LIB__  sp_PrintAtInv(uchar row, uchar col, uchar colour, uchar udg);
extern uint __LIB__  sp_ScreenStr(uchar row, uchar col);
extern void __LIB__  sp_PrintAtDiff(uchar row, uchar col, uchar colour, uchar udg);
extern void __LIB__  sp_PrintString(struct sp_PSS *ps, uchar *s);
extern void __LIB__  sp_ComputePos(struct sp_PSS *ps, uchar x, uchar y);
extern void __LIB__ *sp_TileArray(uchar c, void *addr);
extern void __LIB__ *sp_Pallette(uchar c, void *addr);
extern void __LIB__  sp_GetTiles(struct sp_Rect *r, void *dest);
extern void __LIB__  sp_PutTiles(struct sp_Rect *r, void *src);
extern void __LIB__  sp_IterateDList(struct sp_Rect *r, void *hook);
                     /* ^ void (*hook)(void *dlist_addr) */


/* dynamic block memory allocator */

extern void __LIB__ *sp_AddMemory(uchar queue, uchar number, uint size, void *addr);
extern void __LIB__ *sp_BlockAlloc(uchar queue);
extern void __LIB__ *sp_BlockFit(uchar queue, uchar numcheck);
extern void __LIB__  sp_FreeBlock(void *addr);
extern void __LIB__  sp_InitAlloc(void);
extern uint __LIB__  sp_BlockCount(uchar queue);


/* updater */

extern void __LIB__  sp_Invalidate(struct sp_Rect *area, struct sp_Rect *clip);
extern void __LIB__  sp_Validate(struct sp_Rect *area, struct sp_Rect *clip);
extern void __LIB__  sp_ClearRect(struct sp_Rect *area, uchar colour, uchar udg, uchar flags);
extern void __LIB__  sp_UpdateNow(void);
extern void __LIB__  sp_UpdateNowEx(unsigned char doSprites);
extern void __LIB__ *sp_CompDListAddr(uchar row, uchar col);
extern void __LIB__ *sp_CompDirtyAddr(uchar row, uchar col, uchar *mask);


/* input */

extern uchar __LIB__ sp_JoySinclair1(void);
extern uchar __LIB__ sp_JoySinclair2(void);
extern uchar __LIB__ sp_JoyTimexEither(void);
extern uchar __LIB__ sp_JoyTimexLeft(void);
extern uchar __LIB__ sp_JoyTimexRight(void);
extern uchar __LIB__ sp_JoyFuller(void);
extern uchar __LIB__ sp_JoyKempston(void);
extern uchar __LIB__ sp_JoyKeyboard(struct sp_UDK *keys);
extern void  __LIB__ sp_WaitForKey(void);
extern void  __LIB__ sp_WaitForNoKey(void);
extern uint  __LIB__ sp_Pause(uint ticks);
extern void  __LIB__ sp_Wait(uint ticks);
extern uint  __LIB__ sp_LookupKey(uchar c);  /* use "iferror(..)" to see if char not found */
extern uchar __LIB__ sp_GetKey(void);        /* returns ascii code, 0 if no key pressed */
extern uchar __LIB__ sp_Inkey(void);         /* returns ascii code, 0 if no key pressed */
extern int   __LIB__ sp_KeyPressed(uint scancode);
extern void  __LIB__ sp_MouseAMXInit(uchar xvector, uchar yvector);
extern void  __LIB__ sp_MouseAMX(uint *xcoord, uchar *ycoord, uchar *buttons);
extern void  __LIB__ sp_SetMousePosAMX(uint xcoord, uchar ycoord);
extern void  __LIB__ sp_MouseKempston(uint *xcoord, uchar *ycoord, uchar *buttons);
extern void  __LIB__ sp_SetMousePosKempston(uint xcoord, uchar ycoord);
extern void  __LIB__ sp_MouseSim(struct sp_UDM *m, uint *xcoord, uchar *ycoord, uchar *buttons);
extern void  __LIB__ sp_SetMousePosSim(struct sp_UDM *m, uint xcoord, uchar ycoord);


/* screen address helpers */

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


/* AY Sound Chip - don't use incomplete

extern void  __LIB__ sp_AY_Reset(void);
extern void  __LIB__ sp_AY_Silence(void);
extern void  __LIB__ sp_AY_SaveState(struct sp_AYSTATE *s, uint mask);
extern void  __LIB__ sp_AY_RestoreState(struct sp_AYSTATE *s, uint mask);
extern void  __LIB__ sp_AY_Out(uchar reg, uchar data);
extern uchar __LIB__ sp_AY_In(uchar reg);
extern uchar __LIB__ *sp_AY_OutList(uchar *addr);
extern void  __LIB__ sp_AY_PlayPSG2(struct sp_AYPSG2 *s);

*/


/* linked list ADT */

extern struct sp_List __LIB__ *sp_ListCreate(void);
extern uint __LIB__  sp_ListCount(struct sp_List *list);
extern void __LIB__ *sp_ListFirst(struct sp_List *list);
extern void __LIB__ *sp_ListLast(struct sp_List *list);
extern void __LIB__ *sp_ListNext(struct sp_List *list);
extern void __LIB__ *sp_ListPrev(struct sp_List *list);
extern void __LIB__ *sp_ListCurr(struct sp_List *list);
extern int  __LIB__  sp_ListAdd(struct sp_List *list, void *item);
extern int  __LIB__  sp_ListInsert(struct sp_List *list, void *item);
extern int  __LIB__  sp_ListAppend(struct sp_List *list, void *item);
extern int  __LIB__  sp_ListPrepend(struct sp_List *list, void *item);
extern void __LIB__ *sp_ListRemove(struct sp_List *list);
extern void __LIB__  sp_ListConcat(struct sp_List *list1, struct sp_List *list2);
extern void __LIB__  sp_ListFree(struct sp_List *list, void *free);
                                 /* void (*free)(void *item) */
extern void __LIB__ *sp_ListTrim(struct sp_List *list);
extern void __LIB__ *sp_ListSearch(struct sp_List *list, void *match, void *item1);
                                 /* int (*match)(void *item1, void *item2); Set carry if = */


/* hashtable ADT */

extern struct sp_HashTable __LIB__ *sp_HashCreate(uint size, void *hashfunc, void *match, void *delete);
extern struct sp_HashCell  __LIB__ *sp_HashRemove(struct sp_HashTable *ht, void *key);
extern void __LIB__ *sp_HashLookup(struct sp_HashTable *ht, void *key);
extern void __LIB__ *sp_HashAdd(struct sp_HashTable *ht, void *key, void *value);
extern void __LIB__  sp_HashDelete(struct sp_HashTable *ht);


/* heap array ADT aka priority queue */

/*
   The heap is an array of void* with indices 1..N used to store items (you must allocate array)
   In the following:
     void *compare  <-->  int (*compare)(void *item1, void *item2)
                          return carry set and true if item1>item2 for max heap
                          return carry set and true if item1<item2 for min heap
*/

extern void __LIB__ sp_Heapify(void **array, uint n, void *compare);
extern void __LIB__ sp_HeapSiftDown(uint start, void **array, uint n, void *compare);
extern void __LIB__ sp_HeapSiftUp(uint start, void **array, void *compare);
extern void __LIB__ sp_HeapAdd(void *item, void **array, uint n, void *compare); /* n++ after */
extern void __LIB__ sp_HeapExtract(void **array, uint n, void *compare);         /* n-- after */
                    /* ^ extracts item stored in array[1], moved to array[n] after call */


/* static huffman codec

   CREATE
   1. Create huffman codec by calling sp_HuffCreate with the # of source symbols (1..256).
   2. Call sp_HuffAccumulate for each symbol in the source message.
      This accumulates a frequency table for the occurrence of each symbol.
   3. Call sp_HuffExtract to finalize the Huffman Codec.  This will create the
      decoder tree based on the accumulated frequencies in the source message.
      Once this has been called do not accumulate more symbols.  If the call fails,
      it can be called again to finish the extraction once more memory is made available.

   DECODE
   1. Set the start address and bit of the Huffman encoded data block by calling
      sp_HuffSetState.  Bit=0x80 to use the full initial byte.
   3. Each call to sp_HuffDecode will return the next decoded symbol and will
      automatically advance the address/bit for the next symbol.

   ENCODE
   1. Set the start address and bit of where to place the Huffman encoded block
      by calling sp_HuffSetState.  Bit=0x80 will use the full initial byte.
   2. Call sp_HuffEncode with each symbol to encode.  Encoded symbols will be written
      to memory in each call, automatically advancing memory pointers.
*/

extern struct sp_HuffmanCodec  __LIB__ *sp_HuffCreate(uint symbols);
extern void  __LIB__  sp_HuffDelete(struct sp_HuffmanCodec *hc);
extern void  __LIB__  sp_HuffAccumulate(struct sp_HuffmanCodec *hc, uchar c);
extern int   __LIB__  sp_HuffExtract(struct sp_HuffmanCodec *hc, uint n);
                      /* ^ return 0 = success, else n; enter n=0 if first call */
extern void  __LIB__  sp_HuffSetState(struct sp_HuffmanCodec *hc, void *addr, uchar bit);
extern void  __LIB__ *sp_HuffGetState(struct sp_HuffmanCodec *hc, uchar *bit);
extern uchar __LIB__  sp_HuffDecode(struct sp_HuffmanCodec *hc);
extern void  __LIB__  sp_HuffEncode(struct sp_HuffmanCodec *hc, uchar c);


#endif  /* _SPRITEPACK_H */
