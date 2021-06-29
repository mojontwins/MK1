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

int sp_IntPtInterval(uint x, struct sp_Interval *i)
{
#asm
   LIB SPPtInIval

   pop bc
   pop hl
   ld c,(hl)
   inc hl
   ld b,(hl)
   inc hl
   ld e,(hl)
   inc hl
   ld d,(hl)
   pop hl
   push hl
   push hl
   push bc
   call SPPtInIval
   ld hl,0
   ret c
   inc l
#endasm   
}

/*
; enter:   bc = x1  (left end of range, inclusive)
;          de = x2  (right end of range, inclusive)
;          hl = x
;
; exit :   carry = point not in interval
*/
