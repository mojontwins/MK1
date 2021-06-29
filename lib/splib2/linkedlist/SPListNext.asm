;
; void *ListNext(LIST *list)
; Alvin Albrecht 02.2003
;

XLIB SPListNext

; enter: hl = LIST *
; exit : no carry = list empty or current pointer is past end of list
;        de = next item after current in list
;        current pointer changed to point at next item in list
; uses : af, bc, de, hl

.SPListNext
   ld a,(hl)
   inc hl
   or (hl)
   ret z                  ; fail if no items in list
   inc hl                 ; hl = state
   ld a,(hl)              ; 0 = BEFORE, 1 = INLIST, 2 = AFTER
   or a
   jr z, currbefore
   dec a
   ret nz                 ; return failure if current is AFTER end of list

   ; current pointer INLIST

   inc hl
   ld d,(hl)
   inc hl                 ; hl = current + 1
   ld e,(hl)              ; de = NODE for current ptr
   inc de
   inc de                 ; de = NODE.next
   ld a,(de)              ; if NODE->next == NULL, moving past end of list
   or a
   jr z, movedpastend
   ld b,a
   inc de
   ld a,(de)
   ld e,a
   ld d,b                 ; de = NODE->next
   ld (hl),e
   dec hl
   ld (hl),d              ; current ptr = next NODE
   ex de,hl               ; hl = next NODE
   ld e,(hl)
   inc hl
   ld d,(hl)              ; de = list item
   scf
   ret
.movedpastend             ; hl = current+1, de = current NODE.next
   ld (hl),0
   dec hl
   ld (hl),0              ; mark current pointing at nothing
   dec hl
   ld (hl),2              ; mark current pointing after end of list
   ret                    ; carry flag reset indicates failure

   ; current ptr BEFORE start of list

.currbefore               ; hl = state
   ld (hl),1              ; mark current as INLIST
   inc hl
   ld e,l
   ld d,h                 ; de = current
   inc hl
   inc hl                 ; hl = head
   ldi
   ldi                    ; copy head into current
   ex de,hl               ; hl = head
   ld d,(hl)
   inc hl
   ld e,(hl)
   ex de,hl               ; hl = head's NODE
   ld e,(hl)
   inc hl
   ld d,(hl)              ; de = list item
   scf
   ret
