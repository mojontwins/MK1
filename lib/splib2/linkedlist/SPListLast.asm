;
; void *ListLast(LIST *list)
; Alvin Albrecht 02.2003
;

XLIB SPListLast

; enter: hl = LIST *
; exit : no carry = list empty
;        de = item at end of list
;        current pointer changed to point at last item in list
; uses : af, bc, de, hl

.SPListLast
   ld a,(hl)
   inc hl
   or (hl)
   ret z               ; nothing in list
   inc hl
   ld (hl),1           ; current will be INLIST
   inc hl
   ld e,l
   ld d,h              ; de points at current
   ld bc,4
   add hl,de           ; hl points at tail
   ldi
   ldi                 ; copy tail to current
   dec hl
   ld e,(hl)
   dec hl
   ld d,(hl)           ; de = NODE stored at tail of list
   ex de,hl
   ld e,(hl)
   inc hl
   ld d,(hl)           ; de = user's item
   scf
   ret
