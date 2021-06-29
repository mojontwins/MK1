// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Enemigos Muy Jartibles.

	switch (en_an_alive [enit]) {
		case 0:
			if (!en_an_dead_row [enit]) {
				_en_x = _en_x1;
				_en_y = _en_y1;
				en_an_alive [enit] = 1;
				en_an_rawv [enit] = 1 << (rand () & 3);
				if (en_an_rawv [enit] > PURSUERS_MAX_V) en_an_rawv [enit] = 2;
				en_an_dead_row [enit] = 11 + (rand () & 7);
				#if defined(PLAYER_STEPS_ON_ENEMIES) || defined(PLAYER_CAN_FIRE)							
					_en_life = ENEMIES_LIFE_GAUGE;
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
				_en_mx = (signed char) (addsign (((gpx >> 2) << 2) - _en_x, en_an_rawv [enit]));
				if (rand () & 3) _en_x += _en_mx;
				#ifdef WALLS_STOP_ENEMIES
					if (mons_col_sc_x ()) _en_x = _en_cx;
				#endif
				_en_my = (signed char) (addsign (((gpy >> 2) << 2) - _en_y, en_an_rawv [enit]));
				if (rand () & 3) _en_y += _en_my;
				#ifdef WALLS_STOP_ENEMIES
					if (mons_col_sc_y ()) _en_y = _en_cy;
				#endif
			}
			
	}
	