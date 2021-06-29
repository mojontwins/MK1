// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// custom_animation.h

// If you define PLAYER_CUSTOM_ANIMATION you have to add code here
// You should end up giving a value to p_next_frame.

// You can use the array player_cells [] which contains pointers to the 8
// frames for the main player in your spriteset.

if (fire_pressed) {
	rda = 6;
} else {
	if (gpx == gpox) {
		if (p_vy < 0) rda = 7; 
		else rda = (maincounter >> 4) & 1;
	} else {
		rda = 4 - (p_facing << 1);
		if (p_vy >= 0) rda += ((gpx >> 3) & 1);
	}
}

p_next_frame = (unsigned char *) (player_cells [rda]);
