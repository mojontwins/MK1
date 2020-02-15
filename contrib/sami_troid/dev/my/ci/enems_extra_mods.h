// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

if (malotes [enoffsmasi].t == 4) {
	if (boss_killed) {
		malotes [enoffsmasi].t |= 0x10; 	// Stay dead
	} else {
		malotes [enoffsmasi].life = 16;
	}
}