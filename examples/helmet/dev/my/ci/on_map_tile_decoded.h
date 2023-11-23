// A map tile has been decoded. Substitute it?
// Map tile is in A. Do it in assembly, sorry

#asm
		// If level 2 and A = 4,
		ld  c, a

		ld  a, (_level)
		cp  2
		jr  nz, tile_subst_done

		ld  a, c
		cp  4
		jr  nz, tile_subst_done

		// Look tile above
		ld  a, (_gpit)
		cp  15
		jr  c, tile_subst_done

		sub 15
		ld  d, 0
		ld  e, a

		push hl
		ld  hl, _map_buff
		add hl, de
		ld  a, (hl)
		pop hl

		cp  a, 4 
		jr  z, tile_subst_done

		cp  a, 31
		jr  z, tile_subst_done

		// Set tile 31
		ld  c, 31

	.tile_subst_done
		ld  a, c
#endasm