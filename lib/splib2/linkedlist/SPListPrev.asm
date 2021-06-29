;
; void *ListPrev(LIST *list)
; Alvin Albrecht 02.2003
;

XLIB SPListPrev

; enter: hl = LIST *
; exit : no carry = list empty or current pointer is before start of list
;        de = prev item before current in list
;        current pointer changed to point at prev item in list
; uses : af, bc, de, hl

.SPListPrev
   ld a,(hl)
   inc hl
   or (hl)
   ret z                  ; fail if no items in list
   inc hl                 ; hl = state
   ld a,(hl)              ; 0 = BEFORE, 1 = INLIST, 2 = AFTER
   or a
   ret z                  ; return failure if current is BEFORE start of list
   dec a
   jr nz, currafter       ; if current pointer is past end of list

   ; current pointer INLIST

   inc hl
   ld d,(hl)
   inc hl                 ; hl = current + 1
   ld e,(hl)              ; de = NODE for current ptr
   inc de
   inc de
   inc de
   inc de                 ; de = NODE.prev
   ld a,(de)              ; if NODE->prev == NULL, moving past start of list
   or a
   jr z, movedpaststart
   ld b,a
   inc de
   ld a,(de)
   ld e,a
   ld d,b                 ; de = NODE->prev
   ld (hl),e
   dec hl
   ld (hl),d              ; current ptr = prev NODE
   ex de,hl               ; hl = prev NODE
   ld e,(hl)
   inc hl
   ld d,(hl)              ; de = list item
   scf
   ret
.movedpaststart           ; hl = current+1, de = current NODE.prev
   ld (hl),0
   dec hl
   ld (hl),0              ; mark current pointing at nothing
   dec hl
   ld (hl),0              ; mark current pointing before start of list
   ret                    ; carry flag reset indicates failure

   ; current ptr AFTER end of list

.currafter                ; hl = state
   ld (hl),1              ; mark current as INLIST
   inc hl
   ld e,l
   ld d,h                 ; de = current
   inc hl
   inc hl
   inc hl
   inc hl                 ; hl = tail
   ldi
   ldi                    ; copy tail into current
   dec hl                 ; hl = tail+1
   ld e,(hl)
   dec hl
   ld d,(hl)
   ex de,hl               ; hl = tail's NODE
   ld e,(hl)
   inc hl
   ld d,(hl)              ; de = list item
   scf
   ret
