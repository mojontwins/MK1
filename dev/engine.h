// Churrera Engine
// ===============
// Copyleft 2010, 2011 by The Mojon Twins

// engine.h
// Cointains engine functions (movement, colliding, rendering... )

unsigned char collide (unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
	// Secure and dirty box collision.
	unsigned char l1x, l1y, l2x, l2y;
	l1x = (x1 > 13) ? x1 - 13 : 0;
	l2x = x1 + 13;
	l1y = (y1 > 13) ? y1 - 13 : 0;
	l2y = y1 + 13;
	return (x2 >= l1x && x2 <= l2x && y2 >= l1y && y2 <= l2y);
}

void srand (unsigned int new_seed) {
	seed [0] = new_seed;	
}

unsigned char rand () {
	unsigned char res;
	
	#asm
	.rand16
		ld	hl, _seed
		ld	a, (hl)
		ld	e, a
		inc	hl
		ld	a, (hl)
		ld	d, a
		
		;; Ahora DE = [SEED]
					
		ld	a,	d
		ld	h,	e
		ld	l,	253
		or	a
		sbc	hl,	de
		sbc	a, 	0
		sbc	hl,	de
		ld	d, 	0
		sbc	a, 	d
		ld	e,	a
		sbc	hl,	de
		jr	nc,	nextrand
		inc	hl
	.nextrand
		ld	d,	h
		ld	e,	l
		ld	hl, _seed
		ld	a,	e
		ld	(hl), a
		inc	hl
		ld	a,	d
		ld	(hl), a
		
		;; Ahora [SEED] = HL
	
		ld 	hl, _asm_int
		ld	a,	e	
		ld	(hl), a
		inc	hl
		ld	a,	d
		ld	(hl), a
		
		;; Ahora [ASM_INT] = HL
	#endasm
	
	res = asm_int [0];

	return res;
}

unsigned int abs (int n) {
	if (n < 0)
		return (unsigned int) (-n);
	else 
		return (unsigned int) n;
}
	

void step () {
	#asm
		ld a, 16
		out (254), a
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		xor 16
		out (254), a
	#endasm	
}

void cortina () {
	#asm
		;; Antes que nada vamos a limpiar el PAPER de toda la pantalla
		;; para que no queden artefactos feos
		
		ld	de, 22528			; Apuntamos con DE a la zona de atributos
		ld	b,	3				; Procesamos 3 tercios
	.clearb1
		push bc
		
		ld	b, 255				; Procesamos los 256 atributos de cada tercio
	.clearb2
	
		ld	a, (de)				; Nos traemos un atributo
		and	199					; Le hacemos la máscara 11000111 y dejamos PAPER a 0
		ld	(de), a				; Y lo volvemos a poner
		
		inc de					; Siguiente atributo
	
		djnz clearb2
		
		pop bc
		djnz clearb1
		
		;; Y ahora el código original que escribí para UWOL:	
	
		ld	a,	8
	
	.repitatodo
		ld	c,	a			; Salvamos el contador de "repitatodo" en 'c'
	
		ld	hl, 16384
		ld	a,	12
	
	.bucle
		ld	b,	a			; Salvamos el contador de "bucle" en 'b'
		ld	a,	255
	
	.bucle1
		sla (hl)
		inc hl
		dec a
		jr	nz, bucle1
			
		ld	a,	255
	.bucle2
		srl (hl)
		inc hl
		dec a
		jr	nz, bucle2
			
		ld	a,	b			; Restituimos el contador de "bucle" a 'a'
		dec a
		jr	nz, bucle
	
		ld	a,	c			; Restituimos el contador de "repitatodo" a 'a'
		dec a
		jr	nz, repitatodo
	#endasm
}

// Game

char espera_activa (int espera) {
	// Waits until "espera" halts have passed 
	// or a key has been pressed.
	
	char res = 1;
	int i;
	int j;
	
	for (i = 0; i < espera && res; i ++) {
		for (j = 0; j < 250; j ++) {
			res = 1;
		}
		if (sp_GetKey ()) 
			res = 0;
	}
	
	return res;
}

void game_ending () {
	unsigned char x;
	
	sp_UpdateNow();
	unpack ((unsigned int) (s_ending));
	
	for (x = 0; x < 4; x ++) {
		peta_el_beeper (7);
		peta_el_beeper (2);
	}
	peta_el_beeper (9);
	
	espera_activa (500);
}

void game_over () {
	unsigned char x, y;
	for (y = 11; y < 14; y ++)
		for (x = 10; x < 22; x ++)
			sp_PrintAtInv (y, x, 95, 0);
			
	sp_PrintAtInv (12, 11, 95, 39);
	sp_PrintAtInv (12, 12, 95, 33);
	sp_PrintAtInv (12, 13, 95, 45);
	sp_PrintAtInv (12, 14, 95, 37);
	sp_PrintAtInv (12, 16, 95, 47);
	sp_PrintAtInv (12, 17, 95, 54);
	sp_PrintAtInv (12, 18, 95, 37);
	sp_PrintAtInv (12, 19, 95, 50);
	sp_PrintAtInv (12, 20, 95, 1);

	sp_UpdateNow ();
		
	for (x = 0; x < 4; x ++) {
		peta_el_beeper (7);
		peta_el_beeper (2);
	}
	peta_el_beeper (9);
	
	espera_activa (500);
}

#ifndef DEACTIVATE_KEYS
void clear_cerrojo (unsigned char x, unsigned char y) {
	unsigned char i;
	
	// search & toggle
		
	for (i = 0; i < MAX_CERROJOS; i ++) 
		if (cerrojos [i].x == x && cerrojos [i].y == y && cerrojos [i].np == n_pant)
			cerrojos [i].st = 0;
}

void init_cerrojos () {
	unsigned char i;
	
	// Activate all bolts.
	
	for (i = 0; i < MAX_CERROJOS; i ++)
		cerrojos [i].st = 1;	
}
#endif

#ifdef PLAYER_CAN_FIRE
void init_bullets () {
	unsigned char i;
	
	// Initialize bullets
	
	for (i = 0; i < MAX_BULLETS; i ++) 
		bullets [i].estado = 0;
}
#endif

#if defined(PLAYER_KILLS_ENEMIES) || defined (PLAYER_CAN_FIRE)
void init_malotes () {
	unsigned char i;
	
	for (i = 0; i < MAP_W * MAP_H * 3; i ++) {
		malotes [i].t = malotes [i].t & 15;	
#ifdef PLAYER_CAN_FIRE
		malotes [i].life = ENEMIES_LIFE_GAUGE;
#ifdef RANDOM_RESPAWN
		if (malotes [i].t == 5)
			malotes [i].t |= 16;
#endif
#endif
	}
}
#endif

