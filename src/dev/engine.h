// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

#ifdef TEST_DEBUG
	void test_debug (void) {
		sp_UpdateNow ();
		sp_PrintAtInv (5, 5, 71, 69);
		sp_PrintAtInv (6, 6, 15, 70);
		#asm
				ld  ix, (_sp_player)
				ld  iy, vpClipStruct

				ld  bc, 0

				ld  hl, 0x0707 
				ld  de, 0x0000

				call SPMoveSprAbs
		#endasm
		sp_UpdateNow ();
		espera_activa (50);
		#asm
				ld  ix, (_sp_player)
				ld  iy, vpClipStruct

				ld  bc, 0

				ld  hl, 0x0404 
				ld  de, 0x0000

				call SPMoveSprAbs
		#endasm
		sp_UpdateNow ();
		while (sp_GetKey ());
		while (!sp_GetKey ());
	}
#endif

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
		// Normal animation:
		// 0 1 2 3 + facing: walk, 1 = stand. 8 + facing = jump/fall
		const unsigned char *player_frames [] = {
			sprite_5_a, sprite_6_a, sprite_7_a, sprite_6_a,
			sprite_1_a, sprite_2_a, sprite_3_a, sprite_2_a,
			sprite_8_a, sprite_4_a
		};
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
			gpx = level_data->ini_x << 4; p_x = gpx << 6;
			gpy = level_data->ini_y << 4; p_y = gpy << 6;
		}
	#else
		void prepare_level (void) {
			unpack ((unsigned int) levelset [level].leveldata_c, MAP_DATA);
			unpack ((unsigned int) levelset [level].tileset_c, (unsigned int) (tileset));
			unpack ((unsigned int) levelset [level].spriteset_c, (unsigned int) (sprite_1_a - 16));
			n_pant = levelset [level].ini_pant;
			gpx = level_data->ini_x << 4; p_x = gpx << 6;
			gpy = level_data->ini_y << 4; p_y = gpy << 6;
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
			beep_fx (7);
			beep_fx (2);
		} while (-- gpit);
		beep_fx (9);
	#endif
	
	espera_activa (500);
}

void game_over (void) {
	_x = 10; _y = 11; _t = 79; _gp_gen = spacer; print_str ();
	_x = 10; _y = 12; _t = 79; _gp_gen = " GAME OVER! "; print_str ();
	_x = 10; _y = 13; _t = 79; _gp_gen = spacer; print_str ();
	sp_UpdateNow ();

	#ifdef MODE_128K
	#else
		gpit = 4; do {
			beep_fx (7);
			beep_fx (2);
		} while (-- gpit);
		beep_fx (9);
	#endif

	espera_activa (500);
}

#if defined(TIMER_ENABLE) && defined(SHOW_TIMER_OVER)
	void time_over (void) {
		_x = 10; _y = 11; _t = 79; _gp_gen = spacer; print_str ();
		_x = 10; _y = 12; _t = 79; _gp_gen = " TIME'S UP! "; print_str ();
		_x = 10; _y = 13; _t = 79; _gp_gen = spacer; print_str ();
		sp_UpdateNow ();
			
		#ifdef MODE_128K
		#else
			bs = 4; do {
				beep_fx (1);
				beep_fx (2);
			} while (--bs);
			beep_fx (0);
		#endif
		
		espera_activa (250);
	}
#endif

#ifdef PAUSE_ABORT
	void pause_screen (void) {
		_x = 10; _y = 11; _t = 79; _gp_gen = spacer; print_str ();
		_x = 10; _y = 12; _t = 79; _gp_gen = "   PAUSED   "; print_str ();
		_x = 10; _y = 13; _t = 79; _gp_gen = spacer; print_str ();
		sp_UpdateNow ();
	}
#endif

signed int addsign (signed int n, signed int value) {
	if (n >= 0) return value; else return -value;
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
	}
#endif

