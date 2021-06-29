
/*
 *      Sprite Pack V2.1
 *      Alvin Albrecht 03.2003
 */

#include "spritepack.h"

void sp_HeapExtract(void **array, uint n, void *compare)
{
   sp_Swap(array+1, array+n, sizeof(void *));
   sp_HeapSiftDown(1, array, n-1, compare);
}
