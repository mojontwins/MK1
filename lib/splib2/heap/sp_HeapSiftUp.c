
/*
 *      Sprite Pack V2.1
 *      Alvin Albrecht 03.2003
 */

#include "spritepack.h"

void sp_HeapSiftUp(uint start, void **array, void *compare)
{
   uint p;

   while ((start!=1) && (compare(array[start], array[p=start/2]))) {
      sp_Swap(array+start, array+p, sizeof(void *));
      start = p;
   }
}

/*

If I decide to move to assembler...

; Siftup on Heap
; Alvin Albrecht 03.2003
;
;
; The heap is an array of pointers 'void *array[N]' and is indexed by 1..N.
; 'array[0]' is unused.
;
; enter:  bc = start index * 2 (the offset on array)
;         de = array
;         ix = address of compare function
;
; uses :  af, bc, hl

XLIB SPHeapSiftUp
LIB SPSwap

.SPHeapSiftUp
   ld a,c
   and $fc
   or b
   ret z           ; if start<=2 we've reached root so return

   push ix         ; save compare
   push bc         ; save index
   push de         ; save array
   ld l,c
   ld h,b
   add hl,de
   ex de,hl        ; hl = index, de = &array[index]
   srl h
   rr l
   add hl,bc       ; hl = &array[parent(index)]

   push hl
   push de
   push hl
   push de
   call JPIX       ; compare(&array[parent(index)], &array[index])
   pop de
   pop hl
   pop de          ; de = &array[index]
   pop hl          ; hl = &array[parent]
   jr nc, done     ; if no swap required we're done

   ld bc,2
   call SPSwap
   pop de
   pop bc
   pop ix
   srl b           ; move up to parent
   rr c
   jp SPHeapSiftUp

.done
   pop de
   pop bc
   pop ix
   ret

.JPIX
   jp (ix)
*/
