// MT Engine MK2
// Copyleft 2014 the Mojon Twins

// arkosplayer.h
// Arkos Player hook functions

// This code is based on the original integration by Syx & Nightwolf
// In fact, this code IS the original integration by Syx & Nightwolf.
// I just changed the way params are passed (thanks @reidrac)
// I just automated the process & reindented to meet my own personal taste.

#include "sound\arkos-addresses.h"

// Start.

// isr
#asm
	defw 0
#endasm

void ISR(void) {	
	#asm
		ld b, 1
		call SetRAMBank
		call ATPLAY
		ld b, 0
		call SetRAMBank			

			ld  hl, _isrc
			inc (hl)
	#endasm
}

void arkos_stop (void) {
	#asm
		ld b, 1
		call SetRAMBank
		ld a, 201
		ld (ATPLAY),A
		ld b, 0
		call SetRAMBank
	#endasm
}

void __FASTCALL__ arkos_play_sound (unsigned char fx_number) {
	#asm
		di
		ld b,1
		call SetRAMBank
		
		; __FASTCALL__ -> fx_number is in l!
		ld a, ARKOS_SFX_CHANNEL
		ld h, 15
		ld e, 50
		ld d, 0
		ld bc, 0
		call ATSFXPLAY
		
		ld b,0
		call SetRAMBank
		ei
	#endasm
}

void __FASTCALL__ arkos_play_music (unsigned char song_number) {
	#asm
		di
		ld b, 1
		call SetRAMBank
		
		; Reactivate sound generation
		ld a, 175
		ld (ATPLAY),A
		
		; Initialize song
		; __FASTCALL__ -> song_number is in l!
		ld a, l
		add a, a
		ld hl, SONG_LIST
		add a,l
		jr nc, salta_inc_song
		inc h
	salta_inc_song:
		ld l,a
		ld e, (hl)
		inc hl
		ld d, (hl)
		
		call ATINIT
		
		ld de, SFXS_SONG
		call ATSFXINIT
		
		ld b, 0
		call SetRAMBank
		ei
	#endasm
}

void arkos_stop_sound (void)
{
	#asm
		di
		ld b,1
		call SetRAMBank
		
		call ATSFXSTOPALL
		call ATSTOP
		
		; Turn off sound generation
		ld a,201
		ld (ATPLAY),A
		
		ld b,0
		call SetRAMBank
		ei
	#endasm
}
