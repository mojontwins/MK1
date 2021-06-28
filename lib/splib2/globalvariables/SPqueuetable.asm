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
XLIB SPqueuetable

; Table holds one 2-byte entry per queue.  This is a pointer to
; a linked list of available memory queues.  It is zero if none
; are available.

.SPqueuetable
   defs NUMQUEUES * 2
