/*
 *      Sprite Pack V2.1
 *      Alvin Albrecht 03.2003
 */

#include "spritepack.h"

void *sp_HuffGetState(struct sp_HuffmanCodec *hc, uchar *bit)
{
   *bit = hc->bit;
   return hc->addr;
}
