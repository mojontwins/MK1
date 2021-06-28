;
; Dynamic Block Memory Allocator
; Alvin Albrecht 2002
; Fixed 08.2003
;
; Comprised of:
;   InitAlloc, AddMemory, BlockFit, BlockAlloc, FreeBlock
;
; Symbol "NUMQUEUES", indicating number of memory queues,
; needs to be defined externally prior to compilation.
;


XLIB SPAddMemory
LIB SPFreeBlock
XREF SPfb1, SPfb2
defw SPFreeBlock

; AddMemory
;
; Enter:  A     = Queue #
;         B     = # of memory blocks to add to queue A
;         DE    = size of memory blocks in bytes (not including hidden ID byte)
;         HL    = address of free memory from which to draw these blocks
; Exit :  HL    = address just past the memory reserved
; Uses :  F, B, HL, BC', HL', DE' 

.SPAddMemory
   push af
   push hl
   exx
   pop de
   ld (de),a
   call SPfb1

.ib1
   exx
   inc hl
   add hl,de
   pop af
   djnz ib2
   ret

.ib2
   push af
   push hl
   exx
   pop hl
   ex de,hl
   ld (de),a
   inc de
   call SPfb2
   jp ib1
