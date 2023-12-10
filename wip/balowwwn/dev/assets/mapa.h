// my/map_all_zeroes.h

// This file contains an alternate map with all zeroes.
// Just a trick for this game.

extern unsigned char mapa [0];
#asm
	._mapa defs MAP_W * MAP_H * 75
#endasm

typedef struct {
    unsigned char np, x, y, st;
} CERROJOS;

#define MAX_CERROJOS 32

extern CERROJOS cerrojos [0];
#asm
	._cerrojos defs 128	; 32 * 4
#endasm

extern unsigned char mapa_c [0]; 
#asm 
	._mapa_c
		BINARY "../bin/mapa.c.bin"
#endasm
