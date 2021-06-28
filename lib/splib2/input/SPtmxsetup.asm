
XLIB SPtmxsetup

.SPtmxsetup
   ld a,7
   out ($f5),a         ; select R7 on AY chip
   in a,($f6)          ; read R7
   and $bf             ; bit 6 = 0 selects i/o port A read
   out ($f6),a
   ld a,14
   out ($f5),a         ; select R14, attached to i/o port A
   ret
