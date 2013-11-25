// 128K stuff

// Esto parece un scratchpad. Anoto cosas. Cuando esto funcione y tal
// lo limpiaré. Por ahora, a joerce.

/*
	Primera prueba de estandarización 128K de la Churrera
	=====================================================
	
	Importante: todos los niveles tienen que tener el mismo número total
	de pantallas. Da igual como se organicen, cada una puede tener sus 
	propios map_w y map_h, pero el número total debe ser el mismo.
	
	Putada: los cerrojos. Voy a poner un MAX_CERROJOS = 32 y a joerce. 32
	cerrojos por fase está muy bien. Son 4 bytes por cerrojo = 128 bytes!
	
	Añadimos un #define 128K_MODE al principio del todo. También hay que
	añadir un #define COMPRESSED_LEVELS. Hay que activar LAS DOS.
	
	Si se define COMPRESSED_LEVELS y 128K_MODE, en lugar de levels.h se 
	carga un librarian especial llamado 128k.h que trae espacio para todo
	un nivel (del tamaño más grande, según manden MAP_W y MAP_H de config.h).
	También trae la rutina prepare_level_128 y las necesarias para la pagi-
	nación:
	
	void prepare_128k_level (unsigned char level);
	
	Esta función descomprimirá el nivel desde RAM alta hata el espacio en 
	RAM baja. El espacio equivale al binario del nivel generado por la nueva
	aplicación buildlevel:
	
	Chunk		Size
	HEADER		16
	MAP			MAP_W + MAP_H (/2 si es packed)
	CERROJOS	128
	TILESET		2304
	SPRITESET	2304
	EXTRASPR	352
	ENEMS		12 * MAP_W * MAP_H * 3
	HOTSPOTS	3 * MAP_W * MAP_H
	BEHAVIOURS	48
	
	El espacio lo creamos definiendo arrays de esos tamaños del mismo nombre
	que las normales que hay en mapa.h, tileset.h, sprites.h, extrasprites.h
	y enems.h para que se puedan usar directamente por el engine.
*/

// Definitions

#define MAX_CERROJOS 32

// Types:

typedef struct {
	unsigned char map_w, map_h;
	unsigned char scr_ini, ini_x, ini_y;
	unsigned char max_objs;
	unsigned char enems_life;
	unsigned char d01;	// Reserved
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
	int x, y;
	unsigned char x1, y1, x2, y2;
	char mx, my;
	unsigned char t, life;
} MALOTE;

typedef struct {
	unsigned char xy, tipo, act;
} HOTSPOT;

typedef struct {
	unsigned char resource;
	unsigned char music_id;
} LEVEL;

// Space reserved for levels
// This will be overwritten with the unpacked data

// Esta forma mierder-rara de hacerlo es porque z88dk no se aclara.

extern LEVELHEADER level_data [0];
#asm
	._level_data defs 16
#endasm
extern unsigned char mapa [0];
#ifdef UNPACKED_MAP
#asm
	._mapa defs MAP_W * MAP_H * 150
#endasm
#else
#asm
	._mapa defs MAP_W * MAP_H * 75
#endasm
#endif
extern CERROJOS cerrojos [0];
#asm
	._cerrojos defs 128	; 32 * 4
#endasm
extern unsigned char tileset [0];
#asm
	._tileset BINARY "basicts.bin"
#endasm
#include "sprites-empty.h"
#include "extrasprites.h"
extern MALOTE malotes [0];
#asm
	._malotes defs MAP_W * MAP_H * 3 * 12
#endasm
extern HOTSPOT hotspots [0];
#asm
	._hotspots defs MAP_W * MAP_H * 3
#endasm
extern unsigned char comportamiento_tiles [0];
#asm
	._comportamiento_tiles defs 48
#endasm

// Level struct
LEVEL levels [MAX_LEVELS] = {
	{3,3},
	{4,4},
	{5,5},
	{7,7},
	{6,3}	
};

