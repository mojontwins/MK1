// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Tile was pushed from (x0, y0) -> (x1, y1).

// First, put x1, y1 in pixels (precalc)
#asm	
		ld  a, (_x1)
		sla a
		sla a
		sla a
		sla a
		ld  (_rdx), a

		ld  a, (_y1)
		sla a
		sla a
		sla a
		sla a
		ld  (_rdy), a
#endasm

// First detect if the tile overlaps an enemy (simple)
for (enit = 0; enit < 3; ++ enit) {
	enoffsmasi = enoffs + enit;
	
	#asm
			ld 	hl, (_enoffsmasi)
			ld  h, 0

		#ifdef PLAYER_CAN_FIRE
			add hl, hl 				// x2
			ld  d, h
			ld  e, l 				// DE = x2
			add hl, hl 				// x4
			add hl, hl 				// x8

			add hl, de 				// HL = x8 + x2 = x10
		#else
			ld  d, h
			ld  e, l 				// DE = x1
			add hl, hl 				// x2
			add hl, hl 				// x4
			add hl, hl 				// x8

			add hl, de 				// HL = x8 + x1 = x9
		#endif

			ld  de, _malotes
			add hl, de

			ld  (__baddies_pointer), hl 		// Save address for later

			ld  a, (hl)
			ld  (__en_x), a
			inc hl 

			ld  a, (hl)
			ld  (__en_y), a

			ld  bc, 7
			add hl, bc
			ld  a, (hl)
			ld  (__en_t), a

		// Skip for rays
			cp  3
			jp  c, _on_tile_pushed_continue

		// Overlaps?
		// v2 = Full 4 points check.

		// Convert 

		// First: x--x
		//        |  |
		//        ----
		._on_tile_pushed_check_top
			ld  a, (__en_y)
			and 0xf0
			ld  c, a
			ld  a, (_rdy)
			cp  c
			jr  nz, _on_tile_pushed_check_bottom

			ld  a, (__en_x)
			and 0xf0
			ld  c, a
			ld  a, (_rdx)
			cp  c
			jr  z, _on_tile_pushed_overlaps

			ld  a, (__en_x)
			add 15
			and 0xf0
			ld  c, a
			ld  a, (_rdx)
			cp  c
			jr  z, _on_tile_pushed_overlaps
			jp  _on_tile_pushed_continue

		._on_tile_pushed_check_bottom
			ld  a, (__en_y)
			add 15
			and 0xf0
			ld  c, a
			ld  a, (_rdy)
			cp  c
			jp  nz, _on_tile_pushed_continue

			ld  a, (__en_x)
			and 0xf0
			ld  c, a
			ld  a, (_rdx)
			cp  c
			jr  z, _on_tile_pushed_overlaps

			ld  a, (__en_x)
			add 15
			and 0xf0
			ld  c, a
			ld  a, (_rdx)
			cp  c
			jp  nz, _on_tile_pushed_continue

		._on_tile_pushed_overlaps
		// Type 3: insta-kill
			ld  a, (__en_t)
			cp  3
			jp  nz, _on_tile_pushed_do

			jp _on_tile_pushed_kill_enemy

		._on_tile_pushed_do

		// If we got here, pushed tile overlaps the enemy.
		// We have to push the enemy in the right direction.

			ld  a, (_x0)
			ld  c, a
			ld  a, (_x1)
			cp  c
			jr  z, _on_tile_pushed_vertically

		._on_tile_pushed_horizontally
			// Moved horizontally. Left or right?
			jr  nc, _on_tile_pushed_right 	// C set   if A (_x1) <  C (_x0)
											// C reset if A (_x1) >= C (_x0)
		
		._on_tile_pushed_left
			// _en_x = (_en_x - 1) & 0xf0
			ld  a, (__en_x)
			dec a
			and 0xf0
			ld  (__en_x), a
			jr  _on_tile_pushed_horizontally_done

		._on_tile_pushed_right
			ld  a, (__en_x)
			add 16
			and 0xf0
			ld  (__en_x), a

		._on_tile_pushed_horizontally_done
			// Out of screen check
			// A = _en_x
			cp  240
			jp  nc, _on_tile_pushed_kill_enemy 	// C reset if A (__en_x) >= 240


			// Check if we moved to a tile. Checking TWO points should suffice
			// as enemy is now horizontally aligned
			call _on_tile_pushed_sr4
			ld  (_cx1), a
			ld  (_cx2), a
			ld  a, (__en_y)
			call _on_tile_pushed_sr4
			ld  (_cy1), a
			ld  a, (__en_y)
			add 15
			call _on_tile_pushed_sr4
			ld  (_cy2), a
			call _cm_two_points
			ld  a, (_at1)
			ld  c, a
			ld  a, (_at2)
			or  c
			jp  nz, _on_tile_pushed_kill_enemy

			jr  _on_tile_pushed_done

		._on_tile_pushed_vertically
			// Mover vertically. Up or down?
			ld  a, (_y0)
			ld  c, a
			ld  a, (_y1)
			cp  c

			jr  nc, _on_tile_pushed_down 	// C set   if A (_y1) <  C (_y0)
											// C reset if A (_y1) >= C (_y0)

		._on_tile_pushed_up
			ld  a, (__en_y)
			dec a
			and 0xf0
			ld  (__en_y), a
			jr  _on_tile_pushed_vertically_done

		._on_tile_pushed_down
			ld  a, (__en_y)
			add 16
			and 0xf0
			ld  (__en_y), a

		._on_tile_pushed_vertically_done
			// A = _en_y
			cp  160
			jr  nc, _on_tile_pushed_kill_enemy 	// C reset if A (__en_y) >= 160
			
			call _on_tile_pushed_sr4
			ld  (_cy1), a
			ld  (_cy2), a
			ld  a, (__en_x)
			call _on_tile_pushed_sr4
			ld  (_cx1), a
			ld  a, (__en_x)
			add 15
			call _on_tile_pushed_sr4
			ld  (_cx2), a
			call _cm_two_points
			ld  a, (_at1)
			ld  c, a
			ld  a, (_at2)
			or  c
			jp  nz, _on_tile_pushed_kill_enemy
			
		._on_tile_pushed_done

			ld  hl, (__baddies_pointer) 		// Restore pointer

			ld  a, (__en_x)
			ld  (hl), a
			inc hl

			ld  a, (__en_y)
			ld  (hl), a
			inc hl

			jr  _on_tile_pushed_continue

		._on_tile_pushed_sr4
			srl a
			srl a
			srl a
			srl a
			ret

		._on_tile_pushed_kill_enemy

	#endasm

	en_an_next_frame [enit] = sprite_17_a;
	sp_UpdateNow ();

	#ifdef MODE_128K
		en_an_state [enit] = GENERAL_DYING;
		en_an_count [enit] = 12;	
		PLAY_SOUND (SFX_SHOOT);
	#else
		beep_fx (5);
		en_an_next_frame [enit] = sprite_18_a;
	#endif
								
	#ifdef ENABLE_PURSUERS
		enems_pursuers_init ();
	#endif

	enems_kill ();

	#asm
			ld  hl, (__baddies_pointer)
			ld  bc, 8
			add hl, bc
			ld  a, (__en_t)
			ld  (hl), a
		._on_tile_pushed_continue
	#endasm
}
