;
; MultDEAC
; Alvin Albrecht 2002
;

XLIB SPMultDEAC

; Multiply 16 by 16
;
; enter: DE = 16 bit multiplicand
;        AC = 16 bit multiplicand
; exit : HL = AC*DE % 65536
; used : AF, BC, HL
; time : 886

.SPMultDEAC
   ld hl,0
   ld b,16

.m16lp
   add hl,hl
   sla c
   rla 
   jr nc, noadd16
   add hl,de

.noadd16
   djnz m16lp
   ret