#ifdef PLAYER_CAN_FIRE
void fire_bullet () {
	unsigned char i;
	
	// Search a free bullet slot...
	
	for (i = 0; i < MAX_BULLETS; i ++) {
		if (bullets [i].estado == 0) {
			bullets [i].estado = 1;
			if (player.facing == 0) {
				bullets [i].x = (player.x >> 6) - 4;
				bullets [i].mx = -PLAYER_BULLET_SPEED;
			} else {
				bullets [i].x = (player.x >> 6) + 12;
				bullets [i].mx = PLAYER_BULLET_SPEED;
			}
			bullets [i].y = (player.y >> 6) + PLAYER_BULLET_Y_OFFSET;
			peta_el_beeper (6);
#ifdef FIRING_DRAINS_LIFE
			if (player.life > FIRING_DRAIN_AMOUNT) {
				player.life -= FIRING_DRAIN_AMOUNT;
			} else {
				player.life = 0;
			}
#endif				
			break;	
		}	
	}	
}
#endif

#if defined(RANDOM_RESPAWN) || defined(USE_TYPE_6)
char player_hidden () {
	unsigned char x, y, xx, yy;
	x = player.x >> 6;
	y = player.y >> 6;
	xx = x >> 4;
	yy = y >> 4;
	if ( (y & 15) == 0 && player.vx == 0 )
		if (attr (xx, yy) == 2 || (attr (1 + xx, yy) == 2 && (x & 15) != 0) )	
			return 1;
		
	
	return 0;
}
#endif

#ifdef PLAYER_PUSH_BOXES
void move_tile (unsigned char x0, unsigned char y0, unsigned char x1, unsigned char y1) {
	// Move the tile
	map_attr [15 * y1 + x1] = 8;
	map_buff [15 * y1 + x1] = 14;
	map_attr [15 * y0 + x0] = 0;
	map_buff [15 * y0 + x0] = 0;
	// Draw
	draw_coloured_tile (VIEWPORT_X + x0 + x0, VIEWPORT_Y + y0 + y0, 0);
	draw_coloured_tile (VIEWPORT_X + x1 + x1, VIEWPORT_Y + y1 + y1, 14);
	// Sound
	peta_el_beeper (2);	
}
#endif

