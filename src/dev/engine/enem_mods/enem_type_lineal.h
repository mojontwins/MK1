// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Simple, lineal enemies

	active = 1;
	_en_x += _en_mx;
	_en_y += _en_my;
	#ifdef WALLS_STOP_ENEMIES
		if (_en_x == _en_x1 || _en_x == _en_x2 || mons_col_sc_x ())
			_en_mx = -_en_mx;
		if (_en_y == _en_y1 || _en_y == _en_y2 || mons_col_sc_y ())
			_en_my = -_en_my;
	#else
		if (_en_x == _en_x1 || _en_x == _en_x2)
			_en_mx = -_en_mx;
		if (_en_y == _en_y1 || _en_y == _en_y2)
			_en_my = -_en_my;
	#endif
		