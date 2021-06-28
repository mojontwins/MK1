;
; Create Generic ISR
; Alvin Albrecht 01.2003
;
; For installing a generic interrupt service routine on a particular
; im 2 vector:  Call "CreateGenericISR" to copy the routine to a
; particular memory address.  The size of the routine is available in
; "GENERICISRSIZE".  Then place the address of the new GenericISR
; into the interrupt vector table with a call to "InstallISR".
;
; The generic ISR allows multiple hooks to be installed on a particular
; vector.  It calls each installed hook one after the other.  If any
; hook sets the carry flag prior to returning, the ISR terminates
; without calling further hooks down the chain.


XLIB SPCreateGenericISR
XDEF GENERICISRSIZE, GENERICLISTDISP

; Create Generic ISR
;
; Copies the generic ISR routine to a new location pointed at in 'DE'.
; This location should be stored in the interrupt vector table for the
; corresponding vector.  A new copy is necessary so that the generic
; ISR has its own private hook list.
;
; enter: de = address to place ISR
; exit : de = address just past ISR
; uses : bc, de, hl

.SPCreateGenericISR
   ld hl,GenericISR
   ld bc,GENERICISRSIZE
   ldir
   ret

.GenericISR
   call pushreg
.position
   ld hl,0
   call runhooks
   jp popreg

.pushreg
   ex (sp),hl
   push af
   push bc
   push de
   exx
   ex af,af'
   push af
   push bc
   push de
   push hl
   push ix
   push iy
   exx
.JPHL
   jp (hl)

.runhooks
   ld a,h
   or l
   ret z
   push hl
   inc hl
   inc hl
   call JPHL
   pop hl
   ret c
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   jp runhooks

.popreg
   pop iy
   pop ix
   pop hl
   pop de
   pop bc
   pop af
   exx
   ex af,af'
   pop de
   pop bc
   pop af
   pop hl
   ei
   reti

DEFC GENERICISRSIZE = pushreg - GenericISR
DEFC GENERICLISTDISP = position - GenericISR + 1
