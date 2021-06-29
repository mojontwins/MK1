;
; IM2 Interrupt Initialization
; Alvin Albrecht 01.2003
;

INCLUDE "SPconfig.def"
XLIB SPInitIM2

; Init IM2
;
; Creates an interrupt vector table with all vectors initialized to jump to
; a default interrupt service routine.  The interrupt vector table is placed
; at address "IM2TABLE" and is either 256 bytes long if "EVENVECTORS" is 1 or
; 257 bytes long if "EVENVECTORS" is 0.  The latter option is made available
; for machines where peripherals may put an odd vector on the bus, against
; Zilog's recommended im2 scheme.
;
; Selects IM2.  Interrupts should be disabled prior to calling.
;
; enter:  bc = address of default interrupt handler

.SPInitIM2
   ld hl,IM2TABLE
   ld e,l
   ld d,h
   ld (hl),c
   inc hl
   ld (hl),b
   inc hl
   ex de,hl
   ld bc,255-EVENVECTORS
   ldir

   ld a,IM2TABLE/256
   ld i,a
   im 2
   ret
