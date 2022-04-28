// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// breakable.h

void break_wall (void) {
	gpaux = COORDS (_x, _y);
	if (brk_buff [gpaux] < BREAKABLE_WALLS_LIFE) {

		#ifdef MODE_128K
			gpit = SFX_BREAKABLE_HIT;			
		#else
			gpit = 1;
		#endif
		#include "my/ci/on_wall_hit.h"
		#ifdef BREAKABLE_WALLS_BREAKING
			_n = rda; _t = BREAKABLE_WALLS_BREAKING; update_tile ();
		#endif
	} else {
		_n = 0; 
		#ifdef BREAKABLE_WALLS_BROKEN
			_t = BREAKABLE_WALLS_BROKEN;
		#else
			_t = 0; 
		#endif
		update_tile ();
		#ifdef MODE_128K
			gpit = SFX_BREAKABLE_BREAK;
		#else
			gpit = 0;
		#endif
		#include "my/ci/on_wall_broken.h"
	}
		++ brk_buff [gpaux];
	#ifdef MODE_128K
		PLAY_SOUND (gpit);
	#else			
		// Show what just happened before the sound interrupts the action
		sp_UpdateNow ();
		beep_fx (gpit);
	#endif
}
