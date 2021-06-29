;
; IntLargeRect
; Alvin Albrecht 03.2003
;

XLIB SPIntLargeRect
LIB SPIntIvals

; Intersect Large Rectangles
;
; enter:  Rectangle #1:
;
;         ix+0/1   xtop
;         ix+2/3   xbot
;         ix+4/5   xleft
;         ix+6/7   xright
;
;         Rectangle #2:
;
;         iy+0/1   ytop
;         iy+2/3   ybot
;         iy+4/5   yleft
;         iy+6/7   yright
;
; exit :  carry = resulting rectangle is empty
;         otherwise the result of the intersection is on stack:
;         pop order = right, left, bottom, top

.SPIntLargeRect
   pop af
   ex af,af'            ; save return address in af'
   call SPIntIvals      ; intersect [xb,xt] and [yb,yt]
   jr c, failintlarge2  ; if no intersection
   push bc
   push de              ; save resulting [top,bot] on stack
   ld bc,4
   add ix,bc
   add iy,bc
   call SPIntIvals      ; intersect [xl,xr] and [yl,yr]
   jr c, failintlarge1  ; if no intersection
   push bc
   push de              ; save resulting [left,right] on stack
   ex af,af'
   push af              ; restore return address
   or a                 ; no carry = result is non-empty
   ret

.failintlarge1
   pop bc
   pop de
.failintlarge2
   ex af,af'
   push af              ; restore return address
   scf                  ; carry = empty result
   ret
