// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// mainloop.h
// Churrera copyleft 2011 by The Mojon Twins.

void clear_sprites (void) {
	#asm
			ld  ix, (_sp_player)
			ld  iy, vpClipStruct
			ld  bc, 0
			ld  hl, 0xdede
			ld  de, 0
			call SPMoveSprAbs
	
			xor a
		.hide_sprites_enems_loop
			ld  (_gpit), a

			sla a
			ld  c, a
			ld  b, 0
			ld  hl, _sp_moviles
			add hl, bc
			ld  e, (hl)
			inc hl
			ld  d, (hl)
			push de
			pop ix

			ld  iy, vpClipStruct
			ld  bc, 0
			ld  hl, 0xfefe	// -2, -2
			ld  de, 0

			call SPMoveSprAbs

			ld  a, (_gpit)
			inc a
			cp  3
			jr  nz, hide_sprites_enems_loop

		#ifdef PLAYER_CAN_FIRE
				xor a
			.hide_sprites_bullets_loop
				ld  (_gpit), a

				sla a
				ld  c, a
				ld  b, 0
				ld  hl, _sp_bullets
				add hl, bc
				ld  e, (hl)
				inc hl
				ld  d, (hl)
				push de
				pop ix

				ld  iy, vpClipStruct
				ld  bc, 0
				ld  hl, 0xfefe	// -2, -2
				ld  de, 0

				call SPMoveSprAbs

				ld  a, (_gpit)
				inc a
				cp  MAX_BULLETS
				jr  nz, hide_sprites_bullets_loop
		#endif
	#endasm
}

