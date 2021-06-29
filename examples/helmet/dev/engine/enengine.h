// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// enengine.h

#ifdef ENABLE_PURSUERS
	void enems_pursuers_init (void) {
		en_an_alive [enit] = 0;
		en_an_dead_row [enit] = DEATH_COUNT_ADD + (rand () & DEATH_COUNT_AND);
	}
#endif

#ifndef COMPRESSED_LEVELS
	#if defined(PLAYER_STEPS_ON_ENEMIES) || defined (PLAYER_CAN_FIRE)
		void enems_init (void) {
			enit = 0;
			while (enit < MAP_W * MAP_H * MAX_ENEMS) {
				malotes [enit].t = malotes [enit].t & 0xEF;	// Clear bit 4
				#ifdef PLAYER_CAN_FIRE
					malotes [enit].life = ENEMIES_LIFE_GAUGE;
				#endif
				enit ++;
			}
		}
	#endif
#endif

void enems_draw_current (void) {
	_en_x = malotes [enoffsmasi].x;
	_en_y = malotes [enoffsmasi].y;
	
	#asm
		; enter: IX = sprite structure address 
		;        IY = clipping rectangle, set it to "ClipStruct" for full screen 
		;        BC = animate bitdef displacement (0 for no animation) 
		;         H = new row coord in chars 
		;         L = new col coord in chars 
		;         D = new horizontal rotation (0..7) ie horizontal pixel position 
		;         E = new vertical rotation (0..7) ie vertical pixel position 

		// sp_moviles [enit] = sp_moviles + enit*2
		ld  a, (_enit)
		sla a
		ld  c, a
		ld  b, 0 				// BC = offset to [enit] in 16bit arrays
		ld  hl, _sp_moviles
		add hl, bc
		ld  e, (hl)
		inc hl 
		ld  d, (hl)
		push de						
		pop ix

		// Clipping rectangle
		ld  iy, vpClipStruct

		// Animation
		// en_an_next_frame [enit] - en_an_current_frame [enit]
		ld  hl, _en_an_current_frame
		add hl, bc 				// HL -> en_an_current_frame [enit]
		ld  e, (hl)
		inc hl 
		ld  d, (hl) 			// DE = en_an_current_frame [enit]

		ld  hl, _en_an_next_frame
		add hl, bc 				// HL -> en_an_next_frame [enit]
		ld  a, (hl)
		inc hl
		ld  h, (hl)
		ld  l, a 				// HL = en_an_next_frame [enit]

		or  a 					// clear carry
		sbc hl, de 				// en_an_next_frame [enit] - en_an_current_frame [enit]

		push bc 				// Save for later

		ld  b, h
		ld  c, l 				// ** BC = animate bitdef **

		//VIEWPORT_Y + (rdy >> 3), VIEWPORT_X + (rdx >> 3)
		ld  a, (__en_y)					
		srl a
		srl a
		srl a
		add VIEWPORT_Y
		ld h, a

		ld  a, (__en_x)
		srl a
		srl a
		srl a
		add VIEWPORT_X
		ld  l, a

		// rdx & 7, rdy & 7
		ld  a, (__en_x)
		and 7
		ld  d, a

		ld  a, (__en_y)
		and 7
		ld  e, a

		call SPMoveSprAbs

		// en_an_current_frame [enit] = en_an_next_frame [enit];

		pop bc 					// Retrieve index

		ld  hl, _en_an_current_frame
		add hl, bc
		ex  de, hl 				// DE -> en_an_current_frame [enit]	

		ld  hl, _en_an_next_frame
		add hl, bc 				// HL -> en_an_next_frame [enit]
		
		ldi
		ldi
	#endasm
}

