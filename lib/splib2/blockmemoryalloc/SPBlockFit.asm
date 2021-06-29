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


XLIB SPBlockFit
LIB SPqueuetable, SPBlockAlloc
XREF SPalloc
defw SPBlockAlloc

; BlockFit
;
; Enter:  A     = Queue #
;         B     = # Queues to check
; Exit :  DE    = Address of memory block
;         Carry = Success
; Uses :  AF, B, HL, DE
;
; If the pools are arranged such that pool i contains memory blocks
; that are smaller than pool j, with i<j, then this routine attempts
; to satisfy the memory request by allocating from pool A, then pool A+1,
; etc. up to pool A+B-1, ensuring that the memory block returned will
; be at least as large as the block requested.

.SPBlockFit
   call SPBlockAlloc
   ret c
   djnz bbf
   ret

.bbf
   inc hl
   call SPalloc
   ret c
   djnz bbf
   ret
