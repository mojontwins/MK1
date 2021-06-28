
/*
 *      Sprite Pack V2.0
 *
 *      Spectrum and Timex Computers Game Engine
 *      Visit http://justme895.tripod.com/main.htm
 *
 *      Alvin Albrecht 02.2003
 */

#define _SPLIB
#include "spritepack.h"

void sp_SetMousePosKempston(uint xcoord, uchar ycoord)
{
#asm
   INCLUDE "SPconfig.def"
   LIB SPSetMousePosKempston

   ld hl,2
   add hl,sp
   ld d,(hl)
   inc hl
   inc hl
   ld e,(hl)
   inc hl
IF DISP_HIRES
   ld a,(hl)
   rra
ENDIF
   ex de,hl
   call SPSetMousePosKempston
#endasm
}

/*
; enter: h = y coord 0..191
;        l = x coord 0.255, hi-res: carry set adds 256
*/
