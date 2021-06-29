
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

uint sp_LookupKey(uchar c)  /* use "iferror(..)" to see if code not found */
{
#asm
   LIB SPLookupKey

   ld hl,2
   add hl,sp
   ld a,(hl)
   call SPLookupKey
   jr nc, notfound
   ld l,c
   ld h,b
   or a
   ret

.notfound
   scf
#endasm
}

/*
; enter: a = ascii code
; exit : No carry = ascii code not found
;        Else: c = scan row, b = mask
;              bit 7 of b set if CAPS needs to be pressed
;              bit 6 of b set if SYM SHIFT needs to be pressed
*/
