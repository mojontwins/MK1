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

void *sp_CreateGenericISR(void *addr)
{
#asm
   LIB SPCreateGenericISR

   pop hl
   pop de
   push de
   push hl
   call SPCreateGenericISR
   ex de,hl
#endasm
}

/*
; enter: de = address to place ISR
; exit : de = address just past ISR
*/
