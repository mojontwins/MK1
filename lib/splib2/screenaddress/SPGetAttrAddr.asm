;
; GetAttrAddr
; Alvin Albrecht 2002
;

INCLUDE "SPconfig.def"
XLIB SPGetAttrAddr

; Get Attribute Address
;
; Computes the attribute address corresponding to a screen
; address such as returned by 'GetCharAddr' or 'GetScrnAddr'.
;
; enter: hl = screen address
; exit : de = address of attribute square
; uses : af, de

IF DISP_SPECTRUM

.SPGetAttrAddr
   ld e,l
   ld a,h
   or $07
   xor $85
   rrca
   rrca
   rrca
   ld d,a
   ret

ELSE
IF DISP_HICOLOUR

.SPGetAttrAddr
   ld e,l
   ld d,h
   set 5,d
   ret

ELSE

.SPGetAttrAddr
   ld e,l
   ld d,h
   ret             ; There are no attributes in hi-res mode

ENDIF
ENDIF