void enems_load (void) {
	// Movemos y cambiamos a los enemigos según el tipo que tengan
	enoffs = n_pant * MAX_ENEMS;
	
	for (enit = 0; enit < MAX_ENEMS; ++ enit) {
		en_an_frame [enit] = 0;
		en_an_state [enit] = 0;
		en_an_count [enit] = 3;
		enoffsmasi = enoffs + enit;

		#ifdef RESPAWN_ON_ENTER
			// Back to life!
			malotes [enoffsmasi].t &= 0xEF;		
			#ifdef PLAYER_CAN_FIRE
				#if defined (COMPRESSED_LEVELS) && defined (MODE_128K)
					malotes [enoffsmasi].life = level_data.enems_life;
				#else
					malotes [enoffsmasi].life = ENEMIES_LIFE_GAUGE;
				#endif
			#endif
		#endif

		#include "my/ci/enems_custom_respawn.h"

		en_an_next_frame [enit] = sprite_18_a;

		switch (malotes [enoffsmasi].t & 0x1f) {
			case 1:
			case 2:
			case 3:
			case 4:
				en_an_base_frame [enit] = (malotes [enoffsmasi].t - 1) << 1;
				break;

			#ifdef ENABLE_ORTHOSHOOTERS
				case 5:					
					#if ORTHOSHOOTERS_BASE_CELL==99
						en_an_base_frame [enit] = ORTHOSHOOTERS_BASE_CELL;
						en_an_next_frame [enit] = sprite_18_a;
					#else
						en_an_base_frame [enit] = ORTHOSHOOTERS_BASE_CELL << 1;
					#endif
					en_an_state [enit] = malotes [enoffsmasi].t >> 6;
					break;
			#endif

			#ifdef ENABLE_FANTIES
				case 6:
					en_an_base_frame [enit] = FANTIES_BASE_CELL << 1;
					en_an_x [enit] = malotes [enoffsmasi].x1 << 6;
					en_an_y [enit] = malotes [enoffsmasi].y1 << 6;
					en_an_vx [enit] = en_an_vy [enit] = 0;

					#ifdef PLAYER_CAN_FIRE
						malotes [enoffsmasi].life = FANTIES_LIFE_GAUGE;	
					#endif
					#ifdef FANTIES_TYPE_HOMING
						en_an_state [enit] = TYPE_6_IDLE;
					#endif
					break;				
			#endif

			#ifdef ENABLE_PURSUERS
				case 7:
					enems_pursuers_init ();
					break;
			#endif

				#include "my/ci/enems_load.h"
		}

		#include "my/ci/enems_extra_mods.h"
	}
}

void enems_kill (void) {
	if (_en_t != 7) _en_t |= 16;
	++ p_killed;

	#ifdef BODY_COUNT_ON
		flags [BODY_COUNT_ON] = p_killed;
	#endif

	#include "my/ci/on_enems_killed.h"

	#ifdef ACTIVATE_SCRIPTING					
		run_script (2 * MAP_W * MAP_H + 5); 	// PLAYER_KILLS_ENEMY
	#endif
}