#ifdef PLAYER_CAN_FIRE
	void bullets_fire (void) {
		#ifdef PLAYER_CAN_FIRE_FLAG 
			if (flags [PLAYER_CAN_FIRE_FLAG] == 0) return;
		#endif
		#ifdef MAX_AMMO
			if (!p_ammo) return;
			-- p_ammo;
		#endif
		// Buscamos una bala libre
		for (gpit = 0; gpit < MAX_BULLETS; gpit ++) {
			if (bullets_estado [gpit] == 0) {
				bullets_estado [gpit] = 1;
				#ifdef PLAYER_MOGGY_STYLE
					switch (p_facing) {
						case FACING_LEFT:
							bullets_x [gpit] = (p_x >> 6) - 4;
							bullets_mx [gpit] = -PLAYER_BULLET_SPEED;
							bullets_y [gpit] = (p_y >> 6) + PLAYER_BULLET_Y_OFFSET;
							bullets_my [gpit] = 0;
							break;
						case FACING_RIGHT:
							bullets_x [gpit] = (p_x >> 6) + 12;
							bullets_mx [gpit] = PLAYER_BULLET_SPEED;
							bullets_y [gpit] = (p_y >> 6) + PLAYER_BULLET_Y_OFFSET;
							bullets_my [gpit] = 0;
							break;
						case FACING_DOWN:
							bullets_x [gpit] = (p_x >> 6) + PLAYER_BULLET_X_OFFSET;
							bullets_y [gpit] = (p_y >> 6) + 12;
							bullets_my [gpit] = PLAYER_BULLET_SPEED;
							bullets_mx [gpit] = 0;
							break;
						case FACING_UP:
							bullets_x [gpit] = (p_x >> 6) + 8 - PLAYER_BULLET_X_OFFSET;
							bullets_y [gpit] = (p_y >> 6) - 4;
							bullets_my [gpit] = -PLAYER_BULLET_SPEED;
							bullets_mx [gpit] = 0;
							break;
					}
				#else
					
					#ifdef CAN_FIRE_UP
						if (!(pad0 & sp_UP)) {
							bullets_y [gpit] = (p_y >> 6);
							bullets_my [gpit] = -PLAYER_BULLET_SPEED;
						} else if (!(pad0 & sp_DOWN)) {
							bullets_y [gpit] = 8 + (p_y >> 6);
							bullets_my [gpit] = PLAYER_BULLET_SPEED;	 
						} else 
					#endif
					{
						bullets_y [gpit] = (p_y >> 6) + PLAYER_BULLET_Y_OFFSET;
						bullets_my [gpit] = 0;
					}
	

					#ifdef CAN_FIRE_UP
						if (!(pad0 & sp_LEFT) || !(pad0 & sp_RIGHT) || ((pad0 & sp_UP) && (pad0 & sp_DOWN))) {
					#endif
						if (p_facing == 0) {
							bullets_x [gpit] = (p_x >> 6) - 4;
							bullets_mx [gpit] = -PLAYER_BULLET_SPEED;
						} else {
							bullets_x [gpit] = (p_x >> 6) + 12;
							bullets_mx [gpit] = PLAYER_BULLET_SPEED;
						}
					#ifdef CAN_FIRE_UP
						} else {
							bullets_x [gpit] = (p_x >> 6) + 4;
							bullets_mx [gpit] = 0;
						}
					#endif
				#endif
	
				#ifdef MODE_128K
					wyz_play_sound (4);
				#else
					beep_fx (6);
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
		if ( (gpy & 15) == 0 && p_vx == 0 ) {
			if (attr (gpxx, gpyy) == 2 || (attr (1 + gpxx, gpyy) == 2 && (gpx & 15)) ) {
				return 1;
			}
		}			
		return 0;
	}
#endif

#ifdef ACTIVATE_SCRIPTING
	void run_fire_script (void) {
		run_script (2 * MAP_W * MAP_H + 2); 		// PRESS_FIRE AT ANY
		run_script ((n_pant << 1) + 1); 			// PRESS_FIRE AT SCREEN n
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
				if (qtile (x0, y0) == 14 && attr (x1, y1) == 0 && x1 < 15 && y1 < 10) {
					#if defined(ACTIVATE_SCRIPTING) && defined(ENABLE_PUSHED_SCRIPTING)
						flags [MOVED_TILE_FLAG] = map_buff [COORDS(x1,y1)];
						flags [MOVED_X_FLAG] = x1;
						flags [MOVED_Y_FLAG] = y1;
					#endif			
					
					// Pintar
					_x = x0; _y = y0; _t = 0; _n = 0; update_tile ();
					_x = x1; _y = y1; _t = 14; _n = 10; update_tile ();
					
					// Sonido
					#ifdef MODE_128K
						wyz_play_sound (3);
					#else			
						beep_fx (2);	
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
			if (qtile (x0, y0) == 15 && p_keys) {
				for (gpit = 0; gpit < MAX_CERROJOS; ++ gpit) {
					if (cerrojos [gpit].x == x0 && cerrojos [gpit].y == y0 && cerrojos [gpit].np == n_pant) {
						cerrojos [gpit].st = 0;
						break;
					}
				}
				_x = x0; _y = y0; _t = 0; _n = 0; update_tile ();
				-- p_keys;
		
				#ifdef MODE_128K
					wyz_play_sound (3);
				#else
					beep_fx (8);
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
		
	seed = n_pant;

	_x = VIEWPORT_X; _y = VIEWPORT_Y;

	// Draw 150 tiles
	
	for (gpit = 0; gpit < 150; ++ gpit) {	
		#ifdef UNPACKED_MAP
			// Mapa tipo UNPACKED
			_t = *map_pointer ++;
			map_attr [gpit] = behs [gpd];
			map_buff [gpit] = gpd;
		#else
			// Mapa tipo PACKED
			if (!(gpit & 1)) {
				gpc = *map_pointer ++;
				_t = gpc >> 4;
			} else {
				_t = gpc & 15;
			}
			map_attr [gpit] = behs [_t];
			if (_t == 0 && (rand () & 15) == 1) _t = 19;
			map_buff [gpit] = _t;
		#endif	

		#ifdef BREAKABLE_WALLS
			brk_buff [gpit] = 0;
		#endif

		draw_coloured_tile ();

		#if defined ENABLE_TILANIMS && defined UNPACKED_MAP
			// Detect tilanims
			if (_t >= ENABLE_TILANIMS) {
				add_tilanim ((_x - VIEWPORT_X) >> 1, (_y - VIEWPORT_Y) >> 1, _t);	
			}
		#endif
			
		_x += 2; if (_x == VIEWPORT_X + 30) { _x = VIEWPORT_X; _y += 2; }
	}
	
	// Object setup

	hotspot_x = hotspot_y = 240;
	rdx = (hotspots [n_pant].xy >> 4);
	rdy = (hotspots [n_pant].xy & 15);

	if (hotspots [n_pant].act == 1 && hotspots [n_pant].tipo) {
		hotspot_x = rdx << 4;
		hotspot_y = rdy << 4;
		orig_tile = map_buff [COORDS (rdx, rdy)];
		_x = rdx; _y = rdy; _t = 16 + (hotspots [n_pant].tipo != 3 ? hotspots [n_pant].tipo : 0);
		draw_coloured_tile_gamearea ();
	}

	#ifndef DEACTIVATE_KEYS
		// Open locks
		for (gpit = 0; gpit < MAX_CERROJOS; ++ gpit) {
			if (cerrojos [gpit].np == n_pant && !cerrojos [gpit].st) {
				_x = cerrojos [gpit].x;
				_y = cerrojos [gpit].y;
				gpd = COORDS(_x, _y);
				map_attr [gpd] = 0;
				map_buff [gpd] = 0;
				_t = 0; draw_coloured_tile_gamearea ();
			}
		}
	#endif
}

void draw_scr (void) {
	is_rendering = 1;

	#ifdef ENABLE_TILANIMS
		max_tilanims = 0;
	#endif

	#ifdef ENABLE_FIRE_ZONE
		f_zone_ac = 0;
	#endif	

	draw_scr_background ();
	
	enems_load ();
	
	#ifdef ACTIVATE_SCRIPTING
		#ifdef LINE_OF_TEXT
			_x = LINE_OF_TEXT_X; _y = LINE_OF_TEXT; _t = LINE_OF_TEXT_ATTR; _gp_gen = "                              "; print_str ();
		#endif
		// Ejecutamos los scripts de entrar en pantalla:
		run_script (2 * MAP_W * MAP_H + 1); 	// ENTERING ANY
		run_script (n_pant << 1); 				// ENTERING SCREEN n
	#endif

	#ifdef PLAYER_CAN_FIRE
		bullets_init ();
	#endif

	invalidate_viewport ();
	is_rendering = 0;
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
		_x = x; _y = y;
		gpaux = COORDS (_x, _y);
		if (brk_buff [gpaux] < BREAKABLE_WALLS_LIFE) {
			++ brk_buff [gpaux];
			gpaux = 6;
		} else {
			map_attr [gpaux] = 0;
			map_buff [gpaux] = 0;
			_t = 0;	draw_invalidate_coloured_tile_gamearea ();
			gpaux = 7;
		}
		#ifdef MODE_128K
			wyz_play_sound (gpaux);
		#else			
			beep_fx (gpaux);
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
		cx1 = cx2 = (_en_mx > 0 ? _en_x + 15 : _en_x) >> 4;
		cy1 = _en_y >> 4; cy2 = (_en_y + 15) >> 4;
		cm_two_points ();
		#ifdef EVERYTHING_IS_A_WALL
			return (at1 || at2);
		#else
			return ((at1 & 8) || (at2 & 8));
		#endif
	}
		
	unsigned char mons_col_sc_y (void) {
		cy1 = cy2 = (_en_my > 0 ? _en_y + 15 : _en_y) >> 4;
		cx1 = _en_x >> 4; cx2 = (_en_x + 15) >> 4;
		cm_two_points ();
		#ifdef EVERYTHING_IS_A_WALL
			return (at1 || at2);
		#else
			return ((at1 & 8) || (at2 & 8));
		#endif
	}
#endif

#if defined(SLOW_DRAIN) && defined(PLAYER_BOUNCES)
	unsigned char lasttimehit;
#endif

#if defined (ENABLE_FANTIES) && defined (FANTIES_TYPE_HOMING)
	// Funciones auxiliares custom
	unsigned char distance (void) {
		rdx = abs (cx2 - gpx);
		rdy = abs (cy2 - gpy);
		rdn = rdx < rdy ? rdx : rdy;
		return (rdx + rdy - (rdn >> 1) - (rdn >> 2) + (rdn >> 4));
	}
#endif

#if defined(ENABLE_FANTIES)
	int limit (int val, int min, int max) {
		if (val < min) return min;
		if (val > max) return max;
		return val;
	}
#endif
