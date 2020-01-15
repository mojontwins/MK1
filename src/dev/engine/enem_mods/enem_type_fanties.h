// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// The almighty fanties!

	active = 1;

	// Rewrite in assembly:
	_en_an_x = _en_an_x [enit];
	_en_an_y = _en_an_y [enit];
	_en_an_vx = _en_an_vx [enit];
	_en_an_vy = _en_an_vy [enit];
	//

	cx2 = _en_x = _en_an_x >> 6;
	cy2 = _en_y = _en_an_y >> 6;

	#ifdef FANTIES_TYPE_HOMING
		rdd = distance ();
		switch (en_an_state [enit]) {
			case TYPE_6_IDLE:
				if (rdd <= FANTIES_SIGHT_DISTANCE)
					en_an_state [enit] = TYPE_6_PURSUING;
				break;
			case TYPE_6_PURSUING:
				if (rdd > FANTIES_SIGHT_DISTANCE) {
					en_an_state [enit] = TYPE_6_RETREATING;
				} else {
	#endif

					_en_an_vx = limit (
						_en_an_vx + addsign (p_x - _en_an_x, FANTIES_A),
						-FANTIES_MAX_V, FANTIES_MAX_V);
					_en_an_vy = limit (
						_en_an_vy + addsign (p_y - _en_an_y, FANTIES_A),
						-FANTIES_MAX_V, FANTIES_MAX_V);
						
					_en_an_x = limit (_en_an_x + _en_an_vx, 0, 224<<6);
					_en_an_y = limit (_en_an_y + _en_an_vy, 0, 144<<6);

	#ifdef FANTIES_TYPE_HOMING									
				}
				break;
			case TYPE_6_RETREATING:
				_en_an_x += addsign (_en_x - _en_x, 64);
				_en_an_y += addsign (_en_y - _en_y, 64);
				
				if (rdd <= FANTIES_SIGHT_DISTANCE)
					en_an_state [enit] = TYPE_6_PURSUING;
				break;						
		}
	#endif

	_en_x = _en_an_x >> 6;
	_en_y = _en_an_y >> 6;

	#ifdef FANTIES_TYPE_HOMING
		if (en_an_state [enit] == TYPE_6_RETREATING && 
			_en_x == _en_x && 
			_en_y == _en_y
			) 
			en_an_state [enit] = TYPE_6_IDLE;
	#endif

	// Rewrite in assembly:
	_en_an_x [enit] = _en_an_x;
	_en_an_y [enit] = _en_an_y;
	_en_an_vx [enit] = _en_an_vx;
	_en_an_vy [enit] = _en_an_vy;
	//