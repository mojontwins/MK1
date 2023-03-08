// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

#define P_MAX_VY_FRENANDO 128

unsigned char rebound;

#define COLL_NONE 0
#define COLL_VERT 1
#define COLL_HORZ 2

//para meter texticos
#include "plugins/textbox.h"

// decoraciones, los números están en hexadecimal

const unsigned char decos_24 [] = { 0xC3, 32, 0xD3, 33, 0xC4, 34, 0xD4, 35, 0xC5, 36, 0xD5, 37, 0xff };