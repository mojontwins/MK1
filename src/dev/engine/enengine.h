// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// enengine.h

#ifndef COMPRESSED_LEVELS
	#if defined(PLAYER_KILLS_ENEMIES) || defined (PLAYER_CAN_FIRE)
		void enems_init (void) {
			gpit = 0;
			while (gpit < MAP_W * MAP_H * 3) {
				malotes [gpit].t = malotes [gpit].t & 15;	
				#ifdef PLAYER_CAN_FIRE
					malotes [gpit].life = ENEMIES_LIFE_GAUGE;
				#endif
				gpit ++;
			}
		}
	#endif
#endif

void enems_load (void) {
	// Movemos y cambiamos a los enemigos según el tipo que tengan
	enoffs = n_pant * 3;
	
	for (gpit = 0; gpit < 3; ++ gpit) {
		en_an_frame [gpit] = 0;
		en_an_count [gpit] = 3;
		en_an_state [gpit] = 0;
		enoffsmasi = enoffs + gpit;

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
				en_an_base_frame [gpit] = (malotes [enoffsmasi].t - 1) << 1;
				break;

			#ifdef ENABLE_FANTIES
				case 6:
					// Añade aquí tu código custom. Esto es un ejemplo:
					en_an_base_frame [gpit] = FANTIES_BASE_CELL << 1;
					en_an_x [gpit] = malotes [enoffsmasi].x = malotes [enoffsmasi].x1 << 6;
					en_an_y [gpit] = malotes [enoffsmasi].y = malotes [enoffsmasi].y1 << 6;
					en_an_vx [gpit] = en_an_vy [gpit] = 0;

					#ifdef PLAYER_CAN_FIRE
						malotes [enoffsmasi].life = FANTIES_LIFE_GAUGE;	
					#endif
					#ifdef FANTIES_TYPE_HOMING
						en_an_state [gpit] = TYPE_6_IDLE;
					#endif
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
}

void enems_move (void) {
	tocado = p_gotten = ptgmx = ptgmy = 0;

	for (gpit = 0; gpit < 3; gpit ++) {
		active = 0;
		enoffsmasi = enoffs + gpit;
		gpen_x = malotes [enoffsmasi].x;
		gpen_y = malotes [enoffsmasi].y;		
		
		gpt = malotes [enoffsmasi].t;
		
		if (en_an_state [gpit] == GENERAL_DYING) {
			-- en_an_count [gpit];
			if (en_an_count [gpit] == 0) {
				en_an_state [gpit] = 0;
				en_an_next_frame [gpit] = sprite_18_a;
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
					
					cx2 = gpen_cx = en_an_x [gpit] >> 6;
					cy2 = gpen_cy = en_an_y [gpit] >> 6;

					#ifdef FANTIES_TYPE_HOMING
						rdd = distance ();
						switch (en_an_state [gpit]) {
							case TYPE_6_IDLE:
								if (rdd <= FANTIES_SIGHT_DISTANCE)
									en_an_state [gpit] = TYPE_6_PURSUING;
								break;
							case TYPE_6_PURSUING:
								if (rdd > FANTIES_SIGHT_DISTANCE) {
									en_an_state [gpit] = TYPE_6_RETREATING;
								} else {
					#endif

									en_an_vx [gpit] = limit (
										en_an_vx [gpit] + addsign (p_x - en_an_x [gpit], FANTIES_A),
										-FANTIES_MAX_V, FANTIES_MAX_V);
									en_an_vy [gpit] = limit (
										en_an_vy [gpit] + addsign (p_y - en_an_y [gpit], FANTIES_A),
										-FANTIES_MAX_V, FANTIES_MAX_V);
										
									en_an_x [gpit] = limit (en_an_x [gpit] + en_an_vx [gpit], 0, 224<<6);
									en_an_y [gpit] = limit (en_an_y [gpit] + en_an_vy [gpit], 0, 144<<6);

					#ifdef FANTIES_TYPE_HOMING									
								}
								break;
							case TYPE_6_RETREATING:
								en_an_x [gpit] += addsign (malotes [enoffsmasi].x - gpen_cx, 64);
								en_an_y [gpit] += addsign (malotes [enoffsmasi].y - gpen_cy, 64);
								
								if (rdd <= FANTIES_SIGHT_DISTANCE)
									en_an_state [gpit] = TYPE_6_PURSUING;
								break;						
						}
					#endif
					
					gpen_cx = en_an_x [gpit] >> 6;
					gpen_cy = en_an_y [gpit] >> 6;
					
					#ifdef FANTIES_TYPE_HOMING
						if (en_an_state [gpit] == TYPE_6_RETREATING && 
							gpen_cx == malotes [enoffsmasi].x && 
							gpen_cy == malotes [enoffsmasi].y
							) 
							en_an_state [gpit] = TYPE_6_IDLE;
						break;
					#endif
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
							if (p_estado == EST_NORMAL) {
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
					#ifdef PLAYER_KILLS_ENEMIES
					// Step over enemy		
						#ifdef PLAYER_CAN_KILL_FLAG
							if (flags [PLAYER_CAN_KILL_FLAG] != 0 && 
								gpy < gpen_cy - 2 && p_vy >= 0 && gpt >= PLAYER_MIN_KILLABLE)
						#else
							if (gpy < gpen_cy - 2 && p_vy >= 0 && gpt >= PLAYER_MIN_KILLABLE)
						#endif				
						{
							#ifdef MODE_128K
								wyz_play_sound (6);										
								en_an_state [gpit] = GENERAL_DYING;
								en_an_count [gpit] = 12;
								en_an_next_frame [gpit] = sprite_17_a;
								malotes [enoffsmasi].t |= 16;			// Mark as dead
								p_killed ++;
								p_vy = -256;					
							#else
								en_an_next_frame [gpit] = sprite_17_a;
								sp_MoveSprAbs (sp_moviles [gpit], spritesClip, en_an_next_frame [gpit] - en_an_current_frame [gpit], VIEWPORT_Y + (gpen_cy >> 3), VIEWPORT_X + (gpen_cx >> 3), gpen_cx & 7, gpen_cy & 7);
								en_an_current_frame [gpit] = en_an_next_frame [gpit];
								sp_UpdateNow ();

								beeper_fx (5);
								en_an_next_frame [gpit] = sprite_18_a;
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
									p_vx = en_an_vx [gpit] + en_an_vx [gpit];
									p_vy = en_an_vy [gpit] + en_an_vy [gpit];	
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
										en_an_vx [gpit] += addsign (bullets_mx [gpjt], 128);
									}
								#endif
								malotes [enoffsmasi].x = gpen_x;
								malotes [enoffsmasi].y = gpen_y;
								en_an_next_frame [gpit] = sprite_17_a;
								en_an_morido [gpit] = 1;
								bullets_estado [gpjt] = 0;
								#ifndef PLAYER_MOGGY_STYLE							
									if (gpt != 4) malotes [enoffsmasi].life --;
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
										beeper_fx (5);
									#endif
									en_an_next_frame [gpit] = sprite_18_a;
									if (gpt != 7) malotes [enoffsmasi].t |= 16;
									p_killed ++;

									#ifdef ENABLE_PURSUERS
										en_an_alive [gpit] = 0;
										en_an_dead_row [gpit] = DEATH_COUNT_EXPRESSION;
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
