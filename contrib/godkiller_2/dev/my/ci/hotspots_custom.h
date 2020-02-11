// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

	// hotspots_custom.h
	case 0x0a:
	case 0x0b:
	case 0x0c:
		++ flags [6];
		flags [hotspots [n_pant].tipo] = 1;
		wyz_play_sound (7);

		_x = 6; _y = 23; _t = 71; 
		_gp_gen = textos_hotspots [hotspots [n_pant].tipo - 0x0a];
		print_str ();
		break;
		