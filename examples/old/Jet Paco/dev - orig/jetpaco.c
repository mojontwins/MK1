// churromain.c
// Esqueleto de juegos de la churrera
// Copyleft 2010 The Mojon Twins

// Renombrar a tujuego.c o lo que sea para que quede más bello
// y to la pesca.

// Super mega hiper disclaimer: como verás, el código es una 
// paranoia de la hostia. El tema está en que se reaprovecha
// mucho para poder hacer distintos tipos de juego con dife-
// rentes características, pero no todo el código es usable
// en todos los tipos de juego. Para ahorrar, se usan direc-
// tivas que incluyen sólo el necesario, dejando fuera
// todo lo que no se usa... Por eso es tan zapatiéstico.

// Y sí, es el mismo motor que Uwol o Phantomasa 2, pero
// mejorado, tuneado, modularizado y hipervitaminado.

#include <spritepack.h>

/*
#pragma output STACKPTR=61440
#define AD_FREE			60000
*/
// Tighten it even more... Gaining about 1.1 extra Kb 
#pragma output STACKPTR=61952
#define AD_FREE			60020

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
//#if defined(PLAYER_KILLS_ENEMIES) || defined(PLAYER_CAN_FIRE)
#include "extrasprites.h"
//#endif
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
