;
; Install ISR
; Alvin Albrecht 01.2003
;

INCLUDE "SPconfig.def"
XLIB SPInstallISR

; Simply stores ISR address into interrupt vector table.
;
; INTERRUPTS SHOULD BE DISABLED PRIOR TO CALLING!
;
; enter:  l = vector to install on (even, 0..254)
;        de = new ISR address
; exit : de = old ISR address
; used : af, de, h

.SPInstallISR
   ld h,IM2TABLE/256
   ld a,(hl)
   ld (hl),e
   ld e,a
   inc hl
   ld a,(hl)
   ld (hl),d
   ld d,a
   dec l
   ret
