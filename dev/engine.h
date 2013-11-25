// Motor.h
#ifndef PLAYER_MIN_KILLABLE
#define PLAYER_MIN_KILLABLE 0
#endif

#ifdef PLAYER_MOGGY_STYLE
// right: 0 + frame
// left: 2 + frame
// up: 4 + frame
// down: 6 + frame
unsigned char *player_frames [] = {
	sprite_1_a, sprite_2_a, sprite_3_a, sprite_4_a,
	sprite_5_a, sprite_6_a, sprite_7_a, sprite_8_a
};
#else
#ifdef PLAYER_BOOTEE
// vy = 0: 0 + facing
// vy < 0: 1 + facing
// vy > 0: 2 + facing
unsigned char *player_frames [] = {
	sprite_5_a, sprite_6_a, sprite_7_a, sprite_8_a,
	sprite_1_a, sprite_2_a, sprite_3_a, sprite_4_a
};
#else
#ifdef PLAYER_ALTERNATE_ANIMATION
// Alternate animation:
// 0 1 2 + facing = walk, 0 = stand, 3 = jump/fall
unsigned char *player_frames [] = {
	sprite_5_a, sprite_6_a, sprite_7_a, sprite_8_a,
	sprite_1_a, sprite_2_a, sprite_3_a, sprite_4_a
};
#else
// Normal animation:
// 0 1 2 3 + facing: walk, 1 = stand. 8 + facing = jump/fall
unsigned char *player_frames [] = {
	sprite_5_a, sprite_6_a, sprite_7_a, sprite_6_a,
	sprite_1_a, sprite_2_a, sprite_3_a, sprite_2_a,
	sprite_8_a, sprite_4_a
};
#endif
#endif
#endif
unsigned char *enem_frames [] = {
	sprite_9_a, sprite_10_a, sprite_11_a, sprite_12_a, 
	sprite_13_a, sprite_14_a, sprite_15_a, sprite_16_a
};

// Funciones:

#ifdef COMPRESSED_LEVELS
void prepare_level (unsigned char level) {
	unpack ((unsigned int) levelset [level].leveldata_c, MAP_DATA);
	unpack ((unsigned int) levelset [level].tileset_c, (unsigned int) (tileset));
	unpack ((unsigned int) levelset [level].spriteset_c, (unsigned int) (sprite_1_a - 16));
	n_pant = levelset [level].ini_pant;
	player.x = levelset [level].ini_x << 10;
	player.y = levelset [level].ini_y << 10;
	n_bolts = *((unsigned char *) (NBOLTS_PEEK));
}
#endif

void init_player () {
	// Inicializa player con los valores iniciales
	// (de ahí lo de inicializar).
	
#ifndef COMPRESSED_LEVELS
	player.x = 			PLAYER_INI_X << 10;
	player.y = 			PLAYER_INI_Y << 10;
#endif	
	player.vy = 		0;
	player.vx = 		0;
	player.cont_salto = 1;
	player.saltando = 	0;
	player.frame = 		0;
	player.subframe = 	0;
#ifdef PLAYER_MOGGY_STYLE
	player.facing = FACING_DOWN;
	player.facing_v = player.facing_h = 0xff;
#else
	player.facing = 	1;
#endif	
	player.estado = 	EST_NORMAL;
	player.ct_estado = 	0;
#if !defined(COMPRESSED_LEVELS) || defined(REFILL_ME)	
	player.life = 		PLAYER_LIFE;
#endif
	player.objs =		0;
	player.keys = 		0;
	player.killed = 	0;
	player.disparando = 0;
	
	pant_final = SCR_FIN;
}

unsigned char collide (unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
	// Colisión segura y guarra.
	unsigned char l1x, l1y, l2x, l2y;
#ifdef SMALL_COLLISION
	l1x = (x1 > 8) ? x1 - 8 : 0;
	l2x = x1 + 8;
	l1y = (y1 > 8) ? y1 - 8 : 0;
	l2y = y1 + 8;
#else
	l1x = (x1 > 13) ? x1 - 13 : 0;
	l2x = x1 + 13;
	l1y = (y1 > 12) ? y1 - 12 : 0;
	l2y = y1 + 12;
#endif
	return (x2 >= l1x && x2 <= l2x && y2 >= l1y && y2 <= l2y);
}

void srand (unsigned int new_seed) {
	seed [0] = new_seed;	
}

