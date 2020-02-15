// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// hotspots.h

#ifndef COMPRESSED_LEVELS
	void hotspots_init (void) {
		gpit = 0; while (gpit < MAP_W * MAP_H) {
			hotspots [gpit].act = 1; ++ gpit;
		}
	}
#endif

void hotspots_do (void) {
	if (hotspots [n_pant].act == 0) return;

	cx2 = hotspot_x; cy2 = hotspot_y; if (collide ()) {
		// Deactivate hotspot
		hotspot_destroy = 1;
			
		switch (hotspots [n_pant].tipo) {
			#ifndef DEACTIVATE_OBJECTS					   
				case 1:
					#ifdef ONLY_ONE_OBJECT
						if (p_objs == 0) {
							p_objs ++;
							#ifdef MODE_128K
								wyz_play_sound (SFX_ONE_OBJECT_GET);
							#else
								beep_fx (9);
							#endif
						} else {
							#ifdef MODE_128K
								wyz_play_sound (SFX_ONE_OBJECT_WRONG);
							#else
								beep_fx (4);
							#endif
							hotspot_destroy = 0;
							hotspot_y = 240;
						}
					#else
						++ p_objs;
						#ifdef OBJECT_COUNT
							flags [OBJECT_COUNT] = p_objs;
						#endif

						#ifdef MODE_128K
							wyz_play_sound (SFX_OBJECT_GET);
						#else
							beep_fx (9);
						#endif

						#if defined GET_X_MORE && defined PLAYER_NUM_OBJETOS
							if (PLAYER_NUM_OBJETOS > p_objs) {
								_x = 10; _y = 11; _t = 79; _gp_gen = spacer; print_str ();
								getxmore [5] = '0' + PLAYER_NUM_OBJETOS - p_objs;
								_x = 10; _y = 12; _t = 79; _gp_gen = getxmore; print_str ();
								_x = 10; _y = 13; _t = 79; _gp_gen = spacer; print_str ();
								sp_UpdateNow ();
								sp_WaitForNoKey ();
								espera_activa (100);
								draw_scr_background ();
							}
						#endif							
					#endif
					break;
			#endif

			#ifndef DEACTIVATE_KEYS
				case 2:
					p_keys ++;
					#ifdef MODE_128K
						wyz_play_sound (SFX_KEY_GET);
					#else
						beep_fx (7);
					#endif
					break;
			#endif

			#ifndef DEACTIVATE_REFILLS
				case 3:
					p_life += PLAYER_REFILL;
					if (p_life > PLAYER_LIFE)
						p_life = PLAYER_LIFE;
					#ifdef MODE_128K
						wyz_play_sound (SFX_REFILL_GET);
					#else	
						beep_fx (8);
					#endif
					break;
			#endif

			#ifdef MAX_AMMO
				case 4:
					if (MAX_AMMO - p_ammo > AMMO_REFILL)
						p_ammo += AMMO_REFILL;
					else
						p_ammo = MAX_AMMO;
					#ifdef MODE_128K
						wyz_play_sound (SFX_REFILL_GET);
					#else
						beep_fx (9);
					#endif
					break;
			#endif

			#ifdef TIMER_ENABLE
				case 5:
					if (99 - timer_t > TIMER_REFILL)
						timer_t += TIMER_REFILL;
					else
						timer_t = 99;
					#ifdef MODE_128K
						wyz_play_sound (SFX_REFILL_GET);
					#else
						beep_fx (7);
					#endif
					break;
			#endif

			#ifdef ENABLE_CHECKPOINTS
				case 6:
					mem_save ();
					#ifdef MODE_128K
						wyz_play_sound (SFX_START);
					#else
						beep_fx (7);
					#endif
					break;						
			#endif

			#include "my/ci/hotspots_custom.h"
		}
			
		if (hotspot_destroy) {
			hotspots [n_pant].act = 0;
			_x = hotspot_x >> 4; _y = hotspot_y >> 4; _t = orig_tile;
			draw_invalidate_coloured_tile_gamearea ();
			hotspot_y = 240;
		}
	}
}
