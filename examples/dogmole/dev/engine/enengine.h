// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// enengine.h

#ifndef COMPRESSED_LEVELS
	#if defined(PLAYER_STEPS_ON_ENEMIES) || defined (PLAYER_CAN_FIRE)
		void enems_init (void) {
			enit = 0;
			while (enit < MAP_W * MAP_H * 3) {
				malotes [enit].t = malotes [enit].t & 15;	
				#ifdef PLAYER_CAN_FIRE
					malotes [enit].life = ENEMIES_LIFE_GAUGE;
				#endif
				enit ++;
			}
		}
	#endif
#endif

void enems_load (void) {
	// Movemos y cambiamos a los enemigos según el tipo que tengan
	enoffs = n_pant * 3;
	
	for (enit = 0; enit < 3; ++ enit) {
		en_an_frame [enit] = 0;
		en_an_count [enit] = 3;
		en_an_state [enit] = 0;
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

		switch (malotes [enoffsmasi].t) {
			case 1:
			case 2:
			case 3:
			case 4:
				en_an_base_frame [enit] = (malotes [enoffsmasi].t - 1) << 1;
				break;

			#ifdef ENABLE_FANTIES
				case 6:
					// Añade aquí tu código custom. Esto es un ejemplo:
					en_an_base_frame [enit] = FANTIES_BASE_CELL << 1;
					en_an_x [enit] = malotes [enoffsmasi].x = malotes [enoffsmasi].x1 << 6;
					en_an_y [enit] = malotes [enoffsmasi].y = malotes [enoffsmasi].y1 << 6;
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
					en_an_alive [enit] = 0;
					en_an_dead_row [enit] = 0;//DEATH_COUNT_EXPRESSION;
					break;
			#endif

			default:
				en_an_next_frame [enit] = sprite_18_a;
		}
	}
}

