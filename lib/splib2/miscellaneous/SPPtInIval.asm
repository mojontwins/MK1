;
; PointInIval
; Alvin Albrecht 03.2003
;

XLIB SPPtInIval

; Point In Interval?
;
; Returns carry flag set if the point x is in [x1,x2].
;
; enter:   bc = x1  (left end of range, inclusive)
;          de = x2  (right end of range, inclusive)
;          hl = x
;
; exit :   carry = point not in interval
;
; used :   f, de, hl

.SPPtInIval
   push hl
   ld l,e
   ld h,d
   or a
   sbc hl,bc            ; x2 - x1
   jr c, broken         ; if (x2 < x1) goto broken

   pop hl
   push hl
   sbc hl,bc            ; x - x1
   pop hl
   ret c                ; if (x < x1) return not in interval (carry)
   ex de,hl
   sbc hl,de            ; x2 - x
   ret                  ; if (x2 < x) return not in interval (carry)

.broken
   pop hl
   push hl
   or a
   sbc hl,bc            ; x - x1
   pop hl
   ret nc               ; if (x >= x1) return in interval (no carry)
   ex de,hl
   or a
   sbc hl,de            ; x2 - x
   ret                  ; if (x <= x2) return in interval (no carry)
