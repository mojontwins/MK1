;
; void *ListFirst(LIST *list)
; Alvin Albrecht 02.2003
;

XLIB SPListFirst

; enter: hl = LIST *
; exit : no carry = list empty
;        de = item at start of list
;        current pointer changed to point at first item in list
; uses : af, bc, de, hl

.SPListFirst
   ld a,(hl)
   inc hl
   or (hl)
   ret z               ; nothing in list
   inc hl
   ld (hl),1           ; current will be INLIST
   inc hl
   ld e,l
   ld d,h              ; de points at current
   inc hl
   inc hl              ; hl points at head
   ldi
   ldi                 ; copy head to current
   dec hl
   ld e,(hl)
   dec hl
   ld d,(hl)           ; de = NODE stored at head of list
   ex de,hl
   ld e,(hl)
   inc hl
   ld d,(hl)           ; de = user's item
   scf
   ret
