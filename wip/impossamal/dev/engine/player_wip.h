// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

// player.h

void player_init (void) {
	// Inicializa player con los valores iniciales
	// (de ahí lo de inicializar).
		
	#ifndef COMPRESSED_LEVELS
		gpx = PLAYER_INI_X << 4; p_x = gpx << 6;
		gpy = PLAYER_INI_Y << 4; p_y = gpy << 6;
	#endif	
	p_vy = 0;
	p_vx = 0;
	p_cont_salto = 1;
	p_saltando = 0;
	p_frame = 0;
	p_subframe = 0;
	#ifdef PLAYER_GENITAL
		p_facing = FACING_DOWN;
		p_facing_v = p_facing_h = 0xff;
	#else
		p_facing = 1;
	#endif	
	p_estado = 	EST_NORMAL;
	p_ct_estado = 0;
	#if !defined(COMPRESSED_LEVELS) || defined(REFILL_ME)	
		p_life = 		PLAYER_LIFE;
	#endif
	p_objs =	0;
	p_keys = 0;
	p_killed = 0;
	p_disparando = 0;
	#ifdef MAX_AMMO
		#ifdef INITIAL_AMMO
			p_ammo = INITIAL_AMMO;
		#else
			p_ammo = MAX_AMMO;
		#endif
	#endif	

	#ifdef TIMER_ENABLE
		timer_count = 0;
		timer_zero = 0;
		#ifdef TIMER_LAPSE
			timer_frames = TIMER_LAPSE;
		#endif
		#ifdef TIMER_INITIAL
			timer_t = TIMER_INITIAL;
		#endif
		#ifdef TIMER_START
			timer_on = 1;
		#else
			timer_on = 0;
		#endif
	#endif
}

void player_calc_bounding_box (void) {
	#if defined (BOUNDING_BOX_8_BOTTOM)
		#asm
			ld  a, (_gpx)
			add 4
			srl a
			srl a
			srl a
			srl a
			ld  (_ptx1), a
			ld  a, (_gpx)
			add 11
			srl a
			srl a
			srl a
			srl a
			ld  (_ptx2), a
			ld  a, (_gpy)
			add 8
			srl a
			srl a
			srl a
			srl a
			ld  (_pty1), a
			ld  a, (_gpy)
			add 15
			srl a
			srl a
			srl a
			srl a
			ld  (_pty2), a
		#endasm
	#elif defined (BOUNDING_BOX_8_CENTERED)
		#asm
			ld  a, (_gpx)
			add 4
			srl a
			srl a
			srl a
			srl a
			ld  (_ptx1), a
			ld  a, (_gpx)
			add 11
			srl a
			srl a
			srl a
			srl a
			ld  (_ptx2), a
			ld  a, (_gpy)
			add 4
			srl a
			srl a
			srl a
			srl a
			ld  (_pty1), a
			ld  a, (_gpy)
			add 11
			srl a
			srl a
			srl a
			srl a
			ld  (_pty2), a
		#endasm
	#else
		#asm
			ld  a, (_gpx)
			srl a
			srl a
			srl a
			srl a
			ld  (_ptx1), a
			ld  a, (_gpx)
			add 15
			srl a
			srl a
			srl a
			srl a
			ld  (_ptx2), a
			ld  a, (_gpy)
			srl a
			srl a
			srl a
			srl a
			ld  (_pty1), a
			ld  a, (_gpy)
			add 15
			srl a
			srl a
			srl a
			srl a
			ld  (_pty2), a
		#endasm
	#endif
}

