// msc.h
// Generado por Mojon Script Compiler de la Churrera
// Copyleft 2011 The Mojon Twins
 
#define MSC_MAXITEMS    32
#define MSC_MAXFLAGS    32
 
typedef struct {
    unsigned char status;
    unsigned char supertile;
    unsigned char n_pant;
    unsigned char x, y;
} ITEM;
ITEM items [MSC_MAXITEMS];
 
unsigned char flags [MSC_MAXFLAGS];
unsigned char script_result = 0;
unsigned char script_something_done = 0;
 
