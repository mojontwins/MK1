;
; MultDEA
; Alvin Albrecht 2002
;

XLIB SPMultDEA

; Multiply 16 by 8
;
; enter: DE = 16 bit multiplicand
;         A = 8 bit multiplicand
; exit : HL = A*DE % 65536
; used : F, B, HL
; time : 390

.SPMultDEA
   ld hl,0
   ld b,8

.m8lp
   add hl,hl
   rlca 
   jr nc, noadd8
   add hl,de

.noadd8
   djnz m8lp
   ret
