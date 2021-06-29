
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

void *sp_HashLookup(struct sp_HashTable *ht, void *key)
{
   struct sp_HashCell *ls;
   
   for (ls = ht->table[(ht->hashfunc)(key, ht->size)]; ls != NULL; ls = ls->next)
      if ((ht->match)(key, ls->key))
         return ls->value;

   return NULL;
}
