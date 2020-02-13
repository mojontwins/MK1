// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

case 3:
	if ((pad0 & sp_DOWN) == 0) {
		p_life = PLAYER_LIFE;
		beep_fx (8);
	}

	hotspot_destroy = 0;
	break;

case 4:
case 5:
case 6:
case 7:
case 8:
	if ((pad0 & sp_DOWN) == 0) {
		_t = p_inv;
		p_inv = hotspots [n_pant].tipo;
		hotspots [n_pant].tipo = _t;

		// Update graphic
		_x = hotspot_x >> 4; _y = hotspot_y >> 4; _t += 16;
		draw_invalidate_coloured_tile_gamearea ();

		beep_fx (9);

		// Check
		if (
			templos_mataos == 0 &&
			hotspots [12].tipo == 7 && // Scissors on Paper
			hotspots [18].tipo == 6 && // Paper on Stone
			hotspots [22].tipo == 5    // Stone on Scissors
		) {
			templos_mataos = 1;
			_x = 1; _y = 23; _t = 71;
			_gp_gen = "A BOLT APPEARED ELSEWHERE...  ";
			print_str ();
			beep_fx (0);
		}

		if (
			n_pant == 7 && 
			puerta_abierta == 0 &&
			hotspots [7].tipo == 8
		) {
			puerta_abierta = 1;

			// Animation
			_x = 13; _y = 3; _t = 0; _n = 0; update_tile ();
			_x = 13; _y = 4; _t = 29; _n = 0; update_tile ();
			sp_UpdateNow ();
			beep_fx (0);
			_x = 13; _y = 4; _t = 0; _n = 0; update_tile ();
			sp_UpdateNow ();
			beep_fx (0);
		}
	}

	hotspot_destroy = 0;
	break;
