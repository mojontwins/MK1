// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// hud.h - Updates hud

	#if !defined DEACTIVATE_OBJECTS && OBJECTS_X != 99
		if (p_objs != objs_old) {
			draw_objs ();
			objs_old = p_objs;
		}
	#endif

	#if LIFE_X != 99
		if (p_life != life_old) {
			_x = LIFE_X; _y = LIFE_Y; _t = p_life; print_number2 ();
			life_old = p_life;
		}
	#endif

	#if !defined DEACTIVATE_KEYS && KEYS_X != 99
		if (p_keys != keys_old) {
			_x = KEYS_X; _y = KEYS_Y; _t = p_keys; print_number2 ();
			keys_old = p_keys;
		}
	#endif

	#if defined(PLAYER_STEPS_ON_ENEMIES) || defined(PLAYER_CAN_FIRE)
		#if KILLED_X != 99
			if (p_killed != killed_old) {
				_x = KILLED_X; _y = KILLED_Y; _t = p_killed; print_number2 ();
				killed_old = p_killed; 
			}
		#endif
	#endif

	#if defined MAX_AMMO && AMMO_X != 99
		if (p_ammo != ammo_old) {
			_x = AMMO_X; _y = AMMO_Y; _t = p_ammo; print_number2 ();
			ammo_old = p_ammo;
		}
	#endif

	#if defined TIMER_ENABLE && TIMER_X != 99
		if (timer_t != timer_old) {
			_x = TIMER_X; _y = TIMER_Y; _t = timer_t; print_number2 ();
			timer_old = timer_t;
		}
	#endif