unsigned char rand (void) {
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
	

void step (void) {
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

void cortina (void) {
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
	char res = 1;
	int i;
	int j;
	
	for (i = 0; i < espera && res; i ++) {
		for (j = 0; j < 250; j ++) { res = 1; }
		if (sp_GetKey ()) res = 0;
	}
	
	return res;
}

void game_ending (void) {
	unsigned char x;
	
	sp_UpdateNow();
	blackout ();
	unpack ((unsigned int) (s_ending), 16384);
	
	for (x = 0; x < 4; x ++) {
		peta_el_beeper (7);
		peta_el_beeper (2);
	}
	peta_el_beeper (9);
	
	espera_activa (500);
}

void game_over (void) {
	unsigned char x, y;

	print_str (10, 11, 79, "            ");
	print_str (10, 12, 79, " GAME OVER! ");
	print_str (10, 13, 79, "            ");
	sp_UpdateNow ();
		
	for (x = 0; x < 4; x ++) {
		peta_el_beeper (7);
		peta_el_beeper (2);
	}
	peta_el_beeper (9);
	
	espera_activa (500);
}

signed int addsign (signed int n, signed int value) {
	return (n == 0 ? 0 : (n < 0 ? -value : value));
}

unsigned char ctileoff (char n) {
	return (n > 0 ? 1 : 0);
}

// Engine globals (for speed) & size!
unsigned char gpx, gpy, gpd, gpc, gpt;
unsigned char gpxx, gpyy, gpcx, gpcy;
unsigned char possee, hit_v, hit_h, hit, wall;
unsigned char gpen_x, gpen_y, gpen_cx, gpen_cy, gpen_xx, gpen_yy, gpaux;
unsigned char tocado, active;
unsigned char gpit, gpjt;
unsigned char enoffsmasi;
unsigned char *map_pointer;

#ifndef COMPRESSED_LEVELS
#ifndef DEACTIVATE_KEYS
void init_cerrojos (void) {
	// Activa todos los cerrojos	
	for (gpit = 0; gpit < MAX_CERROJOS; gpit ++)
		cerrojos [gpit].st = 1;	
}
#endif
#endif

#ifdef PLAYER_CAN_FIRE
void init_bullets (void) {
	// Inicializa las balas
	for (gpit = 0; gpit < MAX_BULLETS; gpit ++) 
		bullets [gpit].estado = 0;
}
#endif

#if defined(PLAYER_KILLS_ENEMIES) || defined (PLAYER_CAN_FIRE)
void init_malotes (void) {
	for (gpit = 0; gpit < MAP_W * MAP_H * 3; gpit ++) {
		malotes [gpit].t = malotes [gpit].t & 15;	
#ifdef PLAYER_CAN_FIRE
		malotes [gpit].life = ENEMIES_LIFE_GAUGE;
#ifdef ENABLE_RANDOM_RESPAWN
		if (malotes [gpit].t == 5)
			malotes [gpit].t |= 16;
#endif
#endif
	}
}
#endif

#ifndef COMPRESSED_LEVELS
void init_hotspots (void) {
	unsigned char gpit;
	for (gpit = 0; gpit < MAP_W * MAP_H; gpit ++)
		hotspots [gpit].act = 1;
}
#endif

#ifdef PLAYER_CAN_FIRE
void fire_bullet (void) {
	// Buscamos una bala libre
	for (gpit = 0; gpit < MAX_BULLETS; gpit ++) {
		if (bullets [gpit].estado == 0) {
			bullets [gpit].estado = 1;
#ifdef PLAYER_MOGGY_STYLE
			switch (player.facing) {
				case FACING_LEFT:
					bullets [gpit].x = (player.x >> 6) - 4;
					bullets [gpit].mx = -PLAYER_BULLET_SPEED;
					bullets [gpit].y = (player.y >> 6) + PLAYER_BULLET_Y_OFFSET;
					bullets [gpit].my = 0;
					break;	
				case FACING_RIGHT:
					bullets [gpit].x = (player.x >> 6) + 12;
					bullets [gpit].mx = PLAYER_BULLET_SPEED;
					bullets [gpit].y = (player.y >> 6) + PLAYER_BULLET_Y_OFFSET;
					bullets [gpit].my = 0;
					break;
				case FACING_DOWN:
					bullets [gpit].x = (player.x >> 6) + PLAYER_BULLET_X_OFFSET;
					bullets [gpit].y = (player.y >> 6) + 12;
					bullets [gpit].my = PLAYER_BULLET_SPEED;
					bullets [gpit].mx = 0;
					break;
				case FACING_UP:
					bullets [gpit].x = (player.x >> 6) + 8 - PLAYER_BULLET_X_OFFSET;
					bullets [gpit].y = (player.y >> 6) - 4;
					bullets [gpit].my = -PLAYER_BULLET_SPEED;
					bullets [gpit].mx = 0;
					break;
			}
#else			
			if (player.facing == 0) {
				bullets [gpit].x = (player.x >> 6) - 4;
				bullets [gpit].mx = -PLAYER_BULLET_SPEED;
			} else {
				bullets [gpit].x = (player.x >> 6) + 12;
				bullets [gpit].mx = PLAYER_BULLET_SPEED;
			}
			bullets [gpit].y = (player.y >> 6) + PLAYER_BULLET_Y_OFFSET;
			bullets [gpit].my = 0;
#endif
			peta_el_beeper (6);
			break;	
		}	
	}	
}
#endif

#ifdef ENABLE_RANDOM_RESPAWN
char player_hidden (void) {
	gpxx = gpx >> 4;
	gpyy = gpy >> 4;
	if ( (gpy & 15) == 0 && player.vx == 0 ) {
		if (attr (gpxx, gpyy) == 2 || (attr (1 + gpxx, gpyy) == 2 && (gpx & 15)) ) {
			return 1;
		}
	}			
	return 0;
}
#endif

#if defined(PLAYER_PUSH_BOXES) || !defined(DEACTIVATE_KEYS)
void process_tile (unsigned char x0, unsigned char y0, signed char x1, signed char y1) {
#ifdef PLAYER_PUSH_BOXES
#ifdef FIRE_TO_PUSH
	gpit = (joyfunc) (&keys);
	if ((gpit & sp_FIRE) == 0) {
#endif		
		if (qtile (x0, y0) == 14 && attr (x1, y1) == 0 && x1 >= 0 && x1 < 15 && y1 >= 0 && y1 < 10) {
			// Mover
			map_attr [15 * y1 + x1] = 10;
			map_buff [15 * y1 + x1] = 14;
			map_attr [15 * y0 + x0] = 0;
			map_buff [15 * y0 + x0] = 0;
			// Pintar
			draw_coloured_tile (VIEWPORT_X + x0 + x0, VIEWPORT_Y + y0 + y0, 0);
			draw_coloured_tile (VIEWPORT_X + x1 + x1, VIEWPORT_Y + y1 + y1, 14);
			// Sonido
			peta_el_beeper (2);	
		} 
#ifdef FIRE_TO_PUSH
	}
#endif
#endif
#ifndef DEACTIVATE_KEYS
	if (qtile (x0, y0) == 15 && player.keys) {
		map_attr [15 * y0 + x0] = 0;
		map_buff [15 * y0 + x0] = 0;
#ifdef COMPRESSED_LEVELS
		for (gpit = 0; gpit < n_bolts; gpit ++) {
#else		
		for (gpit = 0; gpit < MAX_CERROJOS; gpit ++) {
#endif
			if (cerrojos [gpit].x == x0 && cerrojos [gpit].y == y0 && cerrojos [gpit].np == n_pant) {
				cerrojos [gpit].st = 0;
				break;
			}
		}
		draw_coloured_tile (VIEWPORT_X + x0 + x0, VIEWPORT_Y + y0 + y0, 0);
		player.keys --;
		peta_el_beeper (8);
	}
#endif
}
#endif

unsigned char move (void) {
	gpit = (joyfunc) (&keys); // Leemos del teclado
	
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
		player.vy += PLAYER_G;
	else
		player.vy = PLAYER_MAX_VY_CAYENDO;
#ifdef PLAYER_CUMULATIVE_JUMP
	if (!player.saltando)
#endif
	if (player.gotten) player.vy = 0;		
#else
	// Si lo es, entonces el movimiento vertical se comporta exactamente igual que 
	// el horizontal.
	if ( ! ((gpit & sp_UP) == 0 || (gpit & sp_DOWN) == 0)) {
		player.facing_v = 0xff;
		if (player.vy > 0) {
			player.vy -= PLAYER_RX;
			if (player.vy < 0)
				player.vy = 0;
		} else if (player.vy < 0) {
			player.vy += PLAYER_RX;
			if (player.vy > 0)
				player.vy = 0;
		}
	}

	if ((gpit & sp_UP) == 0) {
		player.facing_v = FACING_UP;
		if (player.vy > -PLAYER_MAX_VX) {
			player.vy -= PLAYER_AX;
		}
	}

	if ((gpit & sp_DOWN) == 0) {
		player.facing_v = FACING_DOWN;
		if (player.vy < PLAYER_MAX_VX) {
			player.vy += PLAYER_AX;
		}
	}
#endif

#ifdef PLAYER_HAS_JETPAC
	if ((gpit & sp_UP) == 0) {
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

	gpx = player.x >> 6;				// dividimos entre 64 para pixels, y luego entre 16 para tiles.
	gpy = player.y >> 6;
	gpxx = gpx >> 4;
	gpyy = gpy >> 4;
	
	// Ya	
	possee = 0;
	hit_v = 0;
#ifdef BOUNDING_BOX_8_BOTTOM	
	if (player.vy < 0) { 			// estamos ascendiendo
		if ((gpy & 15) < 8) {
			if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) > 7) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) > 7)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
				player.vy = -(player.vy / 2);
#else				
				player.vy = 0;
#endif
				player.y = ((gpyy + 1) << 10) - 512;
				wall = WTOP;
			} else if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) == 1) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) == 1)) {
				hit_v = 1; 
			}
		}
	} else if (player.vy > 0 && (gpy & 15) < 8) { 	// estamos descendiendo
		if (player.y < 9216) {
			if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) > 3) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) > 3)) {
#if defined(PLAYER_BOUNCE_WITH_WALLS) && defined(PLAYER_MOGGY_STYLE)
				player.vy = -(player.vy / 2);
#else				
#ifdef PLAYER_CUMULATIVE_JUMP
				if (!player.saltando)
#endif				
				player.vy = 0;
#endif
				player.y = gpyy << 10;
				wall = WBOTTOM;
				possee = 1;
			} else if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) == 1) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) == 1)) {
				hit_v = 1;
			}
		}
	}
