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
	const unsigned char *player_frames [] = {
		sprite_1_a, sprite_2_a, sprite_3_a, sprite_4_a,
		sprite_5_a, sprite_6_a, sprite_7_a, sprite_8_a
	};
#else
	#ifdef PLAYER_BOOTEE
		// vy = 0: 0 + facing
		// vy < 0: 1 + facing
		// vy > 0: 2 + facing
		const unsigned char *player_frames [] = {
			sprite_5_a, sprite_6_a, sprite_7_a, sprite_8_a,
			sprite_1_a, sprite_2_a, sprite_3_a, sprite_4_a
		};
	#else
		#ifdef PLAYER_ALTERNATE_ANIMATION
			// Alternate animation:
			// 0 1 2 + facing = walk, 0 = stand, 3 = jump/fall
			const unsigned char *player_frames [] = {
				sprite_5_a, sprite_6_a, sprite_7_a, sprite_8_a,
				sprite_1_a, sprite_2_a, sprite_3_a, sprite_4_a
			};
		#else
			// Normal animation:
			// 0 1 2 3 + facing: walk, 1 = stand. 8 + facing = jump/fall
			const unsigned char *player_frames [] = {
				sprite_5_a, sprite_6_a, sprite_7_a, sprite_6_a,
				sprite_1_a, sprite_2_a, sprite_3_a, sprite_2_a,
				sprite_8_a, sprite_4_a
			};
		#endif
	#endif
#endif
const unsigned char *enem_frames [] = {
	sprite_9_a, sprite_10_a, sprite_11_a, sprite_12_a, 
	sprite_13_a, sprite_14_a, sprite_15_a, sprite_16_a
};

#ifdef COMPRESSED_LEVELS
	#ifdef MODE_128K
		void prepare_level (void) {
			get_resource (levels [level].resource, (unsigned int) (level_data));
			//unpack_RAMn (levels [level].page, levels [level].address, (unsigned int) (level_data));
			n_pant = level_data.scr_ini;
			gpx = level_data->ini_x << 4; px = gpx << 6;
			gpy = level_data->ini_y << 4; py = gpy << 6;
		}
	#else
		void prepare_level (void) {
			unpack ((unsigned int) levelset [level].leveldata_c, MAP_DATA);
			unpack ((unsigned int) levelset [level].tileset_c, (unsigned int) (tileset));
			unpack ((unsigned int) levelset [level].spriteset_c, (unsigned int) (sprite_1_a - 16));
			n_pant = levelset [level].ini_pant;
			gpx = level_data->ini_x << 4; px = gpx << 6;
			gpy = level_data->ini_y << 4; py = gpy << 6;
			n_bolts = *((unsigned char *) (NBOLTS_PEEK));
	}
	#endif
#endif

void game_ending (void) {
	sp_UpdateNow();
	blackout ();
	#ifdef MODE_128K
		// Resource 2 = ending
		get_resource (2, 16384);
	#else
		#asm
			ld hl, _s_ending
			ld de, 16384
			call depack
		#endasm
	#endif

	#ifdef MODE_128K
	#else
		gpit = 4; do {
			beeper_fx (7);
			beeper_fx (2);
		} while (-- gpit);
		beeper_fx (9);
	#endif
	
	espera_activa (500);
}

void game_over (void) {
	print_str (10, 11, 79, spacer);
	print_str (10, 12, 79, " GAME OVER! ");
	print_str (10, 13, 79, spacer);
	sp_UpdateNow ();

	#ifdef MODE_128K
	#else
		gpit = 4; do {
			beeper_fx (7);
			beeper_fx (2);
		} while (-- gpit);
		beeper_fx (9);
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
				beeper_fx (1);
				beeper_fx (2);
			} while (--bs);
			beeper_fx (0);
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
		void locks_init (void) {
			for (gpit = 0; gpit < MAX_CERROJOS; ++ gpit) cerrojos [gpit].st = 1;	
		}
	#endif
#endif

