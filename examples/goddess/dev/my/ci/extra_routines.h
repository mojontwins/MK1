// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Display current item

if (op_inv != p_inv) {
	op_inv = p_inv;

	_x = 0; _y = 14; _t = 16 + p_inv;
	draw_coloured_tile ();
	invalidate_tile ();
}