#else
#ifdef BOUNDING_BOX_8_CENTERED
	if (player.vy < 0) { 			
		if ((gpy & 15) < 12) {
			if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) > 7) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) > 7)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
				player.vy = -(player.vy / 2);
#else				
				player.vy = 0;
#endif
				player.y = ((gpyy + 1) << 10) - 256;
				wall = WTOP;
			} else if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) == 1) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) == 1)) {
				hit_v = 1; 
			}
		}
	} else if (player.vy > 0 && (gpy & 15) >= 4) { 	
		if (player.y < 9216) {
			if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) > 3) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) > 3)) {
#if defined(PLAYER_BOUNCE_WITH_WALLS) && defined(PLAYER_MOGGY_STYLE)
				player.vy = -(player.vy / 2);
#else
#ifdef PLAYER_CUMULATIVE_JUMP
				if (!player.saltando)
#endif				
				player.vy = 0;
#endif
				player.y = (gpyy << 10) + 256;
				wall = WBOTTOM;
				possee = 1;
			} else if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) == 1) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) == 1)) {
				hit_v = 1; 
			}
		}
	}
#else
	if (player.vy < 0) { 		
		if (attr (gpxx, gpyy) > 7 || ((gpx & 15) && attr (gpxx + 1, gpyy) > 7)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
			player.vy = -(player.vy / 2);
#else				
			player.vy = 0;
#endif
			player.y = (gpyy + 1) << 10;
			wall = WTOP;	
		} else if (attr (gpxx, gpyy) == 1 || ((gpx & 15) && attr (gpxx + 1, gpyy) == 1)) {
			hit_v = 1; 
		}
	} else if (player.vy > 0 && (gpy & 15) < 8) {
		if (player.y < 9216) {
			if (attr (gpxx, gpyy + 1) > 3 || ((gpx & 15) && attr (gpxx + 1, gpyy + 1) > 3))
			{
#if defined(PLAYER_BOUNCE_WITH_WALLS) && defined(PLAYER_MOGGY_STYLE)
				player.vy = -(player.vy / 2);
#else				
#ifdef PLAYER_CUMULATIVE_JUMP
				if (!player.saltando)
#endif
				player.vy = 0;
#endif
				player.y = gpyy << 10;
				possee = 1;
				wall = WBOTTOM;
			} else if (attr (gpxx, gpyy + 1) == 1 || ((gpx & 15) && attr (gpxx + 1, gpyy + 1) == 1)) {
				hit_v = 1; 
			}
		}
	}
#endif
#endif
	
	/* Salto: El salto se reduce a dar un valor negativo a vy. Esta es la forma más
	   sencilla. Sin embargo, para más control, usamos el tipo de salto "mario bros".
	   Para ello, en cada pulsación dejaremos decrementar vy hasta un mínimo, y de-
	   tectando que no se vuelva a pulsar cuando estemos en el aire. Juego de banderas ;)
	*/

#ifdef PLAYER_HAS_JUMP
#ifdef PLAYER_CAN_FIRE
	
#ifdef PLAYER_CUMULATIVE_JUMP
	if (((gpit & sp_UP) == 0) && (possee || player.gotten)) {
		player.vy = -player.vy - PLAYER_VY_INICIAL_SALTO;
		if (player.vy < -PLAYER_MAX_VY_SALTANDO) player.vy = -PLAYER_MAX_VY_SALTANDO;
#else		
	if (((gpit & sp_UP) == 0) && player.saltando == 0 && (possee || player.gotten)) {
#endif
		player.saltando = 1;
		player.cont_salto = 0;
		peta_el_beeper (3);
	}

#ifndef PLAYER_CUMULATIVE_JUMP	
	if ( ((gpit & sp_UP) == 0) && player.saltando ) {
		player.vy -= (PLAYER_VY_INICIAL_SALTO + PLAYER_INCR_SALTO - (player.cont_salto>>1));
		if (player.vy < -PLAYER_MAX_VY_SALTANDO) player.vy = -PLAYER_MAX_VY_SALTANDO;
		player.cont_salto ++;
		if (player.cont_salto == 8)
			player.saltando = 0;
	}
#endif
	
	if ((gpit & sp_UP))
		player.saltando = 0;
#else
#ifdef PLAYER_CUMULATIVE_JUMP
	if (((gpit & sp_FIRE) == 0) && (possee || player.gotten)) {
		player.vy = -player.vy - PLAYER_VY_INICIAL_SALTO;
		if (player.vy < -PLAYER_MAX_VY_SALTANDO) player.vy = -PLAYER_MAX_VY_SALTANDO;
#else
	if (((gpit & sp_FIRE) == 0) && player.saltando == 0 && (possee || player.gotten)) {
#endif
		player.saltando = 1;
		player.cont_salto = 0;
		peta_el_beeper (3);
	}

#ifndef PLAYER_CUMULATIVE_JUMP	
	if ( ((gpit & sp_FIRE) == 0) && player.saltando ) {
		player.vy -= (PLAYER_VY_INICIAL_SALTO + PLAYER_INCR_SALTO - (player.cont_salto>>1));
		if (player.vy < -PLAYER_MAX_VY_SALTANDO) player.vy = -PLAYER_MAX_VY_SALTANDO;
		player.cont_salto ++;
		if (player.cont_salto == 8)
			player.saltando = 0;
	}
#endif

	if ((gpit & sp_FIRE))
		player.saltando = 0;
#endif
#endif

	// Bootee engine
#ifdef PLAYER_BOOTEE
	if ( player.saltando == 0 && (possee || player.gotten) ) {
		player.saltando = 1;
		player.cont_salto = 0;
		peta_el_beeper (3);
	}
	
	if (player.saltando ) {
		player.vy -= (PLAYER_VY_INICIAL_SALTO + PLAYER_INCR_SALTO - (player.cont_salto>>1));
		if (player.vy < -PLAYER_MAX_VY_SALTANDO) player.vy = -PLAYER_MAX_VY_SALTANDO;
		player.cont_salto ++;
		if (player.cont_salto == 8)
			player.saltando = 0;
	}
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

	if ( ! ((gpit & sp_LEFT) == 0 || (gpit & sp_RIGHT) == 0)) {
#ifdef PLAYER_MOGGY_STYLE		
		player.facing_h = 0xff;
#endif
		if (player.vx > 0) {
			player.vx -= PLAYER_RX;
			if (player.vx < 0)
				player.vx = 0;
		} else if (player.vx < 0) {
			player.vx += PLAYER_RX;
			if (player.vx > 0)
				player.vx = 0;
		}
	}

	if ((gpit & sp_LEFT) == 0) {
#ifdef PLAYER_MOGGY_STYLE
		player.facing_h = FACING_LEFT;
#endif
		if (player.vx > -PLAYER_MAX_VX) {
#ifndef PLAYER_MOGGY_STYLE			
			player.facing = 0;
#endif
			player.vx -= PLAYER_AX;
		}
	}

	if ((gpit & sp_RIGHT) == 0) {
#ifdef PLAYER_MOGGY_STYLE	
		player.facing_h = FACING_RIGHT;
#endif
		if (player.vx < PLAYER_MAX_VX) {
			player.vx += PLAYER_AX;
#ifndef PLAYER_MOGGY_STYLE						
			player.facing = 1;
#endif
		}
	}

	player.x = player.x + player.vx;
	
	// Safe
	
	if (player.x < 0)
		player.x = 0;
		
	if (player.x > 14336)
		player.x = 14336;
		
	/* Ahora, como antes, vemos si nos chocamos con algo, y en ese caso
	   paramos y reculamos */

	gpy = player.y >> 6;
	gpx = player.x >> 6;
	gpyy = gpy >> 4;
	gpxx = gpx >> 4;
	hit_h = 0;
#ifdef BOUNDING_BOX_8_BOTTOM	
	if (player.vx < 0 && (gpx & 15) < 12) {
		if ( ((gpy & 15) < 8 && attr (gpxx, gpyy) > 7) || ((gpy & 15) && attr (gpxx, gpyy + 1) > 7)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
			player.vx = -(player.vx / 2);
#else				
			player.vx = 0;
#endif
			player.x = ((gpxx + 1) << 10) - 256;
			wall = WLEFT;
		} else if ( ((gpy & 15) < 8 && attr (gpxx, gpyy) == 1) || ((gpy & 15) && attr (gpxx, gpyy + 1) == 1)) {
			hit_h = 1; 
		}
	} else if ((gpx & 15) >= 4) {
		if ( ((gpy & 15) < 8 && attr (gpxx + 1, gpyy) > 7) || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) > 7)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
			player.vx = -(player.vx / 2);
#else				
			player.vx = 0;
#endif
			player.x = (gpxx << 10) + 256;
			wall = WRIGHT;
		} else if ( ((gpy & 15) < 8 && attr (gpxx + 1, gpyy) == 1) || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) == 1)) {
			hit_h = 1; 
		}
	}
