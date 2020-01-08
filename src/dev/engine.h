// MTE MK1 (la Churrera) v3.99.99 (final)
// Copyleft 2010-2017 by the Mojon Twins

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
unsigned char bs;

#ifdef COMPRESSED_LEVELS
	#ifdef MODE_128K
		void prepare_level (unsigned char level) {
			get_resource (levels [level].resource, (unsigned int) (level_data));
			//unpack_RAMn (levels [level].page, levels [level].address, (unsigned int) (level_data));
			n_pant = level_data.scr_ini;
			px = level_data->ini_x << 10;
			py = level_data->ini_y << 10;
		}
	#else
		void prepare_level (unsigned char level) {
			unpack ((unsigned int) levelset [level].leveldata_c, MAP_DATA);
			unpack ((unsigned int) levelset [level].tileset_c, (unsigned int) (tileset));
			unpack ((unsigned int) levelset [level].spriteset_c, (unsigned int) (sprite_1_a - 16));
			n_pant = levelset [level].ini_pant;
			px = levelset [level].ini_x << 10;
			py = levelset [level].ini_y << 10;
			n_bolts = *((unsigned char *) (NBOLTS_PEEK));
		}
	#endif
#endif

void init_player (void) {
	// Inicializa player con los valores iniciales
	// (de ahí lo de inicializar).
		
	#ifndef COMPRESSED_LEVELS
		px = 			PLAYER_INI_X << 10;
		py = 			PLAYER_INI_Y << 10;
	#endif	
	pvy = 		0;
	pvx = 		0;
	pcont_salto = 1;
	psaltando = 	0;
	pframe = 		0;
	psubframe = 	0;
	#ifdef PLAYER_MOGGY_STYLE
		pfacing = FACING_DOWN;
		pfacing_v = pfacing_h = 0xff;
	#else
		pfacing = 	1;
	#endif	
	pestado = 	EST_NORMAL;
	pct_estado = 	0;
	#if !defined(COMPRESSED_LEVELS) || defined(REFILL_ME)	
		plife = 		PLAYER_LIFE;
	#endif
	pobjs =		0;
	pkeys = 		0;
	pkilled = 	0;
	pdisparando = 0;
	#ifdef MAX_AMMO
		#ifdef INITIAL_AMMO
			pammo = INITIAL_AMMO
		#else
			pammo = MAX_AMMO;
		#endif
	#endif	
	pant_final = SCR_FIN;
	#ifdef TIMER_ENABLE
		ctimer.count = 0;
		ctimer.zero = 0;
		#ifdef TIMER_LAPSE
			ctimer.frames = TIMER_LAPSE;
		#endif
		#ifdef TIMER_INITIAL
			ctimer.t = TIMER_INITIAL;
		#endif
		#ifdef TIMER_START
			ctimer.on = 1;
		#else
			ctimer.on = 0;
		#endif
	#endif
}

