// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

// mainloop.h
// Churrera copyleft 2011 by The Mojon Twins.

void main (void) {

	// Install ISR
	
	#asm
		di
	#endasm
	
	#if defined MODE_128K || defined MIN_FAPS_PER_FRAME
		sp_InitIM2(0xf1f1);
		sp_CreateGenericISR(0xf1f1);
		sp_RegisterHook(255, ISR);
		
		#asm
			ei
		#endasm
	#endif

	#ifdef MODE_128K		
		#ifdef USE_ARKOS_PLAYER
			arkos_stop();
		#else
			wyz_init ();
		#endif

	#endif

	#include "my/ci/after_load.h"

	cortina ();
	
	// splib2 initialization
	sp_Initialize (0, 0);
	sp_Border (BLACK);
	sp_AddMemory(0, NUMBLOCKS, 14, AD_FREE);
	
	// Load tileset
	#ifdef COMPRESSED_LEVELS
		gen_pt = font;
	#else
		gen_pt = tileset;
	#endif
	gpit = 0; do {
		sp_TileArray (gpit, gen_pt);
		gen_pt += 8;
		gpit ++;
		#ifdef COMPRESSED_LEVELS
			if (gpit == 64) gen_pt = tileset;
		#endif
	} while (gpit);

	// Sprite creation
	#ifdef NO_MASKS
		sp_player = sp_CreateSpr (NO_MASKS, 3, sprite_2_a);
		sp_AddColSpr (sp_player, sprite_2_b);
		sp_AddColSpr (sp_player, sprite_2_c);
		p_current_frame = p_next_frame = sprite_2_a;
		
		for (gpit = 0; gpit < MAX_ENEMS; gpit ++) {
			sp_moviles [gpit] = sp_CreateSpr(NO_MASKS, 3, sprite_9_a);
			sp_AddColSpr (sp_moviles [gpit], sprite_9_b);
			sp_AddColSpr (sp_moviles [gpit], sprite_9_c);	
			en_an_current_frame [gpit] = sprite_9_a;
		}
	#else
		sp_player = sp_CreateSpr (sp_MASK_SPRITE, 3, sprite_2_a);
		sp_AddColSpr (sp_player, sprite_2_b);
		sp_AddColSpr (sp_player, sprite_2_c);
		p_current_frame = p_next_frame = sprite_2_a;
		
		for (gpit = 0; gpit < MAX_ENEMS; gpit ++) {
			sp_moviles [gpit] = sp_CreateSpr(sp_MASK_SPRITE, 3, sprite_9_a);
			sp_AddColSpr (sp_moviles [gpit], sprite_9_b);
			sp_AddColSpr (sp_moviles [gpit], sprite_9_c);	
			en_an_current_frame [gpit] = en_an_next_frame [gpit] = sprite_9_a;
		}
	#endif

	#ifdef PLAYER_CAN_FIRE
		for (gpit = 0; gpit < MAX_BULLETS; gpit ++) {
			#ifdef MASKED_BULLETS
				sp_bullets [gpit] = sp_CreateSpr (sp_MASK_SPRITE, 2, sprite_19_a);
			#else		
				sp_bullets [gpit] = sp_CreateSpr (sp_OR_SPRITE, 2, sprite_19_a);
			#endif
			sp_AddColSpr (sp_bullets [gpit], sprite_19_a+32);
		}
	#endif

	#ifdef ENABLE_SIMPLE_COCOS
		for (gpit = 0; gpit < MAX_ENEMS; gpit ++) {
			#ifdef MASKED_BULLETS
				sp_cocos [gpit] = sp_CreateSpr (sp_MASK_SPRITE, 2, sprite_19_a);
			#else		
				sp_cocos [gpit] = sp_CreateSpr (sp_OR_SPRITE, 2, sprite_19_a);
			#endif
			sp_AddColSpr (sp_cocos [gpit], sprite_19_a+32);
		}
	#endif

	#include "my/ci/after_splib2_init.h"

	while (1) {
		#if defined ACTIVATE_SCRIPTING && !defined MODE_128K
			main_script_offset = (int) (main_script);
		#endif

		level = 0;

		// Here the title screen
		
		#include "my/title_screen.h"
		
		#ifdef ENABLE_CHECKPOINTS
			sg_submenu ();
		#endif

		#include "my/ci/before_game.h"

		#ifdef NO_RESET_STATS
			p_objs = 0;
			p_keys = 0;
			p_killed = 0;
			#ifdef MAX_AMMO
				#ifdef INITIAL_AMMO
					p_ammo = INITIAL_AMMO;
				#else
					p_ammo = MAX_AMMO;
				#endif
			#endif
		#endif

		#ifdef COMPRESSED_LEVELS
			silent_level = 0;

			#ifdef ENABLE_CHECKPOINTS
				if (sg_do_load) level = sg_level; else level = 0;
			#endif

			#ifndef REFILL_ME
				p_life = PLAYER_LIFE;
			#endif

			#ifdef ACTIVATE_SCRIPTING
				script_result = 0;
			#else
				warp_to_level = 0;
			#endif

			while (1) 
		#endif
		
		{
			#ifdef COMPRESSED_LEVELS
				if (silent_level == 0) {
					#include "my/level_screen.h"
				}
				silent_level = 0;
			
				prepare_level ();				
			#endif
					
			#ifndef DIRECT_TO_PLAY
				// Clear screen and show game frame
				cortina ();
				sp_UpdateNow();
				#ifdef MODE_128K
					// Resource 1 = marco.bin
					get_resource (MARCO_BIN, 16384);
				#else		
					#asm
						ld hl, _s_marco
						ld de, 16384
						call depack
					#endasm
				#endif
			#endif

			// Let's do it.
			#include "mainloop/game_loop.h"

			#ifdef COMPRESSED_LEVELS
				if (success) {
					#ifdef MODE_128K
						//PLAY_MUSIC (6);
					#endif
					
					if (silent_level == 0) zone_clear ();

					#ifdef ACTIVATE_SCRIPTING
						if (script_result != 3)
					#else
						if (warp_to_level == 0)
					#endif
					{
						level ++;
					} 
					
					if (level >= MAX_LEVELS 
						#ifdef ACTIVATE_SCRIPTING
							|| script_result == 4
						#endif
					) {
						game_ending ();
						break;
					}
				} else {
					#ifdef MODE_128K
						//PLAY_MUSIC (8);
					#endif

					#if defined(TIMER_ENABLE) && defined(TIMER_GAMEOVER_0) && defined(SHOW_TIMER_OVER)
						if (timer_zero) time_over (); else game_over ();
					#else
						game_over ();
					#endif
					
					#ifdef MODE_128K
						STOP_SOUND ();
					#endif
					break;
				}
			#else
				if (success) {
					game_ending (); 
				} else {
					//PLAY_MUSIC (8);
					game_over ();
				}
			#endif
			#if !defined (DIRECT_TO_PLAY) || !defined (COMPRESSED_LEVELS)
				cortina ();
			#endif
		}
		
		clear_sprites ();
	}
}