unsigned char move () {
	unsigned char xx, yy;
	unsigned char x, y;
	unsigned char i, allpurp;
	int cx, cy;
	
	cx = player.x;
	cy = player.y;

	// Read device (keyboard, joystick ...)
	i = (joyfunc) (&keys); 

	/* Vertical movement. The ecuations used are:

	   1.- vy = vy + g
	   2.- y = y + vy

	*/

#ifdef PLAYER_NO_INERTIA

	if ((i & sp_UP) == 0) player.vy = -PLAYER_CONST_V;
	if ((i & sp_DOWN) == 0) player.vy = PLAYER_CONST_V;
	if ( ! ((i & sp_UP) == 0 || (i & sp_DOWN) == 0)) player.vy = 0;

#else
	
#ifndef PLAYER_MOGGY_STYLE
	// If side view, get affected by gravity:
	
	if (player.vy < PLAYER_MAX_VY_CAYENDO)
		player.vy += player.g;
	else
		player.vy = PLAYER_MAX_VY_CAYENDO;

	if (player.gotten) player.vy = 0;		
#else
	// If top-down view, vertical movement = horizontal movement.
	
	if ( ! ((i & sp_UP) == 0 || (i & sp_DOWN) == 0))
		if (player.vy > 0) {
			player.vy -= player.rx;
			if (player.vy < 0)
				player.vy = 0;
		} else if (player.vy < 0) {
			player.vy += player.rx;
			if (player.vy > 0)
				player.vy = 0;
		}

	if ((i & sp_UP) == 0)
		if (player.vy > -PLAYER_MAX_VX) {
			player.vy -= player.ax;
		}

	if ((i & sp_DOWN) == 0)
		if (player.vy < PLAYER_MAX_VX) {
			player.vy += player.ax;
		}
#endif
#endif	
	if (player.estado & EST_DIZZY) { player.vy >>= 1; player.vy += (rand () & (PLAYER_CONST_V - 1)) - (PLAYER_CONST_V >> 1); }

	player.y += player.vy;

	// Safe
		
	if (player.y < 0)
		player.y = 0;
		
	if (player.y > 9216)
		player.y = 9216;

	
	/* 
		Check for collisions with obstacles. If so, we have to move
		back until the edge of the tile.
	*/

	x = player.x >> 6;				// Divide / 64 for pixels, then / 16 for tiles.
	y = player.y >> 6;
	xx = x >> 4;
	yy = y >> 4;
	
	// Cool

	if (player.vy < 0) { 			// Going up
		//if (player.y >= 1024)
			if (attr (xx, yy) > 7 || ((x & 15) != 0 && attr (xx + 1, yy) > 7)) {
				// Stop and adjust.
				player.vy = 0;
				player.y = (yy + 1) << 10;
			}
	} else if (player.vy > 0 && (y & 15) < 8) { 	// Going down
		if (player.y < 9216)
			if (attr (xx, yy + 1) > 3 || ((x & 15) != 0 && attr (xx + 1, yy + 1) > 3))
			{
				// Stop and adjust.
				player.vy = 0;
				player.y = yy << 10;
			}
	}

	/* Jump: Jumping is as easy as giving vy a negative value. Nevertheless, we want
	   a somewhat more controllable jump, so we use the "mario bros" kind of controls:
	   the longer you press jump, the higher you reach.
	*/

#ifdef PLAYER_HAS_JUMP
#ifdef PLAYER_CAN_FIRE
	if (((i & sp_UP) == 0) && ((player.vy == 0 && player.saltando == 0 && (attr (xx, yy + 1) > 3 || ((x & 15) != 0 && attr (xx + 1, yy + 1) > 3))) || player.gotten)) {
		player.saltando = 1;
		player.cont_salto = 0;
		peta_el_beeper (3);
	}

	if ( ((i & sp_UP) == 0) && player.saltando ) {
		player.vy -= (player.salto + PLAYER_INCR_SALTO - (player.cont_salto>>1));
		if (player.vy < -PLAYER_MAX_VY_SALTANDO) player.vy = -PLAYER_MAX_VY_SALTANDO;
		player.cont_salto ++;
		if (player.cont_salto == 8)
			player.saltando = 0;
	}
	
	if ((i & sp_UP) != 0)
		player.saltando = 0;
#else
	if (((i & sp_FIRE) == 0) && ((player.vy == 0 && player.saltando == 0 && (attr (xx, yy + 1) > 3 || ((x & 15) != 0 && attr (xx + 1, yy + 1) > 3))) || player.gotten)) {
		player.saltando = 1;
		player.cont_salto = 0;
		peta_el_beeper (3);
	}

	if ( ((i & sp_FIRE) == 0) && player.saltando ) {
		player.vy -= (player.salto + PLAYER_INCR_SALTO - (player.cont_salto>>1));
		if (player.vy < -PLAYER_MAX_VY_SALTANDO) player.vy = -PLAYER_MAX_VY_SALTANDO;
		player.cont_salto ++;
		if (player.cont_salto == 8)
			player.saltando = 0;
	}
	
	if ((i & sp_FIRE) != 0)
		player.saltando = 0;
#endif
#endif

#ifdef PLAYER_HAS_JETPAC
	if ((i & sp_UP) == 0) {
		player.vy -= PLAYER_INCR_JETPAC;
		if (player.vy < -PLAYER_MAX_VY_JETPAC) player.vy = -PLAYER_MAX_VY_JETPAC;
#ifdef JETPAC_DRAINS_LIFE
		jetpac_frame_counter ++;
		if (jetpac_frame_counter == JETPAC_DRAIN_OFFSET + JETPAC_DRAIN_RATIO) {
			jetpac_frame_counter = JETPAC_DRAIN_OFFSET;
			player.life --;
		}
#endif
	} else {
		jetpac_frame_counter = 0;
	}
#endif

	// Done with vertical movement.

	/* Horizontal movement. Equations are:

	   Direction key pressed:
	   
	   x = x + vx
	   vx = vx + ax

	   Direction key not pressed:

	   x = x + vx
	   vx = vx - rx
	*/
#ifdef PLAYER_NO_INERTIA
	if ((i & sp_LEFT) == 0) player.vx = -PLAYER_CONST_V;
	if ((i & sp_RIGHT) == 0) player.vx = PLAYER_CONST_V;
	if ( ! ((i & sp_LEFT) == 0 || (i & sp_RIGHT) == 0)) player.vx = 0;
#else
	if ( ! ((i & sp_LEFT) == 0 || (i & sp_RIGHT) == 0))
		if (player.vx > 0) {
			player.vx -= player.rx;
			if (player.vx < 0)
				player.vx = 0;
		} else if (player.vx < 0) {
			player.vx += player.rx;
			if (player.vx > 0)
				player.vx = 0;
		}

	if ((i & sp_LEFT) == 0)
		if (player.vx > -PLAYER_MAX_VX) {
			player.facing = 0;
			player.vx -= player.ax;
		}

	if ((i & sp_RIGHT) == 0)
		if (player.vx < PLAYER_MAX_VX) {
			player.vx += player.ax;
			player.facing = 1;
		}
#endif
	if (player.estado & EST_DIZZY) { player.vx >>= 1; player.vx += (rand () & (PLAYER_CONST_V - 1)) - (PLAYER_CONST_V >> 1); }

	player.x += player.vx;
	
	// Safe
	
	if (player.x < 0)
		player.x = 0;
		
	if (player.x > 14336)
		player.x = 14336;

	
	y = player.y >> 6;
	x = player.x >> 6;
	yy = y >> 4;
	xx = x >> 4;
	
	if (player.vx < 0) {
		if (attr (xx, yy) > 7 || ((y & 15) != 0 && attr (xx, yy + 1) > 7)) {
			// Stop and adjust
			player.vx = 0;
			player.x = (xx + 1) << 10;
		}
	} else {
		if (attr (xx + 1, yy) > 7 || ((y & 15) != 0 && attr (xx + 1, yy + 1) > 7)) {
			// Stop and adjust
			player.vx = 0;
			player.x = xx << 10;
		}
	}
	
	// Shooting engine:
	
#ifdef PLAYER_CAN_FIRE
#ifdef PLAYER_MOGGY_STYLE
	// TODO. Not implemented yet. 
#else
	if ((i & sp_FIRE) == 0 && player.disparando == 0) {
		player.disparando = 1;
		fire_bullet ();
	}
	
	if ((i & sp_FIRE) != 0) 
		player.disparando = 0;
#endif
#endif
	
	// Keys / bolts engine:

#ifndef DEACTIVATE_KEYS
	if ((x & 15) == 0 && (y & 15) == 0) {
		if (qtile (xx + 1, yy) == 15 && player.keys > 0) {
			map_attr [15 * yy + xx + 1] = 0;
			map_buff [15 * yy + xx + 1] = 0;
			clear_cerrojo (xx + 1, yy);
			draw_coloured_tile (VIEWPORT_X + xx + xx + 2, VIEWPORT_Y + yy + yy, 0);
			player.keys --;
			peta_el_beeper (8);
		} else if (qtile (xx - 1, yy) == 15 && player.keys > 0) {
			map_attr [15 * yy + xx - 1] = 0;
			map_buff [15 * yy + xx - 1] = 0;
			clear_cerrojo (xx - 1, yy);
			draw_coloured_tile (VIEWPORT_X + xx + xx - 2, VIEWPORT_Y + yy + yy, 0);
			player.keys --;
			peta_el_beeper (8);
		}
	}
#endif
	
	// Pushing boxes (tile #14) engine

#ifdef PLAYER_PUSH_BOXES
#ifdef PLAYER_MOGGY_STYLE
	if ((i & sp_FIRE) == 0) {
#endif		
		x = player.x >> 6;
		y = player.y >> 6;
		xx = x >> 4;
		yy = y >> 4;
#ifdef PLAYER_AUTO_CHANGE_SCREEN
		// In this case, there's nothing in the screen boundaries which will stop
		// the boxes from getting out of the screen, so we have to explicitly 
		// make sure that this won't happen.
		
		// In side-view mode, you can't push boxes vertically.
#ifdef PLAYER_MOGGY_STYLE
		// Vertically, only when player.y is tile-aligned.
		if ((y & 15) == 0) {
			if ((i & sp_UP) == 0 && yy > 1) {
				if (qtile (xx, yy - 1) == 14 && attr (xx, yy - 2) == 0) {				
					move_tile (xx, yy - 1, xx, yy - 2);
				}
				if ((x & 15) != 0) {
					if (qtile (xx + 1, yy - 1) == 14 && attr (xx + 1, yy - 2) == 0) {
						move_tile (xx + 1, yy - 1, xx + 1, yy - 2);
					}
				}
			} else if ((i & sp_DOWN) == 0 && yy < 8) {
				if (qtile (xx, yy + 1) == 14 && attr (xx, yy + 2) == 0) {
					move_tile (xx, yy + 1, xx, yy + 2);
				}
				if ((x & 15) != 0) {
					if (qtile (xx + 1, yy + 1) == 14 && attr (xx + 1, yy + 2) == 0) {
						move_tile (xx + 1, yy + 1, xx + 1, yy + 2);
					}	
				}
			}
		}
#endif

		// Horizontally, only when player.x is tile-aligned.
		if ((x & 15) == 0) {
			if ((i & sp_RIGHT) == 0 && xx < 14) {
				if (qtile (xx + 1, yy) == 14 && attr (xx + 2, yy) == 0) {
					move_tile (xx + 1, yy, xx + 2, yy);
				}
				if ((y & 15) != 0) {
					if (qtile (xx + 1, yy + 1) == 14 && attr (xx + 2, yy + 1) == 0) {
						move_tile (xx + 1, yy + 1, xx + 2, yy + 1);
					}
				}
			} else if ((i & sp_LEFT) == 0 && xx > 1) {
				if (qtile (xx - 1, yy) == 14 && attr (xx - 2, yy) == 0) {
					move_tile (xx - 1, yy, xx - 2, yy);
				}
				if ((y & 15) != 0) {
					if (qtile (xx - 1, yy + 1) == 14 && attr (xx - 2, yy + 1) == 0) {
						move_tile (xx - 1, yy + 1, xx - 2, yy + 1);
					}
				}
			}	
		}			
#else

		// In side-view mode, you can't push boxes vertically.
#ifdef PLAYER_MOGGY_STYLE
		// Vertically, only when player.y is tile-aligned.
		if ((y & 15) == 0) {
			if ((i & sp_UP) == 0) {
				if (qtile (xx, yy - 1) == 14 && attr (xx, yy - 2) == 0) {				
					move_tile (xx, yy - 1, xx, yy - 2);
				}
				if ((x & 15) != 0) {
					if (qtile (xx + 1, yy - 1) == 14 && attr (xx + 1, yy - 2) == 0) {
						move_tile (xx + 1, yy - 1, xx + 1, yy - 2);
					}
				}
			} else if ((i & sp_DOWN) == 0) {
				if (qtile (xx, yy + 1) == 14 && attr (xx, yy + 2) == 0) {
					move_tile (xx, yy + 1, xx, yy + 2);
				}
				if ((x & 15) != 0) {
					if (qtile (xx + 1, yy + 1) == 14 && attr (xx + 1, yy + 2) == 0) {
						move_tile (xx + 1, yy + 1, xx + 1, yy + 2);
					}	
				}
			}
		}
#endif

		// Horizontally, only when player.x is tile-aligned.
		if ((x & 15) == 0) {
			if ((i & sp_RIGHT) == 0) {
				if (qtile (xx + 1, yy) == 14 && attr (xx + 2, yy) == 0) {
					move_tile (xx + 1, yy, xx + 2, yy);
				}
				if ((y & 15) != 0) {
					if (qtile (xx + 1, yy + 1) == 14 && attr (xx + 2, yy + 1) == 0) {
						move_tile (xx + 1, yy + 1, xx + 2, yy + 1);
					}
				}
			} else if ((i & sp_LEFT) == 0) {
				if (qtile (xx - 1, yy) == 14 && attr (xx - 2, yy) == 0) {
					move_tile (xx - 1, yy, xx - 2, yy);
				}
				if ((y & 15) != 0) {
					if (qtile (xx - 1, yy + 1) == 14 && attr (xx - 2, yy + 1) == 0) {
						move_tile (xx - 1, yy + 1, xx - 2, yy + 1);
					}
				}
			}	
		}	
#endif
#ifdef PLAYER_MOGGY_STYLE
	}	
#endif
#endif

	// Evil tile engine

#ifndef DEACTIVATE_EVIL_TILE	
	x = player.x >> 6;
	y = player.y >> 6;
	xx = x >> 4;
	yy = y >> 4;

	if (attr (xx, yy) == 1 || 
		((x & 15) != 0 && attr (xx + 1, yy) == 1) ||
		((y & 15) != 0 && attr (xx, yy + 1) == 1) ||
		((x & 15) != 0 && (y & 15) != 0 && attr (xx + 1, yy + 1) == 1)) {
		if (player.life > 0) {
			peta_el_beeper (4);
			player.life --;	
			player.x = cx;
			player.y = cy;
			player.vy = -player.vy;
			player.vx = -player.vx;
		}
	}
#endif

	// Select next frame to paint...

#ifndef PLAYER_MOGGY_STYLE
	// In this case, the spriteset is:
	// 1  2  3  4  5  6  7  8
	// R1 R2 R3 RJ L1 L2 L3 LJ

	if (player.vy != 0) {
		if (player.facing == 0)
			player.next_frame = sprite_8_a;
		else
			player.next_frame = sprite_4_a;
	} else {
		if (player.vx == 0) {
			if (player.facing == 0)
#ifdef PLAYER_ALTERNATE_ANIMATION
				player.next_frame = sprite_5_a;
#else
				player.next_frame = sprite_6_a;
#endif
			else
#ifdef PLAYER_ALTERNATE_ANIMATION
				player.next_frame = sprite_1_a;
#else
				player.next_frame = sprite_2_a;
#endif
		} else {
			player.subframe ++;
			if (player.subframe == 4) {
				player.subframe = 0;
#ifdef PLAYER_ALTERNATE_ANIMATION
				player.frame ++;
				if (player.frame == 3) 
					player.frame = 0;
#else
				player.frame = (player.frame + 1) & 3;
#endif
				step ();
			}
			
#ifdef PLAYER_ALTERNATE_ANIMATION
			if (player.facing == 0) {
				if (player.frame == 0)
					player.next_frame = sprite_5_a;
				else if (player.frame == 1)
					player.next_frame = sprite_6_a;
				else if (player.frame == 2)
					player.next_frame = sprite_7_a;
			} else {
				if (player.frame == 0)
					player.next_frame = sprite_1_a;
				else if (player.frame == 1)
					player.next_frame = sprite_2_a;
				else if (player.frame == 2)
					player.next_frame = sprite_3_a;	
			}
#else			

			if (player.facing == 0) {
				if (player.frame == 1 || player.frame == 3)
					player.next_frame = sprite_6_a;
				else if (player.frame == 0)
					player.next_frame = sprite_5_a;
				else if (player.frame == 2)
					player.next_frame = sprite_7_a;
			} else {
				if (player.frame == 1 || player.frame == 3)
					player.next_frame = sprite_2_a;
				else if (player.frame == 0)
					player.next_frame = sprite_1_a;
				else if (player.frame == 2)
					player.next_frame = sprite_3_a;
			}
#endif
		}	
	}
#else
	// In this case, the spriteset is
	// 1  2  3  4  5  6  7  8
	// R1 R2 L1 L2 U1 U2 D1 D2
	
	if (player.vx != 0 || player.vy != 0) {
		player.subframe ++;
		if (player.subframe == 4) {
			player.subframe = 0;
			player.frame = !player.frame;
			step (); 
		}
	}
	
	if (player.vx > 0) {
		if (player.frame)
			player.next_frame = sprite_1_a;
		else	
			player.next_frame = sprite_2_a;
	} else if (player.vx < 0) {
		if (player.frame)
			player.next_frame = sprite_3_a;
		else
			player.next_frame = sprite_4_a;
	} else {
		if (player.vy < 0) {
			if (player.frame)
				player.next_frame = sprite_5_a;
			else
				player.next_frame = sprite_6_a;
		} else {
			if (player.frame)
				player.next_frame = sprite_7_a;
			else
				player.next_frame = sprite_8_a;
		}
	}
#endif
}