unsigned char collide (unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
	#ifdef SMALL_COLLISION
		return (x1 + 8 >= x2 && x1 <= x2 + 8 && y1 + 8 >= y2 && y1 <= y2 + 8);
	#else
		return (x1 + 13 >= x2 && x1 <= x2 + 13 && y1 + 12 >= y2 && y1 <= y2 + 12);
	#endif
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

#ifdef PLAYER_STEP_SOUND
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
#endif

void cortina (void) {
	#asm
		;; Antes que nada vamos a limpiar el PAPER de toda la pantalla
		;; para que no queden artefactos feos
		
		ld	de, 22528			; Apuntamos con DE a la zona de atributos
		ld	b,	3				; Procesamos 3 tercios
	.clearb1
		push bc
		
		ld	b, 0				; Procesamos los 256 atributos de cada tercio
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
		ld	a,	0
	
	.bucle1
		sla (hl)
		inc hl
		dec a
		jr	nz, bucle1
			
		ld	a,	0
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
void game_ending (void) {
	sp_UpdateNow();
	blackout ();
	#ifdef MODE_128K
		// Resource 2 = ending
		get_resource (2, 16384);
	#else
		unpack ((unsigned int) (s_ending), 16384);
	#endif

	#ifdef MODE_128K
	#else
		bs = 4; do {
			peta_el_beeper (7);
			peta_el_beeper (2);
		} while (--bs);
		peta_el_beeper (9);
	#endif
	
	espera_activa (500);
}

unsigned char *spacer = "            ";
void game_over (void) {
	print_str (10, 11, 79, spacer);
	print_str (10, 12, 79, " GAME OVER! ");
	print_str (10, 13, 79, spacer);
	sp_UpdateNow ();

	#ifdef MODE_128K
	#else
		bs = 4; do {
			peta_el_beeper (7);
			peta_el_beeper (2);
		} while (--bs);
		peta_el_beeper (9);
	#endif

	espera_activa (500);
}

#if defined(TIMER_ENABLE) && defined(SHOW_TIMER_OVER)
	void time_over (void) {
		print_str (10, 11, 79, spacer);
		print_str (10, 12, 79, " TIME'S UP! ");
		print_str (10, 13, 79, spacer);
		sp_UpdateNow ();
			
		#ifdef MODE_128K
		#else
			bs = 4; do {
				peta_el_beeper (1);
				peta_el_beeper (2);
			} while (--bs);
			peta_el_beeper (0);
		#endif
		
		espera_activa (250);
	}
#endif

#ifdef PAUSE_ABORT
	void pause_screen (void) {
		print_str (10, 11, 79, spacer);
		print_str (10, 12, 79, "   PAUSED   ");
		print_str (10, 13, 79, spacer);
		sp_UpdateNow ();
	}
#endif

signed int addsign (signed int n, signed int value) {
	if (n >= 0) return value; else return -value;
}

unsigned char ctileoff (char n) {
	return n > 0;
}

#ifdef ENABLE_TILANIMS
	#include "tilanim.h"
#endif

void espera_activa (int espera) {
	do {
		#ifndef MODE_128K
			gpjt = 250; do { gpit = 1; } while (--gpjt);
		#else
			#asm
				halt
			#endasm
		#endif
		if (sp_GetKey ()) break;
	} while (--espera);
}

#ifndef COMPRESSED_LEVELS
	#ifndef DEACTIVATE_KEYS
		void init_cerrojos (void) {
			// Activa todos los cerrojos	
			for (gpit = 0; gpit < MAX_CERROJOS; ++ gpit) cerrojos [gpit].st = 1;	
		}
	#endif
#endif

#ifdef PLAYER_CAN_FIRE
	void init_bullets (void) {
		// Inicializa las balas
		gpit = 0; while (gpit < MAX_BULLETS) bullets [gpit ++].estado = 0;
	}
#endif

#ifndef COMPRESSED_LEVELS
	#if defined(PLAYER_KILLS_ENEMIES) || defined (PLAYER_CAN_FIRE)
		void init_malotes (void) {
			gpit = 0;
			while (gpit < MAP_W * MAP_H * 3) {
				malotes [gpit].t = malotes [gpit].t & 15;	
				#ifdef PLAYER_CAN_FIRE
					malotes [gpit].life = ENEMIES_LIFE_GAUGE;
					#ifdef ENABLE_RANDOM_RESPAWN
						if (malotes [gpit].t == 5) malotes [gpit].t |= 16;
					#endif
				#endif
				gpit ++;
			}
		}
	#endif
#endif

#ifndef COMPRESSED_LEVELS
	void init_hotspots (void) {
		gpit = 0;
		while (gpit < MAP_W * MAP_H) {
			hotspots [gpit ++].act = 1;
		}
	}
#endif

#ifdef PLAYER_CAN_FIRE
	void fire_bullet (void) {
		#ifdef PLAYER_CAN_FIRE_FLAG 
			if (flags [PLAYER_CAN_FIRE_FLAG] == 0) return;
		#endif
		#ifdef MAX_AMMO
			if (!pammo) return;
			-- pammo;
		#endif
		// Buscamos una bala libre
		for (gpit = 0; gpit < MAX_BULLETS; gpit ++) {
			if (bullets [gpit].estado == 0) {
				bullets [gpit].estado = 1;
				#ifdef PLAYER_MOGGY_STYLE
					switch (pfacing) {
						case FACING_LEFT:
							bullets [gpit].x = (px >> 6) - 4;
							bullets [gpit].mx = -PLAYER_BULLET_SPEED;
							bullets [gpit].y = (py >> 6) + PLAYER_BULLET_Y_OFFSET;
							bullets [gpit].my = 0;
							break;
						case FACING_RIGHT:
							bullets [gpit].x = (px >> 6) + 12;
							bullets [gpit].mx = PLAYER_BULLET_SPEED;
							bullets [gpit].y = (py >> 6) + PLAYER_BULLET_Y_OFFSET;
							bullets [gpit].my = 0;
							break;
						case FACING_DOWN:
							bullets [gpit].x = (px >> 6) + PLAYER_BULLET_X_OFFSET;
							bullets [gpit].y = (py >> 6) + 12;
							bullets [gpit].my = PLAYER_BULLET_SPEED;
							bullets [gpit].mx = 0;
							break;
						case FACING_UP:
							bullets [gpit].x = (px >> 6) + 8 - PLAYER_BULLET_X_OFFSET;
							bullets [gpit].y = (py >> 6) - 4;
							bullets [gpit].my = -PLAYER_BULLET_SPEED;
							bullets [gpit].mx = 0;
							break;
					}
				#else
					gpjt = (joyfunc) (&keys);

					#ifdef CAN_FIRE_UP
						if (!(gpjt & sp_UP)) {
							bullets [gpit].y = (py >> 6);
							bullets [gpit].my = -PLAYER_BULLET_SPEED;
						} else if (!(gpjt & sp_DOWN)) {
							bullets [gpit].y = 8 + (py >> 6);
							bullets [gpit].my = PLAYER_BULLET_SPEED;	 
						} else 
					#endif
					{
						bullets [gpit].y = (py >> 6) + PLAYER_BULLET_Y_OFFSET;
						bullets [gpit].my = 0;
					}
	

					#ifdef CAN_FIRE_UP
						if (!(gpjt & sp_LEFT) || !(gpjt & sp_RIGHT) || ((gpjt & sp_UP) && (gpjt & sp_DOWN))) {
					#endif
						if (pfacing == 0) {
							bullets [gpit].x = (px >> 6) - 4;
							bullets [gpit].mx = -PLAYER_BULLET_SPEED;
						} else {
							bullets [gpit].x = (px >> 6) + 12;
							bullets [gpit].mx = PLAYER_BULLET_SPEED;
						}
					#ifdef CAN_FIRE_UP
						} else {
							bullets [gpit].x = (px >> 6) + 4;
							bullets [gpit].mx = 0;
						}
					#endif
				#endif
	
				#ifdef MODE_128K
					wyz_play_sound (4);
				#else
					peta_el_beeper (6);
				#endif

				#ifdef LIMITED_BULLETS
					#if defined (LB_FRAMES) || !defined (ACTIVATE_SCRIPTING)
						bullets [gpit].life = LB_FRAMES;
					#else
						bullets [gpit].life = flags [LB_FRAMES_FLAG];
					#endif
				#endif

				break;
			}
		}
	}
#endif

#ifdef ENABLE_RANDOM_RESPAWN
	char player_hidden (void) {
		gpxx = gpx >> 4;
		gpyy = gpy >> 4;
		if ( (gpy & 15) == 0 && pvx == 0 ) {
			if (attr (gpxx, gpyy) == 2 || (attr (1 + gpxx, gpyy) == 2 && (gpx & 15)) ) {
				return 1;
			}
		}			
		return 0;
	}
#endif

#ifdef FIRE_TO_PUSH	
	unsigned char pushed_any;
#endif

#ifdef ACTIVATE_SCRIPTING
	void run_fire_script (void) {
		script = f_scripts [MAP_W * MAP_H];
		run_script ();
		script = f_scripts [n_pant];
		run_script ();
	}
#endif

#if defined(PLAYER_PUSH_BOXES) || !defined(DEACTIVATE_KEYS)
	void process_tile (unsigned char x0, unsigned char y0, signed char x1, signed char y1) {
		#ifdef PLAYER_PUSH_BOXES
			#ifdef FIRE_TO_PUSH
				gpit = (joyfunc) (&keys);
				#ifdef USE_TWO_BUTTONS
					if ((gpit & sp_FIRE) == 0 || sp_KeyPressed (key_fire))
				#else
					if ((gpit & sp_FIRE) == 0)
				#endif
			#endif		
			{
				if (qtile (x0, y0) == 14 && attr (x1, y1) == 0 && x1 >= 0 && x1 < 15 && y1 >= 0 && y1 < 10) {
					#if defined(ACTIVATE_SCRIPTING) && defined(ENABLE_PUSHED_SCRIPTING)
						flags [MOVED_TILE_FLAG] = map_buff [15 * y1 + x1];
						flags [MOVED_X_FLAG] = x1;
						flags [MOVED_Y_FLAG] = y1;
					#endif			
					
					// Mover
					map_attr [15 * y1 + x1] = 10;
					map_buff [15 * y1 + x1] = 14;
					map_attr [15 * y0 + x0] = 0;
					map_buff [15 * y0 + x0] = 0;
					
					// Pintar
					draw_coloured_tile (VIEWPORT_X + x0 + x0, VIEWPORT_Y + y0 + y0, 0);
					draw_coloured_tile (VIEWPORT_X + x1 + x1, VIEWPORT_Y + y1 + y1, 14);
					
					// Sonido
					#ifdef MODE_128K
						wyz_play_sound (3);
					#else			
						peta_el_beeper (2);	
					#endif

					#ifdef FIRE_TO_PUSH			
						// Para no disparar...
						pushed_any = 1;
					#endif
					
					#if defined(ACTIVATE_SCRIPTING) && defined(ENABLE_PUSHED_SCRIPTING) && defined(PUSHING_ACTION)
						// Call scripting
						just_pushed = 1;
						run_fire_script ();
						just_pushed = 0;
					#endif
				} 
			}			
		#endif

		#ifndef DEACTIVATE_KEYS
			if (qtile (x0, y0) == 15 && pkeys) {
				map_attr [15 * y0 + x0] = 0;
				map_buff [15 * y0 + x0] = 0;
		
				#ifdef COMPRESSED_LEVELS
					#ifdef MODE_128K
						for (gpit = 0; gpit < MAX_CERROJOS; gpit ++)
					#else
						for (gpit = 0; gpit < n_bolts; gpit ++)
					#endif
				#else		
					for (gpit = 0; gpit < MAX_CERROJOS; gpit ++)
				#endif
				{
					if (cerrojos [gpit].x == x0 && cerrojos [gpit].y == y0 && cerrojos [gpit].np == n_pant) {
						cerrojos [gpit].st = 0;
						break;
					}
				}
				draw_coloured_tile (VIEWPORT_X + x0 + x0, VIEWPORT_Y + y0 + y0, 0);
				pkeys --;
		
				#ifdef MODE_128K
					wyz_play_sound (3);
				#else
					peta_el_beeper (8);
				#endif
			}
		#endif
	}
#endif

void kill_player (unsigned char sound) {
	if (plife == 0) return;
	plife --;

	#ifdef MODO_128K
		wyz_play_sound (sound);
	#else
		peta_el_beeper (sound);
	#endif

	#ifdef CP_RESET_WHEN_DYING
		#ifdef CP_RESET_ALSO_FLAGS
			mem_load ();
		#else
			n_pant = sg_pool [MAX_FLAGS];
			px = sg_pool [MAX_FLAGS + 1] << 10;
			py = sg_pool [MAX_FLAGS + 2] << 10;
		#endif	
		draw_scr ();
	#endif
}

unsigned char move (void) {
	wall_v = wall_h = 0;
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
		if (pvy < PLAYER_MAX_VY_CAYENDO)
			pvy += PLAYER_G;
		else
			pvy = PLAYER_MAX_VY_CAYENDO;
		
		#ifdef PLAYER_CUMULATIVE_JUMP
			if (!psaltando)
		#endif
		
		if (pgotten) pvy = 0;		
	#else
		// Si lo es, entonces el movimiento vertical se comporta exactamente igual que 
		// el horizontal.
		if ( ! ((gpit & sp_UP) == 0 || (gpit & sp_DOWN) == 0)) {
			pfacing_v = 0xff;
			if (pvy > 0) {
				pvy -= PLAYER_RX;
				if (pvy < 0)
					pvy = 0;
			} else if (pvy < 0) {
				pvy += PLAYER_RX;
				if (pvy > 0)
					pvy = 0;
			}
		}

		if ((gpit & sp_UP) == 0) {
			pfacing_v = FACING_UP;
			if (pvy > -PLAYER_MAX_VX) {
				pvy -= PLAYER_AX;
			}
		}

		if ((gpit & sp_DOWN) == 0) {
			pfacing_v = FACING_DOWN;
			if (pvy < PLAYER_MAX_VX) {
				pvy += PLAYER_AX;
			}
		}
	#endif

	#ifdef PLAYER_HAS_JETPAC
		if ((gpit & sp_UP) == 0) {
			pvy -= PLAYER_INCR_JETPAC;
			if (pvy < -PLAYER_MAX_VY_JETPAC) pvy = -PLAYER_MAX_VY_JETPAC;
		}
	#endif

	py += pvy;
	
	// Safe
		
	if (py < 0)
		py = 0;
		
	if (py > 9216)
		py = 9216;

	
	/* El problema es que no es tan fácil... Hay que ver si no nos chocamos.
	   Si esto pasa, hay que "recular" hasta el borde del obstáculo.

	   Por eso miramos el signo de vy, para que los cálculos sean más sencillos.
	   De paso vamos a precalcular un par de cosas para que esto vaya más rápido.
	*/

	gpx = px >> 6;				// dividimos entre 64 para pixels, y luego entre 16 para tiles.
	gpy = py >> 6;
	gpxx = gpx >> 4;
	gpyy = gpy >> 4;
	
	// Ya	
	possee = 0;
	hit_v = 0;
	#ifdef BOUNDING_BOX_8_BOTTOM	
		if (pvy < 0) { 			// estamos ascendiendo
			if ((gpy & 15) < 8) {
				if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) & 8) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) & 8)) {
					#ifdef PLAYER_BOUNCE_WITH_WALLS
						pvy = -(pvy / 2);
					#else				
						pvy = 0;
					#endif
					py = ((gpyy + 1) << 10) - 512;
					wall_v = WTOP;
				} else if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) & 1) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) & 1)) {
					hit_v = 1; 
				}
			}
		} else if (pvy > 0 && (gpy & 15) < 8) { 	// estamos descendiendo
			if (py < 9216) {
				if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) & 12) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) & 12)) {
					#if defined(PLAYER_BOUNCE_WITH_WALLS) && defined(PLAYER_MOGGY_STYLE)
						pvy = -(pvy / 2);
					#else				
						#ifdef PLAYER_CUMULATIVE_JUMP
							if (!psaltando)
						#endif				
						pvy = 0;
					#endif
					py = gpyy << 10;
					wall_v = WBOTTOM;
					possee = 1;
				} else if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) & 1) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) & 1)) {
					hit_v = 1;
				}
			}
		}
	#else
		#ifdef BOUNDING_BOX_8_CENTERED
			if (pvy < 0) { 			
				if ((gpy & 15) < 12) {
					if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) & 8) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) & 8)) {
						#ifdef PLAYER_BOUNCE_WITH_WALLS
							pvy = -(pvy / 2);
						#else				
							pvy = 0;
						#endif
						py = ((gpyy + 1) << 10) - 256;
						wall_v = WTOP;
					} else if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) & 1) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) & 1)) {
						hit_v = 1; 
					}
				}
			} else if (pvy > 0 && (gpy & 15) >= 4) { 	
				if (py < 9216) {
					if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) & 12) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) & 12)) {
						#if defined(PLAYER_BOUNCE_WITH_WALLS) && defined(PLAYER_MOGGY_STYLE)
							pvy = -(pvy / 2);
						#else
							#ifdef PLAYER_CUMULATIVE_JUMP
								if (!psaltando)
							#endif
							pvy = 0;
						#endif
						py = (gpyy << 10) + 256;
						wall_v = WBOTTOM;
						possee = 1;
					} else if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) & 1) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) & 1)) {
						hit_v = 1; 
					}
				}
			}
		#else
			if (pvy < 0) { 		
				if (attr (gpxx, gpyy) & 8 || ((gpx & 15) && attr (gpxx + 1, gpyy) & 8)) {
					#ifdef PLAYER_BOUNCE_WITH_WALLS
						pvy = -(pvy / 2);
					#else				
						pvy = 0;
					#endif
					py = (gpyy + 1) << 10;
					wall_v = WTOP;	
				} else if (attr (gpxx, gpyy) & 1 || ((gpx & 15) && attr (gpxx + 1, gpyy) & 1)) {
					hit_v = 1; 
				}
			} else if (pvy > 0 && (gpy & 15) < 8) {
				if (py < 9216) {
					if (attr (gpxx, gpyy + 1) & 12 || ((gpx & 15) && attr (gpxx + 1, gpyy + 1) & 12))
					{
						#if defined(PLAYER_BOUNCE_WITH_WALLS) && defined(PLAYER_MOGGY_STYLE)
							pvy = -(pvy / 2);
						#else				
							#ifdef PLAYER_CUMULATIVE_JUMP
								if (!psaltando)
							#endif
							pvy = 0;
						#endif
						py = gpyy << 10;
						possee = 1;
						wall_v = WBOTTOM;
					} else if (attr (gpxx, gpyy + 1) & 1 || ((gpx & 15) && attr (gpxx + 1, gpyy + 1) & 1)) {
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

		#if defined (PLAYER_CAN_FIRE) && !defined (USE_TWO_BUTTONS)
	
			#ifdef PLAYER_CUMULATIVE_JUMP
				if (((gpit & sp_UP) == 0) && (possee || pgotten || hit_v)) {
					pvy = -pvy - PLAYER_VY_INICIAL_SALTO;
					if (pvy < -PLAYER_MAX_VY_SALTANDO) pvy = -PLAYER_MAX_VY_SALTANDO;
			#else		
				if (((gpit & sp_UP) == 0) && psaltando == 0 && (possee || pgotten || hit_v)) {
			#endif
				psaltando = 1;
				pcont_salto = 0;
				#ifdef MODE_128K
					wyz_play_sound (2);
				#else
					peta_el_beeper (3);
				#endif
			}

			#ifndef PLAYER_CUMULATIVE_JUMP	
				if ( ((gpit & sp_UP) == 0) && psaltando ) {
					pvy -= (PLAYER_VY_INICIAL_SALTO + PLAYER_INCR_SALTO - (pcont_salto>>1));
					if (pvy < -PLAYER_MAX_VY_SALTANDO) pvy = -PLAYER_MAX_VY_SALTANDO;
					pcont_salto ++;
					if (pcont_salto == 8)
						psaltando = 0;
				}
			#endif
			
			if ((gpit & sp_UP))
				psaltando = 0;
		
		#elif defined (PLAYER_CAN_FIRE) && defined (USE_TWO_BUTTONS)

			#ifdef PLAYER_CUMULATIVE_JUMP
				if (sp_KeyPressed (key_jump) && (possee || pgotten || hit_v)) {
					pvy = -pvy - PLAYER_VY_INICIAL_SALTO;
					if (pvy < -PLAYER_MAX_VY_SALTANDO) pvy = -PLAYER_MAX_VY_SALTANDO;
			#else		
				if (sp_KeyPressed (key_jump) && psaltando == 0 && (possee || pgotten || hit_v)) {
			#endif
				psaltando = 1;
				pcont_salto = 0;
				#ifdef MODE_128K
					wyz_play_sound (2);
				#else				
					peta_el_beeper (3);
				#endif
			}

			#ifndef PLAYER_CUMULATIVE_JUMP	
				if (sp_KeyPressed (key_jump) && psaltando ) {
					pvy -= (PLAYER_VY_INICIAL_SALTO + PLAYER_INCR_SALTO - (pcont_salto>>1));
					if (pvy < -PLAYER_MAX_VY_SALTANDO) pvy = -PLAYER_MAX_VY_SALTANDO;
					pcont_salto ++;
					if (pcont_salto == 8)
						psaltando = 0;
				}
			#endif
	
			if (!sp_KeyPressed (key_jump))
				psaltando = 0;

		#else

			#ifdef PLAYER_CUMULATIVE_JUMP
				if (((gpit & sp_FIRE) == 0) && (possee || pgotten || hit_v)) {
					pvy = -pvy - PLAYER_VY_INICIAL_SALTO;
					if (pvy < -PLAYER_MAX_VY_SALTANDO) pvy = -PLAYER_MAX_VY_SALTANDO;
			#else
				if (((gpit & sp_FIRE) == 0) && psaltando == 0 && (possee || pgotten || hit_v)) {
			#endif
				psaltando = 1;
				pcont_salto = 0;
				#ifdef MODE_128K
					wyz_play_sound (2);
				#else				
					peta_el_beeper (3);
				#endif
			}

			#ifndef PLAYER_CUMULATIVE_JUMP	
				if ( ((gpit & sp_FIRE) == 0) && psaltando ) {
					pvy -= (PLAYER_VY_INICIAL_SALTO + PLAYER_INCR_SALTO - (pcont_salto>>1));
					if (pvy < -PLAYER_MAX_VY_SALTANDO) pvy = -PLAYER_MAX_VY_SALTANDO;
					pcont_salto ++;
					if (pcont_salto == 8)
						psaltando = 0;
				}
			#endif

			if ((gpit & sp_FIRE))
				psaltando = 0;
		#endif
	#endif

	// Bootee engine
	#ifdef PLAYER_BOOTEE
		if ( psaltando == 0 && (possee || pgotten || hit_v) ) {
			psaltando = 1;
			pcont_salto = 0;
			#ifdef MODE_128K
					wyz_play_sound (2);
			#else				
					peta_el_beeper (3);
			#endif
		}
		
		if (psaltando ) {
			pvy -= (PLAYER_VY_INICIAL_SALTO + PLAYER_INCR_SALTO - (pcont_salto>>1));
			if (pvy < -PLAYER_MAX_VY_SALTANDO) pvy = -PLAYER_MAX_VY_SALTANDO;
			pcont_salto ++;
			if (pcont_salto == 8)
				psaltando = 0;
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
			pfacing_h = 0xff;
		#endif
		if (pvx > 0) {
			pvx -= PLAYER_RX;
			if (pvx < 0)
				pvx = 0;
		} else if (pvx < 0) {
			pvx += PLAYER_RX;
			if (pvx > 0)
				pvx = 0;
		}
	}

	if ((gpit & sp_LEFT) == 0) {
		#ifdef PLAYER_MOGGY_STYLE
			pfacing_h = FACING_LEFT;
		#endif
		if (pvx > -PLAYER_MAX_VX) {
			#ifndef PLAYER_MOGGY_STYLE			
				pfacing = 0;
			#endif
			pvx -= PLAYER_AX;
		}
	}

	if ((gpit & sp_RIGHT) == 0) {
		#ifdef PLAYER_MOGGY_STYLE	
			pfacing_h = FACING_RIGHT;
		#endif
		if (pvx < PLAYER_MAX_VX) {
			pvx += PLAYER_AX;
			#ifndef PLAYER_MOGGY_STYLE						
				pfacing = 1;
			#endif
		}
	}

	px = px + pvx;
	
	// Safe
	
	if (px < 0)
		px = 0;
		
	if (px > 14336)
		px = 14336;
		
	/* Ahora, como antes, vemos si nos chocamos con algo, y en ese caso
	   paramos y reculamos */

	gpy = py >> 6;
	gpx = px >> 6;
	gpyy = gpy >> 4;
	gpxx = gpx >> 4;
	hit_h = 0;
#ifdef BOUNDING_BOX_8_BOTTOM	
	if (pvx < 0 && (gpx & 15) < 12) {
		if ( ((gpy & 15) < 8 && attr (gpxx, gpyy) & 8) || ((gpy & 15) && attr (gpxx, gpyy + 1) & 8)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
			pvx = -(pvx / 2);
#else				
			pvx = 0;
#endif
			px = ((gpxx + 1) << 10) - 256;
			wall_h = WLEFT;
		} else if ( ((gpy & 15) < 8 && attr (gpxx, gpyy) & 1) || ((gpy & 15) && attr (gpxx, gpyy + 1) & 1)) {
			hit_h = 1; 
		}
	} else if ((gpx & 15) >= 4) {
		if ( ((gpy & 15) < 8 && attr (gpxx + 1, gpyy) & 8) || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) & 8)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
			pvx = -(pvx / 2);
#else				
			pvx = 0;
#endif
			px = (gpxx << 10) + 256;
			wall_h = WRIGHT;
		} else if ( ((gpy & 15) < 8 && attr (gpxx + 1, gpyy) & 1) || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) & 1)) {
			hit_h = 1; 
		}
	}
#else
#ifdef BOUNDING_BOX_8_CENTERED
	if (pvx < 0 && (gpx & 15) < 12) {
		if ( ((gpy & 15) < 12 && attr (gpxx, gpyy) & 8) || ((gpy & 15) > 4 && attr (gpxx, gpyy + 1) & 8)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
			pvx = -(pvx / 2);
#else				
			pvx = 0;
#endif
			px = ((gpxx + 1) << 10) - 256;
			wall_h = WLEFT;
		} else if ( ((gpy & 15) < 8 && attr (gpxx, gpyy) & 1) || ((gpy & 15) && attr (gpxx, gpyy + 1) & 1)) {
			hit_h = 1; 
		}
	} else if ((gpx & 15) >= 4) {
		if ( ((gpy & 15) < 12 && attr (gpxx + 1, gpyy) & 8) || ((gpy & 15) > 4 && attr (gpxx + 1, gpyy + 1) & 8)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
			pvx = -(pvx / 2);
#else				
			pvx = 0;
#endif
			px = (gpxx << 10) + 256;
			wall_h = WRIGHT;
		} else if ( ((gpy & 15) < 8 && attr (gpxx + 1, gpyy) & 1) || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) & 1)) {
			hit_h = 1; 
		}
	}
