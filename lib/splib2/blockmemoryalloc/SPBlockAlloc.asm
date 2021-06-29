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


XLIB SPBlockAlloc
LIB SPqueuetable
XDEF SPalloc

; BlockAlloc
;
; Enter:  A     = Queue #
; Exit :  DE=HL = Address of memory block
;         Carry = Success
; Time :  Success   140
;         Fail      78
; Uses :  AF, HL, DE

.SPBlockAlloc
   add a,a
   add a,SPqueuetable % 256
   ld l,a
   ld h,SPqueuetable / 256
   jp nc, SPalloc
   inc h

.SPalloc
   ld e,(hl)
   inc hl
   ld d,(hl)
   ld a,d
   or e
   ret z
   inc de
   ld a,(de)
   ld (hl),a
   dec hl
   dec de
   ld a,(de)
   ld (hl),a
   ld l,e
   ld h,d
   scf
   ret
