// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// mk1.c

#include <spritepack.h>

// We are using some stuff from splib2 directly.
#asm
		LIB SPMoveSprAbs
		LIB SPPrintAtInv
		LIB SPTileArray
		LIB SPInvalidate
		LIB SPCompDListAddr
#endasm

#include "my/config.h"

#ifdef MODE_128K
	// Versión para 128K
	#pragma output STACKPTR=23999
	#define FREEPOOL 61697
#else
	// Versión para 48K
	#pragma output STACKPTR=61952
	#define FREEPOOL 61440
#endif

// Configure number of blocks and reserve a pool for sprites

#ifdef PLAYER_CAN_FIRE
	#define NUMBLOCKS (40 + (MAX_BULLETS * 5))
#else
	#define NUMBLOCKS 40
#endif

unsigned char AD_FREE [NUMBLOCKS * 15];

// Cosas del juego:

#include "definitions.h"

#ifdef ACTIVATE_SCRIPTING
	#include "my/msc-config.h"
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
		#include "my/extern.h"
	#endif
	#include "my/msc.h"
#endif

#include "engine/general.h"
#ifdef BREAKABLE_WALLS
	#include "engine/breakable.h"
#endif
#ifdef PLAYER_CAN_FIRE
	#include "engine/bullets.h"
#endif
#include "engine.h"
#include "engine/player.h"
#include "engine/enengine.h"
#include "engine/hotspots.h"

#ifdef ENABLE_CHECKPOINTS
	#include "savegame.h"
#endif

#include "mainloop.h"

#ifndef MODE_128K
	// From beepola. Phaser engine by Shiru.
	#include "music.h"
#endif
