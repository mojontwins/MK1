
/*
 *      Sprite Pack V2.1
 *
 *      Spectrum and Timex Computers Game Engine
 *      Visit http://justme895.tripod.com/main.htm
 *
 *      Alvin Albrecht 03.2003
 */

#define _SPLIB
#include "spritepack.h"

int sp_IntLargeRect(struct sp_LargeRect *r1, struct sp_LargeRect *r2, struct sp_LargeRect *result)
{
#asm
   LIB SPIntLargeRect

   ld hl,7
   add hl,sp
   ld d,(hl)
   dec hl
   ld e,(hl)
   dec hl
   ld b,(hl)
   dec hl
   ld c,(hl)
   defb $dd
   ld l,e
   defb $dd
   ld h,d
   defb $fd
   ld l,c
   defb $fd
   ld h,b
   call SPIntLargeRect
   ld hl,0
   ret c
   ld hl,10
   add hl,sp
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   ld bc,7
   add hl,bc
   pop bc
   ld (hl),b
   dec hl
   ld (hl),c
   dec hl
   pop bc
   ld (hl),b
   dec hl
   ld (hl),c
   dec hl
   pop bc
   ld (hl),b
   dec hl
   ld (hl),c
   dec hl
   pop bc
   ld (hl),b
   dec hl
   ld (hl),c
   ld hl,1
#endasm
}

/*
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
*/

