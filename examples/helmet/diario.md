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


