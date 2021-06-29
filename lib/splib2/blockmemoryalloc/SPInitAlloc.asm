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

INCLUDE "SPconfig.def"

XLIB SPInitAlloc
LIB SPqueuetable

; InitAlloc
;
; Clears allocator queues, starting from scratch.  Since 
; z80asm initializes DEFS spaces to zero it is not necessary
; to call this function prior to using the allocator.

.SPInitAlloc
   ld hl,SPqueuetable
   ld de,SPqueuetable+1
   ld bc,NUMQUEUES*2 - 1
   ld (hl),0
   ldir
   ret
