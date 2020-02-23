# Blip Blep

Un juego choco.

TODO description

## Custom vEng

Este güego emplea un motor de eje vertical personalizado que podrás ver descrito en el capítulo 15 del Tutorial de **MTE MK1**.

## Custom map renderer

Otra cosa interesante de **Blip Blep** es que emplea un decodificador de mapas personalizado que se basa en un mapa de 32 tiles comprimido con RLE53 que se descomprime en un buffer provisional para luego embellecerse según un conjunto de reglas sencillas de sustitución basadas en el contexto que puede que te sea útil en tus propios güegos y que describimos aquí:

TODO

## Tiles rompiscibles decorados

Empleamos el punto de inyección de código `my/ci/on_breakable_hit.h` para sustituir los tiles que se están rompiendo por otro gráfico:

TODO