void main (void) {

	// Install ISR
	
	#asm
		di
	#endasm
	
	#ifdef MODE_128K
		sp_InitIM2(0xf1f1);
		sp_CreateGenericISR(0xf1f1);
		sp_RegisterHook(255, ISR);
		
		#asm
			ei
		#endasm

		wyz_init ();
	#endif

	cortina ();
	
	// splib2 initialization
	sp_Initialize (7, 0);
	sp_Border (BLACK);
	sp_AddMemory(0, NUMBLOCKS, 14, AD_FREE);
	
	// Load tileset
	gen_pt = tileset;
	gpit = 0; do {
		sp_TileArray (gpit, gen_pt);
		gen_pt += 8;
		gpit ++;
	} while (gpit);

	// Sprite creation
	#ifdef NO_MASKS
		sp_player = sp_CreateSpr (sp_OR_SPRITE, 3, sprite_2_a, 1, TRANSPARENT);
		sp_AddColSpr (sp_player, sprite_2_b, TRANSPARENT);
		sp_AddColSpr (sp_player, sprite_2_c, TRANSPARENT);
		p_current_frame = p_next_frame = sprite_2_a;
		
		for (gpit = 0; gpit < 3; gpit ++) {
			sp_moviles [gpit] = sp_CreateSpr(sp_OR_SPRITE, 3, sprite_9_a, 1, TRANSPARENT);
			sp_AddColSpr (sp_moviles [gpit], sprite_9_b, TRANSPARENT);
			sp_AddColSpr (sp_moviles [gpit], sprite_9_c, TRANSPARENT);	
			en_an_current_frame [gpit] = sprite_9_a;
		}
	#else
		sp_player = sp_CreateSpr (sp_MASK_SPRITE, 3, sprite_2_a, 1, TRANSPARENT);
		sp_AddColSpr (sp_player, sprite_2_b, TRANSPARENT);
		sp_AddColSpr (sp_player, sprite_2_c, TRANSPARENT);
		p_current_frame = p_next_frame = sprite_2_a;
		
		for (gpit = 0; gpit < 3; gpit ++) {
			sp_moviles [gpit] = sp_CreateSpr(sp_MASK_SPRITE, 3, sprite_9_a, 2, TRANSPARENT);
			sp_AddColSpr (sp_moviles [gpit], sprite_9_b, TRANSPARENT);
			sp_AddColSpr (sp_moviles [gpit], sprite_9_c, TRANSPARENT);	
			en_an_current_frame [gpit] = en_an_next_frame [gpit] = sprite_9_a;
		}
	#endif

	#ifdef PLAYER_CAN_FIRE
		for (gpit = 0; gpit < MAX_BULLETS; gpit ++) {
			#ifdef MASKED_BULLETS
				sp_bullets [gpit] = sp_CreateSpr (sp_MASK_SPRITE, 2, sprite_19_a, 1, TRANSPARENT);
			#else		
				sp_bullets [gpit] = sp_CreateSpr (sp_OR_SPRITE, 2, sprite_19_a, 1, TRANSPARENT);
			#endif
			sp_AddColSpr (sp_bullets [gpit], sprite_19_a+32, TRANSPARENT);
		}
	#endif

	#include "my/ci/after_load.h"

	while (1) {
		#ifdef ACTIVATE_SCRIPTING
			main_script_offset = (int) (main_script);
		#endif

		// Here the title screen
		sp_UpdateNow();
		blackout ();
		#ifdef MODE_128K
			// Resource 0 = title.bin
			get_resource (0, 16384);
		#else		
			#asm
				ld hl, _s_title
				ld de, 16384
				call depack
			#endasm
		#endif
		
		#ifdef MODE_128K
			//wyz_play_music (0);
		#endif
		
		select_joyfunc ();
		
		#ifdef MODE_128K
			//wyz_stop_sound ();
		#endif

		#ifdef ENABLE_CHECKPOINTS
			sg_submenu ();
		#endif

		#include "my/ci/before_game.h"

		#ifdef COMPRESSED_LEVELS
			mlplaying = 1;
			#ifdef ENABLE_CHECKPOINTS
				if (sg_do_load) level = sg_level; else level = 0;
			#else
				level = 0;
			#endif				
			#ifndef REFILL_ME
				p_life = PLAYER_LIFE;
			#endif
			while (mlplaying) {
				prepare_level (level);			
				blackout_area ();

				#include "my/level_screen.h"
		#endif
					
		#ifndef DIRECT_TO_PLAY
			// Clear screen and show game frame
			cortina ();
			sp_UpdateNow();
			#ifdef MODE_128K
				// Resource 1 = marco.bin
				get_resource (1, 16384);
			#else		
				#asm
					ld hl, _s_marco
					ld de, 16384
					call depack
				#endasm
			#endif
		#endif

		// Let's do it.

		playing = 1;
		player_init ();

		#ifndef COMPRESSED_LEVELS		
			hotspots_init ();
		#endif

		#ifndef COMPRESSED_LEVELS		
			#ifndef DEACTIVATE_KEYS
				locks_init ();
			#endif
		#endif

		#if defined(PLAYER_STEPS_ON_ENEMIES) || defined (PLAYER_CAN_FIRE)
			#ifndef COMPRESSED_LEVELS
				enems_init ();
			#endif
		#endif	

		#ifndef COMPRESSED_LEVELS	
			n_pant = SCR_INICIO;
		#endif		

		maincounter = 0;
		
		#ifdef ACTIVATE_SCRIPTING		
			script_result = 0;
		#endif

		#ifdef ACTIVATE_SCRIPTING
			// Entering game
			run_script (2 * MAP_W * MAP_H);
		#endif

		#include "my/ci/entering_game.h"
				
		#ifdef PLAYER_STEPS_ON_ENEMIES 	
			#ifdef SHOW_TOTAL
			// Show total of enemies next to the killed amount.
			_x = KILLED_Y; _y = KILLED_X; _t = BADDIES_COUNT; print_number2 ();
			#endif
		#endif

		p_killme = success = half_life = 0;
			
		objs_old = keys_old = life_old = killed_old = 0xff;
		#ifdef MAX_AMMO 	
			ammo_old = 0xff;
		#endif
		#if defined(TIMER_ENABLE) && defined(PLAYER_SHOW_TIMER)
			timer_old = 0;
		#endif
		
		#ifdef PLAYER_CHECK_MAP_BOUNDARIES		
			#ifdef MODE_128K
				x_pant = n_pant % level_data->map_w;
				y_pant = n_pant / level_data->map_w;
			#else
				x_pant = n_pant % MAP_W; y_pant = n_pant / MAP_W;
			#endif
		#endif

		#ifdef ENABLE_CHECKPOINTS
			if (sg_do_load) {
				mem_load ();
			}
		#endif		

		#ifdef MODE_128K
				// Play music
			#ifdef COMPRESSED_LEVELS		
				//wyz_play_music (levels [level].music_id);
			#else
				//wyz_play_music (1);
			#endif		
		#endif

		#ifdef MSC_MAXITEMS
			display_items ();
		#endif

		o_pant = 0xff;
		while (playing) {
			pad0 = (joyfunc) (&keys);

			if (o_pant != n_pant) {
				#include "my/ci/before_entering_screen.h"
				draw_scr ();
				o_pant = n_pant;
			}

			#ifdef TIMER_ENABLE
				// Timer
				if (ctimer.on) {
					ctimer.count ++;
					if (ctimer.count == ctimer.frames) {
						ctimer.count = 0;
						ctimer.t --;
						if (ctimer.t == 0) ctimer.zero = 1;
					}
				}

				#if defined(TIMER_SCRIPT_0) && defined(ACTIVATE_SCRIPTING)
					if (ctimer.zero) {
						ctimer.zero = 0;
						#ifdef SHOW_TIMER_OVER
							clear_sprites ();
							time_over ();
						#endif
						run_script (2 * MAP_W * MAP_H + 3); 	// ON_TIMER_OFF	
					}	
				#endif

				#ifdef TIMER_KILL_0
					if (ctimer.zero) {
						#ifdef SHOW_TIMER_OVER
							#ifndef TIMER_SCRIPT_0
								clear_sprites ();
								time_over ();
							#endif
						#endif				
						ctimer.zero = 0;
						#ifdef TIMER_AUTO_RESET 			
							ctimer.t = TIMER_INITIAL;
						#endif
						
						#ifdef MODE_128K
							p_killme = 7;
						#else
							p_killme = 4;
						#endif

						#ifdef PLAYER_FLICKERS
							p_estado = EST_PARP;
							p_ct_estado = 50;
						#endif

						#if defined(TIMER_WARP_TO_X) && defined(TIMER_WARP_TO_Y)
							p_x = TIMER_WARP_TO_X << 10;
							p_y = TIMER_WARP_TO_Y << 10;
						#endif

						#ifdef TIMER_WARP_TO
							n_pant = TIMER_WARP_TO;
							draw_scr ();
						#endif
					}
				#endif
			#endif

			#include "mainloop/hud.h"

			maincounter ++;
			half_life = !half_life;
			
			// Move player
			player_move ();
			
			// Move enemies
			enems_move ();

			if (p_killme) player_kill (p_killme);

			#ifdef PLAYER_CAN_FIRE
				// Move bullets 			
				bullets_move ();
			#endif

			#ifdef ENABLE_TILANIMS
				do_tilanims ();
			#endif

			// Detect fire zone
			#if defined ACTIVATE_SCRIPTING && defined ENABLE_FIRE_ZONE
				if (f_zone_ac == 1) {
					if (gpx >= fzx1 && gpx <= fzx2 && gpy >= fzy1 && gpy <= fzy2) {
						run_fire_script ();
					}	
				}
			#endif

			// Render
			if (o_pant == n_pant) {
				#include "mainloop/update_sprites.h"

				sp_UpdateNow();
			}

			#ifdef PLAYER_FLICKERS
				// Flickering
				if (p_estado == EST_PARP) {
					p_ct_estado --;
					if (p_ct_estado == 0)
						p_estado = EST_NORMAL; 
				}
			#endif			
			
			// Hotspot interaction.
			hotspots_do ();

			// Scripting related stuff
			
			#ifdef ACTIVATE_SCRIPTING

				// Select object
				#ifdef MSC_MAXITEMS
					if (sp_KeyPressed (KEY_Z)) {
						if (!key_z_pressed) {
							#ifdef MODE_128K
								wyz_play_sound (0);
							#else
								beep_fx (2);
							#endif
							flags [FLAG_SLOT_SELECTED] = (flags [FLAG_SLOT_SELECTED] + 1) % MSC_MAXITEMS;
							display_items ();
						}
						key_z_pressed = 1;
					} else {
						key_z_pressed = 0;
					}
				#endif			

				#ifdef SCRIPTING_KEY_M			
					if (sp_KeyPressed (KEY_M))
				#endif
				#ifdef SCRIPTING_DOWN
					if ((pad0 & sp_DOWN) == 0)
				#endif
				#ifdef SCRIPTING_KEY_FIRE
					if ((pad0 & sp_FIRE) == 0)
				#endif
				{
					// Any scripts to run in this screen?
					run_fire_script ();
				}
			#endif

			#ifdef PAUSE_ABORT
				// Pause/Abort handling
				if (sp_KeyPressed (KEY_H)) {
					sp_WaitForNoKey ();
					#ifdef MODE_128K
						wyz_stop_sound ();
						wyz_play_sound (1);
					#endif				
					clear_sprites ();
					pause_screen ();
					while (!sp_KeyPressed (KEY_H));
					sp_WaitForNoKey ();
					draw_scr ();
					#ifdef MODE_128K
						#ifdef COMPRESSED_LEVELS
							//wyz_play_music (levels [level].music_id);
						#else
							//wyz_play_music (1);
						#endif
					#endif				
				}			
				if (sp_KeyPressed (KEY_Y)) {
					playing = 0;
				}
			#endif

			// Flick the screen ?
				
			#include "mainloop/flick_screen.h"			

			// Win game condition
			
			if (0
				#ifdef ACTIVATE_SCRIPTING
					|| script_result == 1 || script_result > 2
				#endif
				#if PLAYER_NUM_OBJETOS != 99
					|| p_objs == PLAYER_NUM_OBJETOS
				#endif
				#if SCR_FIN != 99
					|| (n_pant == SCR_FIN
					#if PLAYER_FIN_X != 99 && PLAYER_FIN_Y != 99
						&& ((gpx + 8) >> 4) == PLAYER_FIN_X && ((gpy + 8) >> 4) == PLAYER_FIN_Y
					#endif
					)
				#endif
			) {
				success = 1;
				playing = 0;
			}
			
			// Game over condition
			if (p_life == 0
				#ifdef ACTIVATE_SCRIPTING
					|| (script_result == 2)
				#endif
				#if defined(TIMER_ENABLE) && defined(TIMER_GAMEOVER_0)
					|| ctimer.zero
				#endif
			) {
				playing = 0;				
			}

			#include "my/ci/extra_routines.h"
		}
		sp_WaitForNoKey ();
		
		#ifdef MODE_128K		
			wyz_stop_sound ();
		#endif

		clear_sprites ();
		sp_UpdateNow ();

		#include "my/ci/after_game_loop.h"
		
		#ifdef COMPRESSED_LEVELS
			if (success) {
				/*
				wyz_play_music (6);
				_x = 10; _y = 11; _t = 79; _gp_gen = spacer; print_str ();
				_x = 10; _y = 12; _t = 79; _gp_gen = " ZONE CLEAR "; print_str ();
				_x = 10; _y = 13; _t = 79; _gp_gen = spacer; print_str ();
				sp_UpdateNow ();
				sp_WaitForNoKey ();
				espera_activa (250);			
				*/
				level ++;
				if (level == MAX_LEVELS) {
					game_ending ();
					mlplaying = 0;
				}
			} else {
				#ifdef MODE_128K
					//wyz_play_music (8);
				#endif
				#if defined(TIMER_ENABLE) && defined(TIMER_GAMEOVER_0) && defined(SHOW_TIMER_OVER)
					if (ctimer.zero) time_over (); else game_over ();
				#else
					game_over ();
				#endif
				mlplaying = 0;
				#ifdef MODE_128K
					wyz_stop_sound ();
				#endif
			}
		}
		cortina ();
		#else
			if (success) {
				game_ending (); 
			} else {
				//wyz_play_music (8);
				game_over ();
			}
			cortina ();
		#endif
	}
}