#else
	if (pvx < 0) {
		if (attr (gpxx, gpyy) & 8 || ((gpy & 15) && attr (gpxx, gpyy + 1) & 8)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
			pvx = -(pvx / 2);
#else				
			pvx = 0;
#endif
			px = (gpxx + 1) << 10;
			wall_h = WLEFT;
		} else if (attr (gpxx, gpyy) & 1 || ((gpy & 15) && attr (gpxx, gpyy + 1) & 1)) {
			hit_h = 1; 
		}
	} else {
		if (attr (gpxx + 1, gpyy) & 8 || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) & 8)) {
#ifdef PLAYER_BOUNCE_WITH_WALLS
			pvx = -(pvx / 2);
#else				
			pvx = 0;
#endif
			px = gpxx << 10;
			wall_h = WRIGHT;
		} else if (attr (gpxx + 1, gpyy) & 1 || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) & 1)) {
			hit_h = 1; 
		}
	}
#endif
#endif

#ifdef PLAYER_MOGGY_STYLE
	// Priority to decide facing
	#ifdef TOP_OVER_SIDE
		if (pfacing_v != 0xff) {
			pfacing = pfacing_v;
		} else if (pfacing_h != 0xff) {
			pfacing = pfacing_h;
		}
	#else
		if (pfacing_h != 0xff) {
			pfacing = pfacing_h;
		} else if (pfacing_v != 0xff) {
			pfacing = pfacing_v;
		}
	#endif	
