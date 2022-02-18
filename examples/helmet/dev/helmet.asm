;* * * * *  Small-C/Plus z88dk * * * * *
;  Version: 18462-8d70c5a-20210624
;
;	Reconstructed for z80 Module Assembler
;
;	Module compile time: Fri Feb 18 11:03:09 2022


;#line 1 "mk1.c"
	C_LINE	1,"C:\DOCUME~1\ADMINI~1\CONFIG~1\Temp\zcc00000D546EDC2.i"
	C_LINE	0,"mk1.c"

	MODULE	mk1_c


	INCLUDE "z80_crt0.hdr"


; 
	C_LINE	1,"mk1.c"
; 
	C_LINE	2,"mk1.c"
; 
	C_LINE	4,"mk1.c"
; 
	C_LINE	5,"mk1.c"
;#line 1 "c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	6,"mk1.c"
	C_LINE	0,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	5,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;typedef unsigned char uchar;
	C_LINE	26,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	26,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;typedef unsigned int uint;
	C_LINE	27,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	27,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	30,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void *u_malloc;       
	C_LINE	32,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	32,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void *u_free;         
	C_LINE	33,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	33,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	36,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	44,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	53,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	63,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	70,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	77,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	108,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	131,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_SS {
	C_LINE	133,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	133,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar row;            
	C_LINE	134,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar col;            
	C_LINE	135,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar height;         
	C_LINE	136,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar width;          
	C_LINE	137,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar hor_rot;
	C_LINE	138,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar ver_rot;
	C_LINE	139,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar *first;         
	C_LINE	140,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar *last_col;
	C_LINE	141,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar *last;
	C_LINE	142,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar plane;
	C_LINE	143,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar type;
	C_LINE	144,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	145,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	148,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_CS {
	C_LINE	150,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	150,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar *next_in_spr;   
	C_LINE	151,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar *prev;          
	C_LINE	152,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar spr_attr;       
	C_LINE	153,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar *left_graphic;
	C_LINE	154,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar *graphic;
	C_LINE	155,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar hor_rot;
	C_LINE	156,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar colour;         
	C_LINE	157,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar *next;          
	C_LINE	158,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar unused;
	C_LINE	159,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	160,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	163,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_Rect {
	C_LINE	165,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	165,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar row_coord;      
	C_LINE	166,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar col_coord;
	C_LINE	167,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar height;         
	C_LINE	168,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar width;
	C_LINE	169,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	170,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	173,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_PSS {
	C_LINE	175,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	175,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   struct sp_Rect *bounds;   
	C_LINE	176,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar flags;              
	C_LINE	177,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar x;                  
	C_LINE	178,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar y;                  
	C_LINE	179,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar colour;             
	C_LINE	180,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   void *dlist;              
	C_LINE	181,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   void *dirtychars;         
	C_LINE	182,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar dirtybit;           
	C_LINE	183,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	184,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	187,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_LargeRect {
	C_LINE	189,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	189,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint top;             
	C_LINE	190,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint bottom;
	C_LINE	191,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint left;            
	C_LINE	192,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint right;
	C_LINE	193,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	194,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_Interval {     
	C_LINE	196,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	196,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint x1;              
	C_LINE	197,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint x2;              
	C_LINE	198,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	199,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	202,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_UDK {
	C_LINE	204,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	204,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint fire;      
	C_LINE	205,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint right;     
	C_LINE	206,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint left;
	C_LINE	207,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint down;
	C_LINE	208,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint up;
	C_LINE	209,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	210,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	213,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_MD {        
	C_LINE	215,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	215,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar             maxcount;
	C_LINE	216,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint              dx;
	C_LINE	217,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint              dy;
	C_LINE	218,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	219,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_UDM {
	C_LINE	221,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	221,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   struct sp_UDK    *keys;         
	C_LINE	222,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   void             *joyfunc;      
	C_LINE	223,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   struct sp_MD    **delta;        
	C_LINE	224,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar             state;        
	C_LINE	225,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar             count;        
	C_LINE	226,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint              y;            
	C_LINE	227,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint              x;
	C_LINE	228,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	229,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	232,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_ListNode {               
	C_LINE	234,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	234,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   void               *item;
	C_LINE	235,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   struct sp_ListNode *next;
	C_LINE	236,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   struct sp_ListNode *prev;
	C_LINE	237,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	238,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_List {
	C_LINE	240,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	240,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint               count;       
	C_LINE	241,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar              state;       
	C_LINE	242,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   struct sp_ListNode *current;    
	C_LINE	243,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   struct sp_ListNode *head;       
	C_LINE	244,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   struct sp_ListNode *tail;       
	C_LINE	245,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	246,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	249,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_HashCell {
	C_LINE	251,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	251,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   void *key;
	C_LINE	252,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   void *value;
	C_LINE	253,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   struct sp_HashCell *next;
	C_LINE	254,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	255,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_HashTable {
	C_LINE	257,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	257,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint               size;        
	C_LINE	258,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   struct sp_HashCell **table;     
	C_LINE	259,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   void               *hashfunc;   
	C_LINE	260,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   void               *match;      
	C_LINE	261,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   void               *delete;     
	C_LINE	262,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	263,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	266,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_HuffmanJoin {
	C_LINE	268,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	268,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   union {
	C_LINE	269,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;      uint freq;
	C_LINE	270,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;      void *parent;
	C_LINE	271,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   } u;
	C_LINE	272,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   void *left;
	C_LINE	273,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   void *right;
	C_LINE	274,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	275,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_HuffmanLeaf {
	C_LINE	277,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	277,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   union {
	C_LINE	278,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;      uint freq;
	C_LINE	279,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;      void *parent;
	C_LINE	280,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   } u;
	C_LINE	281,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint c;                 
	C_LINE	282,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	283,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;struct sp_HuffmanCodec {
	C_LINE	285,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	285,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uint     symbols;       
	C_LINE	286,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   void     *addr;         
	C_LINE	287,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   uchar    bit;           
	C_LINE	288,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   void     *root;         
	C_LINE	289,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   union {
	C_LINE	290,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;      struct sp_HuffmanLeaf **heap;       
	C_LINE	291,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;      struct sp_HuffmanLeaf **encoder;   
	C_LINE	292,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;                   
	C_LINE	293,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;   } u;
	C_LINE	294,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;};
	C_LINE	295,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	298,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	300,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	396,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_InitIM2(void *default_isr);            
	C_LINE	398,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	398,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_InstallISR(uchar vector, void *isr);           
	C_LINE	399,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	399,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_EmptyISR(void);
	C_LINE	400,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	400,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_CreateGenericISR(void *addr);
	C_LINE	401,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	401,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_RegisterHook(uchar vector, void *hook);        
	C_LINE	402,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	402,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_RegisterHookFirst(uchar vector, void *hook);   
	C_LINE	403,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	403,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_RegisterHookLast(uchar vector, void *hook);    
	C_LINE	404,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	404,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int  __LIB__  sp_RemoveHook(uchar vector, void *hook);          
	C_LINE	405,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	405,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	408,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_Initialize(uchar colour, uchar udg);
	C_LINE	410,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	410,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_SwapEndian(void *ptr);
	C_LINE	411,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	411,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_Swap(void *addr1, void *addr2, uint bytes);
	C_LINE	412,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	412,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int  __LIB__  sp_PFill(uint xcoord, uchar ycoord, void *pattern, uint stackdepth);
	C_LINE	413,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	413,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int  __LIB__  sp_StackSpace(void *addr);     
	C_LINE	414,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	414,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uint __LIB__  sp_Random32(uint *hi);         
	C_LINE	415,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	415,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_Border(uchar colour);       
	C_LINE	416,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	416,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uchar __LIB__ sp_inp(uint port);
	C_LINE	417,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	417,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_outp(uint port, uchar value);
	C_LINE	418,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	418,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	421,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int  __LIB__  sp_IntRect(struct sp_Rect *r1, struct sp_Rect *r2, struct sp_Rect *result);
	C_LINE	423,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	423,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int  __LIB__  sp_IntLargeRect(struct sp_LargeRect *r1, struct sp_LargeRect *r2, struct sp_LargeRect *result);
	C_LINE	424,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	424,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int  __LIB__  sp_IntPtLargeRect(uint x, uint y, struct sp_LargeRect *r);
	C_LINE	425,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	425,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int  __LIB__  sp_IntIntervals(struct sp_Interval *i1, struct sp_Interval *i2, struct sp_Interval *result);
	C_LINE	426,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	426,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int  __LIB__  sp_IntPtInterval(uint x, struct sp_Interval *i);
	C_LINE	427,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	427,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	430,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern struct sp_SS __LIB__ *sp_CreateSpr(uchar type, uchar rows, void *graphic);
	C_LINE	432,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	432,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int  __LIB__  sp_AddColSpr(struct sp_SS *sprite, void *graphic);
	C_LINE	433,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	433,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_DeleteSpr(struct sp_SS *sprite);
	C_LINE	434,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	434,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_IterateSprChar(struct sp_SS *sprite, void *hook);
	C_LINE	435,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	435,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;                                        
	C_LINE	436,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_RemoveDList(struct sp_SS *sprite);
	C_LINE	437,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	437,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_MoveSprAbs(struct sp_SS *sprite, struct sp_Rect *clip, int animate, uchar row, uchar col, uchar hpix, uchar vpix);
	C_LINE	438,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	438,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_MoveSprAbsC(struct sp_SS *sprite, struct sp_Rect *clip, int animate, uchar row, uchar col, uchar hpix, uchar vpix);
	C_LINE	439,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	439,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_MoveSprAbsNC(struct sp_SS *sprite, struct sp_Rect *clip, int animate, uchar row, uchar col, uchar hpix, uchar vpix);
	C_LINE	440,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	440,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_MoveSprRel(struct sp_SS *sprite, struct sp_Rect *clip, int animate, char rel_row, char rel_col, char rel_hpix, char rel_vpix);
	C_LINE	441,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	441,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_MoveSprRelC(struct sp_SS *sprite, struct sp_Rect *clip, int animate, char rel_row, char rel_col, char rel_hpix, char rel_vpix);
	C_LINE	442,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	442,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_MoveSprRelNC(struct sp_SS *sprite, struct sp_Rect *clip, int animate, char rel_row, char rel_col, char rel_hpix, char rel_vpix);
	C_LINE	443,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	443,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	446,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_PrintAt(uchar row, uchar col, uchar colour, uchar udg);
	C_LINE	448,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	448,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_PrintAtInv(uchar row, uchar col, uchar colour, uchar udg);
	C_LINE	449,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	449,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uint __LIB__  sp_ScreenStr(uchar row, uchar col);
	C_LINE	450,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	450,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_PrintAtDiff(uchar row, uchar col, uchar colour, uchar udg);
	C_LINE	451,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	451,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_PrintString(struct sp_PSS *ps, uchar *s);
	C_LINE	452,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	452,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_ComputePos(struct sp_PSS *ps, uchar x, uchar y);
	C_LINE	453,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	453,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_TileArray(uchar c, void *addr);
	C_LINE	454,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	454,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_Pallette(uchar c, void *addr);
	C_LINE	455,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	455,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_GetTiles(struct sp_Rect *r, void *dest);
	C_LINE	456,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	456,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_PutTiles(struct sp_Rect *r, void *src);
	C_LINE	457,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	457,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_IterateDList(struct sp_Rect *r, void *hook);
	C_LINE	458,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	458,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;                      
	C_LINE	459,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	462,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_AddMemory(uchar queue, uchar number, uint size, void *addr);
	C_LINE	464,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	464,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_BlockAlloc(uchar queue);
	C_LINE	465,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	465,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_BlockFit(uchar queue, uchar numcheck);
	C_LINE	466,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	466,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_FreeBlock(void *addr);
	C_LINE	467,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	467,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_InitAlloc(void);
	C_LINE	468,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	468,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uint __LIB__  sp_BlockCount(uchar queue);
	C_LINE	469,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	469,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	472,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_Invalidate(struct sp_Rect *area, struct sp_Rect *clip);
	C_LINE	474,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	474,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_Validate(struct sp_Rect *area, struct sp_Rect *clip);
	C_LINE	475,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	475,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_ClearRect(struct sp_Rect *area, uchar colour, uchar udg, uchar flags);
	C_LINE	476,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	476,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_UpdateNow(void);
	C_LINE	477,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	477,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_UpdateNowEx(unsigned char doSprites);
	C_LINE	478,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	478,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_CompDListAddr(uchar row, uchar col);
	C_LINE	479,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	479,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_CompDirtyAddr(uchar row, uchar col, uchar *mask);
	C_LINE	480,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	480,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	483,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uchar __LIB__ sp_JoySinclair1(void);
	C_LINE	485,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	485,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uchar __LIB__ sp_JoySinclair2(void);
	C_LINE	486,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	486,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uchar __LIB__ sp_JoyTimexEither(void);
	C_LINE	487,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	487,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uchar __LIB__ sp_JoyTimexLeft(void);
	C_LINE	488,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	488,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uchar __LIB__ sp_JoyTimexRight(void);
	C_LINE	489,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	489,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uchar __LIB__ sp_JoyFuller(void);
	C_LINE	490,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	490,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uchar __LIB__ sp_JoyKempston(void);
	C_LINE	491,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	491,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uchar __LIB__ sp_JoyKeyboard(struct sp_UDK *keys);
	C_LINE	492,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	492,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__ sp_WaitForKey(void);
	C_LINE	493,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	493,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__ sp_WaitForNoKey(void);
	C_LINE	494,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	494,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uint  __LIB__ sp_Pause(uint ticks);
	C_LINE	495,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	495,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__ sp_Wait(uint ticks);
	C_LINE	496,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	496,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uint  __LIB__ sp_LookupKey(uchar c);   
	C_LINE	497,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	497,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uchar __LIB__ sp_GetKey(void);         
	C_LINE	498,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	498,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uchar __LIB__ sp_Inkey(void);          
	C_LINE	499,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	499,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int   __LIB__ sp_KeyPressed(uint scancode);
	C_LINE	500,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	500,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__ sp_MouseAMXInit(uchar xvector, uchar yvector);
	C_LINE	501,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	501,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__ sp_MouseAMX(uint *xcoord, uchar *ycoord, uchar *buttons);
	C_LINE	502,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	502,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__ sp_SetMousePosAMX(uint xcoord, uchar ycoord);
	C_LINE	503,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	503,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__ sp_MouseKempston(uint *xcoord, uchar *ycoord, uchar *buttons);
	C_LINE	504,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	504,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__ sp_SetMousePosKempston(uint xcoord, uchar ycoord);
	C_LINE	505,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	505,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__ sp_MouseSim(struct sp_UDM *m, uint *xcoord, uchar *ycoord, uchar *buttons);
	C_LINE	506,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	506,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__ sp_SetMousePosSim(struct sp_UDM *m, uint xcoord, uchar ycoord);
	C_LINE	507,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	507,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	510,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_CharDown(void *scrnaddr);
	C_LINE	512,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	512,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_CharLeft(void *scrnaddr);
	C_LINE	513,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	513,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_CharRight(void *scrnaddr);
	C_LINE	514,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	514,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_CharUp(void *scrnaddr);
	C_LINE	515,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	515,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_GetAttrAddr(void *scrnaddr);
	C_LINE	516,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	516,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_GetCharAddr(uchar row, uchar col);
	C_LINE	517,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	517,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_GetScrnAddr(uint xcoord, uchar ycoord, uchar *mask);
	C_LINE	518,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	518,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_PixelDown(void *scrnaddr);
	C_LINE	519,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	519,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_PixelUp(void *scrnaddr);
	C_LINE	520,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	520,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_PixelLeft(void *scrnaddr, uchar *mask);
	C_LINE	521,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	521,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_PixelRight(void *scrnaddr, uchar *mask);
	C_LINE	522,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	522,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	525,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	539,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern struct sp_List __LIB__ *sp_ListCreate(void);
	C_LINE	541,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	541,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uint __LIB__  sp_ListCount(struct sp_List *list);
	C_LINE	542,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	542,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_ListFirst(struct sp_List *list);
	C_LINE	543,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	543,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_ListLast(struct sp_List *list);
	C_LINE	544,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	544,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_ListNext(struct sp_List *list);
	C_LINE	545,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	545,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_ListPrev(struct sp_List *list);
	C_LINE	546,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	546,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_ListCurr(struct sp_List *list);
	C_LINE	547,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	547,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int  __LIB__  sp_ListAdd(struct sp_List *list, void *item);
	C_LINE	548,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	548,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int  __LIB__  sp_ListInsert(struct sp_List *list, void *item);
	C_LINE	549,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	549,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int  __LIB__  sp_ListAppend(struct sp_List *list, void *item);
	C_LINE	550,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	550,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int  __LIB__  sp_ListPrepend(struct sp_List *list, void *item);
	C_LINE	551,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	551,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_ListRemove(struct sp_List *list);
	C_LINE	552,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	552,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_ListConcat(struct sp_List *list1, struct sp_List *list2);
	C_LINE	553,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	553,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_ListFree(struct sp_List *list, void *free);
	C_LINE	554,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	554,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;                                  
	C_LINE	555,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_ListTrim(struct sp_List *list);
	C_LINE	556,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	556,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_ListSearch(struct sp_List *list, void *match, void *item1);
	C_LINE	557,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	557,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;                                  
	C_LINE	558,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	561,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern struct sp_HashTable __LIB__ *sp_HashCreate(uint size, void *hashfunc, void *match, void *delete);
	C_LINE	563,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	563,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern struct sp_HashCell  __LIB__ *sp_HashRemove(struct sp_HashTable *ht, void *key);
	C_LINE	564,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	564,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_HashLookup(struct sp_HashTable *ht, void *key);
	C_LINE	565,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	565,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ *sp_HashAdd(struct sp_HashTable *ht, void *key, void *value);
	C_LINE	566,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	566,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__  sp_HashDelete(struct sp_HashTable *ht);
	C_LINE	567,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	567,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	570,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	572,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ sp_Heapify(void **array, uint n, void *compare);
	C_LINE	580,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	580,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ sp_HeapSiftDown(uint start, void **array, uint n, void *compare);
	C_LINE	581,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	581,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ sp_HeapSiftUp(uint start, void **array, void *compare);
	C_LINE	582,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	582,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ sp_HeapAdd(void *item, void **array, uint n, void *compare);  
	C_LINE	583,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	583,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void __LIB__ sp_HeapExtract(void **array, uint n, void *compare);          
	C_LINE	584,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	584,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;                     
	C_LINE	585,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
; 
	C_LINE	588,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern struct sp_HuffmanCodec  __LIB__ *sp_HuffCreate(uint symbols);
	C_LINE	612,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	612,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__  sp_HuffDelete(struct sp_HuffmanCodec *hc);
	C_LINE	613,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	613,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__  sp_HuffAccumulate(struct sp_HuffmanCodec *hc, uchar c);
	C_LINE	614,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	614,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern int   __LIB__  sp_HuffExtract(struct sp_HuffmanCodec *hc, uint n);
	C_LINE	615,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	615,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;                       
	C_LINE	616,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__  sp_HuffSetState(struct sp_HuffmanCodec *hc, void *addr, uchar bit);
	C_LINE	617,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	617,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__ *sp_HuffGetState(struct sp_HuffmanCodec *hc, uchar *bit);
	C_LINE	618,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	618,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern uchar __LIB__  sp_HuffDecode(struct sp_HuffmanCodec *hc);
	C_LINE	619,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	619,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;extern void  __LIB__  sp_HuffEncode(struct sp_HuffmanCodec *hc, uchar c);
	C_LINE	620,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	620,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
;#line 7 "mk1.c"
	C_LINE	624,"c:\z88dk\Lib\Config\\..\..\/include/spritepack.h"
	C_LINE	6,"mk1.c"
; 
	C_LINE	8,"mk1.c"
;#asm
	C_LINE	9,"mk1.c"
	C_LINE	9,"mk1.c"
	C_LINE	11,"mk1.c"
		LIB SPMoveSprAbs
	C_LINE	12,"mk1.c"
		LIB SPPrintAtInv
	C_LINE	13,"mk1.c"
		LIB SPTileArray
	C_LINE	14,"mk1.c"
		LIB SPInvalidate
	C_LINE	15,"mk1.c"
		LIB SPCompDListAddr
	C_LINE	16,"mk1.c"
;#line 1 "my/config.h"
	C_LINE	19,"mk1.c"
	C_LINE	0,"my/config.h"
; 
	C_LINE	1,"my/config.h"
; 
	C_LINE	2,"my/config.h"
; 
	C_LINE	4,"my/config.h"
; 
	C_LINE	6,"my/config.h"
; 
	C_LINE	7,"my/config.h"
; 
	C_LINE	8,"my/config.h"
; 
	C_LINE	10,"my/config.h"
; 
	C_LINE	11,"my/config.h"
; 
	C_LINE	12,"my/config.h"
; 
	C_LINE	13,"my/config.h"
; 
	C_LINE	14,"my/config.h"
; 
	C_LINE	15,"my/config.h"
; 
	C_LINE	17,"my/config.h"
; 
	C_LINE	24,"my/config.h"
; 
	C_LINE	25,"my/config.h"
; 
	C_LINE	26,"my/config.h"
; 
	C_LINE	27,"my/config.h"
; 
	C_LINE	31,"my/config.h"
; 
	C_LINE	33,"my/config.h"
; 
	C_LINE	34,"my/config.h"
; 
	C_LINE	36,"my/config.h"
; 
	C_LINE	37,"my/config.h"
; 
	C_LINE	38,"my/config.h"
; 
	C_LINE	40,"my/config.h"
; 
	C_LINE	41,"my/config.h"
; 
	C_LINE	43,"my/config.h"
; 
	C_LINE	45,"my/config.h"
; 
	C_LINE	46,"my/config.h"
;											 
	C_LINE	47,"my/config.h"
; 
	C_LINE	48,"my/config.h"
; 
	C_LINE	49,"my/config.h"
; 
	C_LINE	51,"my/config.h"
; 
	C_LINE	53,"my/config.h"
; 
	C_LINE	54,"my/config.h"
; 
	C_LINE	56,"my/config.h"
; 
	C_LINE	58,"my/config.h"
; 
	C_LINE	59,"my/config.h"
; 
	C_LINE	60,"my/config.h"
; 
	C_LINE	61,"my/config.h"
; 
	C_LINE	62,"my/config.h"
; 
	C_LINE	63,"my/config.h"
; 
	C_LINE	64,"my/config.h"
; 
	C_LINE	65,"my/config.h"
; 
	C_LINE	67,"my/config.h"
; 
	C_LINE	69,"my/config.h"
; 
	C_LINE	72,"my/config.h"
; 
	C_LINE	73,"my/config.h"
; 
	C_LINE	75,"my/config.h"
; 
	C_LINE	76,"my/config.h"
; 
	C_LINE	82,"my/config.h"
; 
	C_LINE	85,"my/config.h"
; 
	C_LINE	86,"my/config.h"
; 
	C_LINE	87,"my/config.h"
; 
	C_LINE	88,"my/config.h"
; 
	C_LINE	89,"my/config.h"
; 
	C_LINE	90,"my/config.h"
; 
	C_LINE	91,"my/config.h"
; 
	C_LINE	97,"my/config.h"
; 
	C_LINE	98,"my/config.h"
; 
	C_LINE	102,"my/config.h"
; 
	C_LINE	103,"my/config.h"
; 
	C_LINE	107,"my/config.h"
; 
	C_LINE	108,"my/config.h"
; 
	C_LINE	109,"my/config.h"
; 
	C_LINE	110,"my/config.h"
; 
	C_LINE	111,"my/config.h"
; 
	C_LINE	113,"my/config.h"
; 
	C_LINE	114,"my/config.h"
; 
	C_LINE	117,"my/config.h"
; 
	C_LINE	123,"my/config.h"
; 
	C_LINE	124,"my/config.h"
; 
	C_LINE	125,"my/config.h"
; 
	C_LINE	129,"my/config.h"
; 
	C_LINE	132,"my/config.h"
; 
	C_LINE	137,"my/config.h"
; 
	C_LINE	138,"my/config.h"
; 
	C_LINE	140,"my/config.h"
; 
	C_LINE	142,"my/config.h"
; 
	C_LINE	143,"my/config.h"
; 
	C_LINE	144,"my/config.h"
; 
	C_LINE	146,"my/config.h"
; 
	C_LINE	147,"my/config.h"
; 
	C_LINE	148,"my/config.h"
; 
	C_LINE	150,"my/config.h"
; 
	C_LINE	151,"my/config.h"
; 
	C_LINE	153,"my/config.h"
; 
	C_LINE	154,"my/config.h"
; 
	C_LINE	155,"my/config.h"
; 
	C_LINE	156,"my/config.h"
; 
	C_LINE	157,"my/config.h"
; 
	C_LINE	158,"my/config.h"
; 
	C_LINE	159,"my/config.h"
; 
	C_LINE	160,"my/config.h"
; 
	C_LINE	161,"my/config.h"
; 
	C_LINE	162,"my/config.h"
; 
	C_LINE	163,"my/config.h"
; 
	C_LINE	164,"my/config.h"
; 
	C_LINE	165,"my/config.h"
; 
	C_LINE	167,"my/config.h"
; 
	C_LINE	168,"my/config.h"
; 
	C_LINE	169,"my/config.h"
; 
	C_LINE	170,"my/config.h"
; 
	C_LINE	171,"my/config.h"
; 
	C_LINE	173,"my/config.h"
; 
	C_LINE	174,"my/config.h"
; 
	C_LINE	178,"my/config.h"
; 
	C_LINE	180,"my/config.h"
; 
	C_LINE	181,"my/config.h"
; 
	C_LINE	183,"my/config.h"
; 
	C_LINE	184,"my/config.h"
; 
	C_LINE	185,"my/config.h"
; 
	C_LINE	186,"my/config.h"
; 
	C_LINE	187,"my/config.h"
; 
	C_LINE	189,"my/config.h"
; 
	C_LINE	190,"my/config.h"
; 
	C_LINE	191,"my/config.h"
; 
	C_LINE	192,"my/config.h"
; 
	C_LINE	194,"my/config.h"
; 
	C_LINE	196,"my/config.h"
; 
	C_LINE	198,"my/config.h"
; 
	C_LINE	199,"my/config.h"
; 
	C_LINE	213,"my/config.h"
; 
	C_LINE	215,"my/config.h"
; 
	C_LINE	218,"my/config.h"
; 
	C_LINE	219,"my/config.h"
; 
	C_LINE	220,"my/config.h"
; 
	C_LINE	221,"my/config.h"
; 
	C_LINE	222,"my/config.h"
;	 
	C_LINE	228,"my/config.h"
;	struct sp_UDK keys = {
	C_LINE	230,"my/config.h"
	C_LINE	230,"my/config.h"
	SECTION	data_compiler
._keys
;		0x017f,  
	C_LINE	231,"my/config.h"
	defw	383
;		0x01df,  
	C_LINE	232,"my/config.h"
	defw	479
;		0x02df,  
	C_LINE	233,"my/config.h"
	defw	735
;		0x01fd,  
	C_LINE	234,"my/config.h"
	defw	509
;		0x01fb	 
	C_LINE	235,"my/config.h"
	defw	507
	SECTION	code_compiler
; 
	C_LINE	239,"my/config.h"
; 
	C_LINE	240,"my/config.h"
; 
	C_LINE	241,"my/config.h"
; 
	C_LINE	243,"my/config.h"
; 
	C_LINE	244,"my/config.h"
; 
	C_LINE	263,"my/config.h"
; 
	C_LINE	265,"my/config.h"
; 
	C_LINE	266,"my/config.h"
; 
	C_LINE	267,"my/config.h"
; 
	C_LINE	268,"my/config.h"
; 
	C_LINE	270,"my/config.h"
; 
	C_LINE	272,"my/config.h"
; 
	C_LINE	273,"my/config.h"
; 
	C_LINE	274,"my/config.h"
; 
	C_LINE	276,"my/config.h"
; 
	C_LINE	277,"my/config.h"
; 
	C_LINE	278,"my/config.h"
; 
	C_LINE	279,"my/config.h"
;											 
	C_LINE	280,"my/config.h"
; 
	C_LINE	281,"my/config.h"
; 
	C_LINE	282,"my/config.h"
; 
	C_LINE	285,"my/config.h"
; 
	C_LINE	286,"my/config.h"
; 
	C_LINE	287,"my/config.h"
; 
	C_LINE	289,"my/config.h"
; 
	C_LINE	290,"my/config.h"
; 
	C_LINE	291,"my/config.h"
; 
	C_LINE	292,"my/config.h"
; 
	C_LINE	294,"my/config.h"
; 
	C_LINE	306,"my/config.h"
; 
	C_LINE	312,"my/config.h"
; 
	C_LINE	313,"my/config.h"
; 
	C_LINE	314,"my/config.h"
; 
	C_LINE	316,"my/config.h"
; 
	C_LINE	317,"my/config.h"
; 
	C_LINE	319,"my/config.h"
; 
	C_LINE	320,"my/config.h"
; 
	C_LINE	321,"my/config.h"
; 
	C_LINE	322,"my/config.h"
; 
	C_LINE	323,"my/config.h"
; 
	C_LINE	324,"my/config.h"
; 
	C_LINE	325,"my/config.h"
; 
	C_LINE	326,"my/config.h"
; 
	C_LINE	327,"my/config.h"
; 
	C_LINE	328,"my/config.h"
;#line 18 "mk1.c"
	C_LINE	336,"my/config.h"
	C_LINE	17,"mk1.c"
;#line 1 "prototypes.h"
	C_LINE	18,"mk1.c"
	C_LINE	0,"prototypes.h"
; 
	C_LINE	1,"prototypes.h"
; 
	C_LINE	2,"prototypes.h"
; 
	C_LINE	4,"prototypes.h"
;	
	C_LINE	7,"prototypes.h"
; 
	C_LINE	22,"prototypes.h"
; 
	C_LINE	24,"prototypes.h"
;void break_wall (void);
	C_LINE	25,"prototypes.h"
	C_LINE	25,"prototypes.h"
; 
	C_LINE	27,"prototypes.h"
;void bullets_init (void);
	C_LINE	28,"prototypes.h"
	C_LINE	28,"prototypes.h"
;void bullets_update (void);
	C_LINE	29,"prototypes.h"
	C_LINE	29,"prototypes.h"
;void bullets_fire (void);
	C_LINE	30,"prototypes.h"
	C_LINE	30,"prototypes.h"
;void bullets_move (void);
	C_LINE	31,"prototypes.h"
	C_LINE	31,"prototypes.h"
; 
	C_LINE	33,"prototypes.h"
;void enems_init (void);
	C_LINE	34,"prototypes.h"
	C_LINE	34,"prototypes.h"
;void enems_draw_current (void);
	C_LINE	35,"prototypes.h"
	C_LINE	35,"prototypes.h"
;void enems_load (void);
	C_LINE	36,"prototypes.h"
	C_LINE	36,"prototypes.h"
;void enems_kill (void);
	C_LINE	37,"prototypes.h"
	C_LINE	37,"prototypes.h"
;void enems_move (void);
	C_LINE	38,"prototypes.h"
	C_LINE	38,"prototypes.h"
; 
	C_LINE	40,"prototypes.h"
;unsigned char collide (void);
	C_LINE	41,"prototypes.h"
	C_LINE	41,"prototypes.h"
;unsigned char cm_two_points (void);
	C_LINE	42,"prototypes.h"
	C_LINE	42,"prototypes.h"
;unsigned char rand (void);
	C_LINE	43,"prototypes.h"
	C_LINE	43,"prototypes.h"
;unsigned int abs (int n);
	C_LINE	44,"prototypes.h"
	C_LINE	44,"prototypes.h"
;void step (void);
	C_LINE	45,"prototypes.h"
	C_LINE	45,"prototypes.h"
;void cortina (void);
	C_LINE	46,"prototypes.h"
	C_LINE	46,"prototypes.h"
; 
	C_LINE	48,"prototypes.h"
;void hotspots_init (void);
	C_LINE	49,"prototypes.h"
	C_LINE	49,"prototypes.h"
;void hotspots_do (void);
	C_LINE	50,"prototypes.h"
	C_LINE	50,"prototypes.h"
; 
	C_LINE	52,"prototypes.h"
;void player_init (void);
	C_LINE	53,"prototypes.h"
	C_LINE	53,"prototypes.h"
;void player_calc_bounding_box (void);
	C_LINE	54,"prototypes.h"
	C_LINE	54,"prototypes.h"
;unsigned char player_move (void);
	C_LINE	55,"prototypes.h"
	C_LINE	55,"prototypes.h"
;void player_deplete (void);
	C_LINE	56,"prototypes.h"
	C_LINE	56,"prototypes.h"
;void player_kill (unsigned char sound);
	C_LINE	57,"prototypes.h"
	C_LINE	57,"prototypes.h"
; 
	C_LINE	59,"prototypes.h"
;void simple_coco_init (void);
	C_LINE	60,"prototypes.h"
	C_LINE	60,"prototypes.h"
;void simple_coco_shoot (void);
	C_LINE	61,"prototypes.h"
	C_LINE	61,"prototypes.h"
;void simple_coco_update (void);
	C_LINE	62,"prototypes.h"
	C_LINE	62,"prototypes.h"
; 
	C_LINE	64,"prototypes.h"
; 
	C_LINE	66,"prototypes.h"
;void SetRAMBank(void);
	C_LINE	67,"prototypes.h"
	C_LINE	67,"prototypes.h"
; 
	C_LINE	69,"prototypes.h"
;void get_resource (unsigned char n, unsigned int destination);
	C_LINE	70,"prototypes.h"
	C_LINE	70,"prototypes.h"
;void unpack (unsigned int address, unsigned int destination);
	C_LINE	71,"prototypes.h"
	C_LINE	71,"prototypes.h"
; 
	C_LINE	73,"prototypes.h"
;void beep_fx (unsigned char n);
	C_LINE	74,"prototypes.h"
	C_LINE	74,"prototypes.h"
; 
	C_LINE	76,"prototypes.h"
;void prepare_level (void);
	C_LINE	77,"prototypes.h"
	C_LINE	77,"prototypes.h"
;void game_ending (void);
	C_LINE	78,"prototypes.h"
	C_LINE	78,"prototypes.h"
;void game_over (void);
	C_LINE	79,"prototypes.h"
	C_LINE	79,"prototypes.h"
;void time_over (void);
	C_LINE	80,"prototypes.h"
	C_LINE	80,"prototypes.h"
;void pause_screen (void);
	C_LINE	81,"prototypes.h"
	C_LINE	81,"prototypes.h"
;signed int addsign (signed int n, signed int value);
	C_LINE	82,"prototypes.h"
	C_LINE	82,"prototypes.h"
;void espera_activa (int espera);
	C_LINE	83,"prototypes.h"
	C_LINE	83,"prototypes.h"
;void locks_init (void);
	C_LINE	84,"prototypes.h"
	C_LINE	84,"prototypes.h"
;char player_hidden (void);
	C_LINE	85,"prototypes.h"
	C_LINE	85,"prototypes.h"
;void run_fire_script (void);
	C_LINE	86,"prototypes.h"
	C_LINE	86,"prototypes.h"
;void process_tile (void);
	C_LINE	87,"prototypes.h"
	C_LINE	87,"prototypes.h"
;void draw_scr_background (void);
	C_LINE	88,"prototypes.h"
	C_LINE	88,"prototypes.h"
;void draw_scr_hotspots_locks (void);
	C_LINE	89,"prototypes.h"
	C_LINE	89,"prototypes.h"
;void draw_scr (void);
	C_LINE	90,"prototypes.h"
	C_LINE	90,"prototypes.h"
;void select_joyfunc (void);
	C_LINE	91,"prototypes.h"
	C_LINE	91,"prototypes.h"
;unsigned char mons_col_sc_x (void);	
	C_LINE	92,"prototypes.h"
	C_LINE	92,"prototypes.h"
;unsigned char mons_col_sc_y (void);
	C_LINE	93,"prototypes.h"
	C_LINE	93,"prototypes.h"
;unsigned char distance (void);
	C_LINE	94,"prototypes.h"
	C_LINE	94,"prototypes.h"
;int limit (int val, int min, int max);
	C_LINE	95,"prototypes.h"
	C_LINE	95,"prototypes.h"
; 
	C_LINE	97,"prototypes.h"
;void blackout (void);
	C_LINE	98,"prototypes.h"
	C_LINE	98,"prototypes.h"
; 
	C_LINE	100,"prototypes.h"
;unsigned char attr (unsigned char x, unsigned char y);
	C_LINE	101,"prototypes.h"
	C_LINE	101,"prototypes.h"
;unsigned char qtile (unsigned char x, unsigned char y);
	C_LINE	102,"prototypes.h"
	C_LINE	102,"prototypes.h"
;void draw_coloured_tile (void);
	C_LINE	103,"prototypes.h"
	C_LINE	103,"prototypes.h"
;void invalidate_tile (void);
	C_LINE	104,"prototypes.h"
	C_LINE	104,"prototypes.h"
;void invalidate_viewport (void);
	C_LINE	105,"prototypes.h"
	C_LINE	105,"prototypes.h"
;void draw_invalidate_coloured_tile_gamearea (void);
	C_LINE	106,"prototypes.h"
	C_LINE	106,"prototypes.h"
;void draw_coloured_tile_gamearea (void);
	C_LINE	107,"prototypes.h"
	C_LINE	107,"prototypes.h"
;void draw_decorations (void);
	C_LINE	108,"prototypes.h"
	C_LINE	108,"prototypes.h"
;void update_tile (void);
	C_LINE	109,"prototypes.h"
	C_LINE	109,"prototypes.h"
;void print_number2 (void);
	C_LINE	110,"prototypes.h"
	C_LINE	110,"prototypes.h"
;void draw_objs ();
	C_LINE	111,"prototypes.h"
	C_LINE	111,"prototypes.h"
;void print_str (void);
	C_LINE	112,"prototypes.h"
	C_LINE	112,"prototypes.h"
;void blackout_area (void);
	C_LINE	113,"prototypes.h"
	C_LINE	113,"prototypes.h"
;void clear_sprites (void);
	C_LINE	114,"prototypes.h"
	C_LINE	114,"prototypes.h"
; 
	C_LINE	116,"prototypes.h"
;void mem_save (void);
	C_LINE	117,"prototypes.h"
	C_LINE	117,"prototypes.h"
;void mem_load (void);
	C_LINE	118,"prototypes.h"
	C_LINE	118,"prototypes.h"
;void tape_save (void); 
	C_LINE	119,"prototypes.h"
	C_LINE	119,"prototypes.h"
;void tape_load (void); 
	C_LINE	120,"prototypes.h"
	C_LINE	120,"prototypes.h"
;void sg_submenu (void);
	C_LINE	121,"prototypes.h"
	C_LINE	121,"prototypes.h"
; 
	C_LINE	123,"prototypes.h"
;void tilanims_add (void);
	C_LINE	124,"prototypes.h"
	C_LINE	124,"prototypes.h"
;void tilanims_do (void);
	C_LINE	125,"prototypes.h"
	C_LINE	125,"prototypes.h"
;void tilanims_reset (void);
	C_LINE	126,"prototypes.h"
	C_LINE	126,"prototypes.h"
; 
	C_LINE	129,"prototypes.h"
;#line 19 "mk1.c"
	C_LINE	136,"prototypes.h"
	C_LINE	18,"mk1.c"
; 
	C_LINE	20,"mk1.c"
; 
	C_LINE	22,"mk1.c"
; 
	C_LINE	26,"mk1.c"
; 
	C_LINE	35,"mk1.c"
;	 
	C_LINE	39,"mk1.c"
;	
	C_LINE	41,"mk1.c"
; 
	C_LINE	44,"mk1.c"
;	
	C_LINE	47,"mk1.c"
;		
	C_LINE	48,"mk1.c"
;	
	C_LINE	49,"mk1.c"
;unsigned char AD_FREE [ (((1 +  3 ) * 10) + ( ( 3  +  3 )  * 5))  * 15];
	C_LINE	62,"mk1.c"
	C_LINE	62,"mk1.c"
; 
	C_LINE	64,"mk1.c"
;#line 1 "definitions.h"
	C_LINE	66,"mk1.c"
	C_LINE	0,"definitions.h"
; 
	C_LINE	1,"definitions.h"
; 
	C_LINE	2,"definitions.h"
;#asm
	C_LINE	4,"definitions.h"
	C_LINE	4,"definitions.h"
	C_LINE	6,"definitions.h"
	.vpClipStruct defb  1 ,  1  + 20,  1 ,  1  + 30
	C_LINE	7,"definitions.h"
	.fsClipStruct defb 0, 24, 0, 32
	C_LINE	8,"definitions.h"
; 
	C_LINE	11,"definitions.h"
;unsigned int (*joyfunc)(struct sp_UDK *) = sp_JoyKeyboard;
	C_LINE	12,"definitions.h"
	C_LINE	12,"definitions.h"
	SECTION	data_compiler
._joyfunc
	defw	sp_JoyKeyboard + 0
	SECTION	code_compiler
;const void *joyfuncs [] = {
	C_LINE	14,"definitions.h"
	C_LINE	14,"definitions.h"
	SECTION	rodata_compiler
._joyfuncs
;	sp_JoyKeyboard, sp_JoyKempston, sp_JoySinclair1
	C_LINE	15,"definitions.h"
	defw	sp_JoyKeyboard + 0
	defw	sp_JoyKempston + 0
;};
	C_LINE	16,"definitions.h"
	defw	sp_JoySinclair1 + 0
	SECTION	code_compiler
;unsigned char pad0;
	C_LINE	18,"definitions.h"
	C_LINE	18,"definitions.h"
;void *my_malloc(uint bytes) {
	C_LINE	26,"definitions.h"
	C_LINE	26,"definitions.h"

; Function my_malloc flags 0x00000200 __smallc 
; void * my_malloc(unsigned int bytes)
; parameter 'unsigned int bytes' at sp+2 size(2)
	C_LINE	26,"definitions.h::my_malloc::0::0"
._my_malloc
	C_LINE	26,"definitions.h::my_malloc::0::0"
;   return sp_BlockAlloc(0);
	C_LINE	27,"definitions.h::my_malloc::1::1"
	C_LINE	27,"definitions.h::my_malloc::1::1"
;0;
	C_LINE	28,"definitions.h::my_malloc::1::1"
	ld	hl,0	;const
	push	hl
	call	sp_BlockAlloc
	pop	bc
	ret


;}
	C_LINE	28,"definitions.h::my_malloc::1::1"
;void *u_malloc = my_malloc;
	C_LINE	30,"definitions.h::my_malloc::0::1"
	C_LINE	30,"definitions.h::my_malloc::0::1"
	SECTION	data_compiler
._u_malloc
	defw	_my_malloc + 0
	SECTION	code_compiler
;void *u_free = sp_FreeBlock;
	C_LINE	31,"definitions.h::my_malloc::0::1"
	C_LINE	31,"definitions.h::my_malloc::0::1"
	SECTION	data_compiler
._u_free
	defw	sp_FreeBlock + 0
	SECTION	code_compiler
; 
	C_LINE	33,"definitions.h::my_malloc::0::1"
;unsigned char safe_byte 		@ 23296;
	C_LINE	35,"definitions.h::my_malloc::0::1"
	C_LINE	35,"definitions.h::my_malloc::0::1"
;unsigned int ram_address 		@ 23297;
	C_LINE	37,"definitions.h::my_malloc::0::1"
	C_LINE	37,"definitions.h::my_malloc::0::1"
;unsigned int ram_destination 	@ 23299;
	C_LINE	38,"definitions.h::my_malloc::0::1"
	C_LINE	38,"definitions.h::my_malloc::0::1"
;	
	C_LINE	43,"definitions.h::my_malloc::0::1"
; 
	C_LINE	44,"definitions.h::my_malloc::0::1"
;struct sp_SS *sp_player;
	C_LINE	46,"definitions.h::my_malloc::0::1"
	C_LINE	46,"definitions.h::my_malloc::0::1"
;struct sp_SS *sp_moviles [ 3 ];
	C_LINE	47,"definitions.h::my_malloc::0::1"
	C_LINE	47,"definitions.h::my_malloc::0::1"
;	struct sp_SS *sp_bullets [ 3 ];
	C_LINE	49,"definitions.h::my_malloc::0::1"
	C_LINE	49,"definitions.h::my_malloc::0::1"
;	struct sp_SS *sp_cocos [ 3 ];
	C_LINE	52,"definitions.h::my_malloc::0::1"
	C_LINE	52,"definitions.h::my_malloc::0::1"
;unsigned char enoffs;
	C_LINE	55,"definitions.h::my_malloc::0::1"
	C_LINE	55,"definitions.h::my_malloc::0::1"
; 
	C_LINE	57,"definitions.h::my_malloc::0::1"
;char asm_number;
	C_LINE	59,"definitions.h::my_malloc::0::1"
	C_LINE	59,"definitions.h::my_malloc::0::1"
;unsigned int asm_int 			@ 23302;
	C_LINE	60,"definitions.h::my_malloc::0::1"
	C_LINE	60,"definitions.h::my_malloc::0::1"
;unsigned int asm_int_2;
	C_LINE	61,"definitions.h::my_malloc::0::1"
	C_LINE	61,"definitions.h::my_malloc::0::1"
;unsigned int seed;
	C_LINE	62,"definitions.h::my_malloc::0::1"
	C_LINE	62,"definitions.h::my_malloc::0::1"
;unsigned char half_life;
	C_LINE	63,"definitions.h::my_malloc::0::1"
	C_LINE	63,"definitions.h::my_malloc::0::1"
; 
	C_LINE	76,"definitions.h::my_malloc::0::1"
; 
	C_LINE	77,"definitions.h::my_malloc::0::1"
; 
	C_LINE	78,"definitions.h::my_malloc::0::1"
; 
	C_LINE	99,"definitions.h::my_malloc::0::1"
;signed int p_x, p_y;
	C_LINE	100,"definitions.h::my_malloc::0::1"
	C_LINE	100,"definitions.h::my_malloc::0::1"
;signed int p_vx, p_vy;
	C_LINE	101,"definitions.h::my_malloc::0::1"
	C_LINE	101,"definitions.h::my_malloc::0::1"
;unsigned char *p_current_frame, *p_next_frame;
	C_LINE	102,"definitions.h::my_malloc::0::1"
	C_LINE	102,"definitions.h::my_malloc::0::1"
;unsigned char p_saltando, p_cont_salto;
	C_LINE	103,"definitions.h::my_malloc::0::1"
	C_LINE	103,"definitions.h::my_malloc::0::1"
;unsigned char p_frame, p_subframe, p_facing;
	C_LINE	104,"definitions.h::my_malloc::0::1"
	C_LINE	104,"definitions.h::my_malloc::0::1"
;unsigned char p_estado;
	C_LINE	105,"definitions.h::my_malloc::0::1"
	C_LINE	105,"definitions.h::my_malloc::0::1"
;unsigned char p_ct_estado;
	C_LINE	106,"definitions.h::my_malloc::0::1"
	C_LINE	106,"definitions.h::my_malloc::0::1"
;unsigned char p_gotten, pregotten;
	C_LINE	107,"definitions.h::my_malloc::0::1"
	C_LINE	107,"definitions.h::my_malloc::0::1"
;unsigned char p_life, p_objs, p_keys;
	C_LINE	108,"definitions.h::my_malloc::0::1"
	C_LINE	108,"definitions.h::my_malloc::0::1"
;unsigned char p_fuel;
	C_LINE	109,"definitions.h::my_malloc::0::1"
	C_LINE	109,"definitions.h::my_malloc::0::1"
;unsigned char p_killed;
	C_LINE	110,"definitions.h::my_malloc::0::1"
	C_LINE	110,"definitions.h::my_malloc::0::1"
;unsigned char p_disparando;
	C_LINE	111,"definitions.h::my_malloc::0::1"
	C_LINE	111,"definitions.h::my_malloc::0::1"
;unsigned char p_facing_v, p_facing_h;
	C_LINE	112,"definitions.h::my_malloc::0::1"
	C_LINE	112,"definitions.h::my_malloc::0::1"
;unsigned char p_ammo;
	C_LINE	113,"definitions.h::my_malloc::0::1"
	C_LINE	113,"definitions.h::my_malloc::0::1"
;unsigned char p_killme;
	C_LINE	114,"definitions.h::my_malloc::0::1"
	C_LINE	114,"definitions.h::my_malloc::0::1"
;unsigned char p_kill_amt;
	C_LINE	115,"definitions.h::my_malloc::0::1"
	C_LINE	115,"definitions.h::my_malloc::0::1"
;unsigned char p_tx, p_ty;
	C_LINE	116,"definitions.h::my_malloc::0::1"
	C_LINE	116,"definitions.h::my_malloc::0::1"
;signed int ptgmx, ptgmy;
	C_LINE	120,"definitions.h::my_malloc::0::1"
	C_LINE	120,"definitions.h::my_malloc::0::1"
;unsigned char *spacer = "            ";
	C_LINE	122,"definitions.h::my_malloc::0::1"
	C_LINE	122,"definitions.h::my_malloc::0::1"
	SECTION	data_compiler
._spacer
	defw	i_1+0
	SECTION	code_compiler
;unsigned char enit;
	C_LINE	124,"definitions.h::my_malloc::0::1"
	C_LINE	124,"definitions.h::my_malloc::0::1"
;unsigned char en_an_base_frame [ 3 ];
	C_LINE	126,"definitions.h::my_malloc::0::1"
	C_LINE	126,"definitions.h::my_malloc::0::1"
;unsigned char en_an_frame [ 3 ];
	C_LINE	127,"definitions.h::my_malloc::0::1"
	C_LINE	127,"definitions.h::my_malloc::0::1"
;unsigned char en_an_count [ 3 ];
	C_LINE	128,"definitions.h::my_malloc::0::1"
	C_LINE	128,"definitions.h::my_malloc::0::1"
;unsigned char *en_an_current_frame [ 3 ], *en_an_next_frame [ 3 ];
	C_LINE	129,"definitions.h::my_malloc::0::1"
	C_LINE	129,"definitions.h::my_malloc::0::1"
;unsigned char en_an_state [ 3 ];
	C_LINE	130,"definitions.h::my_malloc::0::1"
	C_LINE	130,"definitions.h::my_malloc::0::1"
;	unsigned char en_an_alive [ 3 ];
	C_LINE	141,"definitions.h::my_malloc::0::1"
	C_LINE	141,"definitions.h::my_malloc::0::1"
;	unsigned char en_an_dead_row [ 3 ];
	C_LINE	142,"definitions.h::my_malloc::0::1"
	C_LINE	142,"definitions.h::my_malloc::0::1"
;	unsigned char en_an_rawv [ 3 ];
	C_LINE	143,"definitions.h::my_malloc::0::1"
	C_LINE	143,"definitions.h::my_malloc::0::1"
;unsigned char _en_x, _en_y;
	C_LINE	146,"definitions.h::my_malloc::0::1"
	C_LINE	146,"definitions.h::my_malloc::0::1"
;unsigned char _en_x1, _en_y1, _en_x2, _en_y2;
	C_LINE	147,"definitions.h::my_malloc::0::1"
	C_LINE	147,"definitions.h::my_malloc::0::1"
;signed char _en_mx, _en_my;
	C_LINE	148,"definitions.h::my_malloc::0::1"
	C_LINE	148,"definitions.h::my_malloc::0::1"
;signed char _en_t;
	C_LINE	149,"definitions.h::my_malloc::0::1"
	C_LINE	149,"definitions.h::my_malloc::0::1"
;signed char _en_life;
	C_LINE	150,"definitions.h::my_malloc::0::1"
	C_LINE	150,"definitions.h::my_malloc::0::1"
;unsigned char *_baddies_pointer;
	C_LINE	152,"definitions.h::my_malloc::0::1"
	C_LINE	152,"definitions.h::my_malloc::0::1"
;	unsigned char _en_cx, _en_cy;
	C_LINE	155,"definitions.h::my_malloc::0::1"
	C_LINE	155,"definitions.h::my_malloc::0::1"
;	unsigned char bullets_x [ 3 ];
	C_LINE	159,"definitions.h::my_malloc::0::1"
	C_LINE	159,"definitions.h::my_malloc::0::1"
;	unsigned char bullets_y [ 3 ];
	C_LINE	160,"definitions.h::my_malloc::0::1"
	C_LINE	160,"definitions.h::my_malloc::0::1"
;	char bullets_mx [ 3 ];
	C_LINE	161,"definitions.h::my_malloc::0::1"
	C_LINE	161,"definitions.h::my_malloc::0::1"
;	char bullets_my [ 3 ];
	C_LINE	162,"definitions.h::my_malloc::0::1"
	C_LINE	162,"definitions.h::my_malloc::0::1"
;	unsigned char bullets_estado [ 3 ];
	C_LINE	163,"definitions.h::my_malloc::0::1"
	C_LINE	163,"definitions.h::my_malloc::0::1"
;	
	C_LINE	164,"definitions.h::my_malloc::0::1"
;	unsigned char _b_estado;
	C_LINE	168,"definitions.h::my_malloc::0::1"
	C_LINE	168,"definitions.h::my_malloc::0::1"
;	unsigned char b_it, _b_x, _b_y;
	C_LINE	169,"definitions.h::my_malloc::0::1"
	C_LINE	169,"definitions.h::my_malloc::0::1"
;	signed char _b_mx, _b_my;
	C_LINE	170,"definitions.h::my_malloc::0::1"
	C_LINE	170,"definitions.h::my_malloc::0::1"
;	unsigned char cocos_x [ 3 ], cocos_y [ 3 ];
	C_LINE	174,"definitions.h::my_malloc::0::1"
	C_LINE	174,"definitions.h::my_malloc::0::1"
;	signed char cocos_mx [ 3 ], cocos_my [ 3 ];
	C_LINE	175,"definitions.h::my_malloc::0::1"
	C_LINE	175,"definitions.h::my_malloc::0::1"
; 
	C_LINE	178,"definitions.h::my_malloc::0::1"
; 
	C_LINE	179,"definitions.h::my_malloc::0::1"
;unsigned char map_attr [150];
	C_LINE	180,"definitions.h::my_malloc::0::1"
	C_LINE	180,"definitions.h::my_malloc::0::1"
;unsigned char map_buff [150] @  61697 ;
	C_LINE	181,"definitions.h::my_malloc::0::1"
	C_LINE	181,"definitions.h::my_malloc::0::1"
; 
	C_LINE	182,"definitions.h::my_malloc::0::1"
;	unsigned char brk_buff [150] @ 23296+16;
	C_LINE	184,"definitions.h::my_malloc::0::1"
	C_LINE	184,"definitions.h::my_malloc::0::1"
; 
	C_LINE	187,"definitions.h::my_malloc::0::1"
; 
	C_LINE	188,"definitions.h::my_malloc::0::1"
;unsigned char hotspot_x;
	C_LINE	189,"definitions.h::my_malloc::0::1"
	C_LINE	189,"definitions.h::my_malloc::0::1"
;unsigned char hotspot_y;
	C_LINE	190,"definitions.h::my_malloc::0::1"
	C_LINE	190,"definitions.h::my_malloc::0::1"
;unsigned char hotspot_destroy;
	C_LINE	191,"definitions.h::my_malloc::0::1"
	C_LINE	191,"definitions.h::my_malloc::0::1"
;unsigned char orig_tile;	 
	C_LINE	192,"definitions.h::my_malloc::0::1"
	C_LINE	192,"definitions.h::my_malloc::0::1"
; 
	C_LINE	194,"definitions.h::my_malloc::0::1"
;unsigned char flags[ 2 ];	
	C_LINE	198,"definitions.h::my_malloc::0::1"
	C_LINE	198,"definitions.h::my_malloc::0::1"
; 
	C_LINE	200,"definitions.h::my_malloc::0::1"
;unsigned char o_pant;
	C_LINE	201,"definitions.h::my_malloc::0::1"
	C_LINE	201,"definitions.h::my_malloc::0::1"
;unsigned char n_pant;
	C_LINE	202,"definitions.h::my_malloc::0::1"
	C_LINE	202,"definitions.h::my_malloc::0::1"
;unsigned char is_rendering;
	C_LINE	203,"definitions.h::my_malloc::0::1"
	C_LINE	203,"definitions.h::my_malloc::0::1"
;unsigned char level, slevel;
	C_LINE	204,"definitions.h::my_malloc::0::1"
	C_LINE	204,"definitions.h::my_malloc::0::1"
;	unsigned char warp_to_level = 0;
	C_LINE	206,"definitions.h::my_malloc::0::1"
	C_LINE	206,"definitions.h::my_malloc::0::1"
	SECTION	data_compiler
._warp_to_level
	defb	0
	SECTION	code_compiler
;unsigned char maincounter;
	C_LINE	208,"definitions.h::my_malloc::0::1"
	C_LINE	208,"definitions.h::my_malloc::0::1"
; 
	C_LINE	210,"definitions.h::my_malloc::0::1"
; 
	C_LINE	215,"definitions.h::my_malloc::0::1"
; 
	C_LINE	228,"definitions.h::my_malloc::0::1"
;unsigned char gpx, gpox, gpy, gpd, gpc;
	C_LINE	230,"definitions.h::my_malloc::0::1"
	C_LINE	230,"definitions.h::my_malloc::0::1"
;unsigned char gpxx, gpyy, gpcx, gpcy;
	C_LINE	231,"definitions.h::my_malloc::0::1"
	C_LINE	231,"definitions.h::my_malloc::0::1"
;unsigned char possee, hit_v, hit_h, hit, wall_h, wall_v;
	C_LINE	232,"definitions.h::my_malloc::0::1"
	C_LINE	232,"definitions.h::my_malloc::0::1"
;unsigned char gpen_x, gpen_y, gpen_cx, gpen_cy, gpaux;
	C_LINE	233,"definitions.h::my_malloc::0::1"
	C_LINE	233,"definitions.h::my_malloc::0::1"
;unsigned char tocado, active;
	C_LINE	234,"definitions.h::my_malloc::0::1"
	C_LINE	234,"definitions.h::my_malloc::0::1"
;unsigned char gpit, gpjt;
	C_LINE	235,"definitions.h::my_malloc::0::1"
	C_LINE	235,"definitions.h::my_malloc::0::1"
;unsigned char enoffsmasi;
	C_LINE	236,"definitions.h::my_malloc::0::1"
	C_LINE	236,"definitions.h::my_malloc::0::1"
;unsigned char *map_pointer;
	C_LINE	237,"definitions.h::my_malloc::0::1"
	C_LINE	237,"definitions.h::my_malloc::0::1"
;	unsigned char blx, bly;
	C_LINE	239,"definitions.h::my_malloc::0::1"
	C_LINE	239,"definitions.h::my_malloc::0::1"
;unsigned char rdx, rdy, rda, rdb, rdc, rdd, rdn, rdt;
	C_LINE	241,"definitions.h::my_malloc::0::1"
	C_LINE	241,"definitions.h::my_malloc::0::1"
; 
	C_LINE	243,"definitions.h::my_malloc::0::1"
;int itj;
	C_LINE	249,"definitions.h::my_malloc::0::1"
	C_LINE	249,"definitions.h::my_malloc::0::1"
;unsigned char objs_old, keys_old, life_old, killed_old;
	C_LINE	250,"definitions.h::my_malloc::0::1"
	C_LINE	250,"definitions.h::my_malloc::0::1"
;	unsigned char ammo_old;
	C_LINE	253,"definitions.h::my_malloc::0::1"
	C_LINE	253,"definitions.h::my_malloc::0::1"
;	unsigned char *level_str = "LEVEL 0X";
	C_LINE	261,"definitions.h::my_malloc::0::1"
	C_LINE	261,"definitions.h::my_malloc::0::1"
	SECTION	data_compiler
._level_str
	defw	i_1+13
	SECTION	code_compiler
;	unsigned char silent_level = 0;
	C_LINE	262,"definitions.h::my_malloc::0::1"
	C_LINE	262,"definitions.h::my_malloc::0::1"
	SECTION	data_compiler
._silent_level
	defb	0
	SECTION	code_compiler
;unsigned char *gen_pt;
	C_LINE	269,"definitions.h::my_malloc::0::1"
	C_LINE	269,"definitions.h::my_malloc::0::1"
;unsigned char playing;
	C_LINE	270,"definitions.h::my_malloc::0::1"
	C_LINE	270,"definitions.h::my_malloc::0::1"
;unsigned char success;
	C_LINE	272,"definitions.h::my_malloc::0::1"
	C_LINE	272,"definitions.h::my_malloc::0::1"
;unsigned char _x, _y, _n, _t;
	C_LINE	277,"definitions.h::my_malloc::0::1"
	C_LINE	277,"definitions.h::my_malloc::0::1"
;unsigned char cx1, cy1, cx2, cy2, at1, at2;
	C_LINE	278,"definitions.h::my_malloc::0::1"
	C_LINE	278,"definitions.h::my_malloc::0::1"
;unsigned char x0, y0, x1, y1;
	C_LINE	279,"definitions.h::my_malloc::0::1"
	C_LINE	279,"definitions.h::my_malloc::0::1"
;unsigned char ptx1, pty1, ptx2, pty2;
	C_LINE	280,"definitions.h::my_malloc::0::1"
	C_LINE	280,"definitions.h::my_malloc::0::1"
;unsigned char *_gp_gen;
	C_LINE	281,"definitions.h::my_malloc::0::1"
	C_LINE	281,"definitions.h::my_malloc::0::1"
;	 
	C_LINE	308,"definitions.h::my_malloc::0::1"
;	const signed char _dx [] = { 0,  8 , 0, - 8  };
	C_LINE	309,"definitions.h::my_malloc::0::1"
	C_LINE	309,"definitions.h::my_malloc::0::1"
	SECTION	rodata_compiler
.__dx
	defb	0
	defb	8
	defb	0
	defb	-8
	SECTION	code_compiler
;	const signed char _dy [] = { - 8 , 0,  8 , 0 };
	C_LINE	310,"definitions.h::my_malloc::0::1"
	C_LINE	310,"definitions.h::my_malloc::0::1"
	SECTION	rodata_compiler
.__dy
	defb	-8
	defb	0
	defb	8
	defb	0
	SECTION	code_compiler
;unsigned char isrc;
	C_LINE	318,"definitions.h::my_malloc::0::1"
	C_LINE	318,"definitions.h::my_malloc::0::1"
;#line 69 "mk1.c"
	C_LINE	319,"definitions.h::my_malloc::0::1"
	C_LINE	68,"mk1.c::my_malloc::0::1"
;#line 1 "aplib.h"
	C_LINE	80,"mk1.c::my_malloc::0::1"
	C_LINE	0,"aplib.h::my_malloc::0::1"
; 
	C_LINE	1,"aplib.h::my_malloc::0::1"
; 
	C_LINE	2,"aplib.h::my_malloc::0::1"
;#asm
	C_LINE	4,"aplib.h::my_malloc::0::1"
	C_LINE	4,"aplib.h::my_malloc::0::1"
	C_LINE	7,"aplib.h::my_malloc::0::1"
	; aPPack decompressor
	C_LINE	8,"aplib.h::my_malloc::0::1"
	; original source by dwedit
	C_LINE	9,"aplib.h::my_malloc::0::1"
	; very slightly adapted by utopian
	C_LINE	10,"aplib.h::my_malloc::0::1"
	; optimized by Metalbrain
	C_LINE	12,"aplib.h::my_malloc::0::1"
	;hl = source
	C_LINE	13,"aplib.h::my_malloc::0::1"
	;de = dest
	C_LINE	15,"aplib.h::my_malloc::0::1"
	.depack		ld	ixl,128
	C_LINE	16,"aplib.h::my_malloc::0::1"
	.apbranch1	ldi
	C_LINE	17,"aplib.h::my_malloc::0::1"
	.aploop0	ld	ixh,1		;LWM = 0
	C_LINE	18,"aplib.h::my_malloc::0::1"
	.aploop		call 	ap_getbit
	C_LINE	19,"aplib.h::my_malloc::0::1"
			jr 	nc,apbranch1
	C_LINE	20,"aplib.h::my_malloc::0::1"
			call 	ap_getbit
	C_LINE	21,"aplib.h::my_malloc::0::1"
			jr 	nc,apbranch2
	C_LINE	22,"aplib.h::my_malloc::0::1"
			ld 	b,0
	C_LINE	23,"aplib.h::my_malloc::0::1"
			call 	ap_getbit
	C_LINE	24,"aplib.h::my_malloc::0::1"
			jr 	nc,apbranch3
	C_LINE	25,"aplib.h::my_malloc::0::1"
			ld	c,16		;get an offset
	C_LINE	26,"aplib.h::my_malloc::0::1"
	.apget4bits	call 	ap_getbit
	C_LINE	27,"aplib.h::my_malloc::0::1"
			rl 	c
	C_LINE	28,"aplib.h::my_malloc::0::1"
			jr	nc,apget4bits
	C_LINE	29,"aplib.h::my_malloc::0::1"
			jr 	nz,apbranch4
	C_LINE	30,"aplib.h::my_malloc::0::1"
			ld 	a,b
	C_LINE	31,"aplib.h::my_malloc::0::1"
	.apwritebyte	ld 	(de),a		;write a 0
	C_LINE	32,"aplib.h::my_malloc::0::1"
			inc 	de
	C_LINE	33,"aplib.h::my_malloc::0::1"
			jr	aploop0
	C_LINE	34,"aplib.h::my_malloc::0::1"
	.apbranch4	and	a
	C_LINE	35,"aplib.h::my_malloc::0::1"
			ex 	de,hl 		;write a previous byte (1-15 away from dest)
	C_LINE	36,"aplib.h::my_malloc::0::1"
			sbc 	hl,bc
	C_LINE	37,"aplib.h::my_malloc::0::1"
			ld 	a,(hl)
	C_LINE	38,"aplib.h::my_malloc::0::1"
			add	hl,bc
	C_LINE	39,"aplib.h::my_malloc::0::1"
			ex 	de,hl
	C_LINE	40,"aplib.h::my_malloc::0::1"
			jr	apwritebyte
	C_LINE	41,"aplib.h::my_malloc::0::1"
	.apbranch3	ld 	c,(hl)		;use 7 bit offset, length = 2 or 3
	C_LINE	42,"aplib.h::my_malloc::0::1"
			inc 	hl
	C_LINE	43,"aplib.h::my_malloc::0::1"
			rr 	c
	C_LINE	44,"aplib.h::my_malloc::0::1"
			ret 	z		;if a zero is encountered here, it is EOF
	C_LINE	45,"aplib.h::my_malloc::0::1"
			ld	a,2
	C_LINE	46,"aplib.h::my_malloc::0::1"
			adc	a,b
	C_LINE	47,"aplib.h::my_malloc::0::1"
			push 	hl
	C_LINE	48,"aplib.h::my_malloc::0::1"
			ld	iyh,b
	C_LINE	49,"aplib.h::my_malloc::0::1"
			ld	iyl,c
	C_LINE	50,"aplib.h::my_malloc::0::1"
			ld 	h,d
	C_LINE	51,"aplib.h::my_malloc::0::1"
			ld 	l,e
	C_LINE	52,"aplib.h::my_malloc::0::1"
			sbc 	hl,bc
	C_LINE	53,"aplib.h::my_malloc::0::1"
			ld 	c,a
	C_LINE	54,"aplib.h::my_malloc::0::1"
			jr	ap_finishup2
	C_LINE	55,"aplib.h::my_malloc::0::1"
	.apbranch2	call 	ap_getgamma	;use a gamma code * 256 for offset, another gamma code for length
	C_LINE	56,"aplib.h::my_malloc::0::1"
			dec 	c
	C_LINE	57,"aplib.h::my_malloc::0::1"
			ld	a,c
	C_LINE	58,"aplib.h::my_malloc::0::1"
			sub	ixh
	C_LINE	59,"aplib.h::my_malloc::0::1"
			jr 	z,ap_r0_gamma		;if gamma code is 2, use old r0 offset,
	C_LINE	60,"aplib.h::my_malloc::0::1"
			dec 	a
	C_LINE	61,"aplib.h::my_malloc::0::1"
			;do I even need this code?
	C_LINE	62,"aplib.h::my_malloc::0::1"
			;bc=bc*256+(hl), lazy 16bit way
	C_LINE	63,"aplib.h::my_malloc::0::1"
			ld 	b,a
	C_LINE	64,"aplib.h::my_malloc::0::1"
			ld 	c,(hl)
	C_LINE	65,"aplib.h::my_malloc::0::1"
			inc 	hl
	C_LINE	66,"aplib.h::my_malloc::0::1"
			ld	iyh,b
	C_LINE	67,"aplib.h::my_malloc::0::1"
			ld	iyl,c
	C_LINE	69,"aplib.h::my_malloc::0::1"
			push 	bc
	C_LINE	70,"aplib.h::my_malloc::0::1"
	C_LINE	71,"aplib.h::my_malloc::0::1"
			call 	ap_getgamma
	C_LINE	73,"aplib.h::my_malloc::0::1"
			ex 	(sp),hl		;bc = len, hl=offs
	C_LINE	74,"aplib.h::my_malloc::0::1"
			push 	de
	C_LINE	75,"aplib.h::my_malloc::0::1"
			ex 	de,hl
	C_LINE	77,"aplib.h::my_malloc::0::1"
			ld	a,4
	C_LINE	78,"aplib.h::my_malloc::0::1"
			cp	d
	C_LINE	79,"aplib.h::my_malloc::0::1"
			jr 	nc,apskip2
	C_LINE	80,"aplib.h::my_malloc::0::1"
			inc 	bc
	C_LINE	81,"aplib.h::my_malloc::0::1"
			or	a
	C_LINE	82,"aplib.h::my_malloc::0::1"
	.apskip2	ld 	hl,127
	C_LINE	83,"aplib.h::my_malloc::0::1"
			sbc 	hl,de
	C_LINE	84,"aplib.h::my_malloc::0::1"
			jr 	c,apskip3
	C_LINE	85,"aplib.h::my_malloc::0::1"
			inc 	bc
	C_LINE	86,"aplib.h::my_malloc::0::1"
			inc 	bc
	C_LINE	87,"aplib.h::my_malloc::0::1"
	.apskip3		pop 	hl		;bc = len, de = offs, hl=junk
	C_LINE	88,"aplib.h::my_malloc::0::1"
			push 	hl
	C_LINE	89,"aplib.h::my_malloc::0::1"
			or 	a
	C_LINE	90,"aplib.h::my_malloc::0::1"
	.ap_finishup	sbc 	hl,de
	C_LINE	91,"aplib.h::my_malloc::0::1"
			pop 	de		;hl=dest-offs, bc=len, de = dest
	C_LINE	92,"aplib.h::my_malloc::0::1"
	.ap_finishup2	ldir
	C_LINE	93,"aplib.h::my_malloc::0::1"
			pop 	hl
	C_LINE	94,"aplib.h::my_malloc::0::1"
			ld	ixh,b
	C_LINE	95,"aplib.h::my_malloc::0::1"
			jr 	aploop
	C_LINE	97,"aplib.h::my_malloc::0::1"
	.ap_r0_gamma	call 	ap_getgamma		;and a new gamma code for length
	C_LINE	98,"aplib.h::my_malloc::0::1"
			push 	hl
	C_LINE	99,"aplib.h::my_malloc::0::1"
			push 	de
	C_LINE	100,"aplib.h::my_malloc::0::1"
			ex	de,hl
	C_LINE	102,"aplib.h::my_malloc::0::1"
			ld	d,iyh
	C_LINE	103,"aplib.h::my_malloc::0::1"
			ld	e,iyl
	C_LINE	104,"aplib.h::my_malloc::0::1"
			jr 	ap_finishup
	C_LINE	107,"aplib.h::my_malloc::0::1"
	.ap_getbit	ld	a,ixl
	C_LINE	108,"aplib.h::my_malloc::0::1"
			add	a,a
	C_LINE	109,"aplib.h::my_malloc::0::1"
			ld	ixl,a
	C_LINE	110,"aplib.h::my_malloc::0::1"
			ret	nz
	C_LINE	111,"aplib.h::my_malloc::0::1"
			ld	a,(hl)
	C_LINE	112,"aplib.h::my_malloc::0::1"
			inc	hl
	C_LINE	113,"aplib.h::my_malloc::0::1"
			rla
	C_LINE	114,"aplib.h::my_malloc::0::1"
			ld	ixl,a
	C_LINE	115,"aplib.h::my_malloc::0::1"
			ret
	C_LINE	117,"aplib.h::my_malloc::0::1"
	.ap_getgamma	ld 	bc,1
	C_LINE	118,"aplib.h::my_malloc::0::1"
	.ap_getgammaloop	call 	ap_getbit
	C_LINE	119,"aplib.h::my_malloc::0::1"
			rl 	c
	C_LINE	120,"aplib.h::my_malloc::0::1"
			rl 	b
	C_LINE	121,"aplib.h::my_malloc::0::1"
			call 	ap_getbit
	C_LINE	122,"aplib.h::my_malloc::0::1"
			jr 	c,ap_getgammaloop
	C_LINE	123,"aplib.h::my_malloc::0::1"
			ret
	C_LINE	125,"aplib.h::my_malloc::0::1"
;	
	C_LINE	147,"aplib.h::my_malloc::0::1"
;		void unpack (unsigned int address, unsigned int destination) {
	C_LINE	148,"aplib.h::my_malloc::0::1"
	C_LINE	148,"aplib.h::my_malloc::0::1"

; Function unpack flags 0x00000200 __smallc 
; void unpack(unsigned int address, unsigned int destination)
; parameter 'unsigned int destination' at sp+2 size(2)
; parameter 'unsigned int address' at sp+4 size(2)
	C_LINE	148,"aplib.h::unpack::0::1"
._unpack
	C_LINE	148,"aplib.h::unpack::0::1"
;			ram_address = address; ram_destination = destination;
	C_LINE	149,"aplib.h::unpack::1::2"
	C_LINE	149,"aplib.h::unpack::1::2"
	ld	hl,4	;const
	call	l_gintsp	;
	ld	(_ram_address),hl
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(_ram_destination),hl
;			#asm
	C_LINE	150,"aplib.h::unpack::1::2"
	C_LINE	150,"aplib.h::unpack::1::2"
	C_LINE	152,"aplib.h::unpack::1::2"
				ld hl, (_ram_address)
	C_LINE	153,"aplib.h::unpack::1::2"
				ld de, (_ram_destination)
	C_LINE	154,"aplib.h::unpack::1::2"
				call depack
	C_LINE	155,"aplib.h::unpack::1::2"
;		}
	C_LINE	157,"aplib.h::unpack::1::2"
	ret


;			
	C_LINE	158,"aplib.h::unpack::0::2"
;#line 81 "mk1.c"
	C_LINE	159,"aplib.h::unpack::0::2"
	C_LINE	80,"mk1.c::unpack::0::2"
;#line 1 "pantallas.h"
	C_LINE	81,"mk1.c::unpack::0::2"
	C_LINE	0,"pantallas.h::unpack::0::2"
; 
	C_LINE	1,"pantallas.h::unpack::0::2"
; 
	C_LINE	2,"pantallas.h::unpack::0::2"
; 
	C_LINE	4,"pantallas.h::unpack::0::2"
; 
	C_LINE	5,"pantallas.h::unpack::0::2"
; 
	C_LINE	6,"pantallas.h::unpack::0::2"
;	extern unsigned char s_title [];
	C_LINE	9,"pantallas.h::unpack::0::2"
	C_LINE	9,"pantallas.h::unpack::0::2"
;	extern unsigned char s_marco [];
	C_LINE	10,"pantallas.h::unpack::0::2"
	C_LINE	10,"pantallas.h::unpack::0::2"
;	extern unsigned char s_ending [];
	C_LINE	11,"pantallas.h::unpack::0::2"
	C_LINE	11,"pantallas.h::unpack::0::2"
;	#asm
	C_LINE	13,"pantallas.h::unpack::0::2"
	C_LINE	13,"pantallas.h::unpack::0::2"
	C_LINE	15,"pantallas.h::unpack::0::2"
		._s_title
	C_LINE	16,"pantallas.h::unpack::0::2"
			BINARY "..\bin\title.bin"
	C_LINE	17,"pantallas.h::unpack::0::2"
		._s_marco
	C_LINE	18,"pantallas.h::unpack::0::2"
;	
	C_LINE	20,"pantallas.h::unpack::0::2"
;	#asm
	C_LINE	23,"pantallas.h::unpack::0::2"
	C_LINE	23,"pantallas.h::unpack::0::2"
	C_LINE	25,"pantallas.h::unpack::0::2"
		._s_ending
	C_LINE	26,"pantallas.h::unpack::0::2"
			BINARY "..\bin\ending.bin"
	C_LINE	27,"pantallas.h::unpack::0::2"
;void blackout (void) {
	C_LINE	30,"pantallas.h::unpack::0::2"
	C_LINE	30,"pantallas.h::unpack::0::2"

; Function blackout flags 0x00000200 __smallc 
; void blackout()
	C_LINE	30,"pantallas.h::blackout::0::2"
._blackout
	C_LINE	30,"pantallas.h::blackout::0::2"
;	#asm
	C_LINE	31,"pantallas.h::blackout::1::3"
	C_LINE	31,"pantallas.h::blackout::1::3"
	C_LINE	33,"pantallas.h::blackout::1::3"
		ld hl, 22528
	C_LINE	34,"pantallas.h::blackout::1::3"
		ld (hl), 0
	C_LINE	35,"pantallas.h::blackout::1::3"
		push hl
	C_LINE	36,"pantallas.h::blackout::1::3"
		pop de
	C_LINE	37,"pantallas.h::blackout::1::3"
		inc de
	C_LINE	38,"pantallas.h::blackout::1::3"
		ld bc, 767
	C_LINE	39,"pantallas.h::blackout::1::3"
		ldir
	C_LINE	40,"pantallas.h::blackout::1::3"
;}
	C_LINE	42,"pantallas.h::blackout::1::3"
	ret


;#line 82 "mk1.c"
	C_LINE	43,"pantallas.h::blackout::0::3"
	C_LINE	81,"mk1.c::blackout::0::3"
;	#line 1 "assets/levels.h"
	C_LINE	84,"mk1.c::blackout::0::3"
	C_LINE	0,"assets/levels.h::blackout::0::3"
; 
	C_LINE	1,"assets/levels.h::blackout::0::3"
; 
	C_LINE	2,"assets/levels.h::blackout::0::3"
; 
	C_LINE	4,"assets/levels.h::blackout::0::3"
; 
	C_LINE	6,"assets/levels.h::blackout::0::3"
; 
	C_LINE	7,"assets/levels.h::blackout::0::3"
; 
	C_LINE	9,"assets/levels.h::blackout::0::3"
; 
	C_LINE	10,"assets/levels.h::blackout::0::3"
; 
	C_LINE	12,"assets/levels.h::blackout::0::3"
; 
	C_LINE	13,"assets/levels.h::blackout::0::3"
; 
	C_LINE	14,"assets/levels.h::blackout::0::3"
; 
	C_LINE	15,"assets/levels.h::blackout::0::3"
; 
	C_LINE	16,"assets/levels.h::blackout::0::3"
; 
	C_LINE	17,"assets/levels.h::blackout::0::3"
; 
	C_LINE	18,"assets/levels.h::blackout::0::3"
; 
	C_LINE	19,"assets/levels.h::blackout::0::3"
; 
	C_LINE	20,"assets/levels.h::blackout::0::3"
; 
	C_LINE	22,"assets/levels.h::blackout::0::3"
; 
	C_LINE	24,"assets/levels.h::blackout::0::3"
; 
	C_LINE	27,"assets/levels.h::blackout::0::3"
;typedef struct {
	C_LINE	29,"assets/levels.h::blackout::0::3"
	C_LINE	29,"assets/levels.h::blackout::0::3"
;	unsigned char map_w, map_h;
	C_LINE	30,"assets/levels.h::blackout::0::3"
;	unsigned char scr_ini, ini_x, ini_y;
	C_LINE	31,"assets/levels.h::blackout::0::3"
;	unsigned char max_objs;
	C_LINE	32,"assets/levels.h::blackout::0::3"
;	unsigned char enems_life;
	C_LINE	33,"assets/levels.h::blackout::0::3"
;	unsigned char d01;	 
	C_LINE	34,"assets/levels.h::blackout::0::3"
;	unsigned char d02;
	C_LINE	35,"assets/levels.h::blackout::0::3"
;	unsigned char d03;
	C_LINE	36,"assets/levels.h::blackout::0::3"
;	unsigned char d04;
	C_LINE	37,"assets/levels.h::blackout::0::3"
;	unsigned char d05;
	C_LINE	38,"assets/levels.h::blackout::0::3"
;	unsigned char d06;
	C_LINE	39,"assets/levels.h::blackout::0::3"
;	unsigned char d07;
	C_LINE	40,"assets/levels.h::blackout::0::3"
;	unsigned char d08;
	C_LINE	41,"assets/levels.h::blackout::0::3"
;	unsigned char d09;
	C_LINE	42,"assets/levels.h::blackout::0::3"
;} LEVELHEADER;
	C_LINE	43,"assets/levels.h::blackout::0::3"
;typedef struct {
	C_LINE	45,"assets/levels.h::blackout::0::3"
	C_LINE	45,"assets/levels.h::blackout::0::3"
;    unsigned char np, x, y, st;
	C_LINE	46,"assets/levels.h::blackout::0::3"
;} CERROJOS;
	C_LINE	47,"assets/levels.h::blackout::0::3"
;typedef struct {
	C_LINE	49,"assets/levels.h::blackout::0::3"
	C_LINE	49,"assets/levels.h::blackout::0::3"
;	unsigned char x, y;
	C_LINE	50,"assets/levels.h::blackout::0::3"
;	unsigned char x1, y1, x2, y2;
	C_LINE	51,"assets/levels.h::blackout::0::3"
;	char mx, my;
	C_LINE	52,"assets/levels.h::blackout::0::3"
;	unsigned char t, life;
	C_LINE	53,"assets/levels.h::blackout::0::3"
;} MALOTE;
	C_LINE	54,"assets/levels.h::blackout::0::3"
;typedef struct {
	C_LINE	56,"assets/levels.h::blackout::0::3"
	C_LINE	56,"assets/levels.h::blackout::0::3"
;	unsigned char xy, tipo, act;
	C_LINE	57,"assets/levels.h::blackout::0::3"
;} HOTSPOT;
	C_LINE	58,"assets/levels.h::blackout::0::3"
; 
	C_LINE	60,"assets/levels.h::blackout::0::3"
;extern unsigned char font [0];
	C_LINE	62,"assets/levels.h::blackout::0::3"
	C_LINE	62,"assets/levels.h::blackout::0::3"
;#asm
	C_LINE	63,"assets/levels.h::blackout::0::3"
	C_LINE	63,"assets/levels.h::blackout::0::3"
	C_LINE	65,"assets/levels.h::blackout::0::3"
	._font BINARY "font.bin"
	C_LINE	66,"assets/levels.h::blackout::0::3"
;extern LEVELHEADER level_data;
	C_LINE	69,"assets/levels.h::blackout::0::3"
	C_LINE	69,"assets/levels.h::blackout::0::3"
;#asm
	C_LINE	70,"assets/levels.h::blackout::0::3"
	C_LINE	70,"assets/levels.h::blackout::0::3"
	C_LINE	72,"assets/levels.h::blackout::0::3"
	._level_data defs 16
	C_LINE	73,"assets/levels.h::blackout::0::3"
;extern unsigned char mapa [0];
	C_LINE	76,"assets/levels.h::blackout::0::3"
	C_LINE	76,"assets/levels.h::blackout::0::3"
;	#asm
	C_LINE	78,"assets/levels.h::blackout::0::3"
	C_LINE	78,"assets/levels.h::blackout::0::3"
	C_LINE	80,"assets/levels.h::blackout::0::3"
		._mapa defs  1  *  24  * 75
	C_LINE	81,"assets/levels.h::blackout::0::3"
;	extern CERROJOS cerrojos [0];
	C_LINE	84,"assets/levels.h::blackout::0::3"
	C_LINE	84,"assets/levels.h::blackout::0::3"
;	#asm
	C_LINE	85,"assets/levels.h::blackout::0::3"
	C_LINE	85,"assets/levels.h::blackout::0::3"
	C_LINE	87,"assets/levels.h::blackout::0::3"
		._cerrojos defs 128	; 32 * 4
	C_LINE	88,"assets/levels.h::blackout::0::3"
;extern unsigned char tileset [0];
	C_LINE	91,"assets/levels.h::blackout::0::3"
	C_LINE	91,"assets/levels.h::blackout::0::3"
;#asm
	C_LINE	92,"assets/levels.h::blackout::0::3"
	C_LINE	92,"assets/levels.h::blackout::0::3"
	C_LINE	94,"assets/levels.h::blackout::0::3"
	._tileset defs 1792 ; 192 * 8 + 256
	C_LINE	95,"assets/levels.h::blackout::0::3"
;extern MALOTE malotes [0];
	C_LINE	98,"assets/levels.h::blackout::0::3"
	C_LINE	98,"assets/levels.h::blackout::0::3"
;#asm
	C_LINE	99,"assets/levels.h::blackout::0::3"
	C_LINE	99,"assets/levels.h::blackout::0::3"
	C_LINE	101,"assets/levels.h::blackout::0::3"
	._malotes defs  1  *  24  *  3  * 10
	C_LINE	102,"assets/levels.h::blackout::0::3"
;extern HOTSPOT hotspots [0];
	C_LINE	105,"assets/levels.h::blackout::0::3"
	C_LINE	105,"assets/levels.h::blackout::0::3"
;#asm
	C_LINE	106,"assets/levels.h::blackout::0::3"
	C_LINE	106,"assets/levels.h::blackout::0::3"
	C_LINE	108,"assets/levels.h::blackout::0::3"
	._hotspots defs  1  *  24  * 3
	C_LINE	109,"assets/levels.h::blackout::0::3"
;extern unsigned char behs [0];
	C_LINE	112,"assets/levels.h::blackout::0::3"
	C_LINE	112,"assets/levels.h::blackout::0::3"
;#asm
	C_LINE	113,"assets/levels.h::blackout::0::3"
	C_LINE	113,"assets/levels.h::blackout::0::3"
	C_LINE	115,"assets/levels.h::blackout::0::3"
	._behs defs 48
	C_LINE	116,"assets/levels.h::blackout::0::3"
;extern unsigned char sprites [0];
	C_LINE	119,"assets/levels.h::blackout::0::3"
	C_LINE	119,"assets/levels.h::blackout::0::3"
;#asm
	C_LINE	120,"assets/levels.h::blackout::0::3"
	C_LINE	120,"assets/levels.h::blackout::0::3"
	C_LINE	122,"assets/levels.h::blackout::0::3"
	._sprites
	C_LINE	123,"assets/levels.h::blackout::0::3"
;	#line 1 "./assets/sprites.h"
	C_LINE	126,"assets/levels.h::blackout::0::3"
	C_LINE	0,"./assets/sprites.h::blackout::0::3"
; 
	C_LINE	1,"./assets/sprites.h::blackout::0::3"
; 
	C_LINE	2,"./assets/sprites.h::blackout::0::3"
; 
	C_LINE	4,"./assets/sprites.h::blackout::0::3"
; 
	C_LINE	5,"./assets/sprites.h::blackout::0::3"
; 
	C_LINE	6,"./assets/sprites.h::blackout::0::3"
; 
	C_LINE	7,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_1_a []; 
	C_LINE	8,"./assets/sprites.h::blackout::0::3"
	C_LINE	8,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_1_b []; 
	C_LINE	9,"./assets/sprites.h::blackout::0::3"
	C_LINE	9,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_1_c []; 
	C_LINE	10,"./assets/sprites.h::blackout::0::3"
	C_LINE	10,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_2_a []; 
	C_LINE	11,"./assets/sprites.h::blackout::0::3"
	C_LINE	11,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_2_b []; 
	C_LINE	12,"./assets/sprites.h::blackout::0::3"
	C_LINE	12,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_2_c []; 
	C_LINE	13,"./assets/sprites.h::blackout::0::3"
	C_LINE	13,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_3_a []; 
	C_LINE	14,"./assets/sprites.h::blackout::0::3"
	C_LINE	14,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_3_b []; 
	C_LINE	15,"./assets/sprites.h::blackout::0::3"
	C_LINE	15,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_3_c []; 
	C_LINE	16,"./assets/sprites.h::blackout::0::3"
	C_LINE	16,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_4_a []; 
	C_LINE	17,"./assets/sprites.h::blackout::0::3"
	C_LINE	17,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_4_b []; 
	C_LINE	18,"./assets/sprites.h::blackout::0::3"
	C_LINE	18,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_4_c []; 
	C_LINE	19,"./assets/sprites.h::blackout::0::3"
	C_LINE	19,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_5_a []; 
	C_LINE	20,"./assets/sprites.h::blackout::0::3"
	C_LINE	20,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_5_b []; 
	C_LINE	21,"./assets/sprites.h::blackout::0::3"
	C_LINE	21,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_5_c []; 
	C_LINE	22,"./assets/sprites.h::blackout::0::3"
	C_LINE	22,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_6_a []; 
	C_LINE	23,"./assets/sprites.h::blackout::0::3"
	C_LINE	23,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_6_b []; 
	C_LINE	24,"./assets/sprites.h::blackout::0::3"
	C_LINE	24,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_6_c []; 
	C_LINE	25,"./assets/sprites.h::blackout::0::3"
	C_LINE	25,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_7_a []; 
	C_LINE	26,"./assets/sprites.h::blackout::0::3"
	C_LINE	26,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_7_b []; 
	C_LINE	27,"./assets/sprites.h::blackout::0::3"
	C_LINE	27,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_7_c []; 
	C_LINE	28,"./assets/sprites.h::blackout::0::3"
	C_LINE	28,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_8_a []; 
	C_LINE	29,"./assets/sprites.h::blackout::0::3"
	C_LINE	29,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_8_b []; 
	C_LINE	30,"./assets/sprites.h::blackout::0::3"
	C_LINE	30,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_8_c []; 
	C_LINE	31,"./assets/sprites.h::blackout::0::3"
	C_LINE	31,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_9_a []; 
	C_LINE	32,"./assets/sprites.h::blackout::0::3"
	C_LINE	32,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_9_b []; 
	C_LINE	33,"./assets/sprites.h::blackout::0::3"
	C_LINE	33,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_9_c []; 
	C_LINE	34,"./assets/sprites.h::blackout::0::3"
	C_LINE	34,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_10_a []; 
	C_LINE	35,"./assets/sprites.h::blackout::0::3"
	C_LINE	35,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_10_b []; 
	C_LINE	36,"./assets/sprites.h::blackout::0::3"
	C_LINE	36,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_10_c []; 
	C_LINE	37,"./assets/sprites.h::blackout::0::3"
	C_LINE	37,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_11_a []; 
	C_LINE	38,"./assets/sprites.h::blackout::0::3"
	C_LINE	38,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_11_b []; 
	C_LINE	39,"./assets/sprites.h::blackout::0::3"
	C_LINE	39,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_11_c []; 
	C_LINE	40,"./assets/sprites.h::blackout::0::3"
	C_LINE	40,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_12_a []; 
	C_LINE	41,"./assets/sprites.h::blackout::0::3"
	C_LINE	41,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_12_b []; 
	C_LINE	42,"./assets/sprites.h::blackout::0::3"
	C_LINE	42,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_12_c []; 
	C_LINE	43,"./assets/sprites.h::blackout::0::3"
	C_LINE	43,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_13_a []; 
	C_LINE	44,"./assets/sprites.h::blackout::0::3"
	C_LINE	44,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_13_b []; 
	C_LINE	45,"./assets/sprites.h::blackout::0::3"
	C_LINE	45,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_13_c []; 
	C_LINE	46,"./assets/sprites.h::blackout::0::3"
	C_LINE	46,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_14_a []; 
	C_LINE	47,"./assets/sprites.h::blackout::0::3"
	C_LINE	47,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_14_b []; 
	C_LINE	48,"./assets/sprites.h::blackout::0::3"
	C_LINE	48,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_14_c []; 
	C_LINE	49,"./assets/sprites.h::blackout::0::3"
	C_LINE	49,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_15_a []; 
	C_LINE	50,"./assets/sprites.h::blackout::0::3"
	C_LINE	50,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_15_b []; 
	C_LINE	51,"./assets/sprites.h::blackout::0::3"
	C_LINE	51,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_15_c []; 
	C_LINE	52,"./assets/sprites.h::blackout::0::3"
	C_LINE	52,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_16_a []; 
	C_LINE	53,"./assets/sprites.h::blackout::0::3"
	C_LINE	53,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_16_b []; 
	C_LINE	54,"./assets/sprites.h::blackout::0::3"
	C_LINE	54,"./assets/sprites.h::blackout::0::3"
;extern unsigned char sprite_16_c []; 
	C_LINE	55,"./assets/sprites.h::blackout::0::3"
	C_LINE	55,"./assets/sprites.h::blackout::0::3"
; 
	C_LINE	56,"./assets/sprites.h::blackout::0::3"
;#asm
	C_LINE	57,"./assets/sprites.h::blackout::0::3"
	C_LINE	57,"./assets/sprites.h::blackout::0::3"
	C_LINE	59,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	60,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	61,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	62,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	63,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	64,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	65,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	66,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	67,"./assets/sprites.h::blackout::0::3"
	C_LINE	68,"./assets/sprites.h::blackout::0::3"
    ._sprite_1_a
	C_LINE	69,"./assets/sprites.h::blackout::0::3"
        defb 0, 224
	C_LINE	70,"./assets/sprites.h::blackout::0::3"
        defb 15, 192
	C_LINE	71,"./assets/sprites.h::blackout::0::3"
        defb 30, 192
	C_LINE	72,"./assets/sprites.h::blackout::0::3"
        defb 31, 192
	C_LINE	73,"./assets/sprites.h::blackout::0::3"
        defb 31, 192
	C_LINE	74,"./assets/sprites.h::blackout::0::3"
        defb 28, 192
	C_LINE	75,"./assets/sprites.h::blackout::0::3"
        defb 5, 0
	C_LINE	76,"./assets/sprites.h::blackout::0::3"
        defb 58, 0
	C_LINE	77,"./assets/sprites.h::blackout::0::3"
        defb 96, 0
	C_LINE	78,"./assets/sprites.h::blackout::0::3"
        defb 118, 0
	C_LINE	79,"./assets/sprites.h::blackout::0::3"
        defb 52, 0
	C_LINE	80,"./assets/sprites.h::blackout::0::3"
        defb 1, 0
	C_LINE	81,"./assets/sprites.h::blackout::0::3"
        defb 5, 224
	C_LINE	82,"./assets/sprites.h::blackout::0::3"
        defb 5, 224
	C_LINE	83,"./assets/sprites.h::blackout::0::3"
        defb 0, 224
	C_LINE	84,"./assets/sprites.h::blackout::0::3"
        defb 5, 224
	C_LINE	85,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	86,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	87,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	88,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	89,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	90,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	91,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	92,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	93,"./assets/sprites.h::blackout::0::3"
	C_LINE	94,"./assets/sprites.h::blackout::0::3"
    ._sprite_1_b
	C_LINE	95,"./assets/sprites.h::blackout::0::3"
        defb 0, 63
	C_LINE	96,"./assets/sprites.h::blackout::0::3"
        defb 128, 31
	C_LINE	97,"./assets/sprites.h::blackout::0::3"
        defb 192, 31
	C_LINE	98,"./assets/sprites.h::blackout::0::3"
        defb 64, 7
	C_LINE	99,"./assets/sprites.h::blackout::0::3"
        defb 240, 7
	C_LINE	100,"./assets/sprites.h::blackout::0::3"
        defb 0, 7
	C_LINE	101,"./assets/sprites.h::blackout::0::3"
        defb 192, 7
	C_LINE	102,"./assets/sprites.h::blackout::0::3"
        defb 0, 0
	C_LINE	103,"./assets/sprites.h::blackout::0::3"
        defb 254, 0
	C_LINE	104,"./assets/sprites.h::blackout::0::3"
        defb 194, 0
	C_LINE	105,"./assets/sprites.h::blackout::0::3"
        defb 24, 0
	C_LINE	106,"./assets/sprites.h::blackout::0::3"
        defb 0, 0
	C_LINE	107,"./assets/sprites.h::blackout::0::3"
        defb 128, 31
	C_LINE	108,"./assets/sprites.h::blackout::0::3"
        defb 128, 31
	C_LINE	109,"./assets/sprites.h::blackout::0::3"
        defb 0, 31
	C_LINE	110,"./assets/sprites.h::blackout::0::3"
        defb 192, 31
	C_LINE	111,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	112,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	113,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	114,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	115,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	116,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	117,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	118,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	119,"./assets/sprites.h::blackout::0::3"
	C_LINE	120,"./assets/sprites.h::blackout::0::3"
    ._sprite_1_c
	C_LINE	121,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	122,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	123,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	124,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	125,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	126,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	127,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	128,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	129,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	130,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	131,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	132,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	133,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	134,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	135,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	136,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	137,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	138,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	139,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	140,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	141,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	142,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	143,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	144,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	145,"./assets/sprites.h::blackout::0::3"
	C_LINE	146,"./assets/sprites.h::blackout::0::3"
    ._sprite_2_a
	C_LINE	147,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	148,"./assets/sprites.h::blackout::0::3"
        defb 0, 224
	C_LINE	149,"./assets/sprites.h::blackout::0::3"
        defb 15, 192
	C_LINE	150,"./assets/sprites.h::blackout::0::3"
        defb 30, 192
	C_LINE	151,"./assets/sprites.h::blackout::0::3"
        defb 31, 192
	C_LINE	152,"./assets/sprites.h::blackout::0::3"
        defb 31, 192
	C_LINE	153,"./assets/sprites.h::blackout::0::3"
        defb 4, 128
	C_LINE	154,"./assets/sprites.h::blackout::0::3"
        defb 27, 128
	C_LINE	155,"./assets/sprites.h::blackout::0::3"
        defb 48, 128
	C_LINE	156,"./assets/sprites.h::blackout::0::3"
        defb 59, 128
	C_LINE	157,"./assets/sprites.h::blackout::0::3"
        defb 26, 128
	C_LINE	158,"./assets/sprites.h::blackout::0::3"
        defb 1, 128
	C_LINE	159,"./assets/sprites.h::blackout::0::3"
        defb 44, 128
	C_LINE	160,"./assets/sprites.h::blackout::0::3"
        defb 44, 128
	C_LINE	161,"./assets/sprites.h::blackout::0::3"
        defb 32, 128
	C_LINE	162,"./assets/sprites.h::blackout::0::3"
        defb 0, 128
	C_LINE	163,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	164,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	165,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	166,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	167,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	168,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	169,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	170,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	171,"./assets/sprites.h::blackout::0::3"
	C_LINE	172,"./assets/sprites.h::blackout::0::3"
    ._sprite_2_b
	C_LINE	173,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	174,"./assets/sprites.h::blackout::0::3"
        defb 0, 63
	C_LINE	175,"./assets/sprites.h::blackout::0::3"
        defb 128, 31
	C_LINE	176,"./assets/sprites.h::blackout::0::3"
        defb 192, 15
	C_LINE	177,"./assets/sprites.h::blackout::0::3"
        defb 64, 7
	C_LINE	178,"./assets/sprites.h::blackout::0::3"
        defb 240, 7
	C_LINE	179,"./assets/sprites.h::blackout::0::3"
        defb 0, 7
	C_LINE	180,"./assets/sprites.h::blackout::0::3"
        defb 128, 0
	C_LINE	181,"./assets/sprites.h::blackout::0::3"
        defb 127, 0
	C_LINE	182,"./assets/sprites.h::blackout::0::3"
        defb 97, 0
	C_LINE	183,"./assets/sprites.h::blackout::0::3"
        defb 12, 0
	C_LINE	184,"./assets/sprites.h::blackout::0::3"
        defb 192, 0
	C_LINE	185,"./assets/sprites.h::blackout::0::3"
        defb 192, 15
	C_LINE	186,"./assets/sprites.h::blackout::0::3"
        defb 0, 15
	C_LINE	187,"./assets/sprites.h::blackout::0::3"
        defb 224, 15
	C_LINE	188,"./assets/sprites.h::blackout::0::3"
        defb 0, 15
	C_LINE	189,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	190,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	191,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	192,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	193,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	194,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	195,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	196,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	197,"./assets/sprites.h::blackout::0::3"
	C_LINE	198,"./assets/sprites.h::blackout::0::3"
    ._sprite_2_c
	C_LINE	199,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	200,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	201,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	202,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	203,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	204,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	205,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	206,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	207,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	208,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	209,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	210,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	211,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	212,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	213,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	214,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	215,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	216,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	217,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	218,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	219,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	220,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	221,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	222,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	223,"./assets/sprites.h::blackout::0::3"
	C_LINE	224,"./assets/sprites.h::blackout::0::3"
    ._sprite_3_a
	C_LINE	225,"./assets/sprites.h::blackout::0::3"
        defb 0, 252
	C_LINE	226,"./assets/sprites.h::blackout::0::3"
        defb 1, 248
	C_LINE	227,"./assets/sprites.h::blackout::0::3"
        defb 3, 248
	C_LINE	228,"./assets/sprites.h::blackout::0::3"
        defb 2, 224
	C_LINE	229,"./assets/sprites.h::blackout::0::3"
        defb 15, 224
	C_LINE	230,"./assets/sprites.h::blackout::0::3"
        defb 0, 224
	C_LINE	231,"./assets/sprites.h::blackout::0::3"
        defb 3, 224
	C_LINE	232,"./assets/sprites.h::blackout::0::3"
        defb 0, 0
	C_LINE	233,"./assets/sprites.h::blackout::0::3"
        defb 127, 0
	C_LINE	234,"./assets/sprites.h::blackout::0::3"
        defb 67, 0
	C_LINE	235,"./assets/sprites.h::blackout::0::3"
        defb 24, 0
	C_LINE	236,"./assets/sprites.h::blackout::0::3"
        defb 0, 0
	C_LINE	237,"./assets/sprites.h::blackout::0::3"
        defb 1, 248
	C_LINE	238,"./assets/sprites.h::blackout::0::3"
        defb 1, 248
	C_LINE	239,"./assets/sprites.h::blackout::0::3"
        defb 0, 248
	C_LINE	240,"./assets/sprites.h::blackout::0::3"
        defb 3, 248
	C_LINE	241,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	242,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	243,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	244,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	245,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	246,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	247,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	248,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	249,"./assets/sprites.h::blackout::0::3"
	C_LINE	250,"./assets/sprites.h::blackout::0::3"
    ._sprite_3_b
	C_LINE	251,"./assets/sprites.h::blackout::0::3"
        defb 0, 7
	C_LINE	252,"./assets/sprites.h::blackout::0::3"
        defb 240, 3
	C_LINE	253,"./assets/sprites.h::blackout::0::3"
        defb 120, 3
	C_LINE	254,"./assets/sprites.h::blackout::0::3"
        defb 248, 3
	C_LINE	255,"./assets/sprites.h::blackout::0::3"
        defb 248, 3
	C_LINE	256,"./assets/sprites.h::blackout::0::3"
        defb 56, 3
	C_LINE	257,"./assets/sprites.h::blackout::0::3"
        defb 160, 0
	C_LINE	258,"./assets/sprites.h::blackout::0::3"
        defb 92, 0
	C_LINE	259,"./assets/sprites.h::blackout::0::3"
        defb 6, 0
	C_LINE	260,"./assets/sprites.h::blackout::0::3"
        defb 110, 0
	C_LINE	261,"./assets/sprites.h::blackout::0::3"
        defb 44, 0
	C_LINE	262,"./assets/sprites.h::blackout::0::3"
        defb 128, 0
	C_LINE	263,"./assets/sprites.h::blackout::0::3"
        defb 160, 7
	C_LINE	264,"./assets/sprites.h::blackout::0::3"
        defb 160, 7
	C_LINE	265,"./assets/sprites.h::blackout::0::3"
        defb 0, 7
	C_LINE	266,"./assets/sprites.h::blackout::0::3"
        defb 160, 7
	C_LINE	267,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	268,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	269,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	270,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	271,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	272,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	273,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	274,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	275,"./assets/sprites.h::blackout::0::3"
	C_LINE	276,"./assets/sprites.h::blackout::0::3"
    ._sprite_3_c
	C_LINE	277,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	278,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	279,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	280,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	281,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	282,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	283,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	284,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	285,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	286,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	287,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	288,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	289,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	290,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	291,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	292,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	293,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	294,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	295,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	296,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	297,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	298,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	299,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	300,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	301,"./assets/sprites.h::blackout::0::3"
	C_LINE	302,"./assets/sprites.h::blackout::0::3"
    ._sprite_4_a
	C_LINE	303,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	304,"./assets/sprites.h::blackout::0::3"
        defb 0, 252
	C_LINE	305,"./assets/sprites.h::blackout::0::3"
        defb 1, 248
	C_LINE	306,"./assets/sprites.h::blackout::0::3"
        defb 3, 240
	C_LINE	307,"./assets/sprites.h::blackout::0::3"
        defb 2, 224
	C_LINE	308,"./assets/sprites.h::blackout::0::3"
        defb 15, 224
	C_LINE	309,"./assets/sprites.h::blackout::0::3"
        defb 0, 224
	C_LINE	310,"./assets/sprites.h::blackout::0::3"
        defb 1, 0
	C_LINE	311,"./assets/sprites.h::blackout::0::3"
        defb 254, 0
	C_LINE	312,"./assets/sprites.h::blackout::0::3"
        defb 134, 0
	C_LINE	313,"./assets/sprites.h::blackout::0::3"
        defb 48, 0
	C_LINE	314,"./assets/sprites.h::blackout::0::3"
        defb 3, 0
	C_LINE	315,"./assets/sprites.h::blackout::0::3"
        defb 3, 240
	C_LINE	316,"./assets/sprites.h::blackout::0::3"
        defb 0, 240
	C_LINE	317,"./assets/sprites.h::blackout::0::3"
        defb 7, 240
	C_LINE	318,"./assets/sprites.h::blackout::0::3"
        defb 0, 240
	C_LINE	319,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	320,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	321,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	322,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	323,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	324,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	325,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	326,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	327,"./assets/sprites.h::blackout::0::3"
	C_LINE	328,"./assets/sprites.h::blackout::0::3"
    ._sprite_4_b
	C_LINE	329,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	330,"./assets/sprites.h::blackout::0::3"
        defb 0, 7
	C_LINE	331,"./assets/sprites.h::blackout::0::3"
        defb 240, 3
	C_LINE	332,"./assets/sprites.h::blackout::0::3"
        defb 120, 3
	C_LINE	333,"./assets/sprites.h::blackout::0::3"
        defb 248, 3
	C_LINE	334,"./assets/sprites.h::blackout::0::3"
        defb 248, 3
	C_LINE	335,"./assets/sprites.h::blackout::0::3"
        defb 32, 1
	C_LINE	336,"./assets/sprites.h::blackout::0::3"
        defb 216, 1
	C_LINE	337,"./assets/sprites.h::blackout::0::3"
        defb 12, 1
	C_LINE	338,"./assets/sprites.h::blackout::0::3"
        defb 220, 1
	C_LINE	339,"./assets/sprites.h::blackout::0::3"
        defb 88, 1
	C_LINE	340,"./assets/sprites.h::blackout::0::3"
        defb 128, 1
	C_LINE	341,"./assets/sprites.h::blackout::0::3"
        defb 52, 1
	C_LINE	342,"./assets/sprites.h::blackout::0::3"
        defb 52, 1
	C_LINE	343,"./assets/sprites.h::blackout::0::3"
        defb 4, 1
	C_LINE	344,"./assets/sprites.h::blackout::0::3"
        defb 0, 1
	C_LINE	345,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	346,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	347,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	348,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	349,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	350,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	351,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	352,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	353,"./assets/sprites.h::blackout::0::3"
	C_LINE	354,"./assets/sprites.h::blackout::0::3"
    ._sprite_4_c
	C_LINE	355,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	356,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	357,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	358,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	359,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	360,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	361,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	362,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	363,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	364,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	365,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	366,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	367,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	368,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	369,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	370,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	371,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	372,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	373,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	374,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	375,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	376,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	377,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	378,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	379,"./assets/sprites.h::blackout::0::3"
	C_LINE	380,"./assets/sprites.h::blackout::0::3"
    ._sprite_5_a
	C_LINE	381,"./assets/sprites.h::blackout::0::3"
        defb 0, 240
	C_LINE	382,"./assets/sprites.h::blackout::0::3"
        defb 7, 224
	C_LINE	383,"./assets/sprites.h::blackout::0::3"
        defb 13, 224
	C_LINE	384,"./assets/sprites.h::blackout::0::3"
        defb 11, 224
	C_LINE	385,"./assets/sprites.h::blackout::0::3"
        defb 15, 224
	C_LINE	386,"./assets/sprites.h::blackout::0::3"
        defb 7, 128
	C_LINE	387,"./assets/sprites.h::blackout::0::3"
        defb 40, 0
	C_LINE	388,"./assets/sprites.h::blackout::0::3"
        defb 111, 0
	C_LINE	389,"./assets/sprites.h::blackout::0::3"
        defb 110, 0
	C_LINE	390,"./assets/sprites.h::blackout::0::3"
        defb 53, 0
	C_LINE	391,"./assets/sprites.h::blackout::0::3"
        defb 0, 128
	C_LINE	392,"./assets/sprites.h::blackout::0::3"
        defb 6, 240
	C_LINE	393,"./assets/sprites.h::blackout::0::3"
        defb 0, 240
	C_LINE	394,"./assets/sprites.h::blackout::0::3"
        defb 0, 254
	C_LINE	395,"./assets/sprites.h::blackout::0::3"
        defb 0, 254
	C_LINE	396,"./assets/sprites.h::blackout::0::3"
        defb 0, 254
	C_LINE	397,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	398,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	399,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	400,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	401,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	402,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	403,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	404,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	405,"./assets/sprites.h::blackout::0::3"
	C_LINE	406,"./assets/sprites.h::blackout::0::3"
    ._sprite_5_b
	C_LINE	407,"./assets/sprites.h::blackout::0::3"
        defb 0, 31
	C_LINE	408,"./assets/sprites.h::blackout::0::3"
        defb 192, 15
	C_LINE	409,"./assets/sprites.h::blackout::0::3"
        defb 224, 1
	C_LINE	410,"./assets/sprites.h::blackout::0::3"
        defb 236, 1
	C_LINE	411,"./assets/sprites.h::blackout::0::3"
        defb 236, 1
	C_LINE	412,"./assets/sprites.h::blackout::0::3"
        defb 204, 0
	C_LINE	413,"./assets/sprites.h::blackout::0::3"
        defb 50, 0
	C_LINE	414,"./assets/sprites.h::blackout::0::3"
        defb 126, 0
	C_LINE	415,"./assets/sprites.h::blackout::0::3"
        defb 236, 0
	C_LINE	416,"./assets/sprites.h::blackout::0::3"
        defb 192, 1
	C_LINE	417,"./assets/sprites.h::blackout::0::3"
        defb 12, 1
	C_LINE	418,"./assets/sprites.h::blackout::0::3"
        defb 204, 1
	C_LINE	419,"./assets/sprites.h::blackout::0::3"
        defb 192, 1
	C_LINE	420,"./assets/sprites.h::blackout::0::3"
        defb 0, 31
	C_LINE	421,"./assets/sprites.h::blackout::0::3"
        defb 192, 31
	C_LINE	422,"./assets/sprites.h::blackout::0::3"
        defb 0, 31
	C_LINE	423,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	424,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	425,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	426,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	427,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	428,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	429,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	430,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	431,"./assets/sprites.h::blackout::0::3"
	C_LINE	432,"./assets/sprites.h::blackout::0::3"
    ._sprite_5_c
	C_LINE	433,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	434,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	435,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	436,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	437,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	438,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	439,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	440,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	441,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	442,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	443,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	444,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	445,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	446,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	447,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	448,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	449,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	450,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	451,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	452,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	453,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	454,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	455,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	456,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	457,"./assets/sprites.h::blackout::0::3"
	C_LINE	458,"./assets/sprites.h::blackout::0::3"
    ._sprite_6_a
	C_LINE	459,"./assets/sprites.h::blackout::0::3"
        defb 0, 240
	C_LINE	460,"./assets/sprites.h::blackout::0::3"
        defb 7, 224
	C_LINE	461,"./assets/sprites.h::blackout::0::3"
        defb 13, 224
	C_LINE	462,"./assets/sprites.h::blackout::0::3"
        defb 11, 224
	C_LINE	463,"./assets/sprites.h::blackout::0::3"
        defb 15, 224
	C_LINE	464,"./assets/sprites.h::blackout::0::3"
        defb 7, 128
	C_LINE	465,"./assets/sprites.h::blackout::0::3"
        defb 40, 0
	C_LINE	466,"./assets/sprites.h::blackout::0::3"
        defb 111, 0
	C_LINE	467,"./assets/sprites.h::blackout::0::3"
        defb 110, 0
	C_LINE	468,"./assets/sprites.h::blackout::0::3"
        defb 53, 0
	C_LINE	469,"./assets/sprites.h::blackout::0::3"
        defb 0, 128
	C_LINE	470,"./assets/sprites.h::blackout::0::3"
        defb 6, 240
	C_LINE	471,"./assets/sprites.h::blackout::0::3"
        defb 6, 240
	C_LINE	472,"./assets/sprites.h::blackout::0::3"
        defb 0, 240
	C_LINE	473,"./assets/sprites.h::blackout::0::3"
        defb 6, 240
	C_LINE	474,"./assets/sprites.h::blackout::0::3"
        defb 0, 240
	C_LINE	475,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	476,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	477,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	478,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	479,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	480,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	481,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	482,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	483,"./assets/sprites.h::blackout::0::3"
	C_LINE	484,"./assets/sprites.h::blackout::0::3"
    ._sprite_6_b
	C_LINE	485,"./assets/sprites.h::blackout::0::3"
        defb 0, 31
	C_LINE	486,"./assets/sprites.h::blackout::0::3"
        defb 192, 15
	C_LINE	487,"./assets/sprites.h::blackout::0::3"
        defb 224, 1
	C_LINE	488,"./assets/sprites.h::blackout::0::3"
        defb 236, 1
	C_LINE	489,"./assets/sprites.h::blackout::0::3"
        defb 236, 1
	C_LINE	490,"./assets/sprites.h::blackout::0::3"
        defb 204, 0
	C_LINE	491,"./assets/sprites.h::blackout::0::3"
        defb 50, 0
	C_LINE	492,"./assets/sprites.h::blackout::0::3"
        defb 126, 0
	C_LINE	493,"./assets/sprites.h::blackout::0::3"
        defb 236, 0
	C_LINE	494,"./assets/sprites.h::blackout::0::3"
        defb 192, 0
	C_LINE	495,"./assets/sprites.h::blackout::0::3"
        defb 12, 1
	C_LINE	496,"./assets/sprites.h::blackout::0::3"
        defb 204, 1
	C_LINE	497,"./assets/sprites.h::blackout::0::3"
        defb 0, 1
	C_LINE	498,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	499,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	500,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	501,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	502,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	503,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	504,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	505,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	506,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	507,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	508,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	509,"./assets/sprites.h::blackout::0::3"
	C_LINE	510,"./assets/sprites.h::blackout::0::3"
    ._sprite_6_c
	C_LINE	511,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	512,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	513,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	514,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	515,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	516,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	517,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	518,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	519,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	520,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	521,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	522,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	523,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	524,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	525,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	526,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	527,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	528,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	529,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	530,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	531,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	532,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	533,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	534,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	535,"./assets/sprites.h::blackout::0::3"
	C_LINE	536,"./assets/sprites.h::blackout::0::3"
    ._sprite_7_a
	C_LINE	537,"./assets/sprites.h::blackout::0::3"
        defb 0, 248
	C_LINE	538,"./assets/sprites.h::blackout::0::3"
        defb 3, 240
	C_LINE	539,"./assets/sprites.h::blackout::0::3"
        defb 6, 240
	C_LINE	540,"./assets/sprites.h::blackout::0::3"
        defb 5, 240
	C_LINE	541,"./assets/sprites.h::blackout::0::3"
        defb 7, 192
	C_LINE	542,"./assets/sprites.h::blackout::0::3"
        defb 16, 192
	C_LINE	543,"./assets/sprites.h::blackout::0::3"
        defb 27, 192
	C_LINE	544,"./assets/sprites.h::blackout::0::3"
        defb 24, 0
	C_LINE	545,"./assets/sprites.h::blackout::0::3"
        defb 89, 0
	C_LINE	546,"./assets/sprites.h::blackout::0::3"
        defb 91, 0
	C_LINE	547,"./assets/sprites.h::blackout::0::3"
        defb 88, 0
	C_LINE	548,"./assets/sprites.h::blackout::0::3"
        defb 27, 0
	C_LINE	549,"./assets/sprites.h::blackout::0::3"
        defb 3, 192
	C_LINE	550,"./assets/sprites.h::blackout::0::3"
        defb 24, 192
	C_LINE	551,"./assets/sprites.h::blackout::0::3"
        defb 3, 192
	C_LINE	552,"./assets/sprites.h::blackout::0::3"
        defb 0, 248
	C_LINE	553,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	554,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	555,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	556,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	557,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	558,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	559,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	560,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	561,"./assets/sprites.h::blackout::0::3"
	C_LINE	562,"./assets/sprites.h::blackout::0::3"
    ._sprite_7_b
	C_LINE	563,"./assets/sprites.h::blackout::0::3"
        defb 0, 15
	C_LINE	564,"./assets/sprites.h::blackout::0::3"
        defb 224, 7
	C_LINE	565,"./assets/sprites.h::blackout::0::3"
        defb 240, 7
	C_LINE	566,"./assets/sprites.h::blackout::0::3"
        defb 240, 7
	C_LINE	567,"./assets/sprites.h::blackout::0::3"
        defb 240, 7
	C_LINE	568,"./assets/sprites.h::blackout::0::3"
        defb 0, 3
	C_LINE	569,"./assets/sprites.h::blackout::0::3"
        defb 232, 1
	C_LINE	570,"./assets/sprites.h::blackout::0::3"
        defb 12, 1
	C_LINE	571,"./assets/sprites.h::blackout::0::3"
        defb 124, 1
	C_LINE	572,"./assets/sprites.h::blackout::0::3"
        defb 120, 1
	C_LINE	573,"./assets/sprites.h::blackout::0::3"
        defb 0, 3
	C_LINE	574,"./assets/sprites.h::blackout::0::3"
        defb 96, 15
	C_LINE	575,"./assets/sprites.h::blackout::0::3"
        defb 0, 15
	C_LINE	576,"./assets/sprites.h::blackout::0::3"
        defb 0, 127
	C_LINE	577,"./assets/sprites.h::blackout::0::3"
        defb 0, 127
	C_LINE	578,"./assets/sprites.h::blackout::0::3"
        defb 0, 127
	C_LINE	579,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	580,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	581,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	582,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	583,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	584,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	585,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	586,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	587,"./assets/sprites.h::blackout::0::3"
	C_LINE	588,"./assets/sprites.h::blackout::0::3"
    ._sprite_7_c
	C_LINE	589,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	590,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	591,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	592,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	593,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	594,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	595,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	596,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	597,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	598,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	599,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	600,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	601,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	602,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	603,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	604,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	605,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	606,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	607,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	608,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	609,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	610,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	611,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	612,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	613,"./assets/sprites.h::blackout::0::3"
	C_LINE	614,"./assets/sprites.h::blackout::0::3"
    ._sprite_8_a
	C_LINE	615,"./assets/sprites.h::blackout::0::3"
        defb 0, 248
	C_LINE	616,"./assets/sprites.h::blackout::0::3"
        defb 3, 240
	C_LINE	617,"./assets/sprites.h::blackout::0::3"
        defb 6, 240
	C_LINE	618,"./assets/sprites.h::blackout::0::3"
        defb 5, 240
	C_LINE	619,"./assets/sprites.h::blackout::0::3"
        defb 7, 192
	C_LINE	620,"./assets/sprites.h::blackout::0::3"
        defb 16, 192
	C_LINE	621,"./assets/sprites.h::blackout::0::3"
        defb 27, 192
	C_LINE	622,"./assets/sprites.h::blackout::0::3"
        defb 24, 0
	C_LINE	623,"./assets/sprites.h::blackout::0::3"
        defb 89, 0
	C_LINE	624,"./assets/sprites.h::blackout::0::3"
        defb 91, 0
	C_LINE	625,"./assets/sprites.h::blackout::0::3"
        defb 88, 0
	C_LINE	626,"./assets/sprites.h::blackout::0::3"
        defb 27, 0
	C_LINE	627,"./assets/sprites.h::blackout::0::3"
        defb 0, 192
	C_LINE	628,"./assets/sprites.h::blackout::0::3"
        defb 24, 195
	C_LINE	629,"./assets/sprites.h::blackout::0::3"
        defb 0, 195
	C_LINE	630,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	631,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	632,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	633,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	634,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	635,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	636,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	637,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	638,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	639,"./assets/sprites.h::blackout::0::3"
	C_LINE	640,"./assets/sprites.h::blackout::0::3"
    ._sprite_8_b
	C_LINE	641,"./assets/sprites.h::blackout::0::3"
        defb 0, 15
	C_LINE	642,"./assets/sprites.h::blackout::0::3"
        defb 224, 7
	C_LINE	643,"./assets/sprites.h::blackout::0::3"
        defb 240, 7
	C_LINE	644,"./assets/sprites.h::blackout::0::3"
        defb 240, 7
	C_LINE	645,"./assets/sprites.h::blackout::0::3"
        defb 240, 7
	C_LINE	646,"./assets/sprites.h::blackout::0::3"
        defb 0, 3
	C_LINE	647,"./assets/sprites.h::blackout::0::3"
        defb 232, 1
	C_LINE	648,"./assets/sprites.h::blackout::0::3"
        defb 12, 1
	C_LINE	649,"./assets/sprites.h::blackout::0::3"
        defb 124, 1
	C_LINE	650,"./assets/sprites.h::blackout::0::3"
        defb 120, 1
	C_LINE	651,"./assets/sprites.h::blackout::0::3"
        defb 0, 3
	C_LINE	652,"./assets/sprites.h::blackout::0::3"
        defb 96, 15
	C_LINE	653,"./assets/sprites.h::blackout::0::3"
        defb 96, 15
	C_LINE	654,"./assets/sprites.h::blackout::0::3"
        defb 0, 15
	C_LINE	655,"./assets/sprites.h::blackout::0::3"
        defb 96, 15
	C_LINE	656,"./assets/sprites.h::blackout::0::3"
        defb 0, 15
	C_LINE	657,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	658,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	659,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	660,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	661,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	662,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	663,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	664,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	665,"./assets/sprites.h::blackout::0::3"
	C_LINE	666,"./assets/sprites.h::blackout::0::3"
    ._sprite_8_c
	C_LINE	667,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	668,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	669,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	670,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	671,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	672,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	673,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	674,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	675,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	676,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	677,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	678,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	679,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	680,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	681,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	682,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	683,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	684,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	685,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	686,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	687,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	688,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	689,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	690,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	691,"./assets/sprites.h::blackout::0::3"
	C_LINE	692,"./assets/sprites.h::blackout::0::3"
    ._sprite_9_a
	C_LINE	693,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	694,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	695,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	696,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	697,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	698,"./assets/sprites.h::blackout::0::3"
        defb 0, 224
	C_LINE	699,"./assets/sprites.h::blackout::0::3"
        defb 14, 192
	C_LINE	700,"./assets/sprites.h::blackout::0::3"
        defb 31, 128
	C_LINE	701,"./assets/sprites.h::blackout::0::3"
        defb 59, 128
	C_LINE	702,"./assets/sprites.h::blackout::0::3"
        defb 49, 128
	C_LINE	703,"./assets/sprites.h::blackout::0::3"
        defb 0, 132
	C_LINE	704,"./assets/sprites.h::blackout::0::3"
        defb 0, 254
	C_LINE	705,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	706,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	707,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	708,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	709,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	710,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	711,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	712,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	713,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	714,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	715,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	716,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	717,"./assets/sprites.h::blackout::0::3"
	C_LINE	718,"./assets/sprites.h::blackout::0::3"
    ._sprite_9_b
	C_LINE	719,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	720,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	721,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	722,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	723,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	724,"./assets/sprites.h::blackout::0::3"
        defb 0, 225
	C_LINE	725,"./assets/sprites.h::blackout::0::3"
        defb 12, 65
	C_LINE	726,"./assets/sprites.h::blackout::0::3"
        defb 28, 1
	C_LINE	727,"./assets/sprites.h::blackout::0::3"
        defb 184, 1
	C_LINE	728,"./assets/sprites.h::blackout::0::3"
        defb 240, 3
	C_LINE	729,"./assets/sprites.h::blackout::0::3"
        defb 224, 7
	C_LINE	730,"./assets/sprites.h::blackout::0::3"
        defb 0, 15
	C_LINE	731,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	732,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	733,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	734,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	735,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	736,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	737,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	738,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	739,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	740,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	741,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	742,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	743,"./assets/sprites.h::blackout::0::3"
	C_LINE	744,"./assets/sprites.h::blackout::0::3"
    ._sprite_9_c
	C_LINE	745,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	746,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	747,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	748,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	749,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	750,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	751,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	752,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	753,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	754,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	755,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	756,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	757,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	758,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	759,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	760,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	761,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	762,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	763,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	764,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	765,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	766,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	767,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	768,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	769,"./assets/sprites.h::blackout::0::3"
	C_LINE	770,"./assets/sprites.h::blackout::0::3"
    ._sprite_10_a
	C_LINE	771,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	772,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	773,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	774,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	775,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	776,"./assets/sprites.h::blackout::0::3"
        defb 0, 135
	C_LINE	777,"./assets/sprites.h::blackout::0::3"
        defb 48, 130
	C_LINE	778,"./assets/sprites.h::blackout::0::3"
        defb 56, 128
	C_LINE	779,"./assets/sprites.h::blackout::0::3"
        defb 29, 128
	C_LINE	780,"./assets/sprites.h::blackout::0::3"
        defb 15, 192
	C_LINE	781,"./assets/sprites.h::blackout::0::3"
        defb 7, 224
	C_LINE	782,"./assets/sprites.h::blackout::0::3"
        defb 0, 240
	C_LINE	783,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	784,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	785,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	786,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	787,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	788,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	789,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	790,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	791,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	792,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	793,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	794,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	795,"./assets/sprites.h::blackout::0::3"
	C_LINE	796,"./assets/sprites.h::blackout::0::3"
    ._sprite_10_b
	C_LINE	797,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	798,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	799,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	800,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	801,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	802,"./assets/sprites.h::blackout::0::3"
        defb 0, 7
	C_LINE	803,"./assets/sprites.h::blackout::0::3"
        defb 112, 3
	C_LINE	804,"./assets/sprites.h::blackout::0::3"
        defb 248, 1
	C_LINE	805,"./assets/sprites.h::blackout::0::3"
        defb 220, 1
	C_LINE	806,"./assets/sprites.h::blackout::0::3"
        defb 140, 1
	C_LINE	807,"./assets/sprites.h::blackout::0::3"
        defb 0, 33
	C_LINE	808,"./assets/sprites.h::blackout::0::3"
        defb 0, 127
	C_LINE	809,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	810,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	811,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	812,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	813,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	814,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	815,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	816,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	817,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	818,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	819,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	820,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	821,"./assets/sprites.h::blackout::0::3"
	C_LINE	822,"./assets/sprites.h::blackout::0::3"
    ._sprite_10_c
	C_LINE	823,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	824,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	825,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	826,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	827,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	828,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	829,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	830,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	831,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	832,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	833,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	834,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	835,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	836,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	837,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	838,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	839,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	840,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	841,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	842,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	843,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	844,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	845,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	846,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	847,"./assets/sprites.h::blackout::0::3"
	C_LINE	848,"./assets/sprites.h::blackout::0::3"
    ._sprite_11_a
	C_LINE	849,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	850,"./assets/sprites.h::blackout::0::3"
        defb 0, 248
	C_LINE	851,"./assets/sprites.h::blackout::0::3"
        defb 3, 248
	C_LINE	852,"./assets/sprites.h::blackout::0::3"
        defb 3, 248
	C_LINE	853,"./assets/sprites.h::blackout::0::3"
        defb 1, 248
	C_LINE	854,"./assets/sprites.h::blackout::0::3"
        defb 0, 252
	C_LINE	855,"./assets/sprites.h::blackout::0::3"
        defb 0, 254
	C_LINE	856,"./assets/sprites.h::blackout::0::3"
        defb 0, 252
	C_LINE	857,"./assets/sprites.h::blackout::0::3"
        defb 1, 248
	C_LINE	858,"./assets/sprites.h::blackout::0::3"
        defb 3, 248
	C_LINE	859,"./assets/sprites.h::blackout::0::3"
        defb 3, 248
	C_LINE	860,"./assets/sprites.h::blackout::0::3"
        defb 3, 248
	C_LINE	861,"./assets/sprites.h::blackout::0::3"
        defb 1, 248
	C_LINE	862,"./assets/sprites.h::blackout::0::3"
        defb 0, 252
	C_LINE	863,"./assets/sprites.h::blackout::0::3"
        defb 0, 254
	C_LINE	864,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	865,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	866,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	867,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	868,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	869,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	870,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	871,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	872,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	873,"./assets/sprites.h::blackout::0::3"
	C_LINE	874,"./assets/sprites.h::blackout::0::3"
    ._sprite_11_b
	C_LINE	875,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	876,"./assets/sprites.h::blackout::0::3"
        defb 0, 127
	C_LINE	877,"./assets/sprites.h::blackout::0::3"
        defb 0, 63
	C_LINE	878,"./assets/sprites.h::blackout::0::3"
        defb 128, 31
	C_LINE	879,"./assets/sprites.h::blackout::0::3"
        defb 192, 15
	C_LINE	880,"./assets/sprites.h::blackout::0::3"
        defb 224, 15
	C_LINE	881,"./assets/sprites.h::blackout::0::3"
        defb 96, 15
	C_LINE	882,"./assets/sprites.h::blackout::0::3"
        defb 224, 15
	C_LINE	883,"./assets/sprites.h::blackout::0::3"
        defb 192, 15
	C_LINE	884,"./assets/sprites.h::blackout::0::3"
        defb 128, 31
	C_LINE	885,"./assets/sprites.h::blackout::0::3"
        defb 0, 63
	C_LINE	886,"./assets/sprites.h::blackout::0::3"
        defb 128, 31
	C_LINE	887,"./assets/sprites.h::blackout::0::3"
        defb 192, 31
	C_LINE	888,"./assets/sprites.h::blackout::0::3"
        defb 192, 31
	C_LINE	889,"./assets/sprites.h::blackout::0::3"
        defb 0, 31
	C_LINE	890,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	891,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	892,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	893,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	894,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	895,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	896,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	897,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	898,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	899,"./assets/sprites.h::blackout::0::3"
	C_LINE	900,"./assets/sprites.h::blackout::0::3"
    ._sprite_11_c
	C_LINE	901,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	902,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	903,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	904,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	905,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	906,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	907,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	908,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	909,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	910,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	911,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	912,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	913,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	914,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	915,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	916,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	917,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	918,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	919,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	920,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	921,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	922,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	923,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	924,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	925,"./assets/sprites.h::blackout::0::3"
	C_LINE	926,"./assets/sprites.h::blackout::0::3"
    ._sprite_12_a
	C_LINE	927,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	928,"./assets/sprites.h::blackout::0::3"
        defb 0, 254
	C_LINE	929,"./assets/sprites.h::blackout::0::3"
        defb 0, 252
	C_LINE	930,"./assets/sprites.h::blackout::0::3"
        defb 1, 248
	C_LINE	931,"./assets/sprites.h::blackout::0::3"
        defb 3, 240
	C_LINE	932,"./assets/sprites.h::blackout::0::3"
        defb 3, 240
	C_LINE	933,"./assets/sprites.h::blackout::0::3"
        defb 3, 240
	C_LINE	934,"./assets/sprites.h::blackout::0::3"
        defb 1, 240
	C_LINE	935,"./assets/sprites.h::blackout::0::3"
        defb 0, 240
	C_LINE	936,"./assets/sprites.h::blackout::0::3"
        defb 0, 248
	C_LINE	937,"./assets/sprites.h::blackout::0::3"
        defb 0, 252
	C_LINE	938,"./assets/sprites.h::blackout::0::3"
        defb 1, 248
	C_LINE	939,"./assets/sprites.h::blackout::0::3"
        defb 3, 248
	C_LINE	940,"./assets/sprites.h::blackout::0::3"
        defb 3, 248
	C_LINE	941,"./assets/sprites.h::blackout::0::3"
        defb 0, 248
	C_LINE	942,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	943,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	944,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	945,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	946,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	947,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	948,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	949,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	950,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	951,"./assets/sprites.h::blackout::0::3"
	C_LINE	952,"./assets/sprites.h::blackout::0::3"
    ._sprite_12_b
	C_LINE	953,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	954,"./assets/sprites.h::blackout::0::3"
        defb 0, 31
	C_LINE	955,"./assets/sprites.h::blackout::0::3"
        defb 192, 31
	C_LINE	956,"./assets/sprites.h::blackout::0::3"
        defb 192, 31
	C_LINE	957,"./assets/sprites.h::blackout::0::3"
        defb 128, 31
	C_LINE	958,"./assets/sprites.h::blackout::0::3"
        defb 0, 63
	C_LINE	959,"./assets/sprites.h::blackout::0::3"
        defb 128, 127
	C_LINE	960,"./assets/sprites.h::blackout::0::3"
        defb 192, 63
	C_LINE	961,"./assets/sprites.h::blackout::0::3"
        defb 224, 31
	C_LINE	962,"./assets/sprites.h::blackout::0::3"
        defb 96, 31
	C_LINE	963,"./assets/sprites.h::blackout::0::3"
        defb 224, 31
	C_LINE	964,"./assets/sprites.h::blackout::0::3"
        defb 192, 31
	C_LINE	965,"./assets/sprites.h::blackout::0::3"
        defb 128, 31
	C_LINE	966,"./assets/sprites.h::blackout::0::3"
        defb 0, 63
	C_LINE	967,"./assets/sprites.h::blackout::0::3"
        defb 0, 127
	C_LINE	968,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	969,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	970,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	971,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	972,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	973,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	974,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	975,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	976,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	977,"./assets/sprites.h::blackout::0::3"
	C_LINE	978,"./assets/sprites.h::blackout::0::3"
    ._sprite_12_c
	C_LINE	979,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	980,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	981,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	982,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	983,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	984,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	985,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	986,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	987,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	988,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	989,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	990,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	991,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	992,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	993,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	994,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	995,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	996,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	997,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	998,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	999,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1000,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1001,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1002,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1003,"./assets/sprites.h::blackout::0::3"
	C_LINE	1004,"./assets/sprites.h::blackout::0::3"
    ._sprite_13_a
	C_LINE	1005,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1006,"./assets/sprites.h::blackout::0::3"
        defb 0, 248
	C_LINE	1007,"./assets/sprites.h::blackout::0::3"
        defb 3, 240
	C_LINE	1008,"./assets/sprites.h::blackout::0::3"
        defb 5, 240
	C_LINE	1009,"./assets/sprites.h::blackout::0::3"
        defb 7, 192
	C_LINE	1010,"./assets/sprites.h::blackout::0::3"
        defb 20, 128
	C_LINE	1011,"./assets/sprites.h::blackout::0::3"
        defb 49, 128
	C_LINE	1012,"./assets/sprites.h::blackout::0::3"
        defb 34, 128
	C_LINE	1013,"./assets/sprites.h::blackout::0::3"
        defb 53, 128
	C_LINE	1014,"./assets/sprites.h::blackout::0::3"
        defb 48, 128
	C_LINE	1015,"./assets/sprites.h::blackout::0::3"
        defb 7, 128
	C_LINE	1016,"./assets/sprites.h::blackout::0::3"
        defb 3, 240
	C_LINE	1017,"./assets/sprites.h::blackout::0::3"
        defb 0, 248
	C_LINE	1018,"./assets/sprites.h::blackout::0::3"
        defb 3, 248
	C_LINE	1019,"./assets/sprites.h::blackout::0::3"
        defb 0, 248
	C_LINE	1020,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1021,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1022,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1023,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1024,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1025,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1026,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1027,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1028,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1029,"./assets/sprites.h::blackout::0::3"
	C_LINE	1030,"./assets/sprites.h::blackout::0::3"
    ._sprite_13_b
	C_LINE	1031,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1032,"./assets/sprites.h::blackout::0::3"
        defb 0, 31
	C_LINE	1033,"./assets/sprites.h::blackout::0::3"
        defb 192, 15
	C_LINE	1034,"./assets/sprites.h::blackout::0::3"
        defb 224, 3
	C_LINE	1035,"./assets/sprites.h::blackout::0::3"
        defb 232, 1
	C_LINE	1036,"./assets/sprites.h::blackout::0::3"
        defb 44, 1
	C_LINE	1037,"./assets/sprites.h::blackout::0::3"
        defb 68, 1
	C_LINE	1038,"./assets/sprites.h::blackout::0::3"
        defb 172, 1
	C_LINE	1039,"./assets/sprites.h::blackout::0::3"
        defb 76, 1
	C_LINE	1040,"./assets/sprites.h::blackout::0::3"
        defb 0, 1
	C_LINE	1041,"./assets/sprites.h::blackout::0::3"
        defb 96, 15
	C_LINE	1042,"./assets/sprites.h::blackout::0::3"
        defb 0, 15
	C_LINE	1043,"./assets/sprites.h::blackout::0::3"
        defb 0, 127
	C_LINE	1044,"./assets/sprites.h::blackout::0::3"
        defb 0, 127
	C_LINE	1045,"./assets/sprites.h::blackout::0::3"
        defb 0, 127
	C_LINE	1046,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1047,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1048,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1049,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1050,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1051,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1052,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1053,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1054,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1055,"./assets/sprites.h::blackout::0::3"
	C_LINE	1056,"./assets/sprites.h::blackout::0::3"
    ._sprite_13_c
	C_LINE	1057,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1058,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1059,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1060,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1061,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1062,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1063,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1064,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1065,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1066,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1067,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1068,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1069,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1070,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1071,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1072,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1073,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1074,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1075,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1076,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1077,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1078,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1079,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1080,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1081,"./assets/sprites.h::blackout::0::3"
	C_LINE	1082,"./assets/sprites.h::blackout::0::3"
    ._sprite_14_a
	C_LINE	1083,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1084,"./assets/sprites.h::blackout::0::3"
        defb 0, 248
	C_LINE	1085,"./assets/sprites.h::blackout::0::3"
        defb 3, 240
	C_LINE	1086,"./assets/sprites.h::blackout::0::3"
        defb 5, 192
	C_LINE	1087,"./assets/sprites.h::blackout::0::3"
        defb 23, 128
	C_LINE	1088,"./assets/sprites.h::blackout::0::3"
        defb 52, 128
	C_LINE	1089,"./assets/sprites.h::blackout::0::3"
        defb 34, 128
	C_LINE	1090,"./assets/sprites.h::blackout::0::3"
        defb 53, 128
	C_LINE	1091,"./assets/sprites.h::blackout::0::3"
        defb 50, 128
	C_LINE	1092,"./assets/sprites.h::blackout::0::3"
        defb 0, 128
	C_LINE	1093,"./assets/sprites.h::blackout::0::3"
        defb 6, 240
	C_LINE	1094,"./assets/sprites.h::blackout::0::3"
        defb 0, 240
	C_LINE	1095,"./assets/sprites.h::blackout::0::3"
        defb 0, 254
	C_LINE	1096,"./assets/sprites.h::blackout::0::3"
        defb 0, 254
	C_LINE	1097,"./assets/sprites.h::blackout::0::3"
        defb 0, 254
	C_LINE	1098,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1099,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1100,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1101,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1102,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1103,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1104,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1105,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1106,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1107,"./assets/sprites.h::blackout::0::3"
	C_LINE	1108,"./assets/sprites.h::blackout::0::3"
    ._sprite_14_b
	C_LINE	1109,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1110,"./assets/sprites.h::blackout::0::3"
        defb 0, 31
	C_LINE	1111,"./assets/sprites.h::blackout::0::3"
        defb 192, 15
	C_LINE	1112,"./assets/sprites.h::blackout::0::3"
        defb 224, 15
	C_LINE	1113,"./assets/sprites.h::blackout::0::3"
        defb 224, 3
	C_LINE	1114,"./assets/sprites.h::blackout::0::3"
        defb 40, 1
	C_LINE	1115,"./assets/sprites.h::blackout::0::3"
        defb 140, 1
	C_LINE	1116,"./assets/sprites.h::blackout::0::3"
        defb 68, 1
	C_LINE	1117,"./assets/sprites.h::blackout::0::3"
        defb 172, 1
	C_LINE	1118,"./assets/sprites.h::blackout::0::3"
        defb 12, 1
	C_LINE	1119,"./assets/sprites.h::blackout::0::3"
        defb 224, 1
	C_LINE	1120,"./assets/sprites.h::blackout::0::3"
        defb 192, 15
	C_LINE	1121,"./assets/sprites.h::blackout::0::3"
        defb 0, 31
	C_LINE	1122,"./assets/sprites.h::blackout::0::3"
        defb 192, 31
	C_LINE	1123,"./assets/sprites.h::blackout::0::3"
        defb 0, 31
	C_LINE	1124,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1125,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1126,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1127,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1128,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1129,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1130,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1131,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1132,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1133,"./assets/sprites.h::blackout::0::3"
	C_LINE	1134,"./assets/sprites.h::blackout::0::3"
    ._sprite_14_c
	C_LINE	1135,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1136,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1137,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1138,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1139,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1140,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1141,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1142,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1143,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1144,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1145,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1146,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1147,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1148,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1149,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1150,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1151,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1152,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1153,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1154,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1155,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1156,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1157,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1158,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1159,"./assets/sprites.h::blackout::0::3"
	C_LINE	1160,"./assets/sprites.h::blackout::0::3"
    ._sprite_15_a
	C_LINE	1161,"./assets/sprites.h::blackout::0::3"
        defb 0, 240
	C_LINE	1162,"./assets/sprites.h::blackout::0::3"
        defb 7, 224
	C_LINE	1163,"./assets/sprites.h::blackout::0::3"
        defb 13, 224
	C_LINE	1164,"./assets/sprites.h::blackout::0::3"
        defb 14, 224
	C_LINE	1165,"./assets/sprites.h::blackout::0::3"
        defb 15, 224
	C_LINE	1166,"./assets/sprites.h::blackout::0::3"
        defb 0, 128
	C_LINE	1167,"./assets/sprites.h::blackout::0::3"
        defb 55, 0
	C_LINE	1168,"./assets/sprites.h::blackout::0::3"
        defb 112, 0
	C_LINE	1169,"./assets/sprites.h::blackout::0::3"
        defb 100, 0
	C_LINE	1170,"./assets/sprites.h::blackout::0::3"
        defb 83, 0
	C_LINE	1171,"./assets/sprites.h::blackout::0::3"
        defb 48, 0
	C_LINE	1172,"./assets/sprites.h::blackout::0::3"
        defb 6, 128
	C_LINE	1173,"./assets/sprites.h::blackout::0::3"
        defb 6, 240
	C_LINE	1174,"./assets/sprites.h::blackout::0::3"
        defb 0, 240
	C_LINE	1175,"./assets/sprites.h::blackout::0::3"
        defb 6, 240
	C_LINE	1176,"./assets/sprites.h::blackout::0::3"
        defb 0, 240
	C_LINE	1177,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1178,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1179,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1180,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1181,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1182,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1183,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1184,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1185,"./assets/sprites.h::blackout::0::3"
	C_LINE	1186,"./assets/sprites.h::blackout::0::3"
    ._sprite_15_b
	C_LINE	1187,"./assets/sprites.h::blackout::0::3"
        defb 0, 31
	C_LINE	1188,"./assets/sprites.h::blackout::0::3"
        defb 192, 15
	C_LINE	1189,"./assets/sprites.h::blackout::0::3"
        defb 96, 15
	C_LINE	1190,"./assets/sprites.h::blackout::0::3"
        defb 224, 15
	C_LINE	1191,"./assets/sprites.h::blackout::0::3"
        defb 224, 15
	C_LINE	1192,"./assets/sprites.h::blackout::0::3"
        defb 0, 15
	C_LINE	1193,"./assets/sprites.h::blackout::0::3"
        defb 192, 3
	C_LINE	1194,"./assets/sprites.h::blackout::0::3"
        defb 24, 1
	C_LINE	1195,"./assets/sprites.h::blackout::0::3"
        defb 92, 1
	C_LINE	1196,"./assets/sprites.h::blackout::0::3"
        defb 140, 1
	C_LINE	1197,"./assets/sprites.h::blackout::0::3"
        defb 20, 1
	C_LINE	1198,"./assets/sprites.h::blackout::0::3"
        defb 216, 1
	C_LINE	1199,"./assets/sprites.h::blackout::0::3"
        defb 0, 3
	C_LINE	1200,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1201,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1202,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1203,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1204,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1205,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1206,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1207,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1208,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1209,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1210,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1211,"./assets/sprites.h::blackout::0::3"
	C_LINE	1212,"./assets/sprites.h::blackout::0::3"
    ._sprite_15_c
	C_LINE	1213,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1214,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1215,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1216,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1217,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1218,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1219,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1220,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1221,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1222,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1223,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1224,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1225,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1226,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1227,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1228,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1229,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1230,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1231,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1232,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1233,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1234,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1235,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1236,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1237,"./assets/sprites.h::blackout::0::3"
	C_LINE	1238,"./assets/sprites.h::blackout::0::3"
    ._sprite_16_a
	C_LINE	1239,"./assets/sprites.h::blackout::0::3"
        defb 0, 248
	C_LINE	1240,"./assets/sprites.h::blackout::0::3"
        defb 3, 240
	C_LINE	1241,"./assets/sprites.h::blackout::0::3"
        defb 6, 240
	C_LINE	1242,"./assets/sprites.h::blackout::0::3"
        defb 7, 240
	C_LINE	1243,"./assets/sprites.h::blackout::0::3"
        defb 7, 240
	C_LINE	1244,"./assets/sprites.h::blackout::0::3"
        defb 0, 240
	C_LINE	1245,"./assets/sprites.h::blackout::0::3"
        defb 3, 192
	C_LINE	1246,"./assets/sprites.h::blackout::0::3"
        defb 24, 128
	C_LINE	1247,"./assets/sprites.h::blackout::0::3"
        defb 58, 128
	C_LINE	1248,"./assets/sprites.h::blackout::0::3"
        defb 49, 128
	C_LINE	1249,"./assets/sprites.h::blackout::0::3"
        defb 40, 128
	C_LINE	1250,"./assets/sprites.h::blackout::0::3"
        defb 27, 128
	C_LINE	1251,"./assets/sprites.h::blackout::0::3"
        defb 0, 192
	C_LINE	1252,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1253,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1254,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1255,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1256,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1257,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1258,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1259,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1260,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1261,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1262,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1263,"./assets/sprites.h::blackout::0::3"
	C_LINE	1264,"./assets/sprites.h::blackout::0::3"
    ._sprite_16_b
	C_LINE	1265,"./assets/sprites.h::blackout::0::3"
        defb 0, 15
	C_LINE	1266,"./assets/sprites.h::blackout::0::3"
        defb 224, 7
	C_LINE	1267,"./assets/sprites.h::blackout::0::3"
        defb 176, 7
	C_LINE	1268,"./assets/sprites.h::blackout::0::3"
        defb 112, 7
	C_LINE	1269,"./assets/sprites.h::blackout::0::3"
        defb 240, 7
	C_LINE	1270,"./assets/sprites.h::blackout::0::3"
        defb 0, 1
	C_LINE	1271,"./assets/sprites.h::blackout::0::3"
        defb 236, 0
	C_LINE	1272,"./assets/sprites.h::blackout::0::3"
        defb 14, 0
	C_LINE	1273,"./assets/sprites.h::blackout::0::3"
        defb 38, 0
	C_LINE	1274,"./assets/sprites.h::blackout::0::3"
        defb 202, 0
	C_LINE	1275,"./assets/sprites.h::blackout::0::3"
        defb 12, 0
	C_LINE	1276,"./assets/sprites.h::blackout::0::3"
        defb 96, 1
	C_LINE	1277,"./assets/sprites.h::blackout::0::3"
        defb 96, 15
	C_LINE	1278,"./assets/sprites.h::blackout::0::3"
        defb 0, 15
	C_LINE	1279,"./assets/sprites.h::blackout::0::3"
        defb 96, 15
	C_LINE	1280,"./assets/sprites.h::blackout::0::3"
        defb 0, 15
	C_LINE	1281,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1282,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1283,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1284,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1285,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1286,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1287,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1288,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1289,"./assets/sprites.h::blackout::0::3"
	C_LINE	1290,"./assets/sprites.h::blackout::0::3"
    ._sprite_16_c
	C_LINE	1291,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1292,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1293,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1294,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1295,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1296,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1297,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1298,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1299,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1300,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1301,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1302,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1303,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1304,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1305,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1306,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1307,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1308,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1309,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1310,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1311,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1312,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1313,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1314,"./assets/sprites.h::blackout::0::3"
        defb 0, 255
	C_LINE	1315,"./assets/sprites.h::blackout::0::3"
	C_LINE	1316,"./assets/sprites.h::blackout::0::3"
; 
	C_LINE	1318,"./assets/sprites.h::blackout::0::3"
;#line 119 "assets/levels.h"
	C_LINE	1319,"./assets/sprites.h::blackout::0::3"
	C_LINE	118,"assets/levels.h::blackout::0::3"
;#line 85 "mk1.c"
	C_LINE	119,"assets/levels.h::blackout::0::3"
	C_LINE	84,"mk1.c::blackout::0::3"
;	#line 1 "assets/extrasprites.h"
	C_LINE	85,"mk1.c::blackout::0::3"
	C_LINE	0,"assets/extrasprites.h::blackout::0::3"
; 
	C_LINE	1,"assets/extrasprites.h::blackout::0::3"
; 
	C_LINE	2,"assets/extrasprites.h::blackout::0::3"
; 
	C_LINE	4,"assets/extrasprites.h::blackout::0::3"
; 
	C_LINE	5,"assets/extrasprites.h::blackout::0::3"
; 
	C_LINE	6,"assets/extrasprites.h::blackout::0::3"
; 
	C_LINE	7,"assets/extrasprites.h::blackout::0::3"
; 
	C_LINE	9,"assets/extrasprites.h::blackout::0::3"
;	extern unsigned char sprite_17_a []; 
	C_LINE	12,"assets/extrasprites.h::blackout::0::3"
	C_LINE	12,"assets/extrasprites.h::blackout::0::3"
;extern unsigned char sprite_18_a []; 
	C_LINE	15,"assets/extrasprites.h::blackout::0::3"
	C_LINE	15,"assets/extrasprites.h::blackout::0::3"
;	extern unsigned char sprite_19_a [];
	C_LINE	18,"assets/extrasprites.h::blackout::0::3"
	C_LINE	18,"assets/extrasprites.h::blackout::0::3"
;	extern unsigned char sprite_19_b [];
	C_LINE	19,"assets/extrasprites.h::blackout::0::3"
	C_LINE	19,"assets/extrasprites.h::blackout::0::3"
;	#asm
	C_LINE	23,"assets/extrasprites.h::blackout::0::3"
	C_LINE	23,"assets/extrasprites.h::blackout::0::3"
	C_LINE	25,"assets/extrasprites.h::blackout::0::3"
	    ._sprite_17_a
	C_LINE	26,"assets/extrasprites.h::blackout::0::3"
	        BINARY "sprites_extra.bin"
	C_LINE	27,"assets/extrasprites.h::blackout::0::3"
;#asm
	C_LINE	30,"assets/extrasprites.h::blackout::0::3"
	C_LINE	30,"assets/extrasprites.h::blackout::0::3"
	C_LINE	32,"assets/extrasprites.h::blackout::0::3"
	._sprite_18_a
	C_LINE	33,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	34,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	35,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	36,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	37,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	38,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	39,"assets/extrasprites.h::blackout::0::3"
	C_LINE	40,"assets/extrasprites.h::blackout::0::3"
	._sprite_18_b
	C_LINE	41,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	42,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	43,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	44,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	45,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	46,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	47,"assets/extrasprites.h::blackout::0::3"
	C_LINE	48,"assets/extrasprites.h::blackout::0::3"
	._sprite_18_c
	C_LINE	49,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	50,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	51,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	52,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	53,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	54,"assets/extrasprites.h::blackout::0::3"
		defb 0, 255, 0, 255, 0, 255, 0, 255
	C_LINE	55,"assets/extrasprites.h::blackout::0::3"
;	#asm	              	
	C_LINE	58,"assets/extrasprites.h::blackout::0::3"
	C_LINE	58,"assets/extrasprites.h::blackout::0::3"
	C_LINE	60,"assets/extrasprites.h::blackout::0::3"
		._sprite_19_a
	C_LINE	61,"assets/extrasprites.h::blackout::0::3"
			BINARY "sprites_bullet.bin"
	C_LINE	62,"assets/extrasprites.h::blackout::0::3"
;#line 86 "mk1.c"
	C_LINE	64,"assets/extrasprites.h::blackout::0::3"
	C_LINE	85,"mk1.c::blackout::0::3"
;	#line 1 "my/levelset.h"
	C_LINE	86,"mk1.c::blackout::0::3"
	C_LINE	0,"my/levelset.h::blackout::0::3"
; 
	C_LINE	1,"my/levelset.h::blackout::0::3"
; 
	C_LINE	2,"my/levelset.h::blackout::0::3"
; 
	C_LINE	4,"my/levelset.h::blackout::0::3"
; 
	C_LINE	6,"my/levelset.h::blackout::0::3"
; 
	C_LINE	7,"my/levelset.h::blackout::0::3"
; 
	C_LINE	8,"my/levelset.h::blackout::0::3"
; 
	C_LINE	11,"my/levelset.h::blackout::0::3"
;	 
	C_LINE	20,"my/levelset.h::blackout::0::3"
;	typedef struct {
	C_LINE	21,"my/levelset.h::blackout::0::3"
	C_LINE	21,"my/levelset.h::blackout::0::3"
;		unsigned char map_w, map_h;
	C_LINE	22,"my/levelset.h::blackout::0::3"
;		unsigned char scr_ini, ini_x, ini_y;
	C_LINE	23,"my/levelset.h::blackout::0::3"
;		unsigned char max_objs;
	C_LINE	24,"my/levelset.h::blackout::0::3"
;		unsigned char *c_map_bolts;
	C_LINE	25,"my/levelset.h::blackout::0::3"
;		unsigned char *c_tileset;
	C_LINE	26,"my/levelset.h::blackout::0::3"
;		unsigned char *c_enems_hotspots;
	C_LINE	27,"my/levelset.h::blackout::0::3"
;		unsigned char *c_behs;
	C_LINE	28,"my/levelset.h::blackout::0::3"
;		
	C_LINE	29,"my/levelset.h::blackout::0::3"
;		
	C_LINE	32,"my/levelset.h::blackout::0::3"
;	} LEVEL;
	C_LINE	35,"my/levelset.h::blackout::0::3"
; 
	C_LINE	38,"my/levelset.h::blackout::0::3"
;extern unsigned char map_bolts_0 [0];
	C_LINE	40,"my/levelset.h::blackout::0::3"
	C_LINE	40,"my/levelset.h::blackout::0::3"
;extern unsigned char map_bolts_1 [0];
	C_LINE	41,"my/levelset.h::blackout::0::3"
	C_LINE	41,"my/levelset.h::blackout::0::3"
;extern unsigned char map_bolts_2 [0];
	C_LINE	42,"my/levelset.h::blackout::0::3"
	C_LINE	42,"my/levelset.h::blackout::0::3"
;extern unsigned char tileset_0 [0];
	C_LINE	43,"my/levelset.h::blackout::0::3"
	C_LINE	43,"my/levelset.h::blackout::0::3"
;extern unsigned char tileset_1 [0];
	C_LINE	44,"my/levelset.h::blackout::0::3"
	C_LINE	44,"my/levelset.h::blackout::0::3"
;extern unsigned char tileset_2 [0];
	C_LINE	45,"my/levelset.h::blackout::0::3"
	C_LINE	45,"my/levelset.h::blackout::0::3"
;extern unsigned char enems_hotspots_0 [0];
	C_LINE	46,"my/levelset.h::blackout::0::3"
	C_LINE	46,"my/levelset.h::blackout::0::3"
;extern unsigned char enems_hotspots_1 [0];
	C_LINE	47,"my/levelset.h::blackout::0::3"
	C_LINE	47,"my/levelset.h::blackout::0::3"
;extern unsigned char enems_hotspots_2 [0];
	C_LINE	48,"my/levelset.h::blackout::0::3"
	C_LINE	48,"my/levelset.h::blackout::0::3"
;extern unsigned char behs_0_1 [0];
	C_LINE	49,"my/levelset.h::blackout::0::3"
	C_LINE	49,"my/levelset.h::blackout::0::3"
;extern unsigned char behs_2 [0];
	C_LINE	50,"my/levelset.h::blackout::0::3"
	C_LINE	50,"my/levelset.h::blackout::0::3"
;#asm
	C_LINE	52,"my/levelset.h::blackout::0::3"
	C_LINE	52,"my/levelset.h::blackout::0::3"
	C_LINE	54,"my/levelset.h::blackout::0::3"
	._map_bolts_0
	C_LINE	55,"my/levelset.h::blackout::0::3"
		BINARY "../bin/mapa_bolts0c.bin"
	C_LINE	56,"my/levelset.h::blackout::0::3"
	._map_bolts_1
	C_LINE	57,"my/levelset.h::blackout::0::3"
		BINARY "../bin/mapa_bolts1c.bin"
	C_LINE	58,"my/levelset.h::blackout::0::3"
	._map_bolts_2
	C_LINE	59,"my/levelset.h::blackout::0::3"
		BINARY "../bin/mapa_bolts2c.bin"
	C_LINE	60,"my/levelset.h::blackout::0::3"
	._tileset_0
	C_LINE	61,"my/levelset.h::blackout::0::3"
		BINARY "../bin/tileset0c.bin"
	C_LINE	62,"my/levelset.h::blackout::0::3"
	._tileset_1
	C_LINE	63,"my/levelset.h::blackout::0::3"
		BINARY "../bin/tileset1c.bin"
	C_LINE	64,"my/levelset.h::blackout::0::3"
	._tileset_2
	C_LINE	65,"my/levelset.h::blackout::0::3"
		BINARY "../bin/tileset2c.bin"
	C_LINE	66,"my/levelset.h::blackout::0::3"
	._enems_hotspots_0
	C_LINE	67,"my/levelset.h::blackout::0::3"
		BINARY "../bin/enems_hotspots0c.bin"
	C_LINE	68,"my/levelset.h::blackout::0::3"
	._enems_hotspots_1
	C_LINE	69,"my/levelset.h::blackout::0::3"
		BINARY "../bin/enems_hotspots1c.bin"
	C_LINE	70,"my/levelset.h::blackout::0::3"
	._enems_hotspots_2
	C_LINE	71,"my/levelset.h::blackout::0::3"
		BINARY "../bin/enems_hotspots2c.bin"
	C_LINE	72,"my/levelset.h::blackout::0::3"
	._behs_0_1
	C_LINE	73,"my/levelset.h::blackout::0::3"
		BINARY "../bin/behs0_1c.bin"
	C_LINE	74,"my/levelset.h::blackout::0::3"
	._behs_2
	C_LINE	75,"my/levelset.h::blackout::0::3"
		BINARY "../bin/behs2c.bin"
	C_LINE	76,"my/levelset.h::blackout::0::3"
; 
	C_LINE	79,"my/levelset.h::blackout::0::3"
; 
	C_LINE	80,"my/levelset.h::blackout::0::3"
;LEVEL levels [] = {
	C_LINE	81,"my/levelset.h::blackout::0::3"
	C_LINE	81,"my/levelset.h::blackout::0::3"
	SECTION	data_compiler
._levels
;	{ 1, 24, 23, 12, 7, 99, map_bolts_0, tileset_0, enems_hotspots_0, behs_0_1 },
	C_LINE	82,"my/levelset.h::blackout::0::3"
	defb	1
	defb	24
	defb	23
	defb	12
	defb	7
	defb	99
	defw	_map_bolts_0 + 0
	defw	_tileset_0 + 0
	defw	_enems_hotspots_0 + 0
	defw	_behs_0_1 + 0
;	{ 1, 24, 23, 12, 7, 99, map_bolts_1, tileset_1, enems_hotspots_1, behs_0_1 },
	C_LINE	83,"my/levelset.h::blackout::0::3"
	defb	1
	defb	24
	defb	23
	defb	12
	defb	7
	defb	99
	defw	_map_bolts_1 + 0
	defw	_tileset_1 + 0
	defw	_enems_hotspots_1 + 0
	defw	_behs_0_1 + 0
;	{ 1, 24, 23, 6, 8, 99, map_bolts_2, tileset_2, enems_hotspots_2, behs_2 }
	C_LINE	84,"my/levelset.h::blackout::0::3"
	defb	1
	defb	24
	defb	23
	defb	6
	defb	8
	defb	99
	defw	_map_bolts_2 + 0
	defw	_tileset_2 + 0
	defw	_enems_hotspots_2 + 0
	defw	_behs_2 + 0
;};
	C_LINE	85,"my/levelset.h::blackout::0::3"
	SECTION	code_compiler
;#line 87 "mk1.c"
	C_LINE	86,"my/levelset.h::blackout::0::3"
	C_LINE	86,"mk1.c::blackout::0::3"
;#line 1 "my/ci/extra_vars.h"
	C_LINE	95,"mk1.c::blackout::0::3"
	C_LINE	0,"my/ci/extra_vars.h::blackout::0::3"
; 
	C_LINE	1,"my/ci/extra_vars.h::blackout::0::3"
; 
	C_LINE	2,"my/ci/extra_vars.h::blackout::0::3"
;unsigned char decos_computer [] = { 0x63, 32, 0x73, 33, 0x83, 34, 0x64, 36, 0x74, 37, 0x84, 38, 0xff };
	C_LINE	4,"my/ci/extra_vars.h::blackout::0::3"
	C_LINE	4,"my/ci/extra_vars.h::blackout::0::3"
	SECTION	data_compiler
._decos_computer
	defb	99
	defb	32
	defb	115
	defb	33
	defb	131
	defb	34
	defb	100
	defb	36
	defb	116
	defb	37
	defb	132
	defb	38
	defb	255
	SECTION	code_compiler
;unsigned char decos_bombs [] = { 0x44, 17, 0x42, 17, 0x71, 17, 0xA2, 17, 0xA4, 17, 0xff };
	C_LINE	5,"my/ci/extra_vars.h::blackout::0::3"
	C_LINE	5,"my/ci/extra_vars.h::blackout::0::3"
	SECTION	data_compiler
._decos_bombs
	defb	68
	defb	17
	defb	66
	defb	17
	defb	113
	defb	17
	defb	162
	defb	17
	defb	164
	defb	17
	defb	255
	SECTION	code_compiler
;unsigned char decos_moto [] = { 0x13, 40, 0x23, 41, 0xff };
	C_LINE	6,"my/ci/extra_vars.h::blackout::0::3"
	C_LINE	6,"my/ci/extra_vars.h::blackout::0::3"
	SECTION	data_compiler
._decos_moto
	defb	19
	defb	40
	defb	35
	defb	41
	defb	255
	SECTION	code_compiler
;unsigned char do_continue = 0;
	C_LINE	8,"my/ci/extra_vars.h::blackout::0::3"
	C_LINE	8,"my/ci/extra_vars.h::blackout::0::3"
	SECTION	data_compiler
._do_continue
	defb	0
	SECTION	code_compiler
;unsigned char current_level = 0;
	C_LINE	9,"my/ci/extra_vars.h::blackout::0::3"
	C_LINE	9,"my/ci/extra_vars.h::blackout::0::3"
	SECTION	data_compiler
._current_level
	defb	0
	SECTION	code_compiler
;#line 96 "mk1.c"
	C_LINE	10,"my/ci/extra_vars.h::blackout::0::3"
	C_LINE	95,"mk1.c::blackout::0::3"
;	#line 1 "sound/beeper.h"
	C_LINE	104,"mk1.c::blackout::0::3"
	C_LINE	0,"sound/beeper.h::blackout::0::3"
; 
	C_LINE	1,"sound/beeper.h::blackout::0::3"
; 
	C_LINE	2,"sound/beeper.h::blackout::0::3"
;#asm
	C_LINE	4,"sound/beeper.h::blackout::0::3"
	C_LINE	4,"sound/beeper.h::blackout::0::3"
	C_LINE	6,"sound/beeper.h::blackout::0::3"
	;org 60000
	C_LINE	8,"sound/beeper.h::blackout::0::3"
;BeepFX player by Shiru
	C_LINE	9,"sound/beeper.h::blackout::0::3"
;You are free to do whatever you want with this code
	C_LINE	13,"sound/beeper.h::blackout::0::3"
.playBasic
	C_LINE	14,"sound/beeper.h::blackout::0::3"
	ld a,0
	C_LINE	15,"sound/beeper.h::blackout::0::3"
.sound_play
	C_LINE	16,"sound/beeper.h::blackout::0::3"
	ld hl,sfxData	;address of sound effects data
	C_LINE	18,"sound/beeper.h::blackout::0::3"
	;di
	C_LINE	19,"sound/beeper.h::blackout::0::3"
	push ix
	C_LINE	20,"sound/beeper.h::blackout::0::3"
	push iy
	C_LINE	22,"sound/beeper.h::blackout::0::3"
	ld b,0
	C_LINE	23,"sound/beeper.h::blackout::0::3"
	ld c,a
	C_LINE	24,"sound/beeper.h::blackout::0::3"
	add hl,bc
	C_LINE	25,"sound/beeper.h::blackout::0::3"
	add hl,bc
	C_LINE	26,"sound/beeper.h::blackout::0::3"
	ld e,(hl)
	C_LINE	27,"sound/beeper.h::blackout::0::3"
	inc hl
	C_LINE	28,"sound/beeper.h::blackout::0::3"
	ld d,(hl)
	C_LINE	29,"sound/beeper.h::blackout::0::3"
	push de
	C_LINE	30,"sound/beeper.h::blackout::0::3"
	pop ix			;put it into ix
	C_LINE	32,"sound/beeper.h::blackout::0::3"
	ld a,(23624)	;get border color from BASIC vars to keep it unchanged
	C_LINE	33,"sound/beeper.h::blackout::0::3"
	rra
	C_LINE	34,"sound/beeper.h::blackout::0::3"
	rra
	C_LINE	35,"sound/beeper.h::blackout::0::3"
	rra
	C_LINE	36,"sound/beeper.h::blackout::0::3"
	and 7
	C_LINE	37,"sound/beeper.h::blackout::0::3"
	ld (sfxRoutineToneBorder  +1),a
	C_LINE	38,"sound/beeper.h::blackout::0::3"
	ld (sfxRoutineNoiseBorder +1),a
	C_LINE	39,"sound/beeper.h::blackout::0::3"
	ld (sfxRoutineSampleBorder+1),a
	C_LINE	42,"sound/beeper.h::blackout::0::3"
.readData
	C_LINE	43,"sound/beeper.h::blackout::0::3"
	ld a,(ix+0)		;read block type
	C_LINE	44,"sound/beeper.h::blackout::0::3"
	ld c,(ix+1)		;read duration 1
	C_LINE	45,"sound/beeper.h::blackout::0::3"
	ld b,(ix+2)
	C_LINE	46,"sound/beeper.h::blackout::0::3"
	ld e,(ix+3)		;read duration 2
	C_LINE	47,"sound/beeper.h::blackout::0::3"
	ld d,(ix+4)
	C_LINE	48,"sound/beeper.h::blackout::0::3"
	push de
	C_LINE	49,"sound/beeper.h::blackout::0::3"
	pop iy
	C_LINE	51,"sound/beeper.h::blackout::0::3"
	dec a
	C_LINE	52,"sound/beeper.h::blackout::0::3"
	jr z,sfxRoutineTone
	C_LINE	53,"sound/beeper.h::blackout::0::3"
	dec a
	C_LINE	54,"sound/beeper.h::blackout::0::3"
	jr z,sfxRoutineNoise
	C_LINE	55,"sound/beeper.h::blackout::0::3"
	dec a
	C_LINE	56,"sound/beeper.h::blackout::0::3"
	jr z,sfxRoutineSample
	C_LINE	57,"sound/beeper.h::blackout::0::3"
	pop iy
	C_LINE	58,"sound/beeper.h::blackout::0::3"
	pop ix
	C_LINE	59,"sound/beeper.h::blackout::0::3"
	;ei
	C_LINE	60,"sound/beeper.h::blackout::0::3"
	ret
	C_LINE	62,"sound/beeper.h::blackout::0::3"
	C_LINE	64,"sound/beeper.h::blackout::0::3"
;play sample
	C_LINE	66,"sound/beeper.h::blackout::0::3"
.sfxRoutineSample
	C_LINE	67,"sound/beeper.h::blackout::0::3"
	ex de,hl
	C_LINE	68,"sound/beeper.h::blackout::0::3"
.sfxRS0
	C_LINE	69,"sound/beeper.h::blackout::0::3"
	ld e,8
	C_LINE	70,"sound/beeper.h::blackout::0::3"
	ld d,(hl)
	C_LINE	71,"sound/beeper.h::blackout::0::3"
	inc hl
	C_LINE	72,"sound/beeper.h::blackout::0::3"
.sfxRS1
	C_LINE	73,"sound/beeper.h::blackout::0::3"
	ld a,(ix+5)
	C_LINE	74,"sound/beeper.h::blackout::0::3"
.sfxRS2
	C_LINE	75,"sound/beeper.h::blackout::0::3"
	dec a
	C_LINE	76,"sound/beeper.h::blackout::0::3"
	jr nz,sfxRS2
	C_LINE	77,"sound/beeper.h::blackout::0::3"
	rl d
	C_LINE	78,"sound/beeper.h::blackout::0::3"
	sbc a,a
	C_LINE	79,"sound/beeper.h::blackout::0::3"
	and 16
	C_LINE	80,"sound/beeper.h::blackout::0::3"
.sfxRoutineSampleBorder
	C_LINE	81,"sound/beeper.h::blackout::0::3"
	or 0
	C_LINE	82,"sound/beeper.h::blackout::0::3"
	out (254),a
	C_LINE	83,"sound/beeper.h::blackout::0::3"
	dec e
	C_LINE	84,"sound/beeper.h::blackout::0::3"
	jr nz,sfxRS1
	C_LINE	85,"sound/beeper.h::blackout::0::3"
	dec bc
	C_LINE	86,"sound/beeper.h::blackout::0::3"
	ld a,b
	C_LINE	87,"sound/beeper.h::blackout::0::3"
	or c
	C_LINE	88,"sound/beeper.h::blackout::0::3"
	jr nz,sfxRS0
	C_LINE	90,"sound/beeper.h::blackout::0::3"
	ld c,6
	C_LINE	91,"sound/beeper.h::blackout::0::3"
	C_LINE	92,"sound/beeper.h::blackout::0::3"
.nextData
	C_LINE	93,"sound/beeper.h::blackout::0::3"
	add ix,bc		;skip to the next block
	C_LINE	94,"sound/beeper.h::blackout::0::3"
	jr readData
	C_LINE	98,"sound/beeper.h::blackout::0::3"
;generate tone with many parameters
	C_LINE	100,"sound/beeper.h::blackout::0::3"
.sfxRoutineTone
	C_LINE	101,"sound/beeper.h::blackout::0::3"
	ld e,(ix+5)		;freq
	C_LINE	102,"sound/beeper.h::blackout::0::3"
	ld d,(ix+6)
	C_LINE	103,"sound/beeper.h::blackout::0::3"
	ld a,(ix+9)		;duty
	C_LINE	104,"sound/beeper.h::blackout::0::3"
	ld (sfxRoutineToneDuty+1),a
	C_LINE	105,"sound/beeper.h::blackout::0::3"
	ld hl,0
	C_LINE	107,"sound/beeper.h::blackout::0::3"
.sfxRT0
	C_LINE	108,"sound/beeper.h::blackout::0::3"
	push bc
	C_LINE	109,"sound/beeper.h::blackout::0::3"
	push iy
	C_LINE	110,"sound/beeper.h::blackout::0::3"
	pop bc
	C_LINE	111,"sound/beeper.h::blackout::0::3"
.sfxRT1
	C_LINE	112,"sound/beeper.h::blackout::0::3"
	add hl,de
	C_LINE	113,"sound/beeper.h::blackout::0::3"
	ld a,h
	C_LINE	114,"sound/beeper.h::blackout::0::3"
.sfxRoutineToneDuty
	C_LINE	115,"sound/beeper.h::blackout::0::3"
	cp 0
	C_LINE	116,"sound/beeper.h::blackout::0::3"
	sbc a,a
	C_LINE	117,"sound/beeper.h::blackout::0::3"
	and 16
	C_LINE	118,"sound/beeper.h::blackout::0::3"
.sfxRoutineToneBorder
	C_LINE	119,"sound/beeper.h::blackout::0::3"
	or 0
	C_LINE	120,"sound/beeper.h::blackout::0::3"
	out (254),a
	C_LINE	122,"sound/beeper.h::blackout::0::3"
	dec bc
	C_LINE	123,"sound/beeper.h::blackout::0::3"
	ld a,b
	C_LINE	124,"sound/beeper.h::blackout::0::3"
	or c
	C_LINE	125,"sound/beeper.h::blackout::0::3"
	jr nz,sfxRT1
	C_LINE	127,"sound/beeper.h::blackout::0::3"
	ld a,(sfxRoutineToneDuty+1)	 ;duty change
	C_LINE	128,"sound/beeper.h::blackout::0::3"
	add a,(ix+10)
	C_LINE	129,"sound/beeper.h::blackout::0::3"
	ld (sfxRoutineToneDuty+1),a
	C_LINE	131,"sound/beeper.h::blackout::0::3"
	ld c,(ix+7)		;slide
	C_LINE	132,"sound/beeper.h::blackout::0::3"
	ld b,(ix+8)
	C_LINE	133,"sound/beeper.h::blackout::0::3"
	ex de,hl
	C_LINE	134,"sound/beeper.h::blackout::0::3"
	add hl,bc
	C_LINE	135,"sound/beeper.h::blackout::0::3"
	ex de,hl
	C_LINE	137,"sound/beeper.h::blackout::0::3"
	pop bc
	C_LINE	138,"sound/beeper.h::blackout::0::3"
	dec bc
	C_LINE	139,"sound/beeper.h::blackout::0::3"
	ld a,b
	C_LINE	140,"sound/beeper.h::blackout::0::3"
	or c
	C_LINE	141,"sound/beeper.h::blackout::0::3"
	jr nz,sfxRT0
	C_LINE	143,"sound/beeper.h::blackout::0::3"
	ld c,11
	C_LINE	144,"sound/beeper.h::blackout::0::3"
	jr nextData
	C_LINE	148,"sound/beeper.h::blackout::0::3"
;generate noise with two parameters
	C_LINE	150,"sound/beeper.h::blackout::0::3"
.sfxRoutineNoise
	C_LINE	151,"sound/beeper.h::blackout::0::3"
	ld e,(ix+5)		;pitch
	C_LINE	153,"sound/beeper.h::blackout::0::3"
	ld d,1
	C_LINE	154,"sound/beeper.h::blackout::0::3"
	ld h,d
	C_LINE	155,"sound/beeper.h::blackout::0::3"
	ld l,d
	C_LINE	156,"sound/beeper.h::blackout::0::3"
.sfxRN0
	C_LINE	157,"sound/beeper.h::blackout::0::3"
	push bc
	C_LINE	158,"sound/beeper.h::blackout::0::3"
	push iy
	C_LINE	159,"sound/beeper.h::blackout::0::3"
	pop bc
	C_LINE	160,"sound/beeper.h::blackout::0::3"
.sfxRN1
	C_LINE	161,"sound/beeper.h::blackout::0::3"
	ld a,(hl)
	C_LINE	162,"sound/beeper.h::blackout::0::3"
	and 16
	C_LINE	163,"sound/beeper.h::blackout::0::3"
.sfxRoutineNoiseBorder
	C_LINE	164,"sound/beeper.h::blackout::0::3"
	or 0
	C_LINE	165,"sound/beeper.h::blackout::0::3"
	out (254),a
	C_LINE	166,"sound/beeper.h::blackout::0::3"
	dec d
	C_LINE	167,"sound/beeper.h::blackout::0::3"
	jr nz,sfxRN2
	C_LINE	168,"sound/beeper.h::blackout::0::3"
	ld d,e
	C_LINE	169,"sound/beeper.h::blackout::0::3"
	inc hl
	C_LINE	170,"sound/beeper.h::blackout::0::3"
	ld a,h
	C_LINE	171,"sound/beeper.h::blackout::0::3"
	and 31
	C_LINE	172,"sound/beeper.h::blackout::0::3"
	ld h,a
	C_LINE	173,"sound/beeper.h::blackout::0::3"
.sfxRN2
	C_LINE	174,"sound/beeper.h::blackout::0::3"
	dec bc
	C_LINE	175,"sound/beeper.h::blackout::0::3"
	ld a,b
	C_LINE	176,"sound/beeper.h::blackout::0::3"
	or c
	C_LINE	177,"sound/beeper.h::blackout::0::3"
	jr nz,sfxRN1
	C_LINE	179,"sound/beeper.h::blackout::0::3"
	ld a,e
	C_LINE	180,"sound/beeper.h::blackout::0::3"
	add a,(ix+6)	;slide
	C_LINE	181,"sound/beeper.h::blackout::0::3"
	ld e,a
	C_LINE	183,"sound/beeper.h::blackout::0::3"
	pop bc
	C_LINE	184,"sound/beeper.h::blackout::0::3"
	dec bc
	C_LINE	185,"sound/beeper.h::blackout::0::3"
	ld a,b
	C_LINE	186,"sound/beeper.h::blackout::0::3"
	or c
	C_LINE	187,"sound/beeper.h::blackout::0::3"
	jr nz,sfxRN0
	C_LINE	189,"sound/beeper.h::blackout::0::3"
	ld c,7
	C_LINE	190,"sound/beeper.h::blackout::0::3"
	jr nextData
	C_LINE	193,"sound/beeper.h::blackout::0::3"
.sfxData
	C_LINE	195,"sound/beeper.h::blackout::0::3"
.SoundEffectsData
	C_LINE	196,"sound/beeper.h::blackout::0::3"
	defw SoundEffect0Data
	C_LINE	197,"sound/beeper.h::blackout::0::3"
	defw SoundEffect1Data
	C_LINE	198,"sound/beeper.h::blackout::0::3"
	defw SoundEffect2Data
	C_LINE	199,"sound/beeper.h::blackout::0::3"
	defw SoundEffect3Data
	C_LINE	200,"sound/beeper.h::blackout::0::3"
	defw SoundEffect4Data
	C_LINE	201,"sound/beeper.h::blackout::0::3"
	defw SoundEffect5Data
	C_LINE	202,"sound/beeper.h::blackout::0::3"
	defw SoundEffect6Data
	C_LINE	203,"sound/beeper.h::blackout::0::3"
	defw SoundEffect7Data
	C_LINE	204,"sound/beeper.h::blackout::0::3"
	defw SoundEffect8Data
	C_LINE	205,"sound/beeper.h::blackout::0::3"
	defw SoundEffect9Data
	C_LINE	207,"sound/beeper.h::blackout::0::3"
.SoundEffect0Data
	C_LINE	208,"sound/beeper.h::blackout::0::3"
	defb 2 ;noise
	C_LINE	209,"sound/beeper.h::blackout::0::3"
	defw 8,200,20
	C_LINE	210,"sound/beeper.h::blackout::0::3"
	defb 2 ;noise
	C_LINE	211,"sound/beeper.h::blackout::0::3"
	defw 4,2000,5220
	C_LINE	212,"sound/beeper.h::blackout::0::3"
	defb 0
	C_LINE	213,"sound/beeper.h::blackout::0::3"
.SoundEffect1Data
	C_LINE	214,"sound/beeper.h::blackout::0::3"
	defb 2 ;noise
	C_LINE	215,"sound/beeper.h::blackout::0::3"
	defw 1,1000,10
	C_LINE	216,"sound/beeper.h::blackout::0::3"
	defb 2 ;noise
	C_LINE	217,"sound/beeper.h::blackout::0::3"
	defw 1,1000,1
	C_LINE	218,"sound/beeper.h::blackout::0::3"
	defb 0
	C_LINE	219,"sound/beeper.h::blackout::0::3"
.SoundEffect2Data
	C_LINE	220,"sound/beeper.h::blackout::0::3"
	defb 1 ;tone
	C_LINE	221,"sound/beeper.h::blackout::0::3"
	defw 50,100,200,65531,128
	C_LINE	222,"sound/beeper.h::blackout::0::3"
	defb 0
	C_LINE	223,"sound/beeper.h::blackout::0::3"
.SoundEffect3Data
	C_LINE	224,"sound/beeper.h::blackout::0::3"
	defb 1 ;tone
	C_LINE	225,"sound/beeper.h::blackout::0::3"
	defw 100,20,500,2,128
	C_LINE	226,"sound/beeper.h::blackout::0::3"
	defb 0
	C_LINE	227,"sound/beeper.h::blackout::0::3"
.SoundEffect4Data
	C_LINE	228,"sound/beeper.h::blackout::0::3"
	defb 2 ;noise
	C_LINE	229,"sound/beeper.h::blackout::0::3"
	defw 1,1000,20
	C_LINE	230,"sound/beeper.h::blackout::0::3"
	defb 1 ;pause
	C_LINE	231,"sound/beeper.h::blackout::0::3"
	defw 1,1000,0,0,0
	C_LINE	232,"sound/beeper.h::blackout::0::3"
	defb 2 ;noise
	C_LINE	233,"sound/beeper.h::blackout::0::3"
	defw 1,1000,1
	C_LINE	234,"sound/beeper.h::blackout::0::3"
	defb 0
	C_LINE	235,"sound/beeper.h::blackout::0::3"
.SoundEffect5Data
	C_LINE	236,"sound/beeper.h::blackout::0::3"
	defb 1 ;tone
	C_LINE	237,"sound/beeper.h::blackout::0::3"
	defw 50,200,500,65516,128
	C_LINE	238,"sound/beeper.h::blackout::0::3"
	defb 0
	C_LINE	239,"sound/beeper.h::blackout::0::3"
.SoundEffect6Data
	C_LINE	240,"sound/beeper.h::blackout::0::3"
	defb 2 ;noise
	C_LINE	241,"sound/beeper.h::blackout::0::3"
	defw 20,50,257
	C_LINE	242,"sound/beeper.h::blackout::0::3"
	defb 0
	C_LINE	243,"sound/beeper.h::blackout::0::3"
.SoundEffect7Data
	C_LINE	244,"sound/beeper.h::blackout::0::3"
	defb 1 ;tone
	C_LINE	245,"sound/beeper.h::blackout::0::3"
	defw 1,1000,2000,0,64
	C_LINE	246,"sound/beeper.h::blackout::0::3"
	defb 1 ;pause
	C_LINE	247,"sound/beeper.h::blackout::0::3"
	defw 1,1000,0,0,0
	C_LINE	248,"sound/beeper.h::blackout::0::3"
	defb 1 ;tone
	C_LINE	249,"sound/beeper.h::blackout::0::3"
	defw 1,1000,1500,0,64
	C_LINE	250,"sound/beeper.h::blackout::0::3"
	defb 0
	C_LINE	251,"sound/beeper.h::blackout::0::3"
.SoundEffect8Data
	C_LINE	252,"sound/beeper.h::blackout::0::3"
	defb 2 ;noise
	C_LINE	253,"sound/beeper.h::blackout::0::3"
	defw 2,2000,32776
	C_LINE	254,"sound/beeper.h::blackout::0::3"
	defb 0
	C_LINE	255,"sound/beeper.h::blackout::0::3"
.SoundEffect9Data
	C_LINE	256,"sound/beeper.h::blackout::0::3"
	defb 1 ;tone
	C_LINE	257,"sound/beeper.h::blackout::0::3"
	defw 4,1000,1000,400,128
	C_LINE	258,"sound/beeper.h::blackout::0::3"
	defb 0
	C_LINE	259,"sound/beeper.h::blackout::0::3"
;void beep_fx (unsigned char n) {
	C_LINE	262,"sound/beeper.h::blackout::0::3"
	C_LINE	262,"sound/beeper.h::blackout::0::3"

; Function beep_fx flags 0x00000200 __smallc 
; void beep_fx(unsigned char n)
; parameter 'unsigned char n' at sp+2 size(1)
	C_LINE	262,"sound/beeper.h::beep_fx::0::3"
._beep_fx
	C_LINE	262,"sound/beeper.h::beep_fx::0::3"
;	 
	C_LINE	263,"sound/beeper.h::beep_fx::1::4"
;	asm_int = n;
	C_LINE	264,"sound/beeper.h::beep_fx::1::4"
	C_LINE	264,"sound/beeper.h::beep_fx::1::4"
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	(_asm_int),hl
;	#asm
	C_LINE	265,"sound/beeper.h::beep_fx::1::4"
	C_LINE	265,"sound/beeper.h::beep_fx::1::4"
	C_LINE	267,"sound/beeper.h::beep_fx::1::4"
		push ix
	C_LINE	268,"sound/beeper.h::beep_fx::1::4"
		push iy
	C_LINE	269,"sound/beeper.h::beep_fx::1::4"
		ld a, (_asm_int)
	C_LINE	270,"sound/beeper.h::beep_fx::1::4"
		call sound_play
	C_LINE	271,"sound/beeper.h::beep_fx::1::4"
		pop ix
	C_LINE	272,"sound/beeper.h::beep_fx::1::4"
		pop iy
	C_LINE	273,"sound/beeper.h::beep_fx::1::4"
;}
	C_LINE	275,"sound/beeper.h::beep_fx::1::4"
	ret


;#line 105 "mk1.c"
	C_LINE	276,"sound/beeper.h::beep_fx::0::4"
	C_LINE	104,"mk1.c::beep_fx::0::4"
;	
	C_LINE	105,"mk1.c::beep_fx::0::4"
;#line 1 "printer.h"
	C_LINE	110,"mk1.c::beep_fx::0::4"
	C_LINE	0,"printer.h::beep_fx::0::4"
; 
	C_LINE	1,"printer.h::beep_fx::0::4"
; 
	C_LINE	2,"printer.h::beep_fx::0::4"
; 
	C_LINE	4,"printer.h::beep_fx::0::4"
;unsigned char attr (unsigned char x, unsigned char y) {
	C_LINE	6,"printer.h::beep_fx::0::4"
	C_LINE	6,"printer.h::beep_fx::0::4"

; Function attr flags 0x00000200 __smallc 
; unsigned char attr(unsigned char x, unsigned char y)
; parameter 'unsigned char y' at sp+2 size(1)
; parameter 'unsigned char x' at sp+4 size(1)
	C_LINE	6,"printer.h::attr::0::4"
._attr
	C_LINE	6,"printer.h::attr::0::4"
;	if (x >= 15 || y >= 10) return 0;
	C_LINE	7,"printer.h::attr::1::5"
	C_LINE	7,"printer.h::attr::1::5"
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,l
	sub	15
	ccf
	jp	c,i_20	;
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,l
	sub	10
	ccf
	jp	nc,i_19	;
.i_20
	ld	hl,0	;const
	ret


;	return map_attr [x + (y << 4) - y];
	C_LINE	8,"printer.h::attr::1::5"
.i_19
	C_LINE	8,"printer.h::attr::1::5"
	ld	hl,_map_attr
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ret


;}
	C_LINE	9,"printer.h::attr::1::5"
;unsigned char qtile (unsigned char x, unsigned char y) {
	C_LINE	11,"printer.h::attr::0::5"
	C_LINE	11,"printer.h::attr::0::5"

; Function qtile flags 0x00000200 __smallc 
; unsigned char qtile(unsigned char x, unsigned char y)
; parameter 'unsigned char y' at sp+2 size(1)
; parameter 'unsigned char x' at sp+4 size(1)
	C_LINE	11,"printer.h::qtile::0::5"
._qtile
	C_LINE	11,"printer.h::qtile::0::5"
;	return map_buff [x + (y << 4) - y];
	C_LINE	12,"printer.h::qtile::1::6"
	C_LINE	12,"printer.h::qtile::1::6"
	ld	hl,_map_buff
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ret


;}
	C_LINE	13,"printer.h::qtile::1::6"
; 
	C_LINE	17,"printer.h::qtile::0::6"
; 
	C_LINE	18,"printer.h::qtile::0::6"
; 
	C_LINE	19,"printer.h::qtile::0::6"
;	
	C_LINE	56,"printer.h::qtile::0::6"
;	
	C_LINE	58,"printer.h::qtile::0::6"
;void draw_coloured_tile (void) {
	C_LINE	63,"printer.h::qtile::0::6"
	C_LINE	63,"printer.h::qtile::0::6"

; Function draw_coloured_tile flags 0x00000200 __smallc 
; void draw_coloured_tile()
	C_LINE	63,"printer.h::draw_coloured_tile::0::6"
._draw_coloured_tile
	C_LINE	63,"printer.h::draw_coloured_tile::0::6"
;	
	C_LINE	64,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	66,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	78,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	81,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	96,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	103,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	124,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	126,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	131,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	139,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	155,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	157,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	161,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	169,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	185,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	187,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	192,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	196,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	212,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	231,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	242,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	251,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	267,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	278,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	289,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	298,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	314,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	326,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	337,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	346,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	364,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	374,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	376,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	383,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	385,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	387,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	388,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	391,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	392,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	396,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	398,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	399,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	402,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	403,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	406,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	408,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	409,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	412,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	413,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	417,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	419,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	420,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	423,"printer.h::draw_coloured_tile::1::7"
; 
	C_LINE	424,"printer.h::draw_coloured_tile::1::7"
;		#asm
	C_LINE	427,"printer.h::draw_coloured_tile::1::7"
	C_LINE	427,"printer.h::draw_coloured_tile::1::7"
	C_LINE	429,"printer.h::draw_coloured_tile::1::7"
	C_LINE	436,"printer.h::draw_coloured_tile::1::7"
	C_LINE	438,"printer.h::draw_coloured_tile::1::7"
				ld  a, (__x)
	C_LINE	439,"printer.h::draw_coloured_tile::1::7"
				ld  c, a
	C_LINE	440,"printer.h::draw_coloured_tile::1::7"
				ld  a, (__y)
	C_LINE	441,"printer.h::draw_coloured_tile::1::7"
				call SPCompDListAddr
	C_LINE	442,"printer.h::draw_coloured_tile::1::7"
				ex de, hl
	C_LINE	444,"printer.h::draw_coloured_tile::1::7"
	C_LINE	446,"printer.h::draw_coloured_tile::1::7"
	C_LINE	447,"printer.h::draw_coloured_tile::1::7"
				ld  a, (__t)
	C_LINE	448,"printer.h::draw_coloured_tile::1::7"
				sla a
	C_LINE	449,"printer.h::draw_coloured_tile::1::7"
				sla a 				 
	C_LINE	450,"printer.h::draw_coloured_tile::1::7"
				add 64 				 
	C_LINE	451,"printer.h::draw_coloured_tile::1::7"
	C_LINE	452,"printer.h::draw_coloured_tile::1::7"
				ld  hl, _tileset +  1536 
	C_LINE	453,"printer.h::draw_coloured_tile::1::7"
				ld  b, 0
	C_LINE	454,"printer.h::draw_coloured_tile::1::7"
				ld  c, a
	C_LINE	455,"printer.h::draw_coloured_tile::1::7"
				add hl, bc 			 
	C_LINE	456,"printer.h::draw_coloured_tile::1::7"
	C_LINE	457,"printer.h::draw_coloured_tile::1::7"
				ld  c, a 			 
	C_LINE	459,"printer.h::draw_coloured_tile::1::7"
	C_LINE	460,"printer.h::draw_coloured_tile::1::7"
	C_LINE	461,"printer.h::draw_coloured_tile::1::7"
				ld  a, (hl) 		 
	C_LINE	462,"printer.h::draw_coloured_tile::1::7"
				ld  (de), a 		 
	C_LINE	463,"printer.h::draw_coloured_tile::1::7"
				inc de
	C_LINE	464,"printer.h::draw_coloured_tile::1::7"
				inc hl 				 
	C_LINE	466,"printer.h::draw_coloured_tile::1::7"
				ld  a, c  			 
	C_LINE	467,"printer.h::draw_coloured_tile::1::7"
				ld  (de), a			 
	C_LINE	468,"printer.h::draw_coloured_tile::1::7"
				inc de
	C_LINE	469,"printer.h::draw_coloured_tile::1::7"
				inc a 				 
	C_LINE	470,"printer.h::draw_coloured_tile::1::7"
				ld  c, a 
	C_LINE	472,"printer.h::draw_coloured_tile::1::7"
				inc de
	C_LINE	473,"printer.h::draw_coloured_tile::1::7"
				inc de 				 
	C_LINE	475,"printer.h::draw_coloured_tile::1::7"
				ld  a, (hl) 		 
	C_LINE	476,"printer.h::draw_coloured_tile::1::7"
				ld  (de), a 		 
	C_LINE	477,"printer.h::draw_coloured_tile::1::7"
				inc de
	C_LINE	478,"printer.h::draw_coloured_tile::1::7"
				inc hl 				 
	C_LINE	480,"printer.h::draw_coloured_tile::1::7"
				ld  a, c  			 
	C_LINE	481,"printer.h::draw_coloured_tile::1::7"
				ld  (de), a			 
	C_LINE	482,"printer.h::draw_coloured_tile::1::7"
				inc a 				 
	C_LINE	483,"printer.h::draw_coloured_tile::1::7"
	C_LINE	484,"printer.h::draw_coloured_tile::1::7"
				ex  de, hl
	C_LINE	485,"printer.h::draw_coloured_tile::1::7"
				ld  bc, 123
	C_LINE	486,"printer.h::draw_coloured_tile::1::7"
				add hl, bc
	C_LINE	487,"printer.h::draw_coloured_tile::1::7"
				ex  de, hl			 
	C_LINE	488,"printer.h::draw_coloured_tile::1::7"
				ld  c, a 
	C_LINE	490,"printer.h::draw_coloured_tile::1::7"
				ld  a, (hl) 		 
	C_LINE	491,"printer.h::draw_coloured_tile::1::7"
				ld  (de), a 		 
	C_LINE	492,"printer.h::draw_coloured_tile::1::7"
				inc de
	C_LINE	493,"printer.h::draw_coloured_tile::1::7"
				inc hl 				 
	C_LINE	495,"printer.h::draw_coloured_tile::1::7"
				ld  a, c  			 
	C_LINE	496,"printer.h::draw_coloured_tile::1::7"
				ld  (de), a			 
	C_LINE	497,"printer.h::draw_coloured_tile::1::7"
				inc de
	C_LINE	498,"printer.h::draw_coloured_tile::1::7"
				inc a 				 
	C_LINE	499,"printer.h::draw_coloured_tile::1::7"
				ld  c, a 
	C_LINE	501,"printer.h::draw_coloured_tile::1::7"
				inc de
	C_LINE	502,"printer.h::draw_coloured_tile::1::7"
				inc de 				 
	C_LINE	504,"printer.h::draw_coloured_tile::1::7"
				ld  a, (hl) 		 
	C_LINE	505,"printer.h::draw_coloured_tile::1::7"
				ld  (de), a 		 
	C_LINE	506,"printer.h::draw_coloured_tile::1::7"
				inc de
	C_LINE	508,"printer.h::draw_coloured_tile::1::7"
				ld  a, c  			 
	C_LINE	509,"printer.h::draw_coloured_tile::1::7"
				ld  (de), a			 
	C_LINE	510,"printer.h::draw_coloured_tile::1::7"
;	}
	C_LINE	512,"printer.h::draw_coloured_tile::1::7"
	ret


;void invalidate_tile (void) {
	C_LINE	514,"printer.h::draw_coloured_tile::0::7"
	C_LINE	514,"printer.h::draw_coloured_tile::0::7"

; Function invalidate_tile flags 0x00000200 __smallc 
; void invalidate_tile()
	C_LINE	514,"printer.h::invalidate_tile::0::7"
._invalidate_tile
	C_LINE	514,"printer.h::invalidate_tile::0::7"
;	#asm
	C_LINE	515,"printer.h::invalidate_tile::1::8"
	C_LINE	515,"printer.h::invalidate_tile::1::8"
	C_LINE	517,"printer.h::invalidate_tile::1::8"
			; Invalidate Rectangle
	C_LINE	518,"printer.h::invalidate_tile::1::8"
			;
	C_LINE	519,"printer.h::invalidate_tile::1::8"
			; enter:  B = row coord top left corner
	C_LINE	520,"printer.h::invalidate_tile::1::8"
			;         C = col coord top left corner
	C_LINE	521,"printer.h::invalidate_tile::1::8"
			;         D = row coord bottom right corner
	C_LINE	522,"printer.h::invalidate_tile::1::8"
			;         E = col coord bottom right corner
	C_LINE	523,"printer.h::invalidate_tile::1::8"
			;        IY = clipping rectangle, set it to "ClipStruct" for full screen
	C_LINE	525,"printer.h::invalidate_tile::1::8"
			ld  a, (__x)
	C_LINE	526,"printer.h::invalidate_tile::1::8"
			ld  c, a
	C_LINE	527,"printer.h::invalidate_tile::1::8"
			inc a
	C_LINE	528,"printer.h::invalidate_tile::1::8"
			ld  e, a
	C_LINE	529,"printer.h::invalidate_tile::1::8"
			ld  a, (__y)
	C_LINE	530,"printer.h::invalidate_tile::1::8"
			ld  b, a
	C_LINE	531,"printer.h::invalidate_tile::1::8"
			inc a
	C_LINE	532,"printer.h::invalidate_tile::1::8"
			ld  d, a
	C_LINE	533,"printer.h::invalidate_tile::1::8"
			ld  iy, fsClipStruct
	C_LINE	534,"printer.h::invalidate_tile::1::8"
			call SPInvalidate			
	C_LINE	535,"printer.h::invalidate_tile::1::8"
;}
	C_LINE	537,"printer.h::invalidate_tile::1::8"
	ret


;void invalidate_viewport (void) {
	C_LINE	539,"printer.h::invalidate_tile::0::8"
	C_LINE	539,"printer.h::invalidate_tile::0::8"

; Function invalidate_viewport flags 0x00000200 __smallc 
; void invalidate_viewport()
	C_LINE	539,"printer.h::invalidate_viewport::0::8"
._invalidate_viewport
	C_LINE	539,"printer.h::invalidate_viewport::0::8"
;	#asm
	C_LINE	540,"printer.h::invalidate_viewport::1::9"
	C_LINE	540,"printer.h::invalidate_viewport::1::9"
	C_LINE	542,"printer.h::invalidate_viewport::1::9"
			; Invalidate Rectangle
	C_LINE	543,"printer.h::invalidate_viewport::1::9"
			;
	C_LINE	544,"printer.h::invalidate_viewport::1::9"
			; enter:  B = row coord top left corner
	C_LINE	545,"printer.h::invalidate_viewport::1::9"
			;         C = col coord top left corner
	C_LINE	546,"printer.h::invalidate_viewport::1::9"
			;         D = row coord bottom right corner
	C_LINE	547,"printer.h::invalidate_viewport::1::9"
			;         E = col coord bottom right corner
	C_LINE	548,"printer.h::invalidate_viewport::1::9"
			;        IY = clipping rectangle, set it to "ClipStruct" for full screen
	C_LINE	550,"printer.h::invalidate_viewport::1::9"
			ld  b,  1 
	C_LINE	551,"printer.h::invalidate_viewport::1::9"
			ld  c,  1 
	C_LINE	552,"printer.h::invalidate_viewport::1::9"
			ld  d,  1 +19
	C_LINE	553,"printer.h::invalidate_viewport::1::9"
			ld  e,  1 +29
	C_LINE	554,"printer.h::invalidate_viewport::1::9"
			ld  iy, vpClipStruct
	C_LINE	555,"printer.h::invalidate_viewport::1::9"
			call SPInvalidate
	C_LINE	556,"printer.h::invalidate_viewport::1::9"
;}
	C_LINE	558,"printer.h::invalidate_viewport::1::9"
	ret


;void draw_invalidate_coloured_tile_gamearea (void) {
	C_LINE	560,"printer.h::invalidate_viewport::0::9"
	C_LINE	560,"printer.h::invalidate_viewport::0::9"

; Function draw_invalidate_coloured_tile_gamearea flags 0x00000200 __smallc 
; void draw_invalidate_coloured_tile_gamearea()
	C_LINE	560,"printer.h::draw_invalidate_coloured_tile_gamearea::0::9"
._draw_invalidate_coloured_tile_gamearea
	C_LINE	560,"printer.h::draw_invalidate_coloured_tile_gamearea::0::9"
;	draw_coloured_tile_gamearea ();
	C_LINE	561,"printer.h::draw_invalidate_coloured_tile_gamearea::1::10"
	C_LINE	561,"printer.h::draw_invalidate_coloured_tile_gamearea::1::10"
	call	_draw_coloured_tile_gamearea
;	invalidate_tile ();
	C_LINE	562,"printer.h::draw_invalidate_coloured_tile_gamearea::1::10"
	C_LINE	562,"printer.h::draw_invalidate_coloured_tile_gamearea::1::10"
	call	_invalidate_tile
;}
	C_LINE	563,"printer.h::draw_invalidate_coloured_tile_gamearea::1::10"
	ret


;void draw_coloured_tile_gamearea (void) {
	C_LINE	565,"printer.h::draw_invalidate_coloured_tile_gamearea::0::10"
	C_LINE	565,"printer.h::draw_invalidate_coloured_tile_gamearea::0::10"

; Function draw_coloured_tile_gamearea flags 0x00000200 __smallc 
; void draw_coloured_tile_gamearea()
	C_LINE	565,"printer.h::draw_coloured_tile_gamearea::0::10"
._draw_coloured_tile_gamearea
	C_LINE	565,"printer.h::draw_coloured_tile_gamearea::0::10"
;	_x =  1  + (_x << 1); _y =  1  + (_y << 1); draw_coloured_tile ();
	C_LINE	566,"printer.h::draw_coloured_tile_gamearea::1::11"
	C_LINE	566,"printer.h::draw_coloured_tile_gamearea::1::11"
	ld	hl,(__x)
	ld	h,0
	add	hl,hl
	inc	hl
	ld	a,l
	ld	(__x),a
	ld	hl,(__y)
	ld	h,0
	add	hl,hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_draw_coloured_tile
;}
	C_LINE	567,"printer.h::draw_coloured_tile_gamearea::1::11"
	ret


;void draw_decorations (void) {
	C_LINE	569,"printer.h::draw_coloured_tile_gamearea::0::11"
	C_LINE	569,"printer.h::draw_coloured_tile_gamearea::0::11"

; Function draw_decorations flags 0x00000200 __smallc 
; void draw_decorations()
	C_LINE	569,"printer.h::draw_decorations::0::11"
._draw_decorations
	C_LINE	569,"printer.h::draw_decorations::0::11"
;	 
	C_LINE	570,"printer.h::draw_decorations::1::12"
;	#asm
	C_LINE	571,"printer.h::draw_decorations::1::12"
	C_LINE	571,"printer.h::draw_decorations::1::12"
	C_LINE	573,"printer.h::draw_decorations::1::12"
			ld  hl, (__gp_gen)
	C_LINE	575,"printer.h::draw_decorations::1::12"
		._draw_decorations_loop
	C_LINE	576,"printer.h::draw_decorations::1::12"
			ld  a, (hl)
	C_LINE	577,"printer.h::draw_decorations::1::12"
			cp  0xff
	C_LINE	578,"printer.h::draw_decorations::1::12"
			ret z
	C_LINE	580,"printer.h::draw_decorations::1::12"
			ld  a, (hl)
	C_LINE	581,"printer.h::draw_decorations::1::12"
			inc hl
	C_LINE	582,"printer.h::draw_decorations::1::12"
			ld  c, a
	C_LINE	583,"printer.h::draw_decorations::1::12"
			and 0x0f
	C_LINE	584,"printer.h::draw_decorations::1::12"
			ld  (__y), a
	C_LINE	585,"printer.h::draw_decorations::1::12"
			ld  a, c
	C_LINE	586,"printer.h::draw_decorations::1::12"
			srl a
	C_LINE	587,"printer.h::draw_decorations::1::12"
			srl a
	C_LINE	588,"printer.h::draw_decorations::1::12"
			srl a
	C_LINE	589,"printer.h::draw_decorations::1::12"
			srl a
	C_LINE	590,"printer.h::draw_decorations::1::12"
			ld  (__x), a
	C_LINE	592,"printer.h::draw_decorations::1::12"
			ld  a, (hl)
	C_LINE	593,"printer.h::draw_decorations::1::12"
			inc hl
	C_LINE	594,"printer.h::draw_decorations::1::12"
			ld  (__t), a
	C_LINE	596,"printer.h::draw_decorations::1::12"
			push hl
	C_LINE	598,"printer.h::draw_decorations::1::12"
			ld  b, 0
	C_LINE	599,"printer.h::draw_decorations::1::12"
			ld  c, a
	C_LINE	600,"printer.h::draw_decorations::1::12"
			ld  hl, _behs
	C_LINE	601,"printer.h::draw_decorations::1::12"
			add hl, bc
	C_LINE	602,"printer.h::draw_decorations::1::12"
			ld  a, (hl)
	C_LINE	603,"printer.h::draw_decorations::1::12"
			ld  (__n), a
	C_LINE	605,"printer.h::draw_decorations::1::12"
			call _update_tile
	C_LINE	607,"printer.h::draw_decorations::1::12"
			pop hl
	C_LINE	608,"printer.h::draw_decorations::1::12"
			jr  _draw_decorations_loop
	C_LINE	609,"printer.h::draw_decorations::1::12"
;}
	C_LINE	611,"printer.h::draw_decorations::1::12"
	ret


;unsigned char utaux = 0;
	C_LINE	613,"printer.h::draw_decorations::0::12"
	C_LINE	613,"printer.h::draw_decorations::0::12"
	SECTION	data_compiler
._utaux
	defb	0
	SECTION	code_compiler
;void update_tile (void) {
	C_LINE	614,"printer.h::draw_decorations::0::12"
	C_LINE	614,"printer.h::draw_decorations::0::12"

; Function update_tile flags 0x00000200 __smallc 
; void update_tile()
	C_LINE	614,"printer.h::update_tile::0::12"
._update_tile
	C_LINE	614,"printer.h::update_tile::0::12"
;	 
	C_LINE	615,"printer.h::update_tile::1::13"
;	 
	C_LINE	617,"printer.h::update_tile::1::13"
;	#asm
	C_LINE	623,"printer.h::update_tile::1::13"
	C_LINE	623,"printer.h::update_tile::1::13"
	C_LINE	625,"printer.h::update_tile::1::13"
		ld  a, (__x)
	C_LINE	626,"printer.h::update_tile::1::13"
		ld  c, a
	C_LINE	627,"printer.h::update_tile::1::13"
		ld  a, (__y)
	C_LINE	628,"printer.h::update_tile::1::13"
		ld  b, a
	C_LINE	629,"printer.h::update_tile::1::13"
		sla a 
	C_LINE	630,"printer.h::update_tile::1::13"
		sla a 
	C_LINE	631,"printer.h::update_tile::1::13"
		sla a 
	C_LINE	632,"printer.h::update_tile::1::13"
		sla a 
	C_LINE	633,"printer.h::update_tile::1::13"
		sub b
	C_LINE	634,"printer.h::update_tile::1::13"
		add c
	C_LINE	635,"printer.h::update_tile::1::13"
		ld  b, 0
	C_LINE	636,"printer.h::update_tile::1::13"
		ld  c, a
	C_LINE	637,"printer.h::update_tile::1::13"
		ld  hl, _map_attr
	C_LINE	638,"printer.h::update_tile::1::13"
		add hl, bc
	C_LINE	639,"printer.h::update_tile::1::13"
		ld  a, (__n)
	C_LINE	640,"printer.h::update_tile::1::13"
		ld  (hl), a
	C_LINE	641,"printer.h::update_tile::1::13"
		ld  hl, _map_buff
	C_LINE	642,"printer.h::update_tile::1::13"
		add hl, bc
	C_LINE	643,"printer.h::update_tile::1::13"
		ld  a, (__t)
	C_LINE	644,"printer.h::update_tile::1::13"
		ld  (hl), a
	C_LINE	646,"printer.h::update_tile::1::13"
		call _draw_coloured_tile_gamearea
	C_LINE	648,"printer.h::update_tile::1::13"
		ld  a, (_is_rendering)
	C_LINE	649,"printer.h::update_tile::1::13"
		or  a
	C_LINE	650,"printer.h::update_tile::1::13"
		ret nz
	C_LINE	652,"printer.h::update_tile::1::13"
		call _invalidate_tile
	C_LINE	653,"printer.h::update_tile::1::13"
;}
	C_LINE	655,"printer.h::update_tile::1::13"
	ret


;void print_number2 (void) {
	C_LINE	657,"printer.h::update_tile::0::13"
	C_LINE	657,"printer.h::update_tile::0::13"

; Function print_number2 flags 0x00000200 __smallc 
; void print_number2()
	C_LINE	657,"printer.h::print_number2::0::13"
._print_number2
	C_LINE	657,"printer.h::print_number2::0::13"
;	rda = 16 + (_t / 10); rdb = 16 + (_t % 10);
	C_LINE	658,"printer.h::print_number2::1::14"
	C_LINE	658,"printer.h::print_number2::1::14"
	ld	hl,(__t)
	ld	h,0
	ld	de,10
	ex	de,hl
	call	l_div_u
	ld	bc,16
	add	hl,bc
	ld	a,l
	ld	(_rda),a
	ld	hl,(__t)
	ld	h,0
	ld	de,10
	ex	de,hl
	call	l_div_u
	ex	de,hl
	ld	bc,16
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_rdb),a
;	#asm
	C_LINE	659,"printer.h::print_number2::1::14"
	C_LINE	659,"printer.h::print_number2::1::14"
	C_LINE	661,"printer.h::print_number2::1::14"
			; enter:  A = row position (0..23)
	C_LINE	662,"printer.h::print_number2::1::14"
			;         C = col position (0..31/63)
	C_LINE	663,"printer.h::print_number2::1::14"
			;         D = pallette #
	C_LINE	664,"printer.h::print_number2::1::14"
			;         E = graphic #
	C_LINE	666,"printer.h::print_number2::1::14"
			ld  a, (_rda)
	C_LINE	667,"printer.h::print_number2::1::14"
			ld  e, a
	C_LINE	669,"printer.h::print_number2::1::14"
			ld  d,  7 
	C_LINE	670,"printer.h::print_number2::1::14"
	C_LINE	671,"printer.h::print_number2::1::14"
			ld  a, (__x)
	C_LINE	672,"printer.h::print_number2::1::14"
			ld  c, a
	C_LINE	674,"printer.h::print_number2::1::14"
			ld  a, (__y)
	C_LINE	676,"printer.h::print_number2::1::14"
			call SPPrintAtInv
	C_LINE	678,"printer.h::print_number2::1::14"
			ld  a, (_rdb)
	C_LINE	679,"printer.h::print_number2::1::14"
			ld  e, a
	C_LINE	681,"printer.h::print_number2::1::14"
			ld  d,  7 
	C_LINE	682,"printer.h::print_number2::1::14"
	C_LINE	683,"printer.h::print_number2::1::14"
			ld  a, (__x)
	C_LINE	684,"printer.h::print_number2::1::14"
			inc a
	C_LINE	685,"printer.h::print_number2::1::14"
			ld  c, a
	C_LINE	687,"printer.h::print_number2::1::14"
			ld  a, (__y)
	C_LINE	689,"printer.h::print_number2::1::14"
			call SPPrintAtInv
	C_LINE	690,"printer.h::print_number2::1::14"
;}
	C_LINE	692,"printer.h::print_number2::1::14"
	ret


;	void draw_objs () {
	C_LINE	694,"printer.h::print_number2::0::14"
	C_LINE	694,"printer.h::print_number2::0::14"

; Function draw_objs flags 0x00000200 __smallc 
; void draw_objs()
	C_LINE	694,"printer.h::draw_objs::0::14"
._draw_objs
	C_LINE	694,"printer.h::draw_objs::0::14"
;		 
	C_LINE	695,"printer.h::draw_objs::1::15"
; 
	C_LINE	696,"printer.h::draw_objs::1::15"
; 
	C_LINE	703,"printer.h::draw_objs::1::15"
; 
	C_LINE	710,"printer.h::draw_objs::1::15"
; 
	C_LINE	713,"printer.h::draw_objs::1::15"
; 
	C_LINE	716,"printer.h::draw_objs::1::15"
; 
	C_LINE	720,"printer.h::draw_objs::1::15"
; 
	C_LINE	723,"printer.h::draw_objs::1::15"
; 
	C_LINE	726,"printer.h::draw_objs::1::15"
; 
	C_LINE	729,"printer.h::draw_objs::1::15"
; 
	C_LINE	732,"printer.h::draw_objs::1::15"
; 
	C_LINE	735,"printer.h::draw_objs::1::15"
; 
	C_LINE	739,"printer.h::draw_objs::1::15"
; 
	C_LINE	742,"printer.h::draw_objs::1::15"
; 
	C_LINE	745,"printer.h::draw_objs::1::15"
; 
	C_LINE	747,"printer.h::draw_objs::1::15"
;			
	C_LINE	761,"printer.h::draw_objs::1::15"
;				_x =  27 ; _y =  23 ; 
	C_LINE	762,"printer.h::draw_objs::1::15"
	C_LINE	762,"printer.h::draw_objs::1::15"
	ld	a,27
	ld	(__x),a
	ld	hl,23	;const
	ld	a,l
	ld	(__y),a
;				
	C_LINE	763,"printer.h::draw_objs::1::15"
;					_t = p_objs; 
	C_LINE	766,"printer.h::draw_objs::1::15"
	C_LINE	766,"printer.h::draw_objs::1::15"
	ld	hl,(_p_objs)
	ld	h,0
	ld	a,l
	ld	(__t),a
;				
	C_LINE	767,"printer.h::draw_objs::1::15"
;				print_number2 ();
	C_LINE	768,"printer.h::draw_objs::1::15"
	C_LINE	768,"printer.h::draw_objs::1::15"
	call	_print_number2
;			
	C_LINE	769,"printer.h::draw_objs::1::15"
;		
	C_LINE	770,"printer.h::draw_objs::1::15"
;	}
	C_LINE	771,"printer.h::draw_objs::1::15"
	ret


;void print_str (void) {
	C_LINE	774,"printer.h::draw_objs::0::15"
	C_LINE	774,"printer.h::draw_objs::0::15"

; Function print_str flags 0x00000200 __smallc 
; void print_str()
	C_LINE	774,"printer.h::print_str::0::15"
._print_str
	C_LINE	774,"printer.h::print_str::0::15"
;	#asm
	C_LINE	775,"printer.h::print_str::1::16"
	C_LINE	775,"printer.h::print_str::1::16"
	C_LINE	777,"printer.h::print_str::1::16"
		ld  hl, (__gp_gen)
	C_LINE	778,"printer.h::print_str::1::16"
		.print_str_loop
	C_LINE	779,"printer.h::print_str::1::16"
			ld  a, (hl)
	C_LINE	780,"printer.h::print_str::1::16"
			or  a
	C_LINE	781,"printer.h::print_str::1::16"
			ret z 
	C_LINE	783,"printer.h::print_str::1::16"
			inc hl
	C_LINE	784,"printer.h::print_str::1::16"
	C_LINE	785,"printer.h::print_str::1::16"
			sub 32
	C_LINE	786,"printer.h::print_str::1::16"
			ld  e, a
	C_LINE	788,"printer.h::print_str::1::16"
			ld  a, (__t)
	C_LINE	789,"printer.h::print_str::1::16"
			ld  d, a
	C_LINE	791,"printer.h::print_str::1::16"
			ld  a, (__x)
	C_LINE	792,"printer.h::print_str::1::16"
			ld  c, a
	C_LINE	793,"printer.h::print_str::1::16"
			cp  31
	C_LINE	794,"printer.h::print_str::1::16"
			jr  z, print_str_no_inc_a
	C_LINE	795,"printer.h::print_str::1::16"
			inc a
	C_LINE	796,"printer.h::print_str::1::16"
		.print_str_no_inc_a			
	C_LINE	797,"printer.h::print_str::1::16"
			ld  (__x), a
	C_LINE	798,"printer.h::print_str::1::16"
	C_LINE	799,"printer.h::print_str::1::16"
			ld  a, (__y)
	C_LINE	801,"printer.h::print_str::1::16"
			push hl
	C_LINE	802,"printer.h::print_str::1::16"
			call SPPrintAtInv
	C_LINE	803,"printer.h::print_str::1::16"
			pop  hl
	C_LINE	804,"printer.h::print_str::1::16"
	C_LINE	805,"printer.h::print_str::1::16"
			jr  print_str_loop
	C_LINE	806,"printer.h::print_str::1::16"
;}
	C_LINE	808,"printer.h::print_str::1::16"
	ret


;	void blackout_area (void) {
	C_LINE	810,"printer.h::print_str::0::16"
	C_LINE	810,"printer.h::print_str::0::16"

; Function blackout_area flags 0x00000200 __smallc 
; void blackout_area()
	C_LINE	810,"printer.h::blackout_area::0::16"
._blackout_area
	C_LINE	810,"printer.h::blackout_area::0::16"
;		#asm
	C_LINE	811,"printer.h::blackout_area::1::17"
	C_LINE	811,"printer.h::blackout_area::1::17"
	C_LINE	813,"printer.h::blackout_area::1::17"
			ld  de, 22528 + 32 *  1  +  1 
	C_LINE	814,"printer.h::blackout_area::1::17"
			ld  b, 20
	C_LINE	815,"printer.h::blackout_area::1::17"
		.bal1
	C_LINE	816,"printer.h::blackout_area::1::17"
			push bc
	C_LINE	817,"printer.h::blackout_area::1::17"
			ld  h, d 
	C_LINE	818,"printer.h::blackout_area::1::17"
			ld  l, e
	C_LINE	819,"printer.h::blackout_area::1::17"
			ld	(hl), 0
	C_LINE	820,"printer.h::blackout_area::1::17"
			inc de
	C_LINE	821,"printer.h::blackout_area::1::17"
			ld  bc, 29
	C_LINE	822,"printer.h::blackout_area::1::17"
			ldir
	C_LINE	823,"printer.h::blackout_area::1::17"
			inc de
	C_LINE	824,"printer.h::blackout_area::1::17"
			inc de
	C_LINE	825,"printer.h::blackout_area::1::17"
			pop bc
	C_LINE	826,"printer.h::blackout_area::1::17"
			djnz bal1
	C_LINE	827,"printer.h::blackout_area::1::17"
;	}
	C_LINE	829,"printer.h::blackout_area::1::17"
	ret


;void clear_sprites (void) {
	C_LINE	831,"printer.h::blackout_area::0::17"
	C_LINE	831,"printer.h::blackout_area::0::17"

; Function clear_sprites flags 0x00000200 __smallc 
; void clear_sprites()
	C_LINE	831,"printer.h::clear_sprites::0::17"
._clear_sprites
	C_LINE	831,"printer.h::clear_sprites::0::17"
;	#asm
	C_LINE	832,"printer.h::clear_sprites::1::18"
	C_LINE	832,"printer.h::clear_sprites::1::18"
	C_LINE	834,"printer.h::clear_sprites::1::18"
			ld  ix, (_sp_player)
	C_LINE	835,"printer.h::clear_sprites::1::18"
			ld  iy, vpClipStruct
	C_LINE	836,"printer.h::clear_sprites::1::18"
			ld  bc, 0
	C_LINE	837,"printer.h::clear_sprites::1::18"
			ld  hl, 0xdede
	C_LINE	838,"printer.h::clear_sprites::1::18"
			ld  de, 0
	C_LINE	839,"printer.h::clear_sprites::1::18"
			call SPMoveSprAbs
	C_LINE	840,"printer.h::clear_sprites::1::18"
	C_LINE	841,"printer.h::clear_sprites::1::18"
			xor a
	C_LINE	842,"printer.h::clear_sprites::1::18"
		.hide_sprites_enems_loop
	C_LINE	843,"printer.h::clear_sprites::1::18"
			ld  (_gpit), a
	C_LINE	845,"printer.h::clear_sprites::1::18"
			sla a
	C_LINE	846,"printer.h::clear_sprites::1::18"
			ld  c, a
	C_LINE	847,"printer.h::clear_sprites::1::18"
			ld  b, 0
	C_LINE	848,"printer.h::clear_sprites::1::18"
			ld  hl, _sp_moviles
	C_LINE	849,"printer.h::clear_sprites::1::18"
			add hl, bc
	C_LINE	850,"printer.h::clear_sprites::1::18"
			ld  e, (hl)
	C_LINE	851,"printer.h::clear_sprites::1::18"
			inc hl
	C_LINE	852,"printer.h::clear_sprites::1::18"
			ld  d, (hl)
	C_LINE	853,"printer.h::clear_sprites::1::18"
			push de
	C_LINE	854,"printer.h::clear_sprites::1::18"
			pop ix
	C_LINE	856,"printer.h::clear_sprites::1::18"
			ld  iy, vpClipStruct
	C_LINE	857,"printer.h::clear_sprites::1::18"
			ld  bc, 0
	C_LINE	858,"printer.h::clear_sprites::1::18"
			ld  hl, 0xfefe	 
	C_LINE	859,"printer.h::clear_sprites::1::18"
			ld  de, 0
	C_LINE	861,"printer.h::clear_sprites::1::18"
			call SPMoveSprAbs
	C_LINE	863,"printer.h::clear_sprites::1::18"
			ld  a, (_gpit)
	C_LINE	864,"printer.h::clear_sprites::1::18"
			inc a
	C_LINE	865,"printer.h::clear_sprites::1::18"
			cp  3
	C_LINE	866,"printer.h::clear_sprites::1::18"
			jr  nz, hide_sprites_enems_loop
	C_LINE	868,"printer.h::clear_sprites::1::18"
						xor a
	C_LINE	869,"printer.h::clear_sprites::1::18"
			.hide_sprites_bullets_loop
	C_LINE	870,"printer.h::clear_sprites::1::18"
				ld  (_gpit), a
	C_LINE	872,"printer.h::clear_sprites::1::18"
				sla a
	C_LINE	873,"printer.h::clear_sprites::1::18"
				ld  c, a
	C_LINE	874,"printer.h::clear_sprites::1::18"
				ld  b, 0
	C_LINE	875,"printer.h::clear_sprites::1::18"
				ld  hl, _sp_bullets
	C_LINE	876,"printer.h::clear_sprites::1::18"
				add hl, bc
	C_LINE	877,"printer.h::clear_sprites::1::18"
				ld  e, (hl)
	C_LINE	878,"printer.h::clear_sprites::1::18"
				inc hl
	C_LINE	879,"printer.h::clear_sprites::1::18"
				ld  d, (hl)
	C_LINE	880,"printer.h::clear_sprites::1::18"
				push de
	C_LINE	881,"printer.h::clear_sprites::1::18"
				pop ix
	C_LINE	883,"printer.h::clear_sprites::1::18"
				ld  iy, vpClipStruct
	C_LINE	884,"printer.h::clear_sprites::1::18"
				ld  bc, 0
	C_LINE	885,"printer.h::clear_sprites::1::18"
				ld  hl, 0xfefe	 
	C_LINE	886,"printer.h::clear_sprites::1::18"
				ld  de, 0
	C_LINE	888,"printer.h::clear_sprites::1::18"
				call SPMoveSprAbs
	C_LINE	890,"printer.h::clear_sprites::1::18"
				ld  a, (_gpit)
	C_LINE	891,"printer.h::clear_sprites::1::18"
				inc a
	C_LINE	892,"printer.h::clear_sprites::1::18"
				cp   3 
	C_LINE	893,"printer.h::clear_sprites::1::18"
				jr  nz, hide_sprites_bullets_loop
	C_LINE	894,"printer.h::clear_sprites::1::18"
;}
	C_LINE	896,"printer.h::clear_sprites::1::18"
	ret


;#line 111 "mk1.c"
	C_LINE	897,"printer.h::clear_sprites::0::18"
	C_LINE	110,"mk1.c::clear_sprites::0::18"
;#line 1 "my/ci/extra_functions.h"
	C_LINE	111,"mk1.c::clear_sprites::0::18"
	C_LINE	0,"my/ci/extra_functions.h::clear_sprites::0::18"
; 
	C_LINE	1,"my/ci/extra_functions.h::clear_sprites::0::18"
; 
	C_LINE	2,"my/ci/extra_functions.h::clear_sprites::0::18"
;#line 112 "mk1.c"
	C_LINE	3,"my/ci/extra_functions.h::clear_sprites::0::18"
	C_LINE	111,"mk1.c::clear_sprites::0::18"
;#line 1 "engine/general.h"
	C_LINE	120,"mk1.c::clear_sprites::0::18"
	C_LINE	0,"engine/general.h::clear_sprites::0::18"
; 
	C_LINE	1,"engine/general.h::clear_sprites::0::18"
; 
	C_LINE	2,"engine/general.h::clear_sprites::0::18"
; 
	C_LINE	4,"engine/general.h::clear_sprites::0::18"
;unsigned char collide (void) {
	C_LINE	6,"engine/general.h::clear_sprites::0::18"
	C_LINE	6,"engine/general.h::clear_sprites::0::18"

; Function collide flags 0x00000200 __smallc 
; unsigned char collide()
	C_LINE	6,"engine/general.h::collide::0::18"
._collide
	C_LINE	6,"engine/general.h::collide::0::18"
;	
	C_LINE	7,"engine/general.h::collide::1::19"
;		return (gpx + 13 >= cx2 && gpx <= cx2 + 13 && gpy + 12 >= cy2 && gpy <= cy2 + 12);
	C_LINE	10,"engine/general.h::collide::1::19"
	C_LINE	10,"engine/general.h::collide::1::19"
	ld	hl,(_gpx)
	ld	h,0
	ld	bc,13
	add	hl,bc
	ex	de,hl
	ld	hl,(_cx2)
	ld	h,0
	call	l_uge
	jp	nc,i_23	;
	ld	hl,(_gpx)
	ld	h,0
	push	hl
	ld	hl,(_cx2)
	ld	h,0
	ld	bc,13
	add	hl,bc
	pop	de
	and	a
	sbc	hl,de
	ccf
	jp	nc,i_23	;
	ld	hl,(_gpy)
	ld	h,0
	ld	bc,12
	add	hl,bc
	ex	de,hl
	ld	hl,(_cy2)
	ld	h,0
	call	l_uge
	jp	nc,i_23	;
	ld	hl,(_gpy)
	ld	h,0
	push	hl
	ld	hl,(_cy2)
	ld	h,0
	ld	bc,12
	add	hl,bc
	pop	de
	and	a
	sbc	hl,de
	ccf
	jp	nc,i_23	;
	ld	hl,1	;const
	ret
.i_23
	ld	hl,0	;const
	ret


;	
	C_LINE	11,"engine/general.h::collide::1::19"
;}
	C_LINE	12,"engine/general.h::collide::1::19"
;unsigned char cm_two_points (void) {
	C_LINE	14,"engine/general.h::collide::0::19"
	C_LINE	14,"engine/general.h::collide::0::19"

; Function cm_two_points flags 0x00000200 __smallc 
; unsigned char cm_two_points()
	C_LINE	14,"engine/general.h::cm_two_points::0::19"
._cm_two_points
	C_LINE	14,"engine/general.h::cm_two_points::0::19"
;	 
	C_LINE	15,"engine/general.h::cm_two_points::1::20"
;	#asm
	C_LINE	22,"engine/general.h::cm_two_points::1::20"
	C_LINE	22,"engine/general.h::cm_two_points::1::20"
	C_LINE	24,"engine/general.h::cm_two_points::1::20"
			ld  a, (_cx1)
	C_LINE	25,"engine/general.h::cm_two_points::1::20"
			cp  15
	C_LINE	26,"engine/general.h::cm_two_points::1::20"
			jr  nc, _cm_two_points_at1_reset
	C_LINE	28,"engine/general.h::cm_two_points::1::20"
			ld  a, (_cy1)
	C_LINE	29,"engine/general.h::cm_two_points::1::20"
			cp  10
	C_LINE	30,"engine/general.h::cm_two_points::1::20"
			jr  c, _cm_two_points_at1_do
	C_LINE	32,"engine/general.h::cm_two_points::1::20"
		._cm_two_points_at1_reset
	C_LINE	33,"engine/general.h::cm_two_points::1::20"
			xor a
	C_LINE	34,"engine/general.h::cm_two_points::1::20"
			jr  _cm_two_points_at1_done
	C_LINE	36,"engine/general.h::cm_two_points::1::20"
		._cm_two_points_at1_do
	C_LINE	37,"engine/general.h::cm_two_points::1::20"
			ld  a, (_cy1)
	C_LINE	38,"engine/general.h::cm_two_points::1::20"
			ld  b, a
	C_LINE	39,"engine/general.h::cm_two_points::1::20"
			sla a
	C_LINE	40,"engine/general.h::cm_two_points::1::20"
			sla a
	C_LINE	41,"engine/general.h::cm_two_points::1::20"
			sla a
	C_LINE	42,"engine/general.h::cm_two_points::1::20"
			sla a
	C_LINE	43,"engine/general.h::cm_two_points::1::20"
			sub b
	C_LINE	44,"engine/general.h::cm_two_points::1::20"
			ld  b, a
	C_LINE	45,"engine/general.h::cm_two_points::1::20"
			ld  a, (_cx1)
	C_LINE	46,"engine/general.h::cm_two_points::1::20"
			add b
	C_LINE	47,"engine/general.h::cm_two_points::1::20"
			ld  e, a
	C_LINE	48,"engine/general.h::cm_two_points::1::20"
			ld  d, 0
	C_LINE	49,"engine/general.h::cm_two_points::1::20"
			ld  hl, _map_attr
	C_LINE	50,"engine/general.h::cm_two_points::1::20"
			add hl, de
	C_LINE	51,"engine/general.h::cm_two_points::1::20"
			ld  a, (hl)
	C_LINE	53,"engine/general.h::cm_two_points::1::20"
		._cm_two_points_at1_done
	C_LINE	54,"engine/general.h::cm_two_points::1::20"
			ld (_at1), a
	C_LINE	56,"engine/general.h::cm_two_points::1::20"
			ld  a, (_cx2)
	C_LINE	57,"engine/general.h::cm_two_points::1::20"
			cp  15
	C_LINE	58,"engine/general.h::cm_two_points::1::20"
			jr  nc, _cm_two_points_at2_reset
	C_LINE	60,"engine/general.h::cm_two_points::1::20"
			ld  a, (_cy2)
	C_LINE	61,"engine/general.h::cm_two_points::1::20"
			cp  10
	C_LINE	62,"engine/general.h::cm_two_points::1::20"
			jr  c, _cm_two_points_at2_do
	C_LINE	64,"engine/general.h::cm_two_points::1::20"
		._cm_two_points_at2_reset
	C_LINE	65,"engine/general.h::cm_two_points::1::20"
			xor a
	C_LINE	66,"engine/general.h::cm_two_points::1::20"
			jr  _cm_two_points_at2_done
	C_LINE	68,"engine/general.h::cm_two_points::1::20"
		._cm_two_points_at2_do
	C_LINE	69,"engine/general.h::cm_two_points::1::20"
			ld  a, (_cy2)
	C_LINE	70,"engine/general.h::cm_two_points::1::20"
			ld  b, a
	C_LINE	71,"engine/general.h::cm_two_points::1::20"
			sla a
	C_LINE	72,"engine/general.h::cm_two_points::1::20"
			sla a
	C_LINE	73,"engine/general.h::cm_two_points::1::20"
			sla a
	C_LINE	74,"engine/general.h::cm_two_points::1::20"
			sla a
	C_LINE	75,"engine/general.h::cm_two_points::1::20"
			sub b
	C_LINE	76,"engine/general.h::cm_two_points::1::20"
			ld  b, a
	C_LINE	77,"engine/general.h::cm_two_points::1::20"
			ld  a, (_cx2)
	C_LINE	78,"engine/general.h::cm_two_points::1::20"
			add b
	C_LINE	79,"engine/general.h::cm_two_points::1::20"
			ld  e, a
	C_LINE	80,"engine/general.h::cm_two_points::1::20"
			ld  d, 0
	C_LINE	81,"engine/general.h::cm_two_points::1::20"
			ld  hl, _map_attr
	C_LINE	82,"engine/general.h::cm_two_points::1::20"
			add hl, de
	C_LINE	83,"engine/general.h::cm_two_points::1::20"
			ld  a, (hl)
	C_LINE	85,"engine/general.h::cm_two_points::1::20"
		._cm_two_points_at2_done
	C_LINE	86,"engine/general.h::cm_two_points::1::20"
			ld (_at2), a
	C_LINE	87,"engine/general.h::cm_two_points::1::20"
;}
	C_LINE	89,"engine/general.h::cm_two_points::1::20"
	ret


;unsigned char rand (void) {
	C_LINE	91,"engine/general.h::cm_two_points::0::20"
	C_LINE	91,"engine/general.h::cm_two_points::0::20"

; Function rand flags 0x00000200 __smallc 
; unsigned char rand()
	C_LINE	91,"engine/general.h::rand::0::20"
._rand
	C_LINE	91,"engine/general.h::rand::0::20"
;	#asm
	C_LINE	92,"engine/general.h::rand::1::21"
	C_LINE	92,"engine/general.h::rand::1::21"
	C_LINE	94,"engine/general.h::rand::1::21"
		.rand16
	C_LINE	95,"engine/general.h::rand::1::21"
			ld	hl, _seed
	C_LINE	96,"engine/general.h::rand::1::21"
			ld	a, (hl)
	C_LINE	97,"engine/general.h::rand::1::21"
			ld	e, a
	C_LINE	98,"engine/general.h::rand::1::21"
			inc	hl
	C_LINE	99,"engine/general.h::rand::1::21"
			ld	a, (hl)
	C_LINE	100,"engine/general.h::rand::1::21"
			ld	d, a
	C_LINE	101,"engine/general.h::rand::1::21"
	C_LINE	102,"engine/general.h::rand::1::21"
			;; Ahora DE = [SEED]
	C_LINE	103,"engine/general.h::rand::1::21"
	C_LINE	104,"engine/general.h::rand::1::21"
			ld	a,	d
	C_LINE	105,"engine/general.h::rand::1::21"
			ld	h,	e
	C_LINE	106,"engine/general.h::rand::1::21"
			ld	l,	253
	C_LINE	107,"engine/general.h::rand::1::21"
			or	a
	C_LINE	108,"engine/general.h::rand::1::21"
			sbc	hl,	de
	C_LINE	109,"engine/general.h::rand::1::21"
			sbc	a, 	0
	C_LINE	110,"engine/general.h::rand::1::21"
			sbc	hl,	de
	C_LINE	111,"engine/general.h::rand::1::21"
			ld	d, 	0
	C_LINE	112,"engine/general.h::rand::1::21"
			sbc	a, 	d
	C_LINE	113,"engine/general.h::rand::1::21"
			ld	e,	a
	C_LINE	114,"engine/general.h::rand::1::21"
			sbc	hl,	de
	C_LINE	115,"engine/general.h::rand::1::21"
			jr	nc,	nextrand
	C_LINE	116,"engine/general.h::rand::1::21"
			inc	hl
	C_LINE	117,"engine/general.h::rand::1::21"
		.nextrand
	C_LINE	118,"engine/general.h::rand::1::21"
			ld	d,	h
	C_LINE	119,"engine/general.h::rand::1::21"
			ld	e,	l
	C_LINE	120,"engine/general.h::rand::1::21"
			ld	hl, _seed
	C_LINE	121,"engine/general.h::rand::1::21"
			ld	a,	e
	C_LINE	122,"engine/general.h::rand::1::21"
			ld	(hl), a
	C_LINE	123,"engine/general.h::rand::1::21"
			inc	hl
	C_LINE	124,"engine/general.h::rand::1::21"
			ld	a,	d
	C_LINE	125,"engine/general.h::rand::1::21"
			ld	(hl), a
	C_LINE	126,"engine/general.h::rand::1::21"
	C_LINE	127,"engine/general.h::rand::1::21"
			;; Ahora [SEED] = HL
	C_LINE	128,"engine/general.h::rand::1::21"
	C_LINE	129,"engine/general.h::rand::1::21"
			ld  l, e
	C_LINE	130,"engine/general.h::rand::1::21"
			ret
	C_LINE	131,"engine/general.h::rand::1::21"
;}
	C_LINE	133,"engine/general.h::rand::1::21"
	ret


;unsigned int abs (int n) {
	C_LINE	135,"engine/general.h::rand::0::21"
	C_LINE	135,"engine/general.h::rand::0::21"

; Function abs flags 0x00000200 __smallc 
; unsigned int abs(int n)
; parameter 'int n' at sp+2 size(2)
	C_LINE	135,"engine/general.h::abs::0::21"
._abs
	C_LINE	135,"engine/general.h::abs::0::21"
;	if (n < 0)
	C_LINE	136,"engine/general.h::abs::1::22"
	C_LINE	136,"engine/general.h::abs::1::22"
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	a,h
	rla
	jp	nc,i_25	;
;		return (unsigned int) (-n);
	C_LINE	137,"engine/general.h::abs::1::22"
	C_LINE	137,"engine/general.h::abs::1::22"
	pop	bc
	pop	hl
	push	hl
	push	bc
	call	l_neg
	ret


;	else 
	C_LINE	138,"engine/general.h::abs::1::22"
.i_25
;		return (unsigned int) n;
	C_LINE	139,"engine/general.h::abs::1::22"
	C_LINE	139,"engine/general.h::abs::1::22"
	pop	bc
	pop	hl
	push	hl
	push	bc
	ret


.i_26
;}
	C_LINE	140,"engine/general.h::abs::1::22"
	ret


;void cortina (void) {
	C_LINE	158,"engine/general.h::abs::0::22"
	C_LINE	158,"engine/general.h::abs::0::22"

; Function cortina flags 0x00000200 __smallc 
; void cortina()
	C_LINE	158,"engine/general.h::cortina::0::22"
._cortina
	C_LINE	158,"engine/general.h::cortina::0::22"
;	#asm
	C_LINE	159,"engine/general.h::cortina::1::23"
	C_LINE	159,"engine/general.h::cortina::1::23"
	C_LINE	161,"engine/general.h::cortina::1::23"
		;; Antes que nada vamos a limpiar el PAPER de toda la pantalla
	C_LINE	162,"engine/general.h::cortina::1::23"
		;; para que no queden artefactos feos
	C_LINE	163,"engine/general.h::cortina::1::23"
	C_LINE	164,"engine/general.h::cortina::1::23"
		ld	de, 22528			; Apuntamos con DE a la zona de atributos
	C_LINE	165,"engine/general.h::cortina::1::23"
		ld	b,	3				; Procesamos 3 tercios
	C_LINE	166,"engine/general.h::cortina::1::23"
	.clearb1
	C_LINE	167,"engine/general.h::cortina::1::23"
		push bc
	C_LINE	168,"engine/general.h::cortina::1::23"
	C_LINE	169,"engine/general.h::cortina::1::23"
		ld	b, 0				; Procesamos los 256 atributos de cada tercio
	C_LINE	170,"engine/general.h::cortina::1::23"
	.clearb2
	C_LINE	171,"engine/general.h::cortina::1::23"
	C_LINE	172,"engine/general.h::cortina::1::23"
		ld	a, (de)				; Nos traemos un atributo
	C_LINE	173,"engine/general.h::cortina::1::23"
		and	199					; Le hacemos la máscara 11000111 y dejamos PAPER a 0
	C_LINE	174,"engine/general.h::cortina::1::23"
		ld	(de), a				; Y lo volvemos a poner
	C_LINE	175,"engine/general.h::cortina::1::23"
	C_LINE	176,"engine/general.h::cortina::1::23"
		inc de					; Siguiente atributo
	C_LINE	177,"engine/general.h::cortina::1::23"
	C_LINE	178,"engine/general.h::cortina::1::23"
		djnz clearb2
	C_LINE	179,"engine/general.h::cortina::1::23"
	C_LINE	180,"engine/general.h::cortina::1::23"
		pop bc
	C_LINE	181,"engine/general.h::cortina::1::23"
		djnz clearb1
	C_LINE	182,"engine/general.h::cortina::1::23"
	C_LINE	183,"engine/general.h::cortina::1::23"
		;; Y ahora el código original que escribí para UWOL:	
	C_LINE	184,"engine/general.h::cortina::1::23"
	C_LINE	185,"engine/general.h::cortina::1::23"
		ld	a,	8
	C_LINE	186,"engine/general.h::cortina::1::23"
	C_LINE	187,"engine/general.h::cortina::1::23"
	.repitatodo
	C_LINE	188,"engine/general.h::cortina::1::23"
		ld	c,	a			; Salvamos el contador de "repitatodo" en 'c'
	C_LINE	189,"engine/general.h::cortina::1::23"
	C_LINE	190,"engine/general.h::cortina::1::23"
		ld	hl, 16384
	C_LINE	191,"engine/general.h::cortina::1::23"
		ld	a,	12
	C_LINE	192,"engine/general.h::cortina::1::23"
	C_LINE	193,"engine/general.h::cortina::1::23"
	.bucle
	C_LINE	194,"engine/general.h::cortina::1::23"
		ld	b,	a			; Salvamos el contador de "bucle" en 'b'
	C_LINE	195,"engine/general.h::cortina::1::23"
		ld	a,	0
	C_LINE	196,"engine/general.h::cortina::1::23"
	C_LINE	197,"engine/general.h::cortina::1::23"
	.bucle1
	C_LINE	198,"engine/general.h::cortina::1::23"
		sla (hl)
	C_LINE	199,"engine/general.h::cortina::1::23"
		inc hl
	C_LINE	200,"engine/general.h::cortina::1::23"
		dec a
	C_LINE	201,"engine/general.h::cortina::1::23"
		jr	nz, bucle1
	C_LINE	202,"engine/general.h::cortina::1::23"
	C_LINE	203,"engine/general.h::cortina::1::23"
		ld	a,	0
	C_LINE	204,"engine/general.h::cortina::1::23"
	.bucle2
	C_LINE	205,"engine/general.h::cortina::1::23"
		srl (hl)
	C_LINE	206,"engine/general.h::cortina::1::23"
		inc hl
	C_LINE	207,"engine/general.h::cortina::1::23"
		dec a
	C_LINE	208,"engine/general.h::cortina::1::23"
		jr	nz, bucle2
	C_LINE	209,"engine/general.h::cortina::1::23"
	C_LINE	210,"engine/general.h::cortina::1::23"
		ld	a,	b			; Restituimos el contador de "bucle" a 'a'
	C_LINE	211,"engine/general.h::cortina::1::23"
		dec a
	C_LINE	212,"engine/general.h::cortina::1::23"
		jr	nz, bucle
	C_LINE	213,"engine/general.h::cortina::1::23"
	C_LINE	214,"engine/general.h::cortina::1::23"
		ld	a,	c			; Restituimos el contador de "repitatodo" a 'a'
	C_LINE	215,"engine/general.h::cortina::1::23"
		dec a
	C_LINE	216,"engine/general.h::cortina::1::23"
		jr	nz, repitatodo
	C_LINE	217,"engine/general.h::cortina::1::23"
;}
	C_LINE	219,"engine/general.h::cortina::1::23"
	ret


;#line 121 "mk1.c"
	C_LINE	220,"engine/general.h::cortina::0::23"
	C_LINE	120,"mk1.c::cortina::0::23"
;	#line 1 "engine/breakable.h"
	C_LINE	122,"mk1.c::cortina::0::23"
	C_LINE	0,"engine/breakable.h::cortina::0::23"
; 
	C_LINE	1,"engine/breakable.h::cortina::0::23"
; 
	C_LINE	2,"engine/breakable.h::cortina::0::23"
; 
	C_LINE	4,"engine/breakable.h::cortina::0::23"
;void break_wall (void) {
	C_LINE	6,"engine/breakable.h::cortina::0::23"
	C_LINE	6,"engine/breakable.h::cortina::0::23"

; Function break_wall flags 0x00000200 __smallc 
; void break_wall()
	C_LINE	6,"engine/breakable.h::break_wall::0::23"
._break_wall
	C_LINE	6,"engine/breakable.h::break_wall::0::23"
;	gpaux =  (( _x )+( _y <<4)-( _y )) ;
	C_LINE	7,"engine/breakable.h::break_wall::1::24"
	C_LINE	7,"engine/breakable.h::break_wall::1::24"
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,(__y)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,(__y)
	ld	h,0
	ex	de,hl
	and	a
	sbc	hl,de
	ld	h,0
	ld	a,l
	ld	(_gpaux),a
;	if (brk_buff [gpaux] <  1 ) {
	C_LINE	8,"engine/breakable.h::break_wall::1::24"
	C_LINE	8,"engine/breakable.h::break_wall::1::24"
	ld	de,_brk_buff
	ld	hl,(_gpaux)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	sub	1
	jp	nc,i_27	;
;		++ brk_buff [gpaux];
	C_LINE	9,"engine/breakable.h::break_wall::2::25"
	C_LINE	9,"engine/breakable.h::break_wall::2::25"
	ld	de,_brk_buff
	ld	hl,(_gpaux)
	ld	h,0
	add	hl,de
	inc	(hl)
	ld	l,(hl)
	ld	h,0
;		
	C_LINE	10,"engine/breakable.h::break_wall::2::25"
;			gpit = 1;
	C_LINE	13,"engine/breakable.h::break_wall::2::25"
	C_LINE	13,"engine/breakable.h::break_wall::2::25"
	ld	hl,1	;const
	ld	a,l
	ld	(_gpit),a
;		
	C_LINE	14,"engine/breakable.h::break_wall::2::25"
;		#line 1 "./my/ci/on_wall_hit.h"
	C_LINE	15,"engine/breakable.h::break_wall::2::25"
	C_LINE	0,"./my/ci/on_wall_hit.h::break_wall::2::25"
; 
	C_LINE	1,"./my/ci/on_wall_hit.h::break_wall::2::25"
; 
	C_LINE	2,"./my/ci/on_wall_hit.h::break_wall::2::25"
;#line 16 "engine/breakable.h"
	C_LINE	4,"./my/ci/on_wall_hit.h::break_wall::2::25"
	C_LINE	15,"engine/breakable.h::break_wall::2::25"
;	} else {
	C_LINE	16,"engine/breakable.h::break_wall::2::25"
	jp	i_28	;EOS
.i_27
	C_LINE	16,"engine/breakable.h::break_wall::1::25"
;		_n = _t = 0; update_tile ();
	C_LINE	17,"engine/breakable.h::break_wall::2::26"
	C_LINE	17,"engine/breakable.h::break_wall::2::26"
	ld	hl,0	;const
	ld	a,l
	ld	(__t),a
	ld	(__n),a
	call	_update_tile
;		
	C_LINE	18,"engine/breakable.h::break_wall::2::26"
;			gpit = 0;
	C_LINE	21,"engine/breakable.h::break_wall::2::26"
	C_LINE	21,"engine/breakable.h::break_wall::2::26"
	ld	hl,0	;const
	ld	a,l
	ld	(_gpit),a
;		
	C_LINE	22,"engine/breakable.h::break_wall::2::26"
;		#line 1 "./my/ci/on_wall_broken.h"
	C_LINE	23,"engine/breakable.h::break_wall::2::26"
	C_LINE	0,"./my/ci/on_wall_broken.h::break_wall::2::26"
; 
	C_LINE	1,"./my/ci/on_wall_broken.h::break_wall::2::26"
; 
	C_LINE	2,"./my/ci/on_wall_broken.h::break_wall::2::26"
;#line 24 "engine/breakable.h"
	C_LINE	4,"./my/ci/on_wall_broken.h::break_wall::2::26"
	C_LINE	23,"engine/breakable.h::break_wall::2::26"
;	}
	C_LINE	24,"engine/breakable.h::break_wall::2::26"
.i_28
;	
	C_LINE	25,"engine/breakable.h::break_wall::1::26"
;		 
	C_LINE	28,"engine/breakable.h::break_wall::1::26"
;		sp_UpdateNow ();
	C_LINE	29,"engine/breakable.h::break_wall::1::26"
	C_LINE	29,"engine/breakable.h::break_wall::1::26"
	call	sp_UpdateNow
;		beep_fx (gpit);
	C_LINE	30,"engine/breakable.h::break_wall::1::26"
	C_LINE	30,"engine/breakable.h::break_wall::1::26"
;gpit;
	C_LINE	31,"engine/breakable.h::break_wall::1::26"
	ld	hl,(_gpit)
	ld	h,0
	push	hl
	call	_beep_fx
	pop	bc
;	
	C_LINE	31,"engine/breakable.h::break_wall::1::26"
;}
	C_LINE	32,"engine/breakable.h::break_wall::1::26"
	ret


;#line 123 "mk1.c"
	C_LINE	33,"engine/breakable.h::break_wall::0::26"
	C_LINE	122,"mk1.c::break_wall::0::26"
;	#line 1 "engine/bullets.h"
	C_LINE	125,"mk1.c::break_wall::0::26"
	C_LINE	0,"engine/bullets.h::break_wall::0::26"
; 
	C_LINE	1,"engine/bullets.h::break_wall::0::26"
; 
	C_LINE	2,"engine/bullets.h::break_wall::0::26"
; 
	C_LINE	4,"engine/bullets.h::break_wall::0::26"
;void bullets_init (void) {
	C_LINE	6,"engine/bullets.h::break_wall::0::26"
	C_LINE	6,"engine/bullets.h::break_wall::0::26"

; Function bullets_init flags 0x00000200 __smallc 
; void bullets_init()
	C_LINE	6,"engine/bullets.h::bullets_init::0::26"
._bullets_init
	C_LINE	6,"engine/bullets.h::bullets_init::0::26"
;	b_it = 0; while (b_it <  3 ) { 
	C_LINE	7,"engine/bullets.h::bullets_init::1::27"
	C_LINE	7,"engine/bullets.h::bullets_init::1::27"
	xor	a
	ld	(_b_it),a
.i_29
	ld	hl,(_b_it)
	ld	h,0
	ld	a,l
	sub	3
	jp	nc,i_30	;
;		bullets_estado [b_it] = 0; ++ b_it;
	C_LINE	8,"engine/bullets.h::bullets_init::2::28"
	C_LINE	8,"engine/bullets.h::bullets_init::2::28"
	ld	de,_bullets_estado
	ld	hl,(_b_it)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	hl,_b_it
	inc	(hl)
	ld	l,(hl)
	ld	h,0
;	}	
	C_LINE	9,"engine/bullets.h::bullets_init::2::28"
	jp	i_29	;EOS
.i_30
;}
	C_LINE	10,"engine/bullets.h::bullets_init::1::28"
	ret


;void bullets_update (void) {
	C_LINE	12,"engine/bullets.h::bullets_init::0::28"
	C_LINE	12,"engine/bullets.h::bullets_init::0::28"

; Function bullets_update flags 0x00000200 __smallc 
; void bullets_update()
	C_LINE	12,"engine/bullets.h::bullets_update::0::28"
._bullets_update
	C_LINE	12,"engine/bullets.h::bullets_update::0::28"
;	 
	C_LINE	13,"engine/bullets.h::bullets_update::1::29"
;	#asm
	C_LINE	14,"engine/bullets.h::bullets_update::1::29"
	C_LINE	14,"engine/bullets.h::bullets_update::1::29"
	C_LINE	16,"engine/bullets.h::bullets_update::1::29"
		ld  de, (_b_it)
	C_LINE	17,"engine/bullets.h::bullets_update::1::29"
		ld  d, 0
	C_LINE	19,"engine/bullets.h::bullets_update::1::29"
		ld  hl, _bullets_estado
	C_LINE	20,"engine/bullets.h::bullets_update::1::29"
		add hl, de
	C_LINE	21,"engine/bullets.h::bullets_update::1::29"
		ld  a, (__b_estado)
	C_LINE	22,"engine/bullets.h::bullets_update::1::29"
		ld  (hl), a
	C_LINE	24,"engine/bullets.h::bullets_update::1::29"
		ld  hl, _bullets_x
	C_LINE	25,"engine/bullets.h::bullets_update::1::29"
		add hl, de
	C_LINE	26,"engine/bullets.h::bullets_update::1::29"
		ld  a, (__b_x)
	C_LINE	27,"engine/bullets.h::bullets_update::1::29"
		ld  (hl), a
	C_LINE	29,"engine/bullets.h::bullets_update::1::29"
		ld  hl, _bullets_y
	C_LINE	30,"engine/bullets.h::bullets_update::1::29"
		add hl, de
	C_LINE	31,"engine/bullets.h::bullets_update::1::29"
		ld  a, (__b_y)
	C_LINE	32,"engine/bullets.h::bullets_update::1::29"
		ld  (hl), a
	C_LINE	34,"engine/bullets.h::bullets_update::1::29"
		ld  hl, _bullets_mx
	C_LINE	35,"engine/bullets.h::bullets_update::1::29"
		add hl, de
	C_LINE	36,"engine/bullets.h::bullets_update::1::29"
		ld  a, (__b_mx)
	C_LINE	37,"engine/bullets.h::bullets_update::1::29"
		ld  (hl), a
	C_LINE	39,"engine/bullets.h::bullets_update::1::29"
		ld  hl, _bullets_my
	C_LINE	40,"engine/bullets.h::bullets_update::1::29"
		add hl, de
	C_LINE	41,"engine/bullets.h::bullets_update::1::29"
		ld  a, (__b_my)
	C_LINE	42,"engine/bullets.h::bullets_update::1::29"
		ld  (hl), a
	C_LINE	43,"engine/bullets.h::bullets_update::1::29"
;}
	C_LINE	45,"engine/bullets.h::bullets_update::1::29"
	ret


;	 
	C_LINE	47,"engine/bullets.h::bullets_update::0::29"
;	signed char _bxo [] = { 12, -4, 8 -  0 ,  0  };
	C_LINE	48,"engine/bullets.h::bullets_update::0::29"
	C_LINE	48,"engine/bullets.h::bullets_update::0::29"
	SECTION	data_compiler
.__bxo
	defb	12
	defb	-4
	defb	8
	defb	0
	SECTION	code_compiler
;	signed char _byo [] = {  5 ,  5 , -4, 12};
	C_LINE	49,"engine/bullets.h::bullets_update::0::29"
	C_LINE	49,"engine/bullets.h::bullets_update::0::29"
	SECTION	data_compiler
.__byo
	defb	5
	defb	5
	defb	-4
	defb	12
	SECTION	code_compiler
;	signed char _bmxo [] = {  8 , - 8 , 0, 0 };
	C_LINE	50,"engine/bullets.h::bullets_update::0::29"
	C_LINE	50,"engine/bullets.h::bullets_update::0::29"
	SECTION	data_compiler
.__bmxo
	defb	8
	defb	-8
	defb	0
	defb	0
	SECTION	code_compiler
;	signed char _bmyo [] = { 0, 0, - 8 ,  8  };
	C_LINE	51,"engine/bullets.h::bullets_update::0::29"
	C_LINE	51,"engine/bullets.h::bullets_update::0::29"
	SECTION	data_compiler
.__bmyo
	defb	0
	defb	0
	defb	-8
	defb	8
	SECTION	code_compiler
;void bullets_fire (void) {
	C_LINE	53,"engine/bullets.h::bullets_update::0::29"
	C_LINE	53,"engine/bullets.h::bullets_update::0::29"

; Function bullets_fire flags 0x00000200 __smallc 
; void bullets_fire()
	C_LINE	53,"engine/bullets.h::bullets_fire::0::29"
._bullets_fire
	C_LINE	53,"engine/bullets.h::bullets_fire::0::29"
;	
	C_LINE	54,"engine/bullets.h::bullets_fire::1::30"
;	
	C_LINE	58,"engine/bullets.h::bullets_fire::1::30"
;		if (!p_ammo) return;
	C_LINE	59,"engine/bullets.h::bullets_fire::1::30"
	C_LINE	59,"engine/bullets.h::bullets_fire::1::30"
	ld	a,(_p_ammo)
	and	a
	jp	nz,i_35	;
	ret


;	
	C_LINE	60,"engine/bullets.h::bullets_fire::1::30"
;	
	C_LINE	61,"engine/bullets.h::bullets_fire::1::30"
;	 
	C_LINE	62,"engine/bullets.h::bullets_fire::1::30"
;	for (b_it = 0; b_it <  3 ; ++ b_it) {
	C_LINE	63,"engine/bullets.h::bullets_fire::1::30"
.i_35
	C_LINE	63,"engine/bullets.h::bullets_fire::1::30"
	xor	a
	ld	(_b_it),a
	jp	i_38	;EOS
.i_36
	ld	hl,_b_it
	inc	(hl)
	ld	l,(hl)
	ld	h,0
.i_38
	ld	hl,(_b_it)
	ld	h,0
	ld	a,l
	sub	3
	jp	nc,i_37	;
;		if (bullets_estado [b_it] == 0) {
	C_LINE	64,"engine/bullets.h::bullets_fire::3::31"
	C_LINE	64,"engine/bullets.h::bullets_fire::3::31"
	ld	de,_bullets_estado
	ld	hl,(_b_it)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	nz,i_39	;
;			_b_estado = 1;
	C_LINE	65,"engine/bullets.h::bullets_fire::4::32"
	C_LINE	65,"engine/bullets.h::bullets_fire::4::32"
	ld	hl,1	;const
	ld	a,l
	ld	(__b_estado),a
;			
	C_LINE	66,"engine/bullets.h::bullets_fire::4::32"
;				 
	C_LINE	67,"engine/bullets.h::bullets_fire::4::32"
;				 
	C_LINE	95,"engine/bullets.h::bullets_fire::4::32"
;				
	C_LINE	102,"engine/bullets.h::bullets_fire::4::32"
;				#asm
	C_LINE	103,"engine/bullets.h::bullets_fire::4::32"
	C_LINE	103,"engine/bullets.h::bullets_fire::4::32"
	C_LINE	105,"engine/bullets.h::bullets_fire::4::32"
						ld  a, (_p_facing)
	C_LINE	106,"engine/bullets.h::bullets_fire::4::32"
						srl a
	C_LINE	107,"engine/bullets.h::bullets_fire::4::32"
						ld  c, a
	C_LINE	108,"engine/bullets.h::bullets_fire::4::32"
						ld  b, 0
	C_LINE	110,"engine/bullets.h::bullets_fire::4::32"
						ld  hl, __bxo
	C_LINE	111,"engine/bullets.h::bullets_fire::4::32"
						add hl, bc						
	C_LINE	112,"engine/bullets.h::bullets_fire::4::32"
						ld  d, (hl)
	C_LINE	113,"engine/bullets.h::bullets_fire::4::32"
						ld  a, (_gpx)
	C_LINE	114,"engine/bullets.h::bullets_fire::4::32"
						add d
	C_LINE	115,"engine/bullets.h::bullets_fire::4::32"
						ld  (__b_x),a
	C_LINE	117,"engine/bullets.h::bullets_fire::4::32"
						ld  hl, __byo
	C_LINE	118,"engine/bullets.h::bullets_fire::4::32"
						add hl, bc
	C_LINE	119,"engine/bullets.h::bullets_fire::4::32"
						ld  d, (hl)
	C_LINE	120,"engine/bullets.h::bullets_fire::4::32"
						ld  a, (_gpy)
	C_LINE	121,"engine/bullets.h::bullets_fire::4::32"
						add d
	C_LINE	122,"engine/bullets.h::bullets_fire::4::32"
						ld  (__b_y),a
	C_LINE	124,"engine/bullets.h::bullets_fire::4::32"
						ld  hl, __bmxo
	C_LINE	125,"engine/bullets.h::bullets_fire::4::32"
						add hl, bc
	C_LINE	126,"engine/bullets.h::bullets_fire::4::32"
						ld  a, (hl)
	C_LINE	127,"engine/bullets.h::bullets_fire::4::32"
						ld  (__b_mx),a
	C_LINE	129,"engine/bullets.h::bullets_fire::4::32"
						ld  hl, __bmyo
	C_LINE	130,"engine/bullets.h::bullets_fire::4::32"
						add hl, bc
	C_LINE	131,"engine/bullets.h::bullets_fire::4::32"
						ld  a, (hl)
	C_LINE	132,"engine/bullets.h::bullets_fire::4::32"
						ld  (__b_my),a
	C_LINE	133,"engine/bullets.h::bullets_fire::4::32"
;				
	C_LINE	135,"engine/bullets.h::bullets_fire::4::32"
;			
	C_LINE	136,"engine/bullets.h::bullets_fire::4::32"
;			
	C_LINE	168,"engine/bullets.h::bullets_fire::4::32"
;				beep_fx (6);
	C_LINE	171,"engine/bullets.h::bullets_fire::4::32"
	C_LINE	171,"engine/bullets.h::bullets_fire::4::32"
;6;
	C_LINE	172,"engine/bullets.h::bullets_fire::4::32"
	ld	hl,6	;const
	push	hl
	call	_beep_fx
	pop	bc
;			
	C_LINE	172,"engine/bullets.h::bullets_fire::4::32"
;			
	C_LINE	174,"engine/bullets.h::bullets_fire::4::32"
;			#line 1 "./my/ci/on_player_fires.h"
	C_LINE	182,"engine/bullets.h::bullets_fire::4::32"
	C_LINE	0,"./my/ci/on_player_fires.h::bullets_fire::4::32"
; 
	C_LINE	1,"./my/ci/on_player_fires.h::bullets_fire::4::32"
; 
	C_LINE	2,"./my/ci/on_player_fires.h::bullets_fire::4::32"
;#line 183 "engine/bullets.h"
	C_LINE	4,"./my/ci/on_player_fires.h::bullets_fire::4::32"
	C_LINE	182,"engine/bullets.h::bullets_fire::4::32"
;			bullets_update ();
	C_LINE	184,"engine/bullets.h::bullets_fire::4::32"
	C_LINE	184,"engine/bullets.h::bullets_fire::4::32"
	call	_bullets_update
;			
	C_LINE	186,"engine/bullets.h::bullets_fire::4::32"
;				-- p_ammo;
	C_LINE	187,"engine/bullets.h::bullets_fire::4::32"
	C_LINE	187,"engine/bullets.h::bullets_fire::4::32"
	ld	hl,_p_ammo
	dec	(hl)
	ld	l,(hl)
	ld	h,0
;			
	C_LINE	188,"engine/bullets.h::bullets_fire::4::32"
;			
	C_LINE	189,"engine/bullets.h::bullets_fire::4::32"
;			break;
	C_LINE	190,"engine/bullets.h::bullets_fire::4::32"
	C_LINE	190,"engine/bullets.h::bullets_fire::4::32"
	jp	i_37	;EOS
;		}
	C_LINE	191,"engine/bullets.h::bullets_fire::4::32"
;	}
	C_LINE	192,"engine/bullets.h::bullets_fire::3::32"
	jp	i_36	;EOS
	defc	i_39 = i_36
.i_37
;}
	C_LINE	193,"engine/bullets.h::bullets_fire::1::32"
	ret


;void bullets_move (void) {
	C_LINE	195,"engine/bullets.h::bullets_fire::0::32"
	C_LINE	195,"engine/bullets.h::bullets_fire::0::32"

; Function bullets_move flags 0x00000200 __smallc 
; void bullets_move()
	C_LINE	195,"engine/bullets.h::bullets_move::0::32"
._bullets_move
	C_LINE	195,"engine/bullets.h::bullets_move::0::32"
;	for (b_it = 0; b_it <  3 ; b_it ++) {
	C_LINE	196,"engine/bullets.h::bullets_move::1::33"
	C_LINE	196,"engine/bullets.h::bullets_move::1::33"
	xor	a
	ld	(_b_it),a
	jp	i_42	;EOS
.i_40
	ld	hl,_b_it
	ld	a,(hl)
	inc	(hl)
.i_42
	ld	hl,(_b_it)
	ld	h,0
	ld	a,l
	sub	3
	jp	nc,i_41	;
;		if (bullets_estado [b_it]) {
	C_LINE	197,"engine/bullets.h::bullets_move::3::34"
	C_LINE	197,"engine/bullets.h::bullets_move::3::34"
	ld	de,_bullets_estado
	ld	hl,(_b_it)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	a,l
	and	a
	jp	z,i_43	;
;			#asm
	C_LINE	198,"engine/bullets.h::bullets_move::4::35"
	C_LINE	198,"engine/bullets.h::bullets_move::4::35"
	C_LINE	200,"engine/bullets.h::bullets_move::4::35"
				ld  de, (_b_it)
	C_LINE	201,"engine/bullets.h::bullets_move::4::35"
				ld  d, 0
	C_LINE	203,"engine/bullets.h::bullets_move::4::35"
				ld  hl, _bullets_x
	C_LINE	204,"engine/bullets.h::bullets_move::4::35"
				add hl, de
	C_LINE	205,"engine/bullets.h::bullets_move::4::35"
				ld  a, (hl)
	C_LINE	206,"engine/bullets.h::bullets_move::4::35"
				ld  (__b_x), a
	C_LINE	208,"engine/bullets.h::bullets_move::4::35"
				ld  hl, _bullets_y
	C_LINE	209,"engine/bullets.h::bullets_move::4::35"
				add hl, de
	C_LINE	210,"engine/bullets.h::bullets_move::4::35"
				ld  a, (hl)
	C_LINE	211,"engine/bullets.h::bullets_move::4::35"
				ld  (__b_y), a
	C_LINE	213,"engine/bullets.h::bullets_move::4::35"
				ld  hl, _bullets_mx
	C_LINE	214,"engine/bullets.h::bullets_move::4::35"
				add hl, de
	C_LINE	215,"engine/bullets.h::bullets_move::4::35"
				ld  a, (hl)
	C_LINE	216,"engine/bullets.h::bullets_move::4::35"
				ld  (__b_mx), a
	C_LINE	218,"engine/bullets.h::bullets_move::4::35"
				ld  hl, _bullets_my
	C_LINE	219,"engine/bullets.h::bullets_move::4::35"
				add hl, de
	C_LINE	220,"engine/bullets.h::bullets_move::4::35"
				ld  a, (hl)
	C_LINE	221,"engine/bullets.h::bullets_move::4::35"
				ld  (__b_my), a
	C_LINE	223,"engine/bullets.h::bullets_move::4::35"
				ld  a, 1
	C_LINE	224,"engine/bullets.h::bullets_move::4::35"
				ld  (__b_estado), a
	C_LINE	225,"engine/bullets.h::bullets_move::4::35"
;			if (_b_mx) {
	C_LINE	228,"engine/bullets.h::bullets_move::4::35"
	C_LINE	228,"engine/bullets.h::bullets_move::4::35"
	ld	hl,__b_mx
	call	l_gchar
	ld	a,h
	or	l
	jp	z,i_44	;
;				_b_x += _b_mx;								
	C_LINE	229,"engine/bullets.h::bullets_move::5::36"
	C_LINE	229,"engine/bullets.h::bullets_move::5::36"
	ld	hl,(__b_x)
	ld	h,0
	push	hl
	ld	hl,__b_mx
	call	l_gchar
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(__b_x),a
;				if (_b_x > 240) {
	C_LINE	230,"engine/bullets.h::bullets_move::5::36"
	C_LINE	230,"engine/bullets.h::bullets_move::5::36"
	ld	hl,(__b_x)
	ld	h,0
	ld	a,240
	sub	l
	jp	nc,i_45	;
;					_b_estado = 0;
	C_LINE	231,"engine/bullets.h::bullets_move::6::37"
	C_LINE	231,"engine/bullets.h::bullets_move::6::37"
	ld	hl,0	;const
	ld	a,l
	ld	(__b_estado),a
;				}
	C_LINE	232,"engine/bullets.h::bullets_move::6::37"
;			} 
	C_LINE	233,"engine/bullets.h::bullets_move::5::37"
.i_45
;							if (_b_my) {
	C_LINE	234,"engine/bullets.h::bullets_move::4::37"
.i_44
	C_LINE	234,"engine/bullets.h::bullets_move::4::37"
	ld	hl,__b_my
	call	l_gchar
	ld	a,h
	or	l
	jp	z,i_46	;
;					_b_y += _b_my;
	C_LINE	235,"engine/bullets.h::bullets_move::5::38"
	C_LINE	235,"engine/bullets.h::bullets_move::5::38"
	ld	hl,(__b_y)
	ld	h,0
	push	hl
	ld	hl,__b_my
	call	l_gchar
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(__b_y),a
;					if (_b_y > 160) {
	C_LINE	236,"engine/bullets.h::bullets_move::5::38"
	C_LINE	236,"engine/bullets.h::bullets_move::5::38"
	ld	hl,(__b_y)
	ld	h,0
	ld	a,160
	sub	l
	jp	nc,i_47	;
;						_b_estado = 0;
	C_LINE	237,"engine/bullets.h::bullets_move::6::39"
	C_LINE	237,"engine/bullets.h::bullets_move::6::39"
	ld	hl,0	;const
	ld	a,l
	ld	(__b_estado),a
;					}
	C_LINE	238,"engine/bullets.h::bullets_move::6::39"
;				}
	C_LINE	239,"engine/bullets.h::bullets_move::5::39"
.i_47
;						_x = (_b_x + 3) >> 4;
	C_LINE	240,"engine/bullets.h::bullets_move::4::39"
.i_46
	C_LINE	240,"engine/bullets.h::bullets_move::4::39"
	ld	hl,(__b_x)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(__x),a
;			_y = (_b_y + 3) >> 4;
	C_LINE	241,"engine/bullets.h::bullets_move::4::39"
	C_LINE	241,"engine/bullets.h::bullets_move::4::39"
	ld	hl,(__b_y)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(__y),a
;			rda = attr (_x, _y);
	C_LINE	242,"engine/bullets.h::bullets_move::4::39"
	C_LINE	242,"engine/bullets.h::bullets_move::4::39"
;_x;
	C_LINE	243,"engine/bullets.h::bullets_move::4::39"
	ld	hl,(__x)
	ld	h,0
	push	hl
;_y;
	C_LINE	243,"engine/bullets.h::bullets_move::4::39"
	ld	hl,(__y)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	h,0
	ld	a,l
	ld	(_rda),a
;			
	C_LINE	243,"engine/bullets.h::bullets_move::4::39"
;				if (rda & 16) break_wall ();
	C_LINE	244,"engine/bullets.h::bullets_move::4::39"
	C_LINE	244,"engine/bullets.h::bullets_move::4::39"
	ld	hl,(_rda)
	ld	h,0
	ld	a,16
	and	l
	ld	l,a
	ld	a,h
	or	l
	jp	z,i_48	;
	call	_break_wall
;			
	C_LINE	245,"engine/bullets.h::bullets_move::4::39"
;			if (rda > 7) _b_estado = 0;
	C_LINE	246,"engine/bullets.h::bullets_move::4::39"
.i_48
	C_LINE	246,"engine/bullets.h::bullets_move::4::39"
	ld	hl,(_rda)
	ld	h,0
	ld	a,7
	sub	l
	jp	nc,i_49	;
	ld	hl,0	;const
	ld	a,l
	ld	(__b_estado),a
;		
	C_LINE	247,"engine/bullets.h::bullets_move::4::39"
;			
	C_LINE	248,"engine/bullets.h::bullets_move::4::39"
;			bullets_update ();				
	C_LINE	256,"engine/bullets.h::bullets_move::4::39"
.i_49
	C_LINE	256,"engine/bullets.h::bullets_move::4::39"
	call	_bullets_update
;		}	
	C_LINE	257,"engine/bullets.h::bullets_move::4::39"
;	}	
	C_LINE	258,"engine/bullets.h::bullets_move::3::39"
	jp	i_40	;EOS
	defc	i_43 = i_40
.i_41
;}
	C_LINE	259,"engine/bullets.h::bullets_move::1::39"
	ret


;#line 126 "mk1.c"
	C_LINE	260,"engine/bullets.h::bullets_move::0::39"
	C_LINE	125,"mk1.c::bullets_move::0::39"
;	#line 1 "engine/simple_cocos.h"
	C_LINE	128,"mk1.c::bullets_move::0::39"
	C_LINE	0,"engine/simple_cocos.h::bullets_move::0::39"
; 
	C_LINE	1,"engine/simple_cocos.h::bullets_move::0::39"
; 
	C_LINE	2,"engine/simple_cocos.h::bullets_move::0::39"
; 
	C_LINE	4,"engine/simple_cocos.h::bullets_move::0::39"
; 
	C_LINE	6,"engine/simple_cocos.h::bullets_move::0::39"
; 
	C_LINE	7,"engine/simple_cocos.h::bullets_move::0::39"
; 
	C_LINE	9,"engine/simple_cocos.h::bullets_move::0::39"
; 
	C_LINE	10,"engine/simple_cocos.h::bullets_move::0::39"
;void simple_coco_init (void) {
	C_LINE	12,"engine/simple_cocos.h::bullets_move::0::39"
	C_LINE	12,"engine/simple_cocos.h::bullets_move::0::39"

; Function simple_coco_init flags 0x00000200 __smallc 
; void simple_coco_init()
	C_LINE	12,"engine/simple_cocos.h::simple_coco_init::0::39"
._simple_coco_init
	C_LINE	12,"engine/simple_cocos.h::simple_coco_init::0::39"
;	for (enit = 0; enit <  3 ; ++ enit) cocos_y [enit] = 0xff;
	C_LINE	13,"engine/simple_cocos.h::simple_coco_init::1::40"
	C_LINE	13,"engine/simple_cocos.h::simple_coco_init::1::40"
	xor	a
	ld	(_enit),a
	jp	i_52	;EOS
.i_50
	ld	hl,_enit
	inc	(hl)
	ld	l,(hl)
	ld	h,0
.i_52
	ld	a,(_enit)
	sub	3
	jp	nc,i_51	;
	ld	de,_cocos_y
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	(hl),255
	jp	i_50	;EOS
.i_51
;}
	C_LINE	14,"engine/simple_cocos.h::simple_coco_init::1::40"
	ret


;void simple_coco_shoot (void) {
	C_LINE	16,"engine/simple_cocos.h::simple_coco_init::0::40"
	C_LINE	16,"engine/simple_cocos.h::simple_coco_init::0::40"

; Function simple_coco_shoot flags 0x00000200 __smallc 
; void simple_coco_shoot()
	C_LINE	16,"engine/simple_cocos.h::simple_coco_shoot::0::40"
._simple_coco_shoot
	C_LINE	16,"engine/simple_cocos.h::simple_coco_shoot::0::40"
;	#asm
	C_LINE	17,"engine/simple_cocos.h::simple_coco_shoot::1::41"
	C_LINE	17,"engine/simple_cocos.h::simple_coco_shoot::1::41"
	C_LINE	19,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  de, (_enit)
	C_LINE	20,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  d, 0 					 
	C_LINE	22,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  hl, _cocos_y
	C_LINE	23,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			add hl, de
	C_LINE	25,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  a, (hl)
	C_LINE	26,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			cp  160
	C_LINE	27,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ret c
	C_LINE	29,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  a, (__en_y)
	C_LINE	30,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			add 4
	C_LINE	31,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  (hl), a 				 
	C_LINE	33,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  hl, _cocos_x
	C_LINE	34,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			add hl, de
	C_LINE	35,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  a, (__en_x)
	C_LINE	36,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			add 4
	C_LINE	37,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  (hl), a 				 
	C_LINE	39,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  a, (_rda)				 
	C_LINE	41,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  e, a
	C_LINE	42,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  d, 0 					 
	C_LINE	43,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  hl, __dx
	C_LINE	44,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			add hl, de
	C_LINE	45,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  b, (hl) 				 
	C_LINE	46,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  hl, __dy
	C_LINE	47,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			add hl, de
	C_LINE	48,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  c, (hl) 				 
	C_LINE	50,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  de, (_enit)
	C_LINE	51,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  d, 0 					 
	C_LINE	53,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  hl, _cocos_mx
	C_LINE	54,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			add hl, de
	C_LINE	55,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  (hl), b 				 
	C_LINE	57,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  hl, _cocos_my
	C_LINE	58,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			add hl, de
	C_LINE	59,"engine/simple_cocos.h::simple_coco_shoot::1::41"
			ld  (hl), c 				 
	C_LINE	60,"engine/simple_cocos.h::simple_coco_shoot::1::41"
;}
	C_LINE	62,"engine/simple_cocos.h::simple_coco_shoot::1::41"
	ret


;void simple_coco_update (void) {
	C_LINE	64,"engine/simple_cocos.h::simple_coco_shoot::0::41"
	C_LINE	64,"engine/simple_cocos.h::simple_coco_shoot::0::41"

; Function simple_coco_update flags 0x00000200 __smallc 
; void simple_coco_update()
	C_LINE	64,"engine/simple_cocos.h::simple_coco_update::0::41"
._simple_coco_update
	C_LINE	64,"engine/simple_cocos.h::simple_coco_update::0::41"
;	for (enit = 0; enit <  3 ; ++ enit) if (cocos_y [enit] < 160) {
	C_LINE	65,"engine/simple_cocos.h::simple_coco_update::1::42"
	C_LINE	65,"engine/simple_cocos.h::simple_coco_update::1::42"
	xor	a
	ld	(_enit),a
	jp	i_55	;EOS
.i_53
	ld	hl,_enit
	inc	(hl)
	ld	l,(hl)
	ld	h,0
.i_55
	ld	a,(_enit)
	sub	3
	jp	nc,i_54	;
	ld	de,_cocos_y
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	sub	160
	jp	nc,i_56	;
;		#asm				
	C_LINE	66,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	66,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	68,"engine/simple_cocos.h::simple_coco_update::3::43"
			._simple_coco_update_do
	C_LINE	69,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	71,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  de, (_enit)
	C_LINE	72,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  d, 0
	C_LINE	74,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  hl, _cocos_y 
	C_LINE	75,"engine/simple_cocos.h::simple_coco_update::3::43"
				add hl, de
	C_LINE	76,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  b, (hl) 			 
	C_LINE	78,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  hl, _cocos_x
	C_LINE	79,"engine/simple_cocos.h::simple_coco_update::3::43"
				add hl, de
	C_LINE	80,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  c, (hl) 			 
	C_LINE	82,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  hl, _cocos_my
	C_LINE	83,"engine/simple_cocos.h::simple_coco_update::3::43"
				add hl, de
	C_LINE	84,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, (hl)
	C_LINE	85,"engine/simple_cocos.h::simple_coco_update::3::43"
				add b
	C_LINE	86,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  (_rdy), a 			 
	C_LINE	88,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  hl, _cocos_mx
	C_LINE	89,"engine/simple_cocos.h::simple_coco_update::3::43"
				add hl, de
	C_LINE	90,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, (hl)
	C_LINE	91,"engine/simple_cocos.h::simple_coco_update::3::43"
				add c
	C_LINE	92,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  (_rdx), a 			 
	C_LINE	94,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	95,"engine/simple_cocos.h::simple_coco_update::3::43"
				cp  240
	C_LINE	96,"engine/simple_cocos.h::simple_coco_update::3::43"
				jr  c, _simple_coco_update_keep_going
	C_LINE	98,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, 0xff
	C_LINE	99,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  (_rdy), a 			 
	C_LINE	100,"engine/simple_cocos.h::simple_coco_update::3::43"
				jr  _simple_coco_update_continue
	C_LINE	102,"engine/simple_cocos.h::simple_coco_update::3::43"
			._simple_coco_update_keep_going
	C_LINE	103,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	104,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	106,"engine/simple_cocos.h::simple_coco_update::3::43"
							ld  a, (_p_estado)
	C_LINE	107,"engine/simple_cocos.h::simple_coco_update::3::43"
				or  a 
	C_LINE	108,"engine/simple_cocos.h::simple_coco_update::3::43"
				jr  nz, _simple_coco_update_continue
	C_LINE	109,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	110,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	111,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	113,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	114,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, (_gpx)
	C_LINE	115,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  c, a
	C_LINE	116,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, (_rdx)
	C_LINE	117,"engine/simple_cocos.h::simple_coco_update::3::43"
				add 3
	C_LINE	118,"engine/simple_cocos.h::simple_coco_update::3::43"
				cp  c 
	C_LINE	119,"engine/simple_cocos.h::simple_coco_update::3::43"
				jr  c, _simple_coco_update_collpl_done
	C_LINE	121,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	122,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, (_rdx)
	C_LINE	123,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  c, a
	C_LINE	124,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, (_gpx)
	C_LINE	125,"engine/simple_cocos.h::simple_coco_update::3::43"
				add 12
	C_LINE	126,"engine/simple_cocos.h::simple_coco_update::3::43"
				cp  c 
	C_LINE	127,"engine/simple_cocos.h::simple_coco_update::3::43"
				jr  c, _simple_coco_update_collpl_done
	C_LINE	129,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	130,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	132,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	133,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, (_gpy)
	C_LINE	134,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  c, a
	C_LINE	135,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, (_rdy)
	C_LINE	136,"engine/simple_cocos.h::simple_coco_update::3::43"
				add 3
	C_LINE	137,"engine/simple_cocos.h::simple_coco_update::3::43"
				cp  c 
	C_LINE	138,"engine/simple_cocos.h::simple_coco_update::3::43"
				jr  c, _simple_coco_update_collpl_done
	C_LINE	140,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	141,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, (_rdy)
	C_LINE	142,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  c, a
	C_LINE	143,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, (_gpy)
	C_LINE	144,"engine/simple_cocos.h::simple_coco_update::3::43"
				add 12
	C_LINE	145,"engine/simple_cocos.h::simple_coco_update::3::43"
				cp  c 
	C_LINE	146,"engine/simple_cocos.h::simple_coco_update::3::43"
				jr  c, _simple_coco_update_collpl_done
	C_LINE	148,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	149,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, 0xff
	C_LINE	150,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  (_rdy), a 			 
	C_LINE	152,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	154,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, 4
	C_LINE	155,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	156,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  (_p_killme), a
	C_LINE	158,"engine/simple_cocos.h::simple_coco_update::3::43"
				jr  _simple_coco_update_continue
	C_LINE	160,"engine/simple_cocos.h::simple_coco_update::3::43"
			._simple_coco_update_collpl_done
	C_LINE	162,"engine/simple_cocos.h::simple_coco_update::3::43"
;			
	C_LINE	164,"engine/simple_cocos.h::simple_coco_update::3::43"
;		 
	C_LINE	165,"engine/simple_cocos.h::simple_coco_update::3::43"
;		if (attr ((rdx + 3) >> 4, (rdy + 3) >> 4) & 12) rdy = 0xff;
	C_LINE	166,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	166,"engine/simple_cocos.h::simple_coco_update::3::43"
;(rdx +3) >>4;
	C_LINE	167,"engine/simple_cocos.h::simple_coco_update::3::43"
	ld	hl,(_rdx)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	push	hl
;(rdy +3) >>4;
	C_LINE	167,"engine/simple_cocos.h::simple_coco_update::3::43"
	ld	hl,(_rdy)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	a,l
	and	12
	jp	z,i_57	;
	ld	hl,255	;const
	ld	a,l
	ld	(_rdy),a
;		#asm
	C_LINE	168,"engine/simple_cocos.h::simple_coco_update::3::43"
.i_57
	C_LINE	168,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	171,"engine/simple_cocos.h::simple_coco_update::3::43"
			._simple_coco_update_continue
	C_LINE	172,"engine/simple_cocos.h::simple_coco_update::3::43"
	C_LINE	173,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  de, (_enit)
	C_LINE	174,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  d, 0
	C_LINE	176,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  hl, _cocos_y 
	C_LINE	177,"engine/simple_cocos.h::simple_coco_update::3::43"
				add hl, de
	C_LINE	178,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, (_rdy)
	C_LINE	179,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  (hl), a
	C_LINE	181,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  hl, _cocos_x
	C_LINE	182,"engine/simple_cocos.h::simple_coco_update::3::43"
				add hl, de
	C_LINE	183,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  a, (_rdx)
	C_LINE	184,"engine/simple_cocos.h::simple_coco_update::3::43"
				ld  (hl), a
	C_LINE	186,"engine/simple_cocos.h::simple_coco_update::3::43"
			._simple_coco_update_done
	C_LINE	187,"engine/simple_cocos.h::simple_coco_update::3::43"
;	}
	C_LINE	189,"engine/simple_cocos.h::simple_coco_update::3::43"
;}
	C_LINE	190,"engine/simple_cocos.h::simple_coco_update::2::43"
	jp	i_53	;EOS
	defc	i_56 = i_53
.i_54
	ret


;#line 129 "mk1.c"
	C_LINE	191,"engine/simple_cocos.h::simple_coco_update::0::43"
	C_LINE	128,"mk1.c::simple_coco_update::0::43"
;	#line 1 "engine/c_levels.h"
	C_LINE	131,"mk1.c::simple_coco_update::0::43"
	C_LINE	0,"engine/c_levels.h::simple_coco_update::0::43"
;void prepare_level (void) {
	C_LINE	2,"engine/c_levels.h::simple_coco_update::0::43"
	C_LINE	2,"engine/c_levels.h::simple_coco_update::0::43"

; Function prepare_level flags 0x00000200 __smallc 
; void prepare_level()
	C_LINE	2,"engine/c_levels.h::prepare_level::0::43"
._prepare_level
	C_LINE	2,"engine/c_levels.h::prepare_level::0::43"
;	
	C_LINE	3,"engine/c_levels.h::prepare_level::1::44"
;		unpack ((unsigned int) levels [level].c_map_bolts, (unsigned int) (mapa));
	C_LINE	21,"engine/c_levels.h::prepare_level::1::44"
	C_LINE	21,"engine/c_levels.h::prepare_level::1::44"
;(unsigned int)levels [level].c_map_bolts;
	C_LINE	22,"engine/c_levels.h::prepare_level::1::44"
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,6
	add	hl,bc
	call	l_gint	;
	push	hl
;(unsigned int)(mapa);
	C_LINE	22,"engine/c_levels.h::prepare_level::1::44"
	ld	hl,_mapa
	push	hl
	call	_unpack
	pop	bc
	pop	bc
;		unpack ((unsigned int) levels [level].c_tileset, (unsigned int) (tileset));
	C_LINE	22,"engine/c_levels.h::prepare_level::1::44"
	C_LINE	22,"engine/c_levels.h::prepare_level::1::44"
;(unsigned int)levels [level].c_tileset;
	C_LINE	23,"engine/c_levels.h::prepare_level::1::44"
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	call	l_gint	;
	push	hl
;(unsigned int)(tileset);
	C_LINE	23,"engine/c_levels.h::prepare_level::1::44"
	ld	hl,_tileset
	push	hl
	call	_unpack
	pop	bc
	pop	bc
;		unpack ((unsigned int) levels [level].c_enems_hotspots, (unsigned int) (malotes));
	C_LINE	23,"engine/c_levels.h::prepare_level::1::44"
	C_LINE	23,"engine/c_levels.h::prepare_level::1::44"
;(unsigned int)levels [level].c_enems_hotspots;
	C_LINE	24,"engine/c_levels.h::prepare_level::1::44"
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,10
	add	hl,bc
	call	l_gint	;
	push	hl
;(unsigned int)(malotes);
	C_LINE	24,"engine/c_levels.h::prepare_level::1::44"
	ld	hl,_malotes
	push	hl
	call	_unpack
	pop	bc
	pop	bc
;		unpack ((unsigned int) levels [level].c_behs, (unsigned int) (behs));
	C_LINE	24,"engine/c_levels.h::prepare_level::1::44"
	C_LINE	24,"engine/c_levels.h::prepare_level::1::44"
;(unsigned int)levels [level].c_behs;
	C_LINE	25,"engine/c_levels.h::prepare_level::1::44"
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,12
	add	hl,bc
	call	l_gint	;
	push	hl
;(unsigned int)(behs);
	C_LINE	25,"engine/c_levels.h::prepare_level::1::44"
	ld	hl,_behs
	push	hl
	call	_unpack
	pop	bc
	pop	bc
;		
	C_LINE	26,"engine/c_levels.h::prepare_level::1::44"
;		level_data.map_w = levels [level].map_w;
	C_LINE	30,"engine/c_levels.h::prepare_level::1::44"
	C_LINE	30,"engine/c_levels.h::prepare_level::1::44"
	ld	hl,_level_data
	push	hl
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	l,a
	ld	h,0
;		level_data.map_h = levels [level].map_h;
	C_LINE	31,"engine/c_levels.h::prepare_level::1::44"
	C_LINE	31,"engine/c_levels.h::prepare_level::1::44"
	ld	hl,_level_data+1
	push	hl
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	l,a
	ld	h,0
;		
	C_LINE	32,"engine/c_levels.h::prepare_level::1::44"
;		
	C_LINE	33,"engine/c_levels.h::prepare_level::1::44"
;			if (warp_to_level == 0)
	C_LINE	36,"engine/c_levels.h::prepare_level::1::44"
	C_LINE	36,"engine/c_levels.h::prepare_level::1::44"
	ld	hl,(_warp_to_level)
	ld	h,0
	ld	a,l
	and	a
	jp	nz,i_58	;
;		
	C_LINE	37,"engine/c_levels.h::prepare_level::1::44"
;		{
	C_LINE	38,"engine/c_levels.h::prepare_level::1::44"
	C_LINE	38,"engine/c_levels.h::prepare_level::1::44"
;			n_pant = levels [level].scr_ini;
	C_LINE	39,"engine/c_levels.h::prepare_level::2::45"
	C_LINE	39,"engine/c_levels.h::prepare_level::2::45"
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
;			gpx = levels [level].ini_x << 4; p_x = gpx << 6;
	C_LINE	40,"engine/c_levels.h::prepare_level::2::45"
	C_LINE	40,"engine/c_levels.h::prepare_level::2::45"
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	inc	hl
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	a,l
	ld	hl,_gpx
	ld	(hl),a
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	(_p_x),hl
;			gpy = levels [level].ini_y << 4; p_y = gpy << 6;
	C_LINE	41,"engine/c_levels.h::prepare_level::2::45"
	C_LINE	41,"engine/c_levels.h::prepare_level::2::45"
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	add	hl,hl
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,4
	add	hl,bc
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	a,l
	ld	hl,_gpy
	ld	(hl),a
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	(_p_y),hl
;		}
	C_LINE	42,"engine/c_levels.h::prepare_level::2::45"
;		
	C_LINE	44,"engine/c_levels.h::prepare_level::1::45"
;	
	C_LINE	47,"engine/c_levels.h::prepare_level::1::45"
;}
	C_LINE	48,"engine/c_levels.h::prepare_level::1::45"
.i_58
	ret


;#line 132 "mk1.c"
	C_LINE	49,"engine/c_levels.h::prepare_level::0::45"
	C_LINE	131,"mk1.c::prepare_level::0::45"
;#line 1 "engine.h"
	C_LINE	133,"mk1.c::prepare_level::0::45"
	C_LINE	0,"engine.h::prepare_level::0::45"
; 
	C_LINE	1,"engine.h::prepare_level::0::45"
; 
	C_LINE	2,"engine.h::prepare_level::0::45"
; 
	C_LINE	39,"engine.h::prepare_level::0::45"
;	 
	C_LINE	45,"engine.h::prepare_level::0::45"
;	 
	C_LINE	46,"engine.h::prepare_level::0::45"
;	 
	C_LINE	47,"engine.h::prepare_level::0::45"
;	 
	C_LINE	48,"engine.h::prepare_level::0::45"
;	const unsigned char *player_cells [] = {
	C_LINE	49,"engine.h::prepare_level::0::45"
	C_LINE	49,"engine.h::prepare_level::0::45"
	SECTION	rodata_compiler
._player_cells
;		sprite_1_a, sprite_2_a, sprite_3_a, sprite_4_a,
	C_LINE	50,"engine.h::prepare_level::0::45"
	defw	_sprite_1_a + 0
	defw	_sprite_2_a + 0
	defw	_sprite_3_a + 0
	defw	_sprite_4_a + 0
;		sprite_5_a, sprite_6_a, sprite_7_a, sprite_8_a
	C_LINE	51,"engine.h::prepare_level::0::45"
	defw	_sprite_5_a + 0
	defw	_sprite_6_a + 0
	defw	_sprite_7_a + 0
;	};
	C_LINE	52,"engine.h::prepare_level::0::45"
	defw	_sprite_8_a + 0
	SECTION	code_compiler
; 
	C_LINE	54,"engine.h::prepare_level::0::45"
; 
	C_LINE	55,"engine.h::prepare_level::0::45"
; 
	C_LINE	56,"engine.h::prepare_level::0::45"
; 
	C_LINE	62,"engine.h::prepare_level::0::45"
; 
	C_LINE	63,"engine.h::prepare_level::0::45"
;const unsigned char *enem_cells [] = {
	C_LINE	71,"engine.h::prepare_level::0::45"
	C_LINE	71,"engine.h::prepare_level::0::45"
	SECTION	rodata_compiler
._enem_cells
;	sprite_9_a, sprite_10_a, sprite_11_a, sprite_12_a, 
	C_LINE	72,"engine.h::prepare_level::0::45"
	defw	_sprite_9_a + 0
	defw	_sprite_10_a + 0
	defw	_sprite_11_a + 0
	defw	_sprite_12_a + 0
;	sprite_13_a, sprite_14_a, sprite_15_a, sprite_16_a
	C_LINE	73,"engine.h::prepare_level::0::45"
	defw	_sprite_13_a + 0
	defw	_sprite_14_a + 0
	defw	_sprite_15_a + 0
;};
	C_LINE	74,"engine.h::prepare_level::0::45"
	defw	_sprite_16_a + 0
	SECTION	code_compiler
;#line 1 "my/fixed_screens.h"
	C_LINE	76,"engine.h::prepare_level::0::45"
	C_LINE	0,"my/fixed_screens.h::prepare_level::0::45"
; 
	C_LINE	1,"my/fixed_screens.h::prepare_level::0::45"
; 
	C_LINE	2,"my/fixed_screens.h::prepare_level::0::45"
;void validate (void) {
	C_LINE	4,"my/fixed_screens.h::prepare_level::0::45"
	C_LINE	4,"my/fixed_screens.h::prepare_level::0::45"

; Function validate flags 0x00000200 __smallc 
; void validate()
	C_LINE	4,"my/fixed_screens.h::validate::0::45"
._validate
	C_LINE	4,"my/fixed_screens.h::validate::0::45"
;	clear_sprites ();
	C_LINE	5,"my/fixed_screens.h::validate::1::46"
	C_LINE	5,"my/fixed_screens.h::validate::1::46"
	call	_clear_sprites
;	#asm
	C_LINE	6,"my/fixed_screens.h::validate::1::46"
	C_LINE	6,"my/fixed_screens.h::validate::1::46"
	C_LINE	8,"my/fixed_screens.h::validate::1::46"
		LIB SPValidate
	C_LINE	9,"my/fixed_screens.h::validate::1::46"
		ld  c,  1 
	C_LINE	10,"my/fixed_screens.h::validate::1::46"
		ld  b,  1 
	C_LINE	11,"my/fixed_screens.h::validate::1::46"
		ld  d,  1 +19
	C_LINE	12,"my/fixed_screens.h::validate::1::46"
		ld  e,  1 +29
	C_LINE	13,"my/fixed_screens.h::validate::1::46"
		ld  iy, fsClipStruct
	C_LINE	14,"my/fixed_screens.h::validate::1::46"
		call SPValidate
	C_LINE	15,"my/fixed_screens.h::validate::1::46"
;}
	C_LINE	17,"my/fixed_screens.h::validate::1::46"
	ret


;	void lame_sound (void) {
	C_LINE	19,"my/fixed_screens.h::validate::0::46"
	C_LINE	19,"my/fixed_screens.h::validate::0::46"

; Function lame_sound flags 0x00000200 __smallc 
; void lame_sound()
	C_LINE	19,"my/fixed_screens.h::lame_sound::0::46"
._lame_sound
	C_LINE	19,"my/fixed_screens.h::lame_sound::0::46"
;		gpit = 4; do {
	C_LINE	20,"my/fixed_screens.h::lame_sound::1::47"
	C_LINE	20,"my/fixed_screens.h::lame_sound::1::47"
	ld	hl,4	;const
	ld	a,l
	ld	(_gpit),a
.i_63
;			beep_fx (rda);
	C_LINE	21,"my/fixed_screens.h::lame_sound::2::48"
	C_LINE	21,"my/fixed_screens.h::lame_sound::2::48"
;rda;
	C_LINE	22,"my/fixed_screens.h::lame_sound::2::48"
	ld	hl,(_rda)
	ld	h,0
	push	hl
	call	_beep_fx
	pop	bc
;			beep_fx (rdb);
	C_LINE	22,"my/fixed_screens.h::lame_sound::2::48"
	C_LINE	22,"my/fixed_screens.h::lame_sound::2::48"
;rdb;
	C_LINE	23,"my/fixed_screens.h::lame_sound::2::48"
	ld	hl,(_rdb)
	ld	h,0
	push	hl
	call	_beep_fx
	pop	bc
;		} while (-- gpit);
	C_LINE	23,"my/fixed_screens.h::lame_sound::2::48"
.i_61
	ld	hl,_gpit
	dec	(hl)
	ld	l,(hl)
	ld	a,l
	and	a
	jp	nz,i_63	;EOS
.i_62
;		beep_fx (9);
	C_LINE	24,"my/fixed_screens.h::lame_sound::1::48"
	C_LINE	24,"my/fixed_screens.h::lame_sound::1::48"
;9;
	C_LINE	25,"my/fixed_screens.h::lame_sound::1::48"
	ld	hl,9	;const
	push	hl
	call	_beep_fx
	pop	bc
;	}
	C_LINE	25,"my/fixed_screens.h::lame_sound::1::48"
	ret


;void game_ending (void) {
	C_LINE	27,"my/fixed_screens.h::lame_sound::0::48"
	C_LINE	27,"my/fixed_screens.h::lame_sound::0::48"

; Function game_ending flags 0x00000200 __smallc 
; void game_ending()
	C_LINE	27,"my/fixed_screens.h::game_ending::0::48"
._game_ending
	C_LINE	27,"my/fixed_screens.h::game_ending::0::48"
;	sp_UpdateNow();
	C_LINE	28,"my/fixed_screens.h::game_ending::1::49"
	C_LINE	28,"my/fixed_screens.h::game_ending::1::49"
	call	sp_UpdateNow
;	blackout ();
	C_LINE	29,"my/fixed_screens.h::game_ending::1::49"
	C_LINE	29,"my/fixed_screens.h::game_ending::1::49"
	call	_blackout
;	
	C_LINE	30,"my/fixed_screens.h::game_ending::1::49"
; 
	C_LINE	31,"my/fixed_screens.h::game_ending::1::49"
;		#asm
	C_LINE	34,"my/fixed_screens.h::game_ending::1::49"
	C_LINE	34,"my/fixed_screens.h::game_ending::1::49"
	C_LINE	36,"my/fixed_screens.h::game_ending::1::49"
			ld hl, _s_ending
	C_LINE	37,"my/fixed_screens.h::game_ending::1::49"
			ld de, 16384
	C_LINE	38,"my/fixed_screens.h::game_ending::1::49"
			call depack
	C_LINE	39,"my/fixed_screens.h::game_ending::1::49"
;	
	C_LINE	41,"my/fixed_screens.h::game_ending::1::49"
;	 
	C_LINE	42,"my/fixed_screens.h::game_ending::1::49"
;	
	C_LINE	43,"my/fixed_screens.h::game_ending::1::49"
;		_x = 8; _y = 7; _t = 70; _gp_gen = (unsigned char *) ("CONGRATULATIONS!"); print_str ();
	C_LINE	48,"my/fixed_screens.h::game_ending::1::49"
	C_LINE	48,"my/fixed_screens.h::game_ending::1::49"
	ld	a,8
	ld	(__x),a
	ld	a,7
	ld	(__y),a
	ld	a,70
	ld	(__t),a
	ld	hl,i_1+22
	ld	(__gp_gen),hl
	call	_print_str
;		_x = 2; _y = 9; _t = 71; _gp_gen = (unsigned char *) ("YOU MANAGED TO SET THE BOMBS"); print_str ();
	C_LINE	49,"my/fixed_screens.h::game_ending::1::49"
	C_LINE	49,"my/fixed_screens.h::game_ending::1::49"
	ld	a,2
	ld	(__x),a
	ld	a,9
	ld	(__y),a
	ld	a,71
	ld	(__t),a
	ld	hl,i_1+39
	ld	(__gp_gen),hl
	call	_print_str
;		_x = 4; _y = 10;         _gp_gen = (unsigned char *) ("AND DESTROY THE COMPUTER"); print_str ();
	C_LINE	50,"my/fixed_screens.h::game_ending::1::49"
	C_LINE	50,"my/fixed_screens.h::game_ending::1::49"
	ld	a,4
	ld	(__x),a
	ld	a,10
	ld	(__y),a
	ld	hl,i_1+68
	ld	(__gp_gen),hl
	call	_print_str
;		_x = 5; _y = 11;         _gp_gen = (unsigned char *) ("MISSION ACCOMPLISHED!!"); print_str ();
	C_LINE	51,"my/fixed_screens.h::game_ending::1::49"
	C_LINE	51,"my/fixed_screens.h::game_ending::1::49"
	ld	a,5
	ld	(__x),a
	ld	a,11
	ld	(__y),a
	ld	hl,i_1+93
	ld	(__gp_gen),hl
	call	_print_str
;	
	C_LINE	52,"my/fixed_screens.h::game_ending::1::49"
;	sp_UpdateNowEx (0);
	C_LINE	53,"my/fixed_screens.h::game_ending::1::49"
	C_LINE	53,"my/fixed_screens.h::game_ending::1::49"
;0;
	C_LINE	54,"my/fixed_screens.h::game_ending::1::49"
	ld	hl,0	;const
	push	hl
	call	sp_UpdateNowEx
	pop	bc
;	
	C_LINE	54,"my/fixed_screens.h::game_ending::1::49"
;	
	C_LINE	55,"my/fixed_screens.h::game_ending::1::49"
;		rda = 7; rdb = 2;
	C_LINE	57,"my/fixed_screens.h::game_ending::1::49"
	C_LINE	57,"my/fixed_screens.h::game_ending::1::49"
	ld	a,7
	ld	(_rda),a
	ld	hl,2	;const
	ld	a,l
	ld	(_rdb),a
;		lame_sound ();		
	C_LINE	58,"my/fixed_screens.h::game_ending::1::49"
	C_LINE	58,"my/fixed_screens.h::game_ending::1::49"
	call	_lame_sound
;	
	C_LINE	59,"my/fixed_screens.h::game_ending::1::49"
;	espera_activa (5000);
	C_LINE	61,"my/fixed_screens.h::game_ending::1::49"
	C_LINE	61,"my/fixed_screens.h::game_ending::1::49"
;5000;
	C_LINE	62,"my/fixed_screens.h::game_ending::1::49"
	ld	hl,5000	;const
	push	hl
	call	_espera_activa
	pop	bc
;}
	C_LINE	62,"my/fixed_screens.h::game_ending::1::49"
	ret


;void dr (void) {
	C_LINE	64,"my/fixed_screens.h::game_ending::0::49"
	C_LINE	64,"my/fixed_screens.h::game_ending::0::49"

; Function dr flags 0x00000200 __smallc 
; void dr()
	C_LINE	64,"my/fixed_screens.h::dr::0::49"
._dr
	C_LINE	64,"my/fixed_screens.h::dr::0::49"
;	_x = 10; _y = 11; _t = 79; _gp_gen = spacer; print_str ();
	C_LINE	65,"my/fixed_screens.h::dr::1::50"
	C_LINE	65,"my/fixed_screens.h::dr::1::50"
	ld	a,10
	ld	(__x),a
	ld	a,11
	ld	(__y),a
	ld	a,79
	ld	(__t),a
	ld	hl,(_spacer)
	ld	(__gp_gen),hl
	call	_print_str
;	_x = 10; _y = 12;          _gp_gen = gen_pt; print_str ();
	C_LINE	66,"my/fixed_screens.h::dr::1::50"
	C_LINE	66,"my/fixed_screens.h::dr::1::50"
	ld	a,10
	ld	(__x),a
	ld	a,12
	ld	(__y),a
	ld	hl,(_gen_pt)
	ld	(__gp_gen),hl
	call	_print_str
;	_x = 10; _y = 13;          _gp_gen = spacer; print_str ();
	C_LINE	67,"my/fixed_screens.h::dr::1::50"
	C_LINE	67,"my/fixed_screens.h::dr::1::50"
	ld	a,10
	ld	(__x),a
	ld	a,13
	ld	(__y),a
	ld	hl,(_spacer)
	ld	(__gp_gen),hl
	call	_print_str
;	sp_UpdateNowEx (0);
	C_LINE	68,"my/fixed_screens.h::dr::1::50"
	C_LINE	68,"my/fixed_screens.h::dr::1::50"
;0;
	C_LINE	69,"my/fixed_screens.h::dr::1::50"
	ld	hl,0	;const
	push	hl
	call	sp_UpdateNowEx
	pop	bc
;}
	C_LINE	69,"my/fixed_screens.h::dr::1::50"
	ret


;void game_over (void) {
	C_LINE	71,"my/fixed_screens.h::dr::0::50"
	C_LINE	71,"my/fixed_screens.h::dr::0::50"

; Function game_over flags 0x00000200 __smallc 
; void game_over()
	C_LINE	71,"my/fixed_screens.h::game_over::0::50"
._game_over
	C_LINE	71,"my/fixed_screens.h::game_over::0::50"
;	 
	C_LINE	72,"my/fixed_screens.h::game_over::1::51"
;	validate ();
	C_LINE	73,"my/fixed_screens.h::game_over::1::51"
	C_LINE	73,"my/fixed_screens.h::game_over::1::51"
	call	_validate
;	gen_pt = (unsigned char *) (" GAME UNDER "); dr ();
	C_LINE	74,"my/fixed_screens.h::game_over::1::51"
	C_LINE	74,"my/fixed_screens.h::game_over::1::51"
	ld	hl,i_1+116
	ld	(_gen_pt),hl
	call	_dr
;	
	C_LINE	76,"my/fixed_screens.h::game_over::1::51"
;		rda = 7; rdb = 2;
	C_LINE	78,"my/fixed_screens.h::game_over::1::51"
	C_LINE	78,"my/fixed_screens.h::game_over::1::51"
	ld	a,7
	ld	(_rda),a
	ld	hl,2	;const
	ld	a,l
	ld	(_rdb),a
;		lame_sound ();
	C_LINE	79,"my/fixed_screens.h::game_over::1::51"
	C_LINE	79,"my/fixed_screens.h::game_over::1::51"
	call	_lame_sound
;	
	C_LINE	80,"my/fixed_screens.h::game_over::1::51"
;	if (level > 0) {
	C_LINE	82,"my/fixed_screens.h::game_over::1::51"
	C_LINE	82,"my/fixed_screens.h::game_over::1::51"
	ld	hl,(_level)
	ld	h,0
	xor	a
	sub	l
	jp	nc,i_64	;
;		 
	C_LINE	83,"my/fixed_screens.h::game_over::2::52"
;		_x = 10; _y = 15; _t = 79; _gp_gen = spacer; print_str ();
	C_LINE	84,"my/fixed_screens.h::game_over::2::52"
	C_LINE	84,"my/fixed_screens.h::game_over::2::52"
	ld	a,10
	ld	(__x),a
	ld	a,15
	ld	(__y),a
	ld	a,79
	ld	(__t),a
	ld	hl,(_spacer)
	ld	(__gp_gen),hl
	call	_print_str
;		
	C_LINE	85,"my/fixed_screens.h::game_over::2::52"
;			_x = 10; _y = 16;        ; _gp_gen = (unsigned char *)("  CONTINUE  "); print_str ();
	C_LINE	89,"my/fixed_screens.h::game_over::2::52"
	C_LINE	89,"my/fixed_screens.h::game_over::2::52"
	ld	a,10
	ld	(__x),a
	ld	a,16
	ld	(__y),a
	ld	hl,i_1+129
	ld	(__gp_gen),hl
	call	_print_str
;			_x = 10; _y = 17;        ; _gp_gen = (unsigned char *)(" 1-YES 2-NO "); print_str ();
	C_LINE	90,"my/fixed_screens.h::game_over::2::52"
	C_LINE	90,"my/fixed_screens.h::game_over::2::52"
	ld	a,10
	ld	(__x),a
	ld	a,17
	ld	(__y),a
	ld	hl,i_1+142
	ld	(__gp_gen),hl
	call	_print_str
;		
	C_LINE	91,"my/fixed_screens.h::game_over::2::52"
;		_x = 10; _y = 18;        ; _gp_gen = spacer; print_str ();
	C_LINE	92,"my/fixed_screens.h::game_over::2::52"
	C_LINE	92,"my/fixed_screens.h::game_over::2::52"
	ld	a,10
	ld	(__x),a
	ld	a,18
	ld	(__y),a
	ld	hl,(_spacer)
	ld	(__gp_gen),hl
	call	_print_str
;		sp_UpdateNow ();
	C_LINE	93,"my/fixed_screens.h::game_over::2::52"
	C_LINE	93,"my/fixed_screens.h::game_over::2::52"
	call	sp_UpdateNow
;		while (1) {
	C_LINE	95,"my/fixed_screens.h::game_over::2::52"
	C_LINE	95,"my/fixed_screens.h::game_over::2::52"
.i_65
;			gpit = sp_GetKey ();
	C_LINE	96,"my/fixed_screens.h::game_over::3::53"
	C_LINE	96,"my/fixed_screens.h::game_over::3::53"
	call	sp_GetKey
	ld	h,0
	ld	a,l
	ld	(_gpit),a
;			if (gpit == '1') {
	C_LINE	97,"my/fixed_screens.h::game_over::3::53"
	C_LINE	97,"my/fixed_screens.h::game_over::3::53"
	ld	hl,(_gpit)
	ld	h,0
	ld	de,49
	and	a
	sbc	hl,de
	jp	nz,i_67	;
;				current_level = level;
	C_LINE	98,"my/fixed_screens.h::game_over::4::54"
	C_LINE	98,"my/fixed_screens.h::game_over::4::54"
	ld	hl,(_level)
	ld	h,0
	ld	a,l
	ld	(_current_level),a
;				do_continue = 1;
	C_LINE	99,"my/fixed_screens.h::game_over::4::54"
	C_LINE	99,"my/fixed_screens.h::game_over::4::54"
	ld	hl,1	;const
	ld	a,l
	ld	(_do_continue),a
;				break;
	C_LINE	100,"my/fixed_screens.h::game_over::4::54"
	C_LINE	100,"my/fixed_screens.h::game_over::4::54"
	jp	i_66	;EOS
;			}
	C_LINE	101,"my/fixed_screens.h::game_over::4::54"
;			if (gpit == '2') break;
	C_LINE	102,"my/fixed_screens.h::game_over::3::54"
.i_67
	C_LINE	102,"my/fixed_screens.h::game_over::3::54"
	ld	hl,(_gpit)
	ld	h,0
	ld	de,50
	and	a
	sbc	hl,de
	jp	nz,i_68	;
	jp	i_66	;EOS
;		}
	C_LINE	103,"my/fixed_screens.h::game_over::3::54"
	jp	i_65	;EOS
	defc	i_68 = i_65
.i_66
;	}	
	C_LINE	104,"my/fixed_screens.h::game_over::2::54"
;}
	C_LINE	105,"my/fixed_screens.h::game_over::1::54"
.i_64
	ret


;	void zone_clear (void) {
	C_LINE	131,"my/fixed_screens.h::game_over::0::54"
	C_LINE	131,"my/fixed_screens.h::game_over::0::54"

; Function zone_clear flags 0x00000200 __smallc 
; void zone_clear()
	C_LINE	131,"my/fixed_screens.h::zone_clear::0::54"
._zone_clear
	C_LINE	131,"my/fixed_screens.h::zone_clear::0::54"
;		validate ();
	C_LINE	132,"my/fixed_screens.h::zone_clear::1::55"
	C_LINE	132,"my/fixed_screens.h::zone_clear::1::55"
	call	_validate
;		
	C_LINE	133,"my/fixed_screens.h::zone_clear::1::55"
;			gen_pt = (unsigned char *) (" ZONE CLEAR "); dr ();
	C_LINE	136,"my/fixed_screens.h::zone_clear::1::55"
	C_LINE	136,"my/fixed_screens.h::zone_clear::1::55"
	ld	hl,i_1+155
	ld	(_gen_pt),hl
	call	_dr
;		
	C_LINE	137,"my/fixed_screens.h::zone_clear::1::55"
;		espera_activa (250);			
	C_LINE	138,"my/fixed_screens.h::zone_clear::1::55"
	C_LINE	138,"my/fixed_screens.h::zone_clear::1::55"
;250;
	C_LINE	139,"my/fixed_screens.h::zone_clear::1::55"
	ld	hl,250	;const
	push	hl
	call	_espera_activa
	pop	bc
;	}
	C_LINE	139,"my/fixed_screens.h::zone_clear::1::55"
	ret


;#line 77 "engine.h"
	C_LINE	141,"my/fixed_screens.h::zone_clear::0::55"
	C_LINE	76,"engine.h::zone_clear::0::55"
;signed int addsign (signed int n, signed int value) {
	C_LINE	78,"engine.h::zone_clear::0::55"
	C_LINE	78,"engine.h::zone_clear::0::55"

; Function addsign flags 0x00000200 __smallc 
; int addsign(int n, int value)
; parameter 'int value' at sp+2 size(2)
; parameter 'int n' at sp+4 size(2)
	C_LINE	78,"engine.h::addsign::0::55"
._addsign
	C_LINE	78,"engine.h::addsign::0::55"
;	if (n >= 0) return value; else return -value;
	C_LINE	79,"engine.h::addsign::1::56"
	C_LINE	79,"engine.h::addsign::1::56"
	ld	hl,4	;const
	call	l_gintsp	;
	ld	a,h
	rla
	ccf
	jp	nc,i_69	;
	pop	bc
	pop	hl
	push	hl
	push	bc
	ret


.i_69
	pop	bc
	pop	hl
	push	hl
	push	bc
	call	l_neg
	ret


.i_70
;}
	C_LINE	80,"engine.h::addsign::1::56"
	ret


;void espera_activa (int espera) {
	C_LINE	86,"engine.h::addsign::0::56"
	C_LINE	86,"engine.h::addsign::0::56"

; Function espera_activa flags 0x00000200 __smallc 
; void espera_activa(int espera)
; parameter 'int espera' at sp+2 size(2)
	C_LINE	86,"engine.h::espera_activa::0::56"
._espera_activa
	C_LINE	86,"engine.h::espera_activa::0::56"
;	while (sp_GetKey ());
	C_LINE	87,"engine.h::espera_activa::1::57"
	C_LINE	87,"engine.h::espera_activa::1::57"
.i_71
	call	sp_GetKey
	ld	a,h
	or	l
	jp	nz,i_71	;EOS
.i_72
;	do {
	C_LINE	88,"engine.h::espera_activa::1::57"
	C_LINE	88,"engine.h::espera_activa::1::57"
.i_75
;		
	C_LINE	89,"engine.h::espera_activa::2::58"
;			gpjt = 250; do { gpit = 1; } while (--gpjt);
	C_LINE	90,"engine.h::espera_activa::2::58"
	C_LINE	90,"engine.h::espera_activa::2::58"
	ld	a,250
	ld	(_gpjt),a
.i_78
	ld	a,1
	ld	(_gpit),a
.i_76
	ld	hl,_gpjt
	dec	(hl)
	ld	l,(hl)
	ld	a,l
	and	a
	jp	nz,i_78	;EOS
.i_77
;		
	C_LINE	91,"engine.h::espera_activa::2::59"
;		if (sp_GetKey ()) break;
	C_LINE	96,"engine.h::espera_activa::2::59"
	C_LINE	96,"engine.h::espera_activa::2::59"
	call	sp_GetKey
	ld	a,h
	or	l
	jp	z,i_79	;
	jp	i_74	;EOS
;	} while (--espera);
	C_LINE	97,"engine.h::espera_activa::2::59"
.i_79
.i_73
	pop	de
	pop	hl
	dec	hl
	push	hl
	push	de
	ld	a,h
	or	l
	jp	nz,i_75	;EOS
.i_74
;}
	C_LINE	98,"engine.h::espera_activa::1::59"
	ret


; 
	C_LINE	123,"engine.h::espera_activa::0::59"
; 
	C_LINE	124,"engine.h::espera_activa::0::59"
;	void process_tile (void) {
	C_LINE	129,"engine.h::espera_activa::0::59"
	C_LINE	129,"engine.h::espera_activa::0::59"

; Function process_tile flags 0x00000200 __smallc 
; void process_tile()
	C_LINE	129,"engine.h::process_tile::0::59"
._process_tile
	C_LINE	129,"engine.h::process_tile::0::59"
;		
	C_LINE	130,"engine.h::process_tile::1::60"
;			
	C_LINE	131,"engine.h::process_tile::1::60"
;				if ((pad0 &  0x80 ) == 0)				
	C_LINE	132,"engine.h::process_tile::1::60"
	C_LINE	132,"engine.h::process_tile::1::60"
	ld	hl,(_pad0)
	ld	h,0
	ld	a,128
	and	l
	ld	l,a
	jr	nz,ASMPC+3
	scf
	jp	nc,i_80	;
;			
	C_LINE	133,"engine.h::process_tile::1::60"
;			{ 
	C_LINE	134,"engine.h::process_tile::1::60"
	C_LINE	134,"engine.h::process_tile::1::60"
;				
	C_LINE	135,"engine.h::process_tile::2::61"
;					 
	C_LINE	136,"engine.h::process_tile::2::61"
;					 
	C_LINE	137,"engine.h::process_tile::2::61"
;					p_disparando = 1;
	C_LINE	138,"engine.h::process_tile::2::61"
	C_LINE	138,"engine.h::process_tile::2::61"
	ld	hl,1	;const
	ld	a,l
	ld	(_p_disparando),a
;				
	C_LINE	139,"engine.h::process_tile::2::61"
;				if (qtile (x0, y0) == 14 && attr (x1, y1) == 0 && x1 < 15 && y1 < 10) {
	C_LINE	141,"engine.h::process_tile::2::61"
	C_LINE	141,"engine.h::process_tile::2::61"
;x0;
	C_LINE	142,"engine.h::process_tile::2::61"
	ld	hl,(_x0)
	ld	h,0
	push	hl
;y0;
	C_LINE	142,"engine.h::process_tile::2::61"
	ld	hl,(_y0)
	ld	h,0
	push	hl
	call	_qtile
	pop	bc
	pop	bc
	ld	a,l
	cp	14
	jp	nz,i_82	;
;x1;
	C_LINE	142,"engine.h::process_tile::2::61"
	ld	hl,(_x1)
	ld	h,0
	push	hl
;y1;
	C_LINE	142,"engine.h::process_tile::2::61"
	ld	hl,(_y1)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	a,l
	and	a
	jp	nz,i_82	;
	ld	a,(_x1)
	sub	15
	jp	nc,i_82	;
	ld	a,(_y1)
	sub	10
	jp	nc,i_82	;
	defc	i_82 = i_81
.i_83_i_82
;					rda = map_buff [ (( x1 )+( y1 <<4)-( y1 )) ];
	C_LINE	142,"engine.h::process_tile::3::62"
	C_LINE	142,"engine.h::process_tile::3::62"
	ld	hl,_map_buff
	push	hl
	ld	hl,(_x1)
	ld	h,0
	push	hl
	ld	hl,(_y1)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,(_y1)
	ld	h,0
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rda),a
;					
	C_LINE	143,"engine.h::process_tile::3::62"
;					
	C_LINE	144,"engine.h::process_tile::3::62"
;					
	C_LINE	149,"engine.h::process_tile::3::62"
;					 
	C_LINE	150,"engine.h::process_tile::3::62"
;					_x = x0; _y = y0; _t = 0; _n = 0; update_tile ();
	C_LINE	151,"engine.h::process_tile::3::62"
	C_LINE	151,"engine.h::process_tile::3::62"
	ld	a,(_x0)
	ld	(__x),a
	ld	a,(_y0)
	ld	(__y),a
	xor	a
	ld	(__t),a
	ld	hl,0	;const
	ld	a,l
	ld	(__n),a
	call	_update_tile
;					_x = x1; _y = y1; _t = 14; _n = 10; update_tile ();
	C_LINE	152,"engine.h::process_tile::3::62"
	C_LINE	152,"engine.h::process_tile::3::62"
	ld	a,(_x1)
	ld	(__x),a
	ld	a,(_y1)
	ld	(__y),a
	ld	a,14
	ld	(__t),a
	ld	hl,10	;const
	ld	a,l
	ld	(__n),a
	call	_update_tile
;					
	C_LINE	153,"engine.h::process_tile::3::62"
;					 
	C_LINE	154,"engine.h::process_tile::3::62"
;					
	C_LINE	155,"engine.h::process_tile::3::62"
;						beep_fx (2);	
	C_LINE	158,"engine.h::process_tile::3::62"
	C_LINE	158,"engine.h::process_tile::3::62"
;2;
	C_LINE	159,"engine.h::process_tile::3::62"
	ld	hl,2	;const
	push	hl
	call	_beep_fx
	pop	bc
;					
	C_LINE	159,"engine.h::process_tile::3::62"
;				
	C_LINE	160,"engine.h::process_tile::3::62"
;					
	C_LINE	161,"engine.h::process_tile::3::62"
; 
	C_LINE	162,"engine.h::process_tile::3::62"
;					#line 1 "my/ci/on_tile_pushed.h"
	C_LINE	168,"engine.h::process_tile::3::62"
	C_LINE	0,"my/ci/on_tile_pushed.h::process_tile::3::62"
; 
	C_LINE	1,"my/ci/on_tile_pushed.h::process_tile::3::62"
; 
	C_LINE	2,"my/ci/on_tile_pushed.h::process_tile::3::62"
;#line 169 "engine.h"
	C_LINE	4,"my/ci/on_tile_pushed.h::process_tile::3::62"
	C_LINE	168,"engine.h::process_tile::3::62"
;				} 
	C_LINE	169,"engine.h::process_tile::3::62"
;			}			
	C_LINE	170,"engine.h::process_tile::2::62"
.i_81
;		
	C_LINE	171,"engine.h::process_tile::1::62"
;		
	C_LINE	173,"engine.h::process_tile::1::62"
;			if (qtile (x0, y0) == 15 && p_keys) {
	C_LINE	174,"engine.h::process_tile::1::62"
.i_80
	C_LINE	174,"engine.h::process_tile::1::62"
;x0;
	C_LINE	175,"engine.h::process_tile::1::62"
	ld	hl,(_x0)
	ld	h,0
	push	hl
;y0;
	C_LINE	175,"engine.h::process_tile::1::62"
	ld	hl,(_y0)
	ld	h,0
	push	hl
	call	_qtile
	pop	bc
	pop	bc
	ld	a,l
	cp	15
	jp	nz,i_85	;
	ld	a,(_p_keys)
	and	a
	jp	z,i_85	;
	defc	i_85 = i_84
.i_86_i_85
;				for (gpit = 0; gpit <  32 ; ++ gpit) {
	C_LINE	175,"engine.h::process_tile::2::63"
	C_LINE	175,"engine.h::process_tile::2::63"
	xor	a
	ld	(_gpit),a
	jp	i_89	;EOS
.i_87
	ld	hl,_gpit
	inc	(hl)
	ld	l,(hl)
	ld	h,0
.i_89
	ld	hl,(_gpit)
	ld	h,0
	ld	a,l
	sub	32
	jp	nc,i_88	;
;					if (cerrojos [gpit].x == x0 && cerrojos [gpit].y == y0 && cerrojos [gpit].np == n_pant) {
	C_LINE	176,"engine.h::process_tile::4::64"
	C_LINE	176,"engine.h::process_tile::4::64"
	ld	hl,_cerrojos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	ld	a,(_x0)
	cp	(hl)
	jp	nz,i_91	;
	ld	hl,_cerrojos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	a,(_y0)
	cp	(hl)
	jp	nz,i_91	;
	ld	hl,_cerrojos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	a,(_n_pant)
	cp	(hl)
	jp	nz,i_91	;
	defc	i_91 = i_90
.i_92_i_91
;						cerrojos [gpit].st = 0;
	C_LINE	177,"engine.h::process_tile::5::65"
	C_LINE	177,"engine.h::process_tile::5::65"
	ld	hl,_cerrojos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	inc	hl
	ld	(hl),0
	ld	l,(hl)
	ld	h,0
;						break;
	C_LINE	178,"engine.h::process_tile::5::65"
	C_LINE	178,"engine.h::process_tile::5::65"
	jp	i_88	;EOS
;					}
	C_LINE	179,"engine.h::process_tile::5::65"
;				}
	C_LINE	180,"engine.h::process_tile::4::65"
	jp	i_87	;EOS
	defc	i_90 = i_87
.i_88
;				_x = x0; _y = y0; _t = 0; _n = 0; update_tile ();
	C_LINE	181,"engine.h::process_tile::2::65"
	C_LINE	181,"engine.h::process_tile::2::65"
	ld	a,(_x0)
	ld	(__x),a
	ld	a,(_y0)
	ld	(__y),a
	xor	a
	ld	(__t),a
	ld	hl,0	;const
	ld	a,l
	ld	(__n),a
	call	_update_tile
;				-- p_keys;
	C_LINE	182,"engine.h::process_tile::2::65"
	C_LINE	182,"engine.h::process_tile::2::65"
	ld	hl,_p_keys
	dec	(hl)
	ld	l,(hl)
	ld	h,0
;		
	C_LINE	183,"engine.h::process_tile::2::65"
;				
	C_LINE	184,"engine.h::process_tile::2::65"
;					beep_fx (8);
	C_LINE	187,"engine.h::process_tile::2::65"
	C_LINE	187,"engine.h::process_tile::2::65"
;8;
	C_LINE	188,"engine.h::process_tile::2::65"
	ld	hl,8	;const
	push	hl
	call	_beep_fx
	pop	bc
;				
	C_LINE	188,"engine.h::process_tile::2::65"
;				#line 1 "my/ci/on_unlocked_bolt.h"
	C_LINE	190,"engine.h::process_tile::2::65"
	C_LINE	0,"my/ci/on_unlocked_bolt.h::process_tile::2::65"
; 
	C_LINE	1,"my/ci/on_unlocked_bolt.h::process_tile::2::65"
; 
	C_LINE	2,"my/ci/on_unlocked_bolt.h::process_tile::2::65"
;#line 191 "engine.h"
	C_LINE	4,"my/ci/on_unlocked_bolt.h::process_tile::2::65"
	C_LINE	190,"engine.h::process_tile::2::65"
;			}
	C_LINE	191,"engine.h::process_tile::2::65"
;		
	C_LINE	192,"engine.h::process_tile::1::65"
;	}
	C_LINE	193,"engine.h::process_tile::1::65"
.i_84
	ret


;void draw_scr_background (void) {
	C_LINE	196,"engine.h::process_tile::0::65"
	C_LINE	196,"engine.h::process_tile::0::65"

; Function draw_scr_background flags 0x00000200 __smallc 
; void draw_scr_background()
	C_LINE	196,"engine.h::draw_scr_background::0::65"
._draw_scr_background
	C_LINE	196,"engine.h::draw_scr_background::0::65"
;	
	C_LINE	197,"engine.h::draw_scr_background::1::66"
;		map_pointer = mapa + (n_pant * 75);
	C_LINE	200,"engine.h::draw_scr_background::1::66"
	C_LINE	200,"engine.h::draw_scr_background::1::66"
	ld	hl,_mapa
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	de,75
	call	l_mult
	pop	de
	add	hl,de
	ld	(_map_pointer),hl
;	
	C_LINE	201,"engine.h::draw_scr_background::1::66"
;		
	C_LINE	202,"engine.h::draw_scr_background::1::66"
;	seed = n_pant;
	C_LINE	203,"engine.h::draw_scr_background::1::66"
	C_LINE	203,"engine.h::draw_scr_background::1::66"
	ld	hl,(_n_pant)
	ld	h,0
	ld	(_seed),hl
;	_x =  1 ; _y =  1 ;
	C_LINE	205,"engine.h::draw_scr_background::1::66"
	C_LINE	205,"engine.h::draw_scr_background::1::66"
	ld	a,1
	ld	(__x),a
	ld	hl,1	;const
	ld	a,l
	ld	(__y),a
;	 
	C_LINE	207,"engine.h::draw_scr_background::1::66"
;	
	C_LINE	208,"engine.h::draw_scr_background::1::66"
;	
	C_LINE	209,"engine.h::draw_scr_background::1::66"
;		for (gpit = 0; gpit < 150; ++ gpit) {	
	C_LINE	212,"engine.h::draw_scr_background::1::66"
	C_LINE	212,"engine.h::draw_scr_background::1::66"
	xor	a
	ld	(_gpit),a
	jp	i_95	;EOS
.i_93
	ld	hl,_gpit
	inc	(hl)
	ld	l,(hl)
	ld	h,0
.i_95
	ld	hl,(_gpit)
	ld	h,0
	ld	a,l
	sub	150
	jp	nc,i_94	;
;			
	C_LINE	213,"engine.h::draw_scr_background::3::67"
; 
	C_LINE	214,"engine.h::draw_scr_background::3::67"
; 
	C_LINE	215,"engine.h::draw_scr_background::3::67"
;				 
	C_LINE	245,"engine.h::draw_scr_background::3::67"
;				 
	C_LINE	246,"engine.h::draw_scr_background::3::67"
;				#asm
	C_LINE	257,"engine.h::draw_scr_background::3::67"
	C_LINE	257,"engine.h::draw_scr_background::3::67"
	C_LINE	259,"engine.h::draw_scr_background::3::67"
						ld  a, (_gpit)
	C_LINE	260,"engine.h::draw_scr_background::3::67"
						and 1
	C_LINE	261,"engine.h::draw_scr_background::3::67"
						jr  nz, _draw_scr_packed_existing
	C_LINE	262,"engine.h::draw_scr_background::3::67"
					._draw_scr_packed_new
	C_LINE	263,"engine.h::draw_scr_background::3::67"
						ld  hl, (_map_pointer)
	C_LINE	264,"engine.h::draw_scr_background::3::67"
						ld  a, (hl)
	C_LINE	265,"engine.h::draw_scr_background::3::67"
						ld  (_gpc), a
	C_LINE	266,"engine.h::draw_scr_background::3::67"
						inc hl
	C_LINE	267,"engine.h::draw_scr_background::3::67"
						ld  (_map_pointer), hl
	C_LINE	269,"engine.h::draw_scr_background::3::67"
						srl a
	C_LINE	270,"engine.h::draw_scr_background::3::67"
						srl a
	C_LINE	271,"engine.h::draw_scr_background::3::67"
						srl a
	C_LINE	272,"engine.h::draw_scr_background::3::67"
						srl a
	C_LINE	273,"engine.h::draw_scr_background::3::67"
						jr  _draw_scr_packed_done
	C_LINE	275,"engine.h::draw_scr_background::3::67"
					._draw_scr_packed_existing
	C_LINE	276,"engine.h::draw_scr_background::3::67"
						ld  a, (_gpc)
	C_LINE	277,"engine.h::draw_scr_background::3::67"
						and 15
	C_LINE	279,"engine.h::draw_scr_background::3::67"
					._draw_scr_packed_done
	C_LINE	280,"engine.h::draw_scr_background::3::67"
						ld  (__t), a
	C_LINE	281,"engine.h::draw_scr_background::3::67"
	C_LINE	282,"engine.h::draw_scr_background::3::67"
						ld  b, 0
	C_LINE	283,"engine.h::draw_scr_background::3::67"
						ld  c, a
	C_LINE	284,"engine.h::draw_scr_background::3::67"
						ld  hl, _behs
	C_LINE	285,"engine.h::draw_scr_background::3::67"
						add hl, bc
	C_LINE	286,"engine.h::draw_scr_background::3::67"
						ld  a, (hl)
	C_LINE	288,"engine.h::draw_scr_background::3::67"
						ld  bc, (_gpit)
	C_LINE	289,"engine.h::draw_scr_background::3::67"
						ld  b, 0
	C_LINE	290,"engine.h::draw_scr_background::3::67"
						ld  hl, _map_attr
	C_LINE	291,"engine.h::draw_scr_background::3::67"
						add hl, bc
	C_LINE	292,"engine.h::draw_scr_background::3::67"
						ld  (hl), a
	C_LINE	294,"engine.h::draw_scr_background::3::67"
										ld  a, (__t)
	C_LINE	295,"engine.h::draw_scr_background::3::67"
						or  a
	C_LINE	296,"engine.h::draw_scr_background::3::67"
						jr  nz, _draw_scr_packed_noalt
	C_LINE	298,"engine.h::draw_scr_background::3::67"
					._draw_scr_packed_alt
	C_LINE	299,"engine.h::draw_scr_background::3::67"
						call _rand
	C_LINE	300,"engine.h::draw_scr_background::3::67"
						ld  a, l
	C_LINE	301,"engine.h::draw_scr_background::3::67"
						and 15
	C_LINE	302,"engine.h::draw_scr_background::3::67"
						cp  1
	C_LINE	303,"engine.h::draw_scr_background::3::67"
						jr  z, _draw_scr_packed_alt_subst
	C_LINE	305,"engine.h::draw_scr_background::3::67"
						ld  a, (__t)
	C_LINE	306,"engine.h::draw_scr_background::3::67"
						jr  _draw_scr_packed_noalt
	C_LINE	308,"engine.h::draw_scr_background::3::67"
					._draw_scr_packed_alt_subst
	C_LINE	309,"engine.h::draw_scr_background::3::67"
						ld  a,  19 
	C_LINE	310,"engine.h::draw_scr_background::3::67"
						ld  (__t), a
	C_LINE	312,"engine.h::draw_scr_background::3::67"
					._draw_scr_packed_noalt
	C_LINE	313,"engine.h::draw_scr_background::3::67"
	C_LINE	315,"engine.h::draw_scr_background::3::67"
						ld  hl, _map_buff
	C_LINE	316,"engine.h::draw_scr_background::3::67"
						add hl, bc
	C_LINE	317,"engine.h::draw_scr_background::3::67"
	C_LINE	318,"engine.h::draw_scr_background::3::67"
						ld  (hl), a
	C_LINE	319,"engine.h::draw_scr_background::3::67"
;			
	C_LINE	321,"engine.h::draw_scr_background::3::67"
;			
	C_LINE	322,"engine.h::draw_scr_background::3::67"
;				 
	C_LINE	323,"engine.h::draw_scr_background::3::67"
;				#asm
	C_LINE	324,"engine.h::draw_scr_background::3::67"
	C_LINE	324,"engine.h::draw_scr_background::3::67"
	C_LINE	326,"engine.h::draw_scr_background::3::67"
						ld  hl, _brk_buff
	C_LINE	327,"engine.h::draw_scr_background::3::67"
						add hl, bc
	C_LINE	328,"engine.h::draw_scr_background::3::67"
						xor a
	C_LINE	329,"engine.h::draw_scr_background::3::67"
						ld  (hl), a
	C_LINE	330,"engine.h::draw_scr_background::3::67"
;			
	C_LINE	332,"engine.h::draw_scr_background::3::67"
;			
	C_LINE	333,"engine.h::draw_scr_background::3::67"
;			draw_coloured_tile ();
	C_LINE	339,"engine.h::draw_scr_background::3::67"
	C_LINE	339,"engine.h::draw_scr_background::3::67"
	call	_draw_coloured_tile
;			 
	C_LINE	341,"engine.h::draw_scr_background::3::67"
;			#asm
	C_LINE	342,"engine.h::draw_scr_background::3::67"
	C_LINE	342,"engine.h::draw_scr_background::3::67"
	C_LINE	344,"engine.h::draw_scr_background::3::67"
					ld  a, (__x)
	C_LINE	345,"engine.h::draw_scr_background::3::67"
					add 2
	C_LINE	346,"engine.h::draw_scr_background::3::67"
					cp  30 +  1 
	C_LINE	347,"engine.h::draw_scr_background::3::67"
					jr  c, _advance_worm_no_inc_y
	C_LINE	349,"engine.h::draw_scr_background::3::67"
					ld  a, (__y)
	C_LINE	350,"engine.h::draw_scr_background::3::67"
					add 2
	C_LINE	351,"engine.h::draw_scr_background::3::67"
					ld  (__y), a
	C_LINE	353,"engine.h::draw_scr_background::3::67"
					ld  a,  1 
	C_LINE	355,"engine.h::draw_scr_background::3::67"
				._advance_worm_no_inc_y
	C_LINE	356,"engine.h::draw_scr_background::3::67"
					ld  (__x), a
	C_LINE	357,"engine.h::draw_scr_background::3::67"
;		}
	C_LINE	359,"engine.h::draw_scr_background::3::67"
	jp	i_93	;EOS
.i_94
;	}
	C_LINE	360,"engine.h::draw_scr_background::1::67"
	ret


;void draw_scr_hotspots_locks (void) {
	C_LINE	362,"engine.h::draw_scr_background::0::67"
	C_LINE	362,"engine.h::draw_scr_background::0::67"

; Function draw_scr_hotspots_locks flags 0x00000200 __smallc 
; void draw_scr_hotspots_locks()
	C_LINE	362,"engine.h::draw_scr_hotspots_locks::0::67"
._draw_scr_hotspots_locks
	C_LINE	362,"engine.h::draw_scr_hotspots_locks::0::67"
;	 
	C_LINE	363,"engine.h::draw_scr_hotspots_locks::1::68"
;	#asm 
	C_LINE	375,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	375,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	377,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  a, 240
	C_LINE	378,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  (_hotspot_y), a
	C_LINE	380,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	381,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	383,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  a, (_n_pant)
	C_LINE	384,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  b, a
	C_LINE	385,"engine.h::draw_scr_hotspots_locks::1::68"
			sla a
	C_LINE	386,"engine.h::draw_scr_hotspots_locks::1::68"
			add b
	C_LINE	388,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  c, a
	C_LINE	389,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  b, 0
	C_LINE	391,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	393,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  hl, _hotspots
	C_LINE	394,"engine.h::draw_scr_hotspots_locks::1::68"
			add hl, bc
	C_LINE	396,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	398,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  a, (hl) 		 
	C_LINE	399,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  b, a
	C_LINE	401,"engine.h::draw_scr_hotspots_locks::1::68"
			srl a
	C_LINE	402,"engine.h::draw_scr_hotspots_locks::1::68"
			srl a
	C_LINE	403,"engine.h::draw_scr_hotspots_locks::1::68"
			srl a
	C_LINE	404,"engine.h::draw_scr_hotspots_locks::1::68"
			srl a
	C_LINE	405,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  (__x), a
	C_LINE	407,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  a, b
	C_LINE	408,"engine.h::draw_scr_hotspots_locks::1::68"
			and 15
	C_LINE	409,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  (__y), a
	C_LINE	411,"engine.h::draw_scr_hotspots_locks::1::68"
			inc hl 				 
	C_LINE	412,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  b, (hl) 		 
	C_LINE	413,"engine.h::draw_scr_hotspots_locks::1::68"
			inc hl 				 
	C_LINE	414,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  c, (hl) 		 
	C_LINE	416,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	418,"engine.h::draw_scr_hotspots_locks::1::68"
			xor a
	C_LINE	419,"engine.h::draw_scr_hotspots_locks::1::68"
			or  b
	C_LINE	420,"engine.h::draw_scr_hotspots_locks::1::68"
			jr  z, _hotspots_setup_done  
	C_LINE	421,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	422,"engine.h::draw_scr_hotspots_locks::1::68"
			xor a
	C_LINE	423,"engine.h::draw_scr_hotspots_locks::1::68"
			or  c
	C_LINE	424,"engine.h::draw_scr_hotspots_locks::1::68"
			jr  z, _hotspots_setup_done
	C_LINE	426,"engine.h::draw_scr_hotspots_locks::1::68"
		._hotspots_setup_do
	C_LINE	427,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  a, (__x)
	C_LINE	428,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  e, a
	C_LINE	429,"engine.h::draw_scr_hotspots_locks::1::68"
			sla a
	C_LINE	430,"engine.h::draw_scr_hotspots_locks::1::68"
			sla a
	C_LINE	431,"engine.h::draw_scr_hotspots_locks::1::68"
			sla a
	C_LINE	432,"engine.h::draw_scr_hotspots_locks::1::68"
			sla a
	C_LINE	433,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  (_hotspot_x), a
	C_LINE	435,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  a, (__y)
	C_LINE	436,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  d, a
	C_LINE	437,"engine.h::draw_scr_hotspots_locks::1::68"
			sla a
	C_LINE	438,"engine.h::draw_scr_hotspots_locks::1::68"
			sla a
	C_LINE	439,"engine.h::draw_scr_hotspots_locks::1::68"
			sla a
	C_LINE	440,"engine.h::draw_scr_hotspots_locks::1::68"
			sla a
	C_LINE	441,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  (_hotspot_y), a
	C_LINE	443,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	444,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	445,"engine.h::draw_scr_hotspots_locks::1::68"
			sub d
	C_LINE	446,"engine.h::draw_scr_hotspots_locks::1::68"
			add e
	C_LINE	448,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  e, a
	C_LINE	449,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  d, 0
	C_LINE	450,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  hl, _map_buff
	C_LINE	451,"engine.h::draw_scr_hotspots_locks::1::68"
			add hl, de
	C_LINE	452,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  a, (hl)
	C_LINE	453,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  (_orig_tile), a
	C_LINE	455,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	456,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  a, b
	C_LINE	457,"engine.h::draw_scr_hotspots_locks::1::68"
			cp  3
	C_LINE	458,"engine.h::draw_scr_hotspots_locks::1::68"
			jp  nz, _hotspots_setup_set
	C_LINE	460,"engine.h::draw_scr_hotspots_locks::1::68"
		._hotspots_setup_set_refill
	C_LINE	461,"engine.h::draw_scr_hotspots_locks::1::68"
			xor a
	C_LINE	462,"engine.h::draw_scr_hotspots_locks::1::68"
		._hotspots_setup_set
	C_LINE	463,"engine.h::draw_scr_hotspots_locks::1::68"
			add 16
	C_LINE	464,"engine.h::draw_scr_hotspots_locks::1::68"
			ld  (__t), a		
	C_LINE	466,"engine.h::draw_scr_hotspots_locks::1::68"
			call _draw_coloured_tile_gamearea
	C_LINE	468,"engine.h::draw_scr_hotspots_locks::1::68"
		._hotspots_setup_done
	C_LINE	469,"engine.h::draw_scr_hotspots_locks::1::68"
;			 
	C_LINE	472,"engine.h::draw_scr_hotspots_locks::1::68"
;		 
	C_LINE	473,"engine.h::draw_scr_hotspots_locks::1::68"
;		#asm
	C_LINE	484,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	484,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	486,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	487,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  hl, _cerrojos
	C_LINE	488,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  b,  32 
	C_LINE	489,"engine.h::draw_scr_hotspots_locks::1::68"
			._open_locks_loop
	C_LINE	490,"engine.h::draw_scr_hotspots_locks::1::68"
				push bc
	C_LINE	491,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	492,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  a, (_n_pant)
	C_LINE	493,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  c, a
	C_LINE	495,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  b, (hl)			 
	C_LINE	496,"engine.h::draw_scr_hotspots_locks::1::68"
				inc hl
	C_LINE	498,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  d, (hl) 		 
	C_LINE	499,"engine.h::draw_scr_hotspots_locks::1::68"
				inc hl
	C_LINE	501,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  e, (hl)			 
	C_LINE	502,"engine.h::draw_scr_hotspots_locks::1::68"
				inc hl
	C_LINE	504,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  a, (hl)			 
	C_LINE	505,"engine.h::draw_scr_hotspots_locks::1::68"
				inc hl
	C_LINE	507,"engine.h::draw_scr_hotspots_locks::1::68"
				or  a
	C_LINE	508,"engine.h::draw_scr_hotspots_locks::1::68"
				jr  nz, _open_locks_done
	C_LINE	510,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  a, b
	C_LINE	511,"engine.h::draw_scr_hotspots_locks::1::68"
				cp  c
	C_LINE	512,"engine.h::draw_scr_hotspots_locks::1::68"
				jr  nz, _open_locks_done
	C_LINE	513,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	514,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	515,"engine.h::draw_scr_hotspots_locks::1::68"
							ld  a, b
	C_LINE	516,"engine.h::draw_scr_hotspots_locks::1::68"
				or  d
	C_LINE	517,"engine.h::draw_scr_hotspots_locks::1::68"
				or  e
	C_LINE	518,"engine.h::draw_scr_hotspots_locks::1::68"
				jr  z, _open_locks_done				
	C_LINE	519,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	521,"engine.h::draw_scr_hotspots_locks::1::68"
			._open_locks_do
	C_LINE	522,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  a, d
	C_LINE	523,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  (__x), a
	C_LINE	524,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  a, e
	C_LINE	525,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  (__y), a
	C_LINE	526,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	527,"engine.h::draw_scr_hotspots_locks::1::68"
				sla a
	C_LINE	528,"engine.h::draw_scr_hotspots_locks::1::68"
				sla a
	C_LINE	529,"engine.h::draw_scr_hotspots_locks::1::68"
				sla a
	C_LINE	530,"engine.h::draw_scr_hotspots_locks::1::68"
				sla a
	C_LINE	531,"engine.h::draw_scr_hotspots_locks::1::68"
				sub e
	C_LINE	532,"engine.h::draw_scr_hotspots_locks::1::68"
				add d
	C_LINE	534,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  b, 0
	C_LINE	535,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  c, a
	C_LINE	536,"engine.h::draw_scr_hotspots_locks::1::68"
				xor a
	C_LINE	537,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	538,"engine.h::draw_scr_hotspots_locks::1::68"
				push hl 			 
	C_LINE	539,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	540,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  hl, _map_attr
	C_LINE	541,"engine.h::draw_scr_hotspots_locks::1::68"
				add hl, bc
	C_LINE	542,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  (hl), a
	C_LINE	543,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  hl, _map_buff
	C_LINE	544,"engine.h::draw_scr_hotspots_locks::1::68"
				add hl, bc
	C_LINE	545,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  (hl), a
	C_LINE	547,"engine.h::draw_scr_hotspots_locks::1::68"
				ld  (__t), a
	C_LINE	549,"engine.h::draw_scr_hotspots_locks::1::68"
				call _draw_coloured_tile_gamearea
	C_LINE	551,"engine.h::draw_scr_hotspots_locks::1::68"
				pop hl
	C_LINE	553,"engine.h::draw_scr_hotspots_locks::1::68"
			._open_locks_done
	C_LINE	554,"engine.h::draw_scr_hotspots_locks::1::68"
	C_LINE	555,"engine.h::draw_scr_hotspots_locks::1::68"
				pop bc
	C_LINE	556,"engine.h::draw_scr_hotspots_locks::1::68"
				dec b
	C_LINE	557,"engine.h::draw_scr_hotspots_locks::1::68"
				jr  nz, _open_locks_loop
	C_LINE	558,"engine.h::draw_scr_hotspots_locks::1::68"
;	}
	C_LINE	560,"engine.h::draw_scr_hotspots_locks::1::68"
	ret


;void draw_scr (void) {
	C_LINE	562,"engine.h::draw_scr_hotspots_locks::0::68"
	C_LINE	562,"engine.h::draw_scr_hotspots_locks::0::68"

; Function draw_scr flags 0x00000200 __smallc 
; void draw_scr()
	C_LINE	562,"engine.h::draw_scr::0::68"
._draw_scr
	C_LINE	562,"engine.h::draw_scr::0::68"
;	is_rendering = 1;
	C_LINE	563,"engine.h::draw_scr::1::69"
	C_LINE	563,"engine.h::draw_scr::1::69"
	ld	hl,1	;const
	ld	a,l
	ld	(_is_rendering),a
;	
	C_LINE	565,"engine.h::draw_scr::1::69"
;	
	C_LINE	569,"engine.h::draw_scr::1::69"
;	draw_scr_background ();
	C_LINE	573,"engine.h::draw_scr::1::69"
	C_LINE	573,"engine.h::draw_scr::1::69"
	call	_draw_scr_background
;	 
	C_LINE	575,"engine.h::draw_scr::1::69"
;	enems_load ();
	C_LINE	577,"engine.h::draw_scr::1::69"
	C_LINE	577,"engine.h::draw_scr::1::69"
	call	_enems_load
;	
	C_LINE	579,"engine.h::draw_scr::1::69"
; 
	C_LINE	583,"engine.h::draw_scr::1::69"
; 
	C_LINE	584,"engine.h::draw_scr::1::69"
; 
	C_LINE	585,"engine.h::draw_scr::1::69"
;	#line 1 "my/ci/entering_screen.h"
	C_LINE	588,"engine.h::draw_scr::1::69"
	C_LINE	0,"my/ci/entering_screen.h::draw_scr::1::69"
; 
	C_LINE	1,"my/ci/entering_screen.h::draw_scr::1::69"
; 
	C_LINE	2,"my/ci/entering_screen.h::draw_scr::1::69"
; 
	C_LINE	4,"my/ci/entering_screen.h::draw_scr::1::69"
; 
	C_LINE	6,"my/ci/entering_screen.h::draw_scr::1::69"
;if (flags [1]) {
	C_LINE	8,"my/ci/entering_screen.h::draw_scr::1::69"
	C_LINE	8,"my/ci/entering_screen.h::draw_scr::1::69"
	ld	hl,(_flags+1)
	ld	a,l
	and	a
	jp	z,i_96	;
;	_gp_gen = (unsigned char *) ("BOMBS ARE SET! RETURN TO BASE!");
	C_LINE	9,"my/ci/entering_screen.h::draw_scr::2::70"
	C_LINE	9,"my/ci/entering_screen.h::draw_scr::2::70"
	ld	hl,i_1+168
	ld	(__gp_gen),hl
;} else {
	C_LINE	10,"my/ci/entering_screen.h::draw_scr::2::70"
	jp	i_97	;EOS
.i_96
	C_LINE	10,"my/ci/entering_screen.h::draw_scr::1::70"
;	_gp_gen = (unsigned char *) (" SET 5 BOMBS IN EVIL COMPUTER");	
	C_LINE	11,"my/ci/entering_screen.h::draw_scr::2::71"
	C_LINE	11,"my/ci/entering_screen.h::draw_scr::2::71"
	ld	hl,i_1+199
	ld	(__gp_gen),hl
;}
	C_LINE	12,"my/ci/entering_screen.h::draw_scr::2::71"
.i_97
;_x = 1; _y = 0; _t = 71;
	C_LINE	13,"my/ci/entering_screen.h::draw_scr::1::71"
	C_LINE	13,"my/ci/entering_screen.h::draw_scr::1::71"
	ld	a,1
	ld	(__x),a
	xor	a
	ld	(__y),a
	ld	hl,71	;const
	ld	a,l
	ld	(__t),a
;print_str ();
	C_LINE	14,"my/ci/entering_screen.h::draw_scr::1::71"
	C_LINE	14,"my/ci/entering_screen.h::draw_scr::1::71"
	call	_print_str
; 
	C_LINE	16,"my/ci/entering_screen.h::draw_scr::1::71"
;if (n_pant == 0) {
	C_LINE	18,"my/ci/entering_screen.h::draw_scr::1::71"
	C_LINE	18,"my/ci/entering_screen.h::draw_scr::1::71"
	ld	hl,(_n_pant)
	ld	h,0
	ld	a,l
	and	a
	jp	nz,i_98	;
;	_gp_gen = decos_computer; draw_decorations ();
	C_LINE	19,"my/ci/entering_screen.h::draw_scr::2::72"
	C_LINE	19,"my/ci/entering_screen.h::draw_scr::2::72"
	ld	hl,_decos_computer
	ld	(__gp_gen),hl
	call	_draw_decorations
;	if (flags [1]) {
	C_LINE	21,"my/ci/entering_screen.h::draw_scr::2::72"
	C_LINE	21,"my/ci/entering_screen.h::draw_scr::2::72"
	ld	hl,(_flags+1)
	ld	a,l
	and	a
	jp	z,i_99	;
;		_gp_gen = decos_bombs; draw_decorations ();
	C_LINE	22,"my/ci/entering_screen.h::draw_scr::3::73"
	C_LINE	22,"my/ci/entering_screen.h::draw_scr::3::73"
	ld	hl,_decos_bombs
	ld	(__gp_gen),hl
	call	_draw_decorations
;	} else {
	C_LINE	23,"my/ci/entering_screen.h::draw_scr::3::73"
	jp	i_100	;EOS
.i_99
	C_LINE	23,"my/ci/entering_screen.h::draw_scr::2::73"
;		_gp_gen = (unsigned char *) (" SET BOMBS IN EVIL COMPUTER ");
	C_LINE	24,"my/ci/entering_screen.h::draw_scr::3::74"
	C_LINE	24,"my/ci/entering_screen.h::draw_scr::3::74"
	ld	hl,i_1+229
	ld	(__gp_gen),hl
;		_x = 1; _y = 0; _t = 71;
	C_LINE	25,"my/ci/entering_screen.h::draw_scr::3::74"
	C_LINE	25,"my/ci/entering_screen.h::draw_scr::3::74"
	ld	a,1
	ld	(__x),a
	xor	a
	ld	(__y),a
	ld	hl,71	;const
	ld	a,l
	ld	(__t),a
;		print_str ();
	C_LINE	26,"my/ci/entering_screen.h::draw_scr::3::74"
	C_LINE	26,"my/ci/entering_screen.h::draw_scr::3::74"
	call	_print_str
;	}
	C_LINE	27,"my/ci/entering_screen.h::draw_scr::3::74"
.i_100
;}
	C_LINE	28,"my/ci/entering_screen.h::draw_scr::2::74"
; 
	C_LINE	30,"my/ci/entering_screen.h::draw_scr::1::74"
;if (n_pant == 21 && level == 0) {
	C_LINE	32,"my/ci/entering_screen.h::draw_scr::1::74"
.i_98
	C_LINE	32,"my/ci/entering_screen.h::draw_scr::1::74"
	ld	a,(_n_pant)
	cp	21
	jp	nz,i_102	;
	ld	a,(_level)
	and	a
	jp	nz,i_102	;
	defc	i_102 = i_101
.i_103_i_102
;	_gp_gen = decos_moto; draw_decorations ();
	C_LINE	33,"my/ci/entering_screen.h::draw_scr::2::75"
	C_LINE	33,"my/ci/entering_screen.h::draw_scr::2::75"
	ld	hl,_decos_moto
	ld	(__gp_gen),hl
	call	_draw_decorations
;	flags [0] = 1;
	C_LINE	34,"my/ci/entering_screen.h::draw_scr::2::75"
	C_LINE	34,"my/ci/entering_screen.h::draw_scr::2::75"
	ld	hl,_flags
	ld	(hl),1
	ld	l,(hl)
	ld	h,0
;}
	C_LINE	35,"my/ci/entering_screen.h::draw_scr::2::75"
; 
	C_LINE	37,"my/ci/entering_screen.h::draw_scr::1::75"
;if (n_pant == 23 && flags [1]) {
	C_LINE	39,"my/ci/entering_screen.h::draw_scr::1::75"
.i_101
	C_LINE	39,"my/ci/entering_screen.h::draw_scr::1::75"
	ld	a,(_n_pant)
	cp	23
	jp	nz,i_105	;
	ld	a,(_flags+1)
	and	a
	jp	z,i_105	;
	defc	i_105 = i_104
.i_106_i_105
;	beep_fx (0);
	C_LINE	40,"my/ci/entering_screen.h::draw_scr::2::76"
	C_LINE	40,"my/ci/entering_screen.h::draw_scr::2::76"
;0;
	C_LINE	41,"my/ci/entering_screen.h::draw_scr::2::76"
	ld	hl,0	;const
	push	hl
	call	_beep_fx
	pop	bc
;	success = 1;
	C_LINE	41,"my/ci/entering_screen.h::draw_scr::2::76"
	C_LINE	41,"my/ci/entering_screen.h::draw_scr::2::76"
	ld	hl,1	;const
	ld	a,l
	ld	(_success),a
;	playing = 0;
	C_LINE	42,"my/ci/entering_screen.h::draw_scr::2::76"
	C_LINE	42,"my/ci/entering_screen.h::draw_scr::2::76"
	ld	hl,0	;const
	ld	a,l
	ld	(_playing),a
;}
	C_LINE	43,"my/ci/entering_screen.h::draw_scr::2::76"
;#line 589 "engine.h"
	C_LINE	44,"my/ci/entering_screen.h::draw_scr::1::76"
	C_LINE	588,"engine.h::draw_scr::1::76"
;	draw_scr_hotspots_locks ();
	C_LINE	590,"engine.h::draw_scr::1::76"
.i_104
	C_LINE	590,"engine.h::draw_scr::1::76"
	call	_draw_scr_hotspots_locks
;	
	C_LINE	592,"engine.h::draw_scr::1::76"
;		bullets_init ();
	C_LINE	593,"engine.h::draw_scr::1::76"
	C_LINE	593,"engine.h::draw_scr::1::76"
	call	_bullets_init
;	
	C_LINE	594,"engine.h::draw_scr::1::76"
;	
	C_LINE	596,"engine.h::draw_scr::1::76"
;		simple_coco_init ();
	C_LINE	597,"engine.h::draw_scr::1::76"
	C_LINE	597,"engine.h::draw_scr::1::76"
	call	_simple_coco_init
;	
	C_LINE	598,"engine.h::draw_scr::1::76"
;	invalidate_viewport ();
	C_LINE	600,"engine.h::draw_scr::1::76"
	C_LINE	600,"engine.h::draw_scr::1::76"
	call	_invalidate_viewport
;	is_rendering = 0;
	C_LINE	601,"engine.h::draw_scr::1::76"
	C_LINE	601,"engine.h::draw_scr::1::76"
	ld	hl,0	;const
	ld	a,l
	ld	(_is_rendering),a
;}
	C_LINE	602,"engine.h::draw_scr::1::76"
	ret


;void select_joyfunc (void) {
	C_LINE	604,"engine.h::draw_scr::0::76"
	C_LINE	604,"engine.h::draw_scr::0::76"

; Function select_joyfunc flags 0x00000200 __smallc 
; void select_joyfunc()
	C_LINE	604,"engine.h::select_joyfunc::0::76"
._select_joyfunc
	C_LINE	604,"engine.h::select_joyfunc::0::76"
;	
	C_LINE	605,"engine.h::select_joyfunc::1::77"
;		#asm
	C_LINE	607,"engine.h::select_joyfunc::1::77"
	C_LINE	607,"engine.h::select_joyfunc::1::77"
	C_LINE	609,"engine.h::select_joyfunc::1::77"
			; Music generated by beepola
	C_LINE	610,"engine.h::select_joyfunc::1::77"
			call musicstart
	C_LINE	611,"engine.h::select_joyfunc::1::77"
;		
	C_LINE	613,"engine.h::select_joyfunc::1::77"
;	while (1) {
	C_LINE	614,"engine.h::select_joyfunc::1::77"
	C_LINE	614,"engine.h::select_joyfunc::1::77"
.i_107
;		gpjt = sp_GetKey ();
	C_LINE	615,"engine.h::select_joyfunc::2::78"
	C_LINE	615,"engine.h::select_joyfunc::2::78"
	call	sp_GetKey
	ld	h,0
	ld	a,l
	ld	(_gpjt),a
;		if (gpjt >= '1' && gpjt <= '3') {
	C_LINE	616,"engine.h::select_joyfunc::2::78"
	C_LINE	616,"engine.h::select_joyfunc::2::78"
	ld	hl,(_gpjt)
	ld	h,0
	ld	de,49
	ex	de,hl
	call	l_uge
	jp	nc,i_110	;
	ld	a,(_gpjt)
	cp	52
	jp	nc,i_110	;
	defc	i_110 = i_109
.i_111_i_110
;			joyfunc = joyfuncs [gpjt - '1'];
	C_LINE	617,"engine.h::select_joyfunc::3::79"
	C_LINE	617,"engine.h::select_joyfunc::3::79"
	ld	hl,_joyfuncs
	push	hl
	ld	hl,(_gpjt)
	ld	h,0
	ld	bc,-49
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	ld	(_joyfunc),hl
;			
	C_LINE	619,"engine.h::select_joyfunc::3::79"
;			break;
	C_LINE	622,"engine.h::select_joyfunc::3::79"
	C_LINE	622,"engine.h::select_joyfunc::3::79"
	jp	i_108	;EOS
;		}			
	C_LINE	623,"engine.h::select_joyfunc::3::79"
;	}
	C_LINE	624,"engine.h::select_joyfunc::2::79"
	jp	i_107	;EOS
	defc	i_109 = i_107
.i_108
;	
	C_LINE	626,"engine.h::select_joyfunc::1::79"
;}
	C_LINE	631,"engine.h::select_joyfunc::1::79"
	ret


;	unsigned char mons_col_sc_x (void) {
	C_LINE	634,"engine.h::select_joyfunc::0::79"
	C_LINE	634,"engine.h::select_joyfunc::0::79"

; Function mons_col_sc_x flags 0x00000200 __smallc 
; unsigned char mons_col_sc_x()
	C_LINE	634,"engine.h::mons_col_sc_x::0::79"
._mons_col_sc_x
	C_LINE	634,"engine.h::mons_col_sc_x::0::79"
;		
	C_LINE	635,"engine.h::mons_col_sc_x::1::80"
;			cx1 = cx2 = (_en_mx > 0 ? _en_x + 13 : _en_x + 2) >> 4;
	C_LINE	636,"engine.h::mons_col_sc_x::1::80"
	C_LINE	636,"engine.h::mons_col_sc_x::1::80"
	ld	hl,__en_mx
	call	l_gchar
	ld	de,0
	ex	de,hl
	call	l_gt
	jp	nc,i_112	;
	ld	hl,(__en_x)
	ld	h,0
	ld	bc,13
	add	hl,bc
	jp	i_113	;
.i_112
	ld	hl,(__en_x)
	ld	h,0
	inc	hl
	inc	hl
.i_113
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(_cx2),a
	ld	h,0
	ld	a,l
	ld	(_cx1),a
;			cy1 = (_en_y + 7) >> 4; cy2 = (_en_y + 8) >> 4;
	C_LINE	637,"engine.h::mons_col_sc_x::1::80"
	C_LINE	637,"engine.h::mons_col_sc_x::1::80"
	ld	hl,(__en_y)
	ld	h,0
	ld	bc,7
	add	hl,bc
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(_cy1),a
	ld	hl,(__en_y)
	ld	h,0
	ld	bc,8
	add	hl,bc
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(_cy2),a
;		
	C_LINE	638,"engine.h::mons_col_sc_x::1::80"
;		cm_two_points ();
	C_LINE	642,"engine.h::mons_col_sc_x::1::80"
	C_LINE	642,"engine.h::mons_col_sc_x::1::80"
	call	_cm_two_points
;		
	C_LINE	643,"engine.h::mons_col_sc_x::1::80"
;			return (at1 || at2);
	C_LINE	644,"engine.h::mons_col_sc_x::1::80"
	C_LINE	644,"engine.h::mons_col_sc_x::1::80"
	ld	a,(_at1)
	and	a
	jp	nz,i_114	;
	ld	a,(_at2)
	and	a
	jp	nz,i_114	;
	ld	hl,0	;const
	jr	i_115
.i_114
	ld	hl,1	;const
.i_115
	ld	h,0
	ret


;		
	C_LINE	645,"engine.h::mons_col_sc_x::1::80"
;	}
	C_LINE	648,"engine.h::mons_col_sc_x::1::80"
;		
	C_LINE	649,"engine.h::mons_col_sc_x::0::80"
;	unsigned char mons_col_sc_y (void) {
	C_LINE	650,"engine.h::mons_col_sc_x::0::80"
	C_LINE	650,"engine.h::mons_col_sc_x::0::80"

; Function mons_col_sc_y flags 0x00000200 __smallc 
; unsigned char mons_col_sc_y()
	C_LINE	650,"engine.h::mons_col_sc_y::0::80"
._mons_col_sc_y
	C_LINE	650,"engine.h::mons_col_sc_y::0::80"
;		
	C_LINE	651,"engine.h::mons_col_sc_y::1::81"
;			cy1 = cy2 = (_en_my > 0 ? _en_y + 8 : _en_y + 7) >> 4;
	C_LINE	652,"engine.h::mons_col_sc_y::1::81"
	C_LINE	652,"engine.h::mons_col_sc_y::1::81"
	ld	hl,__en_my
	call	l_gchar
	ld	de,0
	ex	de,hl
	call	l_gt
	jp	nc,i_116	;
	ld	hl,(__en_y)
	ld	h,0
	ld	bc,8
	add	hl,bc
	jp	i_117	;
.i_116
	ld	hl,(__en_y)
	ld	h,0
	ld	bc,7
	add	hl,bc
.i_117
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(_cy2),a
	ld	h,0
	ld	a,l
	ld	(_cy1),a
;			cx1 = (_en_x + 2) >> 4; cx2 = (_en_x + 13) >> 4;
	C_LINE	653,"engine.h::mons_col_sc_y::1::81"
	C_LINE	653,"engine.h::mons_col_sc_y::1::81"
	ld	hl,(__en_x)
	ld	h,0
	inc	hl
	inc	hl
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(_cx1),a
	ld	hl,(__en_x)
	ld	h,0
	ld	bc,13
	add	hl,bc
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(_cx2),a
;		
	C_LINE	654,"engine.h::mons_col_sc_y::1::81"
;		cm_two_points ();
	C_LINE	658,"engine.h::mons_col_sc_y::1::81"
	C_LINE	658,"engine.h::mons_col_sc_y::1::81"
	call	_cm_two_points
;		
	C_LINE	659,"engine.h::mons_col_sc_y::1::81"
;			return (at1 || at2);
	C_LINE	660,"engine.h::mons_col_sc_y::1::81"
	C_LINE	660,"engine.h::mons_col_sc_y::1::81"
	ld	a,(_at1)
	and	a
	jp	nz,i_118	;
	ld	a,(_at2)
	and	a
	jp	nz,i_118	;
	ld	hl,0	;const
	jr	i_119
.i_118
	ld	hl,1	;const
.i_119
	ld	h,0
	ret


;		
	C_LINE	661,"engine.h::mons_col_sc_y::1::81"
;	}
	C_LINE	664,"engine.h::mons_col_sc_y::1::81"
; 
	C_LINE	672,"engine.h::mons_col_sc_y::0::81"
;#line 134 "mk1.c"
	C_LINE	688,"engine.h::mons_col_sc_y::0::81"
	C_LINE	133,"mk1.c::mons_col_sc_y::0::81"
;#line 1 "engine/player.h"
	C_LINE	134,"mk1.c::mons_col_sc_y::0::81"
	C_LINE	0,"engine/player.h::mons_col_sc_y::0::81"
; 
	C_LINE	1,"engine/player.h::mons_col_sc_y::0::81"
; 
	C_LINE	2,"engine/player.h::mons_col_sc_y::0::81"
; 
	C_LINE	4,"engine/player.h::mons_col_sc_y::0::81"
;void player_init (void) {
	C_LINE	6,"engine/player.h::mons_col_sc_y::0::81"
	C_LINE	6,"engine/player.h::mons_col_sc_y::0::81"

; Function player_init flags 0x00000200 __smallc 
; void player_init()
	C_LINE	6,"engine/player.h::player_init::0::81"
._player_init
	C_LINE	6,"engine/player.h::player_init::0::81"
;	 
	C_LINE	7,"engine/player.h::player_init::1::82"
;	 
	C_LINE	8,"engine/player.h::player_init::1::82"
;		
	C_LINE	9,"engine/player.h::player_init::1::82"
;	
	C_LINE	10,"engine/player.h::player_init::1::82"
;	p_vy = 0;
	C_LINE	14,"engine/player.h::player_init::1::82"
	C_LINE	14,"engine/player.h::player_init::1::82"
	ld	hl,0	;const
	ld	(_p_vy),hl
;	p_vx = 0;
	C_LINE	15,"engine/player.h::player_init::1::82"
	C_LINE	15,"engine/player.h::player_init::1::82"
	ld	hl,0	;const
	ld	(_p_vx),hl
;	p_cont_salto = 1;
	C_LINE	16,"engine/player.h::player_init::1::82"
	C_LINE	16,"engine/player.h::player_init::1::82"
	ld	hl,1	;const
	ld	a,l
	ld	(_p_cont_salto),a
;	p_saltando = 0;
	C_LINE	17,"engine/player.h::player_init::1::82"
	C_LINE	17,"engine/player.h::player_init::1::82"
	ld	hl,0	;const
	ld	a,l
	ld	(_p_saltando),a
;	p_frame = 0;
	C_LINE	18,"engine/player.h::player_init::1::82"
	C_LINE	18,"engine/player.h::player_init::1::82"
	ld	hl,0	;const
	ld	a,l
	ld	(_p_frame),a
;	p_subframe = 0;
	C_LINE	19,"engine/player.h::player_init::1::82"
	C_LINE	19,"engine/player.h::player_init::1::82"
	ld	hl,0	;const
	ld	a,l
	ld	(_p_subframe),a
;	
	C_LINE	20,"engine/player.h::player_init::1::82"
;		p_facing =  6 ;
	C_LINE	21,"engine/player.h::player_init::1::82"
	C_LINE	21,"engine/player.h::player_init::1::82"
	ld	hl,6	;const
	ld	a,l
	ld	(_p_facing),a
;		p_facing_v = p_facing_h = 0xff;
	C_LINE	22,"engine/player.h::player_init::1::82"
	C_LINE	22,"engine/player.h::player_init::1::82"
	ld	hl,255	;const
	ld	a,l
	ld	(_p_facing_h),a
	ld	(_p_facing_v),a
;	
	C_LINE	23,"engine/player.h::player_init::1::82"
;	p_estado = 	 0 ;
	C_LINE	26,"engine/player.h::player_init::1::82"
	C_LINE	26,"engine/player.h::player_init::1::82"
	ld	hl,0	;const
	ld	a,l
	ld	(_p_estado),a
;	p_ct_estado = 0;
	C_LINE	27,"engine/player.h::player_init::1::82"
	C_LINE	27,"engine/player.h::player_init::1::82"
	ld	hl,0	;const
	ld	a,l
	ld	(_p_ct_estado),a
;	
	C_LINE	28,"engine/player.h::player_init::1::82"
;	p_disparando = 0;
	C_LINE	31,"engine/player.h::player_init::1::82"
	C_LINE	31,"engine/player.h::player_init::1::82"
	ld	hl,0	;const
	ld	a,l
	ld	(_p_disparando),a
;	
	C_LINE	32,"engine/player.h::player_init::1::82"
;	
	C_LINE	33,"engine/player.h::player_init::1::82"
;		p_objs = 0;
	C_LINE	34,"engine/player.h::player_init::1::82"
	C_LINE	34,"engine/player.h::player_init::1::82"
	ld	hl,0	;const
	ld	a,l
	ld	(_p_objs),a
;		p_keys = 0;
	C_LINE	35,"engine/player.h::player_init::1::82"
	C_LINE	35,"engine/player.h::player_init::1::82"
	ld	hl,0	;const
	ld	a,l
	ld	(_p_keys),a
;		p_killed = 0;
	C_LINE	36,"engine/player.h::player_init::1::82"
	C_LINE	36,"engine/player.h::player_init::1::82"
	ld	hl,0	;const
	ld	a,l
	ld	(_p_killed),a
;		
	C_LINE	37,"engine/player.h::player_init::1::82"
;			
	C_LINE	38,"engine/player.h::player_init::1::82"
;				p_ammo =  99 ;
	C_LINE	41,"engine/player.h::player_init::1::82"
	C_LINE	41,"engine/player.h::player_init::1::82"
	ld	hl,99	;const
	ld	a,l
	ld	(_p_ammo),a
;			
	C_LINE	42,"engine/player.h::player_init::1::82"
;		
	C_LINE	43,"engine/player.h::player_init::1::82"
;	
	C_LINE	44,"engine/player.h::player_init::1::82"
;	
	C_LINE	46,"engine/player.h::player_init::1::82"
;}
	C_LINE	61,"engine/player.h::player_init::1::82"
	ret


;void player_calc_bounding_box (void) {
	C_LINE	63,"engine/player.h::player_init::0::82"
	C_LINE	63,"engine/player.h::player_init::0::82"

; Function player_calc_bounding_box flags 0x00000200 __smallc 
; void player_calc_bounding_box()
	C_LINE	63,"engine/player.h::player_calc_bounding_box::0::82"
._player_calc_bounding_box
	C_LINE	63,"engine/player.h::player_calc_bounding_box::0::82"
;	
	C_LINE	64,"engine/player.h::player_calc_bounding_box::1::83"
;		#asm
	C_LINE	127,"engine/player.h::player_calc_bounding_box::1::83"
	C_LINE	127,"engine/player.h::player_calc_bounding_box::1::83"
	C_LINE	129,"engine/player.h::player_calc_bounding_box::1::83"
			ld  a, (_gpx)
	C_LINE	130,"engine/player.h::player_calc_bounding_box::1::83"
			add 2
	C_LINE	131,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	132,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	133,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	134,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	135,"engine/player.h::player_calc_bounding_box::1::83"
			ld  (_ptx1), a
	C_LINE	136,"engine/player.h::player_calc_bounding_box::1::83"
			ld  a, (_gpx)
	C_LINE	137,"engine/player.h::player_calc_bounding_box::1::83"
			add 13
	C_LINE	138,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	139,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	140,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	141,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	142,"engine/player.h::player_calc_bounding_box::1::83"
			ld  (_ptx2), a
	C_LINE	143,"engine/player.h::player_calc_bounding_box::1::83"
			ld  a, (_gpy)
	C_LINE	144,"engine/player.h::player_calc_bounding_box::1::83"
			add 7
	C_LINE	145,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	146,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	147,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	148,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	149,"engine/player.h::player_calc_bounding_box::1::83"
			ld  (_pty1), a
	C_LINE	150,"engine/player.h::player_calc_bounding_box::1::83"
			ld  a, (_gpy)
	C_LINE	151,"engine/player.h::player_calc_bounding_box::1::83"
			add 8
	C_LINE	152,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	153,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	154,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	155,"engine/player.h::player_calc_bounding_box::1::83"
			srl a
	C_LINE	156,"engine/player.h::player_calc_bounding_box::1::83"
			ld  (_pty2), a
	C_LINE	157,"engine/player.h::player_calc_bounding_box::1::83"
;	
	C_LINE	159,"engine/player.h::player_calc_bounding_box::1::83"
;}
	C_LINE	187,"engine/player.h::player_calc_bounding_box::1::83"
	ret


;unsigned char player_move (void) {	
	C_LINE	189,"engine/player.h::player_calc_bounding_box::0::83"
	C_LINE	189,"engine/player.h::player_calc_bounding_box::0::83"

; Function player_move flags 0x00000200 __smallc 
; unsigned char player_move()
	C_LINE	189,"engine/player.h::player_move::0::83"
._player_move
	C_LINE	189,"engine/player.h::player_move::0::83"
;		
	C_LINE	190,"engine/player.h::player_move::1::84"
;	 
	C_LINE	191,"engine/player.h::player_move::1::84"
;	 
	C_LINE	192,"engine/player.h::player_move::1::84"
;	 
	C_LINE	193,"engine/player.h::player_move::1::84"
;	
	C_LINE	195,"engine/player.h::player_move::1::84"
; 
	C_LINE	202,"engine/player.h::player_move::1::84"
;	
	C_LINE	255,"engine/player.h::player_move::1::84"
;		
	C_LINE	257,"engine/player.h::player_move::1::84"
;		{
	C_LINE	260,"engine/player.h::player_move::1::84"
	C_LINE	260,"engine/player.h::player_move::1::84"
;			 
	C_LINE	261,"engine/player.h::player_move::2::85"
;			if ( ! ((pad0 &  0x01 ) == 0 || (pad0 &  0x02 ) == 0)) {
	C_LINE	263,"engine/player.h::player_move::2::85"
	C_LINE	263,"engine/player.h::player_move::2::85"
	ld	hl,(_pad0)
	ld	h,0
	ld	a,1
	and	l
	ld	l,a
	jp	z,i_121	;
	ld	hl,(_pad0)
	ld	h,0
	ld	a,2
	and	l
	ld	l,a
	jp	z,i_121	;
	ld	hl,0	;const
	jr	i_122
.i_121
	ld	hl,1	;const
.i_122
	call	l_lneg
	jp	nc,i_120	;
;				p_facing_v = 0xff;
	C_LINE	264,"engine/player.h::player_move::3::86"
	C_LINE	264,"engine/player.h::player_move::3::86"
	ld	hl,255	;const
	ld	a,l
	ld	(_p_facing_v),a
;				wall_v = 0;
	C_LINE	265,"engine/player.h::player_move::3::86"
	C_LINE	265,"engine/player.h::player_move::3::86"
	ld	hl,0	;const
	ld	a,l
	ld	(_wall_v),a
;				if (p_vy > 0) {
	C_LINE	266,"engine/player.h::player_move::3::86"
	C_LINE	266,"engine/player.h::player_move::3::86"
	ld	hl,(_p_vy)
	ld	de,0
	ex	de,hl
	call	l_gt
	jp	nc,i_123	;
;					p_vy -=  64 ;
	C_LINE	267,"engine/player.h::player_move::4::87"
	C_LINE	267,"engine/player.h::player_move::4::87"
	ld	hl,(_p_vy)
	ld	bc,-64
	add	hl,bc
	ld	(_p_vy),hl
;					if (p_vy < 0) p_vy = 0;
	C_LINE	268,"engine/player.h::player_move::4::87"
	C_LINE	268,"engine/player.h::player_move::4::87"
	ld	hl,(_p_vy)
	ld	a,h
	rla
	jp	nc,i_124	;
	ld	hl,0	;const
	ld	(_p_vy),hl
;				} else if (p_vy < 0) {
	C_LINE	269,"engine/player.h::player_move::4::87"
	jp	i_125	;EOS
	defc	i_124 = i_125
.i_123
	C_LINE	269,"engine/player.h::player_move::3::87"
	ld	hl,(_p_vy)
	ld	a,h
	rla
	jp	nc,i_126	;
;					p_vy +=  64 ;
	C_LINE	270,"engine/player.h::player_move::4::88"
	C_LINE	270,"engine/player.h::player_move::4::88"
	ld	hl,(_p_vy)
	ld	bc,64
	add	hl,bc
	ld	(_p_vy),hl
;					if (p_vy > 0) p_vy = 0;
	C_LINE	271,"engine/player.h::player_move::4::88"
	C_LINE	271,"engine/player.h::player_move::4::88"
	ld	hl,(_p_vy)
	ld	de,0
	ex	de,hl
	call	l_gt
	jp	nc,i_127	;
	ld	hl,0	;const
	ld	(_p_vy),hl
;				}
	C_LINE	272,"engine/player.h::player_move::4::88"
.i_127
;			}
	C_LINE	273,"engine/player.h::player_move::3::88"
.i_126
.i_125
;			if ((pad0 &  0x01 ) == 0) {
	C_LINE	275,"engine/player.h::player_move::2::88"
.i_120
	C_LINE	275,"engine/player.h::player_move::2::88"
	ld	hl,(_pad0)
	ld	h,0
	ld	a,1
	and	l
	ld	l,a
	jr	nz,ASMPC+3
	scf
	jp	nc,i_128	;
;				p_facing_v =  4 ;
	C_LINE	276,"engine/player.h::player_move::3::89"
	C_LINE	276,"engine/player.h::player_move::3::89"
	ld	hl,4	;const
	ld	a,l
	ld	(_p_facing_v),a
;				if (p_vy > - 256 ) p_vy -=  48 ;
	C_LINE	277,"engine/player.h::player_move::3::89"
	C_LINE	277,"engine/player.h::player_move::3::89"
	ld	hl,(_p_vy)
	ld	de,65280
	ex	de,hl
	call	l_gt
	jp	nc,i_129	;
	ld	hl,(_p_vy)
	ld	bc,-48
	add	hl,bc
	ld	(_p_vy),hl
;			}
	C_LINE	278,"engine/player.h::player_move::3::89"
.i_129
;			if ((pad0 &  0x02 ) == 0) {
	C_LINE	280,"engine/player.h::player_move::2::89"
.i_128
	C_LINE	280,"engine/player.h::player_move::2::89"
	ld	hl,(_pad0)
	ld	h,0
	ld	a,2
	and	l
	ld	l,a
	jr	nz,ASMPC+3
	scf
	jp	nc,i_130	;
;				p_facing_v =  6 ;
	C_LINE	281,"engine/player.h::player_move::3::90"
	C_LINE	281,"engine/player.h::player_move::3::90"
	ld	hl,6	;const
	ld	a,l
	ld	(_p_facing_v),a
;				if (p_vy <  256 ) p_vy +=  48 ;
	C_LINE	282,"engine/player.h::player_move::3::90"
	C_LINE	282,"engine/player.h::player_move::3::90"
	ld	hl,(_p_vy)
	ld	a,l
	sub	0
	ld	a,h
	rla
	ccf
	rra
	sbc	129
	jp	nc,i_131	;
	ld	hl,(_p_vy)
	ld	bc,48
	add	hl,bc
	ld	(_p_vy),hl
;			}
	C_LINE	283,"engine/player.h::player_move::3::90"
.i_131
;		}
	C_LINE	284,"engine/player.h::player_move::2::90"
.i_130
;	
	C_LINE	285,"engine/player.h::player_move::1::90"
;	
	C_LINE	287,"engine/player.h::player_move::1::90"
;	#line 1 "./my/ci/custom_veng.h"
	C_LINE	303,"engine/player.h::player_move::1::90"
	C_LINE	0,"./my/ci/custom_veng.h::player_move::1::90"
; 
	C_LINE	1,"./my/ci/custom_veng.h::player_move::1::90"
; 
	C_LINE	2,"./my/ci/custom_veng.h::player_move::1::90"
; 
	C_LINE	4,"./my/ci/custom_veng.h::player_move::1::90"
; 
	C_LINE	5,"./my/ci/custom_veng.h::player_move::1::90"
;#line 304 "engine/player.h"
	C_LINE	6,"./my/ci/custom_veng.h::player_move::1::90"
	C_LINE	303,"engine/player.h::player_move::1::90"
;	p_y += p_vy;
	C_LINE	305,"engine/player.h::player_move::1::90"
	C_LINE	305,"engine/player.h::player_move::1::90"
	ld	de,(_p_y)
	ld	hl,(_p_vy)
	add	hl,de
	ld	(_p_y),hl
;	
	C_LINE	306,"engine/player.h::player_move::1::90"
;	
	C_LINE	307,"engine/player.h::player_move::1::90"
;	 
	C_LINE	311,"engine/player.h::player_move::1::90"
;		
	C_LINE	312,"engine/player.h::player_move::1::90"
;	if (p_y < 0) p_y = 0;
	C_LINE	313,"engine/player.h::player_move::1::90"
	C_LINE	313,"engine/player.h::player_move::1::90"
	ld	hl,(_p_y)
	ld	a,h
	rla
	jp	nc,i_132	;
	ld	hl,0	;const
	ld	(_p_y),hl
;	if (p_y > 9216) p_y = 9216;
	C_LINE	314,"engine/player.h::player_move::1::90"
.i_132
	C_LINE	314,"engine/player.h::player_move::1::90"
	ld	hl,(_p_y)
	ld	de,9216
	ex	de,hl
	call	l_gt
	jp	nc,i_133	;
	ld	hl,9216	;const
	ld	(_p_y),hl
;	gpy = p_y >> 6;
	C_LINE	316,"engine/player.h::player_move::1::90"
.i_133
	C_LINE	316,"engine/player.h::player_move::1::90"
	ld	hl,(_p_y)
	ld	de,6
	call	l_asr_hl_by_e
	ld	h,0
	ld	a,l
	ld	(_gpy),a
;	 
	C_LINE	318,"engine/player.h::player_move::1::90"
;			 
	C_LINE	320,"engine/player.h::player_move::1::90"
;	player_calc_bounding_box ();
	C_LINE	321,"engine/player.h::player_move::1::90"
	C_LINE	321,"engine/player.h::player_move::1::90"
	call	_player_calc_bounding_box
;	hit_v = 0;
	C_LINE	323,"engine/player.h::player_move::1::90"
	C_LINE	323,"engine/player.h::player_move::1::90"
	ld	hl,0	;const
	ld	a,l
	ld	(_hit_v),a
;	cx1 = ptx1; cx2 = ptx2;
	C_LINE	324,"engine/player.h::player_move::1::90"
	C_LINE	324,"engine/player.h::player_move::1::90"
	ld	a,(_ptx1)
	ld	(_cx1),a
	ld	hl,(_ptx2)
	ld	h,0
	ld	a,l
	ld	(_cx2),a
;	
	C_LINE	325,"engine/player.h::player_move::1::90"
;		if (p_vy < 0)
	C_LINE	326,"engine/player.h::player_move::1::90"
	C_LINE	326,"engine/player.h::player_move::1::90"
	ld	hl,(_p_vy)
	ld	a,h
	rla
	jp	nc,i_134	;
;	
	C_LINE	327,"engine/player.h::player_move::1::90"
;	{
	C_LINE	330,"engine/player.h::player_move::1::90"
	C_LINE	330,"engine/player.h::player_move::1::90"
;		cy1 = cy2 = pty1;
	C_LINE	331,"engine/player.h::player_move::2::91"
	C_LINE	331,"engine/player.h::player_move::2::91"
	ld	hl,(_pty1)
	ld	a,l
	ld	(_cy2),a
	ld	(_cy1),a
;		cm_two_points ();
	C_LINE	332,"engine/player.h::player_move::2::91"
	C_LINE	332,"engine/player.h::player_move::2::91"
	call	_cm_two_points
;		if ((at1 & 8) || (at2 & 8)) {
	C_LINE	334,"engine/player.h::player_move::2::91"
	C_LINE	334,"engine/player.h::player_move::2::91"
	ld	a,(_at1)
	and	8
	jp	nz,i_136	;
	ld	a,(_at2)
	and	8
	jp	z,i_135	;
.i_136
;			#line 1 "./my/ci/bg_collision/obstacle_up.h"
	C_LINE	335,"engine/player.h::player_move::3::92"
	C_LINE	0,"./my/ci/bg_collision/obstacle_up.h::player_move::3::92"
; 
	C_LINE	1,"./my/ci/bg_collision/obstacle_up.h::player_move::3::92"
; 
	C_LINE	2,"./my/ci/bg_collision/obstacle_up.h::player_move::3::92"
;#line 336 "engine/player.h"
	C_LINE	3,"./my/ci/bg_collision/obstacle_up.h::player_move::3::92"
	C_LINE	335,"engine/player.h::player_move::3::92"
;			
	C_LINE	337,"engine/player.h::player_move::3::92"
;				p_vy = 0;
	C_LINE	340,"engine/player.h::player_move::3::92"
	C_LINE	340,"engine/player.h::player_move::3::92"
	ld	hl,0	;const
	ld	(_p_vy),hl
;			
	C_LINE	341,"engine/player.h::player_move::3::92"
;			
	C_LINE	343,"engine/player.h::player_move::3::92"
;				gpy = ((pty1 + 1) << 4) - 7;
	C_LINE	348,"engine/player.h::player_move::3::92"
	C_LINE	348,"engine/player.h::player_move::3::92"
	ld	hl,(_pty1)
	ld	h,0
	inc	hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	bc,-7
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_gpy),a
;			
	C_LINE	349,"engine/player.h::player_move::3::92"
;			p_y = gpy << 6;
	C_LINE	355,"engine/player.h::player_move::3::92"
	C_LINE	355,"engine/player.h::player_move::3::92"
	ld	hl,(_gpy)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	(_p_y),hl
;			
	C_LINE	357,"engine/player.h::player_move::3::92"
;				wall_v =  1 ;
	C_LINE	358,"engine/player.h::player_move::3::92"
	C_LINE	358,"engine/player.h::player_move::3::92"
	ld	hl,1	;const
	ld	a,l
	ld	(_wall_v),a
;			
	C_LINE	359,"engine/player.h::player_move::3::92"
;		}
	C_LINE	360,"engine/player.h::player_move::3::92"
;	}
	C_LINE	361,"engine/player.h::player_move::2::92"
.i_135
;	
	C_LINE	362,"engine/player.h::player_move::1::92"
;	
	C_LINE	363,"engine/player.h::player_move::1::92"
;		if (p_vy > 0)
	C_LINE	364,"engine/player.h::player_move::1::92"
.i_134
	C_LINE	364,"engine/player.h::player_move::1::92"
	ld	hl,(_p_vy)
	ld	de,0
	ex	de,hl
	call	l_gt
	jp	nc,i_138	;
;	
	C_LINE	365,"engine/player.h::player_move::1::92"
;	{
	C_LINE	368,"engine/player.h::player_move::1::92"
	C_LINE	368,"engine/player.h::player_move::1::92"
;		cy1 = cy2 = pty2;
	C_LINE	369,"engine/player.h::player_move::2::93"
	C_LINE	369,"engine/player.h::player_move::2::93"
	ld	hl,(_pty2)
	ld	a,l
	ld	(_cy2),a
	ld	(_cy1),a
;		cm_two_points ();
	C_LINE	370,"engine/player.h::player_move::2::93"
	C_LINE	370,"engine/player.h::player_move::2::93"
	call	_cm_two_points
;		
	C_LINE	372,"engine/player.h::player_move::2::93"
;			if ((at1 & 8) || (at2 & 8))
	C_LINE	373,"engine/player.h::player_move::2::93"
	C_LINE	373,"engine/player.h::player_move::2::93"
	ld	a,(_at1)
	and	8
	jp	nz,i_140	;
	ld	a,(_at2)
	and	8
	jp	z,i_139	;
.i_140
;		
	C_LINE	374,"engine/player.h::player_move::2::93"
; 
	C_LINE	375,"engine/player.h::player_move::2::93"
; 
	C_LINE	376,"engine/player.h::player_move::2::93"
; 
	C_LINE	378,"engine/player.h::player_move::2::93"
;		{
	C_LINE	380,"engine/player.h::player_move::2::93"
	C_LINE	380,"engine/player.h::player_move::2::93"
;			#line 1 "./my/ci/bg_collision/obstacle_down.h"
	C_LINE	381,"engine/player.h::player_move::3::94"
	C_LINE	0,"./my/ci/bg_collision/obstacle_down.h::player_move::3::94"
; 
	C_LINE	1,"./my/ci/bg_collision/obstacle_down.h::player_move::3::94"
; 
	C_LINE	2,"./my/ci/bg_collision/obstacle_down.h::player_move::3::94"
;#line 382 "engine/player.h"
	C_LINE	3,"./my/ci/bg_collision/obstacle_down.h::player_move::3::94"
	C_LINE	381,"engine/player.h::player_move::3::94"
;			
	C_LINE	383,"engine/player.h::player_move::3::94"
;				p_vy = 0;
	C_LINE	386,"engine/player.h::player_move::3::94"
	C_LINE	386,"engine/player.h::player_move::3::94"
	ld	hl,0	;const
	ld	(_p_vy),hl
;			
	C_LINE	387,"engine/player.h::player_move::3::94"
;				
	C_LINE	388,"engine/player.h::player_move::3::94"
;			
	C_LINE	389,"engine/player.h::player_move::3::94"
;				gpy = ((pty2 - 1) << 4) + 7;
	C_LINE	392,"engine/player.h::player_move::3::94"
	C_LINE	392,"engine/player.h::player_move::3::94"
	ld	hl,(_pty2)
	ld	h,0
	dec	hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	bc,7
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_gpy),a
;			
	C_LINE	393,"engine/player.h::player_move::3::94"
;			p_y = gpy << 6;
	C_LINE	399,"engine/player.h::player_move::3::94"
	C_LINE	399,"engine/player.h::player_move::3::94"
	ld	hl,(_gpy)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	(_p_y),hl
;			
	C_LINE	400,"engine/player.h::player_move::3::94"
;			
	C_LINE	401,"engine/player.h::player_move::3::94"
;				wall_v =  2 ;
	C_LINE	402,"engine/player.h::player_move::3::94"
	C_LINE	402,"engine/player.h::player_move::3::94"
	ld	hl,2	;const
	ld	a,l
	ld	(_wall_v),a
;			
	C_LINE	403,"engine/player.h::player_move::3::94"
;		}
	C_LINE	404,"engine/player.h::player_move::3::94"
;	}
	C_LINE	405,"engine/player.h::player_move::2::94"
.i_139
;	
	C_LINE	407,"engine/player.h::player_move::1::94"
;		if (p_vy) hit_v = ((at1 & 1) || (at2 & 1));
	C_LINE	408,"engine/player.h::player_move::1::94"
.i_138
	C_LINE	408,"engine/player.h::player_move::1::94"
	ld	hl,(_p_vy)
	ld	a,h
	or	l
	jp	z,i_142	;
	ld	a,(_at1)
	and	1
	jp	nz,i_143	;
	ld	a,(_at2)
	and	1
	jp	nz,i_143	;
	ld	hl,0	;const
	jr	i_144
.i_143
	ld	hl,1	;const
.i_144
	ld	h,0
	ld	a,l
	ld	(_hit_v),a
;	
	C_LINE	409,"engine/player.h::player_move::1::94"
;	
	C_LINE	410,"engine/player.h::player_move::1::94"
;	gpxx = gpx >> 4;
	C_LINE	411,"engine/player.h::player_move::1::94"
.i_142
	C_LINE	411,"engine/player.h::player_move::1::94"
	ld	hl,(_gpx)
	ld	h,0
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(_gpxx),a
;	gpyy = gpy >> 4;
	C_LINE	412,"engine/player.h::player_move::1::94"
	C_LINE	412,"engine/player.h::player_move::1::94"
	ld	hl,(_gpy)
	ld	h,0
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(_gpyy),a
;	
	C_LINE	414,"engine/player.h::player_move::1::94"
;	 
	C_LINE	421,"engine/player.h::player_move::1::94"
;	
	C_LINE	423,"engine/player.h::player_move::1::94"
;	 
	C_LINE	457,"engine/player.h::player_move::1::94"
;	
	C_LINE	459,"engine/player.h::player_move::1::94"
;	 
	C_LINE	484,"engine/player.h::player_move::1::94"
;	 
	C_LINE	485,"engine/player.h::player_move::1::94"
;	 
	C_LINE	486,"engine/player.h::player_move::1::94"
;	
	C_LINE	488,"engine/player.h::player_move::1::94"
;		if ( ! ((pad0 &  0x04 ) == 0 || (pad0 &  0x08 ) == 0)) {
	C_LINE	489,"engine/player.h::player_move::1::94"
	C_LINE	489,"engine/player.h::player_move::1::94"
	ld	hl,(_pad0)
	ld	h,0
	ld	a,4
	and	l
	ld	l,a
	jp	z,i_146	;
	ld	hl,(_pad0)
	ld	h,0
	ld	a,8
	and	l
	ld	l,a
	jp	z,i_146	;
	ld	hl,0	;const
	jr	i_147
.i_146
	ld	hl,1	;const
.i_147
	call	l_lneg
	jp	nc,i_145	;
;			
	C_LINE	490,"engine/player.h::player_move::2::95"
;				p_facing_h = 0xff;
	C_LINE	491,"engine/player.h::player_move::2::95"
	C_LINE	491,"engine/player.h::player_move::2::95"
	ld	hl,255	;const
	ld	a,l
	ld	(_p_facing_h),a
;			
	C_LINE	492,"engine/player.h::player_move::2::95"
;			if (p_vx > 0) {
	C_LINE	493,"engine/player.h::player_move::2::95"
	C_LINE	493,"engine/player.h::player_move::2::95"
	ld	hl,(_p_vx)
	ld	de,0
	ex	de,hl
	call	l_gt
	jp	nc,i_148	;
;				p_vx -=  64 ;
	C_LINE	494,"engine/player.h::player_move::3::96"
	C_LINE	494,"engine/player.h::player_move::3::96"
	ld	hl,(_p_vx)
	ld	bc,-64
	add	hl,bc
	ld	(_p_vx),hl
;				if (p_vx < 0) p_vx = 0;
	C_LINE	495,"engine/player.h::player_move::3::96"
	C_LINE	495,"engine/player.h::player_move::3::96"
	ld	hl,(_p_vx)
	ld	a,h
	rla
	jp	nc,i_149	;
	ld	hl,0	;const
	ld	(_p_vx),hl
;			} else if (p_vx < 0) {
	C_LINE	496,"engine/player.h::player_move::3::96"
	jp	i_150	;EOS
	defc	i_149 = i_150
.i_148
	C_LINE	496,"engine/player.h::player_move::2::96"
	ld	hl,(_p_vx)
	ld	a,h
	rla
	jp	nc,i_151	;
;				p_vx +=  64 ;
	C_LINE	497,"engine/player.h::player_move::3::97"
	C_LINE	497,"engine/player.h::player_move::3::97"
	ld	hl,(_p_vx)
	ld	bc,64
	add	hl,bc
	ld	(_p_vx),hl
;				if (p_vx > 0) p_vx = 0;
	C_LINE	498,"engine/player.h::player_move::3::97"
	C_LINE	498,"engine/player.h::player_move::3::97"
	ld	hl,(_p_vx)
	ld	de,0
	ex	de,hl
	call	l_gt
	jp	nc,i_152	;
	ld	hl,0	;const
	ld	(_p_vx),hl
;			}
	C_LINE	499,"engine/player.h::player_move::3::97"
.i_152
;			wall_h = 0;
	C_LINE	500,"engine/player.h::player_move::2::97"
.i_151
.i_150
	C_LINE	500,"engine/player.h::player_move::2::97"
	ld	hl,0	;const
	ld	a,l
	ld	(_wall_h),a
;		}
	C_LINE	501,"engine/player.h::player_move::2::97"
;		if ((pad0 &  0x04 ) == 0) {
	C_LINE	503,"engine/player.h::player_move::1::97"
.i_145
	C_LINE	503,"engine/player.h::player_move::1::97"
	ld	hl,(_pad0)
	ld	h,0
	ld	a,4
	and	l
	ld	l,a
	jr	nz,ASMPC+3
	scf
	jp	nc,i_153	;
;			
	C_LINE	504,"engine/player.h::player_move::2::98"
;				p_facing_h =  2 ;
	C_LINE	505,"engine/player.h::player_move::2::98"
	C_LINE	505,"engine/player.h::player_move::2::98"
	ld	hl,2	;const
	ld	a,l
	ld	(_p_facing_h),a
;			
	C_LINE	506,"engine/player.h::player_move::2::98"
;			if (p_vx > - 256 ) {
	C_LINE	507,"engine/player.h::player_move::2::98"
	C_LINE	507,"engine/player.h::player_move::2::98"
	ld	hl,(_p_vx)
	ld	de,65280
	ex	de,hl
	call	l_gt
	jp	nc,i_154	;
;				
	C_LINE	508,"engine/player.h::player_move::3::99"
;				p_vx -=  48 ;
	C_LINE	511,"engine/player.h::player_move::3::99"
	C_LINE	511,"engine/player.h::player_move::3::99"
	ld	hl,(_p_vx)
	ld	bc,-48
	add	hl,bc
	ld	(_p_vx),hl
;			}
	C_LINE	512,"engine/player.h::player_move::3::99"
;		}
	C_LINE	513,"engine/player.h::player_move::2::99"
.i_154
;		if ((pad0 &  0x08 ) == 0) {
	C_LINE	515,"engine/player.h::player_move::1::99"
.i_153
	C_LINE	515,"engine/player.h::player_move::1::99"
	ld	hl,(_pad0)
	ld	h,0
	ld	a,8
	and	l
	ld	l,a
	jr	nz,ASMPC+3
	scf
	jp	nc,i_155	;
;			
	C_LINE	516,"engine/player.h::player_move::2::100"
;				p_facing_h =  0 ;
	C_LINE	517,"engine/player.h::player_move::2::100"
	C_LINE	517,"engine/player.h::player_move::2::100"
	ld	hl,0	;const
	ld	a,l
	ld	(_p_facing_h),a
;			
	C_LINE	518,"engine/player.h::player_move::2::100"
;			if (p_vx <  256 ) {
	C_LINE	519,"engine/player.h::player_move::2::100"
	C_LINE	519,"engine/player.h::player_move::2::100"
	ld	hl,(_p_vx)
	ld	a,l
	sub	0
	ld	a,h
	rla
	ccf
	rra
	sbc	129
	jp	nc,i_156	;
;				p_vx +=  48 ;
	C_LINE	520,"engine/player.h::player_move::3::101"
	C_LINE	520,"engine/player.h::player_move::3::101"
	ld	hl,(_p_vx)
	ld	bc,48
	add	hl,bc
	ld	(_p_vx),hl
;				
	C_LINE	521,"engine/player.h::player_move::3::101"
;			}
	C_LINE	524,"engine/player.h::player_move::3::101"
;		}
	C_LINE	525,"engine/player.h::player_move::2::101"
.i_156
;	
	C_LINE	526,"engine/player.h::player_move::1::101"
;	#line 1 "./my/ci/custom_heng.h"
	C_LINE	528,"engine/player.h::player_move::1::101"
	C_LINE	0,"./my/ci/custom_heng.h::player_move::1::101"
; 
	C_LINE	1,"./my/ci/custom_heng.h::player_move::1::101"
; 
	C_LINE	2,"./my/ci/custom_heng.h::player_move::1::101"
; 
	C_LINE	4,"./my/ci/custom_heng.h::player_move::1::101"
;#line 529 "engine/player.h"
	C_LINE	5,"./my/ci/custom_heng.h::player_move::1::101"
	C_LINE	528,"engine/player.h::player_move::1::101"
;	p_x = p_x + p_vx;
	C_LINE	530,"engine/player.h::player_move::1::101"
.i_155
	C_LINE	530,"engine/player.h::player_move::1::101"
	ld	de,(_p_x)
	ld	hl,(_p_vx)
	add	hl,de
	ld	(_p_x),hl
;	
	C_LINE	531,"engine/player.h::player_move::1::101"
;	
	C_LINE	534,"engine/player.h::player_move::1::101"
;	 
	C_LINE	535,"engine/player.h::player_move::1::101"
;	
	C_LINE	536,"engine/player.h::player_move::1::101"
;	if (p_x < 0) p_x = 0;
	C_LINE	537,"engine/player.h::player_move::1::101"
	C_LINE	537,"engine/player.h::player_move::1::101"
	ld	hl,(_p_x)
	ld	a,h
	rla
	jp	nc,i_157	;
	ld	hl,0	;const
	ld	(_p_x),hl
;	if (p_x > 14336) p_x = 14336;
	C_LINE	538,"engine/player.h::player_move::1::101"
.i_157
	C_LINE	538,"engine/player.h::player_move::1::101"
	ld	hl,(_p_x)
	ld	de,14336
	ex	de,hl
	call	l_gt
	jp	nc,i_158	;
	ld	hl,14336	;const
	ld	(_p_x),hl
;	gpox = gpx;
	C_LINE	540,"engine/player.h::player_move::1::101"
.i_158
	C_LINE	540,"engine/player.h::player_move::1::101"
	ld	hl,(_gpx)
	ld	h,0
	ld	a,l
	ld	(_gpox),a
;	gpx = p_x >> 6;
	C_LINE	541,"engine/player.h::player_move::1::101"
	C_LINE	541,"engine/player.h::player_move::1::101"
	ld	hl,(_p_x)
	ld	de,6
	call	l_asr_hl_by_e
	ld	h,0
	ld	a,l
	ld	(_gpx),a
;		
	C_LINE	542,"engine/player.h::player_move::1::101"
;	 
	C_LINE	543,"engine/player.h::player_move::1::101"
;	player_calc_bounding_box ();
	C_LINE	544,"engine/player.h::player_move::1::101"
	C_LINE	544,"engine/player.h::player_move::1::101"
	call	_player_calc_bounding_box
;	hit_h = 0;
	C_LINE	546,"engine/player.h::player_move::1::101"
	C_LINE	546,"engine/player.h::player_move::1::101"
	ld	hl,0	;const
	ld	a,l
	ld	(_hit_h),a
;	cy1 = pty1; cy2 = pty2;
	C_LINE	547,"engine/player.h::player_move::1::101"
	C_LINE	547,"engine/player.h::player_move::1::101"
	ld	a,(_pty1)
	ld	(_cy1),a
	ld	hl,(_pty2)
	ld	h,0
	ld	a,l
	ld	(_cy2),a
;	
	C_LINE	549,"engine/player.h::player_move::1::101"
;		if (p_vx < 0)
	C_LINE	550,"engine/player.h::player_move::1::101"
	C_LINE	550,"engine/player.h::player_move::1::101"
	ld	hl,(_p_vx)
	ld	a,h
	rla
	jp	nc,i_159	;
;	
	C_LINE	551,"engine/player.h::player_move::1::101"
;	{
	C_LINE	554,"engine/player.h::player_move::1::101"
	C_LINE	554,"engine/player.h::player_move::1::101"
;		cx1 = cx2 = ptx1;
	C_LINE	555,"engine/player.h::player_move::2::102"
	C_LINE	555,"engine/player.h::player_move::2::102"
	ld	hl,(_ptx1)
	ld	a,l
	ld	(_cx2),a
	ld	(_cx1),a
;		cm_two_points ();
	C_LINE	556,"engine/player.h::player_move::2::102"
	C_LINE	556,"engine/player.h::player_move::2::102"
	call	_cm_two_points
;		if ((at1 & 8) || (at2 & 8)) {
	C_LINE	558,"engine/player.h::player_move::2::102"
	C_LINE	558,"engine/player.h::player_move::2::102"
	ld	a,(_at1)
	and	8
	jp	nz,i_161	;
	ld	a,(_at2)
	and	8
	jp	z,i_160	;
.i_161
;			#line 1 "./my/ci/bg_collision/obstacle_left.h"
	C_LINE	559,"engine/player.h::player_move::3::103"
	C_LINE	0,"./my/ci/bg_collision/obstacle_left.h::player_move::3::103"
; 
	C_LINE	1,"./my/ci/bg_collision/obstacle_left.h::player_move::3::103"
; 
	C_LINE	2,"./my/ci/bg_collision/obstacle_left.h::player_move::3::103"
;#line 560 "engine/player.h"
	C_LINE	3,"./my/ci/bg_collision/obstacle_left.h::player_move::3::103"
	C_LINE	559,"engine/player.h::player_move::3::103"
;			
	C_LINE	561,"engine/player.h::player_move::3::103"
;				p_vx = 0;
	C_LINE	564,"engine/player.h::player_move::3::103"
	C_LINE	564,"engine/player.h::player_move::3::103"
	ld	hl,0	;const
	ld	(_p_vx),hl
;			
	C_LINE	565,"engine/player.h::player_move::3::103"
;			
	C_LINE	567,"engine/player.h::player_move::3::103"
;				gpx = ((ptx1 + 1) << 4) - 2;
	C_LINE	570,"engine/player.h::player_move::3::103"
	C_LINE	570,"engine/player.h::player_move::3::103"
	ld	hl,(_ptx1)
	ld	h,0
	inc	hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	dec	hl
	dec	hl
	ld	h,0
	ld	a,l
	ld	(_gpx),a
;			
	C_LINE	571,"engine/player.h::player_move::3::103"
;			p_x = gpx << 6;
	C_LINE	575,"engine/player.h::player_move::3::103"
	C_LINE	575,"engine/player.h::player_move::3::103"
	ld	hl,(_gpx)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	(_p_x),hl
;			wall_h =  3 ;
	C_LINE	576,"engine/player.h::player_move::3::103"
	C_LINE	576,"engine/player.h::player_move::3::103"
	ld	hl,3	;const
	ld	a,l
	ld	(_wall_h),a
;		}
	C_LINE	577,"engine/player.h::player_move::3::103"
;		
	C_LINE	578,"engine/player.h::player_move::2::103"
;			else hit_h = ((at1 & 1) || (at2 & 1));
	C_LINE	579,"engine/player.h::player_move::2::103"
	jp	i_163	;EOS
.i_160
	C_LINE	579,"engine/player.h::player_move::2::103"
	ld	a,(_at1)
	and	1
	jp	nz,i_164	;
	ld	a,(_at2)
	and	1
	jp	nz,i_164	;
	ld	hl,0	;const
	jr	i_165
.i_164
	ld	hl,1	;const
.i_165
	ld	h,0
	ld	a,l
	ld	(_hit_h),a
.i_163
;		
	C_LINE	580,"engine/player.h::player_move::2::103"
;	}
	C_LINE	582,"engine/player.h::player_move::2::103"
;	
	C_LINE	584,"engine/player.h::player_move::1::103"
;		if (p_vx > 0)
	C_LINE	585,"engine/player.h::player_move::1::103"
.i_159
	C_LINE	585,"engine/player.h::player_move::1::103"
	ld	hl,(_p_vx)
	ld	de,0
	ex	de,hl
	call	l_gt
	jp	nc,i_166	;
;	
	C_LINE	586,"engine/player.h::player_move::1::103"
;	{
	C_LINE	589,"engine/player.h::player_move::1::103"
	C_LINE	589,"engine/player.h::player_move::1::103"
;		cx1 = cx2 = ptx2; 
	C_LINE	590,"engine/player.h::player_move::2::104"
	C_LINE	590,"engine/player.h::player_move::2::104"
	ld	hl,(_ptx2)
	ld	a,l
	ld	(_cx2),a
	ld	(_cx1),a
;		cm_two_points ();
	C_LINE	591,"engine/player.h::player_move::2::104"
	C_LINE	591,"engine/player.h::player_move::2::104"
	call	_cm_two_points
;		if ((at1 & 8) || (at2 & 8)) {
	C_LINE	593,"engine/player.h::player_move::2::104"
	C_LINE	593,"engine/player.h::player_move::2::104"
	ld	a,(_at1)
	and	8
	jp	nz,i_168	;
	ld	a,(_at2)
	and	8
	jp	z,i_167	;
.i_168
;			#line 1 "./my/ci/bg_collision/obstacle_right.h"
	C_LINE	594,"engine/player.h::player_move::3::105"
	C_LINE	0,"./my/ci/bg_collision/obstacle_right.h::player_move::3::105"
; 
	C_LINE	1,"./my/ci/bg_collision/obstacle_right.h::player_move::3::105"
; 
	C_LINE	2,"./my/ci/bg_collision/obstacle_right.h::player_move::3::105"
;#line 595 "engine/player.h"
	C_LINE	3,"./my/ci/bg_collision/obstacle_right.h::player_move::3::105"
	C_LINE	594,"engine/player.h::player_move::3::105"
;			
	C_LINE	596,"engine/player.h::player_move::3::105"
;				p_vx = 0;
	C_LINE	599,"engine/player.h::player_move::3::105"
	C_LINE	599,"engine/player.h::player_move::3::105"
	ld	hl,0	;const
	ld	(_p_vx),hl
;			
	C_LINE	600,"engine/player.h::player_move::3::105"
;			
	C_LINE	602,"engine/player.h::player_move::3::105"
;				gpx = (ptx1 << 4) + 2;
	C_LINE	605,"engine/player.h::player_move::3::105"
	C_LINE	605,"engine/player.h::player_move::3::105"
	ld	hl,(_ptx1)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_gpx),a
;			
	C_LINE	606,"engine/player.h::player_move::3::105"
;			p_x = gpx << 6;
	C_LINE	610,"engine/player.h::player_move::3::105"
	C_LINE	610,"engine/player.h::player_move::3::105"
	ld	hl,(_gpx)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	(_p_x),hl
;			wall_h =  4 ;
	C_LINE	611,"engine/player.h::player_move::3::105"
	C_LINE	611,"engine/player.h::player_move::3::105"
	ld	hl,4	;const
	ld	a,l
	ld	(_wall_h),a
;		}
	C_LINE	612,"engine/player.h::player_move::3::105"
;		
	C_LINE	613,"engine/player.h::player_move::2::105"
;			else hit_h = ((at1 & 1) || (at2 & 1));
	C_LINE	614,"engine/player.h::player_move::2::105"
	jp	i_170	;EOS
.i_167
	C_LINE	614,"engine/player.h::player_move::2::105"
	ld	a,(_at1)
	and	1
	jp	nz,i_171	;
	ld	a,(_at2)
	and	1
	jp	nz,i_171	;
	ld	hl,0	;const
	jr	i_172
.i_171
	ld	hl,1	;const
.i_172
	ld	h,0
	ld	a,l
	ld	(_hit_h),a
.i_170
;		
	C_LINE	615,"engine/player.h::player_move::2::105"
;	}
	C_LINE	617,"engine/player.h::player_move::2::105"
;	 
	C_LINE	619,"engine/player.h::player_move::1::105"
;	
	C_LINE	621,"engine/player.h::player_move::1::105"
;		
	C_LINE	622,"engine/player.h::player_move::1::105"
;			if (p_facing_v != 0xff) {
	C_LINE	623,"engine/player.h::player_move::1::105"
.i_166
	C_LINE	623,"engine/player.h::player_move::1::105"
	ld	hl,(_p_facing_v)
	ld	h,0
	ld	a,l
	cp	255
	jp	z,i_173	;
;				p_facing = p_facing_v;
	C_LINE	624,"engine/player.h::player_move::2::106"
	C_LINE	624,"engine/player.h::player_move::2::106"
	ld	hl,(_p_facing_v)
	ld	h,0
	ld	a,l
	ld	(_p_facing),a
;			} else if (p_facing_h != 0xff) {
	C_LINE	625,"engine/player.h::player_move::2::106"
	jp	i_174	;EOS
.i_173
	C_LINE	625,"engine/player.h::player_move::1::106"
	ld	hl,(_p_facing_h)
	ld	h,0
	ld	a,l
	cp	255
	jp	z,i_175	;
;				p_facing = p_facing_h;
	C_LINE	626,"engine/player.h::player_move::2::107"
	C_LINE	626,"engine/player.h::player_move::2::107"
	ld	hl,(_p_facing_h)
	ld	h,0
	ld	a,l
	ld	(_p_facing),a
;			}
	C_LINE	627,"engine/player.h::player_move::2::107"
;		
	C_LINE	628,"engine/player.h::player_move::1::107"
;	
	C_LINE	635,"engine/player.h::player_move::1::107"
;	cx1 = p_tx = (gpx + 8) >> 4;
	C_LINE	637,"engine/player.h::player_move::1::107"
.i_175
.i_174
	C_LINE	637,"engine/player.h::player_move::1::107"
	ld	hl,(_gpx)
	ld	h,0
	ld	bc,8
	add	hl,bc
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(_p_tx),a
	ld	h,0
	ld	a,l
	ld	(_cx1),a
;	cy1 = p_ty = (gpy + 8) >> 4;
	C_LINE	638,"engine/player.h::player_move::1::107"
	C_LINE	638,"engine/player.h::player_move::1::107"
	ld	hl,(_gpy)
	ld	h,0
	ld	bc,8
	add	hl,bc
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(_p_ty),a
	ld	h,0
	ld	a,l
	ld	(_cy1),a
;	rdb = attr (cx1, cy1);
	C_LINE	640,"engine/player.h::player_move::1::107"
	C_LINE	640,"engine/player.h::player_move::1::107"
;cx1;
	C_LINE	641,"engine/player.h::player_move::1::107"
	ld	hl,(_cx1)
	ld	h,0
	push	hl
;cy1;
	C_LINE	641,"engine/player.h::player_move::1::107"
	ld	hl,(_cy1)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	h,0
	ld	a,l
	ld	(_rdb),a
;	 
	C_LINE	642,"engine/player.h::player_move::1::107"
;	if (rdb & 128) {
	C_LINE	643,"engine/player.h::player_move::1::107"
	C_LINE	643,"engine/player.h::player_move::1::107"
	ld	hl,(_rdb)
	ld	h,0
	ld	a,128
	and	l
	ld	l,a
	ld	a,h
	or	l
	jp	z,i_176	;
;		#line 1 "./my/ci/on_special_tile.h"
	C_LINE	644,"engine/player.h::player_move::2::108"
	C_LINE	0,"./my/ci/on_special_tile.h::player_move::2::108"
; 
	C_LINE	1,"./my/ci/on_special_tile.h::player_move::2::108"
; 
	C_LINE	2,"./my/ci/on_special_tile.h::player_move::2::108"
;#line 645 "engine/player.h"
	C_LINE	4,"./my/ci/on_special_tile.h::player_move::2::108"
	C_LINE	644,"engine/player.h::player_move::2::108"
;	}
	C_LINE	645,"engine/player.h::player_move::2::108"
;	
	C_LINE	647,"engine/player.h::player_move::1::108"
;		
	C_LINE	648,"engine/player.h::player_move::1::108"
;			if (wall_v ==  1 ) {
	C_LINE	649,"engine/player.h::player_move::1::108"
.i_176
	C_LINE	649,"engine/player.h::player_move::1::108"
	ld	hl,(_wall_v)
	ld	h,0
	ld	a,l
	cp	1
	jp	nz,i_177	;
;				 
	C_LINE	650,"engine/player.h::player_move::2::109"
;				
	C_LINE	651,"engine/player.h::player_move::2::109"
;					cy1 = (gpy + 6) >> 4;
	C_LINE	652,"engine/player.h::player_move::2::109"
	C_LINE	652,"engine/player.h::player_move::2::109"
	ld	hl,(_gpy)
	ld	h,0
	ld	bc,6
	add	hl,bc
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(_cy1),a
;				
	C_LINE	653,"engine/player.h::player_move::2::109"
;				if (attr (cx1, cy1) == 10) {
	C_LINE	659,"engine/player.h::player_move::2::109"
	C_LINE	659,"engine/player.h::player_move::2::109"
;cx1;
	C_LINE	660,"engine/player.h::player_move::2::109"
	ld	hl,(_cx1)
	ld	h,0
	push	hl
;cy1;
	C_LINE	660,"engine/player.h::player_move::2::109"
	ld	hl,(_cy1)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	a,l
	cp	10
	jp	nz,i_178	;
;					x0 = x1 = cx1; y0 = cy1; y1 = cy1 - 1;
	C_LINE	660,"engine/player.h::player_move::3::110"
	C_LINE	660,"engine/player.h::player_move::3::110"
	ld	hl,(_cx1)
	ld	a,l
	ld	(_x1),a
	ld	(_x0),a
	ld	a,(_cy1)
	ld	(_y0),a
	ld	hl,(_cy1)
	dec	l
	ld	h,0
	ld	a,l
	ld	(_y1),a
;					process_tile ();
	C_LINE	661,"engine/player.h::player_move::3::110"
	C_LINE	661,"engine/player.h::player_move::3::110"
	call	_process_tile
;				}
	C_LINE	662,"engine/player.h::player_move::3::110"
;			} else if (wall_v ==  2 ) {
	C_LINE	664,"engine/player.h::player_move::2::110"
	jp	i_179	;EOS
	defc	i_178 = i_179
.i_177
	C_LINE	664,"engine/player.h::player_move::1::110"
	ld	hl,(_wall_v)
	ld	h,0
	ld	a,l
	cp	2
	jp	nz,i_180	;
;				 
	C_LINE	665,"engine/player.h::player_move::2::111"
;				
	C_LINE	666,"engine/player.h::player_move::2::111"
;					cy1 = (gpy + 9) >> 4;
	C_LINE	669,"engine/player.h::player_move::2::111"
	C_LINE	669,"engine/player.h::player_move::2::111"
	ld	hl,(_gpy)
	ld	h,0
	ld	bc,9
	add	hl,bc
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(_cy1),a
;				
	C_LINE	670,"engine/player.h::player_move::2::111"
;			
	C_LINE	675,"engine/player.h::player_move::2::111"
;				if (attr (cx1, cy1) == 10) {
	C_LINE	676,"engine/player.h::player_move::2::111"
	C_LINE	676,"engine/player.h::player_move::2::111"
;cx1;
	C_LINE	677,"engine/player.h::player_move::2::111"
	ld	hl,(_cx1)
	ld	h,0
	push	hl
;cy1;
	C_LINE	677,"engine/player.h::player_move::2::111"
	ld	hl,(_cy1)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	a,l
	cp	10
	jp	nz,i_181	;
;					x0 = x1 = cx1; y0 = cy1; y1 = cy1 + 1;
	C_LINE	677,"engine/player.h::player_move::3::112"
	C_LINE	677,"engine/player.h::player_move::3::112"
	ld	hl,(_cx1)
	ld	a,l
	ld	(_x1),a
	ld	(_x0),a
	ld	a,(_cy1)
	ld	(_y0),a
	ld	hl,(_cy1)
	inc	l
	ld	h,0
	ld	a,l
	ld	(_y1),a
;					process_tile ();
	C_LINE	678,"engine/player.h::player_move::3::112"
	C_LINE	678,"engine/player.h::player_move::3::112"
	call	_process_tile
;				}
	C_LINE	679,"engine/player.h::player_move::3::112"
;			} else
	C_LINE	680,"engine/player.h::player_move::2::112"
	jp	i_182	;EOS
	defc	i_181 = i_182
.i_180
;		
	C_LINE	681,"engine/player.h::player_move::1::112"
;		
	C_LINE	682,"engine/player.h::player_move::1::112"
;		if (wall_h ==  3 ) {		
	C_LINE	683,"engine/player.h::player_move::1::112"
	C_LINE	683,"engine/player.h::player_move::1::112"
	ld	hl,(_wall_h)
	ld	h,0
	ld	a,l
	cp	3
	jp	nz,i_183	;
;			 
	C_LINE	684,"engine/player.h::player_move::2::113"
;			
	C_LINE	685,"engine/player.h::player_move::2::113"
;				cx1 = (gpx + 1) >> 4;
	C_LINE	688,"engine/player.h::player_move::2::113"
	C_LINE	688,"engine/player.h::player_move::2::113"
	ld	hl,(_gpx)
	ld	h,0
	inc	hl
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(_cx1),a
;			
	C_LINE	689,"engine/player.h::player_move::2::113"
;			if (attr (cx1, cy1) == 10) {
	C_LINE	693,"engine/player.h::player_move::2::113"
	C_LINE	693,"engine/player.h::player_move::2::113"
;cx1;
	C_LINE	694,"engine/player.h::player_move::2::113"
	ld	hl,(_cx1)
	ld	h,0
	push	hl
;cy1;
	C_LINE	694,"engine/player.h::player_move::2::113"
	ld	hl,(_cy1)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	a,l
	cp	10
	jp	nz,i_184	;
;				y0 = y1 = cy1; x0 = cx1; x1 = cx1 - 1;
	C_LINE	694,"engine/player.h::player_move::3::114"
	C_LINE	694,"engine/player.h::player_move::3::114"
	ld	hl,(_cy1)
	ld	a,l
	ld	(_y1),a
	ld	(_y0),a
	ld	a,(_cx1)
	ld	(_x0),a
	ld	hl,(_cx1)
	dec	l
	ld	h,0
	ld	a,l
	ld	(_x1),a
;				process_tile ();
	C_LINE	695,"engine/player.h::player_move::3::114"
	C_LINE	695,"engine/player.h::player_move::3::114"
	call	_process_tile
;			}
	C_LINE	696,"engine/player.h::player_move::3::114"
;		} else if (wall_h ==  4 ) {
	C_LINE	697,"engine/player.h::player_move::2::114"
	jp	i_185	;EOS
	defc	i_184 = i_185
.i_183
	C_LINE	697,"engine/player.h::player_move::1::114"
	ld	hl,(_wall_h)
	ld	h,0
	ld	a,l
	cp	4
	jp	nz,i_186	;
;			 
	C_LINE	698,"engine/player.h::player_move::2::115"
;			
	C_LINE	699,"engine/player.h::player_move::2::115"
;				cx1 = (gpx + 14) >>4;
	C_LINE	702,"engine/player.h::player_move::2::115"
	C_LINE	702,"engine/player.h::player_move::2::115"
	ld	hl,(_gpx)
	ld	h,0
	ld	bc,14
	add	hl,bc
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(_cx1),a
;			
	C_LINE	703,"engine/player.h::player_move::2::115"
;			if (attr (cx1, cy1) == 10) {
	C_LINE	706,"engine/player.h::player_move::2::115"
	C_LINE	706,"engine/player.h::player_move::2::115"
;cx1;
	C_LINE	707,"engine/player.h::player_move::2::115"
	ld	hl,(_cx1)
	ld	h,0
	push	hl
;cy1;
	C_LINE	707,"engine/player.h::player_move::2::115"
	ld	hl,(_cy1)
	ld	h,0
	push	hl
	call	_attr
	pop	bc
	pop	bc
	ld	a,l
	cp	10
	jp	nz,i_187	;
;				y0 = y1 = cy1; x0 = cx1; x1 = cx1 + 1;
	C_LINE	707,"engine/player.h::player_move::3::116"
	C_LINE	707,"engine/player.h::player_move::3::116"
	ld	hl,(_cy1)
	ld	a,l
	ld	(_y1),a
	ld	(_y0),a
	ld	a,(_cx1)
	ld	(_x0),a
	ld	hl,(_cx1)
	inc	l
	ld	h,0
	ld	a,l
	ld	(_x1),a
;				process_tile ();
	C_LINE	708,"engine/player.h::player_move::3::116"
	C_LINE	708,"engine/player.h::player_move::3::116"
	call	_process_tile
;			}
	C_LINE	709,"engine/player.h::player_move::3::116"
;		}
	C_LINE	710,"engine/player.h::player_move::2::116"
.i_187
;	
	C_LINE	711,"engine/player.h::player_move::1::116"
;	
	C_LINE	713,"engine/player.h::player_move::1::116"
;		 
	C_LINE	714,"engine/player.h::player_move::1::116"
;		if ((pad0 &  0x80 ) == 0 && p_disparando == 0) {			
	C_LINE	715,"engine/player.h::player_move::1::116"
.i_186
.i_185
.i_182
.i_179
	C_LINE	715,"engine/player.h::player_move::1::116"
	ld	hl,(_pad0)
	ld	h,0
	ld	a,128
	and	l
	ld	l,a
	jr	nz,ASMPC+3
	scf
	jp	nc,i_189	;
	ld	a,(_p_disparando)
	and	a
	jp	nz,i_189	;
	defc	i_189 = i_188
.i_190_i_189
;			p_disparando = 1;
	C_LINE	716,"engine/player.h::player_move::2::117"
	C_LINE	716,"engine/player.h::player_move::2::117"
	ld	hl,1	;const
	ld	a,l
	ld	(_p_disparando),a
;			
	C_LINE	717,"engine/player.h::player_move::2::117"
;				 
	C_LINE	718,"engine/player.h::player_move::2::117"
;			
	C_LINE	719,"engine/player.h::player_move::2::117"
;				bullets_fire ();
	C_LINE	720,"engine/player.h::player_move::2::117"
	C_LINE	720,"engine/player.h::player_move::2::117"
	call	_bullets_fire
;			
	C_LINE	721,"engine/player.h::player_move::2::117"
;				 
	C_LINE	722,"engine/player.h::player_move::2::117"
;			
	C_LINE	723,"engine/player.h::player_move::2::117"
;		}
	C_LINE	724,"engine/player.h::player_move::2::117"
;		
	C_LINE	725,"engine/player.h::player_move::1::117"
;		if ((pad0 &  0x80 )) 
	C_LINE	726,"engine/player.h::player_move::1::117"
.i_188
	C_LINE	726,"engine/player.h::player_move::1::117"
	ld	hl,(_pad0)
	ld	h,0
	ld	a,128
	and	l
	ld	l,a
	ld	a,h
	or	l
	jp	z,i_191	;
;			p_disparando = 0;
	C_LINE	727,"engine/player.h::player_move::1::117"
	C_LINE	727,"engine/player.h::player_move::1::117"
	ld	hl,0	;const
	ld	a,l
	ld	(_p_disparando),a
;	
	C_LINE	729,"engine/player.h::player_move::1::117"
;	
	C_LINE	731,"engine/player.h::player_move::1::117"
;		 
	C_LINE	732,"engine/player.h::player_move::1::117"
;		 
	C_LINE	733,"engine/player.h::player_move::1::117"
;		hit = 0;
	C_LINE	734,"engine/player.h::player_move::1::117"
.i_191
	C_LINE	734,"engine/player.h::player_move::1::117"
	ld	hl,0	;const
	ld	a,l
	ld	(_hit),a
;		if (hit_v) {
	C_LINE	735,"engine/player.h::player_move::1::117"
	C_LINE	735,"engine/player.h::player_move::1::117"
	ld	hl,(_hit_v)
	ld	a,l
	and	a
	jp	z,i_192	;
;			hit = 1;
	C_LINE	736,"engine/player.h::player_move::2::118"
	C_LINE	736,"engine/player.h::player_move::2::118"
	ld	hl,1	;const
	ld	a,l
	ld	(_hit),a
;				p_vy = addsign (-p_vy,  256 );
	C_LINE	737,"engine/player.h::player_move::2::118"
	C_LINE	737,"engine/player.h::player_move::2::118"
;-p_vy;
	C_LINE	738,"engine/player.h::player_move::2::118"
	ld	hl,(_p_vy)
	call	l_neg
	push	hl
;256 ;
	C_LINE	738,"engine/player.h::player_move::2::118"
	ld	hl,256	;const
	push	hl
	call	_addsign
	pop	bc
	pop	bc
	ld	(_p_vy),hl
;		} else if (hit_h) {
	C_LINE	738,"engine/player.h::player_move::2::118"
	jp	i_193	;EOS
.i_192
	C_LINE	738,"engine/player.h::player_move::1::118"
	ld	hl,(_hit_h)
	ld	a,l
	and	a
	jp	z,i_194	;
;			hit = 1;
	C_LINE	739,"engine/player.h::player_move::2::119"
	C_LINE	739,"engine/player.h::player_move::2::119"
	ld	hl,1	;const
	ld	a,l
	ld	(_hit),a
;				p_vx = addsign (-p_vx,  256 );
	C_LINE	740,"engine/player.h::player_move::2::119"
	C_LINE	740,"engine/player.h::player_move::2::119"
;-p_vx;
	C_LINE	741,"engine/player.h::player_move::2::119"
	ld	hl,(_p_vx)
	call	l_neg
	push	hl
;256 ;
	C_LINE	741,"engine/player.h::player_move::2::119"
	ld	hl,256	;const
	push	hl
	call	_addsign
	pop	bc
	pop	bc
	ld	(_p_vx),hl
;		}
	C_LINE	741,"engine/player.h::player_move::2::119"
;		
	C_LINE	742,"engine/player.h::player_move::1::119"
;		if (hit) {
	C_LINE	743,"engine/player.h::player_move::1::119"
.i_194
.i_193
	C_LINE	743,"engine/player.h::player_move::1::119"
	ld	hl,(_hit)
	ld	a,l
	and	a
	jp	z,i_195	;
;			
	C_LINE	744,"engine/player.h::player_move::2::120"
;				if (p_estado ==  0 )
	C_LINE	745,"engine/player.h::player_move::2::120"
	C_LINE	745,"engine/player.h::player_move::2::120"
	ld	hl,(_p_estado)
	ld	h,0
	ld	a,l
	and	a
	jp	nz,i_196	;
;			
	C_LINE	746,"engine/player.h::player_move::2::120"
;			{
	C_LINE	747,"engine/player.h::player_move::2::120"
	C_LINE	747,"engine/player.h::player_move::2::120"
;				
	C_LINE	748,"engine/player.h::player_move::3::121"
;					p_killme = 4;
	C_LINE	751,"engine/player.h::player_move::3::121"
	C_LINE	751,"engine/player.h::player_move::3::121"
	ld	hl,4	;const
	ld	a,l
	ld	(_p_killme),a
;				
	C_LINE	752,"engine/player.h::player_move::3::121"
;			}
	C_LINE	753,"engine/player.h::player_move::3::121"
;		}
	C_LINE	754,"engine/player.h::player_move::2::121"
.i_196
;	
	C_LINE	755,"engine/player.h::player_move::1::121"
;	 
	C_LINE	757,"engine/player.h::player_move::1::121"
;	
	C_LINE	759,"engine/player.h::player_move::1::121"
;		if (p_vx || p_vy) {
	C_LINE	762,"engine/player.h::player_move::1::121"
.i_195
	C_LINE	762,"engine/player.h::player_move::1::121"
	ld	hl,(_p_vx)
	ld	a,h
	or	l
	jp	nz,i_198	;
	ld	hl,(_p_vy)
	ld	a,h
	or	l
	jr	z,i_199
.i_198
	ld	hl,1	;const
.i_199
	ld	a,h
	or	l
	jp	z,i_197	;
;			++ p_subframe;
	C_LINE	763,"engine/player.h::player_move::2::122"
	C_LINE	763,"engine/player.h::player_move::2::122"
	ld	hl,_p_subframe
	inc	(hl)
	ld	l,(hl)
	ld	h,0
;			if (p_subframe == 4) {
	C_LINE	764,"engine/player.h::player_move::2::122"
	C_LINE	764,"engine/player.h::player_move::2::122"
	ld	hl,(_p_subframe)
	ld	h,0
	ld	a,l
	cp	4
	jp	nz,i_200	;
;				p_subframe = 0;
	C_LINE	765,"engine/player.h::player_move::3::123"
	C_LINE	765,"engine/player.h::player_move::3::123"
	ld	hl,0	;const
	ld	a,l
	ld	(_p_subframe),a
;				p_frame = !p_frame;
	C_LINE	766,"engine/player.h::player_move::3::123"
	C_LINE	766,"engine/player.h::player_move::3::123"
	ld	hl,(_p_frame)
	ld	h,0
	call	l_lneg
	ld	h,0
	ld	a,l
	ld	(_p_frame),a
;				
	C_LINE	767,"engine/player.h::player_move::3::123"
;			}
	C_LINE	770,"engine/player.h::player_move::3::123"
;		}
	C_LINE	771,"engine/player.h::player_move::2::123"
.i_200
;		
	C_LINE	772,"engine/player.h::player_move::1::123"
;		p_next_frame = (unsigned char *) (player_cells [p_facing + p_frame]);
	C_LINE	773,"engine/player.h::player_move::1::123"
.i_197
	C_LINE	773,"engine/player.h::player_move::1::123"
	ld	hl,_player_cells
	push	hl
	ld	de,(_p_facing)
	ld	d,0
	ld	hl,(_p_frame)
	ld	h,d
	add	hl,de
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	ld	(_p_next_frame),hl
;	
	C_LINE	774,"engine/player.h::player_move::1::123"
;}
	C_LINE	796,"engine/player.h::player_move::1::123"
	ret


;void player_deplete (void) {
	C_LINE	798,"engine/player.h::player_move::0::123"
	C_LINE	798,"engine/player.h::player_move::0::123"

; Function player_deplete flags 0x00000200 __smallc 
; void player_deplete()
	C_LINE	798,"engine/player.h::player_deplete::0::123"
._player_deplete
	C_LINE	798,"engine/player.h::player_deplete::0::123"
;	p_life = (p_life > p_kill_amt) ? p_life - p_kill_amt : 0;
	C_LINE	799,"engine/player.h::player_deplete::1::124"
	C_LINE	799,"engine/player.h::player_deplete::1::124"
	ld	de,(_p_life)
	ld	d,0
	ld	hl,(_p_kill_amt)
	ld	h,d
	and	a
	sbc	hl,de
	jp	nc,i_201	;
	ld	de,(_p_life)
	ld	d,0
	ld	hl,(_p_kill_amt)
	ld	h,d
	ex	de,hl
	and	a
	sbc	hl,de
	jp	i_202	;
.i_201
	ld	hl,0	;const
.i_202
	ld	h,0
	ld	a,l
	ld	(_p_life),a
;}
	C_LINE	800,"engine/player.h::player_deplete::1::124"
	ret


;void player_kill (unsigned char sound) {
	C_LINE	802,"engine/player.h::player_deplete::0::124"
	C_LINE	802,"engine/player.h::player_deplete::0::124"

; Function player_kill flags 0x00000200 __smallc 
; void player_kill(unsigned char sound)
; parameter 'unsigned char sound' at sp+2 size(1)
	C_LINE	802,"engine/player.h::player_kill::0::124"
._player_kill
	C_LINE	802,"engine/player.h::player_kill::0::124"
;	p_killme = 0;
	C_LINE	803,"engine/player.h::player_kill::1::125"
	C_LINE	803,"engine/player.h::player_kill::1::125"
	ld	hl,0	;const
	ld	a,l
	ld	(_p_killme),a
;	player_deplete ();
	C_LINE	805,"engine/player.h::player_kill::1::125"
	C_LINE	805,"engine/player.h::player_kill::1::125"
	call	_player_deplete
;	
	C_LINE	807,"engine/player.h::player_kill::1::125"
;		beep_fx (sound);
	C_LINE	810,"engine/player.h::player_kill::1::125"
	C_LINE	810,"engine/player.h::player_kill::1::125"
;sound;
	C_LINE	811,"engine/player.h::player_kill::1::125"
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	call	_beep_fx
	pop	bc
;	
	C_LINE	811,"engine/player.h::player_kill::1::125"
;	
	C_LINE	813,"engine/player.h::player_kill::1::125"
; 
	C_LINE	821,"engine/player.h::player_kill::1::125"
;	
	C_LINE	824,"engine/player.h::player_kill::1::125"
;		p_estado =  2 ;
	C_LINE	825,"engine/player.h::player_kill::1::125"
	C_LINE	825,"engine/player.h::player_kill::1::125"
	ld	hl,2	;const
	ld	a,l
	ld	(_p_estado),a
;		p_ct_estado = 50;
	C_LINE	826,"engine/player.h::player_kill::1::125"
	C_LINE	826,"engine/player.h::player_kill::1::125"
	ld	hl,50	;const
	ld	a,l
	ld	(_p_ct_estado),a
;	
	C_LINE	827,"engine/player.h::player_kill::1::125"
;}
	C_LINE	828,"engine/player.h::player_kill::1::125"
	ret


;#line 135 "mk1.c"
	C_LINE	830,"engine/player.h::player_kill::0::125"
	C_LINE	134,"mk1.c::player_kill::0::125"
;#line 1 "engine/enengine.h"
	C_LINE	135,"mk1.c::player_kill::0::125"
	C_LINE	0,"engine/enengine.h::player_kill::0::125"
; 
	C_LINE	1,"engine/enengine.h::player_kill::0::125"
; 
	C_LINE	2,"engine/enengine.h::player_kill::0::125"
; 
	C_LINE	4,"engine/enengine.h::player_kill::0::125"
;	void enems_pursuers_init (void) {
	C_LINE	7,"engine/enengine.h::player_kill::0::125"
	C_LINE	7,"engine/enengine.h::player_kill::0::125"

; Function enems_pursuers_init flags 0x00000200 __smallc 
; void enems_pursuers_init()
	C_LINE	7,"engine/enengine.h::enems_pursuers_init::0::125"
._enems_pursuers_init
	C_LINE	7,"engine/enengine.h::enems_pursuers_init::0::125"
;		en_an_alive [enit] = 0;
	C_LINE	8,"engine/enengine.h::enems_pursuers_init::1::126"
	C_LINE	8,"engine/enengine.h::enems_pursuers_init::1::126"
	ld	de,_en_an_alive
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	l,(hl)
	ld	h,0
;		en_an_dead_row [enit] =  11  + (rand () &  7 );
	C_LINE	9,"engine/enengine.h::enems_pursuers_init::1::126"
	C_LINE	9,"engine/enengine.h::enems_pursuers_init::1::126"
	ld	de,_en_an_dead_row
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	push	hl
	call	_rand
	ld	a,l
	and	7
	ld	l,a
	ld	h,0
	ld	bc,11
	add	hl,bc
	pop	de
	ld	a,l
	ld	(de),a
;	}
	C_LINE	10,"engine/enengine.h::enems_pursuers_init::1::126"
	ret


; 
	C_LINE	18,"engine/enengine.h::enems_pursuers_init::0::126"
;void enems_draw_current (void) {
	C_LINE	28,"engine/enengine.h::enems_pursuers_init::0::126"
	C_LINE	28,"engine/enengine.h::enems_pursuers_init::0::126"

; Function enems_draw_current flags 0x00000200 __smallc 
; void enems_draw_current()
	C_LINE	28,"engine/enengine.h::enems_draw_current::0::126"
._enems_draw_current
	C_LINE	28,"engine/enengine.h::enems_draw_current::0::126"
;	_en_x = malotes [enoffsmasi].x;
	C_LINE	29,"engine/enengine.h::enems_draw_current::1::127"
	C_LINE	29,"engine/enengine.h::enems_draw_current::1::127"
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__en_x),a
;	_en_y = malotes [enoffsmasi].y;
	C_LINE	30,"engine/enengine.h::enems_draw_current::1::127"
	C_LINE	30,"engine/enengine.h::enems_draw_current::1::127"
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__en_y),a
;	
	C_LINE	31,"engine/enengine.h::enems_draw_current::1::127"
;	#asm
	C_LINE	32,"engine/enengine.h::enems_draw_current::1::127"
	C_LINE	32,"engine/enengine.h::enems_draw_current::1::127"
	C_LINE	34,"engine/enengine.h::enems_draw_current::1::127"
		; enter: IX = sprite structure address 
	C_LINE	35,"engine/enengine.h::enems_draw_current::1::127"
		;        IY = clipping rectangle, set it to "ClipStruct" for full screen 
	C_LINE	36,"engine/enengine.h::enems_draw_current::1::127"
		;        BC = animate bitdef displacement (0 for no animation) 
	C_LINE	37,"engine/enengine.h::enems_draw_current::1::127"
		;         H = new row coord in chars 
	C_LINE	38,"engine/enengine.h::enems_draw_current::1::127"
		;         L = new col coord in chars 
	C_LINE	39,"engine/enengine.h::enems_draw_current::1::127"
		;         D = new horizontal rotation (0..7) ie horizontal pixel position 
	C_LINE	40,"engine/enengine.h::enems_draw_current::1::127"
		;         E = new vertical rotation (0..7) ie vertical pixel position 
	C_LINE	42,"engine/enengine.h::enems_draw_current::1::127"
	C_LINE	43,"engine/enengine.h::enems_draw_current::1::127"
		ld  a, (_enit)
	C_LINE	44,"engine/enengine.h::enems_draw_current::1::127"
		sla a
	C_LINE	45,"engine/enengine.h::enems_draw_current::1::127"
		ld  c, a
	C_LINE	46,"engine/enengine.h::enems_draw_current::1::127"
		ld  b, 0 				 
	C_LINE	47,"engine/enengine.h::enems_draw_current::1::127"
		ld  hl, _sp_moviles
	C_LINE	48,"engine/enengine.h::enems_draw_current::1::127"
		add hl, bc
	C_LINE	49,"engine/enengine.h::enems_draw_current::1::127"
		ld  e, (hl)
	C_LINE	50,"engine/enengine.h::enems_draw_current::1::127"
		inc hl 
	C_LINE	51,"engine/enengine.h::enems_draw_current::1::127"
		ld  d, (hl)
	C_LINE	52,"engine/enengine.h::enems_draw_current::1::127"
		push de						
	C_LINE	53,"engine/enengine.h::enems_draw_current::1::127"
		pop ix
	C_LINE	55,"engine/enengine.h::enems_draw_current::1::127"
	C_LINE	56,"engine/enengine.h::enems_draw_current::1::127"
		ld  iy, vpClipStruct
	C_LINE	58,"engine/enengine.h::enems_draw_current::1::127"
	C_LINE	59,"engine/enengine.h::enems_draw_current::1::127"
	C_LINE	60,"engine/enengine.h::enems_draw_current::1::127"
		ld  hl, _en_an_current_frame
	C_LINE	61,"engine/enengine.h::enems_draw_current::1::127"
		add hl, bc 				 
	C_LINE	62,"engine/enengine.h::enems_draw_current::1::127"
		ld  e, (hl)
	C_LINE	63,"engine/enengine.h::enems_draw_current::1::127"
		inc hl 
	C_LINE	64,"engine/enengine.h::enems_draw_current::1::127"
		ld  d, (hl) 			 
	C_LINE	66,"engine/enengine.h::enems_draw_current::1::127"
		ld  hl, _en_an_next_frame
	C_LINE	67,"engine/enengine.h::enems_draw_current::1::127"
		add hl, bc 				 
	C_LINE	68,"engine/enengine.h::enems_draw_current::1::127"
		ld  a, (hl)
	C_LINE	69,"engine/enengine.h::enems_draw_current::1::127"
		inc hl
	C_LINE	70,"engine/enengine.h::enems_draw_current::1::127"
		ld  h, (hl)
	C_LINE	71,"engine/enengine.h::enems_draw_current::1::127"
		ld  l, a 				 
	C_LINE	73,"engine/enengine.h::enems_draw_current::1::127"
		or  a 					 
	C_LINE	74,"engine/enengine.h::enems_draw_current::1::127"
		sbc hl, de 				 
	C_LINE	76,"engine/enengine.h::enems_draw_current::1::127"
		push bc 				 
	C_LINE	78,"engine/enengine.h::enems_draw_current::1::127"
		ld  b, h
	C_LINE	79,"engine/enengine.h::enems_draw_current::1::127"
		ld  c, l 				 
	C_LINE	81,"engine/enengine.h::enems_draw_current::1::127"
	C_LINE	82,"engine/enengine.h::enems_draw_current::1::127"
		ld  a, (__en_y)					
	C_LINE	83,"engine/enengine.h::enems_draw_current::1::127"
		srl a
	C_LINE	84,"engine/enengine.h::enems_draw_current::1::127"
		srl a
	C_LINE	85,"engine/enengine.h::enems_draw_current::1::127"
		srl a
	C_LINE	86,"engine/enengine.h::enems_draw_current::1::127"
		add  1 
	C_LINE	87,"engine/enengine.h::enems_draw_current::1::127"
		ld h, a
	C_LINE	89,"engine/enengine.h::enems_draw_current::1::127"
		ld  a, (__en_x)
	C_LINE	90,"engine/enengine.h::enems_draw_current::1::127"
		srl a
	C_LINE	91,"engine/enengine.h::enems_draw_current::1::127"
		srl a
	C_LINE	92,"engine/enengine.h::enems_draw_current::1::127"
		srl a
	C_LINE	93,"engine/enengine.h::enems_draw_current::1::127"
		add  1 
	C_LINE	94,"engine/enengine.h::enems_draw_current::1::127"
		ld  l, a
	C_LINE	96,"engine/enengine.h::enems_draw_current::1::127"
	C_LINE	97,"engine/enengine.h::enems_draw_current::1::127"
		ld  a, (__en_x)
	C_LINE	98,"engine/enengine.h::enems_draw_current::1::127"
		and 7
	C_LINE	99,"engine/enengine.h::enems_draw_current::1::127"
		ld  d, a
	C_LINE	101,"engine/enengine.h::enems_draw_current::1::127"
		ld  a, (__en_y)
	C_LINE	102,"engine/enengine.h::enems_draw_current::1::127"
		and 7
	C_LINE	103,"engine/enengine.h::enems_draw_current::1::127"
		ld  e, a
	C_LINE	105,"engine/enengine.h::enems_draw_current::1::127"
		call SPMoveSprAbs
	C_LINE	107,"engine/enengine.h::enems_draw_current::1::127"
	C_LINE	109,"engine/enengine.h::enems_draw_current::1::127"
		pop bc 					 
	C_LINE	111,"engine/enengine.h::enems_draw_current::1::127"
		ld  hl, _en_an_current_frame
	C_LINE	112,"engine/enengine.h::enems_draw_current::1::127"
		add hl, bc
	C_LINE	113,"engine/enengine.h::enems_draw_current::1::127"
		ex  de, hl 				 
	C_LINE	115,"engine/enengine.h::enems_draw_current::1::127"
		ld  hl, _en_an_next_frame
	C_LINE	116,"engine/enengine.h::enems_draw_current::1::127"
		add hl, bc 				 
	C_LINE	117,"engine/enengine.h::enems_draw_current::1::127"
	C_LINE	118,"engine/enengine.h::enems_draw_current::1::127"
		ldi
	C_LINE	119,"engine/enengine.h::enems_draw_current::1::127"
		ldi
	C_LINE	120,"engine/enengine.h::enems_draw_current::1::127"
;}
	C_LINE	122,"engine/enengine.h::enems_draw_current::1::127"
	ret


;void enems_load (void) {
	C_LINE	124,"engine/enengine.h::enems_draw_current::0::127"
	C_LINE	124,"engine/enengine.h::enems_draw_current::0::127"

; Function enems_load flags 0x00000200 __smallc 
; void enems_load()
	C_LINE	124,"engine/enengine.h::enems_load::0::127"
._enems_load
	C_LINE	124,"engine/enengine.h::enems_load::0::127"
;	 
	C_LINE	125,"engine/enengine.h::enems_load::1::128"
;	enoffs = n_pant *  3 ;
	C_LINE	126,"engine/enengine.h::enems_load::1::128"
	C_LINE	126,"engine/enengine.h::enems_load::1::128"
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_enoffs),a
;	
	C_LINE	127,"engine/enengine.h::enems_load::1::128"
;	for (enit = 0; enit <  3 ; ++ enit) {
	C_LINE	128,"engine/enengine.h::enems_load::1::128"
	C_LINE	128,"engine/enengine.h::enems_load::1::128"
	xor	a
	ld	(_enit),a
	jp	i_205	;EOS
.i_203
	ld	hl,_enit
	inc	(hl)
	ld	l,(hl)
	ld	h,0
.i_205
	ld	hl,(_enit)
	ld	h,0
	ld	a,l
	sub	3
	jp	nc,i_204	;
;		en_an_frame [enit] = 0;
	C_LINE	129,"engine/enengine.h::enems_load::3::129"
	C_LINE	129,"engine/enengine.h::enems_load::3::129"
	ld	de,_en_an_frame
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	l,(hl)
	ld	h,0
;		en_an_state [enit] = 0;
	C_LINE	130,"engine/enengine.h::enems_load::3::129"
	C_LINE	130,"engine/enengine.h::enems_load::3::129"
	ld	de,_en_an_state
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	l,(hl)
	ld	h,0
;		en_an_count [enit] = 3;
	C_LINE	131,"engine/enengine.h::enems_load::3::129"
	C_LINE	131,"engine/enengine.h::enems_load::3::129"
	ld	de,_en_an_count
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	(hl),3
	ld	l,(hl)
	ld	h,0
;		enoffsmasi = enoffs + enit;
	C_LINE	132,"engine/enengine.h::enems_load::3::129"
	C_LINE	132,"engine/enengine.h::enems_load::3::129"
	ld	de,(_enoffs)
	ld	d,0
	ld	hl,(_enit)
	ld	h,d
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_enoffsmasi),a
;					 
	C_LINE	134,"engine/enengine.h::enems_load::3::129"
;			malotes [enoffsmasi].t &= 0xEF;		
	C_LINE	135,"engine/enengine.h::enems_load::3::129"
	C_LINE	135,"engine/enengine.h::enems_load::3::129"
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	push	hl
	ld	a,(hl)
	and	239
	ld	l,a
	ld	h,0
	pop	de
	ld	a,l
	ld	(de),a
;							
	C_LINE	136,"engine/enengine.h::enems_load::3::129"
;					malotes [enoffsmasi].life =  2 ;
	C_LINE	139,"engine/enengine.h::enems_load::3::129"
	C_LINE	139,"engine/enengine.h::enems_load::3::129"
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,9
	add	hl,bc
	ld	(hl),2
	ld	l,(hl)
	ld	h,0
;				
	C_LINE	140,"engine/enengine.h::enems_load::3::129"
;			
	C_LINE	141,"engine/enengine.h::enems_load::3::129"
;		
	C_LINE	142,"engine/enengine.h::enems_load::3::129"
;		#line 1 "./my/ci/enems_custom_respawn.h"
	C_LINE	144,"engine/enengine.h::enems_load::3::129"
	C_LINE	0,"./my/ci/enems_custom_respawn.h::enems_load::3::129"
; 
	C_LINE	1,"./my/ci/enems_custom_respawn.h::enems_load::3::129"
; 
	C_LINE	2,"./my/ci/enems_custom_respawn.h::enems_load::3::129"
; 
	C_LINE	4,"./my/ci/enems_custom_respawn.h::enems_load::3::129"
;#line 145 "engine/enengine.h"
	C_LINE	6,"./my/ci/enems_custom_respawn.h::enems_load::3::129"
	C_LINE	144,"engine/enengine.h::enems_load::3::129"
;		en_an_next_frame [enit] = sprite_18_a;
	C_LINE	146,"engine/enengine.h::enems_load::3::129"
	C_LINE	146,"engine/enengine.h::enems_load::3::129"
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_enit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,_sprite_18_a
	call	l_pint
;		switch (malotes [enoffsmasi].t & 0x1f) {
	C_LINE	148,"engine/enengine.h::enems_load::3::129"
	C_LINE	148,"engine/enengine.h::enems_load::3::129"
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	ld	a,(hl)
	and	31
	ld	l,a
	ld	h,0
.i_208
	ld	a,l
	cp	+(1% 256)
	jp	z,i_209	;
	cp	+(2% 256)
	jp	z,i_210	;
	cp	+(3% 256)
	jp	z,i_211	;
	cp	+(4% 256)
	jp	z,i_212	;
	cp	+(5% 256)
	jp	z,i_213	;
	cp	+(7% 256)
	jp	z,i_214	;
	jp	i_207	;EOS
;			case 1:
	C_LINE	149,"engine/enengine.h::enems_load::4::130"
	C_LINE	149,"engine/enengine.h::enems_load::4::130"
.i_209
;			case 2:
	C_LINE	150,"engine/enengine.h::enems_load::4::130"
	C_LINE	150,"engine/enengine.h::enems_load::4::130"
.i_210
;			case 3:
	C_LINE	151,"engine/enengine.h::enems_load::4::130"
	C_LINE	151,"engine/enengine.h::enems_load::4::130"
.i_211
;			case 4:
	C_LINE	152,"engine/enengine.h::enems_load::4::130"
	C_LINE	152,"engine/enengine.h::enems_load::4::130"
.i_212
;				en_an_base_frame [enit] = (malotes [enoffsmasi].t - 1) << 1;
	C_LINE	153,"engine/enengine.h::enems_load::4::130"
	C_LINE	153,"engine/enengine.h::enems_load::4::130"
	ld	de,_en_an_base_frame
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	ld	l,(hl)
	ld	h,0
	dec	hl
	add	hl,hl
	pop	de
	ld	a,l
	ld	(de),a
;				break;
	C_LINE	154,"engine/enengine.h::enems_load::4::130"
	C_LINE	154,"engine/enengine.h::enems_load::4::130"
	jp	i_207	;EOS
;			
	C_LINE	156,"engine/enengine.h::enems_load::4::130"
;				case 5:					
	C_LINE	157,"engine/enengine.h::enems_load::4::130"
	C_LINE	157,"engine/enengine.h::enems_load::4::130"
.i_213
;					
	C_LINE	158,"engine/enengine.h::enems_load::4::130"
;						en_an_base_frame [enit] =  3  << 1;
	C_LINE	162,"engine/enengine.h::enems_load::4::130"
	C_LINE	162,"engine/enengine.h::enems_load::4::130"
	ld	de,_en_an_base_frame
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	(hl),6
	ld	l,(hl)
	ld	h,0
;					
	C_LINE	163,"engine/enengine.h::enems_load::4::130"
;					en_an_state [enit] = malotes [enoffsmasi].t >> 6;
	C_LINE	164,"engine/enengine.h::enems_load::4::130"
	C_LINE	164,"engine/enengine.h::enems_load::4::130"
	ld	de,_en_an_state
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,_malotes
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	ld	l,(hl)
	ld	h,0
	ld	a,l
	rlca
	rlca
	and	3
	ld	l,a
	pop	de
	ld	(de),a
;					break;
	C_LINE	165,"engine/enengine.h::enems_load::4::130"
	C_LINE	165,"engine/enengine.h::enems_load::4::130"
	jp	i_207	;EOS
;			
	C_LINE	166,"engine/enengine.h::enems_load::4::130"
;			
	C_LINE	168,"engine/enengine.h::enems_load::4::130"
;			
	C_LINE	184,"engine/enengine.h::enems_load::4::130"
;				case 7:
	C_LINE	185,"engine/enengine.h::enems_load::4::130"
	C_LINE	185,"engine/enengine.h::enems_load::4::130"
.i_214
;					enems_pursuers_init ();
	C_LINE	186,"engine/enengine.h::enems_load::4::130"
	C_LINE	186,"engine/enengine.h::enems_load::4::130"
	call	_enems_pursuers_init
;					break;
	C_LINE	187,"engine/enengine.h::enems_load::4::130"
	C_LINE	187,"engine/enengine.h::enems_load::4::130"
	jp	i_207	;EOS
;			
	C_LINE	188,"engine/enengine.h::enems_load::4::130"
;				#line 1 "./my/ci/enems_load.h"
	C_LINE	190,"engine/enengine.h::enems_load::4::130"
	C_LINE	0,"./my/ci/enems_load.h::enems_load::4::130"
; 
	C_LINE	1,"./my/ci/enems_load.h::enems_load::4::130"
; 
	C_LINE	2,"./my/ci/enems_load.h::enems_load::4::130"
;#line 191 "engine/enengine.h"
	C_LINE	4,"./my/ci/enems_load.h::enems_load::4::130"
	C_LINE	190,"engine/enengine.h::enems_load::4::130"
;		}
	C_LINE	191,"engine/enengine.h::enems_load::4::130"
.i_207
;		#line 1 "./my/ci/enems_extra_mods.h"
	C_LINE	193,"engine/enengine.h::enems_load::3::130"
	C_LINE	0,"./my/ci/enems_extra_mods.h::enems_load::3::130"
; 
	C_LINE	1,"./my/ci/enems_extra_mods.h::enems_load::3::130"
; 
	C_LINE	2,"./my/ci/enems_extra_mods.h::enems_load::3::130"
;#line 194 "engine/enengine.h"
	C_LINE	3,"./my/ci/enems_extra_mods.h::enems_load::3::130"
	C_LINE	193,"engine/enengine.h::enems_load::3::130"
;	}
	C_LINE	194,"engine/enengine.h::enems_load::3::130"
	jp	i_203	;EOS
.i_204
;}
	C_LINE	195,"engine/enengine.h::enems_load::1::130"
	ret


;void enems_kill (void) {
	C_LINE	197,"engine/enengine.h::enems_load::0::130"
	C_LINE	197,"engine/enengine.h::enems_load::0::130"

; Function enems_kill flags 0x00000200 __smallc 
; void enems_kill()
	C_LINE	197,"engine/enengine.h::enems_kill::0::130"
._enems_kill
	C_LINE	197,"engine/enengine.h::enems_kill::0::130"
;	if (_en_t != 7) _en_t |= 16;
	C_LINE	198,"engine/enengine.h::enems_kill::1::131"
	C_LINE	198,"engine/enengine.h::enems_kill::1::131"
	ld	a,(__en_t)
	cp	7
	jp	z,i_215	;
	ld	hl,__en_t
	call	l_gchar
	set	4,l
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(__en_t),a
;	++ p_killed;
	C_LINE	199,"engine/enengine.h::enems_kill::1::131"
.i_215
	C_LINE	199,"engine/enengine.h::enems_kill::1::131"
	ld	hl,_p_killed
	inc	(hl)
	ld	l,(hl)
	ld	h,0
;	
	C_LINE	201,"engine/enengine.h::enems_kill::1::131"
;	#line 1 "./my/ci/on_enems_killed.h"
	C_LINE	205,"engine/enengine.h::enems_kill::1::131"
	C_LINE	0,"./my/ci/on_enems_killed.h::enems_kill::1::131"
; 
	C_LINE	1,"./my/ci/on_enems_killed.h::enems_kill::1::131"
; 
	C_LINE	2,"./my/ci/on_enems_killed.h::enems_kill::1::131"
;#line 206 "engine/enengine.h"
	C_LINE	4,"./my/ci/on_enems_killed.h::enems_kill::1::131"
	C_LINE	205,"engine/enengine.h::enems_kill::1::131"
;	
	C_LINE	207,"engine/enengine.h::enems_kill::1::131"
; 
	C_LINE	208,"engine/enengine.h::enems_kill::1::131"
;}
	C_LINE	210,"engine/enengine.h::enems_kill::1::131"
	ret


;void enems_move (void) {
	C_LINE	212,"engine/enengine.h::enems_kill::0::131"
	C_LINE	212,"engine/enengine.h::enems_kill::0::131"

; Function enems_move flags 0x00000200 __smallc 
; void enems_move()
	C_LINE	212,"engine/enengine.h::enems_move::0::131"
._enems_move
	C_LINE	212,"engine/enengine.h::enems_move::0::131"
;	tocado = p_gotten = ptgmx = ptgmy = 0;
	C_LINE	213,"engine/enengine.h::enems_move::1::132"
	C_LINE	213,"engine/enengine.h::enems_move::1::132"
	ld	hl,0	;const
	ld	(_ptgmy),hl
	ld	(_ptgmx),hl
	ld	a,l
	ld	(_p_gotten),a
	ld	(_tocado),a
;	for (enit = 0; enit <  3 ; enit ++) {
	C_LINE	215,"engine/enengine.h::enems_move::1::132"
	C_LINE	215,"engine/enengine.h::enems_move::1::132"
	xor	a
	ld	(_enit),a
	jp	i_218	;EOS
.i_216
	ld	hl,_enit
	ld	a,(hl)
	inc	(hl)
.i_218
	ld	hl,(_enit)
	ld	h,0
	ld	a,l
	sub	3
	jp	nc,i_217	;
;		active = 0;
	C_LINE	216,"engine/enengine.h::enems_move::3::133"
	C_LINE	216,"engine/enengine.h::enems_move::3::133"
	ld	hl,0	;const
	ld	a,l
	ld	(_active),a
;		enoffsmasi = enoffs + enit;
	C_LINE	217,"engine/enengine.h::enems_move::3::133"
	C_LINE	217,"engine/enengine.h::enems_move::3::133"
	ld	de,(_enoffs)
	ld	d,0
	ld	hl,(_enit)
	ld	h,d
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_enoffsmasi),a
;		 
	C_LINE	219,"engine/enengine.h::enems_move::3::133"
;		
	C_LINE	220,"engine/enengine.h::enems_move::3::133"
;		#asm
	C_LINE	221,"engine/enengine.h::enems_move::3::133"
	C_LINE	221,"engine/enengine.h::enems_move::3::133"
	C_LINE	223,"engine/enengine.h::enems_move::3::133"
	C_LINE	224,"engine/enengine.h::enems_move::3::133"
	C_LINE	225,"engine/enengine.h::enems_move::3::133"
	C_LINE	226,"engine/enengine.h::enems_move::3::133"
	C_LINE	227,"engine/enengine.h::enems_move::3::133"
				ld 	hl, (_enoffsmasi)
	C_LINE	228,"engine/enengine.h::enems_move::3::133"
				ld  h, 0
	C_LINE	230,"engine/enengine.h::enems_move::3::133"
							add hl, hl 				 
	C_LINE	231,"engine/enengine.h::enems_move::3::133"
				ld  d, h
	C_LINE	232,"engine/enengine.h::enems_move::3::133"
				ld  e, l 				 
	C_LINE	233,"engine/enengine.h::enems_move::3::133"
				add hl, hl 				 
	C_LINE	234,"engine/enengine.h::enems_move::3::133"
				add hl, hl 				 
	C_LINE	236,"engine/enengine.h::enems_move::3::133"
				add hl, de 				 
	C_LINE	237,"engine/enengine.h::enems_move::3::133"
	C_LINE	239,"engine/enengine.h::enems_move::3::133"
	C_LINE	240,"engine/enengine.h::enems_move::3::133"
	C_LINE	241,"engine/enengine.h::enems_move::3::133"
	C_LINE	242,"engine/enengine.h::enems_move::3::133"
	C_LINE	244,"engine/enengine.h::enems_move::3::133"
	C_LINE	247,"engine/enengine.h::enems_move::3::133"
				ld  de, _malotes
	C_LINE	248,"engine/enengine.h::enems_move::3::133"
				add hl, de
	C_LINE	250,"engine/enengine.h::enems_move::3::133"
				ld  (__baddies_pointer), hl 		 
	C_LINE	252,"engine/enengine.h::enems_move::3::133"
				ld  a, (hl)
	C_LINE	253,"engine/enengine.h::enems_move::3::133"
				ld  (__en_x), a
	C_LINE	254,"engine/enengine.h::enems_move::3::133"
				inc hl 
	C_LINE	256,"engine/enengine.h::enems_move::3::133"
				ld  a, (hl)
	C_LINE	257,"engine/enengine.h::enems_move::3::133"
				ld  (__en_y), a
	C_LINE	258,"engine/enengine.h::enems_move::3::133"
				inc hl 
	C_LINE	260,"engine/enengine.h::enems_move::3::133"
				ld  a, (hl)
	C_LINE	261,"engine/enengine.h::enems_move::3::133"
				ld  (__en_x1), a
	C_LINE	262,"engine/enengine.h::enems_move::3::133"
				inc hl 
	C_LINE	264,"engine/enengine.h::enems_move::3::133"
				ld  a, (hl)
	C_LINE	265,"engine/enengine.h::enems_move::3::133"
				ld  (__en_y1), a
	C_LINE	266,"engine/enengine.h::enems_move::3::133"
				inc hl 
	C_LINE	268,"engine/enengine.h::enems_move::3::133"
				ld  a, (hl)
	C_LINE	269,"engine/enengine.h::enems_move::3::133"
				ld  (__en_x2), a
	C_LINE	270,"engine/enengine.h::enems_move::3::133"
				inc hl 
	C_LINE	272,"engine/enengine.h::enems_move::3::133"
				ld  a, (hl)
	C_LINE	273,"engine/enengine.h::enems_move::3::133"
				ld  (__en_y2), a
	C_LINE	274,"engine/enengine.h::enems_move::3::133"
				inc hl 
	C_LINE	276,"engine/enengine.h::enems_move::3::133"
				ld  a, (hl)
	C_LINE	277,"engine/enengine.h::enems_move::3::133"
				ld  (__en_mx), a
	C_LINE	278,"engine/enengine.h::enems_move::3::133"
				inc hl 
	C_LINE	280,"engine/enengine.h::enems_move::3::133"
				ld  a, (hl)
	C_LINE	281,"engine/enengine.h::enems_move::3::133"
				ld  (__en_my), a
	C_LINE	282,"engine/enengine.h::enems_move::3::133"
				inc hl 
	C_LINE	284,"engine/enengine.h::enems_move::3::133"
				ld  a, (hl)
	C_LINE	285,"engine/enengine.h::enems_move::3::133"
				ld  (__en_t), a
	C_LINE	286,"engine/enengine.h::enems_move::3::133"
				and 0x1f
	C_LINE	287,"engine/enengine.h::enems_move::3::133"
				ld  (_rdt), a
	C_LINE	289,"engine/enengine.h::enems_move::3::133"
	C_LINE	290,"engine/enengine.h::enems_move::3::133"
				inc hl 
	C_LINE	292,"engine/enengine.h::enems_move::3::133"
				ld  a, (hl)
	C_LINE	293,"engine/enengine.h::enems_move::3::133"
				ld  (__en_life), a
	C_LINE	294,"engine/enengine.h::enems_move::3::133"
	C_LINE	295,"engine/enengine.h::enems_move::3::133"
;					_en_cx = _en_x; _en_cy = _en_y;
	C_LINE	298,"engine/enengine.h::enems_move::3::133"
	C_LINE	298,"engine/enengine.h::enems_move::3::133"
	ld	a,(__en_x)
	ld	(__en_cx),a
	ld	hl,(__en_y)
	ld	h,0
	ld	a,l
	ld	(__en_cy),a
;		
	C_LINE	299,"engine/enengine.h::enems_move::3::133"
;		
	C_LINE	300,"engine/enengine.h::enems_move::3::133"
;		
	C_LINE	301,"engine/enengine.h::enems_move::3::133"
;		
	C_LINE	312,"engine/enengine.h::enems_move::3::133"
;		switch (rdt) {
	C_LINE	320,"engine/enengine.h::enems_move::3::133"
	C_LINE	320,"engine/enengine.h::enems_move::3::133"
	ld	hl,(_rdt)
	ld	h,0
.i_221
	ld	a,l
	cp	+(1% 256)
	jp	z,i_222	;
	cp	+(2% 256)
	jp	z,i_223	;
	cp	+(3% 256)
	jp	z,i_224	;
	cp	+(4% 256)
	jp	z,i_225	;
	cp	+(5% 256)
	jp	z,i_226	;
	cp	+(7% 256)
	jp	z,i_229	;
	jp	i_220	;EOS
;			case 1:
	C_LINE	321,"engine/enengine.h::enems_move::4::134"
	C_LINE	321,"engine/enengine.h::enems_move::4::134"
.i_222
;			case 2:
	C_LINE	322,"engine/enengine.h::enems_move::4::134"
	C_LINE	322,"engine/enengine.h::enems_move::4::134"
.i_223
;			case 3:
	C_LINE	323,"engine/enengine.h::enems_move::4::134"
	C_LINE	323,"engine/enengine.h::enems_move::4::134"
.i_224
;			case 4:
	C_LINE	324,"engine/enengine.h::enems_move::4::134"
	C_LINE	324,"engine/enengine.h::enems_move::4::134"
.i_225
;			
	C_LINE	325,"engine/enengine.h::enems_move::4::134"
;				case 5:
	C_LINE	326,"engine/enengine.h::enems_move::4::134"
	C_LINE	326,"engine/enengine.h::enems_move::4::134"
.i_226
;			
	C_LINE	327,"engine/enengine.h::enems_move::4::134"
;				#line 1 "./engine/enem_mods/enem_type_lineal.h"
	C_LINE	328,"engine/enengine.h::enems_move::4::134"
	C_LINE	0,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
; 
	C_LINE	1,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
; 
	C_LINE	2,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
; 
	C_LINE	4,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
; 
	C_LINE	6,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
;#asm
	C_LINE	20,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
	C_LINE	20,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
	C_LINE	22,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld 	a, 1
	C_LINE	23,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  (_active), a
	C_LINE	25,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  a, (__en_mx)
	C_LINE	26,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  c, a
	C_LINE	27,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  a, (__en_x)
	C_LINE	28,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		add a, c
	C_LINE	29,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  (__en_x), a
	C_LINE	31,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  c, a
	C_LINE	32,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  a, (__en_x1)
	C_LINE	33,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		cp  c
	C_LINE	34,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		jr  z, _enems_lm_change_axis_x
	C_LINE	35,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  a, (__en_x2)
	C_LINE	36,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		cp  c
	C_LINE	38,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
			jr  z, _enems_lm_change_axis_x
	C_LINE	39,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
	C_LINE	40,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		call _mons_col_sc_x
	C_LINE	41,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		xor a
	C_LINE	42,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		or l
	C_LINE	44,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		jr  z, _enems_lm_change_axis_x_done
	C_LINE	45,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
	C_LINE	49,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
	._enems_lm_change_axis_x
	C_LINE	50,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  a, (__en_mx)
	C_LINE	51,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		neg
	C_LINE	52,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  (__en_mx), a
	C_LINE	54,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
	._enems_lm_change_axis_x_done
	C_LINE	56,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  a, (__en_my)
	C_LINE	57,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  c, a
	C_LINE	58,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  a, (__en_y)
	C_LINE	59,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		add a, c
	C_LINE	60,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  (__en_y), a
	C_LINE	62,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  c, a
	C_LINE	63,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  a, (__en_y1)
	C_LINE	64,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		cp  c
	C_LINE	65,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		jr  z, _enems_lm_change_axis_y
	C_LINE	66,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  a, (__en_y2)
	C_LINE	67,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		cp  c
	C_LINE	69,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
	C_LINE	70,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		jr  z, _enems_lm_change_axis_y
	C_LINE	71,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
	C_LINE	72,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		call _mons_col_sc_y
	C_LINE	73,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		xor a
	C_LINE	74,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		or l
	C_LINE	76,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		jr  z, _enems_lm_change_axis_y_done
	C_LINE	77,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
	C_LINE	80,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
	C_LINE	81,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
	._enems_lm_change_axis_y
	C_LINE	82,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  a, (__en_my)
	C_LINE	83,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		neg
	C_LINE	84,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
		ld  (__en_my), a
	C_LINE	86,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
	._enems_lm_change_axis_y_done
	C_LINE	88,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
;	
	C_LINE	90,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
;#line 329 "engine/enengine.h"
	C_LINE	91,"./engine/enem_mods/enem_type_lineal.h::enems_move::4::134"
	C_LINE	328,"engine/enengine.h::enems_move::4::134"
;				
	C_LINE	329,"engine/enengine.h::enems_move::4::134"
;					if (rdt == 5) {
	C_LINE	330,"engine/enengine.h::enems_move::4::134"
	C_LINE	330,"engine/enengine.h::enems_move::4::134"
	ld	hl,(_rdt)
	ld	h,0
	ld	a,l
	cp	5
	jp	nz,i_227	;
;						#line 1 "./engine/enem_mods/enem_type_orthoshooters.h"
	C_LINE	331,"engine/enengine.h::enems_move::5::135"
	C_LINE	0,"./engine/enem_mods/enem_type_orthoshooters.h::enems_move::5::135"
; 
	C_LINE	1,"./engine/enem_mods/enem_type_orthoshooters.h::enems_move::5::135"
; 
	C_LINE	2,"./engine/enem_mods/enem_type_orthoshooters.h::enems_move::5::135"
;	 
	C_LINE	4,"./engine/enem_mods/enem_type_orthoshooters.h::enems_move::5::135"
;	
	C_LINE	5,"./engine/enem_mods/enem_type_orthoshooters.h::enems_move::5::135"
;	if ( (rand()&15)  == 1) {
	C_LINE	6,"./engine/enem_mods/enem_type_orthoshooters.h::enems_move::5::135"
	C_LINE	6,"./engine/enem_mods/enem_type_orthoshooters.h::enems_move::5::135"
	call	_rand
	ld	a,l
	and	15
	ld	l,a
	ld	h,0
	cp	1
	jp	nz,i_228	;
;		rda = en_an_state [enit];
	C_LINE	7,"./engine/enem_mods/enem_type_orthoshooters.h::enems_move::6::136"
	C_LINE	7,"./engine/enem_mods/enem_type_orthoshooters.h::enems_move::6::136"
	ld	de,_en_an_state
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rda),a
;		simple_coco_shoot ();
	C_LINE	8,"./engine/enem_mods/enem_type_orthoshooters.h::enems_move::6::136"
	C_LINE	8,"./engine/enem_mods/enem_type_orthoshooters.h::enems_move::6::136"
	call	_simple_coco_shoot
;	} 
	C_LINE	9,"./engine/enem_mods/enem_type_orthoshooters.h::enems_move::6::136"
;#line 332 "engine/enengine.h"
	C_LINE	10,"./engine/enem_mods/enem_type_orthoshooters.h::enems_move::5::136"
	C_LINE	331,"engine/enengine.h::enems_move::5::136"
;					}
	C_LINE	332,"engine/enengine.h::enems_move::5::136"
.i_228
;				
	C_LINE	333,"engine/enengine.h::enems_move::4::136"
;				break;
	C_LINE	334,"engine/enengine.h::enems_move::4::136"
.i_227
	C_LINE	334,"engine/enengine.h::enems_move::4::136"
	jp	i_220	;EOS
;			
	C_LINE	336,"engine/enengine.h::enems_move::4::136"
;			
	C_LINE	341,"engine/enengine.h::enems_move::4::136"
;				case 7:
	C_LINE	342,"engine/enengine.h::enems_move::4::136"
	C_LINE	342,"engine/enengine.h::enems_move::4::136"
.i_229
;					#line 1 "./engine/enem_mods/enem_type_pursuers_asm.h"
	C_LINE	343,"engine/enengine.h::enems_move::4::136"
	C_LINE	0,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
; 
	C_LINE	1,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
; 
	C_LINE	2,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
; 
	C_LINE	4,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
; 
	C_LINE	5,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
;#asm
	C_LINE	7,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	C_LINE	7,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	C_LINE	9,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  bc, (_enit)
	C_LINE	10,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  b, 0
	C_LINE	11,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  hl, _en_an_alive
	C_LINE	12,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		add hl, bc
	C_LINE	13,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (hl)
	C_LINE	15,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		cp  1
	C_LINE	16,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jp  z, _eij_state_appearing
	C_LINE	18,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		cp  2
	C_LINE	19,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jp  z, _eij_state_moving
	C_LINE	21,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_state_idle
	C_LINE	22,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  hl, _en_an_dead_row
	C_LINE	23,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		add hl, bc
	C_LINE	24,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (hl)
	C_LINE	25,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		or  a
	C_LINE	26,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jr  nz, _eij_state_still_idle
	C_LINE	28,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (__en_x1)
	C_LINE	29,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (__en_x), a
	C_LINE	30,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (__en_y1)
	C_LINE	31,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (__en_y), a
	C_LINE	33,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  hl, _en_an_alive
	C_LINE	34,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		add hl, bc
	C_LINE	35,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, 1
	C_LINE	36,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (hl), a
	C_LINE	38,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	C_LINE	39,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		push bc
	C_LINE	40,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		call _rand		 
	C_LINE	41,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	C_LINE	42,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, l
	C_LINE	43,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		and 3
	C_LINE	44,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  l, a
	C_LINE	45,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  h, 0
	C_LINE	47,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld	de, 1
	C_LINE	48,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		call l_asl 		 
	C_LINE	49,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, l
	C_LINE	50,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		pop bc
	C_LINE	52,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		cp   2 +1
	C_LINE	53,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jr  c, _eij_rawv_set
	C_LINE	55,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, 2
	C_LINE	57,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_rawv_set
	C_LINE	58,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  hl, _en_an_rawv
	C_LINE	59,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		add hl, bc
	C_LINE	60,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (hl), a
	C_LINE	62,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		call _rand
	C_LINE	63,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, l
	C_LINE	64,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		and  7 
	C_LINE	65,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		add  11 
	C_LINE	67,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  hl, _en_an_dead_row
	C_LINE	68,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		add hl, bc
	C_LINE	69,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (hl), a
	C_LINE	71,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
					ld  a,  2 
	C_LINE	72,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
			ld  (__en_life), a
	C_LINE	73,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	C_LINE	74,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jp  _eij_state_done
	C_LINE	76,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_state_still_idle
	C_LINE	77,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		dec a
	C_LINE	78,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (hl), a
	C_LINE	79,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jp  _eij_state_done
	C_LINE	81,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_state_appearing
	C_LINE	82,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  hl, _en_an_dead_row
	C_LINE	83,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		add hl, bc
	C_LINE	84,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (hl)
	C_LINE	85,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		or  a
	C_LINE	86,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jr  nz, _eij_state_still_appearing
	C_LINE	88,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	C_LINE	89,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
			ld  a,  3 *2
	C_LINE	90,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	C_LINE	97,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  hl, _en_an_base_frame
	C_LINE	98,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		add hl, bc
	C_LINE	99,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (hl), a
	C_LINE	101,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, 2
	C_LINE	102,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  hl, _en_an_alive
	C_LINE	103,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		add hl, bc
	C_LINE	104,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (hl), a
	C_LINE	105,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jp  _eij_state_done
	C_LINE	107,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_state_still_appearing
	C_LINE	108,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		dec a
	C_LINE	109,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (hl), a
	C_LINE	110,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  hl, _en_an_next_frame
	C_LINE	111,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		add hl, bc
	C_LINE	112,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		add hl, bc
	C_LINE	113,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  de, _sprite_17_a
	C_LINE	114,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ex de, hl
	C_LINE	115,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		call l_pint
	C_LINE	116,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jp  _eij_state_done
	C_LINE	118,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_state_moving
	C_LINE	119,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, 1
	C_LINE	120,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (_active), a
	C_LINE	122,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  hl, _en_an_rawv
	C_LINE	123,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		add hl, bc
	C_LINE	124,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (hl)
	C_LINE	125,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (_rda), a
	C_LINE	127,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (_p_estado)
	C_LINE	128,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		or  a
	C_LINE	129,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jr  nz, _eij_state_done
	C_LINE	131,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_state_moving_x
	C_LINE	132,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		call _rand
	C_LINE	133,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, l
	C_LINE	134,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		and 3
	C_LINE	135,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jr  z, _eij_state_moving_y
	C_LINE	137,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (__en_x)
	C_LINE	138,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  d, a
	C_LINE	139,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (_gpx)
	C_LINE	140,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		cp  d
	C_LINE	141,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jr  z, _eij_state_moving_y
	C_LINE	143,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jr  c, _eij_state_moving_x_left
	C_LINE	145,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_state_moving_x_right
	C_LINE	146,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (_rda)
	C_LINE	147,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (__en_mx), a
	C_LINE	148,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jr  _eij_state_moving_x_set
	C_LINE	150,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_state_moving_x_left
	C_LINE	151,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (_rda)
	C_LINE	152,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		neg
	C_LINE	153,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (__en_mx), a
	C_LINE	155,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_state_moving_x_set
	C_LINE	156,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		add d
	C_LINE	157,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (__en_x), a
	C_LINE	159,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		call _mons_col_sc_x
	C_LINE	160,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		xor a
	C_LINE	161,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		or  l
	C_LINE	162,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jr  z, _eij_state_moving_y
	C_LINE	164,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (__en_cx)
	C_LINE	165,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (__en_x), a
	C_LINE	167,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_state_moving_y
	C_LINE	168,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		call _rand
	C_LINE	169,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, l
	C_LINE	170,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		and 3
	C_LINE	171,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jr  z, _eij_state_done
	C_LINE	173,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (__en_y)
	C_LINE	174,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  d, a
	C_LINE	175,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (_gpy)
	C_LINE	176,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		cp  d
	C_LINE	177,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jr  z, _eij_state_done
	C_LINE	179,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jr  c, _eij_state_moving_y_up
	C_LINE	181,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_state_moving_y_down
	C_LINE	182,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (_rda)
	C_LINE	183,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (__en_my), a
	C_LINE	184,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jr  _eij_state_moving_y_set
	C_LINE	186,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_state_moving_y_up
	C_LINE	187,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (_rda)
	C_LINE	188,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		neg
	C_LINE	189,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (__en_my), a
	C_LINE	191,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_state_moving_y_set
	C_LINE	192,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		add d
	C_LINE	193,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (__en_y), a
	C_LINE	195,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		call _mons_col_sc_y
	C_LINE	196,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		xor a
	C_LINE	197,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		or  l
	C_LINE	198,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		jr  z, _eij_state_done
	C_LINE	200,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  a, (__en_cy)
	C_LINE	201,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
		ld  (__en_y), a
	C_LINE	203,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	._eij_state_done
	C_LINE	204,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
;#line 344 "engine/enengine.h"
	C_LINE	206,"./engine/enem_mods/enem_type_pursuers_asm.h::enems_move::4::136"
	C_LINE	343,"engine/enengine.h::enems_move::4::136"
;					break;	
	C_LINE	344,"engine/enengine.h::enems_move::4::136"
	C_LINE	344,"engine/enengine.h::enems_move::4::136"
	jp	i_220	;EOS
;			
	C_LINE	345,"engine/enengine.h::enems_move::4::136"
;			#line 1 "./my/ci/enems_move.h"
	C_LINE	346,"engine/enengine.h::enems_move::4::136"
	C_LINE	0,"./my/ci/enems_move.h::enems_move::4::136"
; 
	C_LINE	1,"./my/ci/enems_move.h::enems_move::4::136"
; 
	C_LINE	2,"./my/ci/enems_move.h::enems_move::4::136"
;#line 347 "engine/enengine.h"
	C_LINE	4,"./my/ci/enems_move.h::enems_move::4::136"
	C_LINE	346,"engine/enengine.h::enems_move::4::136"
;			 
	C_LINE	347,"engine/enengine.h::enems_move::4::136"
;		}
	C_LINE	351,"engine/enengine.h::enems_move::4::136"
.i_220
;		
	C_LINE	352,"engine/enengine.h::enems_move::3::136"
;		if (active) {			
	C_LINE	353,"engine/enengine.h::enems_move::3::136"
	C_LINE	353,"engine/enengine.h::enems_move::3::136"
	ld	hl,(_active)
	ld	a,l
	and	a
	jp	z,i_230	;
;			 
	C_LINE	354,"engine/enengine.h::enems_move::4::137"
;			if (en_an_base_frame [enit] != 99) {
	C_LINE	355,"engine/enengine.h::enems_move::4::137"
	C_LINE	355,"engine/enengine.h::enems_move::4::137"
	ld	de,_en_an_base_frame
	ld	hl,(_enit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	cp	99
	jp	z,i_231	;
;				 
	C_LINE	356,"engine/enengine.h::enems_move::5::138"
;				#asm
	C_LINE	364,"engine/enengine.h::enems_move::5::138"
	C_LINE	364,"engine/enengine.h::enems_move::5::138"
	C_LINE	366,"engine/enengine.h::enems_move::5::138"
						ld  bc, (_enit)
	C_LINE	367,"engine/enengine.h::enems_move::5::138"
						ld  b, 0
	C_LINE	369,"engine/enengine.h::enems_move::5::138"
						ld  hl, _en_an_count
	C_LINE	370,"engine/enengine.h::enems_move::5::138"
						add hl, bc
	C_LINE	371,"engine/enengine.h::enems_move::5::138"
						ld  a, (hl)
	C_LINE	372,"engine/enengine.h::enems_move::5::138"
						inc a
	C_LINE	373,"engine/enengine.h::enems_move::5::138"
						ld  (hl), a
	C_LINE	375,"engine/enengine.h::enems_move::5::138"
						cp  4
	C_LINE	376,"engine/enengine.h::enems_move::5::138"
						jr  nz, _enems_move_update_frame_done
	C_LINE	378,"engine/enengine.h::enems_move::5::138"
						xor a
	C_LINE	379,"engine/enengine.h::enems_move::5::138"
						ld  (hl), a
	C_LINE	381,"engine/enengine.h::enems_move::5::138"
						ld  hl, _en_an_frame
	C_LINE	382,"engine/enengine.h::enems_move::5::138"
						add hl, bc
	C_LINE	383,"engine/enengine.h::enems_move::5::138"
						ld  a, (hl)
	C_LINE	384,"engine/enengine.h::enems_move::5::138"
						xor 1
	C_LINE	385,"engine/enengine.h::enems_move::5::138"
						ld  (hl), a
	C_LINE	386,"engine/enengine.h::enems_move::5::138"
	C_LINE	387,"engine/enengine.h::enems_move::5::138"
						ld  hl, _en_an_base_frame
	C_LINE	388,"engine/enengine.h::enems_move::5::138"
						add hl, bc
	C_LINE	389,"engine/enengine.h::enems_move::5::138"
						ld  d, (hl)
	C_LINE	390,"engine/enengine.h::enems_move::5::138"
						add d 							; A = en_an_base_frame [enit] + en_an_frame [enit]]
	C_LINE	392,"engine/enengine.h::enems_move::5::138"
						sla c 							; Index 16 bits; it never overflows.
	C_LINE	393,"engine/enengine.h::enems_move::5::138"
						ld  hl, _en_an_next_frame
	C_LINE	394,"engine/enengine.h::enems_move::5::138"
						add hl, bc
	C_LINE	395,"engine/enengine.h::enems_move::5::138"
						ex de, hl 						; DE -> en_an_next_frame [enit]
	C_LINE	397,"engine/enengine.h::enems_move::5::138"
						sla a
	C_LINE	398,"engine/enengine.h::enems_move::5::138"
						ld  c, a
	C_LINE	399,"engine/enengine.h::enems_move::5::138"
						ld  b, 0
	C_LINE	401,"engine/enengine.h::enems_move::5::138"
						ld  hl, _enem_cells
	C_LINE	402,"engine/enengine.h::enems_move::5::138"
						add hl, bc 						; HL -> enem_cells [en_an_base_frame [enit] + en_an_frame [enit]]
	C_LINE	404,"engine/enengine.h::enems_move::5::138"
						ldi
	C_LINE	405,"engine/enengine.h::enems_move::5::138"
						ldi 							; Copy 16 bit
	C_LINE	406,"engine/enengine.h::enems_move::5::138"
					._enems_move_update_frame_done
	C_LINE	407,"engine/enengine.h::enems_move::5::138"
;			}
	C_LINE	409,"engine/enengine.h::enems_move::5::138"
;			
	C_LINE	410,"engine/enengine.h::enems_move::4::138"
;			 
	C_LINE	411,"engine/enengine.h::enems_move::4::138"
;			
	C_LINE	412,"engine/enengine.h::enems_move::4::138"
;			 
	C_LINE	413,"engine/enengine.h::enems_move::4::138"
; 
	C_LINE	416,"engine/enengine.h::enems_move::4::138"
; 
	C_LINE	425,"engine/enengine.h::enems_move::4::138"
;			{
	C_LINE	438,"engine/enengine.h::enems_move::4::138"
.i_231
	C_LINE	438,"engine/enengine.h::enems_move::4::138"
;				#line 1 "./my/ci/custom_enems_player_collision.h"
	C_LINE	439,"engine/enengine.h::enems_move::5::139"
	C_LINE	0,"./my/ci/custom_enems_player_collision.h::enems_move::5::139"
; 
	C_LINE	1,"./my/ci/custom_enems_player_collision.h::enems_move::5::139"
; 
	C_LINE	2,"./my/ci/custom_enems_player_collision.h::enems_move::5::139"
; 
	C_LINE	4,"./my/ci/custom_enems_player_collision.h::enems_move::5::139"
; 
	C_LINE	5,"./my/ci/custom_enems_player_collision.h::enems_move::5::139"
; 
	C_LINE	7,"./my/ci/custom_enems_player_collision.h::enems_move::5::139"
; 
	C_LINE	8,"./my/ci/custom_enems_player_collision.h::enems_move::5::139"
; 
	C_LINE	10,"./my/ci/custom_enems_player_collision.h::enems_move::5::139"
;#line 440 "engine/enengine.h"
	C_LINE	11,"./my/ci/custom_enems_player_collision.h::enems_move::5::139"
	C_LINE	439,"engine/enengine.h::enems_move::5::139"
;			
	C_LINE	440,"engine/enengine.h::enems_move::5::139"
;				cx2 = _en_x; cy2 = _en_y;
	C_LINE	441,"engine/enengine.h::enems_move::5::139"
	C_LINE	441,"engine/enengine.h::enems_move::5::139"
	ld	a,(__en_x)
	ld	(_cx2),a
	ld	hl,(__en_y)
	ld	h,0
	ld	a,l
	ld	(_cy2),a
;				if (!tocado && collide () && p_estado ==  0 ) {
	C_LINE	442,"engine/enengine.h::enems_move::5::139"
	C_LINE	442,"engine/enengine.h::enems_move::5::139"
	ld	a,(_tocado)
	and	a
	jp	nz,i_233	;
	call	_collide
	ld	a,h
	or	l
	jp	z,i_233	;
	ld	a,(_p_estado)
	and	a
	jp	nz,i_233	;
	defc	i_233 = i_232
.i_234_i_233
;					
	C_LINE	443,"engine/enengine.h::enems_move::6::140"
; 
	C_LINE	444,"engine/enengine.h::enems_move::6::140"
;					{
	C_LINE	470,"engine/enengine.h::enems_move::6::140"
	C_LINE	470,"engine/enengine.h::enems_move::6::140"
;						tocado = 1;
	C_LINE	471,"engine/enengine.h::enems_move::7::141"
	C_LINE	471,"engine/enengine.h::enems_move::7::141"
	ld	hl,1	;const
	ld	a,l
	ld	(_tocado),a
;						
	C_LINE	472,"engine/enengine.h::enems_move::7::141"
;						
	C_LINE	481,"engine/enengine.h::enems_move::7::141"
;							
	C_LINE	482,"engine/enengine.h::enems_move::7::141"
;								p_killme = 4;
	C_LINE	485,"engine/enengine.h::enems_move::7::141"
	C_LINE	485,"engine/enengine.h::enems_move::7::141"
	ld	hl,4	;const
	ld	a,l
	ld	(_p_killme),a
;							
	C_LINE	486,"engine/enengine.h::enems_move::7::141"
;						
	C_LINE	487,"engine/enengine.h::enems_move::7::141"
;						
	C_LINE	488,"engine/enengine.h::enems_move::7::141"
;						
	C_LINE	489,"engine/enengine.h::enems_move::7::141"
;						#line 1 "./my/ci/on_enems_collision.h"
	C_LINE	514,"engine/enengine.h::enems_move::7::141"
	C_LINE	0,"./my/ci/on_enems_collision.h::enems_move::7::141"
; 
	C_LINE	1,"./my/ci/on_enems_collision.h::enems_move::7::141"
; 
	C_LINE	2,"./my/ci/on_enems_collision.h::enems_move::7::141"
;#line 515 "engine/enengine.h"
	C_LINE	4,"./my/ci/on_enems_collision.h::enems_move::7::141"
	C_LINE	514,"engine/enengine.h::enems_move::7::141"
;					}
	C_LINE	515,"engine/enengine.h::enems_move::7::141"
;				}
	C_LINE	516,"engine/enengine.h::enems_move::6::141"
;			}
	C_LINE	517,"engine/enengine.h::enems_move::5::141"
.i_232
;			player_enem_collision_done:
	C_LINE	518,"engine/enengine.h::enems_move::4::141"
	C_LINE	518,"engine/enengine.h::enems_move::4::141"
.i_235
;			
	C_LINE	519,"engine/enengine.h::enems_move::4::141"
;			
	C_LINE	520,"engine/enengine.h::enems_move::4::141"
;				 
	C_LINE	521,"engine/enengine.h::enems_move::4::141"
;				
	C_LINE	522,"engine/enengine.h::enems_move::4::141"
;					if (rdt >=  3 )
	C_LINE	523,"engine/enengine.h::enems_move::4::141"
	C_LINE	523,"engine/enengine.h::enems_move::4::141"
	ld	hl,(_rdt)
	ld	h,0
	ld	a,l
	sub	3
	ccf
	jp	nc,i_236	;
;				
	C_LINE	524,"engine/enengine.h::enems_move::4::141"
;				{
	C_LINE	525,"engine/enengine.h::enems_move::4::141"
	C_LINE	525,"engine/enengine.h::enems_move::4::141"
;					for (gpjt = 0; gpjt <  3 ; gpjt ++) {
	C_LINE	526,"engine/enengine.h::enems_move::5::142"
	C_LINE	526,"engine/enengine.h::enems_move::5::142"
	xor	a
	ld	(_gpjt),a
	jp	i_239	;EOS
.i_237
	ld	hl,_gpjt
	ld	a,(hl)
	inc	(hl)
.i_239
	ld	hl,(_gpjt)
	ld	h,0
	ld	a,l
	sub	3
	jp	nc,i_238	;
;						if (bullets_estado [gpjt] == 1) {
	C_LINE	527,"engine/enengine.h::enems_move::7::143"
	C_LINE	527,"engine/enengine.h::enems_move::7::143"
	ld	de,_bullets_estado
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	cp	1
	jp	nz,i_240	;
;							blx = bullets_x [gpjt] + 3; 
	C_LINE	528,"engine/enengine.h::enems_move::8::144"
	C_LINE	528,"engine/enengine.h::enems_move::8::144"
	ld	de,_bullets_x
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_blx),a
;							bly = bullets_y [gpjt] + 3;
	C_LINE	529,"engine/enengine.h::enems_move::8::144"
	C_LINE	529,"engine/enengine.h::enems_move::8::144"
	ld	de,_bullets_y
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_bly),a
;							if (blx >= _en_x && blx <= _en_x + 15 && bly >= _en_y && bly <= _en_y + 15) {
	C_LINE	530,"engine/enengine.h::enems_move::8::144"
	C_LINE	530,"engine/enengine.h::enems_move::8::144"
	ld	de,(_blx)
	ld	d,0
	ld	hl,(__en_x)
	ld	h,d
	call	l_uge
	jp	nc,i_242	;
	ld	hl,(_blx)
	ld	h,0
	push	hl
	ld	hl,(__en_x)
	ld	h,0
	ld	bc,15
	add	hl,bc
	pop	de
	and	a
	sbc	hl,de
	ccf
	jp	nc,i_242	;
	ld	de,(_bly)
	ld	d,0
	ld	hl,(__en_y)
	ld	h,d
	call	l_uge
	jp	nc,i_242	;
	ld	hl,(_bly)
	ld	h,0
	push	hl
	ld	hl,(__en_y)
	ld	h,0
	ld	bc,15
	add	hl,bc
	pop	de
	and	a
	sbc	hl,de
	ccf
	jp	nc,i_242	;
	defc	i_242 = i_241
.i_243_i_242
;								
	C_LINE	531,"engine/enengine.h::enems_move::9::145"
;								_en_x = _en_cx;
	C_LINE	536,"engine/enengine.h::enems_move::9::145"
	C_LINE	536,"engine/enengine.h::enems_move::9::145"
	ld	hl,(__en_cx)
	ld	h,0
	ld	a,l
	ld	(__en_x),a
;								_en_y = _en_cy;
	C_LINE	537,"engine/enengine.h::enems_move::9::145"
	C_LINE	537,"engine/enengine.h::enems_move::9::145"
	ld	hl,(__en_cy)
	ld	h,0
	ld	a,l
	ld	(__en_y),a
;								en_an_next_frame [enit] = sprite_17_a;
	C_LINE	538,"engine/enengine.h::enems_move::9::145"
	C_LINE	538,"engine/enengine.h::enems_move::9::145"
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_enit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,_sprite_17_a
	call	l_pint
;								bullets_estado [gpjt] = 0;
	C_LINE	539,"engine/enengine.h::enems_move::9::145"
	C_LINE	539,"engine/enengine.h::enems_move::9::145"
	ld	de,_bullets_estado
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	l,(hl)
	ld	h,0
;								
	C_LINE	540,"engine/enengine.h::enems_move::9::145"
;									-- _en_life;
	C_LINE	543,"engine/enengine.h::enems_move::9::145"
	C_LINE	543,"engine/enengine.h::enems_move::9::145"
	ld	hl,__en_life
	call	l_gchar
	dec	hl
	ld	a,l
	ld	(__en_life),a
;								
	C_LINE	544,"engine/enengine.h::enems_move::9::145"
;								
	C_LINE	545,"engine/enengine.h::enems_move::9::145"
;								if (_en_life == 0) {
	C_LINE	546,"engine/enengine.h::enems_move::9::145"
	C_LINE	546,"engine/enengine.h::enems_move::9::145"
	ld	hl,__en_life
	call	l_gchar
	ld	a,l
	and	a
	jp	nz,i_244	;
;									enems_draw_current ();
	C_LINE	547,"engine/enengine.h::enems_move::10::146"
	C_LINE	547,"engine/enengine.h::enems_move::10::146"
	call	_enems_draw_current
;									sp_UpdateNow ();
	C_LINE	548,"engine/enengine.h::enems_move::10::146"
	C_LINE	548,"engine/enengine.h::enems_move::10::146"
	call	sp_UpdateNow
;									
	C_LINE	549,"engine/enengine.h::enems_move::10::146"
;										beep_fx (5);
	C_LINE	554,"engine/enengine.h::enems_move::10::146"
	C_LINE	554,"engine/enengine.h::enems_move::10::146"
;5;
	C_LINE	555,"engine/enengine.h::enems_move::10::146"
	ld	hl,5	;const
	push	hl
	call	_beep_fx
	pop	bc
;										en_an_next_frame [enit] = sprite_18_a;
	C_LINE	555,"engine/enengine.h::enems_move::10::146"
	C_LINE	555,"engine/enengine.h::enems_move::10::146"
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_enit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,_sprite_18_a
	call	l_pint
;									
	C_LINE	556,"engine/enengine.h::enems_move::10::146"
;									
	C_LINE	557,"engine/enengine.h::enems_move::10::146"
;									
	C_LINE	558,"engine/enengine.h::enems_move::10::146"
;										enems_pursuers_init ();
	C_LINE	559,"engine/enengine.h::enems_move::10::146"
	C_LINE	559,"engine/enengine.h::enems_move::10::146"
	call	_enems_pursuers_init
;									
	C_LINE	560,"engine/enengine.h::enems_move::10::146"
;									enems_kill ();					
	C_LINE	562,"engine/enengine.h::enems_move::10::146"
	C_LINE	562,"engine/enengine.h::enems_move::10::146"
	call	_enems_kill
;								}
	C_LINE	563,"engine/enengine.h::enems_move::10::146"
;								
	C_LINE	565,"engine/enengine.h::enems_move::9::146"
;									beep_fx (1);
	C_LINE	568,"engine/enengine.h::enems_move::9::146"
.i_244
	C_LINE	568,"engine/enengine.h::enems_move::9::146"
;1;
	C_LINE	569,"engine/enengine.h::enems_move::9::146"
	ld	hl,1	;const
	push	hl
	call	_beep_fx
	pop	bc
;								
	C_LINE	569,"engine/enengine.h::enems_move::9::146"
;							}
	C_LINE	570,"engine/enengine.h::enems_move::9::146"
;						}
	C_LINE	571,"engine/enengine.h::enems_move::8::146"
.i_241
;					}
	C_LINE	572,"engine/enengine.h::enems_move::7::146"
	jp	i_237	;EOS
	defc	i_240 = i_237
.i_238
;				}
	C_LINE	574,"engine/enengine.h::enems_move::5::146"
;			
	C_LINE	575,"engine/enengine.h::enems_move::4::146"
;			#line 1 "./my/ci/enems_extra_actions.h"
	C_LINE	577,"engine/enengine.h::enems_move::4::146"
	C_LINE	0,"./my/ci/enems_extra_actions.h::enems_move::4::146"
; 
	C_LINE	1,"./my/ci/enems_extra_actions.h::enems_move::4::146"
; 
	C_LINE	2,"./my/ci/enems_extra_actions.h::enems_move::4::146"
;#line 578 "engine/enengine.h"
	C_LINE	3,"./my/ci/enems_extra_actions.h::enems_move::4::146"
	C_LINE	577,"engine/enengine.h::enems_move::4::146"
;		} 
	C_LINE	578,"engine/enengine.h::enems_move::4::146"
.i_236
;		#asm		
	C_LINE	580,"engine/enengine.h::enems_move::3::146"
.i_230
	C_LINE	580,"engine/enengine.h::enems_move::3::146"
	C_LINE	582,"engine/enengine.h::enems_move::3::146"
	C_LINE	583,"engine/enengine.h::enems_move::3::146"
	C_LINE	585,"engine/enengine.h::enems_move::3::146"
				ld  hl, (__baddies_pointer) 		 
	C_LINE	587,"engine/enengine.h::enems_move::3::146"
				ld  a, (__en_x)
	C_LINE	588,"engine/enengine.h::enems_move::3::146"
				ld  (hl), a
	C_LINE	589,"engine/enengine.h::enems_move::3::146"
				inc hl
	C_LINE	591,"engine/enengine.h::enems_move::3::146"
				ld  a, (__en_y)
	C_LINE	592,"engine/enengine.h::enems_move::3::146"
				ld  (hl), a
	C_LINE	593,"engine/enengine.h::enems_move::3::146"
				inc hl
	C_LINE	595,"engine/enengine.h::enems_move::3::146"
				ld  a, (__en_x1)
	C_LINE	596,"engine/enengine.h::enems_move::3::146"
				ld  (hl), a
	C_LINE	597,"engine/enengine.h::enems_move::3::146"
				inc hl
	C_LINE	599,"engine/enengine.h::enems_move::3::146"
				ld  a, (__en_y1)
	C_LINE	600,"engine/enengine.h::enems_move::3::146"
				ld  (hl), a
	C_LINE	601,"engine/enengine.h::enems_move::3::146"
				inc hl
	C_LINE	603,"engine/enengine.h::enems_move::3::146"
				ld  a, (__en_x2)
	C_LINE	604,"engine/enengine.h::enems_move::3::146"
				ld  (hl), a
	C_LINE	605,"engine/enengine.h::enems_move::3::146"
				inc hl
	C_LINE	607,"engine/enengine.h::enems_move::3::146"
				ld  a, (__en_y2)
	C_LINE	608,"engine/enengine.h::enems_move::3::146"
				ld  (hl), a
	C_LINE	609,"engine/enengine.h::enems_move::3::146"
				inc hl
	C_LINE	611,"engine/enengine.h::enems_move::3::146"
				ld  a, (__en_mx)
	C_LINE	612,"engine/enengine.h::enems_move::3::146"
				ld  (hl), a
	C_LINE	613,"engine/enengine.h::enems_move::3::146"
				inc hl
	C_LINE	615,"engine/enengine.h::enems_move::3::146"
				ld  a, (__en_my)
	C_LINE	616,"engine/enengine.h::enems_move::3::146"
				ld  (hl), a
	C_LINE	617,"engine/enengine.h::enems_move::3::146"
				inc hl
	C_LINE	619,"engine/enengine.h::enems_move::3::146"
				ld  a, (__en_t)
	C_LINE	620,"engine/enengine.h::enems_move::3::146"
				ld  (hl), a
	C_LINE	621,"engine/enengine.h::enems_move::3::146"
				inc hl
	C_LINE	623,"engine/enengine.h::enems_move::3::146"
							ld  a, (__en_life)
	C_LINE	624,"engine/enengine.h::enems_move::3::146"
				ld  (hl), a
	C_LINE	625,"engine/enengine.h::enems_move::3::146"
	C_LINE	626,"engine/enengine.h::enems_move::3::146"
;	}
	C_LINE	628,"engine/enengine.h::enems_move::3::146"
	jp	i_216	;EOS
.i_217
;	
	C_LINE	630,"engine/enengine.h::enems_move::1::146"
;}
	C_LINE	632,"engine/enengine.h::enems_move::1::146"
	ret


;#line 136 "mk1.c"
	C_LINE	633,"engine/enengine.h::enems_move::0::146"
	C_LINE	135,"mk1.c::enems_move::0::146"
;#line 1 "engine/hotspots.h"
	C_LINE	136,"mk1.c::enems_move::0::146"
	C_LINE	0,"engine/hotspots.h::enems_move::0::146"
; 
	C_LINE	1,"engine/hotspots.h::enems_move::0::146"
; 
	C_LINE	2,"engine/hotspots.h::enems_move::0::146"
; 
	C_LINE	4,"engine/hotspots.h::enems_move::0::146"
;void hotspots_do (void) {
	C_LINE	14,"engine/hotspots.h::enems_move::0::146"
	C_LINE	14,"engine/hotspots.h::enems_move::0::146"

; Function hotspots_do flags 0x00000200 __smallc 
; void hotspots_do()
	C_LINE	14,"engine/hotspots.h::hotspots_do::0::146"
._hotspots_do
	C_LINE	14,"engine/hotspots.h::hotspots_do::0::146"
;	if (hotspots [n_pant].act == 0) return;
	C_LINE	15,"engine/hotspots.h::hotspots_do::1::147"
	C_LINE	15,"engine/hotspots.h::hotspots_do::1::147"
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	a,(hl)
	and	a
	jp	nz,i_245	;
	ret


;	cx2 = hotspot_x; cy2 = hotspot_y; if (collide ()) {
	C_LINE	17,"engine/hotspots.h::hotspots_do::1::147"
.i_245
	C_LINE	17,"engine/hotspots.h::hotspots_do::1::147"
	ld	a,(_hotspot_x)
	ld	(_cx2),a
	ld	hl,(_hotspot_y)
	ld	h,0
	ld	a,l
	ld	(_cy2),a
	call	_collide
	ld	a,h
	or	l
	jp	z,i_246	;
;		 
	C_LINE	18,"engine/hotspots.h::hotspots_do::2::148"
;		hotspot_destroy = 1;
	C_LINE	19,"engine/hotspots.h::hotspots_do::2::148"
	C_LINE	19,"engine/hotspots.h::hotspots_do::2::148"
	ld	hl,1	;const
	ld	a,l
	ld	(_hotspot_destroy),a
;			
	C_LINE	20,"engine/hotspots.h::hotspots_do::2::148"
;		switch (hotspots [n_pant].tipo) {
	C_LINE	21,"engine/hotspots.h::hotspots_do::2::148"
	C_LINE	21,"engine/hotspots.h::hotspots_do::2::148"
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	ld	l,(hl)
	ld	h,0
.i_249
	ld	a,l
	cp	+(1% 256)
	jp	z,i_250	;
	cp	+(2% 256)
	jp	z,i_251	;
	cp	+(3% 256)
	jp	z,i_252	;
	cp	+(4% 256)
	jp	z,i_254	;
	jp	i_248	;EOS
;			
	C_LINE	22,"engine/hotspots.h::hotspots_do::3::149"
;				case 1:
	C_LINE	23,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	23,"engine/hotspots.h::hotspots_do::3::149"
.i_250
;					
	C_LINE	24,"engine/hotspots.h::hotspots_do::3::149"
;						++ p_objs;
	C_LINE	42,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	42,"engine/hotspots.h::hotspots_do::3::149"
	ld	hl,_p_objs
	inc	(hl)
	ld	l,(hl)
	ld	h,0
;						
	C_LINE	43,"engine/hotspots.h::hotspots_do::3::149"
;						
	C_LINE	47,"engine/hotspots.h::hotspots_do::3::149"
;							beep_fx (9);
	C_LINE	50,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	50,"engine/hotspots.h::hotspots_do::3::149"
;9;
	C_LINE	51,"engine/hotspots.h::hotspots_do::3::149"
	ld	hl,9	;const
	push	hl
	call	_beep_fx
	pop	bc
;						
	C_LINE	51,"engine/hotspots.h::hotspots_do::3::149"
;						
	C_LINE	53,"engine/hotspots.h::hotspots_do::3::149"
;					
	C_LINE	65,"engine/hotspots.h::hotspots_do::3::149"
;					break;
	C_LINE	66,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	66,"engine/hotspots.h::hotspots_do::3::149"
	jp	i_248	;EOS
;			
	C_LINE	67,"engine/hotspots.h::hotspots_do::3::149"
;			
	C_LINE	69,"engine/hotspots.h::hotspots_do::3::149"
;				case 2:
	C_LINE	70,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	70,"engine/hotspots.h::hotspots_do::3::149"
.i_251
;					p_keys ++;
	C_LINE	71,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	71,"engine/hotspots.h::hotspots_do::3::149"
	ld	hl,_p_keys
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
;					
	C_LINE	72,"engine/hotspots.h::hotspots_do::3::149"
;						beep_fx (7);
	C_LINE	75,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	75,"engine/hotspots.h::hotspots_do::3::149"
;7;
	C_LINE	76,"engine/hotspots.h::hotspots_do::3::149"
	ld	hl,7	;const
	push	hl
	call	_beep_fx
	pop	bc
;					
	C_LINE	76,"engine/hotspots.h::hotspots_do::3::149"
;					break;
	C_LINE	77,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	77,"engine/hotspots.h::hotspots_do::3::149"
	jp	i_248	;EOS
;			
	C_LINE	78,"engine/hotspots.h::hotspots_do::3::149"
;			
	C_LINE	80,"engine/hotspots.h::hotspots_do::3::149"
;				case 3:
	C_LINE	81,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	81,"engine/hotspots.h::hotspots_do::3::149"
.i_252
;					p_life +=  5 ;
	C_LINE	82,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	82,"engine/hotspots.h::hotspots_do::3::149"
	ld	hl,(_p_life)
	ld	h,0
	ld	bc,5
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_p_life),a
;					if (p_life >  25 )
	C_LINE	83,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	83,"engine/hotspots.h::hotspots_do::3::149"
	ld	hl,(_p_life)
	ld	h,0
	ld	a,25
	sub	l
	jp	nc,i_253	;
;						p_life =  25 ;
	C_LINE	84,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	84,"engine/hotspots.h::hotspots_do::3::149"
	ld	hl,25	;const
	ld	a,l
	ld	(_p_life),a
;					
	C_LINE	85,"engine/hotspots.h::hotspots_do::3::149"
;						beep_fx (8);
	C_LINE	88,"engine/hotspots.h::hotspots_do::3::149"
.i_253
	C_LINE	88,"engine/hotspots.h::hotspots_do::3::149"
;8;
	C_LINE	89,"engine/hotspots.h::hotspots_do::3::149"
	ld	hl,8	;const
	push	hl
	call	_beep_fx
	pop	bc
;					
	C_LINE	89,"engine/hotspots.h::hotspots_do::3::149"
;					break;
	C_LINE	90,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	90,"engine/hotspots.h::hotspots_do::3::149"
	jp	i_248	;EOS
;			
	C_LINE	91,"engine/hotspots.h::hotspots_do::3::149"
;			
	C_LINE	93,"engine/hotspots.h::hotspots_do::3::149"
;				case 4:
	C_LINE	94,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	94,"engine/hotspots.h::hotspots_do::3::149"
.i_254
;					if ( 99  - p_ammo >  50 )
	C_LINE	95,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	95,"engine/hotspots.h::hotspots_do::3::149"
	ld	hl,(_p_ammo)
	ld	h,0
	ld	de,99
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,50
	sub	l
	jp	nc,i_255	;
;						p_ammo +=  50 ;
	C_LINE	96,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	96,"engine/hotspots.h::hotspots_do::3::149"
	ld	hl,(_p_ammo)
	ld	h,0
	ld	bc,50
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_p_ammo),a
;					else
	C_LINE	97,"engine/hotspots.h::hotspots_do::3::149"
	jp	i_256	;EOS
.i_255
;						p_ammo =  99 ;
	C_LINE	98,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	98,"engine/hotspots.h::hotspots_do::3::149"
	ld	hl,99	;const
	ld	a,l
	ld	(_p_ammo),a
.i_256
;					
	C_LINE	99,"engine/hotspots.h::hotspots_do::3::149"
;						beep_fx (9);
	C_LINE	102,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	102,"engine/hotspots.h::hotspots_do::3::149"
;9;
	C_LINE	103,"engine/hotspots.h::hotspots_do::3::149"
	ld	hl,9	;const
	push	hl
	call	_beep_fx
	pop	bc
;					
	C_LINE	103,"engine/hotspots.h::hotspots_do::3::149"
;					break;
	C_LINE	104,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	104,"engine/hotspots.h::hotspots_do::3::149"
	jp	i_248	;EOS
;			
	C_LINE	105,"engine/hotspots.h::hotspots_do::3::149"
;			
	C_LINE	107,"engine/hotspots.h::hotspots_do::3::149"
;			
	C_LINE	121,"engine/hotspots.h::hotspots_do::3::149"
;			#line 1 "./my/ci/hotspots_custom.h"
	C_LINE	132,"engine/hotspots.h::hotspots_do::3::149"
	C_LINE	0,"./my/ci/hotspots_custom.h::hotspots_do::3::149"
; 
	C_LINE	1,"./my/ci/hotspots_custom.h::hotspots_do::3::149"
; 
	C_LINE	2,"./my/ci/hotspots_custom.h::hotspots_do::3::149"
;#line 133 "engine/hotspots.h"
	C_LINE	4,"./my/ci/hotspots_custom.h::hotspots_do::3::149"
	C_LINE	132,"engine/hotspots.h::hotspots_do::3::149"
;		}
	C_LINE	133,"engine/hotspots.h::hotspots_do::3::149"
.i_248
;			
	C_LINE	134,"engine/hotspots.h::hotspots_do::2::149"
;		if (hotspot_destroy) {
	C_LINE	135,"engine/hotspots.h::hotspots_do::2::149"
	C_LINE	135,"engine/hotspots.h::hotspots_do::2::149"
	ld	hl,(_hotspot_destroy)
	ld	a,l
	and	a
	jp	z,i_257	;
;			hotspots [n_pant].act = 0;
	C_LINE	136,"engine/hotspots.h::hotspots_do::3::150"
	C_LINE	136,"engine/hotspots.h::hotspots_do::3::150"
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	(hl),0
	ld	l,(hl)
	ld	h,0
;			_x = hotspot_x >> 4; _y = hotspot_y >> 4; _t = orig_tile;
	C_LINE	137,"engine/hotspots.h::hotspots_do::3::150"
	C_LINE	137,"engine/hotspots.h::hotspots_do::3::150"
	ld	hl,(_hotspot_x)
	ld	h,0
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(__x),a
	ld	hl,(_hotspot_y)
	ld	h,0
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(__y),a
	ld	hl,(_orig_tile)
	ld	h,0
	ld	a,l
	ld	(__t),a
;			draw_invalidate_coloured_tile_gamearea ();
	C_LINE	138,"engine/hotspots.h::hotspots_do::3::150"
	C_LINE	138,"engine/hotspots.h::hotspots_do::3::150"
	call	_draw_invalidate_coloured_tile_gamearea
;			hotspot_y = 240;
	C_LINE	139,"engine/hotspots.h::hotspots_do::3::150"
	C_LINE	139,"engine/hotspots.h::hotspots_do::3::150"
	ld	hl,240	;const
	ld	a,l
	ld	(_hotspot_y),a
;		}
	C_LINE	140,"engine/hotspots.h::hotspots_do::3::150"
;	}
	C_LINE	141,"engine/hotspots.h::hotspots_do::2::150"
.i_257
;}
	C_LINE	142,"engine/hotspots.h::hotspots_do::1::150"
.i_246
	ret


;#line 137 "mk1.c"
	C_LINE	143,"engine/hotspots.h::hotspots_do::0::150"
	C_LINE	136,"mk1.c::hotspots_do::0::150"
;#line 1 "mainloop.h"
	C_LINE	142,"mk1.c::hotspots_do::0::150"
	C_LINE	0,"mainloop.h::hotspots_do::0::150"
; 
	C_LINE	1,"mainloop.h::hotspots_do::0::150"
; 
	C_LINE	2,"mainloop.h::hotspots_do::0::150"
; 
	C_LINE	4,"mainloop.h::hotspots_do::0::150"
; 
	C_LINE	5,"mainloop.h::hotspots_do::0::150"
;void main (void) {
	C_LINE	7,"mainloop.h::hotspots_do::0::150"
	C_LINE	7,"mainloop.h::hotspots_do::0::150"

; Function main flags 0x00000000 __stdc 
; void main()
	C_LINE	7,"mainloop.h::main::0::151"
._main
	C_LINE	7,"mainloop.h::main::0::151"
;	 
	C_LINE	9,"mainloop.h::main::1::152"
;	
	C_LINE	10,"mainloop.h::main::1::152"
;	#asm
	C_LINE	11,"mainloop.h::main::1::152"
	C_LINE	11,"mainloop.h::main::1::152"
	C_LINE	13,"mainloop.h::main::1::152"
		di
	C_LINE	14,"mainloop.h::main::1::152"
;	
	C_LINE	16,"mainloop.h::main::1::152"
;	
	C_LINE	17,"mainloop.h::main::1::152"
;	
	C_LINE	25,"mainloop.h::main::1::152"
;	cortina ();
	C_LINE	34,"mainloop.h::main::1::152"
	C_LINE	34,"mainloop.h::main::1::152"
	call	_cortina
;	
	C_LINE	35,"mainloop.h::main::1::152"
;	 
	C_LINE	36,"mainloop.h::main::1::152"
;	sp_Initialize (0, 0);
	C_LINE	37,"mainloop.h::main::1::152"
	C_LINE	37,"mainloop.h::main::1::152"
;0;
	C_LINE	38,"mainloop.h::main::1::152"
	ld	hl,0	;const
	push	hl
;0;
	C_LINE	38,"mainloop.h::main::1::152"
	ld	hl,0	;const
	push	hl
	call	sp_Initialize
	pop	bc
	pop	bc
;	sp_Border ( 0x00 );
	C_LINE	38,"mainloop.h::main::1::152"
	C_LINE	38,"mainloop.h::main::1::152"
;0x00 ;
	C_LINE	39,"mainloop.h::main::1::152"
	ld	hl,0	;const
	push	hl
	call	sp_Border
	pop	bc
;	sp_AddMemory(0,  (((1 +  3 ) * 10) + ( ( 3  +  3 )  * 5)) , 14, AD_FREE);
	C_LINE	39,"mainloop.h::main::1::152"
	C_LINE	39,"mainloop.h::main::1::152"
;0;
	C_LINE	40,"mainloop.h::main::1::152"
	ld	hl,0	;const
	push	hl
;(((1 +3 ) *10) +((3  +3 )  *5)) ;
	C_LINE	40,"mainloop.h::main::1::152"
	ld	hl,70	;const
	push	hl
;14;
	C_LINE	40,"mainloop.h::main::1::152"
	ld	hl,14	;const
	push	hl
;AD_FREE;
	C_LINE	40,"mainloop.h::main::1::152"
	ld	hl,_AD_FREE
	push	hl
	call	sp_AddMemory
	pop	bc
	pop	bc
	pop	bc
	pop	bc
;	
	C_LINE	40,"mainloop.h::main::1::152"
;	 
	C_LINE	41,"mainloop.h::main::1::152"
;	
	C_LINE	42,"mainloop.h::main::1::152"
;		gen_pt = font;
	C_LINE	43,"mainloop.h::main::1::152"
	C_LINE	43,"mainloop.h::main::1::152"
	ld	hl,_font
	ld	(_gen_pt),hl
;	
	C_LINE	44,"mainloop.h::main::1::152"
;	gpit = 0; do {
	C_LINE	47,"mainloop.h::main::1::152"
	C_LINE	47,"mainloop.h::main::1::152"
	ld	hl,0	;const
	ld	a,l
	ld	(_gpit),a
.i_260
;		sp_TileArray (gpit, gen_pt);
	C_LINE	48,"mainloop.h::main::2::153"
	C_LINE	48,"mainloop.h::main::2::153"
;gpit;
	C_LINE	49,"mainloop.h::main::2::153"
	ld	hl,(_gpit)
	ld	h,0
	push	hl
;gen_pt;
	C_LINE	49,"mainloop.h::main::2::153"
	ld	hl,(_gen_pt)
	push	hl
	call	sp_TileArray
	pop	bc
	pop	bc
;		gen_pt += 8;
	C_LINE	49,"mainloop.h::main::2::153"
	C_LINE	49,"mainloop.h::main::2::153"
	ld	hl,(_gen_pt)
	ld	bc,8
	add	hl,bc
	ld	(_gen_pt),hl
;		gpit ++;
	C_LINE	50,"mainloop.h::main::2::153"
	C_LINE	50,"mainloop.h::main::2::153"
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
;		
	C_LINE	51,"mainloop.h::main::2::153"
;			if (gpit == 64) gen_pt = tileset;
	C_LINE	52,"mainloop.h::main::2::153"
	C_LINE	52,"mainloop.h::main::2::153"
	ld	a,(_gpit)
	cp	64
	jp	nz,i_261	;
	ld	hl,_tileset
	ld	(_gen_pt),hl
;		
	C_LINE	53,"mainloop.h::main::2::153"
;	} while (gpit);
	C_LINE	54,"mainloop.h::main::2::153"
.i_261
.i_258
	ld	hl,(_gpit)
	ld	a,l
	and	a
	jp	nz,i_260	;EOS
.i_259
;	 
	C_LINE	56,"mainloop.h::main::1::153"
;	
	C_LINE	57,"mainloop.h::main::1::153"
;		sp_player = sp_CreateSpr ( 0x00 , 3, sprite_2_a);
	C_LINE	70,"mainloop.h::main::1::153"
	C_LINE	70,"mainloop.h::main::1::153"
;0x00 ;
	C_LINE	71,"mainloop.h::main::1::153"
	ld	hl,0	;const
	push	hl
;3;
	C_LINE	71,"mainloop.h::main::1::153"
	ld	hl,3	;const
	push	hl
;sprite_2_a;
	C_LINE	71,"mainloop.h::main::1::153"
	ld	hl,_sprite_2_a
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	ld	(_sp_player),hl
;		sp_AddColSpr (sp_player, sprite_2_b);
	C_LINE	71,"mainloop.h::main::1::153"
	C_LINE	71,"mainloop.h::main::1::153"
;sp_player;
	C_LINE	72,"mainloop.h::main::1::153"
	ld	hl,(_sp_player)
	push	hl
;sprite_2_b;
	C_LINE	72,"mainloop.h::main::1::153"
	ld	hl,_sprite_2_b
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
;		sp_AddColSpr (sp_player, sprite_2_c);
	C_LINE	72,"mainloop.h::main::1::153"
	C_LINE	72,"mainloop.h::main::1::153"
;sp_player;
	C_LINE	73,"mainloop.h::main::1::153"
	ld	hl,(_sp_player)
	push	hl
;sprite_2_c;
	C_LINE	73,"mainloop.h::main::1::153"
	ld	hl,_sprite_2_c
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
;		p_current_frame = p_next_frame = sprite_2_a;
	C_LINE	73,"mainloop.h::main::1::153"
	C_LINE	73,"mainloop.h::main::1::153"
	ld	hl,_sprite_2_a
	ld	(_p_next_frame),hl
	ld	(_p_current_frame),hl
;		
	C_LINE	74,"mainloop.h::main::1::153"
;		for (gpit = 0; gpit <  3 ; gpit ++) {
	C_LINE	75,"mainloop.h::main::1::153"
	C_LINE	75,"mainloop.h::main::1::153"
	xor	a
	ld	(_gpit),a
	jp	i_264	;EOS
.i_262
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_264
	ld	hl,(_gpit)
	ld	h,0
	ld	a,l
	sub	3
	jp	nc,i_263	;
;			sp_moviles [gpit] = sp_CreateSpr( 0x00 , 3, sprite_9_a);
	C_LINE	76,"mainloop.h::main::3::154"
	C_LINE	76,"mainloop.h::main::3::154"
	ld	hl,_sp_moviles
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
;0x00 ;
	C_LINE	77,"mainloop.h::main::3::154"
	ld	hl,0	;const
	push	hl
;3;
	C_LINE	77,"mainloop.h::main::3::154"
	ld	hl,3	;const
	push	hl
;sprite_9_a;
	C_LINE	77,"mainloop.h::main::3::154"
	ld	hl,_sprite_9_a
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	call	l_pint_pop
;			sp_AddColSpr (sp_moviles [gpit], sprite_9_b);
	C_LINE	77,"mainloop.h::main::3::154"
	C_LINE	77,"mainloop.h::main::3::154"
;sp_moviles [gpit];
	C_LINE	78,"mainloop.h::main::3::154"
	ld	hl,_sp_moviles
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	push	hl
;sprite_9_b;
	C_LINE	78,"mainloop.h::main::3::154"
	ld	hl,_sprite_9_b
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
;			sp_AddColSpr (sp_moviles [gpit], sprite_9_c);	
	C_LINE	78,"mainloop.h::main::3::154"
	C_LINE	78,"mainloop.h::main::3::154"
;sp_moviles [gpit];
	C_LINE	79,"mainloop.h::main::3::154"
	ld	hl,_sp_moviles
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	push	hl
;sprite_9_c;
	C_LINE	79,"mainloop.h::main::3::154"
	ld	hl,_sprite_9_c
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
;			en_an_current_frame [gpit] = en_an_next_frame [gpit] = sprite_9_a;
	C_LINE	79,"mainloop.h::main::3::154"
	C_LINE	79,"mainloop.h::main::3::154"
	ld	hl,_en_an_current_frame
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,_sprite_9_a
	call	l_pint
	call	l_pint_pop
;		}
	C_LINE	80,"mainloop.h::main::3::154"
	jp	i_262	;EOS
.i_263
;	
	C_LINE	81,"mainloop.h::main::1::154"
;	
	C_LINE	83,"mainloop.h::main::1::154"
;		for (gpit = 0; gpit <  3 ; gpit ++) {
	C_LINE	84,"mainloop.h::main::1::154"
	C_LINE	84,"mainloop.h::main::1::154"
	xor	a
	ld	(_gpit),a
	jp	i_267	;EOS
.i_265
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_267
	ld	hl,(_gpit)
	ld	h,0
	ld	a,l
	sub	3
	jp	nc,i_266	;
;			
	C_LINE	85,"mainloop.h::main::3::155"
;				sp_bullets [gpit] = sp_CreateSpr ( 0x40 , 2, sprite_19_a);
	C_LINE	88,"mainloop.h::main::3::155"
	C_LINE	88,"mainloop.h::main::3::155"
	ld	hl,_sp_bullets
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
;0x40 ;
	C_LINE	89,"mainloop.h::main::3::155"
	ld	hl,64	;const
	push	hl
;2;
	C_LINE	89,"mainloop.h::main::3::155"
	ld	hl,2	;const
	push	hl
;sprite_19_a;
	C_LINE	89,"mainloop.h::main::3::155"
	ld	hl,_sprite_19_a
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	call	l_pint_pop
;			
	C_LINE	89,"mainloop.h::main::3::155"
;			sp_AddColSpr (sp_bullets [gpit], sprite_19_a+32);
	C_LINE	90,"mainloop.h::main::3::155"
	C_LINE	90,"mainloop.h::main::3::155"
;sp_bullets [gpit];
	C_LINE	91,"mainloop.h::main::3::155"
	ld	hl,_sp_bullets
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	push	hl
;sprite_19_a+32;
	C_LINE	91,"mainloop.h::main::3::155"
	ld	hl,_sprite_19_a+32
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
;		}
	C_LINE	91,"mainloop.h::main::3::155"
	jp	i_265	;EOS
.i_266
;	
	C_LINE	92,"mainloop.h::main::1::155"
;	
	C_LINE	94,"mainloop.h::main::1::155"
;		for (gpit = 0; gpit <  3 ; gpit ++) {
	C_LINE	95,"mainloop.h::main::1::155"
	C_LINE	95,"mainloop.h::main::1::155"
	xor	a
	ld	(_gpit),a
	jp	i_270	;EOS
.i_268
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_270
	ld	hl,(_gpit)
	ld	h,0
	ld	a,l
	sub	3
	jp	nc,i_269	;
;			
	C_LINE	96,"mainloop.h::main::3::156"
;				sp_cocos [gpit] = sp_CreateSpr ( 0x40 , 2, sprite_19_a);
	C_LINE	99,"mainloop.h::main::3::156"
	C_LINE	99,"mainloop.h::main::3::156"
	ld	hl,_sp_cocos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
;0x40 ;
	C_LINE	100,"mainloop.h::main::3::156"
	ld	hl,64	;const
	push	hl
;2;
	C_LINE	100,"mainloop.h::main::3::156"
	ld	hl,2	;const
	push	hl
;sprite_19_a;
	C_LINE	100,"mainloop.h::main::3::156"
	ld	hl,_sprite_19_a
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	call	l_pint_pop
;			
	C_LINE	100,"mainloop.h::main::3::156"
;			sp_AddColSpr (sp_cocos [gpit], sprite_19_a+32);
	C_LINE	101,"mainloop.h::main::3::156"
	C_LINE	101,"mainloop.h::main::3::156"
;sp_cocos [gpit];
	C_LINE	102,"mainloop.h::main::3::156"
	ld	hl,_sp_cocos
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	push	hl
;sprite_19_a+32;
	C_LINE	102,"mainloop.h::main::3::156"
	ld	hl,_sprite_19_a+32
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
;		}
	C_LINE	102,"mainloop.h::main::3::156"
	jp	i_268	;EOS
.i_269
;	
	C_LINE	103,"mainloop.h::main::1::156"
;	#line 1 "my/ci/after_load.h"
	C_LINE	105,"mainloop.h::main::1::156"
	C_LINE	0,"my/ci/after_load.h::main::1::156"
; 
	C_LINE	1,"my/ci/after_load.h::main::1::156"
; 
	C_LINE	2,"my/ci/after_load.h::main::1::156"
;#line 106 "mainloop.h"
	C_LINE	4,"my/ci/after_load.h::main::1::156"
	C_LINE	105,"mainloop.h::main::1::156"
;	while (1) {
	C_LINE	107,"mainloop.h::main::1::156"
	C_LINE	107,"mainloop.h::main::1::156"
.i_271
;		
	C_LINE	108,"mainloop.h::main::2::157"
;		level = 0;
	C_LINE	112,"mainloop.h::main::2::157"
	C_LINE	112,"mainloop.h::main::2::157"
	ld	hl,0	;const
	ld	a,l
	ld	(_level),a
;		 
	C_LINE	114,"mainloop.h::main::2::157"
;		
	C_LINE	115,"mainloop.h::main::2::157"
;		#line 1 "my/title_screen.h"
	C_LINE	116,"mainloop.h::main::2::157"
	C_LINE	0,"my/title_screen.h::main::2::157"
; 
	C_LINE	1,"my/title_screen.h::main::2::157"
; 
	C_LINE	2,"my/title_screen.h::main::2::157"
; 
	C_LINE	4,"my/title_screen.h::main::2::157"
;{
	C_LINE	6,"my/title_screen.h::main::2::157"
	C_LINE	6,"my/title_screen.h::main::2::157"
;	 
	C_LINE	7,"my/title_screen.h::main::3::158"
;	if (do_continue) {
	C_LINE	9,"my/title_screen.h::main::3::158"
	C_LINE	9,"my/title_screen.h::main::3::158"
	ld	hl,(_do_continue)
	ld	a,l
	and	a
	jp	z,i_273	;
;		level = current_level;
	C_LINE	10,"my/title_screen.h::main::4::159"
	C_LINE	10,"my/title_screen.h::main::4::159"
	ld	hl,(_current_level)
	ld	h,0
	ld	a,l
	ld	(_level),a
;		do_continue = 0;
	C_LINE	11,"my/title_screen.h::main::4::159"
	C_LINE	11,"my/title_screen.h::main::4::159"
	ld	hl,0	;const
	ld	a,l
	ld	(_do_continue),a
;	} else {
	C_LINE	12,"my/title_screen.h::main::4::159"
	jp	i_274	;EOS
.i_273
	C_LINE	12,"my/title_screen.h::main::3::159"
;		sp_UpdateNow ();
	C_LINE	13,"my/title_screen.h::main::4::160"
	C_LINE	13,"my/title_screen.h::main::4::160"
	call	sp_UpdateNow
;		blackout ();
	C_LINE	14,"my/title_screen.h::main::4::160"
	C_LINE	14,"my/title_screen.h::main::4::160"
	call	_blackout
;		
	C_LINE	15,"my/title_screen.h::main::4::160"
;		
	C_LINE	16,"my/title_screen.h::main::4::160"
;			#asm
	C_LINE	20,"my/title_screen.h::main::4::160"
	C_LINE	20,"my/title_screen.h::main::4::160"
	C_LINE	22,"my/title_screen.h::main::4::160"
				ld hl, _s_title
	C_LINE	23,"my/title_screen.h::main::4::160"
				ld de, 16384
	C_LINE	24,"my/title_screen.h::main::4::160"
				call depack
	C_LINE	25,"my/title_screen.h::main::4::160"
;		
	C_LINE	27,"my/title_screen.h::main::4::160"
;		select_joyfunc ();
	C_LINE	28,"my/title_screen.h::main::4::160"
	C_LINE	28,"my/title_screen.h::main::4::160"
	call	_select_joyfunc
;	}
	C_LINE	29,"my/title_screen.h::main::4::160"
.i_274
;}
	C_LINE	30,"my/title_screen.h::main::3::160"
;#line 117 "mainloop.h"
	C_LINE	31,"my/title_screen.h::main::2::160"
	C_LINE	116,"mainloop.h::main::2::160"
;		
	C_LINE	117,"mainloop.h::main::2::160"
;		
	C_LINE	118,"mainloop.h::main::2::160"
;		#line 1 "my/ci/before_game.h"
	C_LINE	122,"mainloop.h::main::2::160"
	C_LINE	0,"my/ci/before_game.h::main::2::160"
; 
	C_LINE	1,"my/ci/before_game.h::main::2::160"
; 
	C_LINE	2,"my/ci/before_game.h::main::2::160"
;#line 123 "mainloop.h"
	C_LINE	4,"my/ci/before_game.h::main::2::160"
	C_LINE	122,"mainloop.h::main::2::160"
;		
	C_LINE	124,"mainloop.h::main::2::160"
;		
	C_LINE	137,"mainloop.h::main::2::160"
;			silent_level = 0;
	C_LINE	138,"mainloop.h::main::2::160"
	C_LINE	138,"mainloop.h::main::2::160"
	ld	hl,0	;const
	ld	a,l
	ld	(_silent_level),a
;			
	C_LINE	140,"mainloop.h::main::2::160"
;			
	C_LINE	144,"mainloop.h::main::2::160"
;				p_life =  25 ;
	C_LINE	145,"mainloop.h::main::2::160"
	C_LINE	145,"mainloop.h::main::2::160"
	ld	hl,25	;const
	ld	a,l
	ld	(_p_life),a
;			
	C_LINE	146,"mainloop.h::main::2::160"
;			
	C_LINE	148,"mainloop.h::main::2::160"
;				warp_to_level = 0;
	C_LINE	151,"mainloop.h::main::2::160"
	C_LINE	151,"mainloop.h::main::2::160"
	ld	hl,0	;const
	ld	a,l
	ld	(_warp_to_level),a
;			
	C_LINE	152,"mainloop.h::main::2::160"
;			while (1) 
	C_LINE	154,"mainloop.h::main::2::160"
	C_LINE	154,"mainloop.h::main::2::160"
.i_275
;		
	C_LINE	155,"mainloop.h::main::2::160"
;		
	C_LINE	156,"mainloop.h::main::2::160"
;		{
	C_LINE	157,"mainloop.h::main::2::160"
	C_LINE	157,"mainloop.h::main::2::160"
;			
	C_LINE	158,"mainloop.h::main::3::161"
;				if (silent_level == 0) {
	C_LINE	159,"mainloop.h::main::3::161"
	C_LINE	159,"mainloop.h::main::3::161"
	ld	hl,(_silent_level)
	ld	h,0
	ld	a,l
	and	a
	jp	nz,i_277	;
;					#line 1 "my/level_screen.h"
	C_LINE	160,"mainloop.h::main::4::162"
	C_LINE	0,"my/level_screen.h::main::4::162"
; 
	C_LINE	1,"my/level_screen.h::main::4::162"
; 
	C_LINE	2,"my/level_screen.h::main::4::162"
; 
	C_LINE	4,"my/level_screen.h::main::4::162"
;{
	C_LINE	6,"my/level_screen.h::main::4::162"
	C_LINE	6,"my/level_screen.h::main::4::162"
;	blackout_area ();
	C_LINE	7,"my/level_screen.h::main::5::163"
	C_LINE	7,"my/level_screen.h::main::5::163"
	call	_blackout_area
;	
	C_LINE	8,"my/level_screen.h::main::5::163"
;	level_str [7] = 49 + level;
	C_LINE	9,"my/level_screen.h::main::5::163"
	C_LINE	9,"my/level_screen.h::main::5::163"
	ld	hl,(_level_str)
	ld	bc,7
	add	hl,bc
	push	hl
	ld	hl,(_level)
	ld	h,0
	ld	bc,49
	add	hl,bc
	pop	de
	ld	a,l
	ld	(de),a
;	_x = 12; _y = 12; _t = 71; _gp_gen = level_str; print_str ();
	C_LINE	10,"my/level_screen.h::main::5::163"
	C_LINE	10,"my/level_screen.h::main::5::163"
	ld	a,12
	ld	(__x),a
	ld	a,12
	ld	(__y),a
	ld	a,71
	ld	(__t),a
	ld	hl,(_level_str)
	ld	(__gp_gen),hl
	call	_print_str
;	sp_UpdateNow ();
	C_LINE	11,"my/level_screen.h::main::5::163"
	C_LINE	11,"my/level_screen.h::main::5::163"
	call	sp_UpdateNow
;	
	C_LINE	12,"my/level_screen.h::main::5::163"
;		beep_fx (1);
	C_LINE	15,"my/level_screen.h::main::5::163"
	C_LINE	15,"my/level_screen.h::main::5::163"
;1;
	C_LINE	16,"my/level_screen.h::main::5::163"
	ld	hl,1	;const
	push	hl
	call	_beep_fx
	pop	bc
;	
	C_LINE	16,"my/level_screen.h::main::5::163"
;	espera_activa (100);
	C_LINE	18,"my/level_screen.h::main::5::163"
	C_LINE	18,"my/level_screen.h::main::5::163"
;100;
	C_LINE	19,"my/level_screen.h::main::5::163"
	ld	hl,100	;const
	push	hl
	call	_espera_activa
	pop	bc
;}
	C_LINE	19,"my/level_screen.h::main::5::163"
;#line 161 "mainloop.h"
	C_LINE	20,"my/level_screen.h::main::4::163"
	C_LINE	160,"mainloop.h::main::4::163"
;				}
	C_LINE	161,"mainloop.h::main::4::163"
;				silent_level = 0;
	C_LINE	162,"mainloop.h::main::3::163"
.i_277
	C_LINE	162,"mainloop.h::main::3::163"
	ld	hl,0	;const
	ld	a,l
	ld	(_silent_level),a
;			
	C_LINE	163,"mainloop.h::main::3::163"
;				prepare_level ();				
	C_LINE	164,"mainloop.h::main::3::163"
	C_LINE	164,"mainloop.h::main::3::163"
	call	_prepare_level
;			
	C_LINE	165,"mainloop.h::main::3::163"
;					
	C_LINE	166,"mainloop.h::main::3::163"
;			
	C_LINE	167,"mainloop.h::main::3::163"
; 
	C_LINE	168,"mainloop.h::main::3::163"
; 
	C_LINE	172,"mainloop.h::main::3::163"
;			 
	C_LINE	183,"mainloop.h::main::3::163"
;			#line 1 "mainloop/game_loop.h"
	C_LINE	184,"mainloop.h::main::3::163"
	C_LINE	0,"mainloop/game_loop.h::main::3::163"
; 
	C_LINE	1,"mainloop/game_loop.h::main::3::163"
; 
	C_LINE	2,"mainloop/game_loop.h::main::3::163"
; 
	C_LINE	4,"mainloop/game_loop.h::main::3::163"
;	#asm
	C_LINE	6,"mainloop/game_loop.h::main::3::163"
	C_LINE	6,"mainloop/game_loop.h::main::3::163"
	C_LINE	8,"mainloop/game_loop.h::main::3::163"
		; Makes debugging easier
	C_LINE	9,"mainloop/game_loop.h::main::3::163"
		._game_loop_init
	C_LINE	10,"mainloop/game_loop.h::main::3::163"
;	playing = 1;
	C_LINE	13,"mainloop/game_loop.h::main::3::163"
	C_LINE	13,"mainloop/game_loop.h::main::3::163"
	ld	hl,1	;const
	ld	a,l
	ld	(_playing),a
;	player_init ();
	C_LINE	14,"mainloop/game_loop.h::main::3::163"
	C_LINE	14,"mainloop/game_loop.h::main::3::163"
	call	_player_init
;	
	C_LINE	16,"mainloop/game_loop.h::main::3::163"
;	
	C_LINE	18,"mainloop/game_loop.h::main::3::163"
;	
	C_LINE	22,"mainloop/game_loop.h::main::3::163"
;	
	C_LINE	28,"mainloop/game_loop.h::main::3::163"
;		
	C_LINE	29,"mainloop/game_loop.h::main::3::163"
;	
	C_LINE	32,"mainloop/game_loop.h::main::3::163"
;	
	C_LINE	34,"mainloop/game_loop.h::main::3::163"
;	maincounter = 0;
	C_LINE	38,"mainloop/game_loop.h::main::3::163"
	C_LINE	38,"mainloop/game_loop.h::main::3::163"
	ld	hl,0	;const
	ld	a,l
	ld	(_maincounter),a
;	
	C_LINE	40,"mainloop/game_loop.h::main::3::163"
;	
	C_LINE	43,"mainloop/game_loop.h::main::3::163"
;	
	C_LINE	44,"mainloop/game_loop.h::main::3::163"
; 
	C_LINE	45,"mainloop/game_loop.h::main::3::163"
;	
	C_LINE	53,"mainloop/game_loop.h::main::3::163"
; 
	C_LINE	54,"mainloop/game_loop.h::main::3::163"
;	#line 1 "./my/ci/entering_game.h"
	C_LINE	58,"mainloop/game_loop.h::main::3::163"
	C_LINE	0,"./my/ci/entering_game.h::main::3::163"
; 
	C_LINE	1,"./my/ci/entering_game.h::main::3::163"
; 
	C_LINE	2,"./my/ci/entering_game.h::main::3::163"
; 
	C_LINE	4,"./my/ci/entering_game.h::main::3::163"
;flags [0] = flags [1] = 0;
	C_LINE	5,"./my/ci/entering_game.h::main::3::163"
	C_LINE	5,"./my/ci/entering_game.h::main::3::163"
	ld	hl,_flags
	push	hl
	inc	hl
	ld	(hl),0
	ld	l,(hl)
	ld	h,0
	pop	de
	ld	a,l
	ld	(de),a
; 
	C_LINE	7,"./my/ci/entering_game.h::main::3::163"
;p_estado =  2 ;
	C_LINE	8,"./my/ci/entering_game.h::main::3::163"
	C_LINE	8,"./my/ci/entering_game.h::main::3::163"
	ld	hl,2	;const
	ld	a,l
	ld	(_p_estado),a
;p_ct_estado = 50;
	C_LINE	9,"./my/ci/entering_game.h::main::3::163"
	C_LINE	9,"./my/ci/entering_game.h::main::3::163"
	ld	hl,50	;const
	ld	a,l
	ld	(_p_ct_estado),a
;#line 59 "mainloop/game_loop.h"
	C_LINE	10,"./my/ci/entering_game.h::main::3::163"
	C_LINE	58,"mainloop/game_loop.h::main::3::163"
;	
	C_LINE	59,"mainloop/game_loop.h::main::3::163"
;	
	C_LINE	60,"mainloop/game_loop.h::main::3::163"
; 
	C_LINE	62,"mainloop/game_loop.h::main::3::163"
;	p_killme = success = half_life = 0;
	C_LINE	67,"mainloop/game_loop.h::main::3::163"
	C_LINE	67,"mainloop/game_loop.h::main::3::163"
	ld	hl,0	;const
	ld	a,l
	ld	(_half_life),a
	ld	a,l
	ld	(_success),a
	ld	(_p_killme),a
;		
	C_LINE	68,"mainloop/game_loop.h::main::3::163"
;	objs_old = keys_old = life_old = killed_old = 0xff;
	C_LINE	69,"mainloop/game_loop.h::main::3::163"
	C_LINE	69,"mainloop/game_loop.h::main::3::163"
	ld	hl,255	;const
	ld	a,l
	ld	(_killed_old),a
	ld	a,l
	ld	(_life_old),a
	ld	(_keys_old),a
	ld	h,0
	ld	a,l
	ld	(_objs_old),a
;	
	C_LINE	70,"mainloop/game_loop.h::main::3::163"
;		ammo_old = 0xff;
	C_LINE	71,"mainloop/game_loop.h::main::3::163"
	C_LINE	71,"mainloop/game_loop.h::main::3::163"
	ld	hl,255	;const
	ld	a,l
	ld	(_ammo_old),a
;	
	C_LINE	72,"mainloop/game_loop.h::main::3::163"
;	
	C_LINE	73,"mainloop/game_loop.h::main::3::163"
;	
	C_LINE	77,"mainloop/game_loop.h::main::3::163"
;	
	C_LINE	86,"mainloop/game_loop.h::main::3::163"
;	
	C_LINE	92,"mainloop/game_loop.h::main::3::163"
;	o_pant = 0xff;
	C_LINE	96,"mainloop/game_loop.h::main::3::163"
	C_LINE	96,"mainloop/game_loop.h::main::3::163"
	ld	hl,255	;const
	ld	a,l
	ld	(_o_pant),a
;	while (playing) {
	C_LINE	97,"mainloop/game_loop.h::main::3::163"
	C_LINE	97,"mainloop/game_loop.h::main::3::163"
.i_278
	ld	hl,(_playing)
	ld	a,l
	and	a
	jp	z,i_279	;
;		#asm
	C_LINE	98,"mainloop/game_loop.h::main::4::164"
	C_LINE	98,"mainloop/game_loop.h::main::4::164"
	C_LINE	100,"mainloop/game_loop.h::main::4::164"
			; Makes debugging easier
	C_LINE	101,"mainloop/game_loop.h::main::4::164"
			._game_loop_do
	C_LINE	102,"mainloop/game_loop.h::main::4::164"
;		
	C_LINE	105,"mainloop/game_loop.h::main::4::164"
;		p_kill_amt = 1;
	C_LINE	109,"mainloop/game_loop.h::main::4::164"
	C_LINE	109,"mainloop/game_loop.h::main::4::164"
	ld	hl,1	;const
	ld	a,l
	ld	(_p_kill_amt),a
;		pad0 = (joyfunc) (&keys);
	C_LINE	110,"mainloop/game_loop.h::main::4::164"
	C_LINE	110,"mainloop/game_loop.h::main::4::164"
	ld	hl,(_joyfunc)
;&keys;
	C_LINE	111,"mainloop/game_loop.h::main::4::164"
	push	hl
	ld	hl,_keys
	ex	(sp),hl
	call	l_jphl
	pop	bc
	ld	h,0
	ld	a,l
	ld	(_pad0),a
;		if (o_pant != n_pant) {
	C_LINE	112,"mainloop/game_loop.h::main::4::164"
	C_LINE	112,"mainloop/game_loop.h::main::4::164"
	ld	de,(_o_pant)
	ld	d,0
	ld	hl,(_n_pant)
	ld	h,d
	call	l_ne
	jp	nc,i_280	;
;			#line 1 "./my/ci/before_entering_screen.h"
	C_LINE	113,"mainloop/game_loop.h::main::5::165"
	C_LINE	0,"./my/ci/before_entering_screen.h::main::5::165"
; 
	C_LINE	1,"./my/ci/before_entering_screen.h::main::5::165"
; 
	C_LINE	2,"./my/ci/before_entering_screen.h::main::5::165"
;#line 114 "mainloop/game_loop.h"
	C_LINE	4,"./my/ci/before_entering_screen.h::main::5::165"
	C_LINE	113,"mainloop/game_loop.h::main::5::165"
;			draw_scr ();
	C_LINE	114,"mainloop/game_loop.h::main::5::165"
	C_LINE	114,"mainloop/game_loop.h::main::5::165"
	call	_draw_scr
;			o_pant = n_pant;
	C_LINE	115,"mainloop/game_loop.h::main::5::165"
	C_LINE	115,"mainloop/game_loop.h::main::5::165"
	ld	hl,(_n_pant)
	ld	h,0
	ld	a,l
	ld	(_o_pant),a
;		}
	C_LINE	116,"mainloop/game_loop.h::main::5::165"
;		
	C_LINE	118,"mainloop/game_loop.h::main::4::165"
; 
	C_LINE	126,"mainloop/game_loop.h::main::4::165"
; 
	C_LINE	166,"mainloop/game_loop.h::main::4::165"
;		#line 1 "./mainloop/hud.h"
	C_LINE	177,"mainloop/game_loop.h::main::4::165"
	C_LINE	0,"./mainloop/hud.h::main::4::165"
; 
	C_LINE	1,"./mainloop/hud.h::main::4::165"
; 
	C_LINE	2,"./mainloop/hud.h::main::4::165"
; 
	C_LINE	4,"./mainloop/hud.h::main::4::165"
;	
	C_LINE	6,"./mainloop/hud.h::main::4::165"
;		if (p_objs != objs_old) {
	C_LINE	7,"./mainloop/hud.h::main::4::165"
.i_280
	C_LINE	7,"./mainloop/hud.h::main::4::165"
	ld	de,(_p_objs)
	ld	d,0
	ld	hl,(_objs_old)
	ld	h,d
	call	l_ne
	jp	nc,i_281	;
;			draw_objs ();
	C_LINE	8,"./mainloop/hud.h::main::5::166"
	C_LINE	8,"./mainloop/hud.h::main::5::166"
	call	_draw_objs
;			objs_old = p_objs;
	C_LINE	9,"./mainloop/hud.h::main::5::166"
	C_LINE	9,"./mainloop/hud.h::main::5::166"
	ld	hl,(_p_objs)
	ld	h,0
	ld	a,l
	ld	(_objs_old),a
;		}
	C_LINE	10,"./mainloop/hud.h::main::5::166"
;	
	C_LINE	11,"./mainloop/hud.h::main::4::166"
;	
	C_LINE	13,"./mainloop/hud.h::main::4::166"
;		if (p_life != life_old) {
	C_LINE	14,"./mainloop/hud.h::main::4::166"
.i_281
	C_LINE	14,"./mainloop/hud.h::main::4::166"
	ld	de,(_p_life)
	ld	d,0
	ld	hl,(_life_old)
	ld	h,d
	call	l_ne
	jp	nc,i_282	;
;			_x =  3 ; _y =  23 ; _t = p_life; print_number2 ();
	C_LINE	15,"./mainloop/hud.h::main::5::167"
	C_LINE	15,"./mainloop/hud.h::main::5::167"
	ld	a,3
	ld	(__x),a
	ld	a,23
	ld	(__y),a
	ld	hl,(_p_life)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_print_number2
;			life_old = p_life;
	C_LINE	16,"./mainloop/hud.h::main::5::167"
	C_LINE	16,"./mainloop/hud.h::main::5::167"
	ld	hl,(_p_life)
	ld	h,0
	ld	a,l
	ld	(_life_old),a
;		}
	C_LINE	17,"./mainloop/hud.h::main::5::167"
;	
	C_LINE	18,"./mainloop/hud.h::main::4::167"
;	
	C_LINE	20,"./mainloop/hud.h::main::4::167"
;		if (p_keys != keys_old) {
	C_LINE	21,"./mainloop/hud.h::main::4::167"
.i_282
	C_LINE	21,"./mainloop/hud.h::main::4::167"
	ld	de,(_p_keys)
	ld	d,0
	ld	hl,(_keys_old)
	ld	h,d
	call	l_ne
	jp	nc,i_283	;
;			_x =  22 ; _y =  23 ; _t = p_keys; print_number2 ();
	C_LINE	22,"./mainloop/hud.h::main::5::168"
	C_LINE	22,"./mainloop/hud.h::main::5::168"
	ld	a,22
	ld	(__x),a
	ld	a,23
	ld	(__y),a
	ld	hl,(_p_keys)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_print_number2
;			keys_old = p_keys;
	C_LINE	23,"./mainloop/hud.h::main::5::168"
	C_LINE	23,"./mainloop/hud.h::main::5::168"
	ld	hl,(_p_keys)
	ld	h,0
	ld	a,l
	ld	(_keys_old),a
;		}
	C_LINE	24,"./mainloop/hud.h::main::5::168"
;	
	C_LINE	25,"./mainloop/hud.h::main::4::168"
;	
	C_LINE	27,"./mainloop/hud.h::main::4::168"
;		
	C_LINE	28,"./mainloop/hud.h::main::4::168"
;	
	C_LINE	34,"./mainloop/hud.h::main::4::168"
;	
	C_LINE	36,"./mainloop/hud.h::main::4::168"
;		if (p_ammo != ammo_old) {
	C_LINE	37,"./mainloop/hud.h::main::4::168"
.i_283
	C_LINE	37,"./mainloop/hud.h::main::4::168"
	ld	de,(_p_ammo)
	ld	d,0
	ld	hl,(_ammo_old)
	ld	h,d
	call	l_ne
	jp	nc,i_284	;
;			_x =  8 ; _y =  23 ; _t = p_ammo; print_number2 ();
	C_LINE	38,"./mainloop/hud.h::main::5::169"
	C_LINE	38,"./mainloop/hud.h::main::5::169"
	ld	a,8
	ld	(__x),a
	ld	a,23
	ld	(__y),a
	ld	hl,(_p_ammo)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_print_number2
;			ammo_old = p_ammo;
	C_LINE	39,"./mainloop/hud.h::main::5::169"
	C_LINE	39,"./mainloop/hud.h::main::5::169"
	ld	hl,(_p_ammo)
	ld	h,0
	ld	a,l
	ld	(_ammo_old),a
;		}
	C_LINE	40,"./mainloop/hud.h::main::5::169"
;	
	C_LINE	41,"./mainloop/hud.h::main::4::169"
;	
	C_LINE	43,"./mainloop/hud.h::main::4::169"
;#line 178 "mainloop/game_loop.h"
	C_LINE	49,"./mainloop/hud.h::main::4::169"
	C_LINE	177,"mainloop/game_loop.h::main::4::169"
;		maincounter ++;
	C_LINE	179,"mainloop/game_loop.h::main::4::169"
.i_284
	C_LINE	179,"mainloop/game_loop.h::main::4::169"
	ld	hl,_maincounter
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
;		half_life = !half_life;
	C_LINE	180,"mainloop/game_loop.h::main::4::169"
	C_LINE	180,"mainloop/game_loop.h::main::4::169"
	ld	hl,(_half_life)
	ld	h,0
	call	l_lneg
	ld	h,0
	ld	a,l
	ld	(_half_life),a
;		
	C_LINE	181,"mainloop/game_loop.h::main::4::169"
;		 
	C_LINE	182,"mainloop/game_loop.h::main::4::169"
;		player_move ();
	C_LINE	183,"mainloop/game_loop.h::main::4::169"
	C_LINE	183,"mainloop/game_loop.h::main::4::169"
	call	_player_move
;		
	C_LINE	184,"mainloop/game_loop.h::main::4::169"
;		 
	C_LINE	185,"mainloop/game_loop.h::main::4::169"
;		enems_move ();
	C_LINE	186,"mainloop/game_loop.h::main::4::169"
	C_LINE	186,"mainloop/game_loop.h::main::4::169"
	call	_enems_move
;		
	C_LINE	188,"mainloop/game_loop.h::main::4::169"
;			 
	C_LINE	189,"mainloop/game_loop.h::main::4::169"
;			simple_coco_update ();
	C_LINE	190,"mainloop/game_loop.h::main::4::169"
	C_LINE	190,"mainloop/game_loop.h::main::4::169"
	call	_simple_coco_update
;		
	C_LINE	191,"mainloop/game_loop.h::main::4::169"
;		if (p_killme) {
	C_LINE	193,"mainloop/game_loop.h::main::4::169"
	C_LINE	193,"mainloop/game_loop.h::main::4::169"
	ld	hl,(_p_killme)
	ld	a,l
	and	a
	jp	z,i_285	;
;			if (p_life) {
	C_LINE	194,"mainloop/game_loop.h::main::5::170"
	C_LINE	194,"mainloop/game_loop.h::main::5::170"
	ld	hl,(_p_life)
	ld	a,l
	and	a
	jp	z,i_286	;
;			player_kill (p_killme);
	C_LINE	195,"mainloop/game_loop.h::main::6::171"
	C_LINE	195,"mainloop/game_loop.h::main::6::171"
;p_killme;
	C_LINE	196,"mainloop/game_loop.h::main::6::171"
	ld	hl,(_p_killme)
	ld	h,0
	push	hl
	call	_player_kill
	pop	bc
;			#line 1 "./my/ci/on_player_killed.h"
	C_LINE	196,"mainloop/game_loop.h::main::6::171"
	C_LINE	0,"./my/ci/on_player_killed.h::main::6::171"
; 
	C_LINE	1,"./my/ci/on_player_killed.h::main::6::171"
; 
	C_LINE	2,"./my/ci/on_player_killed.h::main::6::171"
;#line 197 "mainloop/game_loop.h"
	C_LINE	4,"./my/ci/on_player_killed.h::main::6::171"
	C_LINE	196,"mainloop/game_loop.h::main::6::171"
;			} else playing = 0;
	C_LINE	197,"mainloop/game_loop.h::main::6::171"
	jp	i_287	;EOS
.i_286
	C_LINE	197,"mainloop/game_loop.h::main::5::171"
	ld	hl,0	;const
	ld	a,l
	ld	(_playing),a
.i_287
;		}
	C_LINE	198,"mainloop/game_loop.h::main::5::171"
;		
	C_LINE	200,"mainloop/game_loop.h::main::4::171"
;			 
	C_LINE	201,"mainloop/game_loop.h::main::4::171"
;			bullets_move ();
	C_LINE	202,"mainloop/game_loop.h::main::4::171"
.i_285
	C_LINE	202,"mainloop/game_loop.h::main::4::171"
	call	_bullets_move
;		
	C_LINE	203,"mainloop/game_loop.h::main::4::171"
;		
	C_LINE	205,"mainloop/game_loop.h::main::4::171"
;		 
	C_LINE	209,"mainloop/game_loop.h::main::4::171"
;		
	C_LINE	210,"mainloop/game_loop.h::main::4::171"
;		 
	C_LINE	218,"mainloop/game_loop.h::main::4::171"
;		if (o_pant == n_pant) {
	C_LINE	219,"mainloop/game_loop.h::main::4::171"
	C_LINE	219,"mainloop/game_loop.h::main::4::171"
	ld	de,(_o_pant)
	ld	d,0
	ld	hl,(_n_pant)
	ld	h,d
	call	l_eq
	jp	nc,i_288	;
;			#line 1 "./mainloop/update_sprites.h"
	C_LINE	220,"mainloop/game_loop.h::main::5::172"
	C_LINE	0,"./mainloop/update_sprites.h::main::5::172"
; 
	C_LINE	1,"./mainloop/update_sprites.h::main::5::172"
; 
	C_LINE	2,"./mainloop/update_sprites.h::main::5::172"
; 
	C_LINE	4,"./mainloop/update_sprites.h::main::5::172"
;	for (enit = 0; enit <  3 ; enit ++) {
	C_LINE	6,"./mainloop/update_sprites.h::main::5::172"
	C_LINE	6,"./mainloop/update_sprites.h::main::5::172"
	xor	a
	ld	(_enit),a
	jp	i_291	;EOS
.i_289
	ld	hl,_enit
	ld	a,(hl)
	inc	(hl)
.i_291
	ld	hl,(_enit)
	ld	h,0
	ld	a,l
	sub	3
	jp	nc,i_290	;
;		enoffsmasi = enoffs + enit;
	C_LINE	7,"./mainloop/update_sprites.h::main::7::173"
	C_LINE	7,"./mainloop/update_sprites.h::main::7::173"
	ld	de,(_enoffs)
	ld	d,0
	ld	hl,(_enit)
	ld	h,d
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_enoffsmasi),a
;		enems_draw_current ();
	C_LINE	8,"./mainloop/update_sprites.h::main::7::173"
	C_LINE	8,"./mainloop/update_sprites.h::main::7::173"
	call	_enems_draw_current
;	}
	C_LINE	9,"./mainloop/update_sprites.h::main::7::173"
	jp	i_289	;EOS
.i_290
;	if ( (p_estado &  2 ) == 0 || half_life == 0 ) {
	C_LINE	11,"./mainloop/update_sprites.h::main::5::173"
	C_LINE	11,"./mainloop/update_sprites.h::main::5::173"
	ld	hl,(_p_estado)
	ld	h,0
	ld	a,2
	and	l
	ld	l,a
	jp	z,i_293	;
	ld	a,(_half_life)
	and	a
	jp	nz,i_292	;
.i_293
;		 
	C_LINE	12,"./mainloop/update_sprites.h::main::6::174"
;		#asm
	C_LINE	13,"./mainloop/update_sprites.h::main::6::174"
	C_LINE	13,"./mainloop/update_sprites.h::main::6::174"
	C_LINE	15,"./mainloop/update_sprites.h::main::6::174"
				ld  ix, (_sp_player)
	C_LINE	16,"./mainloop/update_sprites.h::main::6::174"
				ld  iy, vpClipStruct
	C_LINE	18,"./mainloop/update_sprites.h::main::6::174"
				ld  hl, (_p_next_frame)
	C_LINE	19,"./mainloop/update_sprites.h::main::6::174"
				ld  de, (_p_current_frame)
	C_LINE	20,"./mainloop/update_sprites.h::main::6::174"
				or  a
	C_LINE	21,"./mainloop/update_sprites.h::main::6::174"
				sbc hl, de
	C_LINE	22,"./mainloop/update_sprites.h::main::6::174"
				ld  b, h
	C_LINE	23,"./mainloop/update_sprites.h::main::6::174"
				ld  c, l
	C_LINE	25,"./mainloop/update_sprites.h::main::6::174"
				ld  a, (_gpy)
	C_LINE	26,"./mainloop/update_sprites.h::main::6::174"
				srl a
	C_LINE	27,"./mainloop/update_sprites.h::main::6::174"
				srl a
	C_LINE	28,"./mainloop/update_sprites.h::main::6::174"
				srl a
	C_LINE	29,"./mainloop/update_sprites.h::main::6::174"
				add  1 
	C_LINE	30,"./mainloop/update_sprites.h::main::6::174"
				ld  h, a 
	C_LINE	32,"./mainloop/update_sprites.h::main::6::174"
				ld  a, (_gpx)
	C_LINE	33,"./mainloop/update_sprites.h::main::6::174"
				srl a
	C_LINE	34,"./mainloop/update_sprites.h::main::6::174"
				srl a
	C_LINE	35,"./mainloop/update_sprites.h::main::6::174"
				srl a
	C_LINE	36,"./mainloop/update_sprites.h::main::6::174"
				add  1 
	C_LINE	37,"./mainloop/update_sprites.h::main::6::174"
				ld  l, a 
	C_LINE	38,"./mainloop/update_sprites.h::main::6::174"
	C_LINE	39,"./mainloop/update_sprites.h::main::6::174"
				ld  a, (_gpx)
	C_LINE	40,"./mainloop/update_sprites.h::main::6::174"
				and 7
	C_LINE	41,"./mainloop/update_sprites.h::main::6::174"
				ld  d, a
	C_LINE	43,"./mainloop/update_sprites.h::main::6::174"
				ld  a, (_gpy)
	C_LINE	44,"./mainloop/update_sprites.h::main::6::174"
				and 7
	C_LINE	45,"./mainloop/update_sprites.h::main::6::174"
				ld  e, a
	C_LINE	47,"./mainloop/update_sprites.h::main::6::174"
				call SPMoveSprAbs
	C_LINE	48,"./mainloop/update_sprites.h::main::6::174"
;	} else {
	C_LINE	50,"./mainloop/update_sprites.h::main::6::174"
	jp	i_295	;EOS
.i_292
	C_LINE	50,"./mainloop/update_sprites.h::main::5::174"
;		 
	C_LINE	51,"./mainloop/update_sprites.h::main::6::175"
;		#asm
	C_LINE	52,"./mainloop/update_sprites.h::main::6::175"
	C_LINE	52,"./mainloop/update_sprites.h::main::6::175"
	C_LINE	54,"./mainloop/update_sprites.h::main::6::175"
				ld  ix, (_sp_player)
	C_LINE	55,"./mainloop/update_sprites.h::main::6::175"
				ld  iy, vpClipStruct
	C_LINE	57,"./mainloop/update_sprites.h::main::6::175"
				ld  hl, (_p_next_frame)
	C_LINE	58,"./mainloop/update_sprites.h::main::6::175"
				ld  de, (_p_current_frame)
	C_LINE	59,"./mainloop/update_sprites.h::main::6::175"
				or  a
	C_LINE	60,"./mainloop/update_sprites.h::main::6::175"
				sbc hl, de
	C_LINE	61,"./mainloop/update_sprites.h::main::6::175"
				ld  b, h
	C_LINE	62,"./mainloop/update_sprites.h::main::6::175"
				ld  c, l
	C_LINE	64,"./mainloop/update_sprites.h::main::6::175"
				ld  hl, 0xfefe
	C_LINE	65,"./mainloop/update_sprites.h::main::6::175"
				ld  de, 0
	C_LINE	66,"./mainloop/update_sprites.h::main::6::175"
				call SPMoveSprAbs
	C_LINE	67,"./mainloop/update_sprites.h::main::6::175"
;	}
	C_LINE	69,"./mainloop/update_sprites.h::main::6::175"
.i_295
;	p_current_frame = p_next_frame;
	C_LINE	71,"./mainloop/update_sprites.h::main::5::175"
	C_LINE	71,"./mainloop/update_sprites.h::main::5::175"
	ld	hl,(_p_next_frame)
	ld	(_p_current_frame),hl
;			for (gpit = 0; gpit <  3 ; gpit ++) {
	C_LINE	73,"./mainloop/update_sprites.h::main::5::175"
	C_LINE	73,"./mainloop/update_sprites.h::main::5::175"
	xor	a
	ld	(_gpit),a
	jp	i_298	;EOS
.i_296
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_298
	ld	hl,(_gpit)
	ld	h,0
	ld	a,l
	sub	3
	jp	nc,i_297	;
;			if (bullets_estado [gpit] == 1) {
	C_LINE	74,"./mainloop/update_sprites.h::main::7::176"
	C_LINE	74,"./mainloop/update_sprites.h::main::7::176"
	ld	de,_bullets_estado
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	cp	1
	jp	nz,i_299	;
;				rdx = bullets_x [gpit]; rdy = bullets_y [gpit];
	C_LINE	75,"./mainloop/update_sprites.h::main::8::177"
	C_LINE	75,"./mainloop/update_sprites.h::main::8::177"
	ld	de,_bullets_x
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	ld	(_rdx),a
	ld	de,_bullets_y
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rdy),a
;				 
	C_LINE	76,"./mainloop/update_sprites.h::main::8::177"
;				#asm
	C_LINE	77,"./mainloop/update_sprites.h::main::8::177"
	C_LINE	77,"./mainloop/update_sprites.h::main::8::177"
	C_LINE	79,"./mainloop/update_sprites.h::main::8::177"
						ld  a, (_gpit)
	C_LINE	80,"./mainloop/update_sprites.h::main::8::177"
						sla a
	C_LINE	81,"./mainloop/update_sprites.h::main::8::177"
						ld  c, a
	C_LINE	82,"./mainloop/update_sprites.h::main::8::177"
						ld  b, 0 				 
	C_LINE	83,"./mainloop/update_sprites.h::main::8::177"
						ld  hl, _sp_bullets
	C_LINE	84,"./mainloop/update_sprites.h::main::8::177"
						add hl, bc
	C_LINE	85,"./mainloop/update_sprites.h::main::8::177"
						ld  e, (hl)
	C_LINE	86,"./mainloop/update_sprites.h::main::8::177"
						inc hl 
	C_LINE	87,"./mainloop/update_sprites.h::main::8::177"
						ld  d, (hl)
	C_LINE	88,"./mainloop/update_sprites.h::main::8::177"
						push de						
	C_LINE	89,"./mainloop/update_sprites.h::main::8::177"
						pop ix
	C_LINE	91,"./mainloop/update_sprites.h::main::8::177"
						ld  iy, vpClipStruct
	C_LINE	92,"./mainloop/update_sprites.h::main::8::177"
						ld  bc, 0
	C_LINE	94,"./mainloop/update_sprites.h::main::8::177"
						ld  a, (_rdy)
	C_LINE	95,"./mainloop/update_sprites.h::main::8::177"
						srl a
	C_LINE	96,"./mainloop/update_sprites.h::main::8::177"
						srl a
	C_LINE	97,"./mainloop/update_sprites.h::main::8::177"
						srl a
	C_LINE	98,"./mainloop/update_sprites.h::main::8::177"
						add  1 
	C_LINE	99,"./mainloop/update_sprites.h::main::8::177"
						ld  h, a
	C_LINE	101,"./mainloop/update_sprites.h::main::8::177"
						ld  a, (_rdx)
	C_LINE	102,"./mainloop/update_sprites.h::main::8::177"
						srl a
	C_LINE	103,"./mainloop/update_sprites.h::main::8::177"
						srl a
	C_LINE	104,"./mainloop/update_sprites.h::main::8::177"
						srl a
	C_LINE	105,"./mainloop/update_sprites.h::main::8::177"
						add  1 
	C_LINE	106,"./mainloop/update_sprites.h::main::8::177"
						ld  l, a
	C_LINE	108,"./mainloop/update_sprites.h::main::8::177"
						ld  a, (_rdx)
	C_LINE	109,"./mainloop/update_sprites.h::main::8::177"
						and 7
	C_LINE	110,"./mainloop/update_sprites.h::main::8::177"
						ld  d, a 
	C_LINE	112,"./mainloop/update_sprites.h::main::8::177"
						ld  a, (_rdy)
	C_LINE	113,"./mainloop/update_sprites.h::main::8::177"
						and 7
	C_LINE	114,"./mainloop/update_sprites.h::main::8::177"
						ld  e, a 
	C_LINE	115,"./mainloop/update_sprites.h::main::8::177"
	C_LINE	116,"./mainloop/update_sprites.h::main::8::177"
						call SPMoveSprAbs
	C_LINE	117,"./mainloop/update_sprites.h::main::8::177"
;			} else {
	C_LINE	119,"./mainloop/update_sprites.h::main::8::177"
	jp	i_300	;EOS
.i_299
	C_LINE	119,"./mainloop/update_sprites.h::main::7::177"
;				 
	C_LINE	120,"./mainloop/update_sprites.h::main::8::178"
;				#asm
	C_LINE	121,"./mainloop/update_sprites.h::main::8::178"
	C_LINE	121,"./mainloop/update_sprites.h::main::8::178"
	C_LINE	123,"./mainloop/update_sprites.h::main::8::178"
						ld  a, (_gpit)
	C_LINE	124,"./mainloop/update_sprites.h::main::8::178"
						sla a
	C_LINE	125,"./mainloop/update_sprites.h::main::8::178"
						ld  c, a
	C_LINE	126,"./mainloop/update_sprites.h::main::8::178"
						ld  b, 0 				 
	C_LINE	127,"./mainloop/update_sprites.h::main::8::178"
						ld  hl, _sp_bullets
	C_LINE	128,"./mainloop/update_sprites.h::main::8::178"
						add hl, bc
	C_LINE	129,"./mainloop/update_sprites.h::main::8::178"
						ld  e, (hl)
	C_LINE	130,"./mainloop/update_sprites.h::main::8::178"
						inc hl 
	C_LINE	131,"./mainloop/update_sprites.h::main::8::178"
						ld  d, (hl)
	C_LINE	132,"./mainloop/update_sprites.h::main::8::178"
						push de						
	C_LINE	133,"./mainloop/update_sprites.h::main::8::178"
						pop ix
	C_LINE	135,"./mainloop/update_sprites.h::main::8::178"
						ld  iy, vpClipStruct
	C_LINE	136,"./mainloop/update_sprites.h::main::8::178"
						ld  bc, 0
	C_LINE	138,"./mainloop/update_sprites.h::main::8::178"
						ld  hl, 0xfefe
	C_LINE	139,"./mainloop/update_sprites.h::main::8::178"
						ld  de, 0 
	C_LINE	140,"./mainloop/update_sprites.h::main::8::178"
	C_LINE	141,"./mainloop/update_sprites.h::main::8::178"
						call SPMoveSprAbs
	C_LINE	142,"./mainloop/update_sprites.h::main::8::178"
;			}
	C_LINE	144,"./mainloop/update_sprites.h::main::8::178"
.i_300
;		}
	C_LINE	145,"./mainloop/update_sprites.h::main::7::178"
	jp	i_296	;EOS
.i_297
;			
	C_LINE	146,"./mainloop/update_sprites.h::main::5::178"
;			for (gpit = 0; gpit <  3 ; gpit ++) {
	C_LINE	147,"./mainloop/update_sprites.h::main::5::178"
	C_LINE	147,"./mainloop/update_sprites.h::main::5::178"
	xor	a
	ld	(_gpit),a
	jp	i_303	;EOS
.i_301
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_303
	ld	hl,(_gpit)
	ld	h,0
	ld	a,l
	sub	3
	jp	nc,i_302	;
;			if (cocos_y [gpit] < 160) { 
	C_LINE	148,"./mainloop/update_sprites.h::main::7::179"
	C_LINE	148,"./mainloop/update_sprites.h::main::7::179"
	ld	de,_cocos_y
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	sub	160
	jp	nc,i_304	;
;				rdx = cocos_x [gpit]; rdy = cocos_y [gpit];
	C_LINE	149,"./mainloop/update_sprites.h::main::8::180"
	C_LINE	149,"./mainloop/update_sprites.h::main::8::180"
	ld	de,_cocos_x
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	ld	(_rdx),a
	ld	de,_cocos_y
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rdy),a
;				 
	C_LINE	150,"./mainloop/update_sprites.h::main::8::180"
;				#asm
	C_LINE	151,"./mainloop/update_sprites.h::main::8::180"
	C_LINE	151,"./mainloop/update_sprites.h::main::8::180"
	C_LINE	153,"./mainloop/update_sprites.h::main::8::180"
						ld  a, (_gpit)
	C_LINE	154,"./mainloop/update_sprites.h::main::8::180"
						sla a
	C_LINE	155,"./mainloop/update_sprites.h::main::8::180"
						ld  c, a
	C_LINE	156,"./mainloop/update_sprites.h::main::8::180"
						ld  b, 0 				 
	C_LINE	157,"./mainloop/update_sprites.h::main::8::180"
						ld  hl, _sp_cocos
	C_LINE	158,"./mainloop/update_sprites.h::main::8::180"
						add hl, bc
	C_LINE	159,"./mainloop/update_sprites.h::main::8::180"
						ld  e, (hl)
	C_LINE	160,"./mainloop/update_sprites.h::main::8::180"
						inc hl 
	C_LINE	161,"./mainloop/update_sprites.h::main::8::180"
						ld  d, (hl)
	C_LINE	162,"./mainloop/update_sprites.h::main::8::180"
						push de						
	C_LINE	163,"./mainloop/update_sprites.h::main::8::180"
						pop ix
	C_LINE	165,"./mainloop/update_sprites.h::main::8::180"
						ld  iy, vpClipStruct
	C_LINE	166,"./mainloop/update_sprites.h::main::8::180"
						ld  bc, 0
	C_LINE	168,"./mainloop/update_sprites.h::main::8::180"
						ld  a, (_rdy)
	C_LINE	169,"./mainloop/update_sprites.h::main::8::180"
						srl a
	C_LINE	170,"./mainloop/update_sprites.h::main::8::180"
						srl a
	C_LINE	171,"./mainloop/update_sprites.h::main::8::180"
						srl a
	C_LINE	172,"./mainloop/update_sprites.h::main::8::180"
						add  1 
	C_LINE	173,"./mainloop/update_sprites.h::main::8::180"
						ld  h, a
	C_LINE	175,"./mainloop/update_sprites.h::main::8::180"
						ld  a, (_rdx)
	C_LINE	176,"./mainloop/update_sprites.h::main::8::180"
						srl a
	C_LINE	177,"./mainloop/update_sprites.h::main::8::180"
						srl a
	C_LINE	178,"./mainloop/update_sprites.h::main::8::180"
						srl a
	C_LINE	179,"./mainloop/update_sprites.h::main::8::180"
						add  1 
	C_LINE	180,"./mainloop/update_sprites.h::main::8::180"
						ld  l, a
	C_LINE	182,"./mainloop/update_sprites.h::main::8::180"
						ld  a, (_rdx)
	C_LINE	183,"./mainloop/update_sprites.h::main::8::180"
						and 7
	C_LINE	184,"./mainloop/update_sprites.h::main::8::180"
						ld  d, a 
	C_LINE	186,"./mainloop/update_sprites.h::main::8::180"
						ld  a, (_rdy)
	C_LINE	187,"./mainloop/update_sprites.h::main::8::180"
						and 7
	C_LINE	188,"./mainloop/update_sprites.h::main::8::180"
						ld  e, a 
	C_LINE	189,"./mainloop/update_sprites.h::main::8::180"
	C_LINE	190,"./mainloop/update_sprites.h::main::8::180"
						call SPMoveSprAbs
	C_LINE	191,"./mainloop/update_sprites.h::main::8::180"
;			} else {
	C_LINE	193,"./mainloop/update_sprites.h::main::8::180"
	jp	i_305	;EOS
.i_304
	C_LINE	193,"./mainloop/update_sprites.h::main::7::180"
;				 
	C_LINE	194,"./mainloop/update_sprites.h::main::8::181"
;				#asm
	C_LINE	195,"./mainloop/update_sprites.h::main::8::181"
	C_LINE	195,"./mainloop/update_sprites.h::main::8::181"
	C_LINE	197,"./mainloop/update_sprites.h::main::8::181"
						ld  a, (_gpit)
	C_LINE	198,"./mainloop/update_sprites.h::main::8::181"
						sla a
	C_LINE	199,"./mainloop/update_sprites.h::main::8::181"
						ld  c, a
	C_LINE	200,"./mainloop/update_sprites.h::main::8::181"
						ld  b, 0 				 
	C_LINE	201,"./mainloop/update_sprites.h::main::8::181"
						ld  hl, _sp_cocos
	C_LINE	202,"./mainloop/update_sprites.h::main::8::181"
						add hl, bc
	C_LINE	203,"./mainloop/update_sprites.h::main::8::181"
						ld  e, (hl)
	C_LINE	204,"./mainloop/update_sprites.h::main::8::181"
						inc hl 
	C_LINE	205,"./mainloop/update_sprites.h::main::8::181"
						ld  d, (hl)
	C_LINE	206,"./mainloop/update_sprites.h::main::8::181"
						push de						
	C_LINE	207,"./mainloop/update_sprites.h::main::8::181"
						pop ix
	C_LINE	209,"./mainloop/update_sprites.h::main::8::181"
						ld  iy, vpClipStruct
	C_LINE	210,"./mainloop/update_sprites.h::main::8::181"
						ld  bc, 0
	C_LINE	212,"./mainloop/update_sprites.h::main::8::181"
						ld  hl, 0xfefe
	C_LINE	213,"./mainloop/update_sprites.h::main::8::181"
						ld  de, 0 
	C_LINE	214,"./mainloop/update_sprites.h::main::8::181"
	C_LINE	215,"./mainloop/update_sprites.h::main::8::181"
						call SPMoveSprAbs
	C_LINE	216,"./mainloop/update_sprites.h::main::8::181"
;			}
	C_LINE	218,"./mainloop/update_sprites.h::main::8::181"
.i_305
;		}
	C_LINE	219,"./mainloop/update_sprites.h::main::7::181"
	jp	i_301	;EOS
.i_302
;	#line 221 "mainloop/game_loop.h"
	C_LINE	220,"./mainloop/update_sprites.h::main::5::181"
	C_LINE	220,"mainloop/game_loop.h::main::5::181"
;			 
	C_LINE	222,"mainloop/game_loop.h::main::5::181"
;			
	C_LINE	223,"mainloop/game_loop.h::main::5::181"
;			
	C_LINE	224,"mainloop/game_loop.h::main::5::181"
;			sp_UpdateNow();
	C_LINE	239,"mainloop/game_loop.h::main::5::181"
	C_LINE	239,"mainloop/game_loop.h::main::5::181"
	call	sp_UpdateNow
;		}
	C_LINE	240,"mainloop/game_loop.h::main::5::181"
;		
	C_LINE	242,"mainloop/game_loop.h::main::4::181"
;			 
	C_LINE	243,"mainloop/game_loop.h::main::4::181"
;			if (p_estado ==  2 ) {
	C_LINE	244,"mainloop/game_loop.h::main::4::181"
.i_288
	C_LINE	244,"mainloop/game_loop.h::main::4::181"
	ld	hl,(_p_estado)
	ld	h,0
	ld	a,l
	cp	2
	jp	nz,i_306	;
;				p_ct_estado --;
	C_LINE	245,"mainloop/game_loop.h::main::5::182"
	C_LINE	245,"mainloop/game_loop.h::main::5::182"
	ld	hl,_p_ct_estado
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	ld	h,0
;				if (p_ct_estado == 0)
	C_LINE	246,"mainloop/game_loop.h::main::5::182"
	C_LINE	246,"mainloop/game_loop.h::main::5::182"
	ld	hl,(_p_ct_estado)
	ld	h,0
	ld	a,l
	and	a
	jp	nz,i_307	;
;					p_estado =  0 ; 
	C_LINE	247,"mainloop/game_loop.h::main::5::182"
	C_LINE	247,"mainloop/game_loop.h::main::5::182"
	ld	hl,0	;const
	ld	a,l
	ld	(_p_estado),a
;			}
	C_LINE	248,"mainloop/game_loop.h::main::5::182"
.i_307
;		
	C_LINE	249,"mainloop/game_loop.h::main::4::182"
;		
	C_LINE	250,"mainloop/game_loop.h::main::4::182"
;		 
	C_LINE	251,"mainloop/game_loop.h::main::4::182"
;		hotspots_do ();
	C_LINE	252,"mainloop/game_loop.h::main::4::182"
.i_306
	C_LINE	252,"mainloop/game_loop.h::main::4::182"
	call	_hotspots_do
;		 
	C_LINE	254,"mainloop/game_loop.h::main::4::182"
;		
	C_LINE	255,"mainloop/game_loop.h::main::4::182"
;		
	C_LINE	256,"mainloop/game_loop.h::main::4::182"
; 
	C_LINE	257,"mainloop/game_loop.h::main::4::182"
; 
	C_LINE	286,"mainloop/game_loop.h::main::4::182"
;		
	C_LINE	292,"mainloop/game_loop.h::main::4::182"
; 
	C_LINE	293,"mainloop/game_loop.h::main::4::182"
;		 
	C_LINE	313,"mainloop/game_loop.h::main::4::182"
;			
	C_LINE	314,"mainloop/game_loop.h::main::4::182"
;		
	C_LINE	315,"mainloop/game_loop.h::main::4::182"
;		{
	C_LINE	318,"mainloop/game_loop.h::main::4::182"
	C_LINE	318,"mainloop/game_loop.h::main::4::182"
;			#line 1 "./mainloop/flick_screen.h"
	C_LINE	319,"mainloop/game_loop.h::main::5::183"
	C_LINE	0,"./mainloop/flick_screen.h::main::5::183"
; 
	C_LINE	1,"./mainloop/flick_screen.h::main::5::183"
; 
	C_LINE	2,"./mainloop/flick_screen.h::main::5::183"
; 
	C_LINE	4,"./mainloop/flick_screen.h::main::5::183"
;	
	C_LINE	6,"./mainloop/flick_screen.h::main::5::183"
;		
	C_LINE	52,"./mainloop/flick_screen.h::main::5::183"
; 
	C_LINE	57,"./mainloop/flick_screen.h::main::5::183"
;		
	C_LINE	63,"./mainloop/flick_screen.h::main::5::183"
;			
	C_LINE	64,"./mainloop/flick_screen.h::main::5::183"
;				if (gpy == 0 && p_vy < 0 && n_pant >= level_data.map_w) {
	C_LINE	65,"./mainloop/flick_screen.h::main::5::183"
	C_LINE	65,"./mainloop/flick_screen.h::main::5::183"
	ld	a,(_gpy)
	and	a
	jp	nz,i_309	;
	ld	hl,(_p_vy)
	ld	a,h
	rla
	jp	nc,i_309	;
	ld	de,(_n_pant)
	ld	d,0
	ld	hl,(_level_data)
	ld	h,d
	call	l_uge
	jp	nc,i_309	;
	defc	i_309 = i_308
.i_310_i_309
;					n_pant -= level_data.map_w;
	C_LINE	66,"./mainloop/flick_screen.h::main::6::184"
	C_LINE	66,"./mainloop/flick_screen.h::main::6::184"
	ld	de,(_n_pant)
	ld	d,0
	ld	hl,(_level_data)
	ld	h,d
	ex	de,hl
	and	a
	sbc	hl,de
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
;			
	C_LINE	67,"./mainloop/flick_screen.h::main::6::184"
;				gpy = 144;
	C_LINE	71,"./mainloop/flick_screen.h::main::6::184"
	C_LINE	71,"./mainloop/flick_screen.h::main::6::184"
	ld	hl,144	;const
	ld	a,l
	ld	(_gpy),a
;				p_y = 9216;	
	C_LINE	72,"./mainloop/flick_screen.h::main::6::184"
	C_LINE	72,"./mainloop/flick_screen.h::main::6::184"
	ld	hl,9216	;const
	ld	(_p_y),hl
;			}
	C_LINE	73,"./mainloop/flick_screen.h::main::6::184"
;			if (gpy == 144 && p_vy > 0) {				 
	C_LINE	75,"./mainloop/flick_screen.h::main::5::184"
.i_308
	C_LINE	75,"./mainloop/flick_screen.h::main::5::184"
	ld	a,(_gpy)
	cp	144
	jp	nz,i_312	;
	ld	hl,(_p_vy)
	ld	de,0
	ex	de,hl
	call	l_gt
	jp	nc,i_312	;
	defc	i_312 = i_311
.i_313_i_312
;				
	C_LINE	76,"./mainloop/flick_screen.h::main::6::185"
;					if (n_pant < level_data.map_w * (level_data.map_h - 1)) {
	C_LINE	77,"./mainloop/flick_screen.h::main::6::185"
	C_LINE	77,"./mainloop/flick_screen.h::main::6::185"
	ld	hl,(_n_pant)
	ld	h,0
	push	hl
	ld	hl,(_level_data)
	ld	h,0
	push	hl
	ld	hl,(_level_data+1)
	ld	h,0
	dec	hl
	pop	de
	call	l_mult
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	jp	nc,i_314	;
;						n_pant += level_data.map_w;
	C_LINE	78,"./mainloop/flick_screen.h::main::7::186"
	C_LINE	78,"./mainloop/flick_screen.h::main::7::186"
	ld	de,(_n_pant)
	ld	d,0
	ld	hl,(_level_data)
	ld	h,d
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
;				
	C_LINE	79,"./mainloop/flick_screen.h::main::7::186"
;					gpy = p_y = 0;
	C_LINE	83,"./mainloop/flick_screen.h::main::7::186"
	C_LINE	83,"./mainloop/flick_screen.h::main::7::186"
	ld	hl,0	;const
	ld	(_p_y),hl
	ld	h,0
	ld	a,l
	ld	(_gpy),a
;					if (p_vy > 256) p_vy = 256;
	C_LINE	84,"./mainloop/flick_screen.h::main::7::186"
	C_LINE	84,"./mainloop/flick_screen.h::main::7::186"
	ld	hl,(_p_vy)
	ld	de,256
	ex	de,hl
	call	l_gt
	jp	nc,i_315	;
	ld	hl,256	;const
	ld	(_p_vy),hl
;				}
	C_LINE	85,"./mainloop/flick_screen.h::main::7::186"
.i_315
;				
	C_LINE	86,"./mainloop/flick_screen.h::main::6::186"
;			}
	C_LINE	98,"./mainloop/flick_screen.h::main::6::186"
.i_314
;		
	C_LINE	99,"./mainloop/flick_screen.h::main::5::186"
;	
	C_LINE	100,"./mainloop/flick_screen.h::main::5::186"
;#line 320 "mainloop/game_loop.h"
	C_LINE	101,"./mainloop/flick_screen.h::main::5::186"
	C_LINE	319,"mainloop/game_loop.h::main::5::186"
;		}
	C_LINE	320,"mainloop/game_loop.h::main::5::186"
.i_311
;		 
	C_LINE	322,"mainloop/game_loop.h::main::4::186"
;		
	C_LINE	323,"mainloop/game_loop.h::main::4::186"
;		if (0
	C_LINE	324,"mainloop/game_loop.h::main::4::186"
	C_LINE	324,"mainloop/game_loop.h::main::4::186"
;		
	C_LINE	342,"mainloop/game_loop.h::main::4::187"
;		 
	C_LINE	343,"mainloop/game_loop.h::main::4::187"
;		
	C_LINE	344,"mainloop/game_loop.h::main::4::187"
;		#line 1 "./my/ci/extra_routines.h"
	C_LINE	357,"mainloop/game_loop.h::main::4::187"
	C_LINE	0,"./my/ci/extra_routines.h::main::4::187"
; 
	C_LINE	1,"./my/ci/extra_routines.h::main::4::187"
; 
	C_LINE	2,"./my/ci/extra_routines.h::main::4::187"
;if (n_pant == 0 && flags [1] == 0 && gpy < 96 && p_objs == 5) {
	C_LINE	4,"./my/ci/extra_routines.h::main::4::187"
	C_LINE	4,"./my/ci/extra_routines.h::main::4::187"
	ld	a,(_n_pant)
	and	a
	jp	nz,i_318	;
	ld	a,(_flags+1)
	and	a
	jp	nz,i_318	;
	ld	a,(_gpy)
	sub	96
	jp	nc,i_318	;
	ld	a,(_p_objs)
	cp	5
	jp	nz,i_318	;
	defc	i_318 = i_317
.i_319_i_318
;	flags [1] = 1;
	C_LINE	5,"./my/ci/extra_routines.h::main::5::188"
	C_LINE	5,"./my/ci/extra_routines.h::main::5::188"
	ld	hl,_flags+1
	ld	(hl),1
	ld	l,(hl)
	ld	h,0
;	 
	C_LINE	7,"./my/ci/extra_routines.h::main::5::188"
;	_gp_gen = decos_bombs;
	C_LINE	8,"./my/ci/extra_routines.h::main::5::188"
	C_LINE	8,"./my/ci/extra_routines.h::main::5::188"
	ld	hl,_decos_bombs
	ld	(__gp_gen),hl
;	for (gpit = 0; gpit < 5; ++ gpit) {
	C_LINE	9,"./my/ci/extra_routines.h::main::5::188"
	C_LINE	9,"./my/ci/extra_routines.h::main::5::188"
	xor	a
	ld	(_gpit),a
	jp	i_322	;EOS
.i_320
	ld	hl,_gpit
	inc	(hl)
	ld	l,(hl)
	ld	h,0
.i_322
	ld	hl,(_gpit)
	ld	h,0
	ld	a,l
	sub	5
	jp	nc,i_321	;
;		rda = *_gp_gen; _gp_gen += 2;
	C_LINE	10,"./my/ci/extra_routines.h::main::7::189"
	C_LINE	10,"./my/ci/extra_routines.h::main::7::189"
	ld	hl,(__gp_gen)
	ld	a,(hl)
	ld	(_rda),a
	ld	hl,(__gp_gen)
	inc	hl
	inc	hl
	ld	(__gp_gen),hl
;		_x = rda >> 4; _y = rda & 15; _t = 17;
	C_LINE	11,"./my/ci/extra_routines.h::main::7::189"
	C_LINE	11,"./my/ci/extra_routines.h::main::7::189"
	ld	hl,(_rda)
	ld	h,0
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	ld	h,0
	ld	(__x),a
	ld	hl,(_rda)
	ld	h,0
	ld	a,15
	and	l
	ld	(__y),a
	ld	hl,17	;const
	ld	a,l
	ld	(__t),a
;		update_tile ();
	C_LINE	12,"./my/ci/extra_routines.h::main::7::189"
	C_LINE	12,"./my/ci/extra_routines.h::main::7::189"
	call	_update_tile
;		sp_UpdateNow ();
	C_LINE	13,"./my/ci/extra_routines.h::main::7::189"
	C_LINE	13,"./my/ci/extra_routines.h::main::7::189"
	call	sp_UpdateNow
;		beep_fx (0);
	C_LINE	14,"./my/ci/extra_routines.h::main::7::189"
	C_LINE	14,"./my/ci/extra_routines.h::main::7::189"
;0;
	C_LINE	15,"./my/ci/extra_routines.h::main::7::189"
	ld	hl,0	;const
	push	hl
	call	_beep_fx
	pop	bc
;	}
	C_LINE	15,"./my/ci/extra_routines.h::main::7::189"
	jp	i_320	;EOS
.i_321
;	_x = 1; _y = 0; _t = 71; 
	C_LINE	17,"./my/ci/extra_routines.h::main::5::189"
	C_LINE	17,"./my/ci/extra_routines.h::main::5::189"
	ld	a,1
	ld	(__x),a
	xor	a
	ld	(__y),a
	ld	hl,71	;const
	ld	a,l
	ld	(__t),a
;	_gp_gen = (unsigned char *) ("  DONE! NOW GO BACK TO BASE!  ");
	C_LINE	18,"./my/ci/extra_routines.h::main::5::189"
	C_LINE	18,"./my/ci/extra_routines.h::main::5::189"
	ld	hl,i_1+258
	ld	(__gp_gen),hl
;	print_str ();
	C_LINE	19,"./my/ci/extra_routines.h::main::5::189"
	C_LINE	19,"./my/ci/extra_routines.h::main::5::189"
	call	_print_str
;}
	C_LINE	20,"./my/ci/extra_routines.h::main::5::189"
;if (flags [0]) {
	C_LINE	22,"./my/ci/extra_routines.h::main::4::189"
.i_317
	C_LINE	22,"./my/ci/extra_routines.h::main::4::189"
	ld	hl,(_flags)
	ld	a,l
	and	a
	jp	z,i_323	;
;	if (gpx < 64 && gpy >= 16 && gpy < 80) {
	C_LINE	23,"./my/ci/extra_routines.h::main::5::190"
	C_LINE	23,"./my/ci/extra_routines.h::main::5::190"
	ld	a,(_gpx)
	sub	64
	jp	nc,i_325	;
	ld	hl,(_gpy)
	ld	h,0
	ld	a,l
	sub	16
	ccf
	jp	nc,i_325	;
	ld	a,(_gpy)
	sub	80
	jp	nc,i_325	;
	defc	i_325 = i_324
.i_326_i_325
;		flags [0] = 0;
	C_LINE	24,"./my/ci/extra_routines.h::main::6::191"
	C_LINE	24,"./my/ci/extra_routines.h::main::6::191"
	ld	hl,_flags
	ld	(hl),0
	ld	l,(hl)
	ld	h,0
;		beep_fx (9);
	C_LINE	25,"./my/ci/extra_routines.h::main::6::191"
	C_LINE	25,"./my/ci/extra_routines.h::main::6::191"
;9;
	C_LINE	26,"./my/ci/extra_routines.h::main::6::191"
	ld	hl,9	;const
	push	hl
	call	_beep_fx
	pop	bc
;		_x = 1; _y = 0; _t = 71; 
	C_LINE	26,"./my/ci/extra_routines.h::main::6::191"
	C_LINE	26,"./my/ci/extra_routines.h::main::6::191"
	ld	a,1
	ld	(__x),a
	xor	a
	ld	(__y),a
	ld	hl,71	;const
	ld	a,l
	ld	(__t),a
;		_gp_gen = (unsigned char *) (" HALF NEW MOTORBIKE FOR SALE! ");
	C_LINE	27,"./my/ci/extra_routines.h::main::6::191"
	C_LINE	27,"./my/ci/extra_routines.h::main::6::191"
	ld	hl,i_1+289
	ld	(__gp_gen),hl
;		print_str ();
	C_LINE	28,"./my/ci/extra_routines.h::main::6::191"
	C_LINE	28,"./my/ci/extra_routines.h::main::6::191"
	call	_print_str
;	}
	C_LINE	29,"./my/ci/extra_routines.h::main::6::191"
;}
	C_LINE	30,"./my/ci/extra_routines.h::main::5::191"
.i_324
;	if (sp_KeyPressed ( 0x047f ) && sp_KeyPressed ( 0x02fe )) { 
	C_LINE	33,"./my/ci/extra_routines.h::main::4::191"
.i_323
	C_LINE	33,"./my/ci/extra_routines.h::main::4::191"
;0x047f ;
	C_LINE	34,"./my/ci/extra_routines.h::main::4::191"
	ld	hl,1151	;const
	push	hl
	call	sp_KeyPressed
	pop	bc
	ld	a,h
	or	l
	jp	z,i_328	;
;0x02fe ;
	C_LINE	34,"./my/ci/extra_routines.h::main::4::191"
	ld	hl,766	;const
	push	hl
	call	sp_KeyPressed
	pop	bc
	ld	a,h
	or	l
	jp	z,i_328	;
	defc	i_328 = i_327
.i_329_i_328
;		o_pant = 99; n_pant = 23; flags [1] = 1;
	C_LINE	34,"./my/ci/extra_routines.h::main::5::192"
	C_LINE	34,"./my/ci/extra_routines.h::main::5::192"
	ld	a,99
	ld	(_o_pant),a
	ld	a,23
	ld	(_n_pant),a
	ld	hl,_flags+1
	ld	(hl),1
	ld	l,(hl)
	ld	h,0
;	}
	C_LINE	35,"./my/ci/extra_routines.h::main::5::192"
;#line 358 "mainloop/game_loop.h"
	C_LINE	37,"./my/ci/extra_routines.h::main::4::192"
	C_LINE	357,"mainloop/game_loop.h::main::4::192"
;	}
	C_LINE	358,"mainloop/game_loop.h::main::4::192"
	jp	i_278	;EOS
	defc	i_327 = i_278
.i_279
;	
	C_LINE	359,"mainloop/game_loop.h::main::3::192"
;	sp_UpdateNow ();
	C_LINE	360,"mainloop/game_loop.h::main::3::192"
	C_LINE	360,"mainloop/game_loop.h::main::3::192"
	call	sp_UpdateNow
;	sp_WaitForNoKey ();
	C_LINE	361,"mainloop/game_loop.h::main::3::192"
	C_LINE	361,"mainloop/game_loop.h::main::3::192"
	call	sp_WaitForNoKey
;	
	C_LINE	363,"mainloop/game_loop.h::main::3::192"
;	#line 1 "./my/ci/after_game_loop.h"
	C_LINE	367,"mainloop/game_loop.h::main::3::192"
	C_LINE	0,"./my/ci/after_game_loop.h::main::3::192"
; 
	C_LINE	1,"./my/ci/after_game_loop.h::main::3::192"
; 
	C_LINE	2,"./my/ci/after_game_loop.h::main::3::192"
;_x = 1; _y = 0; _t = 71; 
	C_LINE	4,"./my/ci/after_game_loop.h::main::3::192"
	C_LINE	4,"./my/ci/after_game_loop.h::main::3::192"
	ld	a,1
	ld	(__x),a
	xor	a
	ld	(__y),a
	ld	hl,71	;const
	ld	a,l
	ld	(__t),a
;_gp_gen = (unsigned char *) ("                              ");
	C_LINE	5,"./my/ci/after_game_loop.h::main::3::192"
	C_LINE	5,"./my/ci/after_game_loop.h::main::3::192"
	ld	hl,i_1+320
	ld	(__gp_gen),hl
;print_str ();
	C_LINE	6,"./my/ci/after_game_loop.h::main::3::192"
	C_LINE	6,"./my/ci/after_game_loop.h::main::3::192"
	call	_print_str
;#line 368 "mainloop/game_loop.h"
	C_LINE	7,"./my/ci/after_game_loop.h::main::3::192"
	C_LINE	367,"mainloop/game_loop.h::main::3::192"
;#line 185 "mainloop.h"
	C_LINE	368,"mainloop/game_loop.h::main::3::192"
	C_LINE	184,"mainloop.h::main::3::192"
;			
	C_LINE	186,"mainloop.h::main::3::192"
;				if (success) {
	C_LINE	187,"mainloop.h::main::3::192"
	C_LINE	187,"mainloop.h::main::3::192"
	ld	hl,(_success)
	ld	a,l
	and	a
	jp	z,i_330	;
;					
	C_LINE	188,"mainloop.h::main::4::193"
; 
	C_LINE	189,"mainloop.h::main::4::193"
;					
	C_LINE	191,"mainloop.h::main::4::193"
;					if (silent_level == 0) zone_clear ();
	C_LINE	192,"mainloop.h::main::4::193"
	C_LINE	192,"mainloop.h::main::4::193"
	ld	hl,(_silent_level)
	ld	h,0
	ld	a,l
	and	a
	jp	nz,i_331	;
	call	_zone_clear
;					
	C_LINE	194,"mainloop.h::main::4::193"
;						if (warp_to_level == 0)
	C_LINE	197,"mainloop.h::main::4::193"
.i_331
	C_LINE	197,"mainloop.h::main::4::193"
	ld	hl,(_warp_to_level)
	ld	h,0
	ld	a,l
	and	a
	jp	nz,i_332	;
;					
	C_LINE	198,"mainloop.h::main::4::193"
;					{
	C_LINE	199,"mainloop.h::main::4::193"
	C_LINE	199,"mainloop.h::main::4::193"
;						level ++;
	C_LINE	200,"mainloop.h::main::5::194"
	C_LINE	200,"mainloop.h::main::5::194"
	ld	hl,_level
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
;					} 
	C_LINE	201,"mainloop.h::main::5::194"
;					
	C_LINE	202,"mainloop.h::main::4::194"
;					if (level >=  3  
	C_LINE	203,"mainloop.h::main::4::194"
.i_332
	C_LINE	203,"mainloop.h::main::4::194"
	ld	hl,(_level)
	ld	h,0
	ld	a,l
	sub	3
	ccf
	jp	nc,i_333	;
	C_LINE	207,"mainloop.h::main::4::194"
;						game_ending ();
	C_LINE	208,"mainloop.h::main::5::195"
	C_LINE	208,"mainloop.h::main::5::195"
	call	_game_ending
;						break;
	C_LINE	209,"mainloop.h::main::5::195"
	C_LINE	209,"mainloop.h::main::5::195"
	jp	i_276	;EOS
;					}
	C_LINE	210,"mainloop.h::main::5::195"
;				} else {
	C_LINE	211,"mainloop.h::main::4::195"
	jp	i_334	;EOS
	defc	i_333 = i_334
.i_330
	C_LINE	211,"mainloop.h::main::3::195"
;					
	C_LINE	212,"mainloop.h::main::4::196"
; 
	C_LINE	213,"mainloop.h::main::4::196"
;					
	C_LINE	216,"mainloop.h::main::4::196"
;						game_over ();
	C_LINE	219,"mainloop.h::main::4::196"
	C_LINE	219,"mainloop.h::main::4::196"
	call	_game_over
;					
	C_LINE	220,"mainloop.h::main::4::196"
;					
	C_LINE	221,"mainloop.h::main::4::196"
;					
	C_LINE	222,"mainloop.h::main::4::196"
;					break;
	C_LINE	225,"mainloop.h::main::4::196"
	C_LINE	225,"mainloop.h::main::4::196"
	jp	i_276	;EOS
;				}
	C_LINE	226,"mainloop.h::main::4::196"
.i_334
;			
	C_LINE	227,"mainloop.h::main::3::196"
; 
	C_LINE	231,"mainloop.h::main::3::196"
;			
	C_LINE	235,"mainloop.h::main::3::196"
;		}
	C_LINE	238,"mainloop.h::main::3::196"
	jp	i_275	;EOS
.i_276
;		
	C_LINE	239,"mainloop.h::main::2::196"
;		clear_sprites ();
	C_LINE	240,"mainloop.h::main::2::196"
	C_LINE	240,"mainloop.h::main::2::196"
	call	_clear_sprites
;	}
	C_LINE	241,"mainloop.h::main::2::196"
	jp	i_271	;EOS
.i_272
;}
	C_LINE	242,"mainloop.h::main::1::196"
	ret


;#line 143 "mk1.c"
	C_LINE	243,"mainloop.h::main::0::196"
	C_LINE	142,"mk1.c::main::0::196"
;	 
	C_LINE	145,"mk1.c::main::0::196"
;	#line 1 "sound/music.h"
	C_LINE	146,"mk1.c::main::0::196"
	C_LINE	0,"sound/music.h::main::0::196"
;#asm
	C_LINE	1,"sound/music.h::main::0::196"
	C_LINE	1,"sound/music.h::main::0::196"
	C_LINE	3,"sound/music.h::main::0::196"
; *****************************************************************************
	C_LINE	4,"sound/music.h::main::0::196"
; * phaser1 engine, with synthesised drums
	C_LINE	5,"sound/music.h::main::0::196"
; *
	C_LINE	6,"sound/music.h::main::0::196"
; * original code by shiru - .http 
	C_LINE	7,"sound/music.h::main::0::196"
; * modified by chris cowley
	C_LINE	8,"sound/music.h::main::0::196"
; *
	C_LINE	9,"sound/music.h::main::0::196"
; * produced by beepola v1.05.01
	C_LINE	10,"sound/music.h::main::0::196"
; ******************************************************************************
	C_LINE	11,"sound/music.h::main::0::196"
	C_LINE	12,"sound/music.h::main::0::196"
.musicstart
	C_LINE	13,"sound/music.h::main::0::196"
             ld    hl,musicdata         ;  <- pointer to music data. change
	C_LINE	14,"sound/music.h::main::0::196"
                                        ;     this to play a different song
	C_LINE	15,"sound/music.h::main::0::196"
             ld   a,(hl)                         ; get the loop start pointer
	C_LINE	16,"sound/music.h::main::0::196"
             ld   (pattern_loop_begin),a
	C_LINE	17,"sound/music.h::main::0::196"
             inc  hl
	C_LINE	18,"sound/music.h::main::0::196"
             ld   a,(hl)                         ; get the song end pointer
	C_LINE	19,"sound/music.h::main::0::196"
             ld   (pattern_loop_end),a
	C_LINE	20,"sound/music.h::main::0::196"
             inc  hl
	C_LINE	21,"sound/music.h::main::0::196"
             ld   e,(hl)
	C_LINE	22,"sound/music.h::main::0::196"
             inc  hl
	C_LINE	23,"sound/music.h::main::0::196"
             ld   d,(hl)
	C_LINE	24,"sound/music.h::main::0::196"
             inc  hl
	C_LINE	25,"sound/music.h::main::0::196"
             ld   (instrum_tbl),hl
	C_LINE	26,"sound/music.h::main::0::196"
             ld   (current_inst),hl
	C_LINE	27,"sound/music.h::main::0::196"
             add  hl,de
	C_LINE	28,"sound/music.h::main::0::196"
             ld   (pattern_addr),hl
	C_LINE	29,"sound/music.h::main::0::196"
             xor  a
	C_LINE	30,"sound/music.h::main::0::196"
             ld   (pattern_ptr),a                ; set the pattern pointer to zero
	C_LINE	31,"sound/music.h::main::0::196"
             ld   h,a
	C_LINE	32,"sound/music.h::main::0::196"
             ld   l,a
	C_LINE	33,"sound/music.h::main::0::196"
             ld   (note_ptr),hl                  ; set the note offset (within this pattern) to 0
	C_LINE	35,"sound/music.h::main::0::196"
.player
	C_LINE	37,"sound/music.h::main::0::196"
             push iy
	C_LINE	38,"sound/music.h::main::0::196"
             ;ld   a,border_col
	C_LINE	39,"sound/music.h::main::0::196"
             xor a
	C_LINE	40,"sound/music.h::main::0::196"
             ld   h,$00
	C_LINE	41,"sound/music.h::main::0::196"
             ld   l,a
	C_LINE	42,"sound/music.h::main::0::196"
             ld   (cnt_1a),hl
	C_LINE	43,"sound/music.h::main::0::196"
             ld   (cnt_1b),hl
	C_LINE	44,"sound/music.h::main::0::196"
             ld   (div_1a),hl
	C_LINE	45,"sound/music.h::main::0::196"
             ld   (div_1b),hl
	C_LINE	46,"sound/music.h::main::0::196"
             ld   (cnt_2),hl
	C_LINE	47,"sound/music.h::main::0::196"
             ld   (div_2),hl
	C_LINE	48,"sound/music.h::main::0::196"
             ld   (out_1),a
	C_LINE	49,"sound/music.h::main::0::196"
             ld   (out_2),a
	C_LINE	50,"sound/music.h::main::0::196"
             jr   main_loop
	C_LINE	52,"sound/music.h::main::0::196"
; ********************************************************************************************************
	C_LINE	53,"sound/music.h::main::0::196"
; * next_pattern
	C_LINE	54,"sound/music.h::main::0::196"
; *
	C_LINE	55,"sound/music.h::main::0::196"
; * select the next pattern in sequence (and handle looping if weve reached pattern_loop_end
	C_LINE	56,"sound/music.h::main::0::196"
; * execution falls through to playnote to play the first note from our next pattern
	C_LINE	57,"sound/music.h::main::0::196"
; ********************************************************************************************************
	C_LINE	58,"sound/music.h::main::0::196"
.next_pattern
	C_LINE	59,"sound/music.h::main::0::196"
                          ld   a,(pattern_ptr)
	C_LINE	60,"sound/music.h::main::0::196"
                          inc  a
	C_LINE	61,"sound/music.h::main::0::196"
                          inc  a
	C_LINE	62,"sound/music.h::main::0::196"
                          defb $fe                           ; cp n
	C_LINE	63,"sound/music.h::main::0::196"
.pattern_loop_end         defb 0
	C_LINE	64,"sound/music.h::main::0::196"
                          jr   nz,no_pattern_loop
	C_LINE	65,"sound/music.h::main::0::196"
                          ; handle pattern looping at and of song
	C_LINE	66,"sound/music.h::main::0::196"
                          defb $3e                           ; ld a,n
	C_LINE	67,"sound/music.h::main::0::196"
.pattern_loop_begin       defb 0
	C_LINE	68,"sound/music.h::main::0::196"
.no_pattern_loop          ld   (pattern_ptr),a
	C_LINE	69,"sound/music.h::main::0::196"
                          ld   hl,$0000
	C_LINE	70,"sound/music.h::main::0::196"
                          ld   (note_ptr),hl   ; start of pattern (note_ptr = 0)
	C_LINE	72,"sound/music.h::main::0::196"
.main_loop
	C_LINE	73,"sound/music.h::main::0::196"
             ld   iyl,0                        ; set channel = 0
	C_LINE	75,"sound/music.h::main::0::196"
.read_loop
	C_LINE	76,"sound/music.h::main::0::196"
             ld   hl,(pattern_addr)
	C_LINE	77,"sound/music.h::main::0::196"
             ld   a,(pattern_ptr)
	C_LINE	78,"sound/music.h::main::0::196"
             ld   e,a
	C_LINE	79,"sound/music.h::main::0::196"
             ld   d,0
	C_LINE	80,"sound/music.h::main::0::196"
             add  hl,de
	C_LINE	81,"sound/music.h::main::0::196"
             ld   e,(hl)
	C_LINE	82,"sound/music.h::main::0::196"
             inc  hl
	C_LINE	83,"sound/music.h::main::0::196"
             ld   d,(hl)                       ; now de = start of pattern data
	C_LINE	84,"sound/music.h::main::0::196"
             ld   hl,(note_ptr)
	C_LINE	85,"sound/music.h::main::0::196"
             inc  hl                           ; increment the note pointer and...
	C_LINE	86,"sound/music.h::main::0::196"
             ld   (note_ptr),hl                ; ..store it
	C_LINE	87,"sound/music.h::main::0::196"
             dec  hl
	C_LINE	88,"sound/music.h::main::0::196"
             add  hl,de                        ; now hl = address of note data
	C_LINE	89,"sound/music.h::main::0::196"
             ld   a,(hl)
	C_LINE	90,"sound/music.h::main::0::196"
             or   a
	C_LINE	91,"sound/music.h::main::0::196"
             jr   z,next_pattern               ; select next pattern
	C_LINE	93,"sound/music.h::main::0::196"
             bit  7,a
	C_LINE	94,"sound/music.h::main::0::196"
             jp   z,render                     ; play the currently defined note(s) and drum
	C_LINE	95,"sound/music.h::main::0::196"
             ld   iyh,a
	C_LINE	96,"sound/music.h::main::0::196"
             and  $3f
	C_LINE	97,"sound/music.h::main::0::196"
             cp   $3c
	C_LINE	98,"sound/music.h::main::0::196"
             jp   nc,other                     ; other parameters
	C_LINE	99,"sound/music.h::main::0::196"
             add  a,a
	C_LINE	100,"sound/music.h::main::0::196"
             ld   b,0
	C_LINE	101,"sound/music.h::main::0::196"
             ld   c,a
	C_LINE	102,"sound/music.h::main::0::196"
             ld   hl,freq_table
	C_LINE	103,"sound/music.h::main::0::196"
             add  hl,bc
	C_LINE	104,"sound/music.h::main::0::196"
             ld   e,(hl)
	C_LINE	105,"sound/music.h::main::0::196"
             inc  hl
	C_LINE	106,"sound/music.h::main::0::196"
             ld   d,(hl)
	C_LINE	107,"sound/music.h::main::0::196"
             ld   a,iyl                        ; iyl = 0 for channel 1, or = 1 for channel 2
	C_LINE	108,"sound/music.h::main::0::196"
             or   a
	C_LINE	109,"sound/music.h::main::0::196"
             jr   nz,set_note2
	C_LINE	110,"sound/music.h::main::0::196"
             ld   (div_1a),de
	C_LINE	111,"sound/music.h::main::0::196"
             ex   de,hl
	C_LINE	113,"sound/music.h::main::0::196"
             defb $dd,$21                      ; ld ix,nn
	C_LINE	114,"sound/music.h::main::0::196"
.current_inst
	C_LINE	115,"sound/music.h::main::0::196"
             defw $0000
	C_LINE	117,"sound/music.h::main::0::196"
             ld   a,(ix+$00)
	C_LINE	118,"sound/music.h::main::0::196"
             or   a
	C_LINE	119,"sound/music.h::main::0::196"
             jr   z,l809b                      ; original code jumps into byte 2 of the djnz (invalid opcode fd)
	C_LINE	120,"sound/music.h::main::0::196"
             ld   b,a
	C_LINE	121,"sound/music.h::main::0::196"
.l8098       add  hl,hl
	C_LINE	122,"sound/music.h::main::0::196"
             djnz l8098
	C_LINE	123,"sound/music.h::main::0::196"
.l809b       ld   e,(ix+$01)
	C_LINE	124,"sound/music.h::main::0::196"
             ld   d,(ix+$02)
	C_LINE	125,"sound/music.h::main::0::196"
             add  hl,de
	C_LINE	126,"sound/music.h::main::0::196"
             ld   (div_1b),hl
	C_LINE	127,"sound/music.h::main::0::196"
             ld   iyl,1                        ; set channel = 1
	C_LINE	128,"sound/music.h::main::0::196"
             ld   a,iyh
	C_LINE	129,"sound/music.h::main::0::196"
             and  $40
	C_LINE	130,"sound/music.h::main::0::196"
             jr   z,read_loop                  ; no phase reset
	C_LINE	132,"sound/music.h::main::0::196"
             ld   hl,out_1                     ; reset phaser
	C_LINE	133,"sound/music.h::main::0::196"
             res  4,(hl)
	C_LINE	134,"sound/music.h::main::0::196"
             ld   hl,$0000
	C_LINE	135,"sound/music.h::main::0::196"
             ld   (cnt_1a),hl
	C_LINE	136,"sound/music.h::main::0::196"
             ld   h,(ix+$03)
	C_LINE	137,"sound/music.h::main::0::196"
             ld   (cnt_1b),hl
	C_LINE	138,"sound/music.h::main::0::196"
             jr   read_loop
	C_LINE	140,"sound/music.h::main::0::196"
.set_note2
	C_LINE	141,"sound/music.h::main::0::196"
             ld   (div_2),de
	C_LINE	142,"sound/music.h::main::0::196"
             ld   a,iyh
	C_LINE	143,"sound/music.h::main::0::196"
             ld   hl,out_2
	C_LINE	144,"sound/music.h::main::0::196"
             res  4,(hl)
	C_LINE	145,"sound/music.h::main::0::196"
             ld   hl,$0000
	C_LINE	146,"sound/music.h::main::0::196"
             ld   (cnt_2),hl
	C_LINE	147,"sound/music.h::main::0::196"
             jp   read_loop
	C_LINE	149,"sound/music.h::main::0::196"
.set_stop
	C_LINE	150,"sound/music.h::main::0::196"
             ld   hl,$0000
	C_LINE	151,"sound/music.h::main::0::196"
             ld   a,iyl
	C_LINE	152,"sound/music.h::main::0::196"
             or   a
	C_LINE	153,"sound/music.h::main::0::196"
             jr   nz,set_stop2
	C_LINE	154,"sound/music.h::main::0::196"
             ; stop channel 1 note
	C_LINE	155,"sound/music.h::main::0::196"
             ld   (div_1a),hl
	C_LINE	156,"sound/music.h::main::0::196"
             ld   (div_1b),hl
	C_LINE	157,"sound/music.h::main::0::196"
             ld   hl,out_1
	C_LINE	158,"sound/music.h::main::0::196"
             res  4,(hl)
	C_LINE	159,"sound/music.h::main::0::196"
             ld   iyl,1
	C_LINE	160,"sound/music.h::main::0::196"
             jp   read_loop
	C_LINE	161,"sound/music.h::main::0::196"
.set_stop2
	C_LINE	162,"sound/music.h::main::0::196"
             ; stop channel 2 note
	C_LINE	163,"sound/music.h::main::0::196"
             ld   (div_2),hl
	C_LINE	164,"sound/music.h::main::0::196"
             ld   hl,out_2
	C_LINE	165,"sound/music.h::main::0::196"
             res  4,(hl)
	C_LINE	166,"sound/music.h::main::0::196"
             jp   read_loop
	C_LINE	168,"sound/music.h::main::0::196"
.other       cp   $3c
	C_LINE	169,"sound/music.h::main::0::196"
             jr   z,set_stop                   ; stop note
	C_LINE	170,"sound/music.h::main::0::196"
             cp   $3e
	C_LINE	171,"sound/music.h::main::0::196"
             jr   z,skip_ch1                   ; no changes to channel 1
	C_LINE	172,"sound/music.h::main::0::196"
             inc  hl                           ; instrument change
	C_LINE	173,"sound/music.h::main::0::196"
             ld   l,(hl)
	C_LINE	174,"sound/music.h::main::0::196"
             ld   h,$00
	C_LINE	175,"sound/music.h::main::0::196"
             add  hl,hl
	C_LINE	176,"sound/music.h::main::0::196"
             ld   de,(note_ptr)
	C_LINE	177,"sound/music.h::main::0::196"
             inc  de
	C_LINE	178,"sound/music.h::main::0::196"
             ld   (note_ptr),de                ; increment the note pointer
	C_LINE	180,"sound/music.h::main::0::196"
             defb $01                          ; ld bc,nn
	C_LINE	181,"sound/music.h::main::0::196"
.instrum_tbl
	C_LINE	182,"sound/music.h::main::0::196"
             defw $0000
	C_LINE	184,"sound/music.h::main::0::196"
             add  hl,bc
	C_LINE	185,"sound/music.h::main::0::196"
             ld   (current_inst),hl
	C_LINE	186,"sound/music.h::main::0::196"
             jp   read_loop
	C_LINE	188,"sound/music.h::main::0::196"
.skip_ch1
	C_LINE	189,"sound/music.h::main::0::196"
             ld   iyl,$01
	C_LINE	190,"sound/music.h::main::0::196"
             jp   read_loop
	C_LINE	192,"sound/music.h::main::0::196"
.exit_player
	C_LINE	193,"sound/music.h::main::0::196"
             ld   hl,$2758
	C_LINE	194,"sound/music.h::main::0::196"
             exx
	C_LINE	195,"sound/music.h::main::0::196"
             pop  iy
	C_LINE	197,"sound/music.h::main::0::196"
             ret
	C_LINE	199,"sound/music.h::main::0::196"
.render
	C_LINE	200,"sound/music.h::main::0::196"
             and  $7f                          ; l813a
	C_LINE	201,"sound/music.h::main::0::196"
             cp   $76
	C_LINE	202,"sound/music.h::main::0::196"
             jp   nc,drums
	C_LINE	203,"sound/music.h::main::0::196"
             ld   d,a
	C_LINE	204,"sound/music.h::main::0::196"
             exx
	C_LINE	205,"sound/music.h::main::0::196"
             defb $21                          ; ld hl,nn
	C_LINE	206,"sound/music.h::main::0::196"
.cnt_1a      defw $0000
	C_LINE	207,"sound/music.h::main::0::196"
             defb $dd,$21                      ; ld ix,nn
	C_LINE	208,"sound/music.h::main::0::196"
.cnt_1b      defw $0000
	C_LINE	209,"sound/music.h::main::0::196"
             defb $01                          ; ld bc,nn
	C_LINE	210,"sound/music.h::main::0::196"
.div_1a      defw $0000
	C_LINE	211,"sound/music.h::main::0::196"
             defb $11                          ; ld de,nn
	C_LINE	212,"sound/music.h::main::0::196"
.div_1b      defw $0000
	C_LINE	213,"sound/music.h::main::0::196"
             defb $3e                          ; ld a,n
	C_LINE	214,"sound/music.h::main::0::196"
.out_1       defb $0
	C_LINE	215,"sound/music.h::main::0::196"
             exx
	C_LINE	216,"sound/music.h::main::0::196"
             ex   af,af ; beware!
	C_LINE	217,"sound/music.h::main::0::196"
             defb $21                          ; ld hl,nn
	C_LINE	218,"sound/music.h::main::0::196"
.cnt_2       defw $0000
	C_LINE	219,"sound/music.h::main::0::196"
             defb $01                          ; ld bc,nn
	C_LINE	220,"sound/music.h::main::0::196"
.div_2       defw $0000
	C_LINE	221,"sound/music.h::main::0::196"
             defb $3e                          ; ld a,n
	C_LINE	222,"sound/music.h::main::0::196"
.out_2       defb $00
	C_LINE	224,"sound/music.h::main::0::196"
.play_note
	C_LINE	225,"sound/music.h::main::0::196"
             ; read keyboard
	C_LINE	226,"sound/music.h::main::0::196"
             ld   e,a
	C_LINE	227,"sound/music.h::main::0::196"
             xor  a
	C_LINE	228,"sound/music.h::main::0::196"
             in   a,($fe)
	C_LINE	229,"sound/music.h::main::0::196"
             or   $e0
	C_LINE	230,"sound/music.h::main::0::196"
             inc  a
	C_LINE	232,"sound/music.h::main::0::196"
.player_wait_key
	C_LINE	233,"sound/music.h::main::0::196"
             jr   nz,exit_player
	C_LINE	234,"sound/music.h::main::0::196"
             ld   a,e
	C_LINE	235,"sound/music.h::main::0::196"
             ld   e,0
	C_LINE	237,"sound/music.h::main::0::196"
.l8168       exx
	C_LINE	238,"sound/music.h::main::0::196"
             ex   af,af ; beware!
	C_LINE	239,"sound/music.h::main::0::196"
             add  hl,bc
	C_LINE	240,"sound/music.h::main::0::196"
             out  ($fe),a
	C_LINE	241,"sound/music.h::main::0::196"
             jr   c,l8171
	C_LINE	242,"sound/music.h::main::0::196"
             jr   l8173
	C_LINE	243,"sound/music.h::main::0::196"
.l8171       xor  $10
	C_LINE	244,"sound/music.h::main::0::196"
.l8173       add  ix,de
	C_LINE	245,"sound/music.h::main::0::196"
             jr   c,l8179
	C_LINE	246,"sound/music.h::main::0::196"
             jr   l817b
	C_LINE	247,"sound/music.h::main::0::196"
.l8179       xor  $10
	C_LINE	248,"sound/music.h::main::0::196"
.l817b       ex   af,af ; beware!
	C_LINE	249,"sound/music.h::main::0::196"
             out  ($fe),a
	C_LINE	250,"sound/music.h::main::0::196"
             exx
	C_LINE	251,"sound/music.h::main::0::196"
             add  hl,bc
	C_LINE	252,"sound/music.h::main::0::196"
             jr   c,l8184
	C_LINE	253,"sound/music.h::main::0::196"
             jr   l8186
	C_LINE	254,"sound/music.h::main::0::196"
.l8184       xor  $10
	C_LINE	255,"sound/music.h::main::0::196"
.l8186       nop
	C_LINE	256,"sound/music.h::main::0::196"
             jp   l818a
	C_LINE	258,"sound/music.h::main::0::196"
.l818a       exx
	C_LINE	259,"sound/music.h::main::0::196"
             ex   af,af ; beware!
	C_LINE	260,"sound/music.h::main::0::196"
             add  hl,bc
	C_LINE	261,"sound/music.h::main::0::196"
             out  ($fe),a
	C_LINE	262,"sound/music.h::main::0::196"
             jr   c,l8193
	C_LINE	263,"sound/music.h::main::0::196"
             jr   l8195
	C_LINE	264,"sound/music.h::main::0::196"
.l8193       xor  $10
	C_LINE	265,"sound/music.h::main::0::196"
.l8195       add  ix,de
	C_LINE	266,"sound/music.h::main::0::196"
             jr   c,l819b
	C_LINE	267,"sound/music.h::main::0::196"
             jr   l819d
	C_LINE	268,"sound/music.h::main::0::196"
.l819b       xor  $10
	C_LINE	269,"sound/music.h::main::0::196"
.l819d       ex   af,af ; beware!
	C_LINE	270,"sound/music.h::main::0::196"
             out  ($fe),a
	C_LINE	271,"sound/music.h::main::0::196"
             exx
	C_LINE	272,"sound/music.h::main::0::196"
             add  hl,bc
	C_LINE	273,"sound/music.h::main::0::196"
             jr   c,l81a6
	C_LINE	274,"sound/music.h::main::0::196"
             jr   l81a8
	C_LINE	275,"sound/music.h::main::0::196"
.l81a6       xor  $10
	C_LINE	276,"sound/music.h::main::0::196"
.l81a8       nop
	C_LINE	277,"sound/music.h::main::0::196"
             jp   l81ac
	C_LINE	279,"sound/music.h::main::0::196"
.l81ac       exx
	C_LINE	280,"sound/music.h::main::0::196"
             ex   af,af ; beware!
	C_LINE	281,"sound/music.h::main::0::196"
             add  hl,bc
	C_LINE	282,"sound/music.h::main::0::196"
             out  ($fe),a
	C_LINE	283,"sound/music.h::main::0::196"
             jr   c,l81b5
	C_LINE	284,"sound/music.h::main::0::196"
             jr   l81b7
	C_LINE	285,"sound/music.h::main::0::196"
.l81b5       xor  $10
	C_LINE	286,"sound/music.h::main::0::196"
.l81b7       add  ix,de
	C_LINE	287,"sound/music.h::main::0::196"
             jr   c,l81bd
	C_LINE	288,"sound/music.h::main::0::196"
             jr   l81bf
	C_LINE	289,"sound/music.h::main::0::196"
.l81bd       xor  $10
	C_LINE	290,"sound/music.h::main::0::196"
.l81bf       ex   af,af ; beware!
	C_LINE	291,"sound/music.h::main::0::196"
             out  ($fe),a
	C_LINE	292,"sound/music.h::main::0::196"
             exx
	C_LINE	293,"sound/music.h::main::0::196"
             add  hl,bc
	C_LINE	294,"sound/music.h::main::0::196"
             jr   c,l81c8
	C_LINE	295,"sound/music.h::main::0::196"
             jr   l81ca
	C_LINE	296,"sound/music.h::main::0::196"
.l81c8       xor  $10
	C_LINE	297,"sound/music.h::main::0::196"
.l81ca       nop
	C_LINE	298,"sound/music.h::main::0::196"
             jp   l81ce
	C_LINE	300,"sound/music.h::main::0::196"
.l81ce       exx
	C_LINE	301,"sound/music.h::main::0::196"
             ex   af,af ; beware!
	C_LINE	302,"sound/music.h::main::0::196"
             add  hl,bc
	C_LINE	303,"sound/music.h::main::0::196"
             out  ($fe),a
	C_LINE	304,"sound/music.h::main::0::196"
             jr   c,l81d7
	C_LINE	305,"sound/music.h::main::0::196"
             jr   l81d9
	C_LINE	306,"sound/music.h::main::0::196"
.l81d7       xor  $10
	C_LINE	307,"sound/music.h::main::0::196"
.l81d9       add  ix,de
	C_LINE	308,"sound/music.h::main::0::196"
             jr   c,l81df
	C_LINE	309,"sound/music.h::main::0::196"
             jr   l81e1
	C_LINE	310,"sound/music.h::main::0::196"
.l81df       xor  $10
	C_LINE	311,"sound/music.h::main::0::196"
.l81e1       ex   af,af ; beware!
	C_LINE	312,"sound/music.h::main::0::196"
             out  ($fe),a
	C_LINE	313,"sound/music.h::main::0::196"
             exx
	C_LINE	314,"sound/music.h::main::0::196"
             add  hl,bc
	C_LINE	315,"sound/music.h::main::0::196"
             jr   c,l81ea
	C_LINE	316,"sound/music.h::main::0::196"
             jr   l81ec
	C_LINE	317,"sound/music.h::main::0::196"
.l81ea       xor  $10
	C_LINE	319,"sound/music.h::main::0::196"
.l81ec       dec  e
	C_LINE	320,"sound/music.h::main::0::196"
             jp   nz,l8168
	C_LINE	322,"sound/music.h::main::0::196"
             exx
	C_LINE	323,"sound/music.h::main::0::196"
             ex   af,af ; beware!
	C_LINE	324,"sound/music.h::main::0::196"
             add  hl,bc
	C_LINE	325,"sound/music.h::main::0::196"
             out  ($fe),a
	C_LINE	326,"sound/music.h::main::0::196"
             jr   c,l81f9
	C_LINE	327,"sound/music.h::main::0::196"
             jr   l81fb
	C_LINE	328,"sound/music.h::main::0::196"
.l81f9       xor  $10
	C_LINE	329,"sound/music.h::main::0::196"
.l81fb       add  ix,de
	C_LINE	330,"sound/music.h::main::0::196"
             jr   c,l8201
	C_LINE	331,"sound/music.h::main::0::196"
             jr   l8203
	C_LINE	332,"sound/music.h::main::0::196"
.l8201       xor  $10
	C_LINE	333,"sound/music.h::main::0::196"
.l8203       ex   af,af ; beware!
	C_LINE	334,"sound/music.h::main::0::196"
             out  ($fe),a
	C_LINE	335,"sound/music.h::main::0::196"
             exx
	C_LINE	336,"sound/music.h::main::0::196"
             add  hl,bc
	C_LINE	337,"sound/music.h::main::0::196"
             jr   c,l820c
	C_LINE	338,"sound/music.h::main::0::196"
             jr   l820e
	C_LINE	339,"sound/music.h::main::0::196"
.l820c       xor  $10
	C_LINE	341,"sound/music.h::main::0::196"
.l820e       dec  d
	C_LINE	342,"sound/music.h::main::0::196"
             jp   nz,play_note
	C_LINE	344,"sound/music.h::main::0::196"
             ld   (cnt_2),hl
	C_LINE	345,"sound/music.h::main::0::196"
             ld   (out_2),a
	C_LINE	346,"sound/music.h::main::0::196"
             exx
	C_LINE	347,"sound/music.h::main::0::196"
             ex   af,af ; beware!
	C_LINE	348,"sound/music.h::main::0::196"
             ld   (cnt_1a),hl
	C_LINE	349,"sound/music.h::main::0::196"
             ld   (cnt_1b),ix
	C_LINE	350,"sound/music.h::main::0::196"
             ld   (out_1),a
	C_LINE	351,"sound/music.h::main::0::196"
             jp   main_loop
	C_LINE	353,"sound/music.h::main::0::196"
; ************************************************************
	C_LINE	354,"sound/music.h::main::0::196"
; * drums - synthesised
	C_LINE	355,"sound/music.h::main::0::196"
; ************************************************************
	C_LINE	356,"sound/music.h::main::0::196"
.drums
	C_LINE	357,"sound/music.h::main::0::196"
             add  a,a                          ; on entry a=$75+drum number (i.e. $76 to $7e)
	C_LINE	358,"sound/music.h::main::0::196"
             ld   b,0
	C_LINE	359,"sound/music.h::main::0::196"
             ld   c,a
	C_LINE	360,"sound/music.h::main::0::196"
             ld   hl,drum_table - 236
	C_LINE	361,"sound/music.h::main::0::196"
             add  hl,bc
	C_LINE	362,"sound/music.h::main::0::196"
             ld   e,(hl)
	C_LINE	363,"sound/music.h::main::0::196"
             inc  hl
	C_LINE	364,"sound/music.h::main::0::196"
             ld   d,(hl)
	C_LINE	365,"sound/music.h::main::0::196"
             ex   de,hl
	C_LINE	366,"sound/music.h::main::0::196"
             jp   (hl)
	C_LINE	368,"sound/music.h::main::0::196"
.drum_tone1  ld   l,16
	C_LINE	369,"sound/music.h::main::0::196"
             jr   drum_tone
	C_LINE	370,"sound/music.h::main::0::196"
.drum_tone2  ld   l,12
	C_LINE	371,"sound/music.h::main::0::196"
             jr   drum_tone
	C_LINE	372,"sound/music.h::main::0::196"
.drum_tone3  ld   l,8
	C_LINE	373,"sound/music.h::main::0::196"
             jr   drum_tone
	C_LINE	374,"sound/music.h::main::0::196"
.drum_tone4  ld   l,6
	C_LINE	375,"sound/music.h::main::0::196"
             jr   drum_tone
	C_LINE	376,"sound/music.h::main::0::196"
.drum_tone5  ld   l,4
	C_LINE	377,"sound/music.h::main::0::196"
             jr   drum_tone
	C_LINE	378,"sound/music.h::main::0::196"
.drum_tone6  ld   l,2
	C_LINE	379,"sound/music.h::main::0::196"
.drum_tone
	C_LINE	380,"sound/music.h::main::0::196"
             ld   de,3700
	C_LINE	381,"sound/music.h::main::0::196"
             ld   bc,$0101
	C_LINE	382,"sound/music.h::main::0::196"
	C_LINE	383,"sound/music.h::main::0::196"
             xor a
	C_LINE	384,"sound/music.h::main::0::196"
.dt_loop0    out  ($fe),a
	C_LINE	385,"sound/music.h::main::0::196"
             dec  b
	C_LINE	386,"sound/music.h::main::0::196"
             jr   nz,dt_loop1
	C_LINE	387,"sound/music.h::main::0::196"
             xor  16
	C_LINE	388,"sound/music.h::main::0::196"
             ld   b,c
	C_LINE	389,"sound/music.h::main::0::196"
             ex   af,af ; beware!
	C_LINE	390,"sound/music.h::main::0::196"
             ld   a,c
	C_LINE	391,"sound/music.h::main::0::196"
             add  a,l
	C_LINE	392,"sound/music.h::main::0::196"
             ld   c,a
	C_LINE	393,"sound/music.h::main::0::196"
             ex   af,af ; beware!
	C_LINE	394,"sound/music.h::main::0::196"
.dt_loop1    dec  e
	C_LINE	395,"sound/music.h::main::0::196"
             jr   nz,dt_loop0
	C_LINE	396,"sound/music.h::main::0::196"
             dec  d
	C_LINE	397,"sound/music.h::main::0::196"
             jr   nz,dt_loop0
	C_LINE	398,"sound/music.h::main::0::196"
             jp   main_loop
	C_LINE	400,"sound/music.h::main::0::196"
.drum_noise1 ld   de,2480
	C_LINE	401,"sound/music.h::main::0::196"
             ld   ixl,1
	C_LINE	402,"sound/music.h::main::0::196"
             jr   drum_noise
	C_LINE	403,"sound/music.h::main::0::196"
.drum_noise2 ld   de,1070
	C_LINE	404,"sound/music.h::main::0::196"
             ld   ixl,10
	C_LINE	405,"sound/music.h::main::0::196"
             jr   drum_noise
	C_LINE	406,"sound/music.h::main::0::196"
.drum_noise3 ld   de,365
	C_LINE	407,"sound/music.h::main::0::196"
             ld   ixl,101
	C_LINE	408,"sound/music.h::main::0::196"
.drum_noise
	C_LINE	409,"sound/music.h::main::0::196"
             ld   h,d
	C_LINE	410,"sound/music.h::main::0::196"
             ld   l,e
	C_LINE	411,"sound/music.h::main::0::196"
	C_LINE	412,"sound/music.h::main::0::196"
             xor a
	C_LINE	413,"sound/music.h::main::0::196"
             ld   c,a
	C_LINE	414,"sound/music.h::main::0::196"
.dn_loop0    ld   a,(hl)
	C_LINE	415,"sound/music.h::main::0::196"
             and  16
	C_LINE	416,"sound/music.h::main::0::196"
             or   c
	C_LINE	417,"sound/music.h::main::0::196"
             out  ($fe),a
	C_LINE	418,"sound/music.h::main::0::196"
             ld   b,ixl
	C_LINE	419,"sound/music.h::main::0::196"
.dn_loop1    djnz dn_loop1
	C_LINE	420,"sound/music.h::main::0::196"
             inc  hl
	C_LINE	421,"sound/music.h::main::0::196"
             dec  e
	C_LINE	422,"sound/music.h::main::0::196"
             jr   nz,dn_loop0
	C_LINE	423,"sound/music.h::main::0::196"
             dec  d
	C_LINE	424,"sound/music.h::main::0::196"
             jr   nz,dn_loop0
	C_LINE	425,"sound/music.h::main::0::196"
             jp   main_loop
	C_LINE	427,"sound/music.h::main::0::196"
.pattern_addr   defw  $0000
	C_LINE	428,"sound/music.h::main::0::196"
.pattern_ptr    defb  0
	C_LINE	429,"sound/music.h::main::0::196"
.note_ptr       defw  $0000
	C_LINE	431,"sound/music.h::main::0::196"
; **************************************************************
	C_LINE	432,"sound/music.h::main::0::196"
; * frequency table
	C_LINE	433,"sound/music.h::main::0::196"
; **************************************************************
	C_LINE	434,"sound/music.h::main::0::196"
.freq_table
	C_LINE	435,"sound/music.h::main::0::196"
             defw 178,189,200,212,225,238,252,267,283,300,318,337
	C_LINE	436,"sound/music.h::main::0::196"
             defw 357,378,401,425,450,477,505,535,567,601,637,675
	C_LINE	437,"sound/music.h::main::0::196"
             defw 715,757,802,850,901,954,1011,1071,1135,1202,1274,1350
	C_LINE	438,"sound/music.h::main::0::196"
             defw 1430,1515,1605,1701,1802,1909,2023,2143,2270,2405,2548,2700
	C_LINE	439,"sound/music.h::main::0::196"
             defw 2860,3030,3211,3402,3604,3818,4046,4286,4541,4811,5097,5400
	C_LINE	441,"sound/music.h::main::0::196"
; *****************************************************************
	C_LINE	442,"sound/music.h::main::0::196"
; * synth drum lookup table
	C_LINE	443,"sound/music.h::main::0::196"
; *****************************************************************
	C_LINE	444,"sound/music.h::main::0::196"
.drum_table
	C_LINE	445,"sound/music.h::main::0::196"
             defw drum_tone1,drum_tone2,drum_tone3,drum_tone4,drum_tone5,drum_tone6
	C_LINE	446,"sound/music.h::main::0::196"
             defw drum_noise1,drum_noise2,drum_noise3
	C_LINE	449,"sound/music.h::main::0::196"
.musicdata
	C_LINE	450,"sound/music.h::main::0::196"
             defb 0  ; pattern loop begin * 2
	C_LINE	451,"sound/music.h::main::0::196"
             defb 8  ; song length * 2
	C_LINE	452,"sound/music.h::main::0::196"
             defw 12         ; offset to start of song (length of instrument table)
	C_LINE	453,"sound/music.h::main::0::196"
             defb 1      ; multiple
	C_LINE	454,"sound/music.h::main::0::196"
             defw 5      ; detune
	C_LINE	455,"sound/music.h::main::0::196"
             defb 1      ; phase
	C_LINE	456,"sound/music.h::main::0::196"
             defb 0      ; multiple
	C_LINE	457,"sound/music.h::main::0::196"
             defw 20      ; detune
	C_LINE	458,"sound/music.h::main::0::196"
             defb 0      ; phase
	C_LINE	459,"sound/music.h::main::0::196"
             defb 1      ; multiple
	C_LINE	460,"sound/music.h::main::0::196"
             defw 15      ; detune
	C_LINE	461,"sound/music.h::main::0::196"
             defb 0      ; phase
	C_LINE	463,"sound/music.h::main::0::196"
.patterndata        defw      pat0
	C_LINE	464,"sound/music.h::main::0::196"
                    defw      pat0
	C_LINE	465,"sound/music.h::main::0::196"
                    defw      pat1
	C_LINE	466,"sound/music.h::main::0::196"
                    defw      pat1
	C_LINE	468,"sound/music.h::main::0::196"
; *** pattern data - $00 marks the end of a pattern ***
	C_LINE	469,"sound/music.h::main::0::196"
.pat0
	C_LINE	470,"sound/music.h::main::0::196"
         defb $bd,0
	C_LINE	471,"sound/music.h::main::0::196"
         defb 171
	C_LINE	472,"sound/music.h::main::0::196"
         defb 152
	C_LINE	473,"sound/music.h::main::0::196"
         defb 126
	C_LINE	474,"sound/music.h::main::0::196"
     defb 3
	C_LINE	475,"sound/music.h::main::0::196"
         defb 188
	C_LINE	476,"sound/music.h::main::0::196"
         defb 188
	C_LINE	477,"sound/music.h::main::0::196"
     defb 4
	C_LINE	478,"sound/music.h::main::0::196"
         defb 171
	C_LINE	479,"sound/music.h::main::0::196"
         defb 126
	C_LINE	480,"sound/music.h::main::0::196"
     defb 3
	C_LINE	481,"sound/music.h::main::0::196"
         defb 168
	C_LINE	482,"sound/music.h::main::0::196"
         defb 152
	C_LINE	483,"sound/music.h::main::0::196"
         defb 125
	C_LINE	484,"sound/music.h::main::0::196"
     defb 3
	C_LINE	485,"sound/music.h::main::0::196"
         defb 188
	C_LINE	486,"sound/music.h::main::0::196"
         defb 188
	C_LINE	487,"sound/music.h::main::0::196"
     defb 4
	C_LINE	488,"sound/music.h::main::0::196"
         defb 190
	C_LINE	489,"sound/music.h::main::0::196"
         defb 126
	C_LINE	490,"sound/music.h::main::0::196"
     defb 3
	C_LINE	491,"sound/music.h::main::0::196"
         defb 171
	C_LINE	492,"sound/music.h::main::0::196"
         defb 152
	C_LINE	493,"sound/music.h::main::0::196"
         defb 126
	C_LINE	494,"sound/music.h::main::0::196"
     defb 3
	C_LINE	495,"sound/music.h::main::0::196"
         defb 171
	C_LINE	496,"sound/music.h::main::0::196"
         defb 188
	C_LINE	497,"sound/music.h::main::0::196"
         defb 126
	C_LINE	498,"sound/music.h::main::0::196"
     defb 3
	C_LINE	499,"sound/music.h::main::0::196"
         defb 190
	C_LINE	500,"sound/music.h::main::0::196"
         defb 126
	C_LINE	501,"sound/music.h::main::0::196"
     defb 3
	C_LINE	502,"sound/music.h::main::0::196"
         defb 168
	C_LINE	503,"sound/music.h::main::0::196"
         defb 159
	C_LINE	504,"sound/music.h::main::0::196"
         defb 125
	C_LINE	505,"sound/music.h::main::0::196"
     defb 3
	C_LINE	506,"sound/music.h::main::0::196"
         defb 188
	C_LINE	507,"sound/music.h::main::0::196"
         defb 157
	C_LINE	508,"sound/music.h::main::0::196"
     defb 4
	C_LINE	509,"sound/music.h::main::0::196"
         defb 190
	C_LINE	510,"sound/music.h::main::0::196"
         defb 156
	C_LINE	511,"sound/music.h::main::0::196"
         defb 126
	C_LINE	512,"sound/music.h::main::0::196"
     defb 3
	C_LINE	513,"sound/music.h::main::0::196"
         defb 171
	C_LINE	514,"sound/music.h::main::0::196"
         defb 152
	C_LINE	515,"sound/music.h::main::0::196"
         defb 126
	C_LINE	516,"sound/music.h::main::0::196"
     defb 3
	C_LINE	517,"sound/music.h::main::0::196"
         defb 188
	C_LINE	518,"sound/music.h::main::0::196"
         defb 188
	C_LINE	519,"sound/music.h::main::0::196"
     defb 4
	C_LINE	520,"sound/music.h::main::0::196"
         defb 171
	C_LINE	521,"sound/music.h::main::0::196"
         defb 126
	C_LINE	522,"sound/music.h::main::0::196"
     defb 3
	C_LINE	523,"sound/music.h::main::0::196"
         defb 168
	C_LINE	524,"sound/music.h::main::0::196"
         defb 152
	C_LINE	525,"sound/music.h::main::0::196"
         defb 125
	C_LINE	526,"sound/music.h::main::0::196"
     defb 3
	C_LINE	527,"sound/music.h::main::0::196"
         defb 188
	C_LINE	528,"sound/music.h::main::0::196"
         defb 188
	C_LINE	529,"sound/music.h::main::0::196"
     defb 4
	C_LINE	530,"sound/music.h::main::0::196"
         defb 168
	C_LINE	531,"sound/music.h::main::0::196"
         defb 124
	C_LINE	532,"sound/music.h::main::0::196"
     defb 3
	C_LINE	533,"sound/music.h::main::0::196"
         defb 166
	C_LINE	534,"sound/music.h::main::0::196"
         defb 152
	C_LINE	535,"sound/music.h::main::0::196"
         defb 125
	C_LINE	536,"sound/music.h::main::0::196"
     defb 3
	C_LINE	537,"sound/music.h::main::0::196"
         defb 166
	C_LINE	538,"sound/music.h::main::0::196"
         defb 188
	C_LINE	539,"sound/music.h::main::0::196"
         defb 124
	C_LINE	540,"sound/music.h::main::0::196"
     defb 3
	C_LINE	541,"sound/music.h::main::0::196"
         defb 190
	C_LINE	542,"sound/music.h::main::0::196"
         defb 126
	C_LINE	543,"sound/music.h::main::0::196"
     defb 3
	C_LINE	544,"sound/music.h::main::0::196"
         defb 168
	C_LINE	545,"sound/music.h::main::0::196"
         defb 159
	C_LINE	546,"sound/music.h::main::0::196"
         defb 124
	C_LINE	547,"sound/music.h::main::0::196"
     defb 3
	C_LINE	548,"sound/music.h::main::0::196"
         defb 188
	C_LINE	549,"sound/music.h::main::0::196"
         defb 157
	C_LINE	550,"sound/music.h::main::0::196"
         defb 121
	C_LINE	551,"sound/music.h::main::0::196"
     defb 3
	C_LINE	552,"sound/music.h::main::0::196"
         defb 190
	C_LINE	553,"sound/music.h::main::0::196"
         defb 156
	C_LINE	554,"sound/music.h::main::0::196"
         defb 122
	C_LINE	555,"sound/music.h::main::0::196"
     defb 3
	C_LINE	556,"sound/music.h::main::0::196"
         defb 168
	C_LINE	557,"sound/music.h::main::0::196"
         defb 154
	C_LINE	558,"sound/music.h::main::0::196"
         defb 123
	C_LINE	559,"sound/music.h::main::0::196"
     defb 3
	C_LINE	560,"sound/music.h::main::0::196"
         defb 169
	C_LINE	561,"sound/music.h::main::0::196"
         defb 188
	C_LINE	562,"sound/music.h::main::0::196"
     defb 4
	C_LINE	563,"sound/music.h::main::0::196"
         defb 171
	C_LINE	564,"sound/music.h::main::0::196"
         defb 126
	C_LINE	565,"sound/music.h::main::0::196"
     defb 3
	C_LINE	566,"sound/music.h::main::0::196"
         defb 169
	C_LINE	567,"sound/music.h::main::0::196"
         defb 154
	C_LINE	568,"sound/music.h::main::0::196"
         defb 125
	C_LINE	569,"sound/music.h::main::0::196"
     defb 3
	C_LINE	570,"sound/music.h::main::0::196"
         defb 188
	C_LINE	571,"sound/music.h::main::0::196"
         defb 188
	C_LINE	572,"sound/music.h::main::0::196"
     defb 4
	C_LINE	573,"sound/music.h::main::0::196"
         defb 190
	C_LINE	574,"sound/music.h::main::0::196"
         defb 126
	C_LINE	575,"sound/music.h::main::0::196"
     defb 3
	C_LINE	576,"sound/music.h::main::0::196"
         defb 190
	C_LINE	577,"sound/music.h::main::0::196"
         defb 154
	C_LINE	578,"sound/music.h::main::0::196"
         defb 126
	C_LINE	579,"sound/music.h::main::0::196"
     defb 3
	C_LINE	580,"sound/music.h::main::0::196"
         defb 190
	C_LINE	581,"sound/music.h::main::0::196"
         defb 188
	C_LINE	582,"sound/music.h::main::0::196"
         defb 126
	C_LINE	583,"sound/music.h::main::0::196"
     defb 3
	C_LINE	584,"sound/music.h::main::0::196"
         defb 190
	C_LINE	585,"sound/music.h::main::0::196"
         defb 126
	C_LINE	586,"sound/music.h::main::0::196"
     defb 3
	C_LINE	587,"sound/music.h::main::0::196"
         defb 190
	C_LINE	588,"sound/music.h::main::0::196"
         defb 159
	C_LINE	589,"sound/music.h::main::0::196"
         defb 125
	C_LINE	590,"sound/music.h::main::0::196"
     defb 3
	C_LINE	591,"sound/music.h::main::0::196"
         defb 190
	C_LINE	592,"sound/music.h::main::0::196"
         defb 157
	C_LINE	593,"sound/music.h::main::0::196"
     defb 4
	C_LINE	594,"sound/music.h::main::0::196"
         defb 190
	C_LINE	595,"sound/music.h::main::0::196"
         defb 156
	C_LINE	596,"sound/music.h::main::0::196"
         defb 126
	C_LINE	597,"sound/music.h::main::0::196"
     defb 3
	C_LINE	598,"sound/music.h::main::0::196"
         defb $bd,4
	C_LINE	599,"sound/music.h::main::0::196"
         defb 164
	C_LINE	600,"sound/music.h::main::0::196"
         defb 157
	C_LINE	601,"sound/music.h::main::0::196"
         defb 126
	C_LINE	602,"sound/music.h::main::0::196"
     defb 3
	C_LINE	603,"sound/music.h::main::0::196"
         defb 188
	C_LINE	604,"sound/music.h::main::0::196"
         defb 188
	C_LINE	605,"sound/music.h::main::0::196"
     defb 4
	C_LINE	606,"sound/music.h::main::0::196"
         defb 164
	C_LINE	607,"sound/music.h::main::0::196"
         defb 126
	C_LINE	608,"sound/music.h::main::0::196"
     defb 3
	C_LINE	609,"sound/music.h::main::0::196"
         defb 188
	C_LINE	610,"sound/music.h::main::0::196"
         defb 157
	C_LINE	611,"sound/music.h::main::0::196"
         defb 125
	C_LINE	612,"sound/music.h::main::0::196"
     defb 3
	C_LINE	613,"sound/music.h::main::0::196"
         defb 159
	C_LINE	614,"sound/music.h::main::0::196"
         defb 188
	C_LINE	615,"sound/music.h::main::0::196"
         defb 126
	C_LINE	616,"sound/music.h::main::0::196"
     defb 3
	C_LINE	617,"sound/music.h::main::0::196"
         defb 161
	C_LINE	618,"sound/music.h::main::0::196"
         defb 125
	C_LINE	619,"sound/music.h::main::0::196"
     defb 3
	C_LINE	620,"sound/music.h::main::0::196"
         defb 164
	C_LINE	621,"sound/music.h::main::0::196"
         defb 157
	C_LINE	622,"sound/music.h::main::0::196"
         defb 126
	C_LINE	623,"sound/music.h::main::0::196"
     defb 3
	C_LINE	624,"sound/music.h::main::0::196"
         defb 188
	C_LINE	625,"sound/music.h::main::0::196"
         defb 188
	C_LINE	626,"sound/music.h::main::0::196"
     defb 4
	C_LINE	627,"sound/music.h::main::0::196"
         defb 166
	C_LINE	628,"sound/music.h::main::0::196"
         defb 126
	C_LINE	629,"sound/music.h::main::0::196"
     defb 3
	C_LINE	630,"sound/music.h::main::0::196"
         defb 188
	C_LINE	631,"sound/music.h::main::0::196"
         defb 159
	C_LINE	632,"sound/music.h::main::0::196"
         defb 126
	C_LINE	633,"sound/music.h::main::0::196"
     defb 3
	C_LINE	634,"sound/music.h::main::0::196"
         defb 164
	C_LINE	635,"sound/music.h::main::0::196"
         defb 157
	C_LINE	636,"sound/music.h::main::0::196"
         defb 126
	C_LINE	637,"sound/music.h::main::0::196"
     defb 3
	C_LINE	638,"sound/music.h::main::0::196"
         defb 190
	C_LINE	639,"sound/music.h::main::0::196"
         defb 156
	C_LINE	640,"sound/music.h::main::0::196"
         defb 125
	C_LINE	641,"sound/music.h::main::0::196"
     defb 3
	C_LINE	642,"sound/music.h::main::0::196"
         defb $00
	C_LINE	643,"sound/music.h::main::0::196"
.pat1
	C_LINE	644,"sound/music.h::main::0::196"
         defb $bd,2
	C_LINE	645,"sound/music.h::main::0::196"
         defb 159
	C_LINE	646,"sound/music.h::main::0::196"
         defb 152
	C_LINE	647,"sound/music.h::main::0::196"
         defb 126
	C_LINE	648,"sound/music.h::main::0::196"
     defb 3
	C_LINE	649,"sound/music.h::main::0::196"
         defb 161
	C_LINE	650,"sound/music.h::main::0::196"
         defb 152
	C_LINE	651,"sound/music.h::main::0::196"
         defb 124
	C_LINE	652,"sound/music.h::main::0::196"
     defb 3
	C_LINE	653,"sound/music.h::main::0::196"
         defb 159
	C_LINE	654,"sound/music.h::main::0::196"
         defb 152
	C_LINE	655,"sound/music.h::main::0::196"
         defb 126
	C_LINE	656,"sound/music.h::main::0::196"
     defb 3
	C_LINE	657,"sound/music.h::main::0::196"
         defb 164
	C_LINE	658,"sound/music.h::main::0::196"
         defb 152
	C_LINE	659,"sound/music.h::main::0::196"
         defb 125
	C_LINE	660,"sound/music.h::main::0::196"
     defb 3
	C_LINE	661,"sound/music.h::main::0::196"
         defb 166
	C_LINE	662,"sound/music.h::main::0::196"
         defb 152
	C_LINE	663,"sound/music.h::main::0::196"
     defb 4
	C_LINE	664,"sound/music.h::main::0::196"
         defb 171
	C_LINE	665,"sound/music.h::main::0::196"
         defb 152
	C_LINE	666,"sound/music.h::main::0::196"
         defb 126
	C_LINE	667,"sound/music.h::main::0::196"
     defb 3
	C_LINE	668,"sound/music.h::main::0::196"
         defb 169
	C_LINE	669,"sound/music.h::main::0::196"
         defb 152
	C_LINE	670,"sound/music.h::main::0::196"
         defb 126
	C_LINE	671,"sound/music.h::main::0::196"
     defb 3
	C_LINE	672,"sound/music.h::main::0::196"
         defb 168
	C_LINE	673,"sound/music.h::main::0::196"
         defb 152
	C_LINE	674,"sound/music.h::main::0::196"
         defb 126
	C_LINE	675,"sound/music.h::main::0::196"
     defb 3
	C_LINE	676,"sound/music.h::main::0::196"
         defb 164
	C_LINE	677,"sound/music.h::main::0::196"
         defb 152
	C_LINE	678,"sound/music.h::main::0::196"
         defb 126
	C_LINE	679,"sound/music.h::main::0::196"
     defb 3
	C_LINE	680,"sound/music.h::main::0::196"
         defb 166
	C_LINE	681,"sound/music.h::main::0::196"
         defb 152
	C_LINE	682,"sound/music.h::main::0::196"
         defb 125
	C_LINE	683,"sound/music.h::main::0::196"
     defb 3
	C_LINE	684,"sound/music.h::main::0::196"
         defb 190
	C_LINE	685,"sound/music.h::main::0::196"
         defb 152
	C_LINE	686,"sound/music.h::main::0::196"
     defb 4
	C_LINE	687,"sound/music.h::main::0::196"
         defb 168
	C_LINE	688,"sound/music.h::main::0::196"
         defb 152
	C_LINE	689,"sound/music.h::main::0::196"
         defb 126
	C_LINE	690,"sound/music.h::main::0::196"
     defb 3
	C_LINE	691,"sound/music.h::main::0::196"
         defb $bd,0
	C_LINE	692,"sound/music.h::main::0::196"
         defb 159
	C_LINE	693,"sound/music.h::main::0::196"
         defb 154
	C_LINE	694,"sound/music.h::main::0::196"
         defb 126
	C_LINE	695,"sound/music.h::main::0::196"
     defb 3
	C_LINE	696,"sound/music.h::main::0::196"
         defb 161
	C_LINE	697,"sound/music.h::main::0::196"
         defb 154
	C_LINE	698,"sound/music.h::main::0::196"
     defb 4
	C_LINE	699,"sound/music.h::main::0::196"
         defb 159
	C_LINE	700,"sound/music.h::main::0::196"
         defb 154
	C_LINE	701,"sound/music.h::main::0::196"
         defb 126
	C_LINE	702,"sound/music.h::main::0::196"
     defb 3
	C_LINE	703,"sound/music.h::main::0::196"
         defb 164
	C_LINE	704,"sound/music.h::main::0::196"
         defb 154
	C_LINE	705,"sound/music.h::main::0::196"
         defb 125
	C_LINE	706,"sound/music.h::main::0::196"
     defb 3
	C_LINE	707,"sound/music.h::main::0::196"
         defb 166
	C_LINE	708,"sound/music.h::main::0::196"
         defb 154
	C_LINE	709,"sound/music.h::main::0::196"
     defb 4
	C_LINE	710,"sound/music.h::main::0::196"
         defb 171
	C_LINE	711,"sound/music.h::main::0::196"
         defb 154
	C_LINE	712,"sound/music.h::main::0::196"
         defb 124
	C_LINE	713,"sound/music.h::main::0::196"
     defb 3
	C_LINE	714,"sound/music.h::main::0::196"
         defb 169
	C_LINE	715,"sound/music.h::main::0::196"
         defb 154
	C_LINE	716,"sound/music.h::main::0::196"
         defb 125
	C_LINE	717,"sound/music.h::main::0::196"
     defb 3
	C_LINE	718,"sound/music.h::main::0::196"
         defb 168
	C_LINE	719,"sound/music.h::main::0::196"
         defb 154
	C_LINE	720,"sound/music.h::main::0::196"
         defb 124
	C_LINE	721,"sound/music.h::main::0::196"
     defb 3
	C_LINE	722,"sound/music.h::main::0::196"
         defb 164
	C_LINE	723,"sound/music.h::main::0::196"
         defb 154
	C_LINE	724,"sound/music.h::main::0::196"
         defb 126
	C_LINE	725,"sound/music.h::main::0::196"
     defb 3
	C_LINE	726,"sound/music.h::main::0::196"
         defb 166
	C_LINE	727,"sound/music.h::main::0::196"
         defb 154
	C_LINE	728,"sound/music.h::main::0::196"
         defb 124
	C_LINE	729,"sound/music.h::main::0::196"
     defb 3
	C_LINE	730,"sound/music.h::main::0::196"
         defb 190
	C_LINE	731,"sound/music.h::main::0::196"
         defb 154
	C_LINE	732,"sound/music.h::main::0::196"
         defb 121
	C_LINE	733,"sound/music.h::main::0::196"
     defb 3
	C_LINE	734,"sound/music.h::main::0::196"
         defb 164
	C_LINE	735,"sound/music.h::main::0::196"
         defb 154
	C_LINE	736,"sound/music.h::main::0::196"
         defb 122
	C_LINE	737,"sound/music.h::main::0::196"
     defb 3
	C_LINE	738,"sound/music.h::main::0::196"
         defb 190
	C_LINE	739,"sound/music.h::main::0::196"
         defb 157
	C_LINE	740,"sound/music.h::main::0::196"
         defb 123
	C_LINE	741,"sound/music.h::main::0::196"
     defb 3
	C_LINE	742,"sound/music.h::main::0::196"
         defb 190
	C_LINE	743,"sound/music.h::main::0::196"
         defb 157
	C_LINE	744,"sound/music.h::main::0::196"
     defb 4
	C_LINE	745,"sound/music.h::main::0::196"
         defb 190
	C_LINE	746,"sound/music.h::main::0::196"
         defb 157
	C_LINE	747,"sound/music.h::main::0::196"
         defb 126
	C_LINE	748,"sound/music.h::main::0::196"
     defb 3
	C_LINE	749,"sound/music.h::main::0::196"
         defb 190
	C_LINE	750,"sound/music.h::main::0::196"
         defb 157
	C_LINE	751,"sound/music.h::main::0::196"
         defb 125
	C_LINE	752,"sound/music.h::main::0::196"
     defb 3
	C_LINE	753,"sound/music.h::main::0::196"
         defb 190
	C_LINE	754,"sound/music.h::main::0::196"
         defb 157
	C_LINE	755,"sound/music.h::main::0::196"
     defb 4
	C_LINE	756,"sound/music.h::main::0::196"
         defb 190
	C_LINE	757,"sound/music.h::main::0::196"
         defb 157
	C_LINE	758,"sound/music.h::main::0::196"
         defb 126
	C_LINE	759,"sound/music.h::main::0::196"
     defb 3
	C_LINE	760,"sound/music.h::main::0::196"
         defb 190
	C_LINE	761,"sound/music.h::main::0::196"
         defb 157
	C_LINE	762,"sound/music.h::main::0::196"
         defb 126
	C_LINE	763,"sound/music.h::main::0::196"
     defb 3
	C_LINE	764,"sound/music.h::main::0::196"
         defb 190
	C_LINE	765,"sound/music.h::main::0::196"
         defb 157
	C_LINE	766,"sound/music.h::main::0::196"
         defb 126
	C_LINE	767,"sound/music.h::main::0::196"
     defb 3
	C_LINE	768,"sound/music.h::main::0::196"
         defb 190
	C_LINE	769,"sound/music.h::main::0::196"
         defb 157
	C_LINE	770,"sound/music.h::main::0::196"
         defb 126
	C_LINE	771,"sound/music.h::main::0::196"
     defb 3
	C_LINE	772,"sound/music.h::main::0::196"
         defb 190
	C_LINE	773,"sound/music.h::main::0::196"
         defb 157
	C_LINE	774,"sound/music.h::main::0::196"
         defb 125
	C_LINE	775,"sound/music.h::main::0::196"
     defb 3
	C_LINE	776,"sound/music.h::main::0::196"
         defb 190
	C_LINE	777,"sound/music.h::main::0::196"
         defb 157
	C_LINE	778,"sound/music.h::main::0::196"
     defb 4
	C_LINE	779,"sound/music.h::main::0::196"
         defb 190
	C_LINE	780,"sound/music.h::main::0::196"
         defb 157
	C_LINE	781,"sound/music.h::main::0::196"
         defb 126
	C_LINE	782,"sound/music.h::main::0::196"
     defb 3
	C_LINE	783,"sound/music.h::main::0::196"
         defb $bd,2
	C_LINE	784,"sound/music.h::main::0::196"
         defb 173
	C_LINE	785,"sound/music.h::main::0::196"
         defb 159
	C_LINE	786,"sound/music.h::main::0::196"
         defb 126
	C_LINE	787,"sound/music.h::main::0::196"
     defb 3
	C_LINE	788,"sound/music.h::main::0::196"
         defb 190
	C_LINE	789,"sound/music.h::main::0::196"
         defb 159
	C_LINE	790,"sound/music.h::main::0::196"
     defb 4
	C_LINE	791,"sound/music.h::main::0::196"
         defb 171
	C_LINE	792,"sound/music.h::main::0::196"
         defb 159
	C_LINE	793,"sound/music.h::main::0::196"
         defb 126
	C_LINE	794,"sound/music.h::main::0::196"
     defb 3
	C_LINE	795,"sound/music.h::main::0::196"
         defb 190
	C_LINE	796,"sound/music.h::main::0::196"
         defb 159
	C_LINE	797,"sound/music.h::main::0::196"
         defb 125
	C_LINE	798,"sound/music.h::main::0::196"
     defb 3
	C_LINE	799,"sound/music.h::main::0::196"
         defb 164
	C_LINE	800,"sound/music.h::main::0::196"
         defb 159
	C_LINE	801,"sound/music.h::main::0::196"
         defb 126
	C_LINE	802,"sound/music.h::main::0::196"
     defb 3
	C_LINE	803,"sound/music.h::main::0::196"
         defb 190
	C_LINE	804,"sound/music.h::main::0::196"
         defb 159
	C_LINE	805,"sound/music.h::main::0::196"
         defb 125
	C_LINE	806,"sound/music.h::main::0::196"
     defb 3
	C_LINE	807,"sound/music.h::main::0::196"
         defb 159
	C_LINE	808,"sound/music.h::main::0::196"
         defb 159
	C_LINE	809,"sound/music.h::main::0::196"
         defb 126
	C_LINE	810,"sound/music.h::main::0::196"
     defb 3
	C_LINE	811,"sound/music.h::main::0::196"
         defb 190
	C_LINE	812,"sound/music.h::main::0::196"
         defb 159
	C_LINE	813,"sound/music.h::main::0::196"
     defb 4
	C_LINE	814,"sound/music.h::main::0::196"
         defb 161
	C_LINE	815,"sound/music.h::main::0::196"
         defb 159
	C_LINE	816,"sound/music.h::main::0::196"
         defb 126
	C_LINE	817,"sound/music.h::main::0::196"
     defb 3
	C_LINE	818,"sound/music.h::main::0::196"
         defb 161
	C_LINE	819,"sound/music.h::main::0::196"
         defb 159
	C_LINE	820,"sound/music.h::main::0::196"
         defb 126
	C_LINE	821,"sound/music.h::main::0::196"
     defb 3
	C_LINE	822,"sound/music.h::main::0::196"
         defb 164
	C_LINE	823,"sound/music.h::main::0::196"
         defb 159
	C_LINE	824,"sound/music.h::main::0::196"
         defb 126
	C_LINE	825,"sound/music.h::main::0::196"
     defb 3
	C_LINE	826,"sound/music.h::main::0::196"
         defb 190
	C_LINE	827,"sound/music.h::main::0::196"
         defb 159
	C_LINE	828,"sound/music.h::main::0::196"
         defb 125
	C_LINE	829,"sound/music.h::main::0::196"
     defb 3
	C_LINE	830,"sound/music.h::main::0::196"
         defb $00
	C_LINE	832,"sound/music.h::main::0::196"
;#line 147 "mk1.c"
	C_LINE	834,"sound/music.h::main::0::196"
	C_LINE	146,"mk1.c::main::0::196"
	SECTION	rodata_compiler
.i_1
	defm	"            "
	defb	0

	defm	"LEVEL 0X"
	defb	0

	defm	"CONGRATULATIONS!"
	defb	0

	defm	"YOU MANAGED TO SET THE BOMBS"
	defb	0

	defm	"AND DESTROY THE COMPUTER"
	defb	0

	defm	"MISSION ACCOMPLISHED!!"
	defb	0

	defm	" GAME UNDER "
	defb	0

	defm	"  CONTINUE  "
	defb	0

	defm	" 1-YES 2-NO "
	defb	0

	defm	" ZONE CLEAR "
	defb	0

	defm	"BOMBS ARE SET! RETURN TO BASE!"
	defm	""
	defb	0

	defm	" SET 5 BOMBS IN EVIL COMPUTER"
	defb	0

	defm	" SET BOMBS IN EVIL COMPUTER "
	defb	0

	defm	"  DONE! NOW GO BACK TO BASE!  "
	defm	""
	defb	0

	defm	" HALF NEW MOTORBIKE FOR SALE! "
	defm	""
	defb	0

	defm	"                              "
	defm	""
	defb	0


; --- Start of Static Variables ---

	SECTION	bss_compiler
._AD_FREE	defs	1050
._pad0	defs	1
._sp_player	defs	2
._sp_moviles	defs	6
._sp_bullets	defs	6
._sp_cocos	defs	6
._enoffs	defs	1
._asm_number	defs	1
._asm_int_2	defs	2
._seed	defs	2
._half_life	defs	1
._p_x	defs	2
._p_y	defs	2
._p_vx	defs	2
._p_vy	defs	2
._p_current_frame	defs	2
._p_next_frame	defs	2
._p_saltando	defs	1
._p_cont_salto	defs	1
._p_frame	defs	1
._p_subframe	defs	1
._p_facing	defs	1
._p_estado	defs	1
._p_ct_estado	defs	1
._p_gotten	defs	1
._pregotten	defs	1
._p_life	defs	1
._p_objs	defs	1
._p_keys	defs	1
._p_fuel	defs	1
._p_killed	defs	1
._p_disparando	defs	1
._p_facing_v	defs	1
._p_facing_h	defs	1
._p_ammo	defs	1
._p_killme	defs	1
._p_kill_amt	defs	1
._p_tx	defs	1
._p_ty	defs	1
._ptgmx	defs	2
._ptgmy	defs	2
._enit	defs	1
._en_an_base_frame	defs	3
._en_an_frame	defs	3
._en_an_count	defs	3
._en_an_current_frame	defs	6
._en_an_next_frame	defs	6
._en_an_state	defs	3
._en_an_alive	defs	3
._en_an_dead_row	defs	3
._en_an_rawv	defs	3
.__en_x	defs	1
.__en_y	defs	1
.__en_x1	defs	1
.__en_y1	defs	1
.__en_x2	defs	1
.__en_y2	defs	1
.__en_mx	defs	1
.__en_my	defs	1
.__en_t	defs	1
.__en_life	defs	1
.__baddies_pointer	defs	2
.__en_cx	defs	1
.__en_cy	defs	1
._bullets_x	defs	3
._bullets_y	defs	3
._bullets_mx	defs	3
._bullets_my	defs	3
._bullets_estado	defs	3
.__b_estado	defs	1
._b_it	defs	1
.__b_x	defs	1
.__b_y	defs	1
.__b_mx	defs	1
.__b_my	defs	1
._cocos_x	defs	3
._cocos_y	defs	3
._cocos_mx	defs	3
._cocos_my	defs	3
._map_attr	defs	150
._hotspot_x	defs	1
._hotspot_y	defs	1
._hotspot_destroy	defs	1
._orig_tile	defs	1
._flags	defs	2
._o_pant	defs	1
._n_pant	defs	1
._is_rendering	defs	1
._level	defs	1
._slevel	defs	1
._maincounter	defs	1
._gpx	defs	1
._gpox	defs	1
._gpy	defs	1
._gpd	defs	1
._gpc	defs	1
._gpxx	defs	1
._gpyy	defs	1
._gpcx	defs	1
._gpcy	defs	1
._possee	defs	1
._hit_v	defs	1
._hit_h	defs	1
._hit	defs	1
._wall_h	defs	1
._wall_v	defs	1
._gpen_x	defs	1
._gpen_y	defs	1
._gpen_cx	defs	1
._gpen_cy	defs	1
._gpaux	defs	1
._tocado	defs	1
._active	defs	1
._gpit	defs	1
._gpjt	defs	1
._enoffsmasi	defs	1
._map_pointer	defs	2
._blx	defs	1
._bly	defs	1
._rdx	defs	1
._rdy	defs	1
._rda	defs	1
._rdb	defs	1
._rdc	defs	1
._rdd	defs	1
._rdn	defs	1
._rdt	defs	1
._itj	defs	2
._objs_old	defs	1
._keys_old	defs	1
._life_old	defs	1
._killed_old	defs	1
._ammo_old	defs	1
._gen_pt	defs	2
._playing	defs	1
._success	defs	1
.__x	defs	1
.__y	defs	1
.__n	defs	1
.__t	defs	1
._cx1	defs	1
._cy1	defs	1
._cx2	defs	1
._cy2	defs	1
._at1	defs	1
._at2	defs	1
._x0	defs	1
._y0	defs	1
._x1	defs	1
._y1	defs	1
._ptx1	defs	1
._pty1	defs	1
._ptx2	defs	1
._pty2	defs	1
.__gp_gen	defs	2
._isrc	defs	1
	SECTION	code_compiler


; --- Start of Scope Defns ---

	GLOBAL	_u_malloc
	GLOBAL	_u_free
	GLOBAL	sp_InitIM2
	GLOBAL	sp_InstallISR
	GLOBAL	sp_EmptyISR
	GLOBAL	sp_CreateGenericISR
	GLOBAL	sp_RegisterHook
	GLOBAL	sp_RegisterHookFirst
	GLOBAL	sp_RegisterHookLast
	GLOBAL	sp_RemoveHook
	GLOBAL	sp_Initialize
	GLOBAL	sp_SwapEndian
	GLOBAL	sp_Swap
	GLOBAL	sp_PFill
	GLOBAL	sp_StackSpace
	GLOBAL	sp_Random32
	GLOBAL	sp_Border
	GLOBAL	sp_inp
	GLOBAL	sp_outp
	GLOBAL	sp_IntRect
	GLOBAL	sp_IntLargeRect
	GLOBAL	sp_IntPtLargeRect
	GLOBAL	sp_IntIntervals
	GLOBAL	sp_IntPtInterval
	GLOBAL	sp_CreateSpr
	GLOBAL	sp_AddColSpr
	GLOBAL	sp_DeleteSpr
	GLOBAL	sp_IterateSprChar
	GLOBAL	sp_RemoveDList
	GLOBAL	sp_MoveSprAbs
	GLOBAL	sp_MoveSprAbsC
	GLOBAL	sp_MoveSprAbsNC
	GLOBAL	sp_MoveSprRel
	GLOBAL	sp_MoveSprRelC
	GLOBAL	sp_MoveSprRelNC
	GLOBAL	sp_PrintAt
	GLOBAL	sp_PrintAtInv
	GLOBAL	sp_ScreenStr
	GLOBAL	sp_PrintAtDiff
	GLOBAL	sp_PrintString
	GLOBAL	sp_ComputePos
	GLOBAL	sp_TileArray
	GLOBAL	sp_Pallette
	GLOBAL	sp_GetTiles
	GLOBAL	sp_PutTiles
	GLOBAL	sp_IterateDList
	GLOBAL	sp_AddMemory
	GLOBAL	sp_BlockAlloc
	GLOBAL	sp_BlockFit
	GLOBAL	sp_FreeBlock
	GLOBAL	sp_InitAlloc
	GLOBAL	sp_BlockCount
	GLOBAL	sp_Invalidate
	GLOBAL	sp_Validate
	GLOBAL	sp_ClearRect
	GLOBAL	sp_UpdateNow
	GLOBAL	sp_UpdateNowEx
	GLOBAL	sp_CompDListAddr
	GLOBAL	sp_CompDirtyAddr
	GLOBAL	sp_JoySinclair1
	GLOBAL	sp_JoySinclair2
	GLOBAL	sp_JoyTimexEither
	GLOBAL	sp_JoyTimexLeft
	GLOBAL	sp_JoyTimexRight
	GLOBAL	sp_JoyFuller
	GLOBAL	sp_JoyKempston
	GLOBAL	sp_JoyKeyboard
	GLOBAL	sp_WaitForKey
	GLOBAL	sp_WaitForNoKey
	GLOBAL	sp_Pause
	GLOBAL	sp_Wait
	GLOBAL	sp_LookupKey
	GLOBAL	sp_GetKey
	GLOBAL	sp_Inkey
	GLOBAL	sp_KeyPressed
	GLOBAL	sp_MouseAMXInit
	GLOBAL	sp_MouseAMX
	GLOBAL	sp_SetMousePosAMX
	GLOBAL	sp_MouseKempston
	GLOBAL	sp_SetMousePosKempston
	GLOBAL	sp_MouseSim
	GLOBAL	sp_SetMousePosSim
	GLOBAL	sp_CharDown
	GLOBAL	sp_CharLeft
	GLOBAL	sp_CharRight
	GLOBAL	sp_CharUp
	GLOBAL	sp_GetAttrAddr
	GLOBAL	sp_GetCharAddr
	GLOBAL	sp_GetScrnAddr
	GLOBAL	sp_PixelDown
	GLOBAL	sp_PixelUp
	GLOBAL	sp_PixelLeft
	GLOBAL	sp_PixelRight
	GLOBAL	sp_ListCreate
	GLOBAL	sp_ListCount
	GLOBAL	sp_ListFirst
	GLOBAL	sp_ListLast
	GLOBAL	sp_ListNext
	GLOBAL	sp_ListPrev
	GLOBAL	sp_ListCurr
	GLOBAL	sp_ListAdd
	GLOBAL	sp_ListInsert
	GLOBAL	sp_ListAppend
	GLOBAL	sp_ListPrepend
	GLOBAL	sp_ListRemove
	GLOBAL	sp_ListConcat
	GLOBAL	sp_ListFree
	GLOBAL	sp_ListTrim
	GLOBAL	sp_ListSearch
	GLOBAL	sp_HashCreate
	GLOBAL	sp_HashRemove
	GLOBAL	sp_HashLookup
	GLOBAL	sp_HashAdd
	GLOBAL	sp_HashDelete
	GLOBAL	sp_Heapify
	GLOBAL	sp_HeapSiftDown
	GLOBAL	sp_HeapSiftUp
	GLOBAL	sp_HeapAdd
	GLOBAL	sp_HeapExtract
	GLOBAL	sp_HuffCreate
	GLOBAL	sp_HuffDelete
	GLOBAL	sp_HuffAccumulate
	GLOBAL	sp_HuffExtract
	GLOBAL	sp_HuffSetState
	GLOBAL	sp_HuffGetState
	GLOBAL	sp_HuffDecode
	GLOBAL	sp_HuffEncode
	GLOBAL	_keys
	GLOBAL	_break_wall
	GLOBAL	_bullets_init
	GLOBAL	_bullets_update
	GLOBAL	_bullets_fire
	GLOBAL	_bullets_move
	GLOBAL	_enems_init
	GLOBAL	_enems_draw_current
	GLOBAL	_enems_load
	GLOBAL	_enems_kill
	GLOBAL	_enems_move
	GLOBAL	_collide
	GLOBAL	_cm_two_points
	GLOBAL	_rand
	GLOBAL	_abs
	GLOBAL	_step
	GLOBAL	_cortina
	GLOBAL	_hotspots_init
	GLOBAL	_hotspots_do
	GLOBAL	_player_init
	GLOBAL	_player_calc_bounding_box
	GLOBAL	_player_move
	GLOBAL	_player_deplete
	GLOBAL	_player_kill
	GLOBAL	_simple_coco_init
	GLOBAL	_simple_coco_shoot
	GLOBAL	_simple_coco_update
	GLOBAL	_SetRAMBank
	GLOBAL	_get_resource
	GLOBAL	_unpack
	GLOBAL	_beep_fx
	GLOBAL	_prepare_level
	GLOBAL	_game_ending
	GLOBAL	_game_over
	GLOBAL	_time_over
	GLOBAL	_pause_screen
	GLOBAL	_addsign
	GLOBAL	_espera_activa
	GLOBAL	_locks_init
	GLOBAL	_player_hidden
	GLOBAL	_run_fire_script
	GLOBAL	_process_tile
	GLOBAL	_draw_scr_background
	GLOBAL	_draw_scr_hotspots_locks
	GLOBAL	_draw_scr
	GLOBAL	_select_joyfunc
	GLOBAL	_mons_col_sc_x
	GLOBAL	_mons_col_sc_y
	GLOBAL	_distance
	GLOBAL	_limit
	GLOBAL	_blackout
	GLOBAL	_attr
	GLOBAL	_qtile
	GLOBAL	_draw_coloured_tile
	GLOBAL	_invalidate_tile
	GLOBAL	_invalidate_viewport
	GLOBAL	_draw_invalidate_coloured_tile_gamearea
	GLOBAL	_draw_coloured_tile_gamearea
	GLOBAL	_draw_decorations
	GLOBAL	_update_tile
	GLOBAL	_print_number2
	GLOBAL	_draw_objs
	GLOBAL	_print_str
	GLOBAL	_blackout_area
	GLOBAL	_clear_sprites
	GLOBAL	_mem_save
	GLOBAL	_mem_load
	GLOBAL	_tape_save
	GLOBAL	_tape_load
	GLOBAL	_sg_submenu
	GLOBAL	_tilanims_add
	GLOBAL	_tilanims_do
	GLOBAL	_tilanims_reset
	GLOBAL	_AD_FREE
	GLOBAL	_joyfunc
	GLOBAL	_joyfuncs
	GLOBAL	_pad0
	GLOBAL	_my_malloc
	defc	_safe_byte	= 23296
	defc	_ram_address	= 23297
	defc	_ram_destination	= 23299
	GLOBAL	_sp_player
	GLOBAL	_sp_moviles
	GLOBAL	_sp_bullets
	GLOBAL	_sp_cocos
	GLOBAL	_enoffs
	GLOBAL	_asm_number
	defc	_asm_int	= 23302
	GLOBAL	_asm_int_2
	GLOBAL	_seed
	GLOBAL	_half_life
	GLOBAL	_p_x
	GLOBAL	_p_y
	GLOBAL	_p_vx
	GLOBAL	_p_vy
	GLOBAL	_p_current_frame
	GLOBAL	_p_next_frame
	GLOBAL	_p_saltando
	GLOBAL	_p_cont_salto
	GLOBAL	_p_frame
	GLOBAL	_p_subframe
	GLOBAL	_p_facing
	GLOBAL	_p_estado
	GLOBAL	_p_ct_estado
	GLOBAL	_p_gotten
	GLOBAL	_pregotten
	GLOBAL	_p_life
	GLOBAL	_p_objs
	GLOBAL	_p_keys
	GLOBAL	_p_fuel
	GLOBAL	_p_killed
	GLOBAL	_p_disparando
	GLOBAL	_p_facing_v
	GLOBAL	_p_facing_h
	GLOBAL	_p_ammo
	GLOBAL	_p_killme
	GLOBAL	_p_kill_amt
	GLOBAL	_p_tx
	GLOBAL	_p_ty
	GLOBAL	_ptgmx
	GLOBAL	_ptgmy
	GLOBAL	_spacer
	GLOBAL	_enit
	GLOBAL	_en_an_base_frame
	GLOBAL	_en_an_frame
	GLOBAL	_en_an_count
	GLOBAL	_en_an_current_frame
	GLOBAL	_en_an_next_frame
	GLOBAL	_en_an_state
	GLOBAL	_en_an_alive
	GLOBAL	_en_an_dead_row
	GLOBAL	_en_an_rawv
	GLOBAL	__en_x
	GLOBAL	__en_y
	GLOBAL	__en_x1
	GLOBAL	__en_y1
	GLOBAL	__en_x2
	GLOBAL	__en_y2
	GLOBAL	__en_mx
	GLOBAL	__en_my
	GLOBAL	__en_t
	GLOBAL	__en_life
	GLOBAL	__baddies_pointer
	GLOBAL	__en_cx
	GLOBAL	__en_cy
	GLOBAL	_bullets_x
	GLOBAL	_bullets_y
	GLOBAL	_bullets_mx
	GLOBAL	_bullets_my
	GLOBAL	_bullets_estado
	GLOBAL	__b_estado
	GLOBAL	_b_it
	GLOBAL	__b_x
	GLOBAL	__b_y
	GLOBAL	__b_mx
	GLOBAL	__b_my
	GLOBAL	_cocos_x
	GLOBAL	_cocos_y
	GLOBAL	_cocos_mx
	GLOBAL	_cocos_my
	GLOBAL	_map_attr
	defc	_map_buff	= 61697
	defc	_brk_buff	= 23312
	GLOBAL	_hotspot_x
	GLOBAL	_hotspot_y
	GLOBAL	_hotspot_destroy
	GLOBAL	_orig_tile
	GLOBAL	_flags
	GLOBAL	_o_pant
	GLOBAL	_n_pant
	GLOBAL	_is_rendering
	GLOBAL	_level
	GLOBAL	_slevel
	GLOBAL	_warp_to_level
	GLOBAL	_maincounter
	GLOBAL	_gpx
	GLOBAL	_gpox
	GLOBAL	_gpy
	GLOBAL	_gpd
	GLOBAL	_gpc
	GLOBAL	_gpxx
	GLOBAL	_gpyy
	GLOBAL	_gpcx
	GLOBAL	_gpcy
	GLOBAL	_possee
	GLOBAL	_hit_v
	GLOBAL	_hit_h
	GLOBAL	_hit
	GLOBAL	_wall_h
	GLOBAL	_wall_v
	GLOBAL	_gpen_x
	GLOBAL	_gpen_y
	GLOBAL	_gpen_cx
	GLOBAL	_gpen_cy
	GLOBAL	_gpaux
	GLOBAL	_tocado
	GLOBAL	_active
	GLOBAL	_gpit
	GLOBAL	_gpjt
	GLOBAL	_enoffsmasi
	GLOBAL	_map_pointer
	GLOBAL	_blx
	GLOBAL	_bly
	GLOBAL	_rdx
	GLOBAL	_rdy
	GLOBAL	_rda
	GLOBAL	_rdb
	GLOBAL	_rdc
	GLOBAL	_rdd
	GLOBAL	_rdn
	GLOBAL	_rdt
	GLOBAL	_itj
	GLOBAL	_objs_old
	GLOBAL	_keys_old
	GLOBAL	_life_old
	GLOBAL	_killed_old
	GLOBAL	_ammo_old
	GLOBAL	_level_str
	GLOBAL	_silent_level
	GLOBAL	_gen_pt
	GLOBAL	_playing
	GLOBAL	_success
	GLOBAL	__x
	GLOBAL	__y
	GLOBAL	__n
	GLOBAL	__t
	GLOBAL	_cx1
	GLOBAL	_cy1
	GLOBAL	_cx2
	GLOBAL	_cy2
	GLOBAL	_at1
	GLOBAL	_at2
	GLOBAL	_x0
	GLOBAL	_y0
	GLOBAL	_x1
	GLOBAL	_y1
	GLOBAL	_ptx1
	GLOBAL	_pty1
	GLOBAL	_ptx2
	GLOBAL	_pty2
	GLOBAL	__gp_gen
	GLOBAL	__dx
	GLOBAL	__dy
	GLOBAL	_isrc
	GLOBAL	_s_title
	GLOBAL	_s_marco
	GLOBAL	_s_ending
	GLOBAL	_font
	GLOBAL	_level_data
	GLOBAL	_mapa
	GLOBAL	_cerrojos
	GLOBAL	_tileset
	GLOBAL	_malotes
	GLOBAL	_hotspots
	GLOBAL	_behs
	GLOBAL	_sprites
	GLOBAL	_sprite_1_a
	GLOBAL	_sprite_1_b
	GLOBAL	_sprite_1_c
	GLOBAL	_sprite_2_a
	GLOBAL	_sprite_2_b
	GLOBAL	_sprite_2_c
	GLOBAL	_sprite_3_a
	GLOBAL	_sprite_3_b
	GLOBAL	_sprite_3_c
	GLOBAL	_sprite_4_a
	GLOBAL	_sprite_4_b
	GLOBAL	_sprite_4_c
	GLOBAL	_sprite_5_a
	GLOBAL	_sprite_5_b
	GLOBAL	_sprite_5_c
	GLOBAL	_sprite_6_a
	GLOBAL	_sprite_6_b
	GLOBAL	_sprite_6_c
	GLOBAL	_sprite_7_a
	GLOBAL	_sprite_7_b
	GLOBAL	_sprite_7_c
	GLOBAL	_sprite_8_a
	GLOBAL	_sprite_8_b
	GLOBAL	_sprite_8_c
	GLOBAL	_sprite_9_a
	GLOBAL	_sprite_9_b
	GLOBAL	_sprite_9_c
	GLOBAL	_sprite_10_a
	GLOBAL	_sprite_10_b
	GLOBAL	_sprite_10_c
	GLOBAL	_sprite_11_a
	GLOBAL	_sprite_11_b
	GLOBAL	_sprite_11_c
	GLOBAL	_sprite_12_a
	GLOBAL	_sprite_12_b
	GLOBAL	_sprite_12_c
	GLOBAL	_sprite_13_a
	GLOBAL	_sprite_13_b
	GLOBAL	_sprite_13_c
	GLOBAL	_sprite_14_a
	GLOBAL	_sprite_14_b
	GLOBAL	_sprite_14_c
	GLOBAL	_sprite_15_a
	GLOBAL	_sprite_15_b
	GLOBAL	_sprite_15_c
	GLOBAL	_sprite_16_a
	GLOBAL	_sprite_16_b
	GLOBAL	_sprite_16_c
	GLOBAL	_sprite_17_a
	GLOBAL	_sprite_18_a
	GLOBAL	_sprite_19_a
	GLOBAL	_sprite_19_b
	GLOBAL	_map_bolts_0
	GLOBAL	_map_bolts_1
	GLOBAL	_map_bolts_2
	GLOBAL	_tileset_0
	GLOBAL	_tileset_1
	GLOBAL	_tileset_2
	GLOBAL	_enems_hotspots_0
	GLOBAL	_enems_hotspots_1
	GLOBAL	_enems_hotspots_2
	GLOBAL	_behs_0_1
	GLOBAL	_behs_2
	GLOBAL	_levels
	GLOBAL	_decos_computer
	GLOBAL	_decos_bombs
	GLOBAL	_decos_moto
	GLOBAL	_do_continue
	GLOBAL	_current_level
	GLOBAL	_utaux
	GLOBAL	__bxo
	GLOBAL	__byo
	GLOBAL	__bmxo
	GLOBAL	__bmyo
	GLOBAL	_player_cells
	GLOBAL	_enem_cells
	GLOBAL	_validate
	GLOBAL	_lame_sound
	GLOBAL	_dr
	GLOBAL	_zone_clear
	GLOBAL	_enems_pursuers_init
	GLOBAL	_main


; --- End of Scope Defns ---


; --- End of Compilation ---
