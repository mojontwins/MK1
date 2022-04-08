// churromain.c
// Esqueleto de juegos de la churrera
// Copyleft 2010-2013 The Mojon Twins

// version FORK 3.99b

#include <spritepack.h>

#pragma output STACKPTR=61952
#define AD_FREE			60655

// MAX BINARY SIZE = 35655 (make @ 25000) or 36155 (make @ 24500)

#include "config.h"

// Cosas del juego:

#include "definitions.h"
#ifdef ACTIVATE_SCRIPTING
#include "msc-config.h"
#endif
#include "aplib.h"
#include "pantallas.h"
#include "mapa.h"
#include "tileset.h"
#include "sprites.h"
#include "extrasprites.h"
#include "enems.h"
#include "beeper.h"
#include "printer.h"
#ifdef ACTIVATE_SCRIPTING
#include "msc.h"
#endif
#include "engine.h"
#include "mainloop.h"

// Y el main

void main (void) {
	do_game ();
}

// From beepola. Phaser engine by Shiru.
#include "music.h"
