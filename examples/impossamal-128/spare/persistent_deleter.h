// Persistent deleter for MTE MK1
// Copyleft 2020 by The Mojon Twins

// Add #include "my/ci/persistent_deleter.h" to "my/ci/extra_functions.h"

// Usage: 
// - On before_game.h add
//   pd_index = 0;
// - On entering_screen.h add
//   pd_do ();
// - To add persistence for current screen:
//   _t = room number; _x = x_tile_coord; _y = y_tile_coord;
//   pd_add ();

#define PD_MAX_ITEMS 		32
#define PD_DELETE_TILE		0

#ifdef MODE_128K
	unsigned char pd_n_pant [PD_MAX_ITEMS];
	unsigned char pd_yx [PD_MAX_ITEMS];
#else
	unsigned char pd_n_pant [PD_MAX_ITEMS] @ (24000 - PD_MAX_ITEMS);
	unsigned char pd_yx [PD_MAX_ITEMS] @ (24000 - PD_MAX_ITEMS*2);
#endif

unsigned char pd_index;

void pd_add (void) {
	pd_n_pant [pd_index] = _t;
	pd_yx [pd_index] = (_y << 4) | _x;
	++ pd_index;
}

void pd_do (void) {
	for (gpit = 0; gpit < pd_index; ++ gpit) {
		if (n_pant == pd_n_pant [gpit]) {
			_y = pd_yx [gpit]; _x = _y & 0xf; _y >>= 4;
			_t = PD_DELETE_TILE;
			update_tile ();
		}
	}
}
