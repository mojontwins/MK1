;
; Remove hook
; Alvin Albrecht 01.2003
;

INCLUDE "SPconfig.def"

XLIB SPRemoveHook
LIB SPCreateGenericISR
XREF GENERICLISTDISP
defw SPCreateGenericISR

; For use with the Generic ISR.
; Removes a hook from the ISR's list of hooks.
;
; INTERRUPTS MUST BE DISABLED BEFORE CALLING!
;
; enter: bc = address of hook
;         l = interrupt vector
; exit : Carry flag reset if hook not found
; used : af, bc, de ,hl

.SPRemoveHook
   ld h,IM2TABLE/256
   ld e,(hl)
   inc hl
   ld d,(hl)
   ld hl,GENERICLISTDISP
   add hl,de             ; hl = address of hook list
   dec bc
   dec bc

.loop
   ld e,(hl)
   inc hl
   ld d,(hl)             ; de = next hook
   ld a,d
   or e
   ret z                 ; reached end without finding hook to remove
   ld a,d
   cp b
   jr nz, nomatch
   ld a,e
   cp c
   jr z, match

.nomatch
   ex de,hl
   jp loop

.match                   ; hl points at hook to remove + 1
   dec hl
   ld a,(bc)
   ld (hl),a
   inc bc
   inc hl
   ld a,(bc)
   ld (hl),a
   scf                   ; successful removal
   ret
