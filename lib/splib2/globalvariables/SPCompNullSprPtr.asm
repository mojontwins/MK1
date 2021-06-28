
INCLUDE "SPconfig.def"
XLIB SPCompNullSprPtr

IF DISP_HICOLOUR
.SPCompNullSprPtr
   defb $00,$80,$00,$80,$00,$80,$00,$80
   defb $00,$80,$00,$80,$00,$80,$00,$80
ELSE
.SPCompNullSprPtr
   defb $00,$00,$00,$00
   defb $00,$00,$00,$00
ENDIF
