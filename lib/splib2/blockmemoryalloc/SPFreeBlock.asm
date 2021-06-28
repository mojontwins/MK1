;
; Dynamic Block Memory Allocator
; Alvin Albrecht 2002
;
; Comprised of:
;   InitAlloc, AddMemory, BlockFit, BlockAlloc, FreeBlock
;
; Symbol "NUMQUEUES", indicating number of memory queues,
; needs to be defined externally prior to compilation.
;


XLIB SPFreeBlock
LIB SPqueuetable
XDEF SPfb1, SPfb2

; FreeBlock
;
; Enter:  DE    = address of a block, as returned by BlockAlloc
; Exit :  none
; Time :  129
; Uses :  AF, BC, HL, DE
;
; Returns the memory block to the correct queue for use later.

.SPFreeBlock
   ld a,d
   or e
   ret z
   dec de
   ld a,(de)

.SPfb1
   inc de
   add a,a
   add a,SPqueuetable % 256
   ld l,a
   ld h,SPqueuetable / 256
   jp nc, SPfb2
   inc h

.SPfb2
   ld c,(hl)
   inc hl
   ld b,(hl)
   ld (hl),d
   dec hl
   ld (hl),e
   ex de,hl
   ld (hl),c
   inc hl
   ld (hl),b
   ret