void enems_move (void) {
	tocado = p_gotten = ptgmx = ptgmy = 0;

	for (enit = 0; enit < 3; enit ++) {
		active = 0;
		enoffsmasi = enoffs + enit;
		gpen_x = malotes [enoffsmasi].x;
		gpen_y = malotes [enoffsmasi].y;		
		
		gpt = malotes [enoffsmasi].t;
		
		if (en_an_state [enit] == GENERAL_DYING) {
			-- en_an_count [enit];
			if (en_an_count [enit] == 0) {
				en_an_state [enit] = 0;
				en_an_next_frame [enit] = sprite_18_a;
				continue;
			}
		}

		#ifndef PLAYER_MOGGY_STYLE
			#if defined (BOUNDING_BOX_8_CENTERED) || defined (BOUNDING_BOX_8_BOTTOM)
				pregotten = (gpx + 12 >= gpen_x && gpx <= gpen_x + 12);
			#else
				pregotten = (gpx + 15 >= gpen_x && gpx <= gpen_x + 15);
			#endif
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

			#ifdef ENABLE_FANTIES
				case 6:	
					active = 1;
					
					cx2 = gpen_cx = en_an_x [enit] >> 6;
					cy2 = gpen_cy = en_an_y [enit] >> 6;

					#ifdef FANTIES_TYPE_HOMING
						rdd = distance ();
						switch (en_an_state [enit]) {
							case TYPE_6_IDLE:
								if (rdd <= FANTIES_SIGHT_DISTANCE)
									en_an_state [enit] = TYPE_6_PURSUING;
								break;
							case TYPE_6_PURSUING:
								if (rdd > FANTIES_SIGHT_DISTANCE) {
									en_an_state [enit] = TYPE_6_RETREATING;
								} else {
					#endif

									en_an_vx [enit] = limit (
										en_an_vx [enit] + addsign (p_x - en_an_x [enit], FANTIES_A),
										-FANTIES_MAX_V, FANTIES_MAX_V);
									en_an_vy [enit] = limit (
										en_an_vy [enit] + addsign (p_y - en_an_y [enit], FANTIES_A),
										-FANTIES_MAX_V, FANTIES_MAX_V);
										
									en_an_x [enit] = limit (en_an_x [enit] + en_an_vx [enit], 0, 224<<6);
									en_an_y [enit] = limit (en_an_y [enit] + en_an_vy [enit], 0, 144<<6);

					#ifdef FANTIES_TYPE_HOMING									
								}
								break;
							case TYPE_6_RETREATING:
								en_an_x [enit] += addsign (malotes [enoffsmasi].x - gpen_cx, 64);
								en_an_y [enit] += addsign (malotes [enoffsmasi].y - gpen_cy, 64);
								
								if (rdd <= FANTIES_SIGHT_DISTANCE)
									en_an_state [enit] = TYPE_6_PURSUING;
								break;						
						}
					#endif
					
					gpen_cx = en_an_x [enit] >> 6;
					gpen_cy = en_an_y [enit] >> 6;
					
					#ifdef FANTIES_TYPE_HOMING
						if (en_an_state [enit] == TYPE_6_RETREATING && 
							gpen_cx == malotes [enoffsmasi].x && 
							gpen_cy == malotes [enoffsmasi].y
							) 
							en_an_state [enit] = TYPE_6_IDLE;
						break;
					#endif
			#endif
			#ifdef ENABLE_PURSUERS
				case 7:
					switch (en_an_alive [enit]) {
						case 0:
							if (!en_an_dead_row [enit]) {
								malotes [enoffsmasi].x = malotes [enoffsmasi].x1;
								malotes [enoffsmasi].y = malotes [enoffsmasi].y1;
								en_an_alive [enit] = 1;
								en_an_rawv [enit] = 1 << (rand () % 5);
								if (en_an_rawv [enit] > 4) en_an_rawv [enit] = 2;
								en_an_dead_row [enit] = 11 + (rand () & 7);
								#if defined(PLAYER_STEPS_ON_ENEMIES) || defined(PLAYER_CAN_FIRE)							
									malotes [enoffsmasi].life = ENEMIES_LIFE_GAUGE;
								#endif							
							} else {
								en_an_dead_row [enit] --;
							}
							break;
						case 1:
							if (!en_an_dead_row [enit]) {
								#ifdef PURSUERS_BASE_CELL
									en_an_base_frame [enit] = PURSUERS_BASE_CELL << 1;
								#else							
									en_an_base_frame [enit] = (rand () & 3) << 1;
								#endif							
								en_an_alive [enit] = 2;
							} else {
								en_an_dead_row [enit] --;
								en_an_next_frame [enit] = sprite_17_a;
							}
							break;
						case 2:
							active = 1;
							if (p_estado == EST_NORMAL) {
								malotes [enoffsmasi].mx = (signed char) (addsign (((gpx >> 2) << 2) - gpen_x, en_an_rawv [enit]));
								malotes [enoffsmasi].x += malotes [enoffsmasi].mx;
								gpen_xx = malotes [enoffsmasi].x >> 4;
								gpen_yy = malotes [enoffsmasi].y >> 4;
								#ifdef WALLS_STOP_ENEMIES
									if (mons_col_sc_x ()) malotes [enoffsmasi].x = gpen_x;
								#endif
								malotes [enoffsmasi].my = (signed char) (addsign (((gpy >> 2) << 2) - gpen_y, en_an_rawv [enit]));
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
				if (en_an_state [enit] != GENERAL_DYING) en_an_next_frame [enit] = sprite_18_a;
			*/
		}
		
		if (active) {			
			// Animate
			en_an_count [enit] ++; 
			if (en_an_count [enit] == 4) {
				en_an_count [enit] = 0;
				en_an_frame [enit] = !en_an_frame [enit];
				en_an_next_frame [enit] = enem_frames [en_an_base_frame [enit] + en_an_frame [enit]];
			}
			
			// Collide with player
			
			#ifndef PLAYER_MOGGY_STYLE
				// Platforms
				if (gpt == 4) {
					if (pregotten && (p_gotten == 0)) {

						// Horizontal moving platforms
						if (malotes [enoffsmasi].mx) {
							if (gpy + 16 >= gpen_cy && gpy + 10 <= gpen_cy) {
								p_gotten = 1;
								ptgmx = malotes [enoffsmasi].mx << 6;
								gpy = (gpen_cy - 16); p_y = gpy << 6;
							}
						}

						// Vertical moving platforms
						if (
							(malotes [enoffsmasi].my < 0 && gpy + 18 >= gpen_cy && gpy + 10 <= gpen_cy) ||
							(malotes [enoffsmasi].my > 0 && gpy + 17 + malotes [enoffsmasi].my >= gpen_cy && gpy + 10 <= gpen_cy)
						) {
							p_gotten = 1;
							ptgmy = malotes [enoffsmasi].my << 6;
							gpy = (gpen_cy - 16); p_y = gpy << 6;						
						}

					}
				} else
			#endif			
			{
				cx2 = gpen_cx; cy2 = gpen_cy;
				if (!tocado && collide () && p_estado == EST_NORMAL) {
					#ifdef PLAYER_STEPS_ON_ENEMIES
					// Step over enemy		
						#ifdef PLAYER_CAN_STEP_ON_FLAG
							if (flags [PLAYER_CAN_STEP_ON_FLAG] != 0 && 
								gpy < gpen_cy - 2 && p_vy >= 0 && gpt >= PLAYER_MIN_KILLABLE)
						#else
							if (gpy < gpen_cy - 2 && p_vy >= 0 && gpt >= PLAYER_MIN_KILLABLE)
						#endif				
						{
							#ifdef MODE_128K
								wyz_play_sound (6);										
								en_an_state [enit] = GENERAL_DYING;
								en_an_count [enit] = 12;
								en_an_next_frame [enit] = sprite_17_a;
								malotes [enoffsmasi].t |= 16;			// Mark as dead
								p_killed ++;
								p_vy = -256;					
							#else
								en_an_next_frame [enit] = sprite_17_a;
								sp_MoveSprAbs (sp_moviles [enit], spritesClip, en_an_next_frame [enit] - en_an_current_frame [enit], VIEWPORT_Y + (gpen_cy >> 3), VIEWPORT_X + (gpen_cx >> 3), gpen_cx & 7, gpen_cy & 7);
								en_an_current_frame [enit] = en_an_next_frame [enit];
								sp_UpdateNow ();

								beeper_fx (5);
								en_an_next_frame [enit] = sprite_18_a;
								malotes [enoffsmasi].t |= 16;			// Mark as dead
							
								p_killed ++;
							#endif					
							#ifdef ACTIVATE_SCRIPTING					
								// Run this screen fire script or "entering any".
								script = f_scripts [n_pant];
								run_script ();
								script = e_scripts [MAP_W * MAP_H + 1];
								run_script ();
							#endif
						} else
					#endif
					{
						tocado = 1;
						#if defined(SLOW_DRAIN) && defined(PLAYER_BOUNCES)
							if (!lasttimehit || ((maincounter & 3) == 0)) {
								#ifdef MODE_128K
									p_killme = 7;
								#else							
									p_killme = 4;
								#endif
							}
						#else
						
							#ifdef MODE_128K
								p_killme = 7;
							#else							
								p_killme = 4;
							#endif
						#endif					
						
						#ifdef PLAYER_BOUNCES
							#ifdef ENABLE_FANTIES
								if (gpt == 6) {
									p_vx = en_an_vx [enit] + en_an_vx [enit];
									p_vy = en_an_vy [enit] + en_an_vy [enit];	
								} else
							#endif
							
							#ifndef PLAYER_MOGGY_STYLE	
								{
									p_vx = addsign (malotes [enoffsmasi].mx, PLAYER_MAX_VX);
									p_vy = addsign (malotes [enoffsmasi].my, PLAYER_MAX_VX);
								}
							#else
								{
									if (malotes [enoffsmasi].mx) {
										p_vx = addsign (gpx - gpen_cx, abs (malotes [enoffsmasi].mx) << 8);
									}
									if (malotes [enoffsmasi].my) {
										p_vy = addsign (gpy - gpen_cy, abs (malotes [enoffsmasi].my) << 8);
									}
								}
							#endif
						#endif
						#ifdef PLAYER_FLICKERS
							p_estado = EST_PARP;
							p_ct_estado = 50;
						#endif
					}
				}
			}
			
			#ifdef PLAYER_CAN_FIRE
				// Collide with bullets
				#ifdef FIRE_MIN_KILLABLE
					if (gpt >= FIRE_MIN_KILLABLE)
				#endif				
				{
					for (gpjt = 0; gpjt < MAX_BULLETS; gpjt ++) {
						if (bullets_estado [gpjt] == 1) {
							blx = bullets_x [gpjt] + 3; 
							bly = bullets_y [gpjt] + 3;
							if (blx >= gpen_cx && blx <= gpen_cx + 15 && bly >= gpen_cy && bly <= gpen_cy + 15) {
								#ifdef ENABLE_FANTIES
									if (gpt == 6) {
										en_an_vx [enit] += addsign (bullets_mx [gpjt], 128);
									}
								#endif
								malotes [enoffsmasi].x = gpen_x;
								malotes [enoffsmasi].y = gpen_y;
								en_an_next_frame [enit] = sprite_17_a;
								en_an_morido [enit] = 1;
								bullets_estado [gpjt] = 0;
								#ifndef PLAYER_MOGGY_STYLE							
									if (gpt != 4) malotes [enoffsmasi].life --;
								#else
									malotes [enoffsmasi].life --;
								#endif
								if (malotes [enoffsmasi].life == 0) {
									sp_MoveSprAbs (sp_moviles [enit], spritesClip, en_an_next_frame [enit] - en_an_current_frame [enit], VIEWPORT_Y + (gpen_cy >> 3), VIEWPORT_X + (gpen_cx >> 3), gpen_cx & 7, gpen_cy & 7);
									en_an_current_frame [enit] = en_an_next_frame [enit];
									sp_UpdateNow ();
									#ifdef MODE_128K
										#asm
											halt
										#endasm
										wyz_play_sound (6);
									#else															
										beeper_fx (5);
									#endif
									en_an_next_frame [enit] = sprite_18_a;
									if (gpt != 7) malotes [enoffsmasi].t |= 16;
									p_killed ++;

									#ifdef ENABLE_PURSUERS
										en_an_alive [enit] = 0;
										en_an_dead_row [enit] = DEATH_COUNT_EXPRESSION;
									#endif							
								}
							}
						}
					}

				}
			#endif
		} 
	}
	#if defined(SLOW_DRAIN) && defined(PLAYER_BOUNCES)
		lasttimehit = tocado;
	#endif
}
