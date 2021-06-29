// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

rda = templos_mataos ^ 1;
_gp_gen = (unsigned char *) (simple_decorations + (rda ? 4 : 0));
for (gpit = rda; gpit < 6; gpit ++) {
	if (*_gp_gen == n_pant) {
		++ _gp_gen;
		_x = *_gp_gen; ++ _gp_gen;
		_y = *_gp_gen; ++ _gp_gen;
		_t = *_gp_gen; ++ _gp_gen;
		_n = 8;
		update_tile ();
		break;
	} else _gp_gen += 4;
}

hotspots [7].act = templos_mataos;

if (n_pant == 7 && puerta_abierta == 0) {
	_x = 13; _y = 3; _t = 29; _n = 8; update_tile ();
	_x = 13; _y = 4; _t = 30; _n = 8; update_tile ();
}
