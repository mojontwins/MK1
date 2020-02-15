// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

switch (n_pant) {
	case 35:
		screen_35_decoration ();
		break;

	case 1:
		if (flags [1] == 14) {
			_x = 0; _y = 3; _t = _n = 0;
			update_tile ();
		}
		break;

	case 42:
		if (flags [1] > 9) {
			_x = 14; _y = 2; _t = _n = 0;
			update_tile ();
		}
		break;
}
