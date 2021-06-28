;
; JoySinclair2
; Alvin Albrecht 2002
;
; Reads Sinclair 2 joystick.
;

XLIB SPJoySinclair2
LIB SPtbllookup

; JoySinclair2 
;
; Reads Sinclair 2 joystick (keys 1..5). 
;
; exit:   a = F111RLDU active low 
; uses:   af, de 

.SPJoySinclair2
   ld a,$f7            ; key row 1..5
   in a,($fe)
   and $1f             ; 000FUDRL active low
   ld de,sinc2tbl      ; use table to transform
   jp SPtbllookup

.sinc2tbl
   defb $70,$74,$78,$7c
   defb $72,$76,$7a,$7e
   defb $71,$75,$79,$7d
   defb $73,$77,$7b,$7f
   defb $f0,$f4,$f8,$fc
   defb $f2,$f6,$fa,$fe
   defb $f1,$f5,$f9,$fd
   defb $f3,$f7,$fb,$ff
