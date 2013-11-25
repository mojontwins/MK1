// churromain.c
// Esqueleto de juegos de la churrera
// Copyleft 2010 The Mojon Twins

// Renombrar a tujuego.c o lo que sea para que quede más bello
// y to la pesca.

#include <spritepack.h>

#pragma output STACKPTR=61440
#define AD_FREE			60000

struct sp_UDK keys;
void *joyfunc;				// Puntero a la función de manejo seleccionada.

void *my_malloc(uint bytes) {
   return sp_BlockAlloc(0);
}

void *u_malloc = my_malloc;
void *u_free = sp_FreeBlock;

// Globales muy globalizadas

unsigned char kempston_is_attached;
struct sp_SS *sp_player;
struct sp_SS *sp_moviles [3];
struct sp_Rect spritesClipValues;
struct sp_Rect *spritesClip;

unsigned char enoffs;


// Aux

extern char asm_number[1];
extern unsigned int asm_int [1];
extern unsigned int asm_int_2 [1];
extern unsigned int seed [1];
unsigned char half_life;

#asm
._asm_number 
	defb 0
._asm_int
	defw 0
._asm_int_2
	defw 0
._seed	
	defw 0
#endasm

// Cosas del juego:

#include "aplib.h"
#include "pantallas.h"
#include "config.h"
#include "mapa.h"
#include "tileset.h"
#include "sprites.h"
#include "enems.h"
#include "beeper.h"
#include "engine.h"

// Y el main

