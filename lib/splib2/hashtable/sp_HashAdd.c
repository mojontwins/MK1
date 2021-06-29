
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

void *sp_HashAdd(struct sp_HashTable *ht, void *key, void *value)
{
   uint i;
   struct sp_HashCell *hc, *lag, *ls;

   ls = ht->table[i = (ht->hashfunc)(key, ht->size)];
   for (lag = NULL; ls != NULL; lag = ls, ls = ls->next)
      if ((ht->match)(key, ls->key))
         break;

   if (ls) {
      hc = ls->value;
      ls->value = value;
      return_nc hc;
   }

   if ((hc = u_malloc(sizeof(struct sp_HashCell))) == NULL)
      return_c NULL;

   hc->key = key;
   hc->value = value;
   hc->next = ht->table[i];
   ht->table[i] = hc;

   return_nc NULL;
}
