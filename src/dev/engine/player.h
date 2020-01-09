// MTE MK1 (la Churrera) v3.99.99 (final)
// Copyleft 2010-2017 by the Mojon Twins

// player.h

void player_init (void) {
	// Inicializa player con los valores iniciales
	// (de ahí lo de inicializar).
		
	#ifndef COMPRESSED_LEVELS
		gpx = PLAYER_INI_X << 4; px = gpx << 6;
		gpy = PLAYER_INI_Y << 4; py = gpy << 6;
	#endif	
	pvy = 0;
	pvx = 0;
	pcont_salto = 1;
	psaltando = 0;
	pframe = 0;
	psubframe = 0;
	#ifdef PLAYER_MOGGY_STYLE
		pfacing = FACING_DOWN;
		pfacing_v = pfacing_h = 0xff;
	#else
		pfacing = 1;
	#endif	
	pestado = 	EST_NORMAL;
	pct_estado = 0;
	#if !defined(COMPRESSED_LEVELS) || defined(REFILL_ME)	
		plife = 		PLAYER_LIFE;
	#endif
	pobjs =	0;
	pkeys = 0;
	pkilled = 0;
	pdisparando = 0;
	#ifdef MAX_AMMO
		#ifdef INITIAL_AMMO
			pammo = INITIAL_AMMO
		#else
			pammo = MAX_AMMO;
		#endif
	#endif	
	pant_final = SCR_FIN;
	#ifdef TIMER_ENABLE
		ctimer.count = 0;
		ctimer.zero = 0;
		#ifdef TIMER_LAPSE
			ctimer.frames = TIMER_LAPSE;
		#endif
		#ifdef TIMER_INITIAL
			ctimer.t = TIMER_INITIAL;
		#endif
		#ifdef TIMER_START
			ctimer.on = 1;
		#else
			ctimer.on = 0;
		#endif
	#endif
}

