// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

	// Include this code after `enem_type_lineal.h` so they move!
	
	if (ORTHOSHOOTERS_FREQ == 1) {
		rda = en_an_state [enit];
		#asm
			ld  a, (_rda)
			rlca
			rlca
			and 3							// Short for >> 6, unsigned
		#endasm
		simple_coco_shoot ();
	} 