void init_player () {
	// Initialize player with initial values.
	// (hence the initialize thing)
	
	player.x = 			PLAYER_INI_X << 10;
	player.y = 			PLAYER_INI_Y << 10;
	player.vy = 		0;
	player.g = 			PLAYER_G; 
	player.vx = 		0;
	player.ax = 		PLAYER_AX;
	player.rx = 		PLAYER_RX;
	player.salto = 		PLAYER_VY_INICIAL_SALTO;
	player.cont_salto = 1;
	player.saltando = 	0;
	player.frame = 		0;
	player.subframe = 	0;
	player.facing = 	1;
	player.estado = 	EST_NORMAL;
	player.ct_estado = 	0;
	player.life = 		PLAYER_LIFE;
	player.objs =		0;
	player.keys = 		0;
	player.killed = 	0;
	player.disparando = 0;
	
	pant_final = SCR_FIN;
}

#if defined(DEACTIVATE_KEYS) && defined(DEACTIVATE_OBJECTS)
#else
void init_hotspots () {
	unsigned char i;
	for (i = 0; i < MAP_W * MAP_H; i ++)
		hotspots [i].act = 1;
}
#endif

void delete_text () {
	unsigned char i;
	for (i = 0; i < 32 - LINE_OF_TEXT_SUBSTR; i ++)
		sp_PrintAtInv (LINE_OF_TEXT, LINE_OF_TEXT_X + i, 71, 0);
}

