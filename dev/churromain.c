// Churrera Engine
// ===============
// Copyleft 2010, 2011 by The Mojon Twins

// churromain.c
// Program skeleton. Rename to your game title.c

#include <spritepack.h>

/*
#pragma output STACKPTR=61440
#define AD_FREE			60000
*/
// Tighten it even more... Gaining about 1.1 extra Kb 
// You will probably have to tinker with this depending on your game.
#pragma output STACKPTR=61952
#define AD_FREE			60020

#include "config.h"

// Program modules in strict order...

#include "definitions.h"
#ifdef ACTIVATE_SCRIPTING
#include "msc-config.h"
#endif
#include "aplib.h"
#include "pantallas.h"
#include "mapa.h"
#include "tileset.h"
#include "sprites.h"
#if defined(PLAYER_KILLS_ENEMIES) || defined(PLAYER_CAN_FIRE) || defined(NO_MAX_ENEMS)
#include "extrasprites.h"
#endif
#include "enems.h"
#include "beeper.h"
#include "printer.h"
#ifdef ACTIVATE_SCRIPTING
#include "msc.h"
#endif
#include "engine.h"
#include "mainloop.h"

// Main function.

void main (void) {
	do_game ();
}

// From beepola. Phaser engine by Shiru. We stick this at the end 'cause
// we don't want this in contended memory.

#include "music.h"

// And that's all, folks.
