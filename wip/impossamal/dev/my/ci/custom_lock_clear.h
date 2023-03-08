// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

// custom_lock_clear.h

// If your define CUSTOM_LOCK_CLEAR this function
// will be called to remove the lock from screen
// (when opening and when entering)

void custom_lock_clear (void) {
	// Tile to be changed is _x, _y
	// Remember that if you call update_tile,
	// _x and _y are destroyed, so you should
	// save them elsewhere if you need.

	// Vanilla code does this:
	/*
	#asm
		xor a
		ld  (__t), a
		ld  (__n), a
		call _update_tile
	#endasm
	*/
}
