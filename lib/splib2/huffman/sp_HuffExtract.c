/*
 *      Sprite Pack V2.1
 *      Alvin Albrecht 03.2003
 */

#include "spritepack.h"

int compare(struct sp_HuffmanLeaf *h1, struct sp_HuffmanLeaf *h2)
{
   if (h1->u.freq < h2->u.freq)
      return_c(1);
   return_nc(0);
}

void traverseHuffTree(struct sp_HuffmanJoin *hj, struct sp_HuffmanLeaf **heap)
{
   if (hj->left < 256) {      /* if this is really a sp_HuffmanLeaf */
      heap[hj->left] = hj;
      return;
   }
   traverseHuffTree(hj->left, heap);
   traverseHuffTree(hj->right, heap);
}

int sp_HuffExtract(struct sp_HuffmanCodec *hc, uint n)
{
   struct sp_HuffmanLeaf **heap;
   struct sp_HuffmanJoin *hj1, *hj2, *hj3;

   /* change frequency table into a min-heap */
   if (n == 0)
      sp_Heapify(heap = hc->u.heap-1, n = hc->symbols, compare);

   /* create huffman decoder tree */
   while (n != 1) {
      if ((hj3 = u_malloc(sizeof(struct sp_HuffmanJoin))) == NULL)
         return_c n;

      sp_HeapExtract(heap, n, compare);
      hj1 = heap[n--];
      sp_HeapExtract(heap, n, compare);
      hj2 = heap[n--];

      hj3->u.freq = hj1->u.freq + hj2->u.freq;
      hj1->u.parent = hj3;
      hj2->u.parent = hj3;
      hj3->left = hj1;
      hj3->right = hj2;

      sp_HeapAdd(hj3, heap, n++, compare);
   }
   hj3->u.parent = NULL;
   hc->root = heap[1];

   /* create encoder array */
   traverseHuffTree(hc->root, heap+1);

   return_nc 0;
}
