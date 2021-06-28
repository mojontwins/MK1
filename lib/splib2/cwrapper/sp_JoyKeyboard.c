
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

uchar sp_JoyKeyboard(struct sp_UDK *keys)
{
#asm
   LIB SPJoyKeyboard

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   ld d,(hl)
   call SPJoyKeyboard
   ld l,a
   ld h,0
#endasm
}

/*
; enter:   de points at a 5-entry table, each entry holds
;             a key row value (byte) followed by a mask (byte).
;             The key row byte is the same byte that would appear
;             in the MSB of a port read of the keyboard.  The mask
;             byte isolates the key within the byte.  "LookupKey"
;             will provide this information for a particular key
;             given its ascii code.
;               de + 0/1 fire key: key row / mask
;               de + 2/3 right key: key row / mask
;               de + 4/5 left key: key row / mask
;               de + 6/7 down key: key row / mask
;               de + 8/9 up key: key row / mask
; exit :   a = F111RLDU active low
*/
