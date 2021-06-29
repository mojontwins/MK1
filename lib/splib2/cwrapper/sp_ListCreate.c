
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

struct sp_List *sp_ListCreate(void)
{
   struct sp_List *ls;

   ls = u_malloc(sizeof(struct sp_List));

#asm
   LIB SPListCreate

   pop hl               ; hl = ls
   ld a,h
   or l
   ret z
   ex de,hl
   call SPListCreate
   ret
#endasm
}

/*
; enter: de = address of new sp_List container
; exit : hl = LIST*
*/
