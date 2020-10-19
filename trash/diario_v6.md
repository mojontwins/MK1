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

## 20201019

Todo OK y commited y funcionante.

Voy a empezar a plantear el tema de los sprites aunque todavía tengo que portar los ejemplos a v6 y ver qué tal va todo, aunque entiendo que todo debería ir bien.

Veamos, debería poder configurar el tamaño de los sprites del jugador, el de los enemigos, y luego el área de colisión del jugador.

**Si el área de colisión del jugador es de más de 16 pixels de algo hay que meter un punto intermedio.**. Por tanto, si se detecta que el jugador va a colisionar con más de 16 píxels de alto habría que cambiar `cm_two_points` por `cm_three_points`. Quizá sea buena idea ir cambiándole el nombre a esta función por `cm_hb_collision`, con hb = half box. DONE.

Si vamos a poder configurar el tamaño de los sprites del jugador y de los enemigos lo suyo es separarlos completamente y hacer dos conversiones, teniendo dos punteros separados y tal. Esto haría menos *cumbersome* poner más frames para el jugador en animaciones custom.

Voy a ver de hacer los cambios necesarios para tenerlo separado.

Lo primerísimo que voy a hacer, para ir allanando, es sacar la creación de los sprites de `mainloop.h` y meterla en dos archivos separados dentro de `assets`, `spritedef_player.h` y `spritedef_enems.h`. Estos archivos luego deberían ser generados por el conversor.

Estaría muy bien que la llamada normal al conversor de sprites fuera IGUAL que antes si sólo vas a usar el set estándar de toda la vida, pero poderla extender con parámetros extra para la nueva situación:

* `player_size=XxY` para controlar el tamaño del sprite del jugador.
* `enems_size=XxY` para controlar el tañao de los sprites de los enemigos.
* `player_frames=n` para controlar el número de frames para el jugador
* `enems_frames=n` para controlar el número de frames de los enemigos.
* `player_pos=x,y` posición x,y del rectángulo que contiene el spriteset del jugador.
* `enems_pos=x,y` posición x,y del rectángulo que contiene el spriteset de los enemigos.

`XxY` puede ser `16x16`, `16x24`, `24x16` o `16x32`.

Si no se pasa nada, se asume esta serie de valores por defecto:

* `player_size=16x16`
* `enems_size=16x16`
* `player_frames=8`
* `enems_drames=8`
* `player_pos=0,0`
* `enems_pos=0,16`

Creo que lo mejor sería empezar haciendo el nuevo conversor que generase ya todos los datos, y probarlo para el caso base para montar primero el sistema de sprites, y más tarde pensar ya en la caja de colisión.

Remember: El tamaño de la caja de colisión debe también afectar a como se detecta el cambio de pantalla y el ajuste para no permitir que el sprite se salga.

Nah, no lo voy a hacer así. Voy a hacer que una llamada recorte un set y haré dos llamadas para tener todos los cells en dos binarios y dos archivos de definiciones.

Meh, palos patrás de nuevo. Tengo que generar código muy específico de MK1 (el nombre de los arrays y tal)
así que volvemos al plan inicial pero con dos binarios.

