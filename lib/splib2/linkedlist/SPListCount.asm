;
; uint ListCount(LIST *list)
; Alvin Albrecht 02.2003
;

XLIB SPListCount

; enter: hl = LIST *
; exit : de = # items in list
; uses : af, de

.SPListCount
   ld e,(hl)
   inc hl
   ld d,(hl)
   dec hl
   ret
