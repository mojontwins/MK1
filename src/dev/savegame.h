// MTE MK1 (la Churrera) v3.99.99 (final)
// Copyleft 2010-2017 by the Mojon Twins

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
	sg_pool [MAX_FLAGS + 1] = px >> 10;
	sg_pool [MAX_FLAGS + 2] = py >> 10;
#ifdef MAX_AMMO
	sg_pool [MAX_FLAGS + 3] = pammo;
#endif
#ifdef TIMER_ENABLE
	sg_pool [MAX_FLAGS + 4] = ctimer.t;
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
	px = sg_pool [MAX_FLAGS + 1] << 10;
	py = sg_pool [MAX_FLAGS + 2] << 10;
#ifdef MAX_AMMO
	pammo = sg_pool [MAX_FLAGS + 3];
#endif
#ifdef TIMER_ENABLE
	ctimer.t = sg_pool [MAX_FLAGS + 4];
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
		print_str (VIEWPORT_X + 11, VIEWPORT_Y + 8, 71, "0 START");
		print_str (VIEWPORT_X + 11, VIEWPORT_Y + 8, 71, "9 CONTINUE");
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
