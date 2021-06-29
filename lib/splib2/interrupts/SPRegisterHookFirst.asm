;
; Register hook at front of list
; Alvin Albrecht 01.2003
;

INCLUDE "SPconfig.def"

XLIB SPRegisterHookFirst
LIB SPCreateGenericISR
XREF GENERICLISTDISP
defw SPCreateGenericISR

; For use with the Generic ISR.  Installs a hook at the front of
; the list of registered hooks.
;
; INTERRUPTS MUST BE DISABLED BEFORE CALLING!
;
; *** Hooks must have two free bytes available just
;     before the start of the subroutine.
;
; enter: de = address of hook
;         l = interrupt vector
; used : bc, de ,hl

.SPRegisterHookFirst
   ld h,IM2TABLE/256
   ld c,(hl)
   inc hl
   ld b,(hl)
   ld hl,GENERICLISTDISP
   add hl,bc            ; hl is address of hook list for this ISR
   ld c,(hl)
   inc hl
   ld b,(hl)            ; bc = first hook
   dec de
   dec de
   ld (hl),d
   dec hl
   ld (hl),e            ; store new hook as first one
   ex de,hl
   ld (hl),c
   inc hl
   ld (hl),b            ; hook after new one is former first hook
   ret
