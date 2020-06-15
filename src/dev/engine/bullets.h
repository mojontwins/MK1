// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// bullets.h

void bullets_init (void) {
	b_it = 0; while (b_it < MAX_BULLETS) { 
		bullets_estado [b_it] = 0; ++ b_it;
	}	
}

void bullets_update (void) {
	// Copies _b_? to the bullets_? [b_it] arrays
	#asm
		ld  de, (_b_it)
		ld  d, 0

		ld  hl, _bullets_estado
		add hl, de
		ld  a, (__b_estado)
		ld  (hl), a

		ld  hl, _bullets_x
		add hl, de
		ld  a, (__b_x)
		ld  (hl), a

		ld  hl, _bullets_y
		add hl, de
		ld  a, (__b_y)
		ld  (hl), a

		ld  hl, _bullets_mx
		add hl, de
		ld  a, (__b_mx)
		ld  (hl), a

		ld  hl, _bullets_my
		add hl, de
		ld  a, (__b_my)
		ld  (hl), a
	#endasm
}

#ifdef PLAYER_GENITAL
	// Based upon facing >> 1: RIGHT LEFT UP DOWN
	signed char _bxo [] = { 12, -4, 8 - PLAYER_BULLET_X_OFFSET, PLAYER_BULLET_X_OFFSET };
	signed char _byo [] = { PLAYER_BULLET_Y_OFFSET, PLAYER_BULLET_Y_OFFSET, -4, 12};
	signed char _bmxo [] = { PLAYER_BULLET_SPEED, -PLAYER_BULLET_SPEED, 0, 0 };
	signed char _bmyo [] = { 0, 0, -PLAYER_BULLET_SPEED, PLAYER_BULLET_SPEED };
#endif

void bullets_fire (void) {
	#ifdef PLAYER_CAN_FIRE_FLAG 
		if (flags [PLAYER_CAN_FIRE_FLAG] == 0) return;
	#endif

	#ifdef MAX_AMMO
		if (!p_ammo) return;
	#endif
	
	// Buscamos una bala libre
	for (b_it = 0; b_it < MAX_BULLETS; ++ b_it) {
		if (bullets_estado [b_it] == 0) {
			_b_estado = 1;
			#ifdef PLAYER_GENITAL
				/*
				switch (p_facing) {
					case FACING_RIGHT:
						_b_x = gpx + 12;
						_b_y = gpy + PLAYER_BULLET_Y_OFFSET;
						_b_mx = PLAYER_BULLET_SPEED;
						_b_my = 0;
						break;
					case FACING_LEFT:
						_b_x = gpx - 4;
						_b_y = gpy + PLAYER_BULLET_Y_OFFSET;
						_b_mx = -PLAYER_BULLET_SPEED;
						_b_my = 0;
						break;
					case FACING_DOWN:
						_b_x = gpx + PLAYER_BULLET_X_OFFSET;
						_b_y = gpy + 12;
						_b_mx = 0;
						_b_my = PLAYER_BULLET_SPEED;
						break;
					case FACING_UP:
						_b_x = gpx + 8 - PLAYER_BULLET_X_OFFSET;
						_b_y = gpy - 4;
						_b_mx = 0;
						_b_my = -PLAYER_BULLET_SPEED;
						break;
				}
				*/
				/*
				rda = p_facing >> 1;
				_b_x = gpx + _bxo [rda];
				_b_y = gpy + _byo [rda];
				_b_mx = _bmxo [rda];
				_b_my = _bmyo [rda];
				*/
				
				#asm
						ld  a, (_p_facing)
						srl a
						ld  c, a
						ld  b, 0

						ld  hl, __bxo
						add hl, bc						
						ld  d, (hl)
						ld  a, (_gpx)
						add d
						ld  (__b_x),a

						ld  hl, __byo
						add hl, bc
						ld  d, (hl)
						ld  a, (_gpy)
						add d
						ld  (__b_y),a

						ld  hl, __bmxo
						add hl, bc
						ld  a, (hl)
						ld  (__b_mx),a

						ld  hl, __bmyo
						add hl, bc
						ld  a, (hl)
						ld  (__b_my),a
				#endasm
				
			#else
				#ifdef CAN_FIRE_UP
					if ((pad0 & sp_UP) == 0) {
						_b_y = gpy;
						_b_my = -PLAYER_BULLET_SPEED;
					} else if (!(pad0 & sp_DOWN)) {
						_b_y = 8 + gpy;
						_b_my = PLAYER_BULLET_SPEED;	 
					} else 
				#endif
				{
					_b_y = gpy + PLAYER_BULLET_Y_OFFSET;
					_b_my = 0;
				}


				#ifdef CAN_FIRE_UP
					if ((pad0 & sp_LEFT) == 0 || (pad0 & sp_RIGHT) == 0 || ((pad0 & sp_UP) && (pad0 & sp_DOWN))) {
				#endif
					if (p_facing == 0) {
						_b_x = gpx - 4;
						_b_mx = -PLAYER_BULLET_SPEED;
					} else {
						_b_x = gpx + 12;
						_b_mx = PLAYER_BULLET_SPEED;
					}
				#ifdef CAN_FIRE_UP
					} else {
						_b_x = gpx + 4;
						_b_mx = 0;
					}
				#endif
			#endif

			#ifdef MODE_128K
				wyz_play_sound (SFX_SHOOT);
			#else
				beep_fx (6);
			#endif

			#ifdef LIMITED_BULLETS
				#if defined (LB_FRAMES) || !defined (ACTIVATE_SCRIPTING)
					bullets_life [b_it] = LB_FRAMES;
				#else
					bullets_life [b_it] = flags [LB_FRAMES_FLAG];
				#endif
			#endif

			#include "my/ci/on_player_fires.h"

			bullets_update ();

			#ifdef MAX_AMMO
				-- p_ammo;
			#endif
			
			break;
		}
	}
}

void bullets_move (void) {
	for (b_it = 0; b_it < MAX_BULLETS; b_it ++) {
		if (bullets_estado [b_it]) {
			#asm
				ld  de, (_b_it)
				ld  d, 0

				ld  hl, _bullets_x
				add hl, de
				ld  a, (hl)
				ld  (__b_x), a

				ld  hl, _bullets_y
				add hl, de
				ld  a, (hl)
				ld  (__b_y), a

				ld  hl, _bullets_mx
				add hl, de
				ld  a, (hl)
				ld  (__b_mx), a

				ld  hl, _bullets_my
				add hl, de
				ld  a, (hl)
				ld  (__b_my), a

				ld  a, 1
				ld  (__b_estado), a
			#endasm

			if (_b_mx) {
				_b_x += _b_mx;								
				if (_b_x > 240) {
					_b_estado = 0;
				}
			} 
			#if defined(PLAYER_GENITAL) || defined(CAN_FIRE_UP)
				if (_b_my) {
					_b_y += _b_my;
					if (_b_y > 160) {
						_b_estado = 0;
					}
				}
			#endif
			_x = (_b_x + 3) >> 4;
			_y = (_b_y + 3) >> 4;
			rda = attr (_x, _y);
			#ifdef BREAKABLE_WALLS			
				if (rda & 16) break_wall ();
			#endif
			if (rda > 7) _b_estado = 0;
		
			#ifdef LIMITED_BULLETS
				if (bullets_life [b_it] > 0) {
					-- bullets_life [b_it];
				} else {
					_b_estado = 0;
				}
			#endif

			bullets_update ();				
		}	
	}	
}
