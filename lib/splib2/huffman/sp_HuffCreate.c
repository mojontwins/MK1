/*
 *      Sprite Pack V2.1
 *      Alvin Albrecht 03.2003
 */

#include <string.h>
#define NOREDEF
#include "spritepack.h"

struct sp_HuffmanCodec *sp_HuffCreate(uint symbols)
{
   struct sp_HuffmanCodec *hc;
   struct sp_HuffmanLeaf *hl;
   struct sp_HuffmanLeaf **heap;
   uint i;

   if ((hc = u_malloc(sizeof(struct sp_HuffmanCodec))) == NULL)
      return NULL;
   memset(hc, 0, sizeof(struct sp_HuffmanCodec));

   hc->symbols = i = symbols;
   if ((hc->u.heap = heap = u_malloc(i*sizeof(struct sp_HuffmanLeaf *))) == NULL) {
      u_free(hc);
      return NULL;
   }

   while (i != 0) {
      if ((heap[--i] = hl = u_malloc(sizeof(struct sp_HuffmanLeaf))) == NULL) {
         while (++i != symbols)
            u_free(heap[i-1]);
         u_free(heap);
         u_free(hc);
         return NULL;
      }
      hl->u.freq = 0;
      hl->c = i;
   }

   return hc;
}
