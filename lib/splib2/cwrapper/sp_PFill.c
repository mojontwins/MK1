
/*
 *      Sprite Pack V2.0
 *
 *      Spectrum and Timex Computers Game Engine
 *      Visit http://justme895.tripod.com/main.htm
 *
 *      Alvin Albrecht 01.2003
 */

#define _SPLIB
#include "spritepack.h"

int sp_PFill(uint xcoord, uchar ycoord, void *pattern, uint stackdepth)
{
#asm
   LIB SPPFill

   ld hl,2
   add hl,sp
   ld c,(hl)
   inc hl
   ld b,(hl)
   inc hl
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl     ; bc, de set up
   ld a,(hl)  ; a = ycoord
   inc hl
   inc hl
   ex af,af
   inc hl
   ld a,(hl)
   rrca
   ex af,af  ; alternate carry set for top 256 pixels
   dec hl
   ld l,(hl)  ; l = x coord
   ld h,a     ; h = y coord   
   call SPPFill
   ld hl,1
   ret nc
   dec l
#endasm
}

/*
; enter: h = y coord, l = x coord, bc = max stack depth, de = address of fill pattern
;        In hi-res mode, carry flag is most significant bit of x coord
; used : ix, af, bc, de, hl
; exit : no carry = success, carry = had to bail queue was too small
; stack: 3*bc+30 bytes, not including the call to PFILL or interrupts
*/
