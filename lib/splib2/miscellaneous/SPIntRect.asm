;
; IntRect
; Alvin Albrecht 03.2003
;

XLIB SPIntRect
XDEF SPIntSmallIval, SPPtInSmallIval

; Intersect Rectangles
;
; enter:  Rectangle #1:
;
;         B = row coord top left corner
;         C = col coord top left corner
;         D = row height in chars
;         E = col width in chars
;
;         Rectangle #2:
;
;         (iy+0) = row coord top left corner
;         (iy+1) = row coord bottom right corner + 1
;         (iy+2) = col coord top left corner
;         (iy+3) = col coord bottom right corner + 1
;
; exit :  carry = resulting rectangle is empty
;         B = row coord top left corner of intersection
;         C = col coord top left corner of intersection
;         D = row height in chars of intersection
;         E = col width in chars of intersection
;
; WORST: 756

.SPIntRect
   ld h,b               ; h = Rect#1 row coord top
   ld a,d
   add a,b
   dec a
   ld l,a               ; l = Rect#1 row coord bot
   ld d,c               ; d = Rect#1 col left
   ld a,e
   add a,c
   dec a
   ld e,a               ; e = Rect#1 col right
   ld b,(iy+0)          ; b = Rect#2 row coord top
   ld c,(iy+1)          ; c = Rect#2 row coord bot+1
   dec c
   push de
   call SPIntSmallIval
   pop de
   ret c                ; if no intersection
   ex de,hl             ; h = Rect#1 col left, l = Rect#1 col right, de = row result
   ld b,(iy+2)          ; b = Rect#2 col coord left
   ld c,(iy+3)          ; c = Rect#2 col coord right+1
   dec c
   push de
   call SPIntSmallIval
   pop de
   ret c                ; if no intersection

   ; d = row coord top, e = row coord bot
   ; h = col coord left, l = col coord right

   ld b,d               ; set up registers for return result
   ld c,h
   ld a,e
   sub d
   inc a
   ld d,a
   ld a,l
   sub h
   inc a
   ld e,a
   or a
   ret

; intersect intervals [h,l] = [b,c] intersect [h,l]  carry=no intersection
.SPIntSmallIval
   ld a,b
   ld d,h
   ld e,l
   call SPPtInSmallIval ; is b in [h,l]
   jr c, tryotherway

   ld a,c               ; b is left edge of intersection
   sub b
   ld d,a               ; d = c-b
   ld a,l
   sub b                ; a = l-b
   cp d
   ld h,b
   ccf
   ret nc
   ld l,c
   or a
   ret

.tryotherway
   ld a,h
   ld d,b
   ld e,c
   call SPPtInSmallIval ; is h in [b,c]
   ret c                ; if no, report no intersection

   ld a,l               ; h is left edge of intersection
   sub h
   ld d,a               ; d = l-h
   ld a,c
   sub h                ; a = c-h
   cp d
   ret nc
   ld l,c
   or a
   ret


; is a in the interval d-e?  carry=no
.SPPtInSmallIval
   ex af,af'
   ld a,e               ; does interval d-e wrap?
   cp d
   jr c, broken

   ex af,af'
   cp d
   ret c                ; return fail if a<d
   ld d,a
   ld a,e
   cp d
   ret                  ; return fail if a>e else success

.broken
   ex af,af'
   cp d
   ret nc               ; return sucess if a>=d
   ld d,a
   ld a,e
   cp d
   ret                  ; return sucess if e>=a
