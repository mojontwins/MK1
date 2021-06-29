// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// my/ci/entering_screen.h

_gp_gen = 0;

switch (n_pant) {
	case 0:
		_gp_gen = (unsigned char *) (decos_0); break;
	case 1:
		_gp_gen = (unsigned char *) (decos_1); break;
	case 6: 
		_gp_gen = (unsigned char *) (decos_6); break;
	case 18:
		_gp_gen = (unsigned char *) (decos_18); break;
}

if (_gp_gen) draw_decorations ();

if (n_pant == 2) {
	if (flags [3]) {
		_x = 12; _y = 7; _t = _n = 0; update_tile ();
	}
}
