// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

void screen_35_decoration (void) {
	if (flags [1] > 9) {
		_x = 8; _y = 7;  _n = 0;
		_t = flags [1] == 14 ? 45 : 44;
		update_tile ();
	}
}
