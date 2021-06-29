
XLIB SPtbllookup

; enter:
;    de = table base
;     a = table byte index
;
; exit:
;     a = table entry

.SPtbllookup
   add a,e
   ld e,a
   jp nc, noinc
   inc d

.noinc
   ld a,(de)
   ret
