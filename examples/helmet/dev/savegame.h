// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Savegame / checkpoint routines

unsigned char sg_pool [MAX_FLAGS + 5];
unsigned char sgit;
unsigned char sg_saved = 0;
unsigned char sg_do_load = 0;
unsigned char sg_level;

void mem_save (void) {
	sg_saved = 1;
	sgit = 0; while (sgit < MAX_FLAGS) {
		sg_pool [sgit] = flags [sgit ++];
	}
	sg_pool [MAX_FLAGS] = n_pant;
	sg_pool [MAX_FLAGS + 1] = p_x >> 10;
	sg_pool [MAX_FLAGS + 2] = p_y >> 10;
#ifdef MAX_AMMO
	sg_pool [MAX_FLAGS + 3] = p_ammo;
#endif
#ifdef TIMER_ENABLE
	sg_pool [MAX_FLAGS + 4] = timer_t;
#endif
#ifdef COMPRESSED_LEVELS
	sg_level = level;
#endif
}

void mem_load (void) {
	sgit = 0; while (sgit < MAX_FLAGS) {
		flags [sgit] = sg_pool [sgit ++];
	}
	n_pant = sg_pool [MAX_FLAGS];
	p_x = sg_pool [MAX_FLAGS + 1] << 10;
	p_y = sg_pool [MAX_FLAGS + 2] << 10;
#ifdef MAX_AMMO
	p_ammo = sg_pool [MAX_FLAGS + 3];
#endif
#ifdef TIMER_ENABLE
	timer_t = sg_pool [MAX_FLAGS + 4];
#endif
}

void tape_save (void) {
	// TODO!
}

void tape_load (void) {
	// TODO!
}

void sg_submenu (void) {
	sg_do_load = 0;
	if (sg_saved) {
		blackout_area ();
		_x = VIEWPORT_X + 11; _y = VIEWPORT_Y + 8; _t = 71; _gp_gen = "0 START"; print_str ();
		_x = VIEWPORT_X + 11; _y = VIEWPORT_Y + 8; _t = 71; _gp_gen = "9 CONTINUE"; print_str ();
		while (1) {
			sgit = sp_GetKey ();
			if (sgit == '0') break;
			if (sgit == '9') {
				sg_do_load = 1;
				break;
			}
		}
	}	
}
