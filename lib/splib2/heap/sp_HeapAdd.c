
/*
 *      Sprite Pack V2.1
 *      Alvin Albrecht 03.2003
 */

#include "spritepack.h"

void sp_HeapAdd(void *item, void **array, uint n, void *compare)
{
   array[n+1] = item;
   sp_HeapSiftUp(n+1, array, compare);
}
