
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

int sp_AddColSpr(struct sp_SS *sprite, void *graphic)
{
#asm
   LIB SPAddColSpr

   ld hl,2
   add hl,sp
   ;ld a,(hl)
   ;ex af,af
   ;inc hl
   ;inc hl
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl
   ld c,(hl)
   inc hl
   ld b,(hl)
   defb $dd
   ld l,c
   defb $dd
   ld h,b
   call SPAddColSpr
   ld hl,1
   ccf
   ret nc
   dec l
#endasm
}

/*  enter: IX = sprite structure address 
           DE = sprite column definition 
           A' = (spectrum )  colour attribute for entire column 
                (hi-colour)  colour threshold (0..7) 
                (hi-res   )  unused 
    exit : carry for success 
*/
