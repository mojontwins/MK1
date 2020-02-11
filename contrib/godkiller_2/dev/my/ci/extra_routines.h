// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// extra_routines.h

	if (sp_KeyPressed (KEY_M)) {
		rda = 0;
		switch (n_pant) {
			case 10:
				if (flags [0x0a] == 0) break;
				rda = 1;
				_x = 6; _y = 23; _t = 71; 
				gp_gen = " LA LLAMA TE GUIA "; print_str ();
				break;

			case 28:
				rda = 2;
				break;

			case 35:
				rda = 3;
				break;
		}

		if (rda) {
			rda --;
			if (p_tx == warp_from_x [rda] && p_ty == warp_from_y [rda]) {
				n_pant = warp_to_n_pant [rda];
				gpx = warp_to_x [rda] << 4; p_x = gpx << FIXBITS;
				gpy = warp_to_y [rda] << 4; p_x = gpx << FIXBITS;
				wyz_play_sound (5);
			}
		}

		if (n_pant == 11 && p_tx == 12 && p_ty == 7) {
			_x = 12; _y = 8; _t = _n = 0; update_tile ();
			wyz_play_sound (5);
		}

		if (n_pant == 4 && p_tx == 7 && p_ty == 1) {
			if (p_objs == 15 && flags [6] == 3) {
				success = 1;
				playing = 0;			
			}
		}		
	}