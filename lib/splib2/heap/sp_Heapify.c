
/*
 *      Sprite Pack V2.1
 *      Alvin Albrecht 03.2003
 */

#include "spritepack.h"

/* orders an unsorted array into a heap by building the heap from the bottom up */

void sp_Heapify(void **array, uint n, void *compare)
{
   uint i;

   for (i=n/2; i!=0; i--)
      sp_HeapSiftDown(i, array, n, compare);
}
