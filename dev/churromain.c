// churromain.c
// Esqueleto de juegos de la churrera
// Copyleft 2010-2014 The Mojon Twins

// version FORK 3.99.3b

#include <spritepack.h>

// Para 128K descomenta la 24099 y comenta la otra
//#pragma output STACKPTR=24099
#pragma output STACKPTR=61952
#define AD_FREE			60655

// MAX BINARY SIZE = 35655 (make @ 25000) or 36155 (make @ 24500)

// Optimal place to compile if using COMPRESSED_LEVELS:
// 23296 + MAP_W * MAP_H * (108) + MAX_CERROJOS * 4 + 49

#include "config.h"

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
	#include "wyzplayer.h"
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

#include "engine.h"
#include "mainloop.h"

// Y el main

void main (void) {
	do_game ();
}

#ifndef MODE_128K
// From beepola. Phaser engine by Shiru.
#include "music.h"
#endif
