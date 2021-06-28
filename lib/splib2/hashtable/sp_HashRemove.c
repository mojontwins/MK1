
/*
 *      Sprite Pack V2.1
 *
 *      Spectrum and Timex Computers Game Engine
 *      Visit http://justme895.tripod.com/main.htm
 *
 *      Alvin Albrecht 03.2003
 */

#define _SPLIB
#include "spritepack.h"

struct sp_HashCell *sp_HashRemove(struct sp_HashTable *ht, void *key)
{
   int i;
   struct sp_HashCell *lag;
   struct sp_HashCell *ls;

   ls = ht->table[i = (ht->hashfunc)(key, ht->size)];
   for (lag = NULL; ls != NULL; lag = ls, ls = ls->next)
      if ((ht->match)(key, ls->key))
         break;

   if (ls) {
      if (lag)
         lag->next = ls->next;
      else
         ht->table[i] = ls->next;
   }

   return ls;
}
