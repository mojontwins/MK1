// custom_evil_tile_check.h
// Detect collision, modify velocities and set hit.

#asm
	// Detect attr 1 in 
	// (gpx + 2, gpy + 13) (gpx + 13, gpy + 13)
	// (gpx + 2, gpy + 15) (gpx + 13, gpy + 15)

		ld  a, (_gpx)
		ld  b, a
		add 2
		srl a
		srl a
		srl a
		srl a
		ld  (_cx1), a
		
		ld  a, b
		add 13
		srl a
		srl a
		srl a
		srl a
		ld  (_cx2), a

		ld  a, (_gpy)
		ld  b, a
		add 13
		srl a
		srl a
		srl a
		srl a
		ld  (_pty1), a

		ld  a, b
		add 15
		srl a
		srl a
		srl a
		srl a
		ld  (_pty2), a

		ld  a, (_pty1)
		ld  (_cy1), a
		ld  (_cy2), a
		call _cm_two_points

		ld  a, (_at1)
		and 1
		jr  nz, custom_hit_do

		ld  a, (_at2)
		and 1
		jr  nz, custom_hit_do

		ld  a, (_pty2)
		ld  (_cy1), a
		ld  (_cy2), a
		call _cm_two_points

		ld  a, (_at1)
		and 1
		jr  nz, custom_hit_do

		ld  a, (_at2)
		and 1
		jr  z, custom_hit_done

	.custom_hit_do
		ld  a, 1
		ld  (_hit), a

	.custom_hit_done

#endasm