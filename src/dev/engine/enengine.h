// MTE MK1 (la Churrera) v3.99.99 (final)
// Copyleft 2010-2017 by the Mojon Twins

// enengine.h

#ifndef COMPRESSED_LEVELS
	#if defined(PLAYER_KILLS_ENEMIES) || defined (PLAYER_CAN_FIRE)
		void enems_init (void) {
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

void enems_move (void) {
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
					cx2 = gpen_cx = en_an_x [gpit] >> 6;
					cy2 = gpen_cy = en_an_y [gpit] >> 6;
					rdd = distance ();
					switch (en_an_state [gpit]) {
						case TYPE_6_IDLE:
							if (rdd <= SIGHT_DISTANCE)
								en_an_state [gpit] = TYPE_6_PURSUING;
							break;
						case TYPE_6_PURSUING:
							if (rdd > SIGHT_DISTANCE) {
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
							
							if (rdd <= SIGHT_DISTANCE)
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
			} else
#endif			
			{
				cx2 = gpen_cx; cy2 = gpen_cy;
				if (!tocado && collide () && pestado == EST_NORMAL) {
					#ifdef PLAYER_KILLS_ENEMIES
					// Step over enemy		
						#ifdef PLAYER_CAN_KILL_FLAG
							if (flags [PLAYER_CAN_KILL_FLAG] != 0 && 
								gpy < gpen_cy - 2 && pvy >= 0 && malotes [enoffsmasi].t >= PLAYER_MIN_KILLABLE)
						#else
							if (gpy < gpen_cy - 2 && pvy >= 0 && malotes [enoffsmasi].t >= PLAYER_MIN_KILLABLE)
						#endif				
						{
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

								beeper_fx (5);
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
						} else
					#endif
					{
						tocado = 1;
						#if defined(SLOW_DRAIN) && defined(PLAYER_BOUNCES)
							if (!lasttimehit || ((maincounter & 3) == 0)) {
								#ifdef MODE_128K
									pkillme = 7;
								#else							
									pkillme = 4;
								#endif
							}
						#else
						
							#ifdef MODE_128K
								pkillme = 7;
							#else							
								pkillme = 4;
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
			}
			
			#ifdef PLAYER_CAN_FIRE
				// Collide with bullets
				#ifdef FIRE_MIN_KILLABLE
					if (malotes [enoffsmasi].t >= FIRE_MIN_KILLABLE)
				#endif				
				{
					for (gpjt = 0; gpjt < MAX_BULLETS; gpjt ++) {
						if (bullets_estado [gpjt] == 1) {
							blx = bullets_x [gpjt] + 3; 
							bly = bullets_y [gpjt] + 3;
							if (blx >= gpen_cx && blx <= gpen_cx + 15 && bly >= gpen_cy && bly <= gpen_cy + 15) {
								#ifdef RANDOM_RESPAWN		
									if (en_an_fanty_activo [gpit]) {
										en_an_vx [gpit] += addsign (bullets_mx [gpjt], 128);
									}
								#endif
								#ifdef ENABLE_CUSTOM_TYPE_6
									if (malotes [enoffsmasi].t == 6) {
										en_an_vx [gpit] += addsign (bullets_mx [gpjt], 128);
									}
								#endif
								malotes [enoffsmasi].x = gpen_x;
								malotes [enoffsmasi].y = gpen_y;
								en_an_next_frame [gpit] = sprite_17_a;
								en_an_morido [gpit] = 1;
								bullets_estado [gpjt] = 0;
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
										beeper_fx (5);
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

				}
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
