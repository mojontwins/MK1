
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

void sp_ListConcat(struct sp_List *list1, struct sp_List *list2)
{
#asm
   LIB SPListConcat

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   ex de,hl
   call SPListConcat
#endasm
}

/*
; enter: hl = list2, de = list1
; exit : list1 = list1 concat list2, list2 is deleted
*/
