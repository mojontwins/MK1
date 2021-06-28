
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

int sp_ListAppend(struct sp_List *list, void *item)
{
   struct sp_ListNode *node;

   node = u_malloc(sizeof(struct sp_ListNode));

#asm
   LIB SPListAppend

   pop hl         ; hl = node
   ld a,h
   or l
   ret z
   ex de,hl
   ld hl,2
   add hl,sp
   ld c,(hl)
   inc hl
   ld b,(hl)
   inc hl
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   ex de,hl
   call SPListAppend
   ld hl,1
   ret
#endasm
}

/*
; enter: de = LIST *
;        bc = item *
;        hl = address of new sp_ListNode container
; exit : new item appended to end of list, current points at new item
*/
