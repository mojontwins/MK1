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

#if defined PLAYER_GENITAL || defined PLAYER_CUSTOM_ANIMATION
	// right: 0 + frame
	// left: 2 + frame
	// up: 4 + frame
	// down: 6 + frame
	const unsigned char *player_cells [] = {
		sprite_1_a, sprite_2_a, sprite_3_a, sprite_4_a,
		sprite_5_a, sprite_6_a, sprite_7_a, sprite_8_a
	};
#elif defined PLAYER_BOOTEE
	// vy = 0: 0 + facing
	// vy < 0: 1 + facing
	// vy > 0: 2 + facing
	const unsigned char *player_cells [] = {
		sprite_5_a, sprite_6_a, sprite_7_a, sprite_8_a,
		sprite_1_a, sprite_2_a, sprite_3_a, sprite_4_a
	};
#else
	// Normal animation:
	// 0 1 2 3 + facing: walk, 1 = stand. 8 + facing = jump/fall
	const unsigned char *player_cells [] = {
		sprite_5_a, sprite_6_a, sprite_7_a, sprite_6_a,
		sprite_1_a, sprite_2_a, sprite_3_a, sprite_2_a,
		sprite_8_a, sprite_4_a
	};
#endif

const unsigned char *enem_cells [] = {
	sprite_9_a, sprite_10_a, sprite_11_a, sprite_12_a, 
	sprite_13_a, sprite_14_a, sprite_15_a, sprite_16_a
};

#include "my/fixed_screens.h"

signed int addsign (signed int n, signed int value) {
	if (n >= 0) return value; else return -value;
}

#ifdef ENABLE_TILANIMS
	#include "tilanim.h"
#endif