void enems_move (void) {
	tocado = p_gotten = ptgmx = ptgmy = 0;

	for (enit = 0; enit < MAX_ENEMS; enit ++) {
		active = 0;
		enoffsmasi = enoffs + enit;

		// Copy array values to temporary variables as fast as possible
		
		#asm
				// Those values are stored in this order:
				// x, y, x1, y1, x2, y2, mx, my, t[, life]
				// Point HL to baddies [enoffsmasi]. The struct is 9 or 10 bytes long
				// so this is baddies + enoffsmasi*(9|10) depending on PLAYER_CAN_FIRE
				ld 	hl, (_enoffsmasi)
				ld  h, 0

			#if defined PLAYER_CAN_FIRE || defined COMPRESSED_LEVELS
				add hl, hl 				// x2
				ld  d, h
				ld  e, l 				// DE = x2
				add hl, hl 				// x4
				add hl, hl 				// x8

				add hl, de 				// HL = x8 + x2 = x10
			#else
				ld  d, h
				ld  e, l 				// DE = x1
				add hl, hl 				// x2
				add hl, hl 				// x4
				add hl, hl 				// x8

				add hl, de 				// HL = x8 + x1 = x9
			#endif

				ld  de, _malotes
				add hl, de

				ld  (__baddies_pointer), hl 		// Save address for later

				ld  a, (hl)
				ld  (__en_x), a
				inc hl 

				ld  a, (hl)
				ld  (__en_y), a
				inc hl 

				ld  a, (hl)
				ld  (__en_x1), a
				inc hl 

				ld  a, (hl)
				ld  (__en_y1), a
				inc hl 

				ld  a, (hl)
				ld  (__en_x2), a
				inc hl 

				ld  a, (hl)
				ld  (__en_y2), a
				inc hl 

				ld  a, (hl)
				ld  (__en_mx), a
				inc hl 

				ld  a, (hl)
				ld  (__en_my), a
				inc hl 

				ld  a, (hl)
				ld  (__en_t), a
				and 0x1f
				ld  (_rdt), a

			#ifdef PLAYER_CAN_FIRE
				inc hl 

				ld  a, (hl)
				ld  (__en_life), a
			#endif
		#endasm

		#if defined PLAYER_CAN_FIRE || defined ENABLE_PURSUERS
			_en_cx = _en_x; _en_cy = _en_y;
		#endif
		
		#ifdef MODE_128K
			if (en_an_state [enit] == GENERAL_DYING) {
				-- en_an_count [enit];
				if (en_an_count [enit] == 0) {
					en_an_state [enit] = 0;
					en_an_next_frame [enit] = sprite_18_a;
					continue;
				}
			}
		#endif

		#ifndef PLAYER_GENITAL
			#if defined (BOUNDING_BOX_8_CENTERED) || defined (BOUNDING_BOX_8_BOTTOM)
				pregotten = (gpx + 12 >= _en_x && gpx <= _en_x + 12);
			#else
				pregotten = (gpx + 15 >= _en_x && gpx <= _en_x + 15);
			#endif
		#endif

		switch (rdt) {
			case 1:
			case 2:
			case 3:
			case 4:
			#ifdef ENABLE_ORTHOSHOOTERS
				case 5:
			#endif
				#include "engine/enem_mods/enem_type_lineal.h"
				#ifdef ENABLE_ORTHOSHOOTERS
					if (rdt == 5) {
						#include "engine/enem_mods/enem_type_orthoshooters.h"
					}
				#endif
				break;

			#ifdef ENABLE_FANTIES
				case 6:	
					#include "engine/enem_mods/enem_type_fanties.h"
					break;
			#endif
			#ifdef ENABLE_PURSUERS
				case 7:
					#include "engine/enem_mods/enem_type_pursuers_asm.h"
					break;	
			#endif
			#include "my/ci/enems_move.h"
			/*
			default:
				if (en_an_state [enit] != GENERAL_DYING) en_an_next_frame [enit] = sprite_18_a;
			*/
		}
		
		if (active) {			
			// Animate
			if (en_an_base_frame [enit] != 99) {
				/*
				en_an_count [enit] ++; 
				if (en_an_count [enit] == 4) {
					en_an_count [enit] = 0;
					en_an_frame [enit] = !en_an_frame [enit];
					en_an_next_frame [enit] = enem_cells [en_an_base_frame [enit] + en_an_frame [enit]];
				}
				*/
				#asm
						ld  bc, (_enit)
						ld  b, 0

						ld  hl, _en_an_count
						add hl, bc
						ld  a, (hl)
						inc a
						ld  (hl), a

						cp  4
						jr  nz, _enems_move_update_frame_done

						xor a
						ld  (hl), a

						ld  hl, _en_an_frame
						add hl, bc
						ld  a, (hl)
						xor 1
						ld  (hl), a
						
						ld  hl, _en_an_base_frame
						add hl, bc
						ld  d, (hl)
						add d 							; A = en_an_base_frame [enit] + en_an_frame [enit]]

						sla c 							; Index 16 bits; it never overflows.
						ld  hl, _en_an_next_frame
						add hl, bc
						ex de, hl 						; DE -> en_an_next_frame [enit]

						sla a
						ld  c, a
						ld  b, 0

						ld  hl, _enem_cells
						add hl, bc 						; HL -> enem_cells [en_an_base_frame [enit] + en_an_frame [enit]]

						ldi
						ldi 							; Copy 16 bit
					._enems_move_update_frame_done
				#endasm
			}
			
			// Collide with player
			
			#if !defined PLAYER_GENITAL && !defined DISABLE_PLATFORMS
				// Platforms
				if (_en_t == 4) {
					if (pregotten) {

						// Horizontal moving platforms
						if (_en_mx) {
							if (gpy + 17 >= _en_y && gpy + 8 <= _en_y) {
								p_gotten = 1;
								ptgmx = _en_mx << 6;
								gpy = (_en_y - 16); p_y = gpy << 6;
							}
						}

						// Vertical moving platforms
						if (
							(_en_my < 0 && gpy + 18 >= _en_y && gpy + 8 <= _en_y) ||
							(_en_my > 0 && gpy + 17 + _en_my >= _en_y && gpy + 8 <= _en_y)
						) {
							p_gotten = 1;
							ptgmy = _en_my << 6;
							gpy = (_en_y - 16); p_y = gpy << 6;						
						}

					}
				} else
			#endif
			{
				#include "my/ci/custom_enems_player_collision.h"
			
				cx2 = _en_x; cy2 = _en_y;
				if (!tocado && collide () && p_estado == EST_NORMAL) {
					#ifdef PLAYER_STEPS_ON_ENEMIES
					// Step over enemy		
						#ifdef PLAYER_CAN_STEP_ON_FLAG
							if (flags [PLAYER_CAN_STEP_ON_FLAG] != 0 && 
								gpy < _en_y - 2 && p_vy >= 0 && rdt >= PLAYER_MIN_KILLABLE)
						#else
							if (gpy < _en_y - 2 && p_vy >= 0 && rdt >= PLAYER_MIN_KILLABLE)
						#endif				
						{
							#ifdef MODE_128K
								PLAY_SOUND (SFX_KILL_ENEMY_STEP);										
								en_an_state [enit] = GENERAL_DYING;
								en_an_count [enit] = 12;
								en_an_next_frame [enit] = sprite_17_a;
								p_vy = -256;
							#else
								en_an_next_frame [enit] = sprite_17_a;
								enems_draw_current ();
								sp_UpdateNow ();

								beep_fx (5);
								en_an_next_frame [enit] = sprite_18_a;								
							#endif					

							enems_kill ();
						} else
					#endif
					{
						tocado = 1;
						#if defined(SLOW_DRAIN) && defined(PLAYER_BOUNCES)
							if (!lasttimehit || ((maincounter & 3) == 0)) {
								#ifdef MODE_128K
									p_killme = SFX_ENEMY_HIT;
								#else							
									p_killme = 4;
								#endif
							}
						#else
						
							#ifdef MODE_128K
								p_killme = SFX_ENEMY_HIT;
							#else							
								p_killme = 4;
							#endif
						#endif					
						
						#ifdef PLAYER_BOUNCES
							#ifdef ENABLE_FANTIES
								if (_en_t == 6) {
									p_vx = en_an_vx [enit] + en_an_vx [enit];
									p_vy = en_an_vy [enit] + en_an_vy [enit];	
								} else
							#endif
							
							#ifndef PLAYER_GENITAL	
								{
									p_vx = addsign (_en_mx, PLAYER_MAX_VX);
									p_vy = addsign (_en_my, PLAYER_MAX_VX);
								}
							#else
								{
									if (_en_mx) {
										p_vx = addsign (gpx - _en_x, abs (_en_mx) << 8);
									}
									if (_en_my) {
										p_vy = addsign (gpy - _en_y, abs (_en_my) << 8);
									}
								}
							#endif
						#endif

						#include "my/ci/on_enems_collision.h"
					}
				}
			}
			player_enem_collision_done:
			
			#ifdef PLAYER_CAN_FIRE
				// Collide with bullets
				#ifdef FIRE_MIN_KILLABLE
					if (rdt >= FIRE_MIN_KILLABLE)
				#endif				
				{
					for (gpjt = 0; gpjt < MAX_BULLETS; gpjt ++) {
						if (bullets_estado [gpjt] == 1) {
							blx = bullets_x [gpjt] + 3; 
							bly = bullets_y [gpjt] + 3;
							if (blx >= _en_x && blx <= _en_x + 15 && bly >= _en_y && bly <= _en_y + 15) {
								#ifdef ENABLE_FANTIES
									if (_en_t == 6) {
										en_an_vx [enit] += addsign (bullets_mx [gpjt], 128);
									}
								#endif
								_en_x = _en_cx;
								_en_y = _en_cy;
								en_an_next_frame [enit] = sprite_17_a;
								bullets_estado [gpjt] = 0;
								#if !defined PLAYER_GENITAL && !defined DISABLE_PLATFORMS							
									if (_en_t != 4) -- _en_life;
								#else
									-- _en_life;
								#endif
								
								if (_en_life == 0) {
									enems_draw_current ();
									sp_UpdateNow ();
									#ifdef MODE_128K
										en_an_state [enit] = GENERAL_DYING;
										en_an_count [enit] = 12;
										PLAY_SOUND (SFX_KILL_ENEMY_SHOOT);
									#else															
										beep_fx (5);
										en_an_next_frame [enit] = sprite_18_a;
									#endif	
									
									#ifdef ENABLE_PURSUERS
										enems_pursuers_init ();
									#endif

									enems_kill ();					
								}

								#ifdef MODE_128K
									PLAY_SOUND (SFX_HIT_ENEMY);
								#else
									beep_fx (1);
								#endif
							}
						}
					}

				}
			#endif

			#include "my/ci/enems_extra_actions.h"
		} 

		#asm		
				// Those values are stored in this order:
				// x, y, x1, y1, x2, y2, mx, my, t[, life]

				ld  hl, (__baddies_pointer) 		// Restore pointer

				ld  a, (__en_x)
				ld  (hl), a
				inc hl

				ld  a, (__en_y)
				ld  (hl), a
				inc hl

				ld  a, (__en_x1)
				ld  (hl), a
				inc hl

				ld  a, (__en_y1)
				ld  (hl), a
				inc hl

				ld  a, (__en_x2)
				ld  (hl), a
				inc hl

				ld  a, (__en_y2)
				ld  (hl), a
				inc hl

				ld  a, (__en_mx)
				ld  (hl), a
				inc hl

				ld  a, (__en_my)
				ld  (hl), a
				inc hl

				ld  a, (__en_t)
				ld  (hl), a
				inc hl

			#ifdef PLAYER_CAN_FIRE
				ld  a, (__en_life)
				ld  (hl), a
			#endif
		#endasm	
	}

	#if defined(SLOW_DRAIN) && defined(PLAYER_BOUNCES)
		lasttimehit = tocado;
	#endif
}
