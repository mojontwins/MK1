// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Enemigos Increiblemente Jartibles.
// Assembly version.

#asm
		ld  bc, (_enit)
		ld  b, 0
		ld  hl, _en_an_alive
		add hl, bc
		ld  a, (hl)

		cp  1
		jp  z, _eij_state_appearing

		cp  2
		jp  z, _eij_state_moving

	._eij_state_idle
		ld  hl, _en_an_dead_row
		add hl, bc
		ld  a, (hl)
		or  a
		jr  nz, _eij_state_still_idle

		ld  a, (__en_x1)
		ld  (__en_x), a
		ld  a, (__en_y1)
		ld  (__en_y), a

		ld  hl, _en_an_alive
		add hl, bc
		ld  a, 1
		ld  (hl), a

		// en_an_rawv [enit] = 1 << (rand () & 3);
		push bc
		call _rand		// rand -> L
		
		ld  a, l
		and 3
		ld  l, a
		ld  h, 0

		ld	de, 1
		call l_asl 		// l_asl :: DE << HL -> HL
		ld  a, l
		pop bc

		cp  PURSUERS_MAX_V+1
		jr  c, _eij_rawv_set

		ld  a, 2

	._eij_rawv_set
		ld  hl, _en_an_rawv
		add hl, bc
		ld  (hl), a

		call _rand
		ld  a, l
		and DEATH_COUNT_AND
		add DEATH_COUNT_ADD

		ld  hl, _en_an_dead_row
		add hl, bc
		ld  (hl), a

		#if defined(PLAYER_CAN_FIRE)
			ld  a, ENEMIES_LIFE_GAUGE
			ld  (__en_life), a
		#endif
		jp  _eij_state_done

	._eij_state_still_idle
		dec a
		ld  (hl), a
		jp  _eij_state_done

	._eij_state_appearing
		ld  hl, _en_an_dead_row
		add hl, bc
		ld  a, (hl)
		or  a
		jr  nz, _eij_state_still_appearing

		#ifdef PURSUERS_BASE_CELL
			ld  a, PURSUERS_BASE_CELL*2
		#else
			call _rand
			ld  a, l
			and 3
			sla a
		#endif

		ld  hl, _en_an_base_frame
		add hl, bc
		ld  (hl), a

		ld  a, 2
		ld  hl, _en_an_alive
		add hl, bc
		ld  (hl), a
		jp  _eij_state_done

	._eij_state_still_appearing
		dec a
		ld  (hl), a
		ld  hl, _en_an_next_frame
		add hl, bc
		add hl, bc
		ld  de, _sprite_17_a
		ex de, hl
		call l_pint
		jp  _eij_state_done

	._eij_state_moving
		ld  a, 1
		ld  (_active), a

		ld  hl, _en_an_rawv
		add hl, bc
		ld  a, (hl)
		ld  (_rda), a

		ld  a, (_p_estado)
		or  a
		jr  nz, _eij_state_done

	._eij_state_moving_x
		call _rand
		ld  a, l
		and 3
		jr  z, _eij_state_moving_y

		ld  a, (__en_x)
		ld  d, a
		ld  a, (_gpx)
		cp  d
		jr  z, _eij_state_moving_y

		jr  c, _eij_state_moving_x_left

	._eij_state_moving_x_right
		ld  a, (_rda)
		ld  (__en_mx), a
		jr  _eij_state_moving_x_set

	._eij_state_moving_x_left
		ld  a, (_rda)
		neg
		ld  (__en_mx), a

	._eij_state_moving_x_set
		add d
		ld  (__en_x), a

		call _mons_col_sc_x
		xor a
		or  l
		jr  z, _eij_state_moving_y

		ld  a, (__en_cx)
		ld  (__en_x), a

	._eij_state_moving_y
		call _rand
		ld  a, l
		and 3
		jr  z, _eij_state_done

		ld  a, (__en_y)
		ld  d, a
		ld  a, (_gpy)
		cp  d
		jr  z, _eij_state_done

		jr  c, _eij_state_moving_y_up

	._eij_state_moving_y_down
		ld  a, (_rda)
		ld  (__en_my), a
		jr  _eij_state_moving_y_set

	._eij_state_moving_y_up
		ld  a, (_rda)
		neg
		ld  (__en_my), a

	._eij_state_moving_y_set
		add d
		ld  (__en_y), a

		call _mons_col_sc_y
		xor a
		or  l
		jr  z, _eij_state_done

		ld  a, (__en_cy)
		ld  (__en_y), a

	._eij_state_done
#endasm