#else
#ifdef BOUNDING_BOX_8_CENTERED
	if (player.vx < 0 && (gpx & 15) < 12) {
		if ( ((gpy & 15) < 12 && attr (gpxx, gpyy) > 7) || ((gpy & 15) > 4 && attr (gpxx, gpyy + 1) > 7)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
			player.vx = -(player.vx / 2);
#else				
			player.vx = 0;
#endif
			player.x = ((gpxx + 1) << 10) - 256;
			wall = WLEFT;
		} else if ( ((gpy & 15) < 8 && attr (gpxx, gpyy) == 1) || ((gpy & 15) && attr (gpxx, gpyy + 1) == 1)) {
			hit_h = 1; 
		}
	} else if ((gpx & 15) >= 4) {
		if ( ((gpy & 15) < 12 && attr (gpxx + 1, gpyy) > 7) || ((gpy & 15) > 4 && attr (gpxx + 1, gpyy + 1) > 7)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
			player.vx = -(player.vx / 2);
#else				
			player.vx = 0;
#endif
			player.x = (gpxx << 10) + 256;
			wall = WRIGHT;
		} else if ( ((gpy & 15) < 8 && attr (gpxx + 1, gpyy) == 1) || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) == 1)) {
			hit_h = 1; 
		}
	}
#else
	if (player.vx < 0) {
		if (attr (gpxx, gpyy) > 7 || ((gpy & 15) && attr (gpxx, gpyy + 1) > 7)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
			player.vx = -(player.vx / 2);
#else				
			player.vx = 0;
#endif
			player.x = (gpxx + 1) << 10;
			wall = WLEFT;
		} else if (attr (gpxx, gpyy) == 1 || ((gpy & 15) && attr (gpxx, gpyy + 1) == 1)) {
			hit_h = 1; 
		}
	} else {
		if (attr (gpxx + 1, gpyy) > 7 || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) > 7)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
			player.vx = -(player.vx / 2);
#else				
			player.vx = 0;
#endif
			player.x = gpxx << 10;
			wall = WRIGHT;
		} else if (attr (gpxx + 1, gpyy) == 1 || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) == 1)) {
			hit_h = 1; 
		}
	}
#endif
#endif

#ifdef PLAYER_MOGGY_STYLE
	// Priority to decide facing
	#ifdef TOP_OVER_SIDE
		if (player.facing_v != 0xff) {
			player.facing = player.facing_v;
		} else if (player.facing_h != 0xff) {
			player.facing = player.facing_h;
		}
	#else
		if (player.facing_h != 0xff) {
			player.facing = player.facing_h;
		} else if (player.facing_v != 0xff) {
			player.facing = player.facing_v;
		}
	#endif	
#endif

#ifdef PLAYER_CAN_FIRE
	// Disparos
	if ((gpit & sp_FIRE) == 0 && player.disparando == 0) {
		player.disparando = 1;
		fire_bullet ();
	}
	
	if ((gpit & sp_FIRE)) 
		player.disparando = 0;

#endif
	
#if defined(PLAYER_PUSH_BOXES) || !defined(DEACTIVATE_KEYS)
	// Empujar cajas (tile #14)
	gpx = player.x >> 6;
	gpy = player.y >> 6;
	gpxx = gpx >> 4;
	gpyy = gpy >> 4;
	
	// En modo plataformas, no se puede empujar verticalmente
