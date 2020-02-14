// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// WYZ player hook functions

// WYZ player and songs are loaded into RAM 1 ($C000).
// In each interrupt, we just page in RAM 1, call the player,
// then page back RAM 0 and exit.

// The player is, thus, compiled to $C000, and its addresses
// are:

#define WYZPLAYERINIT		0xC018	// INIT_BUFFERS		EQU 0C018H
#define WYZPLAYERISR		0xC000	// INICIO			EQU 0C000H
#define INICIAEFECTO		0xC47E	// INICIA_EFECTO	EQU 0C46BH
#define CARGA_CANCION		0xC087	// CARGA_CANCION	EQU 0C087H
#define SILENCIA_PLAYER		0xC062	// PLAYER_OFF		EQU 0C062H

// Start.

// isr
#asm
	defw 0	// 2 bytes libres
#endasm

void ISR(void) {	
	#asm
		ld b, 1
		call SetRAMBank
		call WYZPLAYERISR
		ld b, 0
		call SetRAMBank			
	#endasm
}

void wyz_init (void) {
	#asm
		ld b,1
		call SetRAMBank
		call WYZPLAYERINIT	
		ld b,0
		call SetRAMBank
	#endasm
}

void __FASTCALL__ wyz_play_sound (unsigned char fx_number) {
	#asm
		di
		ld b, 1
		call SetRAMBank
		; __FASTCALL__ -> fx_number is in l!
		ld b, l
		call INICIAEFECTO
		ld b, 0
		call SetRAMBank
		ei
	#endasm
}

void __FASTCALL__ wyz_play_music (unsigned char song_number) {
	#asm
		di
		ld b, 1
		call SetRAMBank
		; __FASTCALL__ -> song_number is in l!
		ld a, l
		call CARGA_CANCION
		ld b, 0
		call SetRAMBank
		ei
	#endasm
	song_playing = song_number;
}

void wyz_stop_sound (void) {
	#asm
		di
		ld b,1
		call SetRAMBank
		call SILENCIA_PLAYER
		ld b,0
		call SetRAMBank
		ei
	#endasm
}
