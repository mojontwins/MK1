// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

void modify_map (void) {
	// gpaux is COORDS (_x, _y) & points where.
	// c_screen_address is calculated on entering_screen.h
	// rdt is the tile number to write.

	_gp_gen = (c_screen_address + (gpaux >> 1));
	rda = *_gp_gen;

	if (gpaux & 1) {
		// Modify right nibble
		rda = (rda & 0xf0) | rdt;
	} else {
		// Modify left nibble
		rda = (rda & 0x0f) | (rdt << 4);
	}

	*_gp_gen = rda;	
}

void break_wall_kill_and_persist (void) {

	break_wall ();			// Breaks _x, _y. this sets gpaux!

	p_killme = 1;

	// c_screen_address must be set
	// gpaux is COORDS (_x, _y)
	// rdt = substitute with this tile
	
	// make the changes persistent on map only when the tile is
	// completely broken (i.e. has disappeared, 0 in this game)

	if (map_buff [gpaux] == 0) {
		rdt = 0;
		modify_map ();
	}
}

void break_vertical (void) {
	// Called from obstacle_up and obstacle_down

	if (at1 & 16) {
		_y = cy1; _x = cx1; 
		break_wall_kill_and_persist ();
	}

	if (cx1 != cx2) {
		if (at2 & 16) {
			_y = cy1; _x = cx2; 
			break_wall_kill_and_persist ();
		}
	}
}

void break_horizontal (void) {
	// Called from obstacle_left and obstacle_right
	_x = cx1;

	if (at1 & 16) {
		_x = cx1;_y = cy1; 
		break_wall_kill_and_persist ();
	}

	if (cy1 != cy2) {
		if (at2 & 16) {
			_x = cx1; _y = cy2; 
			break_wall_kill_and_persist ();
		}
	}
}
