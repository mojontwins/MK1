/*
 *      Sprite Pack V2.1
 *      Alvin Albrecht 03.2003
 */

#include "spritepack.h"

void sp_HuffAccumulate(struct sp_HuffmanCodec *hc, uchar c)
{
   (hc->u.heap[c])->u.freq++;
}
