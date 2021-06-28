;
; void ListAppend(LIST *list, void *item, uchar nodeQueue)
; Alvin Albrecht 02.2003
;

XLIB SPListAppend
XDEF SPListAppend2
LIB SPemptylistadd

; enter: de = LIST *
;        bc = item *
;        hl = address of new sp_ListNode container
; exit : new item appended to end of list, current points at new item
; uses : af, bc, de, hl

.SPListAppend
   ld (hl),c
   inc hl
   ld (hl),b              ; store user item into new NODE
   inc hl                 ; hl = new NODE.next
   ex de,hl               ; hl = LIST*, de = new NODE.next
   ld a,(hl)
   inc (hl)               ; increase item count
   inc hl
   jp nz, noinchi
   inc (hl)
   jp cont
.noinchi
   or (hl)                ; hl = LIST.count+1, de = new NODE.next, item count & item done
   jp z, SPemptylistadd   ; if there are no items in list jump to emptylistadd helper
.cont
   inc hl                 ; hl = LIST.state, de = new NODE.next, item count & item done
.SPListAppend2
   ld (hl),1              ; current INLIST
   inc hl
   dec de
   dec de                 ; de = new NODE
   push de                ; save new NODE
   ld (hl),d
   inc hl
   ld (hl),e              ; current = new NODE
   inc hl
   inc hl
   inc hl                 ; hl = tail
   inc de
   inc de                 ; de = new NODE.next
   xor a
   ld (de),a
   inc de
   ld (de),a              ; new NODE.next = NULL
   inc de                 ; de = new NODE.prev
   ldi
   ldi                    ; new NODE.prev = tail
   dec hl
   ld e,(hl)
   dec hl                 ; hl = tail
   ld d,(hl)              ; de = old tail NODE
   pop bc                 ; bc = new NODE
   ld (hl),b
   inc hl
   ld (hl),c              ; tail = new NODE
   ex de,hl               ; hl = old tail NODE
   inc hl
   inc hl                 ; hl = old tail NODE.next
   ld (hl),b
   inc hl
   ld (hl),c              ; old tail NODE.next = new NODE
   ret
