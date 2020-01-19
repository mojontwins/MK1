// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// my/ci/extra_routines.h

if (n_pant == 0) {
	if (p_objs && p_ty == 7 && (p_tx == 3 || p_tx == 4)) {
		p_objs = 0; 	// Liberamos el objeto
		++ flags [1]; 	// Contamos uno más.

		if (flags [1] == 10) {
			// Terminar el juego "bien"
			success = 1;
			playing = 0;
		}
	}
}
