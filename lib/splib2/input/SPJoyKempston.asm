;
; JoyKempston
; Alvin Albrecht 2002
;
; Reads Kempston joystick.
;

XLIB SPJoyKempston
LIB SPtbllookup

; JoyKempston
;
; Reads Kempston joystick.
; You must make sure the real hardware is
; present or you may get false readings. 
;
; exit:   a = F111RLDU active low 
; uses:   af, de 

.SPJoyKempston
   in a,($1f)           ; 000FUDLR active high
   cpl                  ; active low
   and $1f
   ld de,kemptbl        ; use table to transform
   jp SPtbllookup

.kemptbl
   defb $70,$78,$74,$7c
   defb $72,$7a,$76,$7e
   defb $71,$79,$75,$7d
   defb $73,$7b,$77,$7f
   defb $f0,$f8,$f4,$fc
   defb $f2,$fa,$f6,$fe
   defb $f1,$f9,$f5,$fd
   defb $f3,$fb,$f7,$ff
