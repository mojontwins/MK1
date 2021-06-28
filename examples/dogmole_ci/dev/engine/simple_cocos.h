// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// simple_cocos.h

// A coco is active if its cocos_y has a valid value. Set to >160 to kill coco.
// This is a shortcut as we don't have to check if the coco exits the screen vertically.

// Creation is straightforward: enem N shoots coco N from _en_x+4, _en_y+4, so index with enit.
// Direction is extracted from bits 6, 7 of _en_t and preloaded in rda

void simple_coco_init (void) {
	for (enit = 0; enit < MAX_ENEMS; ++ enit) cocos_y [enit] = 0xff;
}

void simple_coco_shoot (void) {
	#asm
			ld  de, (_enit)
			ld  d, 0 					// DE = enit (index)

			ld  hl, _cocos_y
			add hl, de

			ld  a, (hl)
			cp  160
			ret c

			ld  a, (__en_y)
			add 4
			ld  (hl), a 				// cocos_y [enit] = _en_x + 4

			ld  hl, _cocos_x
			add hl, de
			ld  a, (__en_x)
			add 4
			ld  (hl), a 				// cocos_x [enit] = _en_x + 4

			ld  a, (_rda)				// direction 

			ld  e, a
			ld  d, 0 					// DE = direction
			ld  hl, __dx
			add hl, de
			ld  b, (hl) 				// B = _dx [direction]
			ld  hl, __dy
			add hl, de
			ld  c, (hl) 				// C = _dy [direction]

			ld  de, (_enit)
			ld  d, 0 					// DE = enit (index)

			ld  hl, _cocos_mx
			add hl, de
			ld  (hl), b 				// cocos_mx [enit] = B = _dx [direction]

			ld  hl, _cocos_my
			add hl, de
			ld  (hl), c 				// cocos_my [enit] = C = _dy [direction]
	#endasm
}

void simple_coco_update (void) {
	for (enit = 0; enit < MAX_ENEMS; ++ enit) if (cocos_y [enit] < 160) {
		#asm				
			._simple_coco_update_do
				// Move coco and copy to simple vars

				ld  de, (_enit)
				ld  d, 0

				ld  hl, _cocos_y 
				add hl, de
				ld  b, (hl) 			// B = cocos_y [enit]

				ld  hl, _cocos_x
				add hl, de
				ld  c, (hl) 			// C = cocos_x [enit]

				ld  hl, _cocos_my
				add hl, de
				ld  a, (hl)
				add b
				ld  (_rdy), a 			// rdy = cocos_y [enit] + cocos_my [enit]

				ld  hl, _cocos_mx
				add hl, de
				ld  a, (hl)
				add c
				ld  (_rdx), a 			// rdx = cocos_x [enit] + cocos_mx [enit]

				// Check if X is off limits
				cp  240
				jr  c, _simple_coco_update_keep_going

				ld  a, 0xff
				ld  (_rdy), a 			// This effectively marks the coco for destruction
				jr  _simple_coco_update_continue

			._simple_coco_update_keep_going
			
				// Check collision (player)	

			#ifdef PLAYER_FLICKERS
				ld  a, (_p_estado)
				or  a 
				jr  nz, _simple_coco_update_continue
			#endif

				// rdx + 3 >= gpx && rdx + 3 <= gpx + 15 &&
				// rdx + 3 >= gpx && rdx <= gpx + 12

				// rdx + 3 >= gpx
				ld  a, (_gpx)
				ld  c, a
				ld  a, (_rdx)
				add 3
				cp  c 
				jr  c, _simple_coco_update_collpl_done

				// gpx + 12 >= rdx
				ld  a, (_rdx)
				ld  c, a
				ld  a, (_gpx)
				add 12
				cp  c 
				jr  c, _simple_coco_update_collpl_done

				// rdy + 3 >= gpy && rdy + 3 <= gpy + 15
				// rdy + 3 >= gpy && rdy <= gpy + 12

				// rdy + 3 >= gpy
				ld  a, (_gpy)
				ld  c, a
				ld  a, (_rdy)
				add 3
				cp  c 
				jr  c, _simple_coco_update_collpl_done

				// gpy + 12 >= rdy
				ld  a, (_rdy)
				ld  c, a
				ld  a, (_gpy)
				add 12
				cp  c 
				jr  c, _simple_coco_update_collpl_done

				// Kill player
				ld  a, 0xff
				ld  (_rdy), a 			// This effectively marks the coco for destruction

			#ifdef MODE_128K
				ld  a, SFX_ENEMY_HIT
			#else
				ld  a, 4
			#endif
				ld  (_p_killme), a

				jr  _simple_coco_update_continue

			._simple_coco_update_collpl_done

		#endasm
			
		// Check collision (BG)	
		if (attr ((rdx + 3) >> 4, (rdy + 3) >> 4) & 12) rdy = 0xff;

		#asm

			._simple_coco_update_continue
				// And update arrays 
				ld  de, (_enit)
				ld  d, 0

				ld  hl, _cocos_y 
				add hl, de
				ld  a, (_rdy)
				ld  (hl), a

				ld  hl, _cocos_x
				add hl, de
				ld  a, (_rdx)
				ld  (hl), a

			._simple_coco_update_done
		#endasm
	}
}
