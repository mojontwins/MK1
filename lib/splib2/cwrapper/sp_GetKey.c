
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

uchar sp_GetKey(void)  /* returns ascii code, 0 if no key pressed */
{
#asm
   LIB SPGetKey

   call SPGetKey
   jr c, keyok
   xor a

.keyok
   ld l,a
   ld h,0
   ccf
#endasm
}

/*
; exit :   carry flag set:  key is registered, a = ascii code
*/
