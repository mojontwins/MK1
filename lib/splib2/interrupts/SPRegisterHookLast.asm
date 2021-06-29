;
; Register hook at end of list
; Alvin Albrecht 01.2003
;

INCLUDE "SPconfig.def"

XLIB SPRegisterHookLast
XDEF SPRegisterHook
LIB SPCreateGenericISR
XREF GENERICLISTDISP
defw SPCreateGenericISR

; For use with the Generic ISR.  Installs a hook at the end of
; the list of registered hooks.
;
; INTERRUPTS MUST BE DISABLED BEFORE CALLING!
;
; *** Hooks must have two free bytes available just
;     before the start of the subroutine.
;
; enter: bc = address of hook
;         l = interrupt vector
; used : bc, de ,hl

.SPRegisterHook
.SPRegisterHookLast
   ld h,IM2TABLE/256
   ld e,(hl)
   inc hl
   ld d,(hl)
   ld hl,GENERICLISTDISP
   add hl,de            ; hl = address of hook list

.loop
   ld e,(hl)
   inc hl
   ld d,(hl)            ; get address of next hook
   ld a,d
   or e
   jr z, done           ; if it's zero, we've found the end of the list
   ex de,hl             ; otherwise keep going
   jp loop

.done
   xor a
   dec bc
   ld (bc),a
   dec bc
   ld (bc),a            ; mark end of list in new hook
   ld (hl),b
   dec hl
   ld (hl),c            ; store new hook at end of list
   ret
