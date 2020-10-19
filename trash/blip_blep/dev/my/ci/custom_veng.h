// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Modify p_vy
// Don't forget to use the veng_selector if VENG_SELECTOR is defined.

// Movimiento choco

if ((pad0 & sp_FIRE) == 0) {
	fire_pressed = 1;
	p_thrust -= P_THRUST_ADD;
	if (p_thrust < -P_THRUST_MAX) p_thrust = -P_THRUST_MAX;
	pad0 = 0xff;
} else {
	if (fire_pressed) {
		p_vy = p_thrust;
		p_thrust = 0;
	}
	fire_pressed = 0;
}

#ifdef BREAKABLE_WALLS
	// Detect head
	if (p_vy < -P_BREAK_VELOCITY_OFFSET) {
		cx1 = ptx1; cx2 = ptx2;
		cy1 = cy2 = (gpy - 1) >> 4;
		cm_hb_collision ();

		if (at1 & 16) {
			_x = cx1; _y = cy1;
			break_wall ();
			p_vy = P_BREAK_VELOCITY_OFFSET;
		}

		if (cx1 != cx2 && (at2 & 16)) {
			_x = cx2; _y = cy2;
			break_wall ();
			p_vy = P_BREAK_VELOCITY_OFFSET;
		}
	}
#endif

// Water gravity & friction
if (p_vy < PLAYER_MAX_VY_CAYENDO) {
	p_vy += PLAYER_G;
	if (p_vy > PLAYER_MAX_VY_CAYENDO) p_vy = PLAYER_MAX_VY_CAYENDO;
} else {
	p_vy -= P_WATER_FRICTION;
	if (p_vy < PLAYER_MAX_VY_CAYENDO) p_vy = PLAYER_MAX_VY_CAYENDO;
}
