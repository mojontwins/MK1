;
; JoySinclair1
; Alvin Albrecht 2002
;
; Reads Sinclair 1 joystick.
;

XLIB SPJoySinclair1
LIB SPtbllookup

; JoySinclair1 
;
; Reads Sinclair 1 joystick (keys 6..0). 
;
; exit:   a = F111RLDU active low 
; uses:   af, de 

.SPJoySinclair1
   ld a,$ef
   in a,($fe)
   and $1f             ; 000LRDUF active low
   ld de,sinc1tbl      ; use table to transform
   jp SPtbllookup

.sinc1tbl
   defb $70,$f0,$71,$f1
   defb $72,$f2,$73,$f3
   defb $78,$f8,$79,$f9
   defb $7a,$fa,$7b,$fb
   defb $74,$f4,$75,$f5
   defb $76,$f6,$77,$f7
   defb $7c,$fc,$7d,$fd
   defb $7e,$fe,$7f,$ff
