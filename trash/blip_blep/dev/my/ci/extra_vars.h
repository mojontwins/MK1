// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Commands for the automatic room embellisher

/*
	Each item is { t C p s }

	- t = tile to substitute
	- C = command:
			00000 - substitute if equal
			--010 - substitute if above is equal to
			--011 - substitute if above is different to
			--110 - substitute if below is equal to
			--111 - substitute if below is different to
			01--0 - substitute if left is equal to
			01--1 - substitute if left is different to
			11--0 - substitute if right is equal to
			11--1 - substitute if right is different to

			Command is C_EQ|C_NEQ [OR C_UP|C_DOWN] [OR C_LEFT|C_RIGHT]
	- p = parameter to compare (commands >= 2)
	- s = substitute by, s + (rand () & (s >> 6))

	Terminate with 0xff
*/

#define C_EQ 	0
#define C_NEQ 	1
#define C_UP 	2
#define C_DOWN  6
#define C_LEFT  8
#define C_RIGHT 24

const unsigned char embellishments [] = {
	 1, C_NEQ|C_DOWN ,  1,  3,			// 1 -> 3 if b != 1
	 1, C_EQ         ,  0,  1 | 0x40,	// 1 -> 1 + rand () & 1
	 5, C_NEQ|C_UP   ,  5,  4,			// 5 -> 4 if a != 5
	 5, C_NEQ|C_DOWN ,  5,  6, 			// 5 -> 6 if b != 5
	10, C_NEQ|C_DOWN , 10, 11, 			// 10 -> 11 if b != 10
	29, C_NEQ|C_UP   , 29, 28,			// 29 -> 18 if a != 29
	0xff
};

// Custom backdrop

const unsigned char backdrop [] = {
	00, 00, 33, 35, 00, 33, 34, 35, 33, 35, 33, 35, 00, 33, 34,
	00, 33, 35, 00, 33, 34, 35, 33, 35, 33, 35, 00, 33, 34, 35,
	36, 38, 00, 33, 34, 35, 33, 35, 33, 35, 00, 33, 34, 35, 00,
	00, 00, 33, 34, 35, 33, 35, 33, 35, 00, 33, 34, 35, 00, 33,
	00, 33, 34, 35, 33, 35, 36, 38, 00, 33, 34, 35, 00, 33, 35,
	33, 34, 35, 36, 38, 00, 00, 00, 33, 34, 35, 00, 33, 35, 00,
	37, 38, 00, 00, 00, 00, 00, 33, 34, 35, 00, 36, 38, 00, 33,
	00, 00, 00, 00, 00, 00, 36, 37, 38, 00, 00, 00, 00, 33, 35,
	00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 36, 38, 00,
	00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
};

// Custom vEng

unsigned char fire_pressed;
signed int p_thrust;

#define P_THRUST_ADD 			16
#define P_THRUST_MAX 			384
#define P_BREAK_VELOCITY_OFFSET 128
#define P_WATER_FRICTION		16

// Add the explosion manually

extern unsigned char sprite_17_a []; 
#asm
        defb 0, 255
        defb 0, 255
        defb 0, 255
        defb 0, 255
        defb 0, 255
        defb 0, 255
        defb 0, 255
        defb 0, 255
    ._sprite_17_a
        BINARY "sprites_extra.bin"
#endasm
