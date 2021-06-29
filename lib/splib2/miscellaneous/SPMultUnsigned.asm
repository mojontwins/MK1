
; Fast Unsigned Multiply
; Thanks to Nick Fleming for the code.

;	Routine :		fast_unsigned_multiply (unsigned)
;
;	Before calling		: bc = number to multiply
;				  de = number to multiply
;
;	after calling		: de = high word of result
;				  hl = low word of result
;
;	registers changed	: bc, de, hl, a, flags.
;
;	 Notes:
;	--------
;	Does the sum de,hl = bc * de
;	Based on the excellent multiply routines
;	found in Rodney Zaks "Programming the z80" (Sybex)

XLIB SPMultUnsigned

.SPMultUnsigned
   ld hl,0
   ld a,16
.fumult
   add hl,hl
   rl e
   rl d
   jp nc, fum_noadd
   add hl,bc
.fum_noadd
   dec a
   jp nz,fumult
   ret