void main (void) {
	int j;
	unsigned char *allpurposepuntero;
	unsigned char i;
	unsigned char playing;
	unsigned char n_pant;
	unsigned char maincounter;
	unsigned char x, y;
	unsigned char success;
	
	// Primero detecto el kempston
	
	#asm
		halt
		in	a, (31)
		inc a
		ld	(_kempston_is_attached), a
		di
	#endasm
	
	// Inicializo splib2
	
	sp_Initialize (7, 0);
	sp_Border (BLACK);
	sp_AddMemory(0, 50, 14, AD_FREE);
	
	// Defino las teclas y el control por defecto
	
	keys.up    = sp_LookupKey('q');
	keys.down  = sp_LookupKey('a');
	keys.left  = sp_LookupKey('o');
	keys.right = sp_LookupKey('p');
	keys.fire  = sp_LookupKey(' ');
	
	joyfunc = sp_JoyKeyboard;

	// Cargo el tileset
		
	allpurposepuntero = tileset;
	for (j = 0; j < 255; j++) {
		sp_TileArray (j, allpurposepuntero);
		allpurposepuntero += 8;
	}

	// Rectángulo de clipping

	spritesClipValues.row_coord = VIEWPORT_Y;
	spritesClipValues.col_coord = VIEWPORT_X;
	spritesClipValues.height = 20;
	spritesClipValues.width = 30;
	spritesClip = &spritesClipValues;
	
	// Creamos los sprites
	
	sp_player = sp_CreateSpr (sp_MASK_SPRITE, 3, sprite_2_a, 1, TRANSPARENT);
	sp_AddColSpr (sp_player, sprite_2_b, TRANSPARENT);
	sp_AddColSpr (sp_player, sprite_2_c, TRANSPARENT);
	player.current_frame = player.next_frame = sprite_2_a;
	
	for (i = 0; i < 3; i ++) {
		sp_moviles [i] = sp_CreateSpr(sp_MASK_SPRITE, 3, sprite_9_a, 2, TRANSPARENT);
		sp_AddColSpr (sp_moviles [i], sprite_9_b, TRANSPARENT);
		sp_AddColSpr (sp_moviles [i], sprite_9_c, TRANSPARENT);	
		en_an [i].current_frame = sprite_9_a;
	}
	
	while (1) {
		// Aquí la pantalla de título
		sp_UpdateNow();
		unpack ((unsigned int) (s_title));
		select_joyfunc ();
		cortina ();
		
		// Empezamos.
		
		sp_UpdateNow();
		unpack ((unsigned int) (s_marco));
		
		playing = 1;
		init_player ();
		init_hotspots ();
		init_cerrojos ();
		
		n_pant = SCR_INICIO;
		maincounter = 0;
		
		draw_scr (n_pant);
		draw_life ();
		draw_objs ();
		draw_keys ();
		
		half_life = 0;
		
		while (playing) {
			maincounter ++;
			half_life = !half_life;
			
			// Mover player
			
			if ( !(player.estado & EST_MUR) )
				move (n_pant);
			else {
				// ?
			}
			
			// Mover enemigos
			
			mueve_bicharracos ();
			
			// Precalc para cálculos (eh?)
			
			x = player.x >> 6;
			y = player.y >> 6;
			
			// Render
			
			sp_MoveSprAbs (sp_player, spritesClip, player.next_frame - player.current_frame, VIEWPORT_Y + (y >> 3), VIEWPORT_X + (x >> 3), x & 7, y & 7);
			player.current_frame = player.next_frame;
			
			for (i = 0; i < 3; i ++) {
				if (malotes [enoffs + i].t != 0) {		// Esto sólo es necesario si hay habitaciones con menos de 3.
					sp_MoveSprAbs (sp_moviles [i], spritesClip, en_an [i].next_frame - en_an [i].current_frame, VIEWPORT_Y + (malotes [enoffs + i].y >> 3), VIEWPORT_X + (malotes [enoffs + i].x >> 3), malotes [enoffs + i].x & 7, malotes [enoffs + i].y & 7);
					en_an [i].current_frame = en_an [i].next_frame;
				}
			}
			
			// Update to screen
			
			sp_UpdateNow();
			
			// Coger objeto
			
			if (x >= hotspot_x - 15 && x <= hotspot_x + 15 && y >= hotspot_y - 15 && y <= hotspot_y + 15) {
				// restauramos el tile de fondo
				draw_coloured_tile (VIEWPORT_X + (hotspot_x >> 3), VIEWPORT_Y + (hotspot_y >> 3), orig_tile);
				// Desactivamos el hotspot:
				hotspot_x = hotspot_y = 240;
				// ¿Sumamos un objeto, una llave, o vida?
				if (hotspots [n_pant].act == 0) {
					player.life += PLAYER_REFILL;
					if (player.life > PLAYER_LIFE)
						player.life = PLAYER_LIFE;
					draw_life ();
					hotspots [n_pant].act = 2;
				} else if (hotspots [n_pant].tipo == 1) {
					player.objs ++;
					draw_objs ();	
					hotspots [n_pant].act = 0;
				} else if (hotspots [n_pant].tipo == 2) {
					player.keys ++;
					draw_keys ();
					hotspots [n_pant].act = 0;
				} 
				// PLOP!!
				peta_el_beeper (0);			
			}
			
			// Comprobaciones
			
			i = (joyfunc) (&keys);
#ifdef PLAYER_AUTO_CHANGE_SCREEN
			if (player.x == 0 && player.vx < 0) {
				n_pant --;
				draw_scr (n_pant);
				player.x = 14336;
			}
			if (player.x == 14336 && player.vx > 0) {
				n_pant ++;
				draw_scr (n_pant);
				player.x = 0;
			}
#else
			if (player.x == 0 && ((i & sp_LEFT) == 0)) {
				n_pant --;
				draw_scr (n_pant);	
				player.x = 14336;
			}
			if (player.x == 14336 && ((i & sp_RIGHT) == 0)) {		// 14336 = 224 * 64
				n_pant ++;
				draw_scr (n_pant);
				player.x = 0;
			}
#endif
			if (player.y == 0 && player.vy < 0 && n_pant >= MAP_W) {
				n_pant -= MAP_W;
				draw_scr (n_pant);
				player.y = 9216;	
			}
			if (player.y == 9216 && player.vy > 0) {				// 9216 = 144 * 64
				n_pant += MAP_W;
				draw_scr (n_pant);
				player.y = 0;
			}
			
			// llegarse al final
			
			if (player.objs == PLAYER_NUM_OBJETOS) {
				success = 0;
				if (n_pant == pant_final) {
					if ((player.x >> 10) == PLAYER_FIN_X && (player.y >> 10) == PLAYER_FIN_Y) 
						success = 1;
				} else if (pant_final == 99) {
					success = 1;
				}
				if (success) {
					cortina ();
					game_ending ();
					playing = 0;
					cortina ();
				}
			}
			
			// game over
			
			if (player.life == 0) {
				
				// ¡Saca a todo el mundo de aquí!
				sp_MoveSprAbs (sp_player, spritesClip, 0, VIEWPORT_Y + 30, VIEWPORT_X + 20, 0, 0);				
				for (i = 0; i < 3; i ++) {
					if (malotes [enoffs + i].t != 0)
						sp_MoveSprAbs (sp_moviles [i], spritesClip, 0, VIEWPORT_Y + 30, VIEWPORT_X + 20, 0, 0);
				}
				
				game_over ();
				playing = 0;
				cortina ();
			}
		}	
	}
}
