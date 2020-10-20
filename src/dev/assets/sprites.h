// MTE MK1 (la Churrera) v6
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Sprites.h
// Generado por SprCnv3 de la Churrera
// Copyleft 2020 The Mojon Twins

extern unsigned char sprites_player [0];
#asm
		defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	._sprites_player
		BINARY "../bin/sprites_player.bin"
#endasm

#define SPR_CELL_PLAYER_SIZE    144
#define SPR_COLUMN_PLAYER_SIZE  48

extern unsigned char *player_cells [0];
#asm
	._player_cells
		defw _sprites_player + 0x0000, _sprites_player + 0x0090, _sprites_player + 0x0120, _sprites_player + 0x01B0
		defw _sprites_player + 0x0240, _sprites_player + 0x02D0, _sprites_player + 0x0360, _sprites_player + 0x03F0
#endasm

extern unsigned char sprites_enems [0];
#asm
		defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	._sprites_enems
		BINARY "../bin/sprites_enems.bin"
#endasm

#define SPR_CELL_ENEMS_SIZE    144
#define SPR_COLUMN_ENEMS_SIZE  48

extern unsigned char *enem_cells [0];
#asm
	._enem_cells
		defw _sprites_enems + 0x0000, _sprites_enems + 0x0090, _sprites_enems + 0x0120, _sprites_enems + 0x01B0
		defw _sprites_enems + 0x0240, _sprites_enems + 0x02D0, _sprites_enems + 0x0360, _sprites_enems + 0x03F0
#endasm

