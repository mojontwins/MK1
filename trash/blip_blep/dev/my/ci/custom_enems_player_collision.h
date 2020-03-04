// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// To check custom collisions with the player.
// Runs after platforms (in lateral view games) have been discarded.

// Don't remember to bypass normal enemy/player collision (which results on the player losing life)
// if needed using 

// goto player_enem_collision_done;

cx2 = _en_x; cy2 = _en_y;
if (collide () && _en_y >= gpy - 8 && p_vy < -P_BREAK_VELOCITY_OFFSET) {
	// animate death
	en_an_next_frame [enit] = sprite_17_a;
	enems_draw_current ();
	sp_UpdateNow ();

	beep_fx (5);
	en_an_next_frame [enit] = sprite_18_a;	
	
	// Kill enemy
	enems_kill ();

	// Rebound player
	p_vy = -p_vy;

	// Skip normal collision
	goto player_enem_collision_done;
}
