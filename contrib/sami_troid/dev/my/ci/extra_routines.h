// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

if ((pad0 & sp_DOWN) == 0) {
	if (n_pant == 35) {
		if (gpx >= 112 && gpx <= 243) {
			if (gpy >= 128 && gpy <= 159) {
				p_objs = 0;
				++ flags [1];
				beep_fx (5);

				screen_35_decoration ();
			}
		}
	}

	if (n_pant == 0) {
		if (p_tx == 3 && p_ty == 8) {
			if (boss_killed) {
				success = 1;
				playing = 0;
			}
		}
	}
}
