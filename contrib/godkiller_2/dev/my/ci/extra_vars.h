// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// extra_vars.h	

extern unsigned char *textos_hotspots [0]; 

#asm
	.texto0 defm "VOLUNTAD_DE_CRONOS", 0
	.texto1 defm "___RUNAS_DE_DIS___", 0
	.texto2 defm "___FUEGO_ESTIGIO__", 0

	._textos_hotspots 
		defw texto0, texto1, texto2
#endasm

const unsigned char warp_from_x [] =    {  6,  7,  3 };
const unsigned char warp_from_y [] =    {  3,  5,  5 };
const unsigned char warp_to_n_pant [] = { 10, 35,  3 };
const unsigned char warp_to_x [] =      {  6,  7, 10 };
const unsigned char warp_to_y [] =      {  7,  2,  4 };
