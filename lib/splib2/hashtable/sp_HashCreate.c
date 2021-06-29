
/*
 *      Sprite Pack V2.1
 *
 *      Spectrum and Timex Computers Game Engine
 *      Visit http://justme895.tripod.com/main.htm
 *
 *      Alvin Albrecht 03.2003
 */

#define _SPLIB
#include <string.h>
#include <stdlib.h>
#define NOREDEF
#include "spritepack.h"

struct sp_HashTable *sp_HashCreate(uint size, void *hashfunc, void *match, void *delete)
{
   struct sp_HashTable *ht;

   if ((ht = u_malloc(sizeof(struct sp_HashTable))) == NULL)
      return NULL;

   if ((ht->table = u_malloc(size*sizeof(struct sp_HashCell *))) == NULL) {
      u_free(ht);
      return NULL;
   }

   memset(ht->table, 0, size*sizeof(struct sp_HashCell *));
   ht->size = size;
   ht->hashfunc = hashfunc;
   ht->match = match;
   ht->delete = delete;

   return ht;
}
