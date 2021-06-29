
/*
 *      Sprite Pack V2.1
 *      Alvin Albrecht 03.2003
 */

#include "spritepack.h"

void sp_HeapSiftDown(uint start, void **array, uint n, void *compare)
{
   uint c;

   for (c = start*2; c < n; start = c, c = c*2) {
      if ((c+1 <= n) && (compare(array[c+1], array[c])))
         c++;
      if (compare(array[start], array[c]))
         return;
      sp_Swap(array+start, array+c, sizeof(void *));
   }
   if ((c == n) && (compare(array[c], array[start])))
      sp_Swap(array+start, array+c, sizeof(void *));
}
