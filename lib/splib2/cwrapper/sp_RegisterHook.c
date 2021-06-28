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

/* void sp_RegisterHook(uchar vector, void (*hook)(void)) */
void sp_RegisterHook(uchar vector, void *hook)
{
   sp_RegisterHookLast(vector, hook);
}

/* THERE MUST BE TWO FREE BYTES PRIOR TO YOUR HOOK !!! */
