// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

	// hotspots_custom.h
	case 5:
	case 6:
	case 7:
		rda = hotspots [n_pant].tipo;

		++ flags [0];
		flags [rda] = 1;
		wyz_play_sound (7);

		_x = (rda << 1) + 16; _y = 0; _t = 16 + rda;
		draw_coloured_tile ();
		invalidate_tile ();

		_gp_gen = textos_hotspots [rda - 5];
		_x = 6; _y = 23; _t = 71; 
		print_str ();
		break;
		