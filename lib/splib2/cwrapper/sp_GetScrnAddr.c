
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

void *sp_GetScrnAddr(uint xcoord, uchar ycoord, uchar *mask)
{
#asm
   LIB SPGetScrnAddr

   ld hl,7
   add hl,sp
   ld b,(hl)
   dec hl
   ld c,(hl)  ; bc = x coord
   dec hl
   dec hl
   push hl
   ld h,(hl)
   ld l,c
   ld a,h
   rrc b
   call SPGetScrnAddr
   ex de,hl
   ex (sp),hl
   dec hl
   ld d,(hl)
   dec hl
   ld e,(hl)  ; de = mask
   ex de,hl
   ld (hl),b
   pop hl
#endasm
}

/*
  enter: a = h = y coord 0..191, l = x coord 0..255 
         carry = add 256 to x coord (hi-res only) 
  exit : de = screen address, b = pixel mask 
*/
