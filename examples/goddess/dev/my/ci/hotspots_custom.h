// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

case 4:
case 5:
case 6:
case 7:
case 8:
	_t = p_inv;
	p_inv = hotspots [n_pant].tipo;
	hotspots [n_pant].tipo = _t;

	// Update graphic
	_x = hotspot_x >> 4; _y = hotspot_y >> 4;
	draw_invalidate_coloured_tile_gamearea ();

	break;