unsigned char player_move (void) {
	wall_v = wall_h = 0;
		
	/* Por partes. Primero el movimiento vertical. La ecuación de movimien-
	   to viene a ser, en cada ciclo:

	   1.- vy = vy + g
	   2.- y = y + vy

	   O sea la velocidad afectada por la gravedad. 
	   Para no colarnos con los nmeros, ponemos limitadores:
	*/

	#ifndef PLAYER_MOGGY_STYLE
		// Si el tipo de movimiento no es MOGGY_STYLE, entonces nos afecta la gravedad.
		if (pvy < PLAYER_MAX_VY_CAYENDO)
			pvy += PLAYER_G;
		else
			pvy = PLAYER_MAX_VY_CAYENDO;
		
		#ifdef PLAYER_CUMULATIVE_JUMP
			if (!psaltando)
		#endif
		
		if (pgotten) pvy = 0;		
	#else
		// Si lo es, entonces el movimiento vertical se comporta exactamente igual que 
		// el horizontal.
		if ( ! ((pad0 & sp_UP) == 0 || (pad0 & sp_DOWN) == 0)) {
			pfacing_v = 0xff;
			if (pvy > 0) {
				pvy -= PLAYER_RX;
				if (pvy < 0)
					pvy = 0;
			} else if (pvy < 0) {
				pvy += PLAYER_RX;
				if (pvy > 0)
					pvy = 0;
			}
		}

		if ((pad0 & sp_UP) == 0) {
			pfacing_v = FACING_UP;
			if (pvy > -PLAYER_MAX_VX) {
				pvy -= PLAYER_AX;
			}
		}

		if ((pad0 & sp_DOWN) == 0) {
			pfacing_v = FACING_DOWN;
			if (pvy < PLAYER_MAX_VX) {
				pvy += PLAYER_AX;
			}
		}
	#endif

	#ifdef PLAYER_HAS_JETPAC
		if ((pad0 & sp_UP) == 0) {
			pvy -= PLAYER_INCR_JETPAC;
			if (pvy < -PLAYER_MAX_VY_JETPAC) pvy = -PLAYER_MAX_VY_JETPAC;
		}
	#endif

	py += pvy;
	
	// Safe
		
	if (py < 0)
		py = 0;
		
	if (py > 9216)
		py = 9216;

	
	/* El problema es que no es tan fácil... Hay que ver si no nos chocamos.
	   Si esto pasa, hay que "recular" hasta el borde del obstáculo.

	   Por eso miramos el signo de vy, para que los cálculos sean más sencillos.
	   De paso vamos a precalcular un par de cosas para que esto vaya más rápido.
	*/

	gpx = px >> 6;				// dividimos entre 64 para pixels, y luego entre 16 para tiles.
	gpy = py >> 6;
	gpxx = gpx >> 4;
	gpyy = gpy >> 4;
	
	// Ya	
	possee = 0;
	hit_v = 0;
	#ifdef BOUNDING_BOX_8_BOTTOM	
		if (pvy < 0) { 			// estamos ascendiendo
			if ((gpy & 15) < 8) {
				if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) & 8) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) & 8)) {
					#ifdef PLAYER_BOUNCE_WITH_WALLS
						pvy = -(pvy / 2);
					#else				
						pvy = 0;
					#endif
					py = ((gpyy + 1) << 10) - 512;
					wall_v = WTOP;
				} else if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) & 1) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) & 1)) {
					hit_v = 1; 
				}
			}
		} else if (pvy > 0 && (gpy & 15) < 8) { 	// estamos descendiendo
			if (py < 9216) {
				if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) & 12) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) & 12)) {
					#if defined(PLAYER_BOUNCE_WITH_WALLS) && defined(PLAYER_MOGGY_STYLE)
						pvy = -(pvy / 2);
					#else				
						#ifdef PLAYER_CUMULATIVE_JUMP
							if (!psaltando)
						#endif				
						pvy = 0;
					#endif
					py = gpyy << 10;
					wall_v = WBOTTOM;
					possee = 1;
				} else if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) & 1) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) & 1)) {
					hit_v = 1;
				}
			}
		}
	#else
		#ifdef BOUNDING_BOX_8_CENTERED
			if (pvy < 0) { 			
				if ((gpy & 15) < 12) {
					if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) & 8) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) & 8)) {
						#ifdef PLAYER_BOUNCE_WITH_WALLS
							pvy = -(pvy / 2);
						#else				
							pvy = 0;
						#endif
						py = ((gpyy + 1) << 10) - 256;
						wall_v = WTOP;
					} else if ( ((gpx & 15) < 12 && attr (gpxx, gpyy) & 1) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy) & 1)) {
						hit_v = 1; 
					}
				}
			} else if (pvy > 0 && (gpy & 15) >= 4) { 	
				if (py < 9216) {
					if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) & 12) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) & 12)) {
						#if defined(PLAYER_BOUNCE_WITH_WALLS) && defined(PLAYER_MOGGY_STYLE)
							pvy = -(pvy / 2);
						#else
							#ifdef PLAYER_CUMULATIVE_JUMP
								if (!psaltando)
							#endif
							pvy = 0;
						#endif
						py = (gpyy << 10) + 256;
						wall_v = WBOTTOM;
						possee = 1;
					} else if ( ((gpx & 15) < 12 && attr (gpxx, gpyy + 1) & 1) || ((gpx & 15) > 4 && attr (gpxx + 1, gpyy + 1) & 1)) {
						hit_v = 1; 
					}
				}
			}
		#else
			if (pvy < 0) { 		
				if (attr (gpxx, gpyy) & 8 || ((gpx & 15) && attr (gpxx + 1, gpyy) & 8)) {
					#ifdef PLAYER_BOUNCE_WITH_WALLS
						pvy = -(pvy / 2);
					#else				
						pvy = 0;
					#endif
					py = (gpyy + 1) << 10;
					wall_v = WTOP;	
				} else if (attr (gpxx, gpyy) & 1 || ((gpx & 15) && attr (gpxx + 1, gpyy) & 1)) {
					hit_v = 1; 
				}
			} else if (pvy > 0 && (gpy & 15) < 8) {
				if (py < 9216) {
					if (attr (gpxx, gpyy + 1) & 12 || ((gpx & 15) && attr (gpxx + 1, gpyy + 1) & 12))
					{
						#if defined(PLAYER_BOUNCE_WITH_WALLS) && defined(PLAYER_MOGGY_STYLE)
							pvy = -(pvy / 2);
						#else				
							#ifdef PLAYER_CUMULATIVE_JUMP
								if (!psaltando)
							#endif
							pvy = 0;
						#endif
						py = gpyy << 10;
						possee = 1;
						wall_v = WBOTTOM;
					} else if (attr (gpxx, gpyy + 1) & 1 || ((gpx & 15) && attr (gpxx + 1, gpyy + 1) & 1)) {
						hit_v = 1; 
					}
				}
			}
		#endif
	#endif
	
	/* Salto: El salto se reduce a dar un valor negativo a vy. Esta es la forma más
	   sencilla. Sin embargo, para más control, usamos el tipo de salto "mario bros".
	   Para ello, en cada pulsación dejaremos decrementar vy hasta un mínimo, y de-
	   tectando que no se vuelva a pulsar cuando estemos en el aire. Juego de banderas ;)
	*/

	#ifdef PLAYER_HAS_JUMP

		#if defined (PLAYER_CAN_FIRE) && !defined (USE_TWO_BUTTONS)
	
			#ifdef PLAYER_CUMULATIVE_JUMP
				if (((pad0 & sp_UP) == 0) && (possee || pgotten || hit_v)) {
					pvy = -pvy - PLAYER_VY_INICIAL_SALTO;
					if (pvy < -PLAYER_MAX_VY_SALTANDO) pvy = -PLAYER_MAX_VY_SALTANDO;
			#else		
				if (((pad0 & sp_UP) == 0) && psaltando == 0 && (possee || pgotten || hit_v)) {
			#endif
				psaltando = 1;
				pcont_salto = 0;
				#ifdef MODE_128K
					wyz_play_sound (2);
				#else
					beeper_fx (3);
				#endif
			}

			#ifndef PLAYER_CUMULATIVE_JUMP	
				if ( ((pad0 & sp_UP) == 0) && psaltando ) {
					pvy -= (PLAYER_VY_INICIAL_SALTO + PLAYER_INCR_SALTO - (pcont_salto>>1));
					if (pvy < -PLAYER_MAX_VY_SALTANDO) pvy = -PLAYER_MAX_VY_SALTANDO;
					pcont_salto ++;
					if (pcont_salto == 8)
						psaltando = 0;
				}
			#endif
			
			if ((pad0 & sp_UP))
				psaltando = 0;
		
		#elif defined (PLAYER_CAN_FIRE) && defined (USE_TWO_BUTTONS)

			#ifdef PLAYER_CUMULATIVE_JUMP
				if (sp_KeyPressed (key_jump) && (possee || pgotten || hit_v)) {
					pvy = -pvy - PLAYER_VY_INICIAL_SALTO;
					if (pvy < -PLAYER_MAX_VY_SALTANDO) pvy = -PLAYER_MAX_VY_SALTANDO;
			#else		
				if (sp_KeyPressed (key_jump) && psaltando == 0 && (possee || pgotten || hit_v)) {
			#endif
				psaltando = 1;
				pcont_salto = 0;
				#ifdef MODE_128K
					wyz_play_sound (2);
				#else				
					beeper_fx (3);
				#endif
			}

			#ifndef PLAYER_CUMULATIVE_JUMP	
				if (sp_KeyPressed (key_jump) && psaltando ) {
					pvy -= (PLAYER_VY_INICIAL_SALTO + PLAYER_INCR_SALTO - (pcont_salto>>1));
					if (pvy < -PLAYER_MAX_VY_SALTANDO) pvy = -PLAYER_MAX_VY_SALTANDO;
					pcont_salto ++;
					if (pcont_salto == 8)
						psaltando = 0;
				}
			#endif
	
			if (!sp_KeyPressed (key_jump))
				psaltando = 0;

		#else

			#ifdef PLAYER_CUMULATIVE_JUMP
				if (((pad0 & sp_FIRE) == 0) && (possee || pgotten || hit_v)) {
					pvy = -pvy - PLAYER_VY_INICIAL_SALTO;
					if (pvy < -PLAYER_MAX_VY_SALTANDO) pvy = -PLAYER_MAX_VY_SALTANDO;
			#else
				if (((pad0 & sp_FIRE) == 0) && psaltando == 0 && (possee || pgotten || hit_v)) {
			#endif
				psaltando = 1;
				pcont_salto = 0;
				#ifdef MODE_128K
					wyz_play_sound (2);
				#else				
					beeper_fx (3);
				#endif
			}

			#ifndef PLAYER_CUMULATIVE_JUMP	
				if ( ((pad0 & sp_FIRE) == 0) && psaltando ) {
					pvy -= (PLAYER_VY_INICIAL_SALTO + PLAYER_INCR_SALTO - (pcont_salto>>1));
					if (pvy < -PLAYER_MAX_VY_SALTANDO) pvy = -PLAYER_MAX_VY_SALTANDO;
					pcont_salto ++;
					if (pcont_salto == 8)
						psaltando = 0;
				}
			#endif

			if ((pad0 & sp_FIRE))
				psaltando = 0;
		#endif
	#endif

	// Bootee engine
	#ifdef PLAYER_BOOTEE
		if ( psaltando == 0 && (possee || pgotten || hit_v) ) {
			psaltando = 1;
			pcont_salto = 0;
			#ifdef MODE_128K
					wyz_play_sound (2);
			#else				
					beeper_fx (3);
			#endif
		}
		
		if (psaltando ) {
			pvy -= (PLAYER_VY_INICIAL_SALTO + PLAYER_INCR_SALTO - (pcont_salto>>1));
			if (pvy < -PLAYER_MAX_VY_SALTANDO) pvy = -PLAYER_MAX_VY_SALTANDO;
			pcont_salto ++;
			if (pcont_salto == 8)
				psaltando = 0;
		}
	#endif	

	// ------ ok con el movimiento vertical.

	/* Movimiento horizontal:

	   Mientras se pulse una tecla de dirección, 
	   
	   x = x + vx
	   vx = vx + ax

	   Si no se pulsa nada:

	   x = x + vx
	   vx = vx - rx
	*/

	if ( ! ((pad0 & sp_LEFT) == 0 || (pad0 & sp_RIGHT) == 0)) {
		#ifdef PLAYER_MOGGY_STYLE		
			pfacing_h = 0xff;
		#endif
		if (pvx > 0) {
			pvx -= PLAYER_RX;
			if (pvx < 0)
				pvx = 0;
		} else if (pvx < 0) {
			pvx += PLAYER_RX;
			if (pvx > 0)
				pvx = 0;
		}
	}

	if ((pad0 & sp_LEFT) == 0) {
		#ifdef PLAYER_MOGGY_STYLE
			pfacing_h = FACING_LEFT;
		#endif
		if (pvx > -PLAYER_MAX_VX) {
			#ifndef PLAYER_MOGGY_STYLE			
				pfacing = 0;
			#endif
			pvx -= PLAYER_AX;
		}
	}

	if ((pad0 & sp_RIGHT) == 0) {
		#ifdef PLAYER_MOGGY_STYLE	
			pfacing_h = FACING_RIGHT;
		#endif
		if (pvx < PLAYER_MAX_VX) {
			pvx += PLAYER_AX;
			#ifndef PLAYER_MOGGY_STYLE						
				pfacing = 1;
			#endif
		}
	}

	px = px + pvx;
	
	// Safe
	
	if (px < 0)
		px = 0;
		
	if (px > 14336)
		px = 14336;
		
	/* Ahora, como antes, vemos si nos chocamos con algo, y en ese caso
	   paramos y reculamos */

	gpy = py >> 6;
	gpx = px >> 6;
	gpyy = gpy >> 4;
	gpxx = gpx >> 4;
	hit_h = 0;
	#ifdef BOUNDING_BOX_8_BOTTOM	
		if (pvx < 0 && (gpx & 15) < 12) {
			if ( ((gpy & 15) < 8 && attr (gpxx, gpyy) & 8) || ((gpy & 15) && attr (gpxx, gpyy + 1) & 8)) {
				#ifdef PLAYER_BOUNCE_WITH_WALLS
					pvx = -(pvx / 2);
				#else				
					pvx = 0;
				#endif
				px = ((gpxx + 1) << 10) - 256;
				wall_h = WLEFT;
			} else if ( ((gpy & 15) < 8 && attr (gpxx, gpyy) & 1) || ((gpy & 15) && attr (gpxx, gpyy + 1) & 1)) {
				hit_h = 1; 
			}
		} else if ((gpx & 15) >= 4) {
			if ( ((gpy & 15) < 8 && attr (gpxx + 1, gpyy) & 8) || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) & 8)) {
				#ifdef PLAYER_BOUNCE_WITH_WALLS
					pvx = -(pvx / 2);
				#else				
					pvx = 0;
				#endif
				px = (gpxx << 10) + 256;
				wall_h = WRIGHT;
			} else if ( ((gpy & 15) < 8 && attr (gpxx + 1, gpyy) & 1) || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) & 1)) {
				hit_h = 1; 
			}
		}
	#else
		#ifdef BOUNDING_BOX_8_CENTERED
			if (pvx < 0 && (gpx & 15) < 12) {
				if ( ((gpy & 15) < 12 && attr (gpxx, gpyy) & 8) || ((gpy & 15) > 4 && attr (gpxx, gpyy + 1) & 8)) {
					#ifdef PLAYER_BOUNCE_WITH_WALLS
						pvx = -(pvx / 2);
					#else				
						pvx = 0;
					#endif
					px = ((gpxx + 1) << 10) - 256;
					wall_h = WLEFT;
				} else if ( ((gpy & 15) < 8 && attr (gpxx, gpyy) & 1) || ((gpy & 15) && attr (gpxx, gpyy + 1) & 1)) {
					hit_h = 1; 
				}
			} else if ((gpx & 15) >= 4) {
				if ( ((gpy & 15) < 12 && attr (gpxx + 1, gpyy) & 8) || ((gpy & 15) > 4 && attr (gpxx + 1, gpyy + 1) & 8)) {
					#ifdef PLAYER_BOUNCE_WITH_WALLS
						pvx = -(pvx / 2);
					#else				
						pvx = 0;
					#endif
					px = (gpxx << 10) + 256;
					wall_h = WRIGHT;
				} else if ( ((gpy & 15) < 8 && attr (gpxx + 1, gpyy) & 1) || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) & 1)) {
					hit_h = 1; 
				}
			}
		#else
			if (pvx < 0) {
				if (attr (gpxx, gpyy) & 8 || ((gpy & 15) && attr (gpxx, gpyy + 1) & 8)) {
					#ifdef PLAYER_BOUNCE_WITH_WALLS
						pvx = -(pvx / 2);
					#else				
						pvx = 0;
					#endif
					px = (gpxx + 1) << 10;
					wall_h = WLEFT;
				} else if (attr (gpxx, gpyy) & 1 || ((gpy & 15) && attr (gpxx, gpyy + 1) & 1)) {
					hit_h = 1; 
				}
			} else {
				if (attr (gpxx + 1, gpyy) & 8 || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) & 8)) {
					#ifdef PLAYER_BOUNCE_WITH_WALLS
						pvx = -(pvx / 2);
					#else				
						pvx = 0;
					#endif
					px = gpxx << 10;
					wall_h = WRIGHT;
				} else if (attr (gpxx + 1, gpyy) & 1 || ((gpy & 15) && attr (gpxx + 1, gpyy + 1) & 1)) {
					hit_h = 1; 
				}
			}
		#endif
	#endif

	#ifdef PLAYER_MOGGY_STYLE
		// Priority to decide facing
		#ifdef TOP_OVER_SIDE
			if (pfacing_v != 0xff) {
				pfacing = pfacing_v;
			} else if (pfacing_h != 0xff) {
				pfacing = pfacing_h;
			}
		#else
			if (pfacing_h != 0xff) {
				pfacing = pfacing_h;
			} else if (pfacing_v != 0xff) {
				pfacing = pfacing_v;
			}
		#endif	
	#endif

	#ifdef FIRE_TO_PUSH	
	pushed_any = 0;
	#endif

	#if defined(PLAYER_PUSH_BOXES) || !defined(DEACTIVATE_KEYS)
		// Empujar cajas (tile #14)
		gpx = px >> 6;
		gpy = py >> 6;
		gpxx = gpx >> 4;
		gpyy = gpy >> 4;
		
		// En modo plataformas, no se puede empujar verticalmente
		#ifdef PLAYER_MOGGY_STYLE
			
			if (wall_v == WTOP) {
				#if defined(BOUNDING_BOX_8_BOTTOM) || defined (BOUNDING_BOX_8_CENTERED)
					if (attr (gpxx, gpyy) == 10) {				
						cx1 = gpxx; cy1 = gpyy; cx2 = gpxx; cy2 = gpyy - 1; process_tile ();
					}
				#else
					if (attr (gpxx, gpyy - 1) == 10) {				
						cx1 = gpxx; cy1 = gpyy - 1; cx2 = gpxx; cy2 = gpyy - 2; process_tile ();
					}
				#endif
				
				if ((gpx & 15)) {
					#if defined(BOUNDING_BOX_8_BOTTOM) || defined (BOUNDING_BOX_8_CENTERED)
						if (attr (gpxx + 1, gpyy) == 10) {
							cx1 = gpxx + 1; cy1 = gpyy; cx2 = gpxx + 1; cy2 = gpyy - 1; process_tile ();
						}
					#else
						if (qtile (gpxx + 1, gpyy - 1) == 10) {
							cx1 = gpxx + 1; cy1 = gpyy - 1; cx2 = gpxx + 1; cy2 = gpyy - 2; process_tile ();
						}
					#endif
				}
			} else if (wall_v == WBOTTOM) {
				if (attr (gpxx, gpyy + 1) == 10) {
					cx1 = gpxx; cy1 = gpyy + 1; cx2 = gpxx; cx2 = gpyy + 2; process_tile ();
				}
				if ((gpx & 15)) {
					if (attr (gpxx + 1, gpyy + 1) == 10) {
						cx1 = gpxx + 1; cy1 = gpyy + 1; cx2 = gpxx + 1; cy2 = gpyy + 2; process_tile ();
					}	
				}
			}
		#endif

		// Horizontalmente
		
		if (wall_h == WRIGHT) {
			if (attr (gpxx + 1, gpyy) == 10) {
				cx1 = gpxx + 1; cy1 = gpyy; cx2 = gpxx + 2; cy2 = gpyy; process_tile ();
			}
			if ((gpy & 15)) {
				if (attr (gpxx + 1, gpyy + 1) == 10) {
					cx1 = gpxx + 1; cy1 = gpyy + 1; cx2 = gpxx + 2; cy2 = gpyy + 1; process_tile ();
				}
			}
		} else if (wall_h == WLEFT) {
			#if defined(BOUNDING_BOX_8_BOTTOM) || defined(BOUNDING_BOX_8_CENTERED)
				if (attr (gpxx, gpyy) == 10) {
					cx1 = gpxx; cy1 = gpyy; cx2 = gpxx - 1; cy2 = gpyy; process_tile ();
				}
			#else
				if (attr (gpxx - 1, gpyy) == 10) {
					cx1 = gpxx - 1; cy1 = gpyy; cx2 = gpxx - 2; cy2 = gpyy; process_tile ();
				}
			#endif
			
			if ((gpy & 15)) {
				#if defined(BOUNDING_BOX_8_BOTTOM) || defined(BOUNDING_BOX_8_CENTERED)
					if (attr (gpxx, gpyy + 1) == 10) {
						cx1 = gpxx; cy1 = gpyy + 1; cx2 = gpxx - 1; cy2 = gpyy + 1; process_tile ();
					}
				#else
					if (attr (gpxx - 1, gpyy + 1) == 10) {
						cx1 = gpxx - 1; cy1 = gpyy + 1; cx2 = gpxx - 2; cy2 = gpyy + 1; process_tile ();
					}
				#endif
			}
		}						
	#endif

	#ifdef PLAYER_CAN_FIRE
		// Disparos
		#ifdef USE_TWO_BUTTONS
			#ifdef FIRE_TO_PUSH	
				if (((pad0 & sp_FIRE) == 0 || sp_KeyPressed (key_fire)) && pdisparando == 0 && !pushed_any) {
			#else
				if (((pad0 & sp_FIRE) == 0 || sp_KeyPressed (key_fire)) && pdisparando == 0) {
			#endif
		#else
			#ifdef FIRE_TO_PUSH	
				if ((pad0 & sp_FIRE) == 0 && pdisparando == 0 && !pushed_any) {
			#else
				if ((pad0 & sp_FIRE) == 0 && pdisparando == 0) {
			#endif
		#endif
			pdisparando = 1;
			bullets_fire ();
		}
		
		if ((pad0 & sp_FIRE)) 
			pdisparando = 0;

	#endif

	#ifndef DEACTIVATE_EVIL_TILE
		// Tiles que te matan. 
		// hit_v tiene preferencia sobre hit_h
		hit = 0;
		if (hit_v) {
			hit = 1;
			#ifdef FULL_BOUNCE
				pvy = addsign (-pvy, PLAYER_MAX_VX);
			#else
				pvy = -pvy;
			#endif
		} else if (hit_h) {
			hit = 1;
			#ifdef FULL_BOUNCE
				pvx = addsign (-pvx, PLAYER_MAX_VX);
			#else
				pvx = -pvx;
			#endif
		}
		if (hit) {
			#ifdef PLAYER_FLICKERS
				if (pestado == EST_NORMAL) {
					pestado = EST_PARP;
					pct_estado = 50;
			#endif		
			{
				#ifdef MODE_128K
					pkillme = 8;
				#else		
					pkillme = 4;
				#endif
			}
		}
	#endif

	// Select animation frame 
	
	#ifndef PLAYER_MOGGY_STYLE
		#ifdef PLAYER_BOOTEE
			gpit = pfacing << 2;
			if (pvy == 0) {
				pnext_frame = player_frames [gpit];
			} else if (pvy < 0) {
				pnext_frame = player_frames [gpit + 1];
			} else {
				pnext_frame = player_frames [gpit + 2];
			}
		#else	
			if (!possee && !pgotten) {
				pnext_frame = player_frames [8 + pfacing];
			} else {
				gpit = pfacing << 2;
				if (pvx == 0) {
					#ifdef PLAYER_ALTERNATE_ANIMATION
						pnext_frame = player_frames [gpit];
					#else
						pnext_frame = player_frames [gpit + 1];
					#endif
				} else {
					psubframe ++;
					if (psubframe == 4) {
						psubframe = 0;
						#ifdef PLAYER_ALTERNATE_ANIMATION
							pframe ++; if (pframe == 3) pframe = 0;
						#else
							pframe = (pframe + 1) & 3;
						#endif
						#ifdef PLAYER_STEP_SOUND
							step ();
						#endif
					}
					pnext_frame = player_frames [gpit + pframe];
				}
			}
		#endif
	#else
		
		if (pvx || pvy) {
			psubframe ++;
			if (psubframe == 4) {
				psubframe = 0;
				pframe = !pframe;
				#ifdef PLAYER_STEP_SOUND			
					step (); 
				#endif
			}
		}
		
		pnext_frame = player_frames [pfacing + pframe];
	#endif
}

void player_kill (unsigned char sound) {
	pkillme = 0;

	if (plife == 0) return;
	-- plife;

	#ifdef MODO_128K
		wyz_play_sound (sound);
	#else
		beeper_fx (sound);
	#endif

	#ifdef CP_RESET_WHEN_DYING
		#ifdef CP_RESET_ALSO_FLAGS
			mem_load ();
		#else
			n_pant = sg_pool [MAX_FLAGS];
			px = sg_pool [MAX_FLAGS + 1] << 10;
			py = sg_pool [MAX_FLAGS + 2] << 10;
		#endif	
		o_pant = 0xff; // Reload
	#endif
}

