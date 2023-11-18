// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Extrasprites.h
// Contiene sprites extra para el modo de matar enemigos de la churrera
// Sólo se incluirá (tras los sprites) si se define PLAYER_STEPS_ON_ENEMIES
// Copyleft 2010 The Mojon Twins

// Frames extra por si se pueden eliminar los enemigos:

#if defined(PLAYER_CAN_FIRE) || defined(PLAYER_STEPS_ON_ENEMIES) || defined(ENABLE_PURSUERS) || defined (MODE_128K)
	extern unsigned char sprite_17_a []; 
#endif

extern unsigned char sprite_18_a []; 

#if defined(PLAYER_CAN_FIRE) || defined (MODE_128K)
	extern unsigned char sprite_19_a [];
	extern unsigned char sprite_19_b [];
#endif

#if defined(PLAYER_CAN_FIRE) || defined(PLAYER_STEPS_ON_ENEMIES) || defined(ENABLE_PURSUERS) || defined (MODE_128K)
	#asm
	    ._sprite_17_a
	        BINARY "sprites_extra.bin"
	#endasm
#endif

#asm
	._sprite_18_a
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
		
	._sprite_18_b
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
		
	._sprite_18_c
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
		defb 0, 255, 0, 255, 0, 255, 0, 255
#endasm

#if defined(PLAYER_CAN_FIRE) || defined (MODE_128K)
	#asm	              	
		._sprite_19_a
			BINARY "sprites_bullet.bin"
	#endasm
#endif
