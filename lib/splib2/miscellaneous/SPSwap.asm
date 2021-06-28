; Swap Memory Blocks
; Alvin Albrecht 03.2003
;

XLIB SPSwap

; An overlap-safe swap of two memory blocks.
;
; enter:  bc = # bytes to swap
;         hl = address of block 1
;         de = address of block 2

.SPSwap
   ld a,(de)
   ldi
   dec hl
   ld (hl),a
   inc hl
   jp pe, SPSwap
   ret
