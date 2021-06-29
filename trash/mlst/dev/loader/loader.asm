; loader.asm
; loads the loader
; by na_th_an - Thanks to Antonio Villena for his tutorials and utilities.

	org $5ccb
	ld  sp, 23999
	di
	db	$de, $c0, $37, $0e, $8f, $39, $96 ;OVER USR 7 ($5ccb)
	
	call blackout

; load screen
	scf
	ld	a, $ff
	ld	ix, $4000
	ld	de, 6912
	call $0556
	di

; RAM1
	ld	a, $11 		; ROM 1, RAM 1
	ld	bc, $7ffd
	out (C), a

	scf
	ld	a, $ff
	ld	ix, $C000
	ld	de, 2968
	call $0556
	di

; RAM3
	ld	a, $13 		; ROM 1, RAM 3
	ld	bc, $7ffd
	out (C), a

	scf
	ld	a, $ff
	ld	ix, $C000
	ld	de, 5809
	call $0556
	di

; Main binary
	ld	a, $10 		; ROM 1, RAM 0
	ld	bc, $7ffd
	out (C), a

	scf
	ld	a, $ff
	ld	ix, 24000
	ld	de, 21360
	call $0556
	di
	
; run game!
	jp 24000

blackout:
	; screen 0
		ld  bc, 767
		ld	hl, $5800
		ld	de, $5801
		ld	(hl), l
		ldir
		ret
		
