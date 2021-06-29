;
; void ListFree(LIST *list, void (*itemfree)(void *item))
; Alvin Albrecht 02.2003
;

XLIB SPListFree
XREF _u_free

; enter: hl = LIST *
;        bc = itemfree
; exit : The entire list is deleted.
;        Itemfree is called once for each item in the list with
;          de = item (and item on stack).
; uses : af, bc, de, hl

.SPListFree
   push hl               ; save list
   ld de,5
   add hl,de             ; hl = head

.while
   ld a,(hl)
   or a
   jr z, done
   inc hl
   ld l,(hl)
   ld h,a                ; hl = next NODE
   ld e,(hl)
   inc hl                ; hl = NODE.item+1
   ld d,(hl)             ; de = item
   push hl
   push bc
   push hl
   push de               ; push for C interface
   ld l,c
   ld h,b                ; hl = itemfree function
   ld a,h
   or l
   call nz, JPHL
   pop de
   pop de                ; de = NODE.item+1
   dec de
   push de
   ld hl,(_u_free)
   call JPHL             ; free node container
   pop de
   pop bc
   pop hl
   inc hl
   jp while

.done
   pop de                ; de = list
   ld hl,(_u_free)
   push de
   call JPHL             ; free list container
   pop de
   ret

.JPHL
   jp (hl)
