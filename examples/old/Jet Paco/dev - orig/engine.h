// Motor.h
// Funciones:

// MOD: smaller bounding box
unsigned char collide (unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
	// Colisión segura y guarra.
	unsigned char l1x, l1y, l2x, l2y;
	l1x = (x1 > 8) ? x1 - 13 : 0;
	l2x = x1 + 8;
	l1y = (y1 > 8) ? y1 - 12 : 0;
	l2y = y1 + 8;
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
	// Estoy llorando 
}

// Game

char espera_activa (int espera) {
	
	// jL
	
	// Esta función espera un rato o hasta que se pulse una tecla.
	// Si se pulsa una tecla, devuelve 0
	
	// Esta función sólo funciona en Spectrum.
	// en CPC no hay una interrupción cada 20ms, asín que esto no
	// sirve "pa ná".
	
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
void clear_cerrojo (unsigned char np, unsigned char x, unsigned char y) {
	unsigned char i;
	
	// search & toggle
		
	for (i = 0; i < MAX_CERROJOS; i ++) 
		if (cerrojos [i].x == x && cerrojos [i].y == y && cerrojos [i].np == np)
			cerrojos [i].st = 0;
}

void init_cerrojos () {
	unsigned char i;
	
	// Activa todos los cerrojos
	
	for (i = 0; i < MAX_CERROJOS; i ++)
		cerrojos [i].st = 1;	
}
#endif

#ifdef PLAYER_CAN_FIRE
void init_bullets () {
	unsigned char i;
	
	// Inicializa las balas
	
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
	
	// Buscamos una bala libre
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
			break;	
		}	
	}	
}
#endif

#ifdef RANDOM_RESPAWN
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
	// Mover
	map_attr [15 * y1 + x1] = 8;
	map_buff [15 * y1 + x1] = 14;
	map_attr [15 * y0 + x0] = 0;
	map_buff [15 * y0 + x0] = 0;
	// Pintar
	draw_coloured_tile (VIEWPORT_X + x0 + x0, VIEWPORT_Y + y0 + y0, 0);
	draw_coloured_tile (VIEWPORT_X + x1 + x1, VIEWPORT_Y + y1 + y1, 14);
	// Sonido
	peta_el_beeper (2);	
}
#endif