void draw_scr () {

	// This function draws and sets up current screen.
		
	unsigned char x = 0, y = 0, i, d, t1, t2;
#ifdef UNPACKED_MAP
	unsigned int idx = n_pant * 150;
#else
	unsigned int idx = n_pant * 75;
#endif
	unsigned char location = 0;
	
	f_zone_ac = 0;
	
#ifdef UNPACKED_MAP
	// UNPACKED map, every byte represents one tile.
	for (i = 0; i < 150; i ++) {
		d = mapa [idx++];
		map_attr [location] = comportamiento_tiles [d];
		map_buff [location] = d;
		draw_coloured_tile (VIEWPORT_X + x, VIEWPORT_Y + y, d);
		location ++;
		x += 2;
		if (x == 30) {
			x = 0;
			y += 2;
		}
	}
#else
	// PACKED map, every byte contains two tiles, plus admits
	// some special effects (autoshadows, see below).
	for (i = 0; i < 75; i ++) {
		location = 15 * (y >> 1) + (x >> 1);
		d = mapa [idx++];
		t1 = d >> 4;
		t2 = d & 15;
		map_attr [location] = comportamiento_tiles [t1];
#ifndef NO_ALT_BG
		if ((rand () & 15) < 2 && t1 == 0 && map_buff [location - 16] == 0)
			t1 = 19;
#endif
		draw_coloured_tile (VIEWPORT_X + x, VIEWPORT_Y + y, t1);
		map_buff [location] = t1;
		x += 2;
		if (x == 30) {
			x = 0;
			y += 2;
		}
		location ++;
		map_attr [location] = comportamiento_tiles [t2];
#ifndef NO_ALT_BG
		if ((rand () & 15) < 2 && t2 == 0 && map_buff [location - 16] == 0)
			t2 = 19;
#endif
		draw_coloured_tile (VIEWPORT_X + x, VIEWPORT_Y + y, t2);
		map_buff [location] = t2;
		x += 2;
		if (x == 30) {
			x = 0;
			y += 2;
		}
	}
#endif	

#if defined(DEACTIVATE_KEYS) && defined(DEACTIVATE_OBJECTS)
#else
	// Is there an object in this screen?
	
	hotspot_x = hotspot_y = 240;
	if (hotspots [n_pant].act == 1) {
#if defined(ACTIVATE_SCRIPTING) && defined(OBJECTS_ON_VAR)
		if (flags [OBJECTS_ON_VAR] == 1) {
#endif
			if (hotspots [n_pant].tipo != 0) {
				// Calculate tile coordinates
				x = (hotspots [n_pant].xy >> 4);
				y = (hotspots [n_pant].xy & 15);
				// Convert to pixels and store
				hotspot_x = x << 4;
				hotspot_y = y << 4;
				// Remember which tile was there
				orig_tile = map_buff [15 * y + x];
				// Draw the object.
				draw_coloured_tile (VIEWPORT_X + x + x, VIEWPORT_Y + y + y, 16 + hotspots [n_pant].tipo);
			}
#if defined(ACTIVATE_SCRIPTING) && defined(OBJECTS_ON_VAR)
		}
#endif
	}
#ifndef DEACTIVATE_REFILLS
	else if (hotspots [n_pant].act == 0) {
		// Randomly, if there's no active object, we draw a recharge.
		if (rand () % 3 == 2) {
			x = (hotspots [n_pant].xy >> 4);
			y = (hotspots [n_pant].xy & 15);
			hotspot_x = x << 4;
			hotspot_y = y << 4;
			orig_tile = map_buff [15 * y + x];
			draw_coloured_tile (VIEWPORT_X + x + x, VIEWPORT_Y + y + y, 16);	
		}
	}
#endif
#endif
	
#ifndef DEACTIVATE_KEYS
	// Is there a bolt which has been already opened in this screen?
	// If so, delete it:
	for (i = 0; i < MAX_CERROJOS; i ++) {
		if (cerrojos [i].np == n_pant && !cerrojos [i].st) {
			draw_coloured_tile (VIEWPORT_X + cerrojos [i].x + cerrojos [i].x, VIEWPORT_Y + cerrojos [i].y + cerrojos [i].y, 0);
			location = 15 * cerrojos [i].y + cerrojos [i].x;
			map_attr [location] = 0;
			map_buff [location] = 0;
		}
	}
#endif
	
	// Set up enemies.
	
	enoffs = n_pant * 3;
	
	for (i = 0; i < 3; i ++) {
		en_an [i].frame = 0;
		en_an [i].count = 0;
#ifdef RANDOM_RESPAWN
		en_an [i].fanty_activo = 0;
#endif
		switch (malotes [enoffs + i].t) {
#ifdef NO_MAX_ENEMS
			case 0:
				en_an [i].next_frame = sprite_18_a;
				break;
#endif
			case 1:
				en_an [i].next_frame = sprite_9_a;
				break;
			case 2:
				en_an [i].next_frame = sprite_11_a;
				break;
			case 3:
				en_an [i].next_frame = sprite_13_a;
				break;
			case 4:
				en_an [i].next_frame = sprite_15_a;
				break;
#ifdef USE_TYPE_6
			case 6:
				en_an [i].next_frame = sprite_13_a;
				en_an [i].x = malotes [enoffs + i].x << 6;
				en_an [i].y = malotes [enoffs + i].y << 6;
				en_an [i].vx = en_an [i].vy = 0;
				en_an [i].state = TYPE_6_IDLE;
#endif
#if defined (PLAYER_KILLS_ENEMIES) || defined (PLAYER_CAN_FIRE)			
			default:
				en_an [i].next_frame = sprite_18_a;
#endif
		}
	}
	
#ifdef ACTIVATE_SCRIPTING
	// Delete line of text
	delete_text ();
	// Run "ENTERING ANY" script (if available)
	script = e_scripts [MAP_W * MAP_H + 1];
	run_script ();
	// Run "ENTERING" script for THIS screen (if available)
	script = e_scripts [n_pant];
	run_script ();
#endif

#ifdef PLAYER_CAN_FIRE
		init_bullets ();
#endif	
}

