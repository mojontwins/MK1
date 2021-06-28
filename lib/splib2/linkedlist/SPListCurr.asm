;
; void *ListCurr(LIST *list)
; Alvin Albrecht 02.2003
;

XLIB SPListCurr

; enter: hl = LIST *
; exit : no carry = list empty or current points outside list
;        de = current item in list
; uses : af, de, hl

.SPListCurr
   ld a,(hl)
   inc hl
   or (hl)
   ret z               ; nothing in list
   inc hl
   ld a,(hl)           ; state of current pointer 0=BEFORE, 1=INLIST, 2=AFTER
   dec a
   ret nz              ; if not INLIST, not pointing at an item, nc=failure
   inc hl
   ld d,(hl)
   inc hl
   ld e,(hl)           ; de = current's NODE
   ex de,hl
   ld e,(hl)
   inc hl
   ld d,(hl)           ; de = current NODE's item
   scf
   ret