unsigned char player_move (void) {	
		
	// ***************************************************************************
	//  MOVEMENT IN THE VERTICAL AXIS
	// ***************************************************************************

	#if !defined PLAYER_GENITAL || defined VENG_SELECTOR

		#if !defined PLAYER_DISABLE_GRAVITY
			#if defined VENG_SELECTOR && defined PLAYER_VKEYS
				if (veng_selector != VENG_KEYS)
			#endif
			{
				// Do gravity
				
				#asm
						; Signed comparisons are hard
						; p_vy <= PLAYER_MAX_VY_CAYENDO - PLAYER_G

						; We are going to take a shortcut.
						; If p_vy < 0, just add PLAYER_G.
						; If p_vy > 0, we can use unsigned comparition anyway.

						ld  hl, (_p_vy)
						bit 7, h
						jr  nz, _player_gravity_add 	; < 0

						ld  de, PLAYER_MAX_VY_CAYENDO - PLAYER_G
						or  a
						push hl
						sbc hl, de
						pop hl
						jr  nc, _player_gravity_maximum

					._player_gravity_add
						ld  de, PLAYER_G
						add hl, de
						jr  _player_gravity_vy_set

					._player_gravity_maximum
						ld  hl, PLAYER_MAX_VY_CAYENDO

					._player_gravity_vy_set
						ld  (_p_vy), hl

					._player_gravity_done

					#ifdef PLAYER_CUMULATIVE_JUMP
						ld  a, (_p_jmp_on)
						or  a
						jr  nz, _player_gravity_p_gotten_done
					#endif

						ld  a, (_p_gotten)
						or  a
						jr  z, _player_gravity_p_gotten_done

						xor a
						ld  (_p_vy), a

					._player_gravity_p_gotten_done
				#endasm
			}	
		#endif
	#endif

	#if defined PLAYER_GENITAL || (defined VENG_SELECTOR && defined PLAYER_VKEYS)

		#if defined (VENG_SELECTOR)
			if (veng_selector == VENG_KEYS )
		#endif
		{
			// Pad do

			if ( ! ((pad0 & sp_UP) == 0 || (pad0 & sp_DOWN) == 0)) {
				p_facing_v = 0xff;
				wall_v = 0;
				if (p_vy > 0) {
					p_vy -= PLAYER_RX;
					if (p_vy < 0) p_vy = 0;
				} else if (p_vy < 0) {
					p_vy += PLAYER_RX;
					if (p_vy > 0) p_vy = 0;
				}
			}

			if ((pad0 & sp_UP) == 0) {
				p_facing_v = FACING_UP;
				if (p_vy > -PLAYER_MAX_VX) p_vy -= PLAYER_AX;
			}

			if ((pad0 & sp_DOWN) == 0) {
				p_facing_v = FACING_DOWN;
				if (p_vy < PLAYER_MAX_VX) p_vy += PLAYER_AX;
			}
		}
	#endif

	#ifdef PLAYER_HAS_JETPAC
		#ifdef VENG_SELECTOR
			if (veng_selector == VENG_JETPAC)
		#endif
		{
			if ((pad0 & sp_UP) == 0) {
				p_vy -= PLAYER_INCR_JETPAC;
				if (p_vy < -PLAYER_MAX_VY_JETPAC) p_vy = -PLAYER_MAX_VY_JETPAC;

				#include "my/ci/on_jetpac_boost.h"

				p_jetpac_on = 1;
			} else p_jetpac_on = 0;
		}
	#endif

	#include "my/ci/custom_veng.h"

	p_y += p_vy;
	
	#if !defined (PLAYER_GENITAL)
		if (p_gotten) p_y += ptgmy;
	#endif

	// Safe
		
	if (p_y < 0) p_y = 0;
	if (p_y > 9216) p_y = 9216;

	gpy = p_y >> 6;

	// Collision, may set possee, hit_v

	#asm
			call _player_calc_bounding_box

			xor a 
			ld  (_hit_v), a

			ld  a, (_ptx1)
			ld  (_cx1), a
			ld  a, (_ptx2)
			ld  (_cx2), a

			// Calculate vertical velocity
			
			ld  a, (_p_vy)
			#if !defined (PLAYER_GENITAL)
				ld  c, a
				ld  a, (_ptgmy)
				add c
			#endif

			// Skip if not moving in the vertical axis

			or  a
			jp  z, _va_collision_done

			// Check sign

			bit 7, a
			jr  z, _va_collision_vy_positive

		._va_collision_vy_negative

			// Velocity negative (going upwards)

			ld  a, (_pty1)
			ld  (_cy1), a
			ld  (_cy2), a

			call _cm_two_points

			// if ((at1 & 8) || (at2 & 8)) {
			ld  a, (_at1)
			and 8
			jr  nz, _va_col_vy_neg_do

			ld  a, (_at2)
			and 8
			jr  z, _va_collision_checkevil

		._va_col_vy_neg_do

			#ifdef PLAYER_BOUNCE_WITH_WALLS
				ld  a, (_p_vy)
				sra a
				neg a
			#else
				xor a
			#endif 
			ld  (_p_vy), a

			ld  a, (_pty1)
			inc a
			sla a
			sla a
			sla a
			sla a		

			#if defined (BOUNDING_BOX_8_BOTTOM)			
				// gpy = ((pty1 + 1) << 4) - 8;
				sub 8
			#elif defined (BOUNDING_BOX_8_CENTERED)
				// gpy = ((pty1 + 1) << 4) - 4;
				sub 4
			#elif defined (BOUNDING_BOX_TINY_BOTTOM)
				// gpy = ((pty1 + 1) << 4) - 14;
				sub 14
			#else
				// gpy = ((pty1 + 1) << 4);
			#endif

			ld  (_gpy), a

			// p_y = gpy << FIXBITS; 16 bits shift
			ld  d, 0
			ld  e, a
			ld  l, FIXBITS
			call l_asl
			ld  (_p_y), hl

			#if defined PLAYER_GENITAL || defined LOCKS_CHECK_VERTICAL
				ld  a, WTOP
				ld  (_wall_v), a
			#endif

			jr  _va_collision_checkevil

		._va_collision_vy_positive

			// Velocity positive (going downwards)
			ld  a, (_pty2)
			ld  (_cy1), a
			ld  (_cy2), a

			call _cm_two_points

			#ifdef PLAYER_GENITAL
				// if ((at1 & 8) || (at2 & 8)) {
				ld  a, (_at1)
				and 8
				jr  nz, _va_col_vy_pos_do

				ld  a, (_at2)
				and 8
				jr  z, _va_collision_checkevil
			#else
				// if ((at1 & 8) || 
				ld  a, (_at1)
				and 8
				jr  nz, _va_col_vy_pos_do

				// (at2 & 8) || 
				ld  a, (_at2)
				and 8
				jr  nz, _va_col_vy_pos_do

				// (((gpy - 1) & 15) < 8 &&
				ld  a, (_gpy)
				dec a
				and 15
				cp  8 
				jr  nc, _va_collision_checkevil

				// ((at1 & 4) || (at2 & 4))))
				ld  a, (_at1)
				and 4
				jr  nz, _va_col_vy_pos_do

				ld  a, (_at2)
				and 4
				jr  z, _va_collision_checkevil
			#endif
		._va_col_vy_pos_do

			#ifdef PLAYER_BOUNCE_WITH_WALLS
				ld  a, (_p_vy)
				sra a
				neg a
			#else
				xor a
			#endif 
			ld  (_p_vy), a	

			ld  a, (_pty2)
			dec a 
			sla a
			sla a
			sla a
			sla a

			#ifdef BOUNDING_BOX_8_CENTERED
				add 4
			#endif

			ld  (_gpy), a

			// p_y = gpy << FIXBITS; 16 bits shift
			ld  d, 0
			ld  e, a
			ld  l, FIXBITS
			call l_asl
			ld  (_p_y), hl

			#if defined PLAYER_GENITAL || defined LOCKS_CHECK_VERTICAL
				ld  a, WBOTTOM
				ld  (_wall_v), a
			#endif
				
			jr  _va_collision_done

		._va_collision_checkevil

			#ifndef DEACTIVATE_EVIL_TILE
				#endasm
					hit_v = ((at1 & 1) || (at2 & 1));
				#asm
			#endif

		._va_collision_done
	#endasm
	
	gpxx = gpx >> 4;
	gpyy = gpy >> 4;

	#ifndef PLAYER_GENITAL
		cy1 = cy2 = (gpy + 16) >> 4;
		cx1 = ptx1; cx2 = ptx2;
		cm_two_points ();
		possee = ((at1 & 12) || (at2 & 12)) && (gpy & 15) < 8;
	#endif

	// Jump

	#ifdef PLAYER_HAS_JUMP
		#ifdef VENG_SELECTOR
			if (veng_selector == VENG_JUMP)
		#endif
		{
			#if defined (PLAYER_CAN_FIRE) && !defined (USE_TWO_BUTTONS)
				rda = (pad0 & sp_UP) == 0;
			#elif defined (PLAYER_CAN_FIRE) && defined (USE_TWO_BUTTONS)				
				rda = isJoy ? ((pad0 & sp_UP) == 0) : (sp_KeyPressed (key_jump));
			#else
				rda = (pad0 & sp_FIRE) == 0;
			#endif

			if (rda) {
				if (p_saltando == 0) {
					if (possee || p_gotten || hit_v) {
						p_saltando = 1;
						p_cont_salto = 0;
						#ifdef MODE_128K
							PLAY_SOUND (SFX_JUMP);
						#else
							beep_fx (3);
						#endif
					}
				} else {
					p_vy -= (PLAYER_VY_INICIAL_SALTO + PLAYER_INCR_SALTO - (p_cont_salto >> 1));
					if (p_vy < -PLAYER_MAX_VY_SALTANDO) p_vy = -PLAYER_MAX_VY_SALTANDO;
					++ p_cont_salto;
					if (p_cont_salto == 9) p_saltando = 0;
				}
			} else p_saltando = 0;
		}
	#endif

	// Bootee engine

	#ifdef PLAYER_BOOTEE
		#ifdef VENG_SELECTOR
			if (veng_selector == VENG_BOOTEE)
		#endif
		{
			if ( p_saltando == 0 && (possee || p_gotten || hit_v) ) {
				p_saltando = 1;
				p_cont_salto = 0;
				#ifdef MODE_128K
					PLAY_SOUND (SFX_JUMP);
				#else				
					beep_fx (3);
				#endif
			}
			
			if (p_saltando ) {
				p_vy -= (PLAYER_VY_INICIAL_SALTO + PLAYER_INCR_SALTO - (p_cont_salto>>1));
				if (p_vy < -PLAYER_MAX_VY_SALTANDO) p_vy = -PLAYER_MAX_VY_SALTANDO;
				++ p_cont_salto;
				if (p_cont_salto == 8)
					p_saltando = 0;
			}
		}
	#endif	

	// ***************************************************************************
	//  MOVEMENT IN THE HORIZONTAL AXIS
	// ***************************************************************************

	#ifndef PLAYER_DISABLE_DEFAULT_HENG
		if ( ! ((pad0 & sp_LEFT) == 0 || (pad0 & sp_RIGHT) == 0)) {
			#ifdef PLAYER_GENITAL		
				p_facing_h = 0xff;
			#endif
			if (p_vx > 0) {
				p_vx -= PLAYER_RX;
				if (p_vx < 0) p_vx = 0;
			} else if (p_vx < 0) {
				p_vx += PLAYER_RX;
				if (p_vx > 0) p_vx = 0;
			}
			wall_h = 0;
		}

		if ((pad0 & sp_LEFT) == 0) {
			#ifdef PLAYER_GENITAL
				p_facing_h = FACING_LEFT;
			#endif
			if (p_vx > -PLAYER_MAX_VX) {
				#ifndef PLAYER_GENITAL			
					p_facing = 0;
				#endif
				p_vx -= PLAYER_AX;
			}
		}

		if ((pad0 & sp_RIGHT) == 0) {
			#ifdef PLAYER_GENITAL	
				p_facing_h = FACING_RIGHT;
			#endif
			if (p_vx < PLAYER_MAX_VX) {
				p_vx += PLAYER_AX;
				#ifndef PLAYER_GENITAL						
					p_facing = 1;
				#endif
			}
		}
	#endif

	#include "my/ci/custom_heng.h"

	p_x = p_x + p_vx;
	#ifndef PLAYER_GENITAL
		p_x += ptgmx;
	#endif
	
	// Safe
	
	if (p_x < 0) p_x = 0;
	if (p_x > 14336) p_x = 14336;

	gpox = gpx;
	gpx = p_x >> 6;
		
	// Collision. May set hit_h
	player_calc_bounding_box ();

	hit_h = 0;
	cy1 = pty1; cy2 = pty2;

	#if defined (PLAYER_GENITAL)
		if (p_vx < 0)
	#else	
		if (p_vx + ptgmx < 0)
	#endif
	{
		cx1 = cx2 = ptx1;
		cm_two_points ();

		if ((at1 & 8) || (at2 & 8)) {
			#include "my/ci/bg_collision/obstacle_left.h"

			#ifdef PLAYER_BOUNCE_WITH_WALLS
				p_vx = -(p_vx / 2);
			#else
				p_vx = 0;
			#endif

			#if defined (BOUNDING_BOX_8_BOTTOM) || defined (BOUNDING_BOX_8_CENTERED) || defined (BOUNDING_BOX_TINY_BOTTOM)				
				gpx = ((ptx1 + 1) << 4) - 4;
			#else
				gpx = ((ptx1 + 1) << 4);
			#endif

			p_x = gpx << 6;
			wall_h = WLEFT;
		}
		#ifndef DEACTIVATE_EVIL_TILE
			else hit_h = ((at1 & 1) || (at2 & 1));
		#endif

	}

	#if defined (PLAYER_GENITAL)
		if (p_vx > 0)
	#else	
		if (p_vx + ptgmx > 0)
	#endif
	{
		cx1 = cx2 = ptx2; 
		cm_two_points ();

		if ((at1 & 8) || (at2 & 8)) {
			#include "my/ci/bg_collision/obstacle_right.h"

			#ifdef PLAYER_BOUNCE_WITH_WALLS
				p_vx = -(p_vx / 2);
			#else
				p_vx = 0;
			#endif

			#if defined (BOUNDING_BOX_8_BOTTOM) || defined (BOUNDING_BOX_8_CENTERED) || defined (BOUNDING_BOX_TINY_BOTTOM)				
				gpx = (ptx1 << 4) + 4;
			#else
				gpx = (ptx1 << 4);
			#endif

			p_x = gpx << 6;
			wall_h = WRIGHT;
		}
		#ifndef DEACTIVATE_EVIL_TILE
			else hit_h = ((at1 & 1) || (at2 & 1));
		#endif

	}

	// Priority to decide facing

	#ifdef PLAYER_GENITAL
		#ifdef TOP_OVER_SIDE
			if (p_facing_v != 0xff) {
				p_facing = p_facing_v;
			} else if (p_facing_h != 0xff) {
				p_facing = p_facing_h;
			}
		#else
			if (p_facing_h != 0xff) {
				p_facing = p_facing_h;
			} else if (p_facing_v != 0xff) {
				p_facing = p_facing_v;
			}
		#endif	
	#endif

	cx1 = p_tx = (gpx + 8) >> 4;
	cy1 = p_ty = (gpy + 8) >> 4;

	rdb = attr (cx1, cy1);

	// Special tiles
	if (rdb & 128) {
		#include "my/ci/on_special_tile.h"
	}

	#if defined (PLAYER_PUSH_BOXES) || !defined (DEACTIVATE_KEYS)
		#if defined PLAYER_GENITAL || defined LOCKS_CHECK_VERTICAL
			if (wall_v == WTOP) {
				// interact up			
				#if defined (BOUNDING_BOX_8_BOTTOM)
					cy1 = (gpy + 7) >> 4;
				#elif defined (BOUNDING_BOX_8_CENTERED)
					cy1 = (gpy + 3) >> 4;
				#else
					cy1 = (gpy - 1) >> 3;		
				#endif

				if (attr (cx1, cy1) == 10) {
					x0 = x1 = cx1; y0 = cy1; y1 = cy1 - 1;
					process_tile ();
				}

			} else if (wall_v == WBOTTOM) {
				// interact down
				#if defined (BOUNDING_BOX_8_BOTTOM)
					cy1 = (gpy + 16) >> 4;
				#elif defined (BOUNDING_BOX_8_CENTERED)
					cy1 = (gpy + 12) >> 4;
				#else
					cy1 = (gpy + 16) >> 3;				
				#endif		
			
				if (attr (cx1, cy1) == 10) {
					x0 = x1 = cx1; y0 = cy1; y1 = cy1 + 1;
					process_tile ();
				}
			} else
		#endif	
		
		if (wall_h == WLEFT) {		
			// interact left
			#if defined (BOUNDING_BOX_8_BOTTOM) || defined (BOUNDING_BOX_8_CENTERED)
				cx1 = (gpx + 3) >> 4;
			#else
				cx1 = (gpx - 1) >> 4;		
			#endif		

			if (attr (cx1, cy1) == 10) {
				y0 = y1 = cy1; x0 = cx1; x1 = cx1 - 1;
				process_tile ();
			}
		} else if (wall_h == WRIGHT) {
			// interact right
			#if defined (BOUNDING_BOX_8_BOTTOM) || defined (BOUNDING_BOX_8_CENTERED)
				cx1 = (gpx + 12) >> 4;
			#else
				cx1 = (gpx + 16) >> 4;		
			#endif		
			if (attr (cx1, cy1) == 10) {
				y0 = y1 = cy1; x0 = cx1; x1 = cx1 + 1;
				process_tile ();
			}
		}
	#endif

	#ifdef PLAYER_CAN_FIRE
		// Disparos
		if ((pad0 & sp_FIRE) == 0 && p_disparando == 0) {			
			p_disparando = 1;
			#ifdef FIRE_TO_PUSH	
				//if (pushed_any == 0)
			#endif
				bullets_fire ();
			#ifdef FIRE_TO_PUSH	
				//else pushed_any = 0;
			#endif
		}
		
		if ((pad0 & sp_FIRE)) 
			p_disparando = 0;

	#endif

	#ifndef DEACTIVATE_EVIL_TILE
		// Tiles que te matan. 
		// hit_v tiene preferencia sobre hit_h
		hit = 0;
		if (hit_v) {
			hit = 1;
				p_vy = addsign (-p_vy, PLAYER_MAX_VX);
		} else if (hit_h) {
			hit = 1;
				p_vx = addsign (-p_vx, PLAYER_MAX_VX);
		}
		
		if (hit) {
			#ifdef PLAYER_FLICKERS
				if (p_estado == EST_NORMAL)
			#endif		
			{
				#ifdef MODE_128K
					p_killme = SFX_SPIKES;
				#else		
					p_killme = 4;
				#endif
			}
		}
	#endif

	// Select animation frame 

	#ifdef PLAYER_CUSTOM_ANIMATION
		#include "my/custom_animation.h"
	#elif defined PLAYER_GENITAL
		if (p_vx || p_vy) {
			++ p_subframe;
			if (p_subframe == 4) {
				p_subframe = 0;
				p_frame = !p_frame;
				#ifdef PLAYER_STEP_SOUND			
					step (); 
				#endif
			}
		}
		
		p_next_frame = player_cells [p_facing + p_frame];
	#elif defined PLAYER_BOOTEE
		gpit = p_facing << 2;
		if (p_vy == 0) {
			p_next_frame = player_cells [gpit];
		} else if (p_vy < 0) {
			p_next_frame = player_cells [gpit + 1];
		} else {
			p_next_frame = player_cells [gpit + 2];
		}
	#else	
		if (!possee && !p_gotten) {
			p_next_frame = player_cells [8 + p_facing];
		} else {
			gpit = p_facing << 2;
			if (p_vx == 0) {
				rda = 1;
			} else {
				rda = ((gpx + 4) >> 3) & 3;
			}
			p_next_frame = player_cells [gpit + rda];
		}
	#endif
}

void player_deplete (void) {
	p_life = (p_life > p_kill_amt) ? p_life - p_kill_amt : 0;
}

void player_kill (unsigned char sound) {
	p_killme = 0;

	player_deplete ();

	#ifdef MODE_128K
		PLAY_SOUND (sound);
	#else
		beep_fx (sound);
	#endif

	#ifdef CP_RESET_WHEN_DYING
		#ifdef CP_RESET_ALSO_FLAGS
			mem_load ();
		#else
			n_pant = sg_pool [MAX_FLAGS];
			p_x = sg_pool [MAX_FLAGS + 1] << 10;
			p_y = sg_pool [MAX_FLAGS + 2] << 10;
		#endif	
		o_pant = 0xff; // Reload
	#endif

	#ifdef PLAYER_FLICKERS
		p_estado = EST_PARP;
		p_ct_estado = 50;
	#endif
}