// This function is called from the menu and
// sets up the controlling scheme depending on
// which key is pressed:

// 1 KEYS
// 2 KEMPSTON
// 3 SINCLAIR

void select_joyfunc () {
	unsigned int key_1, key_2, key_3;
	unsigned char terminado = 0;

	key_1 = sp_LookupKey('1');
	key_2 = sp_LookupKey('2');
	key_3 = sp_LookupKey('3');
	
	#asm
		; Music generated by beepola
		call musicstart
	#endasm
	
	while (!terminado) {
		
		if (sp_KeyPressed (key_1)) {
			terminado = 1;
			joyfunc = sp_JoyKeyboard;
		} else if (sp_KeyPressed (key_2)) {
			terminado = 1;
			joyfunc = sp_JoyKempston;
		} else if (sp_KeyPressed (key_3)) {
			terminado = 1;
			joyfunc = sp_JoySinclair1;
		}			
	}
	#asm
		di
	#endasm
}

#ifdef PLAYER_CAN_FIRE
void mueve_bullets () {
	unsigned char i;
	unsigned char j;
#ifdef PLAYER_MOGGY_STYLE
	// TODO
#else	
	for (i = 0; i < MAX_BULLETS; i ++) {
		bullets [i].x += bullets [i].mx;
		if (attr (bullets [i].x >> 4, bullets [i].y >> 4) > 7) {
			bullets [i].estado = 0;
		}
		if (bullets [i].x < 8 || bullets [i].x > 240)
			bullets [i].estado = 0;
	}	
#endif
}
#endif	

unsigned char distance (unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
	// return abs (x2 - x1 + y2 - y1);
	// Better version:
	unsigned char dx = abs (x2 - x1);
	unsigned char dy = abs (y2 - y1);
	unsigned char mn = dx < dy ? dx : dy;
	return (dx + dy - (mn >> 1) - (mn >> 2) + (mn >> 4));
}

