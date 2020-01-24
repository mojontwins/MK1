# Diario y cosas

El tema multi nivel está muy poco depurado en **MTE MK1**, sobre todo en modo 128K. La idea de hacer este juego multinivel y posteriormente portar **Goku Mal** es dejar limpito y usable el manejador de niveles.

Los juegos de 128K multinivel usarán el `buildlevels.exe` y los *niveles tipo bundle* como **Goku Mal**. Los de 48K emplearán assets separados. En cualquier caso la estructura sobre la que se descomprimirán las cosas serán las mismas.

Para automatizar, los niveles 48K se compondrán de:

- cabecera
- tileset
- mapa y cerrojos
- enemigos y hotspots
- comportamientos de tile
- (opcional) spriteset

Las cabecera será un tipo de datos compatible con el de los level bundles que refinaré debidamente (actualización de `buildlevels.exe` mediante, pero eso ya lo veré con **Goku Mal**).

Los datos "de engine" de los niveles se colocarán en un `assets/levels.h` que se encargará de meter lo que vaya necesitando. Los arrays con los levelsets se pondrán en `my/levelset.h`.

~~ 

Necesito hacer enemigos disparadores. Pero en plan hiper sencillo. Voy a hacer unos *orthogonal cocos*. Si un enemigo tiene levantado el bit 5 (& 0x20) disparará su coco en la direccion que digan los bits 6 y 7 según se cumpla `(rand () & COCO_FREQ) == 1`. Tengo que hacerlo en modo super ahorro así que les meteré candela en ensamble directamente.

~~ 

No voy a gastar un bit sólo para esto, con todo lo que implica. Vamos a meter otro numerito, el tipo 5, que quedó libre:

ddXM0101, con dd la dirección.

~~

Los tipos sería, por tanto, si ordenamos dd como arriba, derecha, abajo, izquierda:

|t|bin|khe
|---|---|---
|05|**00**00 0101|arriba
|45|**01**00 0101|derecha
|85|**10**00 0101|abajo
|C5|**11**00 0101|izquierda

