// more boxes

#ifdef PLAYER_PUSH_BOXES

unsigned char can_move_box (unsigned char x0, unsigned char y0, unsigned char x1, unsigned char y1) {
#ifdef ENEMIES_BLOCK_BOXES
	unsigned char i, xx, yy;
	
	xx = x1 << 4; yy = y1 << 4;
	for (i = 0; i < 3; i ++) {
		if (malotes [enoffs + i].x >= xx - 15 && malotes [enoffs + i].x <= xx + 15 &&
			malotes [enoffs + i].y >= yy - 15 && malotes [enoffs + i].y <= yy + 15) {
			peta_el_beeper (9);
			return 0;
		}
	}
#endif

	if (qtile (x0, y0) != 14 || attr (x1, y1) >= 4)
		return 0;
		
	return 1;
}

#ifdef FALLING_BOXES
void init_falling_box_buffer () {
	unsigned char i;
	for (i = 0; i < MAX_FALLING_BOXES; i ++)
		fallingboxbuffer [i].act = 0;
}

void fall_box (unsigned char x, unsigned char y) {
	unsigned char i;
	for (i = 0; i < MAX_FALLING_BOXES; i ++) {
		if (!fallingboxbuffer [i].act) {
			fallingboxbuffer [i].act = 1;
			fallingboxbuffer [i].x = x;
			fallingboxbuffer [i].y = y;
			break;
		}
	}
}

void animate_boxes () {
#if defined (BOXES_KILL_ENEMIES) || defined (BOXES_KILL_PLAYER)
	unsigned char xx, yy;
#endif
#ifdef BOXES_KILL_PLAYER
	unsigned char x, y;
#endif
	unsigned char i;

	// Only at the right time...
	fall_frame_counter ++;
	if (fall_frame_counter >= FALLING_BOXES_SPEED) {
		fall_frame_counter = 0;
		for (i = 0; i < MAX_FALLING_BOXES; i ++) {
			if (fallingboxbuffer [i].act) {
				// Fall this box?
				if (attr (fallingboxbuffer [i].x, fallingboxbuffer [i].y + 1) < 4) {
					move_tile (fallingboxbuffer [i].x, fallingboxbuffer [i].y, fallingboxbuffer [i].x, fallingboxbuffer [i].y + 1, 0);
					// Check for cascades! (box beneath?)
					if (qtile (fallingboxbuffer [i].x, fallingboxbuffer [i].y - 1) == 14)
						fall_box (fallingboxbuffer [i].x, fallingboxbuffer [i].y - 1);
					fallingboxbuffer [i].y ++;
#if defined (BOXES_KILL_ENEMIES) || defined (BOXES_KILL_PLAYER)
					xx = fallingboxbuffer [i].x << 4;
					yy = fallingboxbuffer [i].y << 4;
#endif

#ifdef BOXES_KILL_ENEMIES
					// Check for enemy killed!

					for (i = 0; i < 3; i ++) {
#ifdef BOXES_ONLY_KILL_TYPE
						if (malotes [enoffs + i].t == BOXES_ONLY_KILL_TYPE) {
#else
						if (malotes [enoffs + i].t > 0 && malotes [enoffs + i].t < 16) {
#endif
							if (malotes [enoffs + i].x >= xx - 15 && malotes [enoffs + i].x <= xx + 15 &&
								malotes [enoffs + i].y >= yy - 15 && malotes [enoffs + i].y <= yy + 15) {
								en_an [i].next_frame = sprite_17_a;
								sp_MoveSprAbs (sp_moviles [i], spritesClip, en_an [i].next_frame - en_an [i].current_frame, VIEWPORT_Y + (malotes [enoffs + i].y >> 3), VIEWPORT_X + (malotes [enoffs + i].x >> 3), malotes [enoffs + i].x & 7, malotes [enoffs + i].y & 7);
								en_an [i].current_frame = en_an [i].next_frame;
								sp_UpdateNow ();
								peta_el_beeper (10);
								en_an [i].next_frame = sprite_18_a;
								malotes [enoffs + i].t |= 16;			// Marked as "dead"
								// Count it
								player.killed ++;
#ifdef ACTIVATE_SCRIPTING
								script = f_scripts [max_screens + 2];
								run_script ();
#endif
							}
						}						
					}
#endif

#ifdef BOXES_KILL_PLAYER
					// Check for player killed!
					x = player.x >> 6; y = player.y >> 6;
					if (x >= xx - 15 && x <= xx + 15 && y >= yy - 15 && y <= yy + 15) {
						explode_player (x, y);						
						player.life --;
						player.is_dead = 1;
					}
#endif
				} else {
					fallingboxbuffer [i].act = 0;
				}
			}	
		}	
	}
}
#endif
#endif