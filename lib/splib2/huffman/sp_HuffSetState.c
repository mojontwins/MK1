/*
 *      Sprite Pack V2.1
 *      Alvin Albrecht 03.2003
 */

#include "spritepack.h"

void sp_HuffSetState(struct sp_HuffmanCodec *hc, void *addr, uchar bit)
{
   hc->bit = bit;
   hc->addr = addr;
}
