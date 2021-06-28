
/*
 *      Sprite Pack V2.1
 *
 *      Spectrum and Timex Computers Game Engine
 *      Visit http://justme895.tripod.com/main.htm
 *
 *      Alvin Albrecht 06.2003
 */

#define _SPLIB
#include "spritepack.h"

void sp_SetMousePosSim(struct sp_UDM *m, uint xcoord, uchar ycoord)
{
#asm
   INCLUDE "SPconfig.def"
   LIB SPSetMousePosSim

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
   inc hl
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   ex de,hl
   call SPSetMousePosSim
#endasm
}

/*
; enter: h = y coord 0..191
;        l = x coord 0.255, hi-res: carry set adds 256
;       de = struct sp_UDM
*/
