/*
 *      Sprite Pack V2.1
 *      Alvin Albrecht 03.2003
 */

#include "spritepack.h"

void traverseTree(struct sp_HuffmanJoin *hj)
{
   if (hj->left < 256) {
      u_free(hj);
      return;
   }
   traverseTree(hj->left);
   traverseTree(hj->right);
   u_free(hj);
}

void sp_HuffDelete(struct sp_HuffmanCodec *hc)
{
   uint i;

   if (hc->root) {
      traverseTree(hc->root);
      u_free(hc->u.encoder);
   } else {
      for (i=hc->symbols; i!=0; i--)
         traverseTree(hc->u.encoder[i-1]);
      u_free(hc->u.encoder);
   }

   u_free(hc);
}
