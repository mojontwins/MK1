// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// breakable.h

void break_wall (void) {
	gpaux = COORDS (_x, _y);
	if (brk_buff [gpaux] < BREAKABLE_WALLS_LIFE) {
		++ brk_buff [gpaux];
		#ifdef MODE_128K
			gpit = SFX_BREAKABLE_HIT;			
		#else
			gpit = 1;
		#endif
		#include "my/ci/on_wall_hit.h"
	} else {
		_n = _t = 0; update_tile ();
		#ifdef MODE_128K
			gpit = SFX_BREAKABLE_BREAK;
		#else
			gpit = 0;
		#endif
		#include "my/ci/on_wall_broken.h"
	}
	#ifdef MODE_128K
		PLAY_SOUND (gpit);
	#else			
		// Show what just happened before the sound interrupts the action
		sp_UpdateNow ();
		beep_fx (gpit);
	#endif
}
