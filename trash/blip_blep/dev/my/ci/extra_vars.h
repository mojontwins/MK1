// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Commands for the automatic room embellisher

/*
	Each item is { t C p s }

	- t = tile to substitute
	- C = command:
			0 - 000 - substitute if equal
			2 - 010 - substitute if above is equal to
			3 - 011 - substitute if above is different to
			6 - 110 - substitute if below is equal to
			7 - 111 - substitute if below is different to
	- p = parameter to compare (commands >= 2)
	- s = substitute by, s + (rand () & (s >> 6))

	Terminate with 0xff
*/

#define C_IEQ 0
#define C_AEQ 2
#define C_ANE 3
#define C_BEQ 6
#define C_BNE 7

const unsigned char embellishments [] = {
	1, C_BNE, 1, 3,			// 1 -> 3 if b != 1
	1, C_IEQ, 0, 0x41, 		// 1 -> 1 + rand () & 1
	5, C_ANE, 5, 4,			// 5 -> 4 if a != 5
	5, C_BNE, 5, 6, 		// 5 -> 6 if b != 5
	10, C_BNE, 10, 11, 		// 10 -> 11 if b != 10
	29, C_ANE, 29, 28,		// 0 -> 29 if a == 28
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
#define P_BREAK_VELOCITY_OFFSET 192
#define P_WATER_FRICTION		16
