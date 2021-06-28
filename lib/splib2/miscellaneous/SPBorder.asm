;
; Set Border Colour
; Alvin Albrecht 07.2003
;

INCLUDE "SPconfig.def"

XLIB SPBorder
XDEF SPBorderClr

.SPBorderClr
IF DISP_HIRES
   defb $00
ELSE
   defb $07
ENDIF

; Set Border Colour
;
; Stores border colour in variable SPBorderClr.
; In hi-res mode, the "border colour" selects the
; paper colour with the ink colour selected by
; the Timex hardware.
;
; enter:   a = border colour 0..7
; exit :   border colour changed
;
; used :   af,c

.SPBorder
IF !DISP_HIRES
   and $07
   ld (SPBorderClr),a
   out ($fe),a
ELSE
   and $07
   ld (SPBorderClr),a
   xor $07
   rlca
   rlca
   rlca
   ld c,a
   in a,($ff)
   and $c7
   or c
   out ($ff),a
ENDIF
   ret