void espera_activa (int espera) {
	while (sp_GetKey ());
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
	#if !defined DEACTIVATE_KEYS && MAX_CERROJOS > 0
		void locks_init (void) {
			for (gpit = 0; gpit < MAX_CERROJOS; ++ gpit) cerrojos [gpit].st = 1;	
		}
	#endif
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
				if ((pad0 & sp_FIRE) == 0)				
			#endif		
			{ 
				#ifdef FIRE_TO_PUSH			
					// Para no disparar...
					//pushed_any = 1;
					p_disparando = 1;
				#endif

				if (qtile (x0, y0) == 14 && attr (x1, y1) == 0 && x1 < 15 && y1 < 10) {
					rda = map_buff [COORDS(x1,y1)];
					
					#if defined(ACTIVATE_SCRIPTING) && defined(ENABLE_PUSHED_SCRIPTING)
						flags [MOVED_TILE_FLAG] = rda; 
						flags [MOVED_X_FLAG] = x1;
						flags [MOVED_Y_FLAG] = y1;
					#endif			
					
					// Pintar
					_x = x0; _y = y0; _t = 0; _n = 0; update_tile ();
					_x = x1; _y = y1; _t = 14; _n = 10; update_tile ();
					
					// Sonido
					#ifdef MODE_128K
						PLAY_SOUND (SFX_PUSH_BOX);
					#else			
						beep_fx (2);	
					#endif
				
					#if defined(ACTIVATE_SCRIPTING) && defined(ENABLE_PUSHED_SCRIPTING) && defined(PUSHING_ACTION)
						// Call scripting
						just_pushed = 1;
						run_fire_script ();
						just_pushed = 0;
					#endif

					#include "my/ci/on_tile_pushed.h"
				} 
			}			
		#endif

		#if !defined DEACTIVATE_KEYS && MAX_CERROJOS > 0
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
					PLAY_SOUND (SFX_OPEN_LOCK);
				#else
					beep_fx (8);
				#endif

				#include "my/ci/on_unlocked_bolt.h"
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
	
	#ifdef USE_MAP_CUSTOM_DECODER
		#include "my/map_custom_decoder.h"
	#else
		for (gpit = 0; gpit < 150; ++ gpit) {	
			#ifdef UNPACKED_MAP
				// Mapa tipo UNPACKED
				/*
				_t = *map_pointer ++;
				map_attr [gpit] = behs [_t];
				map_buff [gpit] = _t;
				*/
				#asm
						ld  hl, (_map_pointer)
						ld  a, (hl)
						ld  (__t), a
						inc hl
						ld  (_map_pointer), hl

						ld  b, 0
						ld  c, a
						ld  hl, _behs
						add hl, bc
						ld  a, (hl)

						ld  bc, (_gpit)
						ld  b, 0
						ld  hl, _map_attr
						add hl, bc
						ld  (hl), a

						ld  hl, _map_buff
						add hl, bc
						ld  a, (__t)
						ld  (hl), a
				#endasm
			#else
				// Mapa tipo PACKED
				/*
				if (!(gpit & 1)) {
					gpc = *map_pointer ++;
					_t = gpc >> 4;
				} else {
					_t = gpc & 15;
				}
				map_attr [gpit] = behs [_t];
				if (_t == 0 && (rand () & 15) == 1) _t = 19;
				map_buff [gpit] = _t;
				*/
				#asm
						ld  a, (_gpit)
						and 1
						jr  nz, _draw_scr_packed_existing
					._draw_scr_packed_new
						ld  hl, (_map_pointer)
						ld  a, (hl)
						ld  (_gpc), a
						inc hl
						ld  (_map_pointer), hl

						srl a
						srl a
						srl a
						srl a
						jr  _draw_scr_packed_done

					._draw_scr_packed_existing
						ld  a, (_gpc)
						and 15

					._draw_scr_packed_done
						ld  (__t), a
						
						ld  b, 0
						ld  c, a
						ld  hl, _behs
						add hl, bc
						ld  a, (hl)

						ld  bc, (_gpit)
						ld  b, 0
						ld  hl, _map_attr
						add hl, bc
						ld  (hl), a

				#ifdef PACKED_MAP_ALT_TILE
						ld  a, (__t)
						or  a
						jr  nz, _draw_scr_packed_noalt

					._draw_scr_packed_alt
						call _rand
						ld  a, l
						and 15
						cp  1
						jr  z, _draw_scr_packed_alt_subst

						ld  a, (__t)
						jr  _draw_scr_packed_noalt

					._draw_scr_packed_alt_subst
						ld  a, PACKED_MAP_ALT_TILE
						ld  (__t), a

					._draw_scr_packed_noalt
				#endif

						ld  hl, _map_buff
						add hl, bc
						
						ld  (hl), a
				#endasm
			#endif	

			#ifdef BREAKABLE_WALLS
				// brk_buff [gpit] = 0;
				#asm
						ld  hl, _brk_buff
						add hl, bc
						xor a
						ld  (hl), a
				#endasm
			#endif

			#ifdef ENABLE_TILANIMS
				if (_t >= ENABLE_TILANIMS) {
					_n = (((_x - VIEWPORT_X) << 3) & 0xf0) | ((_y - VIEWPORT_Y) >> 1);
					tilanims_add ();	
				}
			#endif

			draw_coloured_tile ();

			//_x += 2; if (_x == VIEWPORT_X + 30) { _x = VIEWPORT_X; _y += 2; }
			#asm
					ld  a, (__x)
					add 2
					cp  30 + VIEWPORT_X
					jr  c, _advance_worm_no_inc_y

					ld  a, (__y)
					add 2
					ld  (__y), a

					ld  a, VIEWPORT_X

				._advance_worm_no_inc_y
					ld  (__x), a
			#endasm
		}
	#endif
}