#ifdef PLAYER_MOGGY_STYLE
	
	if (wall == WTOP) {
#if defined(BOUNDING_BOX_8_BOTTOM) || defined (BOUNDING_BOX_8_CENTERED)
		if (attr (gpxx, gpyy) == 10) {				
			process_tile (gpxx, gpyy, gpxx, gpyy - 1);
#else
		if (attr (gpxx, gpyy - 1) == 10) {				
			process_tile (gpxx, gpyy - 1, gpxx, gpyy - 2);
#endif
		}
		if ((gpx & 15)) {
#if defined(BOUNDING_BOX_8_BOTTOM) || defined (BOUNDING_BOX_8_CENTERED)
			if (attr (gpxx + 1, gpyy) == 10) {
				process_tile (gpxx + 1, gpyy, gpxx + 1, gpyy - 1);
#else
			if (qtile (gpxx + 1, gpyy - 1) == 10) {
				process_tile (gpxx + 1, gpyy - 1, gpxx + 1, gpyy - 2);
#endif
			}
		}
	} else if (wall == WBOTTOM) {
		if (attr (gpxx, gpyy + 1) == 10) {
			process_tile (gpxx, gpyy + 1, gpxx, gpyy + 2);
		}
		if ((gpx & 15)) {
			if (attr (gpxx + 1, gpyy + 1) == 10) {
				process_tile (gpxx + 1, gpyy + 1, gpxx + 1, gpyy + 2);
			}	
		}
	}
#endif
	// Horizontalmente
	
	if (wall == WRIGHT) {
		if (attr (gpxx + 1, gpyy) == 10) {
			process_tile (gpxx + 1, gpyy, gpxx + 2, gpyy);
		}
		if ((gpy & 15)) {
			if (attr (gpxx + 1, gpyy + 1) == 10) {
				process_tile (gpxx + 1, gpyy + 1, gpxx + 2, gpyy + 1);
			}
		}
	} else if (wall == WLEFT) {
#if defined(BOUNDING_BOX_8_BOTTOM) || defined(BOUNDING_BOX_8_CENTERED)
		if (attr (gpxx, gpyy) == 10) {
			process_tile (gpxx, gpyy, gpxx - 1, gpyy);
#else
		if (attr (gpxx - 1, gpyy) == 10) {
			process_tile (gpxx - 1, gpyy, gpxx - 2, gpyy);
#endif
		}
		if ((gpy & 15)) {
#if defined(BOUNDING_BOX_8_BOTTOM) || defined(BOUNDING_BOX_8_CENTERED)
			if (attr (gpxx, gpyy + 1) == 10) {
				process_tile (gpxx, gpyy + 1, gpxx - 1, gpyy + 1);
#else
			if (attr (gpxx - 1, gpyy + 1) == 10) {
				process_tile (gpxx - 1, gpyy + 1, gpxx - 2, gpyy + 1);
#endif
			}
		}
	}						
#endif

#ifndef DEACTIVATE_EVIL_TILE
	// Tiles que te matan. 
	// hit_v tiene preferencia sobre hit_h
	hit = 0;
	if (hit_v) {
		hit = 1;
#ifdef FULL_BOUNCE
		player.vy = addsign (-player.vy, PLAYER_MAX_VX);
#else
		player.vy = -player.vy;
#endif
	} else if (hit_h) {
		hit = 1;
#ifdef FULL_BOUNCE
		player.vx = addsign (-player.vx, PLAYER_MAX_VX);
#else
		player.vx = -player.vx;
#endif
	}
	if (hit) {
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
	}
#endif

	// Select animation frame 
	
#ifndef PLAYER_MOGGY_STYLE
#ifdef PLAYER_BOOTEE
	gpit = player.facing << 2;
	if (player.vy == 0) {
		player.next_frame = player_frames [gpit];
	} else if (player.vy < 0) {
		player.next_frame = player_frames [gpit + 1];
	} else {
		player.next_frame = player_frames [gpit + 2];
	}
#else	
	if (!possee && !player.gotten) {
		player.next_frame = player_frames [8 + player.facing];
	} else {
		gpit = player.facing << 2;
		if (player.vx == 0) {
#ifdef PLAYER_ALTERNATE_ANIMATION
			player.next_frame = player_frames [gpit];
#else
			player.next_frame = player_frames [gpit + 1];
#endif
		} else {
			player.subframe ++;
			if (player.subframe == 4) {
				player.subframe = 0;
#ifdef PLAYER_ALTERNATE_ANIMATION
				player.frame ++; if (player.frame == 3) player.frame = 0;
#else
				player.frame = (player.frame + 1) & 3;
#endif
#ifdef PLAYER_STEP_SOUND
				step ();
#endif
			}
			player.next_frame = player_frames [gpit + player.frame];
		}
	}
#endif
#else
	
	if (player.vx || player.vy) {
		player.subframe ++;
		if (player.subframe == 4) {
			player.subframe = 0;
			player.frame = !player.frame;
#ifdef PLAYER_STEP_SOUND			
			step (); 
#endif
		}
	}
	
	player.next_frame = player_frames [player.facing + player.frame];
#endif
}

void draw_scr () {
	// Desempaqueta y dibuja una pantalla, actualiza el array map_attr
	// y hace algunas otras cosillas más (cambiar sprites de enemigos/plataformas, etc)
	
#ifdef UNPACKED_MAP
	map_pointer = mapa + (n_pant * 150);
#else
	map_pointer = mapa + (n_pant * 75);
#endif

	gpx = gpy = 0;	

	// Draw 150 tiles
	
	for (gpit = 0; gpit < 150; gpit ++) {	
#ifdef UNPACKED_MAP
		// Mapa tipo UNPACKED
		gpd = *map_pointer ++;
		map_attr [gpit] = comportamiento_tiles [gpd];
		map_buff [gpit] = gpd;
#else
		// Mapa tipo PACKED
		if (!(gpit & 1)) {
			gpc = *map_pointer ++;
			gpd = gpc >> 4;
		} else {
			gpd = gpc & 15;
		}
		map_attr [gpit] = comportamiento_tiles [gpd];
		if (gpd == 0 && (rand () & 15) == 1) gpd = 19;
		map_buff [gpit] = gpd;
#endif	
		draw_coloured_tile (VIEWPORT_X + gpx, VIEWPORT_Y + gpy, gpd);	
		gpx += 2;
		if (gpx == 30) {
			gpx = 0;
			gpy += 2;
		}
	}
	
	// Object setup
	
	hotspot_x = hotspot_y = 240;
	gpx = (hotspots [n_pant].xy >> 4);
	gpy = (hotspots [n_pant].xy & 15);

	if ((hotspots [n_pant].act == 1 && hotspots [n_pant].tipo) ||
		(hotspots [n_pant].act == 0 && (rand () & 7) == 2)) {
		hotspot_x = gpx << 4;
		hotspot_y = gpy << 4;
		orig_tile = map_buff [15 * gpy + gpx];
		draw_coloured_tile (VIEWPORT_X + gpx + gpx, VIEWPORT_Y + gpy + gpy, 16 + (hotspots [n_pant].act ? hotspots [n_pant].tipo : 0));
	}
	
#ifndef DEACTIVATE_KEYS
	// Open locks
#ifdef COMPRESSED_LEVELS
	for (gpit = 0; gpit < n_bolts; gpit ++) {
#else
	for (gpit = 0; gpit < MAX_CERROJOS; gpit ++) {
#endif
		if (cerrojos [gpit].np == n_pant && !cerrojos [gpit].st) {
			gpx = cerrojos [gpit].x;
			gpy = cerrojos [gpit].y;
			draw_coloured_tile (VIEWPORT_X + gpx + gpx, VIEWPORT_Y + gpy + gpy, 0);
			gpd = 15 * gpy + gpx;
			map_attr [gpd] = 0;
			map_buff [gpd] = 0;
		}
	}
#endif
	
	// Movemos y cambiamos a los enemigos según el tipo que tengan
	enoffs = n_pant * 3;
	
	for (gpit = 0; gpit < 3; gpit ++) {
		en_an [gpit].frame = 0;
		en_an [gpit].count = 3;
#ifdef ENABLE_RANDOM_RESPAWN
		en_an [gpit].fanty_activo = 0;
#endif
#ifdef RESPAWN_ON_ENTER
		// Back to life!
		
		malotes [enoffs + gpit].t &= 0xEF;	
#ifdef PLAYER_CAN_FIRE
		malotes [enoffs + gpit].life = ENEMIES_LIFE_GAUGE;
#endif
#endif
		switch (malotes [enoffs + gpit].t) {
			case 1:
			case 2:
			case 3:
			case 4:
				en_an [gpit].base_frame = (malotes [enoffs + gpit].t - 1) << 1;
				break;
#ifdef ENABLE_RANDOM_RESPAWN
			case 5: 
				en_an [gpit].base_frame = 4;
				break;
#endif
#ifdef ENABLE_PURSUERS
			case 7:
				en_an [gpit].alive = 0;
				en_an [gpit].dead_row = 0;//DEATH_COUNT_EXPRESSION;
				break;
#endif
			default:
				en_an [gpit].next_frame = sprite_18_a;
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

void select_joyfunc () {
	#asm
		; Music generated by beepola
		call musicstart
	#endasm
	
	gpit = 0;
	while (!gpit) {
		gpjt = sp_GetKey ();
		switch (gpjt) {
			case '1':
				gpit = 1;
				joyfunc = sp_JoyKeyboard;
				break;
			case '2':
				gpit = 1;
				joyfunc = sp_JoyKempston;
				break;
			case '3':
				gpit = 1;
				joyfunc = sp_JoySinclair1;
				break;
		}			
	}
	#asm
		di
	#endasm
}

#ifdef PLAYER_CAN_FIRE
void mueve_bullets () {
	for (gpit = 0; gpit < MAX_BULLETS; gpit ++) {
		if (bullets [gpit].mx) {
			bullets [gpit].x += bullets [gpit].mx;
			gpxx = bullets [gpit].x >> 4;
			gpyy = bullets [gpit].y >> 4;
			if (
				(attr (gpxx, gpyy) > 7 && ((bullets [gpit].y & 15) < 8 || attr (gpxx, gpyy + 1) > 7)) || 
				bullets [gpit].x < 8 || 
				bullets [gpit].x > 240
			)
				bullets [gpit].estado = 0;
		} 
#ifdef PLAYER_MOGGY_STYLE
		if (bullets [gpit].my) {
			if (attr (bullets [gpit].x >> 4, bullets [gpit].y >> 4) > 7 || bullets [gpit].y < 8 || bullets [gpit].y > 160)
				bullets [gpit].estado = 0;
			bullets [gpit].y += bullets [gpit].my;
		}
	}	
#endif
}
#endif	

// Total rewrite

#ifdef WALLS_STOP_ENEMIES
unsigned char __FASTCALL__ mons_col_sc_x (void) {
	gpaux = gpen_xx + ctileoff (malotes [enoffsmasi].mx);
	if (attr (gpaux, gpen_yy) > 7 || 
		((malotes [enoffsmasi].y & 15) && attr (gpaux, gpen_yy + 1) > 7)) {
		return 1;
	}
	return 0;
}
	
unsigned char __FASTCALL__ mons_col_sc_y (void) {
	gpaux = gpen_yy + ctileoff (malotes [enoffsmasi].my);
	if (attr (gpen_xx, gpaux) > 7 || 
		((malotes [enoffsmasi].x & 15) && attr (gpen_xx + 1, gpaux) > 7)) {
		return 1;
	}
	return 0;
}
#endif

#if defined(SLOW_DRAIN) && defined(PLAYER_BOUNCES)
unsigned char lasttimehit;
#endif

void mueve_bicharracos (void) {
	gpx = player.x >> 6;
	gpy = player.y >> 6;
	
	tocado = 0;
	player.gotten = 0;
	for (gpit = 0; gpit < 3; gpit ++) {
		active = 0;
		enoffsmasi = enoffs + gpit;
		gpen_x = malotes [enoffsmasi].x;
		gpen_y = malotes [enoffsmasi].y;		
		gpt = malotes [enoffsmasi].t;
#ifdef ENABLE_RANDOM_RESPAWN
		if (en_an [gpit].fanty_activo) gpt = 5;
#endif
		switch (gpt) {
			case 1:
			case 2:
			case 3:
			case 4:
				active = 1;
				malotes [enoffsmasi].x += malotes [enoffsmasi].mx;
				malotes [enoffsmasi].y += malotes [enoffsmasi].my;
				gpen_cx = malotes [enoffsmasi].x;
				gpen_cy = malotes [enoffsmasi].y;
				gpen_xx = gpen_cx >> 4;
				gpen_yy = gpen_cy >> 4;
#ifdef WALLS_STOP_ENEMIES
				if (gpen_cx == malotes [enoffsmasi].x1 || gpen_cx == malotes [enoffsmasi].x2 || mons_col_sc_x ())
					malotes [enoffsmasi].mx = -malotes [enoffsmasi].mx;
				if (gpen_cy == malotes [enoffsmasi].y1 || gpen_cy == malotes [enoffsmasi].y2 || mons_col_sc_y ())
					malotes [enoffsmasi].my = -malotes [enoffsmasi].my;
#else
				if (gpen_cx == malotes [enoffsmasi].x1 || gpen_cx == malotes [enoffsmasi].x2)
					malotes [enoffsmasi].mx = -malotes [enoffsmasi].mx;
				if (gpen_cy == malotes [enoffsmasi].y1 || gpen_cy == malotes [enoffsmasi].y2)
					malotes [enoffsmasi].my = -malotes [enoffsmasi].my;
#endif
				break;
#ifdef ENABLE_RANDOM_RESPAWN
			case 5:
				active = 1;
				gpen_cx = en_an [gpit].x >> 6;
				gpen_cy = en_an [gpit].y >> 6;
				if (player_hidden ()) {
					if (player.x < en_an [gpit].x && en_an [gpit].vx < FANTY_MAX_V)
						en_an [gpit].vx += FANTY_A >> 1;
					else if (player.x > en_an [gpit].x && en_an [gpit].vx > -FANTY_MAX_V)
						en_an [gpit].vx -= FANTY_A >> 1;
					if (player.y < en_an [gpit].y && en_an [gpit].vy < FANTY_MAX_V)
						en_an [gpit].vy += FANTY_A >> 1;
					else if (player.y > en_an [gpit].y && en_an [gpit].vy > -FANTY_MAX_V)
						en_an [gpit].vy -= FANTY_A >> 1;
				} else if ((rand () & 7) > 1) {
					if (player.x > en_an [gpit].x && en_an [gpit].vx < FANTY_MAX_V)
						en_an [gpit].vx += FANTY_A;
					else if (player.x < en_an [gpit].x && en_an [gpit].vx > -FANTY_MAX_V)
						en_an [gpit].vx -= FANTY_A;
					if (player.y > en_an [gpit].y && en_an [gpit].vy < FANTY_MAX_V)
						en_an [gpit].vy += FANTY_A;
					else if (player.y < en_an [gpit].y && en_an [gpit].vy > -FANTY_MAX_V)
						en_an [gpit].vy -= FANTY_A;
				}
								
				en_an [gpit].x += en_an [gpit].vx;
				en_an [gpit].y += en_an [gpit].vy;
				if (en_an [gpit].x > 15360) en_an [gpit].x = 15360;
				if (en_an [gpit].x < -1024) en_an [gpit].x = -1024;
				if (en_an [gpit].y > 10240) en_an [gpit].y = 10240;
				if (en_an [gpit].y < -1024) en_an [gpit].y = -1024;
				break;
#endif
#ifdef ENABLE_PURSUERS
			case 7:
				switch (en_an [gpit].alive) {
					case 0:
						if (!en_an [gpit].dead_row) {
							malotes [enoffsmasi].x = malotes [enoffsmasi].x1;
							malotes [enoffsmasi].y = malotes [enoffsmasi].y1;
							en_an [gpit].alive = 1;
							en_an [gpit].rawv = 1 << (rand () % 5);
							if (en_an [gpit].rawv > 4) en_an [gpit].rawv = 2;
							en_an [gpit].dead_row = 15;
#if defined(PLAYER_KILLS_ENEMIES) || defined(PLAYER_CAN_FIRE)							
							malotes [enoffsmasi].life = ENEMIES_LIFE_GAUGE;
#endif							
						} else {
							en_an [gpit].dead_row --;
						}
						break;
					case 1:
						if (!en_an [gpit].dead_row) {
							en_an [gpit].base_frame = (rand () & 3) << 1;
							en_an [gpit].alive = 2;
						} else {
							en_an [gpit].dead_row --;
							en_an [gpit].next_frame = sprite_17_a;
						}
						break;
					case 2:
						active = 1;
						if (player.estado == EST_NORMAL) {
							malotes [enoffsmasi].mx = (signed char) (addsign (((gpx >> 2) << 2) - gpen_x, en_an [gpit].rawv));
							malotes [enoffsmasi].x += malotes [enoffsmasi].mx;
							gpen_xx = malotes [enoffsmasi].x >> 4;
							gpen_yy = malotes [enoffsmasi].y >> 4;
#ifdef WALLS_STOP_ENEMIES
							if (mons_col_sc_x ()) malotes [enoffsmasi].x = gpen_x;
#endif
							malotes [enoffsmasi].my = (signed char) (addsign (((gpy >> 2) << 2) - gpen_y, en_an [gpit].rawv));
							malotes [enoffsmasi].y += malotes [enoffsmasi].my;
							gpen_xx = malotes [enoffsmasi].x >> 4;
							gpen_yy = malotes [enoffsmasi].y >> 4;
#ifdef WALLS_STOP_ENEMIES
							if (mons_col_sc_y ()) malotes [enoffsmasi].y = gpen_y;
#endif
						}
						gpen_cx = malotes [enoffsmasi].x;
						gpen_cy = malotes [enoffsmasi].y;
				}
				break;	
#endif
			default:
				en_an [gpit].next_frame = sprite_18_a;
		}
		
		if (active) {			
			// Animate
			en_an [gpit].count ++; 
			if (en_an [gpit].count == 4) {
				en_an [gpit].count = 0;
				en_an [gpit].frame = !en_an [gpit].frame;
				en_an [gpit].next_frame = enem_frames [en_an [gpit].base_frame + en_an [gpit].frame];
			}
			
			// Collide with player
			
#ifndef PLAYER_MOGGY_STYLE
			// Platforms
			if (malotes [enoffsmasi].t == 4) {
				gpxx = gpx >> 4;
				if (gpx >= gpen_cx - 15 && gpx <= gpen_cx + 15) {
					if (malotes [enoffsmasi].my < 0) {
						if (gpy >= gpen_cy - 16 && gpy <= gpen_cy - 11 && player.vy >= -(PLAYER_INCR_SALTO)) {
							player.gotten = 1;
							player.y = (gpen_cy - 16) << 6;
#ifdef PLAYER_CUMULATIVE_JUMP
							if (!player.saltando)	
#endif							
							player.vy = 0;
							gpyy = gpy >> 4;
#ifdef BOUNDING_BOX_8_BOTTOM	
							if ((gpy & 15) < 8) {
								if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) > 7) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) > 7)) {
#else
#ifdef BOUNDING_BOX_8_CENTERED
							if ((gpy & 15) < 12) {
								if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) > 7) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) > 7)) {
#else				
							{
								if (attr (gpxx, gpyy) > 7 || ((gpx & 15) && attr (gpxx + 1, gpyy) > 7)) {
#endif
#endif
									player.y = (gpyy + 1) << 10;
								}
							}
						}
					} else if (malotes [enoffsmasi].my > 0) {
						if (gpy >= gpen_cy - 20 && gpy <= gpen_cy - 14 && player.vy >= 0) {
							player.gotten = 1;
							player.y = (gpen_cy - 16) << 6;
#ifdef PLAYER_CUMULATIVE_JUMP
							if (!player.saltando)	
#endif							
							player.vy = 0;
							gpyy = gpy >> 4;
#ifdef BOUNDING_BOX_8_BOTTOM
							if ((gpy & 15) < 8) {
								if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) > 3) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) > 3)) {
#else									
#ifdef BOUNDING_BOX_8_CENTERED
							if ((gpy & 15) >= 4) {
								if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) > 3) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) > 3)) {
#else							
							{
								if (attr (gpxx, gpyy + 1) > 7 || ((gpx & 15) && attr (gpxx + 1, gpyy + 1) > 7)) {
#endif
#endif								
									player.y = gpyy << 10;
								}
							}
						}
					}
					gpy = player.y >> 6;
					if (malotes [enoffsmasi].mx && gpy >= gpen_cy - 16 && gpy <= gpen_cy - 8 && player.vy >= 0) {
						player.gotten = 1;
						player.y = (gpen_cy - 16) << 6;
						gpyy = gpy >> 4;
						gpx = gpx + malotes [enoffsmasi].mx;
						player.x = gpx << 6;
						gpxx = gpx >> 4;
						if (malotes [enoffsmasi].mx < 0) {
#ifdef BOUNDING_BOX_8_BOTTOM
							if ((gpx & 15) < 12) {
								if ( ((gpy & 15) < 8 && attr (gpxx, gpyy) > 7) || ((gpy & 15) && attr (gpxx, gpyy + 1) > 7)) {
#else
#ifdef BOUNDING_BOX_8_CENTERED
							if ((gpx & 15) < 12) {
								if ( ((gpy & 15) < 12 && attr (gpxx, gpyy) > 7) || ((gpy & 15) > 4 && attr (gpxx, gpyy + 1) > 7)) {
#else							
							{
								if (attr (gpxx, gpyy) > 7 || ((gpy & 15) && attr (gpxx, gpyy + 1) > 7)) {
#endif
#endif
									player.vx = 0;
									player.x = (gpxx + 1) << 10;
								}
							}
						} else {
#ifdef BOUNDING_BOX_8_BOTTOM
							if ((gpx & 15) >= 4) {
								if ( ((gpy & 15) < 8 && attr (gpxx + 1, gpyy) > 7) || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) > 7)) {
#else
#ifdef BOUNDING_BOX_8_CENTERED
							if ((gpx & 15) >= 4) {
								if ( ((gpy & 15) < 12 && attr (gpxx + 1, gpyy) > 7) || ((gpy & 15) > 4 && attr (gpxx + 1, gpyy + 1) > 7)) {
#else									
							{
								if (attr (gpxx + 1, gpyy) > 7 || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) > 7)) {
#endif
#endif									
									player.vx = 0;
									player.x = gpxx << 10;
								}
							}
						}
					}
				}
			} else if (!tocado && collide (gpx, gpy, gpen_cx, gpen_cy) && player.estado == EST_NORMAL) {
#else
			if (!tocado && collide (gpx, gpy, gpen_cx, gpen_cy) && player.estado == EST_NORMAL) {
#endif			
#ifdef PLAYER_KILLS_ENEMIES
				// Step over enemy				
				if (gpy < gpen_cy - 2 && player.vy >= 0 && malotes [enoffsmasi].t >= PLAYER_MIN_KILLABLE) {
					en_an [gpit].next_frame = sprite_17_a;
					sp_MoveSprAbs (sp_moviles [gpit], spritesClip, en_an [gpit].next_frame - en_an [gpit].current_frame, VIEWPORT_Y + (gpen_cy >> 3), VIEWPORT_X + (gpen_cx >> 3), gpen_cx & 7, gpen_cy & 7);
					en_an [gpit].current_frame = en_an [gpit].next_frame;
					sp_UpdateNow ();
					peta_el_beeper (5);
					en_an [gpit].next_frame = sprite_18_a;
					malotes [enoffsmasi].t |= 16;			// Mark as dead					
					player.killed ++;
#ifdef ACTIVATE_SCRIPTING					
					// Run this screen fire script or "entering any".
					script = f_scripts [n_pant];
					run_script ();
					script = e_scripts [MAP_W * MAP_H + 1];
					run_script ();
#endif
				} else if (player.life > 0) {
#else
				if (player.life > 0) {					
#endif
					tocado = 1;
#if defined(SLOW_DRAIN) && defined(PLAYER_BOUNCES)
					if (!lasttimehit || ((maincounter & 3) == 0)) {
						peta_el_beeper (4);
						player.life --;	
					}
#else
					player.life --;
					peta_el_beeper (4);
#endif					
#ifdef PLAYER_BOUNCES
#ifndef PLAYER_MOGGY_STYLE	
#ifdef RANDOM_RESPAWN
					if (!en_an [gpit].fanty_activo) {
						player.vx = addsign (malotes [enoffsmasi].mx, PLAYER_MAX_VX);
						player.vy = addsign (malotes [enoffsmasi].my, PLAYER_MAX_VX);
					} else {
						player.vx = en_an [gpit].vx + en_an [gpit].vx;
						player.vy = en_an [gpit].vy + en_an [gpit].vy;	
					}
#else
					player.vx = addsign (malotes [enoffsmasi].mx, PLAYER_MAX_VX);
					player.vy = addsign (malotes [enoffsmasi].my, PLAYER_MAX_VX);
#endif
#else
					if (malotes [enoffsmasi].mx) {
						player.vx = addsign (gpx - gpen_cx, abs (malotes [enoffsmasi].mx) << 8);
					}
					if (malotes [enoffsmasi].my) {
						player.vy = addsign (gpy - gpen_cy, abs (malotes [enoffsmasi].my) << 8);
					}
#endif
#endif
#ifdef PLAYER_FLICKERS
					player.estado = EST_PARP;
					player.ct_estado = 50;
#endif
				}
			}
			
#ifdef PLAYER_CAN_FIRE
			// Collide with bullets
			for (gpjt = 0; gpjt < MAX_BULLETS; gpjt ++) {
				if (bullets [gpjt].estado == 1) {
					if (bullets [gpjt].y >= gpen_cy - 4 && bullets [gpjt].y <= gpen_cy + 12 && bullets [gpjt].x >= gpen_cx - 4 && bullets [gpjt].x <= gpen_cx + 12) {
#ifdef RANDOM_RESPAWN		
						if (en_an [gpit].fanty_activo) {
							en_an [gpit].vx += (bullets [gpjt].mx > 0 ? 128 : -128);
						}
#endif
						malotes [enoffsmasi].x = gpen_x;
						malotes [enoffsmasi].y = gpen_y;
						en_an [gpit].next_frame = sprite_17_a;
						en_an [gpit].morido = 1;
						bullets [gpjt].estado = 0;
#ifndef PLAYER_MOGGY_STYLE							
						if (malotes [enoffsmasi].t != 4) malotes [enoffsmasi].life --;
#else
						malotes [enoffsmasi].life --;
#endif
						if (malotes [enoffsmasi].life == 0) {
							sp_MoveSprAbs (sp_moviles [gpit], spritesClip, en_an [gpit].next_frame - en_an [gpit].current_frame, VIEWPORT_Y + (gpen_cy >> 3), VIEWPORT_X + (gpen_cx >> 3), gpen_cx & 7, gpen_cy & 7);
							en_an [gpit].current_frame = en_an [gpit].next_frame;
							sp_UpdateNow ();
							peta_el_beeper (5);
							en_an [gpit].next_frame = sprite_18_a;
							if (gpt != 7) malotes [enoffsmasi].t |= 16;
							player.killed ++;
#ifdef RANDOM_RESPAWN								
							en_an [gpit].fanty_activo = 0;
							malotes [enoffsmasi].life = FANTIES_LIFE_GAUGE;
#endif
#ifdef ENABLE_PURSUERS
							en_an [gpit].alive = 0;
							en_an [gpit].dead_row = DEATH_COUNT_EXPRESSION;
#endif							
						}
					}
				}
			}
#endif
			
#ifdef RANDOM_RESPAWN
			// Activar fanty

			if (malotes [enoffsmasi].t > 15 && en_an [gpit].fanty_activo == 0 && (rand () & 31) == 1) {
				en_an [gpit].fanty_activo = 1;
				if (player.y > 5120) en_an [gpit].y = -1024; else en_an [gpit].y = 10240;
				en_an [gpit].x = (rand () % 240 - 8) << 6;
				en_an [gpit].vx = en_an [gpit].vy = 0;
				en_an [gpit].base_frame = 4;
			}
#endif
		} 
	}
#if defined(SLOW_DRAIN) && defined(PLAYER_BOUNCES)
	lasttimehit = tocado;
#endif
}