
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

void *sp_ListFirst(struct sp_List *list)
{
#asm
   LIB SPListFirst

   ld hl,2
   add hl,sp
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   call SPListFirst
   ccf
   ex de,hl
   ret nc
   ld hl,0
#endasm
}

/*
; enter: hl = LIST *
; exit : no carry = list empty
;        de = item at start of list
;        current pointer changed to point at first item in list
*/