void draw_scr_hotspots_locks (void) {
	/*
	hotspot_y = 240;
	rdx = (hotspots [n_pant].xy >> 4);
	rdy = (hotspots [n_pant].xy & 15);

	if (hotspots [n_pant].act == 1 && hotspots [n_pant].tipo) {
		hotspot_x = rdx << 4;
		hotspot_y = rdy << 4;
		orig_tile = map_buff [COORDS (rdx, rdy)];
		_x = rdx; _y = rdy; _t = 16 + (hotspots [n_pant].tipo != 3 ? hotspots [n_pant].tipo : 0);
		draw_coloured_tile_gamearea ();
	}
	*/
	#asm 
			ld  a, 240
			ld  (_hotspot_y), a

			// Hotspots are 3-byte wide structs. No game will have more than 85 screens
			// in the same map so we can do the math in 8 bits:

			ld  a, (_n_pant)
			ld  b, a
			sla a
			add b

			ld  c, a
			ld  b, 0

			// BC = Index to the hotspots struct, which happens to be {xy, type, act}

			ld  hl, _hotspots
			add hl, bc

			// Now HL points to hotspots [n_pant]

			ld  a, (hl) 		// A = hotspots [n_pant].xy
			ld  b, a

			srl a
			srl a
			srl a
			srl a
			ld  (__x), a

			ld  a, b
			and 15
			ld  (__y), a

			inc hl 				// HL->hotspots [n_pant].type
			ld  b, (hl) 		// B = hotspots [n_pant].type
			inc hl 				// HL->hotspots [n_pant].act
			ld  c, (hl) 		// C = hotspots [n_pant].act

			// if (hotspots [n_pant].act && hotspots [n_pant].tipo) 

			xor a
			or  b
			jr  z, _hotspots_setup_done  
			
			xor a
			or  c
			jr  z, _hotspots_setup_done

		._hotspots_setup_do
			ld  a, (__x)
			ld  e, a
			sla a
			sla a
			sla a
			sla a
			ld  (_hotspot_x), a

			ld  a, (__y)
			ld  d, a
			sla a
			sla a
			sla a
			sla a
			ld  (_hotspot_y), a

			// orig_tile = map_buff [(_y << 4) - _y + _x];
			// A = (_y << 4), D = _y, E = _x, so
			sub d
			add e

			ld  e, a
			ld  d, 0
			ld  hl, _map_buff
			add hl, de
			ld  a, (hl)
			ld  (_orig_tile), a

			// _t = 16 + (hotspots [n_pant].tipo != 3 ? hotspots [n_pant].tipo : 0);
			ld  a, b
			cp  3
			jp  nz, _hotspots_setup_set

		._hotspots_setup_set_refill
			xor a
		._hotspots_setup_set
			add 16
			ld  (__t), a		

			call _draw_coloured_tile_gamearea

		._hotspots_setup_done
	#endasm

	#if !defined DEACTIVATE_KEYS && MAX_CERROJOS > 0
		// Open locks
		/*
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
		*/
		#asm
				// CERROJOS structure is 4 bytes wide: { np, x, y, st }
				ld  hl, _cerrojos
				ld  b, MAX_CERROJOS
			._open_locks_loop
				push bc
				
				ld  a, (_n_pant)
				ld  c, a

				ld  b, (hl)			// B = cerrojos [gpit].np
				inc hl

				ld  d, (hl) 		// D = cerrojos [gpit].x;
				inc hl

				ld  e, (hl)			// E = cerrojos [gpit].y;
				inc hl

				ld  a, (hl)			// A = cerrojos [gpit].st
				inc hl

				or  a
				jr  nz, _open_locks_done

				ld  a, b
				cp  c
				jr  nz, _open_locks_done
				
			// Remove x=y=np=0 pseudobug in multilevel games
			#ifdef COMPRESSED_LEVELS
				ld  a, b
				or  d
				or  e
				jr  z, _open_locks_done				
			#endif

			._open_locks_do
				ld  a, d
				ld  (__x), a
				ld  a, e
				ld  (__y), a
				
				sla a
				sla a
				sla a
				sla a
				sub e
				add d

				ld  b, 0
				ld  c, a
				xor a
				
				push hl 			// Save for later.
				
				ld  hl, _map_attr
				add hl, bc
				ld  (hl), a
				ld  hl, _map_buff
				add hl, bc
				ld  (hl), a

				ld  (__t), a

				call _draw_coloured_tile_gamearea

				pop hl

			._open_locks_done
				
				pop bc
				dec b
				jr  nz, _open_locks_loop
		#endasm
	#endif
}

void draw_scr (void) {
	is_rendering = 1;

	#ifdef ENABLE_TILANIMS
		tilanims_reset ();
	#endif

	#ifdef ENABLE_FIRE_ZONE
		f_zone_ac = 0;
	#endif	

	draw_scr_background ();

	// Object setup

	enems_load ();

	#ifdef ACTIVATE_SCRIPTING
		#if defined LINE_OF_TEXT && !defined LINE_OF_TEXT_NO_AUTOERASE
			_x = LINE_OF_TEXT_X; _y = LINE_OF_TEXT; _t = LINE_OF_TEXT_ATTR; _gp_gen = "                              "; print_str ();
		#endif
		// Ejecutamos los scripts de entrar en pantalla:
		run_script (2 * MAP_W * MAP_H + 1); 	// ENTERING ANY
		run_script (n_pant << 1); 				// ENTERING SCREEN n
	#endif

	#include "my/ci/entering_screen.h"

	draw_scr_hotspots_locks ();

	#ifdef PLAYER_CAN_FIRE
		bullets_init ();
	#endif

	#ifdef ENABLE_SIMPLE_COCOS
		simple_coco_init ();
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

			#ifdef USE_TWO_BUTTONS
				isJoy = gpjt > '1';
			#endif

			break;
		}			
	}

	#ifdef MODE_128K
		STOP_SOUND ();
		PLAY_SOUND (SFX_START);
		sp_WaitForNoKey ();
	#endif
}

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
