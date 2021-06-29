
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

void sp_HashDelete(struct sp_HashTable *ht)
{
   uint i;
   struct sp_HashCell *temp, *ls;

   for (i=0; i != ht->size; i++) {
      for (ls = ht->table[i]; ls != NULL; ls = temp) {
         temp = ls->next;
         (ht->delete)(ls);
         u_free(ls);
      }
   }

   u_free(ht->table);
   u_free(ht);
}