// Patched move. 8x8 (+4,+8) bounding box
unsigned char move (unsigned char n_pant) {
	unsigned char xx, yy;
	unsigned char x, y;
	unsigned char i, allpurp, possee, hit;
	int cx, cy;
	
	cx = player.x;
	cy = player.y;

	i = (joyfunc) (&keys); // Leemos del teclado

	/* Por partes. Primero el movimiento vertical. La ecuación de movimien-
	   to viene a ser, en cada ciclo:

	   1.- vy = vy + g
	   2.- y = y + vy

	   O sea la velocidad afectada por la gravedad. 
	   Para no colarnos con los nmeros, ponemos limitadores:
	*/

#ifndef PLAYER_MOGGY_STYLE
	// Si el tipo de movimiento no es MOGGY_STYLE, entonces nos afecta la gravedad.
	if (player.vy < PLAYER_MAX_VY_CAYENDO)
		player.vy += player.g;
	else
		player.vy = PLAYER_MAX_VY_CAYENDO;

	if (player.gotten) player.vy = 0;		
#else
	// Si lo es, entonces el movimiento vertical se comporta exactamente igual que 
	// el horizontal.
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

#ifdef PLAYER_HAS_JETPAC
	if ((i & sp_UP) == 0) {
		player.vy -= PLAYER_INCR_JETPAC;
		if (player.vy < -PLAYER_MAX_VY_JETPAC) player.vy = -PLAYER_MAX_VY_JETPAC;
	}
#endif

	player.y += player.vy;
	
	// Safe
		
	if (player.y < 0)
		player.y = 0;
		
	if (player.y > 9216)
		player.y = 9216;

	
	/* El problema es que no es tan fácil... Hay que ver si no nos chocamos.
	   Si esto pasa, hay que "recular" hasta el borde del obstáculo.

	   Por eso miramos el signo de vy, para que los cálculos sean más sencillos.
	   De paso vamos a precalcular un par de cosas para que esto vaya más rápido.
	*/

	x = player.x >> 6;				// dividimos entre 64 para pixels, y luego entre 16 para tiles.
	y = player.y >> 6;
	xx = x >> 4;
	yy = y >> 4;
	
	// Ya	
	possee = 0;
	hit = 0;
	if (player.vy < 0) { 			// estamos ascendiendo
		if ((y & 15) < 8) {
			if ( ((x & 15) < 12 && attr (xx, yy) > 7) || ((x & 15) > 4 && attr (xx + 1, yy) > 7)) {
				// paramos y ajustamos:
				player.vy = 0;
				player.y = ((yy + 1) << 10) - 512;
			} else if ( ((x & 15) < 12 && attr (xx, yy) == 1) || ((x & 15) > 4 && attr (xx + 1, yy) == 1)) {
				if (player.life > 0 && player.estado == EST_NORMAL) {hit = 1;}
			}
		}
	} else if (player.vy > 0 && (y & 15) < 8) { 	// estamos descendiendo
		if (player.y < 9216)
			if ( ((x & 15) < 12 && attr (xx, yy + 1) > 3) || ((x & 15) > 4 && attr (xx + 1, yy + 1) > 3)) {
				// paramos y ajustamos:
				player.vy = 0;
				player.y = yy << 10;
				possee = 1;
			} else if ( ((x & 15) < 12 && attr (xx, yy + 1) == 1) || ((x & 15) > 4 && attr (xx + 1, yy + 1) == 1)) {
				if (player.life > 0 && player.estado == EST_NORMAL) {hit = 1;}
			}
	}
	
	/* Salto: El salto se reduce a dar un valor negativo a vy. Esta es la forma más
	   sencilla. Sin embargo, para más control, usamos el tipo de salto "mario bros".
	   Para ello, en cada pulsación dejaremos decrementar vy hasta un mínimo, y de-
	   tectando que no se vuelva a pulsar cuando estemos en el aire. Juego de banderas ;)
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

	// ------ ok con el movimiento vertical.

	/* Movimiento horizontal:

	   Mientras se pulse una tecla de dirección, 
	   
	   x = x + vx
	   vx = vx + ax

	   Si no se pulsa nada:

	   x = x + vx
	   vx = vx - rx
	*/

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

	player.x = player.x + player.vx;
	
	// Safe
	
	if (player.x < 0)
		player.x = 0;
		
	if (player.x > 14336)
		player.x = 14336;
		
	/* Ahora, como antes, vemos si nos chocamos con algo, y en ese caso
	   paramos y reculamos */

	y = player.y >> 6;
	x = player.x >> 6;
	yy = y >> 4;
	xx = x >> 4;
	
	if (player.vx < 0 && (x & 15) < 12) {
		if ( ((y & 15) < 8 && attr (xx, yy) > 7) || ((y & 15) != 0 && attr (xx, yy + 1) > 7)) {
			// paramos y ajustamos:
			player.vx = 0;
			player.x = (((xx + 1) << 4) - 4) << 6;
		} else if ( ((y & 15) < 8 && attr (xx, yy) == 1) || ((y & 15) != 0 && attr (xx, yy + 1) == 1)) {
			if (player.life > 0 && player.estado == EST_NORMAL) {hit = 1;}
		}
	} else if ((x & 15) > 4) {
		if ( ((y & 15) < 8 && attr (xx + 1, yy) > 7) || ((y & 15) != 0 && attr (xx + 1, yy + 1) > 7)) {
			// paramos y ajustamos:
			player.vx = 0;
			player.x = ((xx << 4) + 4) << 6;
		} else if ( ((y & 15) < 8 && attr (xx + 1, yy) == 1) || ((y & 15) != 0 && attr (xx + 1, yy + 1) == 1)) {
			if (player.life > 0 && player.estado == EST_NORMAL) {hit = 1;}
		}
	}

#ifdef PLAYER_CAN_FIRE
	// Disparos
#ifdef PLAYER_MOGGY_STYLE
	// TODO
#else
	if ((i & sp_FIRE) == 0 && player.disparando == 0) {
		player.disparando = 1;
		fire_bullet ();
	}
	
	if ((i & sp_FIRE) != 0) 
		player.disparando = 0;
#endif
#endif
	
#ifndef DEACTIVATE_KEYS
	// Abrir cerrojo
	if ((x & 15) == 0 && (y & 15) == 0) {
		if (qtile (xx + 1, yy) == 15 && player.keys > 0) {
			map_attr [15 * yy + xx + 1] = 0;
			map_buff [15 * yy + xx + 1] = 0;
			clear_cerrojo (n_pant, xx + 1, yy);
			draw_coloured_tile (VIEWPORT_X + xx + xx + 2, VIEWPORT_Y + yy + yy, 0);
			player.keys --;
			peta_el_beeper (8);
		} else if (qtile (xx - 1, yy) == 15 && player.keys > 0) {
			map_attr [15 * yy + xx - 1] = 0;
			map_buff [15 * yy + xx - 1] = 0;
			clear_cerrojo (n_pant, xx - 1, yy);
			draw_coloured_tile (VIEWPORT_X + xx + xx - 2, VIEWPORT_Y + yy + yy, 0);
			player.keys --;
			peta_el_beeper (8);
		}
	}
#endif
	
	// Calculamos el frame que hay que poner:
	
#ifdef PLAYER_PUSH_BOXES
	// Empujar cajas (tile #14)
#ifdef PLAYER_MOGGY_STYLE
	if ((i & sp_FIRE) == 0) {
#endif		
		x = player.x >> 6;
		y = player.y >> 6;
		xx = x >> 4;
		yy = y >> 4;
#ifdef PLAYER_AUTO_CHANGE_SCREEN
		// En este caso, las cajas no se pararán automáticamente en los bordes de la 
		// pantalla... Tenemos que comprobar de forma explícita que no se salen:
		
		// En modo plataformas, no se puede empujar verticalmente
#ifdef PLAYER_MOGGY_STYLE
		// Verticalmente, cuando player.y está alineado a tile:
		if ((y & 15) == 0) {
			// Según la tecla que pulse...
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
		// Horizontalmente, cuando player.x esté alineado a tile:
		
		if ((x & 15) == 0) {
			// Según la tecla que pulse...
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

		// En modo plataformas, no se puede empujar verticalmente
#ifdef PLAYER_MOGGY_STYLE
		// Verticalmente, cuando player.y está alineado a tile:
		if ((y & 15) == 0) {
			// Según la tecla que pulse...
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

		// Horizontalmente, cuando player.x esté alineado a tile:
		
		if ((x & 15) == 0) {
			// Según la tecla que pulse...
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

/*
#ifndef DEACTIVATE_EVIL_TILE
	// Tiles que te matan. 
	
	x = player.x >> 6;				// dividimos entre 64 para pixels, y luego entre 16 para tiles.
	y = player.y >> 6;
	xx = x >> 4;
	yy = y >> 4;

	if (attr (xx, yy) == 1 || 
		((x & 15) != 0 && attr (xx + 1, yy) == 1) ||
		((y & 15) != 0 && attr (xx, yy + 1) == 1) ||
		((x & 15) != 0 && (y & 15) != 0 && attr (xx + 1, yy + 1) == 1)) {
#ifdef PLAYER_FLICKERS
		if (player.life > 0 && player.estado == EST_NORMAL) {
			player.estado = EST_PARP;
			player.ct_estado = 50;
#else
		if (player.life > 0) {
#endif		
			peta_el_beeper (4);
			player.life --;	
		}

		player.x = cx;
		player.y = cy;
		player.vy = -player.vy;
		player.vx = -player.vx;

	}
#endif
*/
if (hit) {
	peta_el_beeper (4);
	player.life --;	
	player.estado = EST_PARP; 
	player.ct_estado = 50;
	player.x = cx;
	player.y = cy;
}

#ifndef PLAYER_MOGGY_STYLE
	// En este caso, el spriteset es:
	// 1  2  3  4  5  6  7  8
	// R1 R2 R3 RJ L1 L2 L3 LJ

	//if (player.vy != 0) {
	if (!possee) {
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
	// En este caso, el spriteset es:
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
	// Inicializa player con los valores iniciales
	// (de ahí lo de inicializar).
	
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

void init_hotspots () {
	unsigned char i;
	for (i = 0; i < MAP_W * MAP_H; i ++)
		hotspots [i].act = 1;
}

void draw_scr (unsigned char n_pant) {
	// Desempaqueta y dibuja una pantalla, actualiza el array map_attr
	// y hace algunas otras cosillas más (cambiar sprites de enemigos/plataformas, etc)
	
	unsigned char x = 0, y = 0, i, d, t1, t2;
#ifdef UNPACKED_MAP
	unsigned int idx = n_pant * 150;
#else
	unsigned int idx = n_pant * 75;
#endif
	unsigned char location = 0;
	
#ifdef UNPACKED_MAP
	// Mapa tipo UNPACKED
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
	// Mapa tipo PACKED
	for (i = 0; i < 75; i ++) {
		location = 15 * (y >> 1) + (x >> 1);
		d = mapa [idx++];
		t1 = d >> 4;
		t2 = d & 15;
		map_attr [location] = comportamiento_tiles [t1];
		if ((rand () & 15) < 2 && t1 == 0 && map_buff [location - 16] == 0)
			t1 = 19;
		draw_coloured_tile (VIEWPORT_X + x, VIEWPORT_Y + y, t1);
		map_buff [location] = t1;
		x += 2;
		if (x == 30) {
			x = 0;
			y += 2;
		}
		location ++;
		map_attr [location] = comportamiento_tiles [t2];
		if ((rand () & 15) < 2 && t2 == 0 && map_buff [location - 16] == 0)
			t2 = 19;
		draw_coloured_tile (VIEWPORT_X + x, VIEWPORT_Y + y, t2);
		map_buff [location] = t2;
		x += 2;
		if (x == 30) {
			x = 0;
			y += 2;
		}
	}
#endif	
	// ¿Hay objeto en esta pantalla?
	
	hotspot_x = hotspot_y = 240;
	if (hotspots [n_pant].act == 1) {
		if (hotspots [n_pant].tipo != 0) {
			// Sacamos la posición a nivel de tiles del objeto
			x = (hotspots [n_pant].xy >> 4);
			y = (hotspots [n_pant].xy & 15);
			// Convertimos la posición almacenada en píxels
			hotspot_x = x << 4;
			hotspot_y = y << 4;
			// Guardamos el tile que hay originalmente
			orig_tile = map_buff [15 * y + x];
			// Pintamos el incono del objeto
			draw_coloured_tile (VIEWPORT_X + x + x, VIEWPORT_Y + y + y, 16 + hotspots [n_pant].tipo);
		}
	} else if (hotspots [n_pant].act == 0) {
		// Aleatoriamente, ponemos una recarga de vida si no hay objeto activo.	
		if (rand () % 3 == 2) {
			// Sacamos la posición a nivel de tiles del objeto
			x = (hotspots [n_pant].xy >> 4);
			y = (hotspots [n_pant].xy & 15);
			// Convertimos la posición almacenada en píxels
			hotspot_x = x << 4;
			hotspot_y = y << 4;
			// Guardamos el tile que hay originalmente
			orig_tile = map_buff [15 * y + x];
			// Pintamos el incono del objeto
			draw_coloured_tile (VIEWPORT_X + x + x, VIEWPORT_Y + y + y, 16);	
		}
	}
	
#ifndef DEACTIVATE_KEYS
	// Borramos los cerrojos abiertos
	for (i = 0; i < MAX_CERROJOS; i ++) {
		if (cerrojos [i].np == n_pant && !cerrojos [i].st) {
			draw_coloured_tile (VIEWPORT_X + cerrojos [i].x + cerrojos [i].x, VIEWPORT_Y + cerrojos [i].y + cerrojos [i].y, 0);
			location = 15 * cerrojos [i].y + cerrojos [i].x;
			map_attr [location] = 0;
			map_buff [location] = 0;
		}
	}
#endif
	
	// Movemos y cambiamos a los enemigos según el tipo que tengan
	enoffs = n_pant * 3;
	
	for (i = 0; i < 3; i ++) {
		en_an [i].frame = 0;
		en_an [i].count = 0;
#ifdef RANDOM_RESPAWN
		en_an [i].fanty_activo = 0;
#endif
		switch (malotes [enoffs + i].t) {
			case 0:
				//sp_MoveSprAbs (sp_moviles [i], spritesClip, 0, 22, 0, 0, 0);
				en_an [i].next_frame = sprite_18_a;
				break;
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
#ifdef PLAYER_KILLS_ENEMIES			
			default:
				en_an [i].next_frame = sprite_18_a;
#endif
#ifdef PLAYER_CAN_FIRE
			default:
				en_an [i].next_frame = sprite_18_a;
#endif
		}
	}
	
#ifdef ACTIVATE_SCRIPTING
	// Ejecutamos los scripts de entrar en pantalla:
	script = e_scripts [MAP_W * MAP_H + 1];
	run_script ();
	script = e_scripts [n_pant];
	run_script ();
#endif

#ifdef PLAYER_CAN_FIRE
		init_bullets ();
#endif	
}

// Esto se emplea en el menú
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

void mueve_bicharracos (unsigned char n_pant) {
	// Vamos a mover un frame todos los bicharracos activos.
	
	unsigned char i, j, enoffsmasi, x, y, xx, yy;
	unsigned char cx, cy;
	unsigned char ccx, ccy;
	// Para que si hay dos enemigos que lo toquen en el mismo frame, sólo uno actúe
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
			// Colisiones:
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
			ccx = malotes [enoffsmasi].x;
			ccy = malotes [enoffsmasi].y;
#endif
			
#ifndef PLAYER_MOGGY_STYLE	
			if (malotes [enoffsmasi].t == 4) {
				// Arrastrar plataforma:
				xx = player.x >> 10;
				// Vertical
				if (malotes [enoffsmasi].my < 0) {
					// Subir.
					if (x >= ccx - 15 && x <= ccx + 15 && y >= ccy - 16 && y <= ccy - 11 && player.vy >= -(PLAYER_INCR_SALTO)) {
						player.gotten = 1;
						player.y = (ccy - 16) << 6;
						player.vy = 0;						
						yy = player.y >> 10;
						// No nos estaremos metiendo en un tile ¿no?
						if (player.y > 1024)
							if (attr (xx, yy) > 7 || ((x & 15) != 0 && attr (xx + 1, yy) > 7)) {
								// ajustamos:
								player.y = (yy + 1) << 10;
							}
					}
				} else if (malotes [enoffsmasi].my > 0) {
					// bajar
					if (x >= ccx - 15 && x <= ccx + 15 && y >= ccy - 20 && y <= ccy - 14 && player.vy >= 0) {
						player.gotten = 1;
						player.y = (ccy - 16) << 6;
						player.vy = 0;
						yy = player.y >> 10;
						// No nos estaremos metiendo en un tile ¿no?
						if (player.y < 9216)
							if (attr (xx, yy + 1) > 7 || ((x & 15) != 0 && attr (xx + 1, yy + 1) > 7)) {
								// ajustamos:
								player.y = yy << 10;
							}
					}
				}
				y = player.y >> 6;
				yy = player.y >> 10;
				// Horizontal
				if (malotes [enoffsmasi].mx != 0 && x >= ccx - 15 && x <= ccx + 15 && y >= ccy - 16 && y <= ccy - 8 && player.vy >= 0) {
					player.gotten = 1;
					player.y = (ccy - 16) << 6;
					yy = player.y >> 10;
					x = x + malotes [enoffsmasi].mx;
					player.x = x << 6;
					xx = player.x >> 10;
					if (malotes [enoffsmasi].mx < 0) {
						if (attr (xx, yy) > 7 || ((y & 15) != 0 && attr (xx, yy + 1) > 7)) {
							// paramos y ajustamos:
							player.vx = 0;
							player.x = (xx + 1) << 10;
						}
					} else if (malotes [enoffsmasi].mx > 0) {
						if (attr (xx + 1, yy) > 7 || ((y & 15) != 0 && attr (xx + 1, yy + 1) > 7)) {
							// paramos y ajustamos:
							player.vx = 0;
							player.x = xx << 10;
						}
					}					
				}
			// Colisión matadora
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
				if (y < ccy - 2 && player.vy >= 0 && malotes [enoffsmasi].t >= PLAYER_MIN_KILLABLE) {
					// matar enemigo:
					en_an [i].next_frame = sprite_17_a;
					sp_MoveSprAbs (sp_moviles [i], spritesClip, en_an [i].next_frame - en_an [i].current_frame, VIEWPORT_Y + (malotes [enoffs + i].y >> 3), VIEWPORT_X + (malotes [enoffs + i].x >> 3), malotes [enoffs + i].x & 7, malotes [enoffs + i].y & 7);
					en_an [i].current_frame = en_an [i].next_frame;
					sp_UpdateNow ();
					peta_el_beeper (5);
					en_an [i].next_frame = sprite_18_a;
					malotes [enoffsmasi].t |= 16;			// Marcamos como "estoy muelto"
					// Contamos un enemigo muerto más
					player.killed ++;
#ifdef ACTIVATE_SCRIPTING					
					// Vemos si hay algún script por ejecutar
					script = f_scripts [n_pant];
					run_script ();
					// Modificación *********
					script = e_scripts [MAP_W * MAP_H + 1];
					run_script ();
#endif
				} else if (player.life > 0) {
#else
				if (player.life > 0) {
#endif
					tocado = 1;
					peta_el_beeper (4);
					player.life --;	
#ifdef PLAYER_BOUNCES
#ifndef PLAYER_MOGGY_STYLE	

#ifdef RANDOM_RESPAWN
					if (!en_an [i].fanty_activo) {
						// Repulsión: Empuja en la dirección mx, my del movimiento del malote
						// incrementando vy con PLAYER_MAX_VX con el signo correcto.
						if (malotes [enoffsmasi].mx > 0) player.vx = PLAYER_MAX_VX;
						if (malotes [enoffsmasi].mx < 0) player.vx = -PLAYER_MAX_VX;
						if (malotes [enoffsmasi].my > 0) player.vy = PLAYER_MAX_VX;
						if (malotes [enoffsmasi].my < 0) player.vy = -PLAYER_MAX_VX;
					} else {
						player.vx = en_an [i].vx + en_an [i].vx;
						player.vy = en_an [i].vy + en_an [i].vy;
					}
#else
					// Repulsión: Empuja en la dirección mx, my del movimiento del malote
					// incrementando vy con PLAYER_MAX_VX con el signo correcto.
					if (malotes [enoffsmasi].mx > 0) player.vx = (PLAYER_MAX_VX + PLAYER_MAX_VX);
					if (malotes [enoffsmasi].mx < 0) player.vx = -(PLAYER_MAX_VX + PLAYER_MAX_VX);
					if (malotes [enoffsmasi].my > 0) player.vy = (PLAYER_MAX_VX + PLAYER_MAX_VX);
					if (malotes [enoffsmasi].my < 0) player.vy = -(PLAYER_MAX_VX + PLAYER_MAX_VX);
#endif
#else
					// Vamos a empujar al player en el sentido de la diagonal que los une, con la
					// dirección que los haga separarse, con 2*v del enemigo
					
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
					// El jugador parpadeará durante unos momentos
					// y será invulnerable mientras tanto.
					player.estado = EST_PARP;
					player.ct_estado = 50;
#endif
				}
			}
			
			// Límites de trayectoria.
			
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
				if (ccx == malotes [enoffsmasi].x1 || ccx == malotes [enoffsmasi].x2)
					malotes [enoffsmasi].mx = -malotes [enoffsmasi].mx;
				if (ccy == malotes [enoffsmasi].y1 || ccy == malotes [enoffsmasi].y2)
					malotes [enoffsmasi].my = -malotes [enoffsmasi].my;
#ifdef RANDOM_RESPAWN
			}
#endif
							
#ifdef PLAYER_CAN_FIRE
			// Colisión con balas
#ifdef RANDOM_RESPAWN
			if (malotes [enoffsmasi].t < 16 || en_an [i].fanty_activo == 1) {
#else
			if (malotes [enoffsmasi].t < 16) {
#endif
				for (j = 0; j < MAX_BULLETS; j ++) {		
					if (bullets [j].estado == 1) {
						if (bullets [j].y >= ccy - 4 && bullets [j].y <= ccy + 12 && bullets [j].x >= ccx - 4 && bullets [j].x <= ccx + 12) {
#ifdef RANDOM_RESPAWN		
							if (en_an [i].fanty_activo) 
								en_an [i].vx += (bullets [i].mx > 0 ? 128 : -128);
#endif
							en_an [i].next_frame = sprite_17_a;
							en_an [i].morido = 1;
							bullets [j].estado = 0;
							if (malotes [enoffsmasi].t != 4)
								malotes [enoffsmasi].life --;
							if (malotes [enoffsmasi].life == 0) {
								// matar enemigo:
								sp_MoveSprAbs (sp_moviles [i], spritesClip, en_an [i].next_frame - en_an [i].current_frame, VIEWPORT_Y + (ccy >> 3), VIEWPORT_X + (ccx >> 3), ccx & 7, ccy & 7);
								en_an [i].current_frame = en_an [i].next_frame;
								sp_UpdateNow ();
								peta_el_beeper (5);
								en_an [i].next_frame = sprite_18_a;
								malotes [enoffsmasi].t |= 16;			// Marcamos como "estoy muelto"
								// Contamos un enemigo muerto más
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
			// Activar fanty

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
