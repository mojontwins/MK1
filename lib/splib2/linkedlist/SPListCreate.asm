;
; LIST *ListCreate(uchar listQueue)
; Alvin Albrecht 02.2003
;

XLIB SPListCreate
XDEF SPzerolist

; enter: de = address of new sp_List container
; exit : hl = LIST*
; uses : af, de, hl

.SPListCreate
.SPzerolist
   ld l,e
   ld h,d
   xor a
   ld (de),a
   inc de
   ld (de),a
   inc de
   ld (de),a
   inc de
   ld (de),a
   inc de
   ld (de),a
   inc de
   ld (de),a
   inc de
   ld (de),a
   inc de
   ld (de),a
   inc de
   ld (de),a
   ret