#endif

#ifdef FIRE_TO_PUSH	
pushed_any = 0;
#endif

#if defined(PLAYER_PUSH_BOXES) || !defined(DEACTIVATE_KEYS)
	// Empujar cajas (tile #14)
	gpx = px >> 6;
	gpy = py >> 6;
	gpxx = gpx >> 4;
	gpyy = gpy >> 4;
	
	// En modo plataformas, no se puede empujar verticalmente
#ifdef PLAYER_MOGGY_STYLE
	
	if (wall_v == WTOP) {
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
	} else if (wall_v == WBOTTOM) {
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
	
	if (wall_h == WRIGHT) {
		if (attr (gpxx + 1, gpyy) == 10) {
			process_tile (gpxx + 1, gpyy, gpxx + 2, gpyy);
		}
		if ((gpy & 15)) {
			if (attr (gpxx + 1, gpyy + 1) == 10) {
				process_tile (gpxx + 1, gpyy + 1, gpxx + 2, gpyy + 1);
			}
		}
	} else if (wall_h == WLEFT) {
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

#ifdef PLAYER_CAN_FIRE
	// Disparos
#ifdef USE_TWO_BUTTONS
#ifdef FIRE_TO_PUSH	
	if (((gpit & sp_FIRE) == 0 || sp_KeyPressed (key_fire)) && pdisparando == 0 && !pushed_any) {
#else
	if (((gpit & sp_FIRE) == 0 || sp_KeyPressed (key_fire)) && pdisparando == 0) {
#endif
#else
#ifdef FIRE_TO_PUSH	
	if ((gpit & sp_FIRE) == 0 && pdisparando == 0 && !pushed_any) {
#else
	if ((gpit & sp_FIRE) == 0 && pdisparando == 0) {
#endif
#endif
		pdisparando = 1;
		fire_bullet ();
	}
	
	if ((gpit & sp_FIRE)) 
		pdisparando = 0;

#endif

#ifndef DEACTIVATE_EVIL_TILE
	// Tiles que te matan. 
	// hit_v tiene preferencia sobre hit_h
	hit = 0;
	if (hit_v) {
		hit = 1;
#ifdef FULL_BOUNCE
		pvy = addsign (-pvy, PLAYER_MAX_VX);
#else
		pvy = -pvy;
#endif
	} else if (hit_h) {
		hit = 1;
#ifdef FULL_BOUNCE
		pvx = addsign (-pvx, PLAYER_MAX_VX);
#else
		pvx = -pvx;
#endif
	}
	if (hit) {
#ifdef PLAYER_FLICKERS
		if (pestado == EST_NORMAL) {
			pestado = EST_PARP;
			pct_estado = 50;
#else
		{
#endif		
#ifdef MODE_128K
			kill_player (8);
#else		
			kill_player (4);
#endif
		}
	}
#endif

	// Select animation frame 
	
#ifndef PLAYER_MOGGY_STYLE
#ifdef PLAYER_BOOTEE
	gpit = pfacing << 2;
	if (pvy == 0) {
		pnext_frame = player_frames [gpit];
	} else if (pvy < 0) {
		pnext_frame = player_frames [gpit + 1];
	} else {
		pnext_frame = player_frames [gpit + 2];
	}
#else	
	if (!possee && !pgotten) {
		pnext_frame = player_frames [8 + pfacing];
	} else {
		gpit = pfacing << 2;
		if (pvx == 0) {
#ifdef PLAYER_ALTERNATE_ANIMATION
			pnext_frame = player_frames [gpit];
#else
			pnext_frame = player_frames [gpit + 1];
#endif
		} else {
			psubframe ++;
			if (psubframe == 4) {
				psubframe = 0;
#ifdef PLAYER_ALTERNATE_ANIMATION
				pframe ++; if (pframe == 3) pframe = 0;
#else
				pframe = (pframe + 1) & 3;
#endif
#ifdef PLAYER_STEP_SOUND
				step ();
#endif
			}
			pnext_frame = player_frames [gpit + pframe];
		}
	}
#endif
#else
	
	if (pvx || pvy) {
		psubframe ++;
		if (psubframe == 4) {
			psubframe = 0;
			pframe = !pframe;
#ifdef PLAYER_STEP_SOUND			
			step (); 
#endif
		}
	}
	
	pnext_frame = player_frames [pfacing + pframe];
#endif
}

void draw_scr_background (void) {
#ifdef UNPACKED_MAP
	map_pointer = mapa + (n_pant * 150);
#else
	map_pointer = mapa + (n_pant * 75);
#endif
	srand (n_pant);
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
#ifdef BREAKABLE_WALLS
		brk_buff [gpit] = 0;
#endif		
		draw_coloured_tile (VIEWPORT_X + gpx, VIEWPORT_Y + gpy, gpd);	
#ifdef ENABLE_TILANIMS
		// Detect tilanims
		if (gpd >= ENABLE_TILANIMS) {
			add_tilanim (gpx >> 1, gpy >> 1, gpd);	
		}
#endif
			
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

#ifndef USE_HOTSPOTS_TYPE_3
	if ((hotspots [n_pant].act == 1 && hotspots [n_pant].tipo) ||
		(hotspots [n_pant].act == 0 && (rand () & 7) == 2)) {
		hotspot_x = gpx << 4;
		hotspot_y = gpy << 4;
		orig_tile = map_buff [15 * gpy + gpx];
		draw_coloured_tile (VIEWPORT_X + gpx + gpx, VIEWPORT_Y + gpy + gpy, 16 + (hotspots [n_pant].act ? hotspots [n_pant].tipo : 0));
	}
#else
	// Modificación para que los hotspots de tipo 3 sean recargas directas:
	if (hotspots [n_pant].act == 1 && hotspots [n_pant].tipo) {
        hotspot_x = gpx << 4;
        hotspot_y = gpy << 4;
        orig_tile = map_buff [15 * gpy + gpx];
        draw_coloured_tile (VIEWPORT_X + gpx + gpx, VIEWPORT_Y + gpy + gpy, 16 + (hotspots [n_pant].tipo != 3 ? hotspots [n_pant].tipo : 0));
    }
#endif

#ifndef DEACTIVATE_KEYS
	// Open locks
#if defined (COMPRESSED_LEVELS) && !defined (MODE_128K)
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
}

void draw_scr (void) {
#ifdef ENABLE_TILANIMS
	max_tilanims = 0;
#endif

#ifdef ENABLE_FIRE_ZONE
	f_zone_ac = 0;
#endif	

	draw_scr_background ();
	
	// Movemos y cambiamos a los enemigos según el tipo que tengan
	enoffs = n_pant * 3;
	
	for (gpit = 0; gpit < 3; gpit ++) {
		en_an_frame [gpit] = 0;
		en_an_count [gpit] = 3;
		en_an_state [gpit] = 0;
#ifdef ENABLE_RANDOM_RESPAWN
		en_an_fanty_activo [gpit] = 0;
#endif
#ifdef RESPAWN_ON_ENTER
		// Back to life!
		
		malotes [enoffs + gpit].t &= 0xEF;		
#ifdef PLAYER_CAN_FIRE
#if defined (COMPRESSED_LEVELS) && defined (MODE_128K)
		malotes [enoffs + gpit].life = level_data.enems_life;
#else
		malotes [enoffs + gpit].life = ENEMIES_LIFE_GAUGE;
#endif
#endif
#endif
		switch (malotes [enoffs + gpit].t) {
			case 1:
			case 2:
			case 3:
			case 4:
				en_an_base_frame [gpit] = (malotes [enoffs + gpit].t - 1) << 1;
				break;
#ifdef ENABLE_RANDOM_RESPAWN
			case 5: 
				en_an_base_frame [gpit] = 4;
				break;
#endif
#ifdef ENABLE_CUSTOM_TYPE_6
			case 6:
				// Añade aquí tu código custom. Esto es un ejemplo:
				en_an_base_frame [gpit] = TYPE_6_FIXED_SPRITE << 1;
				en_an_x [gpit] = malotes [enoffs + gpit].x << 6;
				en_an_y [gpit] = malotes [enoffs + gpit].y << 6;
				en_an_vx [gpit] = en_an_vy [gpit] = 0;
				en_an_state [gpit] = TYPE_6_IDLE;				
				break;				
#endif
#ifdef ENABLE_PURSUERS
			case 7:
				en_an_alive [gpit] = 0;
				en_an_dead_row [gpit] = 0;//DEATH_COUNT_EXPRESSION;
				break;
#endif
			default:
				en_an_next_frame [gpit] = sprite_18_a;
		}
	}
	
#ifdef ACTIVATE_SCRIPTING
#ifdef LINE_OF_TEXT
	print_str (LINE_OF_TEXT_X, LINE_OF_TEXT, LINE_OF_TEXT_ATTR, "                              ");
#endif
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

void select_joyfunc (void) {
#ifdef MODE_128K
#else
	#asm
		; Music generated by beepola
		call musicstart
	#endasm
#endif
	
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
#ifdef MODE_128K
	wyz_play_sound (0);
	sp_WaitForNoKey ();
#else
	#asm
		di
	#endasm
#endif
}

#ifdef BREAKABLE_WALLS
void break_wall (unsigned char x, unsigned char y) {
	gpaux = (y << 4) - y + x;
	if (brk_buff [gpaux] < BREAKABLE_WALLS_LIFE) {
		brk_buff [gpaux] ++;
		gpaux = 6;
	} else {
		map_attr [gpaux] = 0;
		map_buff [gpaux] = 0;
		draw_coloured_tile (VIEWPORT_X + x + x, VIEWPORT_Y + y + y, 0);
		gpaux = 7;
	}
#ifdef MODE_128K
	wyz_play_sound (gpaux);
#else			
	peta_el_beeper (gpaux);
#endif
}
#endif

#ifdef PLAYER_CAN_FIRE
void mueve_bullets (void) {
	for (gpit = 0; gpit < MAX_BULLETS; gpit ++) {
		if (bullets [gpit].estado) {			
			if (bullets [gpit].mx) {
				bullets [gpit].x += bullets [gpit].mx;								
				if (bullets [gpit].x > 240) {
					bullets [gpit].estado = 0;
				}
			} 
#if defined(PLAYER_MOGGY_STYLE) || defined(CAN_FIRE_UP)
			if (bullets [gpit].my) {
				bullets [gpit].y += bullets [gpit].my;
				if (bullets [gpit].y < 8 || bullets [gpit].y > 160) {
					bullets [gpit].estado = 0;
				}
			}
#endif
			gpxx = (bullets [gpit].x + 3) >> 4;
			gpyy = (bullets [gpit].y + 3) >> 4;
#ifdef BREAKABLE_WALLS			
			if (attr (gpxx, gpyy) & 16) break_wall (gpxx, gpyy);
#endif
			if (attr (gpxx, gpyy) > 7) bullets [gpit].estado = 0;
			
#ifdef LIMITED_BULLETS
			if (bullets [gpit].life > 0) {
				bullets [gpit].life --;
			} else {
				bullets [gpit].estado = 0;
			}
#endif
			
		}	
	}	
}
#endif	

// Total rewrite

#ifdef WALLS_STOP_ENEMIES
unsigned char  mons_col_sc_x (void) {
	gpaux = gpen_xx + ctileoff (malotes [enoffsmasi].mx);
#ifdef EVERYTHING_IS_A_WALL
	if (attr (gpaux, gpen_yy) || ((malotes [enoffsmasi].y & 15) && attr (gpaux, gpen_yy + 1))) {
#else	
	if (attr (gpaux, gpen_yy) & 8 || ((malotes [enoffsmasi].y & 15) && attr (gpaux, gpen_yy + 1) & 8)) {
#endif
		return 1;
	}
	return 0;
}
	
unsigned char  mons_col_sc_y (void) {
	gpaux = gpen_yy + ctileoff (malotes [enoffsmasi].my);
#ifdef EVERYTHING_IS_A_WALL
	if (attr (gpen_xx, gpaux) || ((malotes [enoffsmasi].x & 15) && attr (gpen_xx + 1, gpaux))) {
#else	
	if (attr (gpen_xx, gpaux) & 8 || ((malotes [enoffsmasi].x & 15) && attr (gpen_xx + 1, gpaux) & 8)) {
#endif
		return 1;
	}
	return 0;
}
#endif

#if defined(SLOW_DRAIN) && defined(PLAYER_BOUNCES)
unsigned char lasttimehit;
#endif

#ifdef ENABLE_CUSTOM_TYPE_6
// Funciones auxiliares custom
unsigned char distance (unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
	unsigned char dx = abs (x2 - x1);
	unsigned char dy = abs (y2 - y1);
	unsigned char mn = dx < dy ? dx : dy;
	return (dx + dy - (mn >> 1) - (mn >> 2) + (mn >> 4));
}
#endif

#if defined(ENABLE_CUSTOM_TYPE_6) || defined(ENABLE_RANDOM_RESPAWN)
int limit (int val, int min, int max) {
	if (val < min) return min;
	if (val > max) return max;
	return val;
}
#endif

void mueve_bicharracos (void) {
	gpx = px >> 6;
	gpy = py >> 6;
	
	tocado = 0;
	pgotten = 0;
	for (gpit = 0; gpit < 3; gpit ++) {
		active = 0;
		enoffsmasi = enoffs + gpit;
		gpen_x = malotes [enoffsmasi].x;
		gpen_y = malotes [enoffsmasi].y;		
		gpt = malotes [enoffsmasi].t;
#ifdef ENABLE_RANDOM_RESPAWN
		if (en_an_fanty_activo [gpit]) gpt = 5;
#endif

		if (en_an_state [gpit] == GENERAL_DYING) {
			en_an_count [gpit] --;
			if (en_an_count [gpit] == 0) {
				en_an_state [gpit] = 0;
				en_an_next_frame [gpit] = sprite_18_a;
				continue;
			}
		}

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
				gpen_cx = en_an_x [gpit] >> 6;
				gpen_cy = en_an_y [gpit] >> 6;
				if (player_hidden ()) {
					en_an_vx [gpit] = limit (
						en_an_vx [gpit] + addsign (en_an_x [gpit] - px, FANTY_A >> 1),
						-FANTY_MAX_V, FANTY_MAX_V);
					en_an_vy [gpit] = limit (
						en_an_vy [gpit] + addsign (en_an_y [gpit] - py, FANTY_A >> 1),
						-FANTY_MAX_V, FANTY_MAX_V);
				} else if ((rand () & 7) > 1) {
					en_an_vx [gpit] = limit (
						en_an_vx [gpit] + addsign (px - en_an_x [gpit], FANTY_A),
						-FANTY_MAX_V, FANTY_MAX_V);
					en_an_vy [gpit] = limit (
						en_an_vy [gpit] + addsign (py - en_an_y [gpit], FANTY_A),
						-FANTY_MAX_V, FANTY_MAX_V);
				}
								
				en_an_x [gpit] = limit (en_an_x [gpit] + en_an_vx [gpit], 0, 14336);
				en_an_y [gpit] = limit (en_an_y [gpit] + en_an_vy [gpit], 0, 9216);
							
				break;
#endif
#ifdef ENABLE_CUSTOM_TYPE_6
			case 6:	
				active = 1;
				gpen_cx = en_an_x [gpit] >> 6;
				gpen_cy = en_an_y [gpit] >> 6;
				switch (en_an_state [gpit]) {
					case TYPE_6_IDLE:
						if (distance (gpx, gpy, gpen_cx, gpen_cy) <= SIGHT_DISTANCE)
							en_an_state [gpit] = TYPE_6_PURSUING;
						break;
					case TYPE_6_PURSUING:
						if (distance (gpx, gpy, gpen_cx, gpen_cy) > SIGHT_DISTANCE) {
							en_an_state [gpit] = TYPE_6_RETREATING;
						} else {
							en_an_vx [gpit] = limit (
								en_an_vx [gpit] + addsign (px - en_an_x [gpit], FANTY_A),
								-FANTY_MAX_V, FANTY_MAX_V);
							en_an_vy [gpit] = limit (
								en_an_vy [gpit] + addsign (py - en_an_y [gpit], FANTY_A),
								-FANTY_MAX_V, FANTY_MAX_V);
								
							en_an_x [gpit] = limit (en_an_x [gpit] + en_an_vx [gpit], 0, 14336);
							en_an_y [gpit] = limit (en_an_y [gpit] + en_an_vy [gpit], 0, 9216);
						}
						break;
					case TYPE_6_RETREATING:
						en_an_x [gpit] += addsign (malotes [enoffsmasi].x - gpen_cx, 64);
						en_an_y [gpit] += addsign (malotes [enoffsmasi].y - gpen_cy, 64);
						
						if (distance (gpx, gpy, gpen_cx, gpen_cy) <= SIGHT_DISTANCE)
							en_an_state [gpit] = TYPE_6_PURSUING;
						break;						
				}
				gpen_cx = en_an_x [gpit] >> 6;
				gpen_cy = en_an_y [gpit] >> 6;
				if (en_an_state [gpit] == TYPE_6_RETREATING && 
					gpen_cx == malotes [enoffsmasi].x && 
					gpen_cy == malotes [enoffsmasi].y
					) 
					en_an_state [gpit] = TYPE_6_IDLE;
				break;
#endif
#ifdef ENABLE_PURSUERS
			case 7:
				switch (en_an_alive [gpit]) {
					case 0:
						if (!en_an_dead_row [gpit]) {
							malotes [enoffsmasi].x = malotes [enoffsmasi].x1;
							malotes [enoffsmasi].y = malotes [enoffsmasi].y1;
							en_an_alive [gpit] = 1;
							en_an_rawv [gpit] = 1 << (rand () % 5);
							if (en_an_rawv [gpit] > 4) en_an_rawv [gpit] = 2;
							en_an_dead_row [gpit] = 11 + (rand () & 7);
#if defined(PLAYER_KILLS_ENEMIES) || defined(PLAYER_CAN_FIRE)							
							malotes [enoffsmasi].life = ENEMIES_LIFE_GAUGE;
#endif							
						} else {
							en_an_dead_row [gpit] --;
						}
						break;
					case 1:
						if (!en_an_dead_row [gpit]) {
#ifdef TYPE_7_FIXED_SPRITE
							en_an_base_frame [gpit] = (TYPE_7_FIXED_SPRITE - 1) << 1;
#else							
							en_an_base_frame [gpit] = (rand () & 3) << 1;
#endif							
							en_an_alive [gpit] = 2;
						} else {
							en_an_dead_row [gpit] --;
							en_an_next_frame [gpit] = sprite_17_a;
						}
						break;
					case 2:
						active = 1;
						if (pestado == EST_NORMAL) {
							malotes [enoffsmasi].mx = (signed char) (addsign (((gpx >> 2) << 2) - gpen_x, en_an_rawv [gpit]));
							malotes [enoffsmasi].x += malotes [enoffsmasi].mx;
							gpen_xx = malotes [enoffsmasi].x >> 4;
							gpen_yy = malotes [enoffsmasi].y >> 4;
#ifdef WALLS_STOP_ENEMIES
							if (mons_col_sc_x ()) malotes [enoffsmasi].x = gpen_x;
#endif
							malotes [enoffsmasi].my = (signed char) (addsign (((gpy >> 2) << 2) - gpen_y, en_an_rawv [gpit]));
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
/*
			default:
				if (en_an_state [gpit] != GENERAL_DYING) en_an_next_frame [gpit] = sprite_18_a;
*/
		}
		
		if (active) {			
			// Animate
			en_an_count [gpit] ++; 
			if (en_an_count [gpit] == 4) {
				en_an_count [gpit] = 0;
				en_an_frame [gpit] = !en_an_frame [gpit];
				en_an_next_frame [gpit] = enem_frames [en_an_base_frame [gpit] + en_an_frame [gpit]];
			}
			
			// Collide with player
			
#ifndef PLAYER_MOGGY_STYLE
			// Platforms
			if (malotes [enoffsmasi].t == 4) {
				gpxx = gpx >> 4;
				if (gpx + 15 >= gpen_cx && gpx <= gpen_cx + 15) {
					if (malotes [enoffsmasi].my < 0) {
						if (gpy + 16 >= gpen_cy && gpy + 9 <= gpen_cy && pvy >= -(PLAYER_INCR_SALTO)) {
							pgotten = 1;
							py = (gpen_cy - 16) << 6;
#ifdef PLAYER_CUMULATIVE_JUMP
							if (!psaltando)	
#endif							
							pvy = 0;
							gpyy = gpy >> 4;
#ifdef BOUNDING_BOX_8_BOTTOM	
							if ((gpy & 15) < 8) {
								if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) & 8) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) & 8)) {
#else
#ifdef BOUNDING_BOX_8_CENTERED
							if ((gpy & 15) < 12) {
								if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) & 8) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) & 8)) {
#else				
							{
								if (attr (gpxx, gpyy) & 8 || ((gpx & 15) && attr (gpxx + 1, gpyy) & 8)) {
#endif
#endif
									py = (gpyy + 1) << 10;
								}
							}
						}
					} else if (malotes [enoffsmasi].my > 0) {
						if (gpy + 20 >= gpen_cy && gpy + 14 <= gpen_cy && pvy >= 0) {
							pgotten = 1;
							py = (gpen_cy - 16) << 6;
#ifdef PLAYER_CUMULATIVE_JUMP
							if (!psaltando)	
#endif							
							pvy = 0;
							gpyy = gpy >> 4;
#ifdef BOUNDING_BOX_8_BOTTOM
							if ((gpy & 15) < 8) {
								if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) & 12) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) & 12)) {
#else									
#ifdef BOUNDING_BOX_8_CENTERED
							if ((gpy & 15) >= 4) {
								if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) & 12) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) & 12)) {
#else							
							{
								if (attr (gpxx, gpyy + 1) & 8 || ((gpx & 15) && attr (gpxx + 1, gpyy + 1) & 8)) {
#endif
#endif								
									py = gpyy << 10;
								}
							}
						}
					}
					gpy = py >> 6;
					if (malotes [enoffsmasi].mx && gpy + 16 >= gpen_cy && gpy + 8 <= gpen_cy && pvy >= 0) {
						pgotten = 1;
						py = (gpen_cy - 16) << 6;
						gpyy = gpy >> 4;
						gpx = gpx + malotes [enoffsmasi].mx;
						px = gpx << 6;
						gpxx = gpx >> 4;
						if (malotes [enoffsmasi].mx < 0) {
#ifdef BOUNDING_BOX_8_BOTTOM
							if ((gpx & 15) < 12) {
								if ( ((gpy & 15) < 8 && attr (gpxx, gpyy) & 8) || ((gpy & 15) && attr (gpxx, gpyy + 1) & 8)) {
#else
#ifdef BOUNDING_BOX_8_CENTERED
							if ((gpx & 15) < 12) {
								if ( ((gpy & 15) < 12 && attr (gpxx, gpyy) & 8) || ((gpy & 15) > 4 && attr (gpxx, gpyy + 1) & 8)) {
#else							
							{
								if (attr (gpxx, gpyy) & 8 || ((gpy & 15) && attr (gpxx, gpyy + 1) & 8)) {
#endif
#endif
									pvx = 0;
									px = (gpxx + 1) << 10;
								}
							}
						} else {
#ifdef BOUNDING_BOX_8_BOTTOM
							if ((gpx & 15) >= 4) {
								if ( ((gpy & 15) < 8 && attr (gpxx + 1, gpyy) & 8) || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) & 8)) {
#else
#ifdef BOUNDING_BOX_8_CENTERED
							if ((gpx & 15) >= 4) {
								if ( ((gpy & 15) < 12 && attr (gpxx + 1, gpyy) & 8) || ((gpy & 15) > 4 && attr (gpxx + 1, gpyy + 1) & 8)) {
#else									
							{
								if (attr (gpxx + 1, gpyy) & 8 || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) & 8)) {
#endif
#endif									
									pvx = 0;
									px = gpxx << 10;
								}
							}
						}
					}
				}
			} else if (!tocado && collide (gpx, gpy, gpen_cx, gpen_cy) && pestado == EST_NORMAL) {
#else
			if (!tocado && collide (gpx, gpy, gpen_cx, gpen_cy) && pestado == EST_NORMAL) {
#endif			
#ifdef PLAYER_KILLS_ENEMIES
				// Step over enemy		
#ifdef PLAYER_CAN_KILL_FLAG
				if (flags [PLAYER_CAN_KILL_FLAG] != 0 && 
					gpy < gpen_cy - 2 && pvy >= 0 && malotes [enoffsmasi].t >= PLAYER_MIN_KILLABLE) {
#else
				if (gpy < gpen_cy - 2 && pvy >= 0 && malotes [enoffsmasi].t >= PLAYER_MIN_KILLABLE) {
#endif				
#ifdef MODE_128K
					wyz_play_sound (6);										
					en_an_state [gpit] = GENERAL_DYING;
					en_an_count [gpit] = 12;
					en_an_next_frame [gpit] = sprite_17_a;
					malotes [enoffsmasi].t |= 16;			// Mark as dead
					pkilled ++;
					pvy = -256;
					
#else
					en_an_next_frame [gpit] = sprite_17_a;
					sp_MoveSprAbs (sp_moviles [gpit], spritesClip, en_an_next_frame [gpit] - en_an_current_frame [gpit], VIEWPORT_Y + (gpen_cy >> 3), VIEWPORT_X + (gpen_cx >> 3), gpen_cx & 7, gpen_cy & 7);
					en_an_current_frame [gpit] = en_an_next_frame [gpit];
					sp_UpdateNow ();

					peta_el_beeper (5);
					en_an_next_frame [gpit] = sprite_18_a;
					malotes [enoffsmasi].t |= 16;			// Mark as dead
					
					pkilled ++;
#endif					
#ifdef ACTIVATE_SCRIPTING					
					// Run this screen fire script or "entering any".
					script = f_scripts [n_pant];
					run_script ();
					script = e_scripts [MAP_W * MAP_H + 1];
					run_script ();
#endif
				} else {

					
#else
				{
#endif
					tocado = 1;
#if defined(SLOW_DRAIN) && defined(PLAYER_BOUNCES)
					if (!lasttimehit || ((maincounter & 3) == 0)) {
#ifdef MODE_128K
						kill_player (7);
#else							
						kill_player(4);
#endif
					}
#else
					
#ifdef MODE_128K
					kill_player (7);
#else							
					kill_player (4);
#endif
#endif					
#ifdef PLAYER_BOUNCES
#ifndef PLAYER_MOGGY_STYLE	
#ifdef RANDOM_RESPAWN
					if (!en_an_fanty_activo [gpit]) {
						pvx = addsign (malotes [enoffsmasi].mx, PLAYER_MAX_VX);
						pvy = addsign (malotes [enoffsmasi].my, PLAYER_MAX_VX);
					} else {
						pvx = en_an_vx [gpit] + en_an_vx [gpit];
						pvy = en_an_vy [gpit] + en_an_vy [gpit];	
					}
#else
					pvx = addsign (malotes [enoffsmasi].mx, PLAYER_MAX_VX);
					pvy = addsign (malotes [enoffsmasi].my, PLAYER_MAX_VX);
#endif
#else
					if (malotes [enoffsmasi].mx) {
						pvx = addsign (gpx - gpen_cx, abs (malotes [enoffsmasi].mx) << 8);
					}
					if (malotes [enoffsmasi].my) {
						pvy = addsign (gpy - gpen_cy, abs (malotes [enoffsmasi].my) << 8);
					}
#endif
#endif
#ifdef PLAYER_FLICKERS
					pestado = EST_PARP;
					pct_estado = 50;
#endif
				}
			}
			
#ifdef PLAYER_CAN_FIRE
			// Collide with bullets
#ifdef FIRE_MIN_KILLABLE
			if (malotes [enoffsmasi].t >= FIRE_MIN_KILLABLE) {
#endif				
				for (gpjt = 0; gpjt < MAX_BULLETS; gpjt ++) {
					if (bullets [gpjt].estado == 1) {
						blx = bullets [gpjt].x + 3; 
						bly = bullets [gpjt].y + 3;
						if (blx >= gpen_cx && blx <= gpen_cx + 15 && bly >= gpen_cy && bly <= gpen_cy + 15) {
#ifdef RANDOM_RESPAWN		
							if (en_an_fanty_activo [gpit]) {
								en_an_vx [gpit] += addsign (bullets [gpjt].mx, 128);
							}
#endif
#ifdef ENABLE_CUSTOM_TYPE_6
							if (malotes [enoffsmasi].t == 6) {
								en_an_vx [gpit] += addsign (bullets [gpjt].mx, 128);
							}
#endif
							malotes [enoffsmasi].x = gpen_x;
							malotes [enoffsmasi].y = gpen_y;
							en_an_next_frame [gpit] = sprite_17_a;
							en_an_morido [gpit] = 1;
							bullets [gpjt].estado = 0;
#ifndef PLAYER_MOGGY_STYLE							
							if (malotes [enoffsmasi].t != 4) malotes [enoffsmasi].life --;
#else
							malotes [enoffsmasi].life --;
#endif
							if (malotes [enoffsmasi].life == 0) {
								sp_MoveSprAbs (sp_moviles [gpit], spritesClip, en_an_next_frame [gpit] - en_an_current_frame [gpit], VIEWPORT_Y + (gpen_cy >> 3), VIEWPORT_X + (gpen_cx >> 3), gpen_cx & 7, gpen_cy & 7);
								en_an_current_frame [gpit] = en_an_next_frame [gpit];
								sp_UpdateNow ();
#ifdef MODE_128K
								#asm
									halt
								#endasm
								wyz_play_sound (6);
#else															
								peta_el_beeper (5);
#endif
								en_an_next_frame [gpit] = sprite_18_a;
								if (gpt != 7) malotes [enoffsmasi].t |= 16;
								pkilled ++;
#ifdef RANDOM_RESPAWN								
								en_an_fanty_activo [gpit] = 0;
								malotes [enoffsmasi].life = FANTIES_LIFE_GAUGE;
#endif
#ifdef ENABLE_PURSUERS
								en_an_alive [gpit] = 0;
								en_an_dead_row [gpit] = DEATH_COUNT_EXPRESSION;
#endif							
							}
						}
					}
				}
#ifdef FIRE_MIN_KILLABLE
			}
#endif							
#endif
			
#ifdef RANDOM_RESPAWN
			// Activar fanty

			if (malotes [enoffsmasi].t > 15 && en_an_fanty_activo [gpit] == 0 && (rand () & 31) == 1) {
				en_an_fanty_activo [gpit] = 1;
				if (py > 5120) en_an_y [gpit] = -1024; else en_an_y [gpit] = 10240;
				en_an_x [gpit] = (rand () % 240 - 8) << 6;
				en_an_vx [gpit] = en_an_vy [gpit] = 0;
				en_an_base_frame [gpit] = 4;
			}
#endif
		} 
	}
#if defined(SLOW_DRAIN) && defined(PLAYER_BOUNCES)
	lasttimehit = tocado;
#endif
}