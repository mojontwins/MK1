// churromain.c
// Esqueleto de juegos de la churrera
// Copyleft 2010-2013 The Mojon Twins

// version FORK 3.99b

#include <spritepack.h>

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
#include "aplib.h"
#include "pantallas.h"
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
#include "beeper.h"
#include "printer.h"
#ifdef ACTIVATE_SCRIPTING
#ifdef ENABLE_EXTERN_CODE
#include "extern.h"
#endif
#include "msc.h"
#endif
#ifdef ENABLE_TILANIMS
#include "tilanim.h"
#endif
#include "engine.h"
#include "mainloop.h"

// Y el main

void main (void) {
	do_game ();
}

// From beepola. Phaser engine by Shiru.
#include "music.h"