void mueve_bicharracos () {
	// This function moves the active enemies.
	
	unsigned char i, j, enoffsmasi, x, y, xx, yy;
	unsigned char cx, cy;
	unsigned char ccx, ccy;
	// Only one enemy may hurt the player at once, so we need this flag:
	unsigned char tocado = 0; 		

	player.gotten = 0;
	
	for (i = 0; i < 3; i ++) {
		enoffsmasi = enoffs + i;
		if (malotes [enoffsmasi].t != 0) {
			cx = malotes [enoffsmasi].x;
			cy = malotes [enoffsmasi].y;
#ifdef RANDOM_RESPAWN
			if (!en_an [i].fanty_activo) {
				malotes [enoffsmasi].x += malotes [enoffsmasi].mx;
				malotes [enoffsmasi].y += malotes [enoffsmasi].my;
			}
#else
			malotes [enoffsmasi].x += malotes [enoffsmasi].mx;
			malotes [enoffsmasi].y += malotes [enoffsmasi].my;
#endif

#ifdef PLAYER_PUSH_BOXES			
			// Check for collisions.
			x = malotes [enoffsmasi].x >> 4;
			y = malotes [enoffsmasi].y >> 4;

			if (malotes [enoffsmasi].mx != 0) {
				if (attr (x + ctileoff (malotes [enoffsmasi].mx), y) > 7 || 
				((malotes [enoffsmasi].y & 15) != 0 && attr (x + ctileoff (malotes [enoffsmasi].mx), y + 1) > 7)) {
					malotes [enoffsmasi].mx = -malotes [enoffsmasi].mx;
					malotes [enoffsmasi].x = cx;
				}
			}
			if (malotes [enoffsmasi].my != 0) {
				if (attr (x, y + ctileoff (malotes [enoffsmasi].my)) > 7 || 
				((malotes [enoffsmasi].x & 15) != 0 && attr (x + 1, y + ctileoff (malotes [enoffsmasi].mx)) > 7)) {
					malotes [enoffsmasi].my = -malotes [enoffsmasi].my;
					malotes [enoffsmasi].y = cy;
				}
			}
#endif

			en_an [i].count ++; 
			if (en_an [i].count == 4) {
				en_an [i].count = 0;
				en_an [i].frame = !en_an [i].frame;

				switch (malotes [enoffsmasi].t) {
					case 1:
						en_an [i].next_frame = en_an [i].frame ? sprite_9_a : sprite_10_a;
						break;
					case 2:
						en_an [i].next_frame = en_an [i].frame ? sprite_11_a : sprite_12_a;
						break;
					case 3:
					case 6:
						en_an [i].next_frame = en_an [i].frame ? sprite_13_a : sprite_14_a;
						break;
					case 4:
						en_an [i].next_frame = en_an [i].frame ? sprite_15_a : sprite_16_a;
#ifdef RANDOM_RESPAWN
						break;
					default:
						if (en_an [i].fanty_activo)
							en_an [i].next_frame = en_an [i].frame ? sprite_13_a : sprite_14_a;
#endif					
				}	
			}

			x = player.x >> 6;
			y = player.y >> 6;
			
#ifdef RANDOM_RESPAWN
			if (en_an [i].fanty_activo) {
				ccx = en_an [i].x >> 6;
				ccy = en_an [i].y >> 6;
			} else {
				ccx = malotes [enoffsmasi].x;
				ccy = malotes [enoffsmasi].y;
			}
#else
#ifdef USE_TYPE_6
			if (malotes [enoffsmasi].t == 6) {
				ccx = en_an [i].x >> 6;
				ccy = en_an [i].y >> 6;
			} else {
				ccx = malotes [enoffsmasi].x;
				ccy = malotes [enoffsmasi].y;
			}
#else
			ccx = malotes [enoffsmasi].x;
			ccy = malotes [enoffsmasi].y;
#endif
#endif
			
			// Moving platforms engine:

#ifndef PLAYER_MOGGY_STYLE	
			if (malotes [enoffsmasi].t == 4) {
				xx = player.x >> 10;
				// Vertical
				if (malotes [enoffsmasi].my < 0) {
					// Go up.
					if (x >= ccx - 15 && x <= ccx + 15 && y >= ccy - 16 && y <= ccy - 11 && player.vy >= -(PLAYER_INCR_SALTO)) {
						player.gotten = 1;
						player.y = (ccy - 16) << 6;
						player.vy = 0;						
						yy = player.y >> 10;
						// Collide?
						if (player.y > 1024)
							if (attr (xx, yy) > 7 || ((x & 15) != 0 && attr (xx + 1, yy) > 7)) {
								// ajust:
								player.y = (yy + 1) << 10;
							}
					}
				} else if (malotes [enoffsmasi].my > 0) {
					// Go down.
					if (x >= ccx - 15 && x <= ccx + 15 && y >= ccy - 20 && y <= ccy - 14 && player.vy >= 0) {
						player.gotten = 1;
						player.y = (ccy - 16) << 6;
						player.vy = 0;
						yy = player.y >> 10;
						// Collide?
						if (player.y < 9216)
							if (attr (xx, yy + 1) > 7 || ((x & 15) != 0 && attr (xx + 1, yy + 1) > 7)) {
								// ajust:
								player.y = yy << 10;
							}
					}
				}
				y = player.y >> 6;
				yy = player.y >> 10;
				// Horizontal
				if (malotes [enoffsmasi].mx != 0 && x >= ccx - 15 && x <= ccx + 15 && y >= ccy - 16 && y <= ccy - 11 && player.vy >= 0) {
					player.gotten = 1;
					player.y = (ccy - 16) << 6;
					yy = player.y >> 10;
					x = x + malotes [enoffsmasi].mx;
					player.x = x << 6;
					xx = player.x >> 10;
					if (malotes [enoffsmasi].mx < 0) {
						if (attr (xx, yy) > 7 || ((y & 15) != 0 && attr (xx, yy + 1) > 7)) {
							player.vx = 0;
							player.x = (xx + 1) << 10;
						}
					} else if (malotes [enoffsmasi].mx > 0) {
						if (attr (xx + 1, yy) > 7 || ((y & 15) != 0 && attr (xx + 1, yy + 1) > 7)) {
							player.vx = 0;
							player.x = xx << 10;
						}
					}					
				}
				
			// Collision with enemy
			
#ifdef RANDOM_RESPAWN
			} else if (!tocado && collide (x, y, ccx, ccy) && (malotes [enoffsmasi].t < 16 || en_an [i].fanty_activo == 1) && player.estado == EST_NORMAL) {
#else
			} else if (!tocado && collide (x, y, ccx, ccy) && malotes [enoffsmasi].t < 16 && player.estado == EST_NORMAL) {
#endif
#else
#ifdef RANDOM_RESPAWN
			if (!tocado && collide (x, y, ccx, ccy) && (malotes [enoffsmasi].t < 16 || en_an [i].fanty_activo == 1) && player.estado == EST_NORMAL) {
#else
			if (!tocado && collide (x, y, ccx, ccy) && malotes [enoffsmasi].t < 16 && player.estado == EST_NORMAL) {
#endif
#endif			

#ifdef PLAYER_KILLS_ENEMIES
				if (y < ccy - 8 && player.vy > 0 && malotes [enoffsmasi].t >= PLAYER_MIN_KILLABLE) {
					// Step on enemy and kill it.
					en_an [i].next_frame = sprite_17_a;
					sp_MoveSprAbs (sp_moviles [i], spritesClip, en_an [i].next_frame - en_an [i].current_frame, VIEWPORT_Y + (malotes [enoffs + i].y >> 3), VIEWPORT_X + (malotes [enoffs + i].x >> 3), malotes [enoffs + i].x & 7, malotes [enoffs + i].y & 7);
					en_an [i].current_frame = en_an [i].next_frame;
					sp_UpdateNow ();
					peta_el_beeper (5);
					en_an [i].next_frame = sprite_18_a;
					malotes [enoffsmasi].t |= 16;			// Marked as "dead"
					// Count it
					player.killed ++;
#ifdef ACTIVATE_SCRIPTING					
					// Run script?
					script = f_scripts [n_pant];
					run_script ();
#endif
				} else if (player.life > 0) {
#else
				if (player.life > 0) {
#endif
					tocado = 1;
					peta_el_beeper (4);
					
					// We decide which kind of life drain we do:
#if defined(RANDOM_RESPAWN) || defined(USE_TYPE_6)
					if (malotes [enoffsmasi].t > 4) {
						if (player.life > FLYING_ENEMY_HIT) 
							player.life -= FLYING_ENEMY_HIT;
						else
							player.life = 0;
					} else {
#endif
						if (player.life > LINEAR_ENEMY_HIT) 
							player.life -= LINEAR_ENEMY_HIT;
						else
							player.life = 0;
#if defined(RANDOM_RESPAWN) || defined (USE_TYPE_6)
					}
#endif
					
#ifdef PLAYER_BOUNCES
#ifndef PLAYER_MOGGY_STYLE	
#if defined(RANDOM_RESPAWN) || defined(USE_TYPE_6)
					if (!en_an [i].fanty_activo) {
						// Bouncing!
						if (malotes [enoffsmasi].mx > 0) player.vx = PLAYER_MAX_VX;
						if (malotes [enoffsmasi].mx < 0) player.vx = -PLAYER_MAX_VX;
						if (malotes [enoffsmasi].my > 0) player.vy = PLAYER_MAX_VX;
						if (malotes [enoffsmasi].my < 0) player.vy = -PLAYER_MAX_VX;
					} else {
						player.vx = en_an [i].vx + en_an [i].vx;
						player.vy = en_an [i].vy + en_an [i].vy;
					}
#else
					// Bouncing!
					if (malotes [enoffsmasi].mx > 0) player.vx = (PLAYER_MAX_VX + PLAYER_MAX_VX);
					if (malotes [enoffsmasi].mx < 0) player.vx = -(PLAYER_MAX_VX + PLAYER_MAX_VX);
					if (malotes [enoffsmasi].my > 0) player.vy = (PLAYER_MAX_VX + PLAYER_MAX_VX);
					if (malotes [enoffsmasi].my < 0) player.vy = -(PLAYER_MAX_VX + PLAYER_MAX_VX);
#endif
#else
					// Bouncing:
					
					// x
					if (malotes [enoffsmasi].mx != 0) {
						if (x < ccx) {
							player.vx = - (abs (malotes [enoffsmasi].mx + malotes [enoffsmasi].mx) << 7);
						} else {
							player.vx = abs (malotes [enoffsmasi].mx + malotes [enoffsmasi].mx) << 7;
						}
					}
					
					// y
					if (malotes [enoffsmasi].my != 0) {
						if (y < ccy) {
							player.vy = - (abs (malotes [enoffsmasi].my + malotes [enoffsmasi].my) << 7);
						} else {
							player.vy = abs (malotes [enoffsmasi].my + malotes [enoffsmasi].my) << 7;
						}
					}
#endif
#endif

#ifdef PLAYER_FLICKERS
					// Flickers. People seem to like this more than the bouncing behaviour.
					player.estado = EST_PARP;
					player.ct_estado = 50;
#endif
				}
			}
			
			// Trajectory limits for linear enemies
			
#ifdef RANDOM_RESPAWN
			if (en_an [i].fanty_activo) {
				
				if (player_hidden ()) {
					if (player.x < en_an [i].x && en_an [i].vx < FANTY_MAX_V)
						en_an [i].vx += FANTY_A >> 1;
					else if (player.x > en_an [i].x && en_an [i].vx > -FANTY_MAX_V)
						en_an [i].vx -= FANTY_A >> 1;
					if (player.y < en_an [i].y && en_an [i].vy < FANTY_MAX_V)
						en_an [i].vy += FANTY_A >> 1;
					else if (player.y > en_an [i].y && en_an [i].vy > -FANTY_MAX_V)
						en_an [i].vy -= FANTY_A >> 1;
				} else if ((rand () & 7) > 1) {
					if (player.x > en_an [i].x && en_an [i].vx < FANTY_MAX_V)
						en_an [i].vx += FANTY_A;
					else if (player.x < en_an [i].x && en_an [i].vx > -FANTY_MAX_V)
						en_an [i].vx -= FANTY_A;
					if (player.y > en_an [i].y && en_an [i].vy < FANTY_MAX_V)
						en_an [i].vy += FANTY_A;
					else if (player.y < en_an [i].y && en_an [i].vy > -FANTY_MAX_V)
						en_an [i].vy -= FANTY_A;
				}
								
				en_an [i].x += en_an [i].vx;
				en_an [i].y += en_an [i].vy;
				if (en_an [i].x > 15360) en_an [i].x = 15360;
				if (en_an [i].x < -1024) en_an [i].x = -1024;
				if (en_an [i].y > 10240) en_an [i].y = 10240;
				if (en_an [i].y < -1024) en_an [i].y = -1024;
			} else {
#endif
#ifdef USE_TYPE_6
			if (malotes [enoffsmasi].t == 6) {
				switch (en_an [i].state) {
					case TYPE_6_IDLE:
						if (distance (ccx, ccy, x, y) <= SIGHT_DISTANCE && !player_hidden ()) 
							en_an [i].state = TYPE_6_PURSUING;
						break;
					case TYPE_6_PURSUING:
						if ((rand () & 7) > 1) {
							if (player.x > en_an [i].x && en_an [i].vx < FANTY_MAX_V)
								en_an [i].vx += FANTY_A;
							else if (player.x < en_an [i].x && en_an [i].vx > -FANTY_MAX_V)
								en_an [i].vx -= FANTY_A;
							if (player.y > en_an [i].y && en_an [i].vy < FANTY_MAX_V)
								en_an [i].vy += FANTY_A;
							else if (player.y < en_an [i].y && en_an [i].vy > -FANTY_MAX_V)
								en_an [i].vy -= FANTY_A;
						}
						if (distance (ccx, ccy, x, y) >= SIGHT_DISTANCE || player_hidden ()) 
							en_an [i].state = TYPE_6_RETREATING;
						break;
					case TYPE_6_RETREATING:
						if ((malotes [enoffsmasi].x << 6) > en_an [i].x && en_an [i].vx < FANTY_MAX_V)
							en_an [i].vx += FANTY_A;
						else if ((malotes [enoffsmasi].x << 6) < en_an [i].x && en_an [i].vx > -FANTY_MAX_V)
							en_an [i].vx -= FANTY_A;
						if ((malotes [enoffsmasi].y << 6) > en_an [i].y && en_an [i].vy < FANTY_MAX_V)
							en_an [i].vy += FANTY_A;
						else if ((malotes [enoffsmasi].y << 6) < en_an [i].y && en_an [i].vy > -FANTY_MAX_V)
							en_an [i].vy -= FANTY_A;
						if (distance (ccx, ccy, x, y) <= SIGHT_DISTANCE && !player_hidden ()) 
							en_an [i].state = TYPE_6_PURSUING;
						break;	
				}
				en_an [i].x += en_an [i].vx;
				en_an [i].y += en_an [i].vy;
				if (en_an [i].x > 15360) en_an [i].x = 15360;
				if (en_an [i].x < -1024) en_an [i].x = -1024;
				if (en_an [i].y > 10240) en_an [i].y = 10240;
				if (en_an [i].y < -1024) en_an [i].y = -1024;
			} else {
#endif
				if (ccx == malotes [enoffsmasi].x1 || ccx == malotes [enoffsmasi].x2)
					malotes [enoffsmasi].mx = -malotes [enoffsmasi].mx;
				if (ccy == malotes [enoffsmasi].y1 || ccy == malotes [enoffsmasi].y2)
					malotes [enoffsmasi].my = -malotes [enoffsmasi].my;
#if defined(RANDOM_RESPAWN) || defined(USE_TYPE_6)
			}
#endif
							
#ifdef PLAYER_CAN_FIRE
			// Collision with bullets
#ifdef RANDOM_RESPAWN
			if (malotes [enoffsmasi].t < 16 || en_an [i].fanty_activo == 1) {
#else
			if (malotes [enoffsmasi].t < 16) {
#endif
				for (j = 0; j < MAX_BULLETS; j ++) {		
					if (bullets [j].estado == 1) {
						if (bullets [j].y >= ccy - 4 && bullets [j].y <= ccy + 12 && bullets [j].x >= ccx - 4 && bullets [j].x <= ccx + 12) {
#if defined (RANDOM_RESPAWN) || defined (USE_TYPE_6)	
#ifdef RANDOM_RESPAWN	
							if (en_an [i].fanty_activo) 
#else
							if (malotes [enoffsmasi].t == 6)
#endif
								en_an [i].vx += (bullets [i].mx > 0 ? 128 : -128);
#endif
							en_an [i].next_frame = sprite_17_a;
							en_an [i].morido = 1;
							bullets [j].estado = 0;
							if (malotes [enoffsmasi].t != 4)
								malotes [enoffsmasi].life --;
							if (malotes [enoffsmasi].life == 0) {
								// Kill enemy
								sp_MoveSprAbs (sp_moviles [i], spritesClip, en_an [i].next_frame - en_an [i].current_frame, VIEWPORT_Y + (ccy >> 3), VIEWPORT_X + (ccx >> 3), ccx & 7, ccy & 7);
								en_an [i].current_frame = en_an [i].next_frame;
								sp_UpdateNow ();
								peta_el_beeper (5);
								en_an [i].next_frame = sprite_18_a;
								malotes [enoffsmasi].t |= 16;			// dead
								// Count
								player.killed ++;
#ifdef RANDOM_RESPAWN								
								en_an [i].fanty_activo = 0;
								malotes [enoffsmasi].life = FANTIES_LIFE_GAUGE;
#endif
							}
						}
					}
				}
			}
#endif

#ifdef RANDOM_RESPAWN
			// Activate fanty

			if (malotes [enoffsmasi].t > 15 && en_an [i].fanty_activo == 0 && (rand () & 31) == 1) {
				en_an [i].fanty_activo = 1;
				if (player.y > 5120)
					en_an [i].y = -1024;
				else
					en_an [i].y = 10240;
				en_an [i].x = (rand () % 240 - 8) << 6;
				en_an [i].vx = en_an [i].vy = 0;
			}
#endif

		}
	}
}