#ifdef PLAYER_CAN_FIRE
	void bullets_init (void) {
		gpit = 0; while (gpit < MAX_BULLETS) { 
			bullets_estado [gpit] = 0; ++ gpit;
			
	}
#endif

#ifndef COMPRESSED_LEVELS
	void hotspots_init (void) {
		gpit = 0; while (gpit < MAP_W * MAP_H) {
			hotspots [gpit].act = 1; ++ gpit;
		}
	}
#endif

#ifdef PLAYER_CAN_FIRE
	void bullets_fire (void) {
		#ifdef PLAYER_CAN_FIRE_FLAG 
			if (flags [PLAYER_CAN_FIRE_FLAG] == 0) return;
		#endif
		#ifdef MAX_AMMO
			if (!pammo) return;
			-- pammo;
		#endif
		// Buscamos una bala libre
		for (gpit = 0; gpit < MAX_BULLETS; gpit ++) {
			if (bullets_estado [gpit] == 0) {
				bullets_estado [gpit] = 1;
				#ifdef PLAYER_MOGGY_STYLE
					switch (pfacing) {
						case FACING_LEFT:
							bullets_x [gpit] = (px >> 6) - 4;
							bullets_mx [gpit] = -PLAYER_BULLET_SPEED;
							bullets_y [gpit] = (py >> 6) + PLAYER_BULLET_Y_OFFSET;
							bullets_my [gpit] = 0;
							break;
						case FACING_RIGHT:
							bullets_x [gpit] = (px >> 6) + 12;
							bullets_mx [gpit] = PLAYER_BULLET_SPEED;
							bullets_y [gpit] = (py >> 6) + PLAYER_BULLET_Y_OFFSET;
							bullets_my [gpit] = 0;
							break;
						case FACING_DOWN:
							bullets_x [gpit] = (px >> 6) + PLAYER_BULLET_X_OFFSET;
							bullets_y [gpit] = (py >> 6) + 12;
							bullets_my [gpit] = PLAYER_BULLET_SPEED;
							bullets_mx [gpit] = 0;
							break;
						case FACING_UP:
							bullets_x [gpit] = (px >> 6) + 8 - PLAYER_BULLET_X_OFFSET;
							bullets_y [gpit] = (py >> 6) - 4;
							bullets_my [gpit] = -PLAYER_BULLET_SPEED;
							bullets_mx [gpit] = 0;
							break;
					}
				#else
					
					#ifdef CAN_FIRE_UP
						if (!(pad0 & sp_UP)) {
							bullets_y [gpit] = (py >> 6);
							bullets_my [gpit] = -PLAYER_BULLET_SPEED;
						} else if (!(pad0 & sp_DOWN)) {
							bullets_y [gpit] = 8 + (py >> 6);
							bullets_my [gpit] = PLAYER_BULLET_SPEED;	 
						} else 
					#endif
					{
						bullets_y [gpit] = (py >> 6) + PLAYER_BULLET_Y_OFFSET;
						bullets_my [gpit] = 0;
					}
	

					#ifdef CAN_FIRE_UP
						if (!(pad0 & sp_LEFT) || !(pad0 & sp_RIGHT) || ((pad0 & sp_UP) && (pad0 & sp_DOWN))) {
					#endif
						if (pfacing == 0) {
							bullets_x [gpit] = (px >> 6) - 4;
							bullets_mx [gpit] = -PLAYER_BULLET_SPEED;
						} else {
							bullets_x [gpit] = (px >> 6) + 12;
							bullets_mx [gpit] = PLAYER_BULLET_SPEED;
						}
					#ifdef CAN_FIRE_UP
						} else {
							bullets_x [gpit] = (px >> 6) + 4;
							bullets_mx [gpit] = 0;
						}
					#endif
				#endif
	
				#ifdef MODE_128K
					wyz_play_sound (4);
				#else
					beeper_fx (6);
				#endif

				#ifdef LIMITED_BULLETS
					#if defined (LB_FRAMES) || !defined (ACTIVATE_SCRIPTING)
						bullets_life [gpit] = LB_FRAMES;
					#else
						bullets_life [gpit] = flags [LB_FRAMES_FLAG];
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
	void process_tile (void) {
		#ifdef PLAYER_PUSH_BOXES
			#ifdef FIRE_TO_PUSH
				#ifdef USE_TWO_BUTTONS
					if ((pad0 & sp_FIRE) == 0 || sp_KeyPressed (key_fire))
				#else
					if ((pad0 & sp_FIRE) == 0)
				#endif
			#endif		
			{
				if (qtile (cx1, cy1) == 14 && attr (cx2, cy2) == 0 && cx2 >= 0 && cx2 < 15 && cy2 >= 0 && cy2 < 10) {
					#if defined(ACTIVATE_SCRIPTING) && defined(ENABLE_PUSHED_SCRIPTING)
						flags [MOVED_TILE_FLAG] = map_buff [15 * cy2 + cx2];
						flags [MOVED_X_FLAG] = cx2;
						flags [MOVED_Y_FLAG] = cy2;
					#endif			
					
					// Mover
					map_attr [15 * cy2 + cx2] = 10;
					map_buff [15 * cy2 + cx2] = 14;
					map_attr [15 * cy1 + cx1] = 0;
					map_buff [15 * cy1 + cx1] = 0;
					
					// Pintar
					draw_coloured_tile (VIEWPORT_X + cx1 + cx1, VIEWPORT_Y + cy1 + cy1, 0);
					draw_coloured_tile (VIEWPORT_X + cx2 + cx2, VIEWPORT_Y + cy2 + cy2, 14);
					
					// Sonido
					#ifdef MODE_128K
						wyz_play_sound (3);
					#else			
						beeper_fx (2);	
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
			if (qtile (cx1, cy1) == 15 && pkeys) {
				map_attr [15 * cy1 + cx1] = 0;
				map_buff [15 * cy1 + cx1] = 0;
		
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
					if (cerrojos [gpit].x == cx1 && cerrojos [gpit].y == cy1 && cerrojos [gpit].np == n_pant) {
						cerrojos [gpit].st = 0;
						break;
					}
				}
				draw_coloured_tile (VIEWPORT_X + cx1 + cx1, VIEWPORT_Y + cy1 + cy1, 0);
				pkeys --;
		
				#ifdef MODE_128K
					wyz_play_sound (3);
				#else
					beeper_fx (8);
				#endif
			}
		#endif
	}
#endif

void draw_scr_background (void) {
	#ifdef UNPACKED_MAP
		map_pointer = mapa + (n_pant * 150);
	#else
		map_pointer = mapa + (n_pant * 75);
	#endif
	seed [0] = n_pant;
	gpx = gpy = 0;	

	// Draw 150 tiles
	
	for (gpit = 0; gpit < 150; ++ gpit) {	
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
		enoffsmasi = enoffs + gpit:
		malotes [enoffsmasi].t &= 0xEF;		
		#ifdef PLAYER_CAN_FIRE
			#if defined (COMPRESSED_LEVELS) && defined (MODE_128K)
				malotes [enoffsmasi].life = level_data.enems_life;
			#else
				malotes [enoffsmasi].life = ENEMIES_LIFE_GAUGE;
			#endif
		#endif
	#endif
		switch (malotes [enoffsmasi].t) {
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
					en_an_x [gpit] = malotes [enoffsmasi].x << 6;
					en_an_y [gpit] = malotes [enoffsmasi].y << 6;
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
	
	while (1) {
		gpjt = sp_GetKey ();
		if (gpjt >= '1' && gpjt <= '3') {
			joyfunc = joyfuncs [gpjt - '1'];
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
			beeper_fx (gpaux);
		#endif
	}
#endif

#ifdef PLAYER_CAN_FIRE
	void bullets_move (void) {
		for (gpit = 0; gpit < MAX_BULLETS; gpit ++) {
			if (bullets_estado [gpit]) {			
				if (bullets_mx [gpit]) {
					bullets_x [gpit] += bullets_mx [gpit];								
					if (bullets_x [gpit] > 240) {
						bullets_estado [gpit] = 0;
					}
				} 
				#if defined(PLAYER_MOGGY_STYLE) || defined(CAN_FIRE_UP)
					if (bullets_my [gpit]) {
						bullets_y [gpit] += bullets_my [gpit];
						if (bullets_y [gpit] < 8 || bullets_y [gpit] > 160) {
							bullets_estado [gpit] = 0;
						}
					}
				#endif
				gpxx = (bullets_x [gpit] + 3) >> 4;
				gpyy = (bullets_y [gpit] + 3) >> 4;
				#ifdef BREAKABLE_WALLS			
					if (attr (gpxx, gpyy) & 16) break_wall (gpxx, gpyy);
				#endif
				if (attr (gpxx, gpyy) > 7) bullets_estado [gpit] = 0;
			
				#ifdef LIMITED_BULLETS
					if (bullets_life [gpit] > 0) {
						bullets_life [gpit] --;
					} else {
						bullets_estado [gpit] = 0;
					}
				#endif				
			}	
		}	
	}
#endif	

// Total rewrite

#ifdef WALLS_STOP_ENEMIES
unsigned char mons_col_sc_x (void) {
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
	
unsigned char mons_col_sc_y (void) {
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
	unsigned char distance (void) {
		rdx = abs (cx2 - gpx);
		rdy = abs (cy2 - gpy);
		rdn = rdx < rdy ? rdx : rdy;
		return (rdx + rdy - (rdn >> 1) - (rdn >> 2) + (rdn >> 4));
	}
#endif

#if defined(ENABLE_CUSTOM_TYPE_6) || defined(ENABLE_RANDOM_RESPAWN)
	int limit (int val, int min, int max) {
		if (val < min) return min;
		if (val > max) return max;
		return val;
	}
#endif
