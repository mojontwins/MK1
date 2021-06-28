
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

void sp_MouseKempston(uint *xcoord, uchar *ycoord, uchar *buttons)
{
#asm
   INCLUDE "SPconfig.def"
   LIB SPMouseKempston

   ld hl,2
   add hl,sp
   push hl
   call SPMouseKempston
   ld a,e               ; a = buttons
   ld c,l
   ld b,h               ; bc = pixel coords, carry=+256 to x coord
   pop hl
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl
   ld (de),a
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl
   ld a,b
   ld (de),a
   ld e,(hl)
   inc hl
   ld d,(hl)
   ld a,c
   ld (de),a
   inc de
   ld a,0
IF DISP_HIRES
   adc a,0
ENDIF
   ld (de),a
#endasm
}

/*
; exit : a = h = y coord 0..191
;        l = x coord 0.255, hi-res mode: carry set adds 256
;        e = 111111RL active low button press
*/
