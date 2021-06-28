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

int sp_IntIntervals(struct sp_Interval *i1, struct sp_Interval *i2, struct sp_Interval *result)
{
#asm
   LIB SPIntIvals

   pop bc
   pop hl
   pop iy
   pop ix
   push hl
   push hl
   push hl
   push bc
   push hl
   call SPIntIvals
   pop hl
   ld (hl),c
   inc hl
   ld (hl),b
   inc hl
   ld (hl),e
   inc hl
   ld (hl),d
   ld hl,0
   ret c
   inc l
#endasm   
}

/*
; enter:   ix+0 = x1 low
;          ix+1 = x1 hi
;          ix+2 = x2 low
;          ix+3 = x2 hi
;          iy+0 = y1 low
;          iy+1 = y1 hi
;          iy+2 = y2 low
;          iy+3 = y2 hi
;
; exit :   carry = no intersection
;          otherwise the resulting intersect interval is [bc,de]
*/
