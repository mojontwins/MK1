# Road to v6

La versión 6 que nunca me planteé hacer incoporará lo siguiente:

- Partes en asm backported desde MK2 (adaptadas y siempre que sea posible para no romper los puntos de inyección de código).
- Tamaño de los sprites configurable built-in con conversores.

El primer *milestone* desos será que todos los ejemplos funcionen con los cambios y mejoras. El segundo *hito* será meter el tamaño de los sprites configurable para jugador y enemigos (con colisión ajustable), que voy a implementar siguiendo los pasos de AGNES. Para la parte de backend, probablemente tenga que hacer que el conversor de sprites me genere la creación de las estructuras sprite.

Llevo tiempo pensando en la viablilidad de hacer que cada tipo de enemigo tenga un tamaño diferente de sprite, pero esto es problemático porque las estructuras de datos que representan los sprites son listas complejas que no sé si sería muy costoso destruir y recrear en cada pantalla.

Probablemente ya vaya que chuta dejando que player y enemigos sean de 16x24 o de 16x32 sin demasiado fiddle.

## 20201018

He adaptado el código de MK2 para la colisión en ambos ejes del personaje principal y el movimiento de las plataformas móviles. Echaré un vistazo a ver si hay más *snippets* fácilmente adaptables y cuando tenga esto listo tendré que empezar a portar todos los ejemplos. Las contris se quedarán en una subcarpeta v5 porque paso de tocarlas.

Lo siguiente es probar los fantis, por cierto.

