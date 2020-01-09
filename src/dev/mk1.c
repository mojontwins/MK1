// MTE MK1 (la Churrera) v3.99.99 (final)
// Copyleft 2010-2017 by the Mojon Twins

// mk1.c
// Esqueleto de juegos de la churrera
// Copyleft 2010-2014 The Mojon Twins

#include <spritepack.h>

// We are using some stuff from splib2 directly.
#asm
		LIB SPMoveSprAbs
		LIB SPPrintAtInv
		LIB SPTileArray
		LIB SPInvalidate
		LIB SPCompDListAddr
#endasm

#include "config.h"

#ifdef MODE_128K
	// Versión para 128K
	#pragma output STACKPTR=23999
	#define FREEPOOL 61697
#else
	// Versión para 48K
	#pragma output STACKPTR=61952
	#define FREEPOOL 61440
#endif

// NUMBLOCKS es el número de bloques necesario para mover los sprites
// Configurar bien este número es MUY IMPORTANTE

#define NUMBLOCKS 40

// La regla es esta: cada sprite de 16x16 ocupa 10 bloques.
// Cada proyectil ocupa 5 bloques.

// Si, por ejemplo, tu juego no tiene disparos, sólo necesitas bloques
// para el sprite principal y tres enemigos, o sea, 4*10 = 40 bloques.

// Si, por ejemplo, tu juego además lleva 3 proyectiles, necesitarás
// 4*10 + 3*5 = 55 bloques.

unsigned char AD_FREE [NUMBLOCKS * 15];

// Cosas del juego:

#include "definitions.h"

#ifdef ACTIVATE_SCRIPTING
	#include "msc-config.h"
#endif

#ifdef MODE_128K
	#include "128k.h"
#endif

#include "aplib.h"
#include "pantallas.h"

#ifdef MODE_128K
	#include "librarian.h"
	
	#ifdef COMPRESSED_LEVELS
		#include "levels128.h"
	#else
		#include "mapa.h"
		#include "tileset.h"
		#include "sprites.h"
		#include "extrasprites.h"
		#include "enems.h"
	#endif

#else

	#ifdef COMPRESSED_LEVELS
		#include "levels.h"
	#else
		#include "mapa.h"
	#endif

	#include "tileset.h"
	#include "sprites.h"
	#include "extrasprites.h"
	
	#ifndef COMPRESSED_LEVELS
		#include "enems.h"
	#endif

#endif

#ifdef MODE_128K
	#include "wyzph"
#else
	#include "beeper.h"
#endif

#include "printer.h"

#ifdef ACTIVATE_SCRIPTING
	#ifdef ENABLE_EXTERN_CODE
		#include "extern.h"
	#endif
	#include "msc.h"
#endif

#include "engine/general.h"
#include "engine.h"
#include "engine/player.h"
#include "engine/enengine.h"

#ifdef ENABLE_CHECKPOINTS
	#include "savegame.h"
#endif

#include "mainloop.h"

#ifndef MODE_128K
	// From beepola. Phaser engine by Shiru.
	#include "music.h"
#endif
