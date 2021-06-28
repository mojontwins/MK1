;
; void *ListSearch(LIST *list, int (*match)(void *item1, void *item2), void *item1)
; Alvin Albrecht 02.2003
;

XLIB SPListSearch
LIB SPListCurr, SPListNext

; enter: hl = list
;        de = item1
;        bc = match
; exit : no carry = item not found, current points past end of list
;        de = item found
;        current points at found item
;
;        Searches list of items from current item, calling user function "match"
;        on each of them.  If match returns with carry set the search stops.
; uses : af, bc, de, hl

.SPListSearch
   push hl            ; save list
   push bc            ; save match
   push de            ; save item1
   call SPListCurr

.loop
   jr nc, fail        ; de = next item to examine
   pop bc             ; bc = item1
   pop hl             ; hl = match
   push hl            ; save match
   push bc            ; save item1

   push bc            ; pushes for C interface
   push de
   call JPHL          ; call "match"
   pop de
   pop bc
   jr c, matched      ; match returns carry to stop iteration

   ld hl,4
   add hl,sp
   ld e,(hl)
   inc hl
   ld d,(hl)
   ex de,hl           ; hl = list
   call SPListNext
   jp loop

.fail
   ld hl,6
   add hl,sp
   ld sp,hl           ; clear off stack
   or a
   ret                ; no carry = fail

.matched
   ld hl,6
   add hl,sp
   ld sp,hl
   scf
   ret

.JPHL
   jp (hl)
