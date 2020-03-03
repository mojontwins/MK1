# Blip Blep

Un juego choco.

TODO description

## Custom vEng

Este güego emplea un motor de eje vertical personalizado que podrás ver descrito en el [capítulo 15 del Tutorial de **MTE MK1**](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap15.md).

## Custom map renderer

Otra cosa interesante de **Blip Blep** es que emplea un decodificador de mapas personalizado que se basa en un mapa de 32 tiles comprimido con RLE53 que se descomprime en un buffer provisional para luego embellecerse según un conjunto de reglas sencillas de sustitución basadas en el contexto que puede que te sea útil en tus propios güegos.

### Primer paso: *decode*

El primer paso es decodificar el mapa. Para hacer el mapa hemos empleado muy pocos tiles, sin hacer ningún tipo de adorno, ya que estos adornos se harán posteriormente de manera automática. Así conseguirmos que el compresor RLE obtenga mejores resultados al haber más repetición.

![Mapa sin adornos](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/XX_map_simple.png)

Para esta parte usamos el decompresor de RLE en su versión RLE53 (5 bits de número de tile - 32 diferentes - y 3 bits de contador), pero no vamos a pintar en pantalla ni a rellenar directamente los buffers. Como buffer temporal utilizaremos `map_attr`, que luego machacaremos con los behs correctos al final del proceso.

### Segundo paso, *backdrop*

En el segundo paso copiamos el contenido de un array de 150 tiles representando el fondo marino en `map_buff`. Este array está definido en `my/ci/extra_vars.h`:

```c

    // extra_vars.h

    [...]

    // Custom backdrop

    const unsigned char backdrop [] = {
        00, 00, 33, 35, 00, 33, 34, 35, 33, 35, 33, 35, 00, 33, 34,
        00, 33, 35, 00, 33, 34, 35, 33, 35, 33, 35, 00, 33, 34, 35,
        36, 38, 00, 33, 34, 35, 33, 35, 33, 35, 00, 33, 34, 35, 00,
        00, 00, 33, 34, 35, 33, 35, 33, 35, 00, 33, 34, 35, 00, 33,
        00, 33, 34, 35, 33, 35, 36, 38, 00, 33, 34, 35, 00, 33, 35,
        33, 34, 35, 36, 38, 00, 00, 00, 33, 34, 35, 00, 33, 35, 00,
        37, 38, 00, 00, 00, 00, 00, 33, 34, 35, 00, 36, 38, 00, 33,
        00, 00, 00, 00, 00, 00, 36, 37, 38, 00, 00, 00, 00, 33, 35,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 36, 38, 00,
        00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
    };
```

### Tercer paso: *embellish* 

El siguiente paso se trata de coger la información de `map_attr`, decorarla automáticamente, y escribirla en `map_buff`. Para eso utilizamos un sistema de sustituciones basadas en el contexto que puedes reutilizar todo lo que quieras. Se basa en una serie de reglas de 4 bytes que tienen este formato (y que definimos en `my/ci/extra_vars.h`):

```
    t, C, p, s, ..., 0xff
```

* `t` es el tile que hay que sustituir (si se cumple la regla).
* `C` es la regla de comparación
* `p` es el parámetro, será el valor con el que se comparará `t` (si aplica).
* `s` será el valor por el que se sustituirá `t` (que se escribirá en `map_buff`) si se cumple `C`.

La regla de comparación es un valor de 5 bits que se organiza así:

|Valor|Ke ase
|---|---
|`00000`|Sustituir este tile (siempre)
|`--010`|Sustituir si el tile de arriba es igual a
|`--011`|Sustituir si el tile de arriba es diferente de
|`--110`|Sustituir si el tile de abajo es igual a
|`--111`|Sustituir si el tile de abajo es diferente de
|`01--0`|Sustituir si el tile de la izquierda es igual a
|`01--1`|Sustituir si el tile de la izquierda es diferente de
|`11--0`|Sustituir si el tile de la derecha es igual a
|`11--1`|Sustituir si el tile de la derecha es diferente de

Como habrás adivinado (o no) los movimientos horizontal y vertical se pueden combinar, por lo que un valor por ejemplo `01011` significa *sustituir si el tile de arriba a la izquierda es diferente de*. Para hacer todo más legible se definen estas macros que se pueden combinar entre sí para formar todos los valores:

```c
    #define C_EQ    0
    #define C_NEQ   1
    #define C_UP    2
    #define C_DOWN  6
    #define C_LEFT  8
    #define C_RIGHT 24
```

La rutina va recorriendo los valores temporales de `map_attr` uno a uno e iterando sobre la lista de sustituciones. Si el valor actual corresponde a `t`, realiza la comparación entre tile que le diga `C` y `p`. Si se cumple, escribe en `map_buff` el valor `s`; si no, escribe `t`. En cuanto hace una sustitución deja de iterar por la lista de sustituciones y pasa al siguiente tile.

Las sustituciones (`s`) pueden llevar levantados los bits 6 y 7. Si esto ocurre, al valor de `s` se le sumará un valor `rand ()` entre 0 y 1 (si los bits 6 y 7 son 01) o entre 0 y 3 (si son 11). 

La lista de todas las sustituciones está en el array `embellishments` de `my/ci/extra_vars.h`. Vamos a ver un par de ellos para ilustrar mejor como funciona esto.

```c
    // extra_vars.h

    const unsigned char embellishments [] = {
         1, C_NEQ|C_DOWN ,  1,  3,          // 1 -> 3 if b != 1
         1, C_EQ         ,  0,  1 | 0x40,   // 1 -> 1 + rand () & 1
         5, C_NEQ|C_UP   ,  5,  4,          // 5 -> 4 if a != 5
         5, C_NEQ|C_DOWN ,  5,  6,          // 5 -> 6 if b != 5
        10, C_NEQ|C_DOWN , 10, 11,          // 10 -> 11 if b != 10
        29, C_NEQ|C_UP   , 29, 28,          // 29 -> 18 if a != 29
        0xff
    };
```

El proceso recorre, como hemos dicho, todos los tiles *temporales* de la pantalla en orden (esto es, de izquierda a derecha y de arriba a abajo). Veremos que pasa con los tiles 0 y 2, por ejemplo:

![Mapa sin adornos](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/XX_embellishing.png)

El tile 0 de la imagen es el tile número 1 del tileset. Cuando el embellecedor comienza a procesar el array `embellishments` se encuentra una coincidencia con su primera regla, que es:

|t|C|p|s
|---|---|---|---
|1|`C_NEQ OR C_DOWN`|1|3

En esta regla, el comando `C` vale `C_NEQ|C_DOWN` que significa "que el tile de debajo sea distinto de", y el parámetro `p` es 1. Por tanto esta regla de sustitución se cumplirá cuando el tile actual valga 1 (`t`), y el tile de abajo (según `C`) sea distinto de 1 (`p`). En este caso no se cumple, ya que el tile que hay debajo del tile 0 también vale 1, por lo que pasaremos a la siguiente regla, que es:

|t|C|p|s
|---|---|---|---
|1|`C_EQ`|0|`1 OR 0x40`

Las reglas que solo son `C_EQ` se cumplen siempre y no comparan con nada. En este caso `s` vale `1|0x40` que significa 1 más un número aleatorio que puede ser 0 o 1. Esto sirve para alternar entre los dos tipos de piedra (tiles 1 y 2) de forma aleatoria.

Como hemos sustituido, no procesamos más.

El tile siguiente (el 1) es igual, y se actuaría igual. Se escribiría 1 o 2, al azar, en `map_buff`. El siguiente tile, el 2, ya es diferente. La primera regla:

|t|C|p|s
|---|---|---|---
|1|`C_NEQ OR C_DOWN`|1|3

se cumpliría, pues "el tile de abajo es distinto de" (`C`) 1 (`p`). Por lo tanto, el tile que se escribiría en `map_buff` será 3 (el valor de `s`).

Y así con todos los tiles y todas las reglas. Como cuando se cumple una regla ya se pasa al siguiente tile, deberemos ordenar las reglas inteligentemente para obtener el resultado requerido. Por ejemplo, y esto es de cajón, como las reglas con `C` = `C_EQ` se cumplen siempre las colocaremos al final.

Los tiles resultantes de aplicar las reglas se escribirán en `map_buff` si son distintos de 0, y así se verá el fondo que pusimos en el paso 2.

Aquí tenéis el [documento de diseño original del *embellisher*](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/XX_embellisher.pdf) (!)

### Cuarto paso: *render*

En este último paso se coge el contenido de `map_buff`, se rellena en base a él `map_attr` con los comportamientos de tile correspondientes (de `behs`) y se pintan los tiles, sin invalidar, en la pantalla. Y con esto tendríamos compuesta nuestra imagen:

![Mapa con adornos](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/XX_embellished.jpg)

## Tiles rompiscibles decorados

Empleamos el punto de inyección de código `my/ci/on_wall_hit.h` para sustituir los tiles que se están rompiendo por otro gráfico. Este punto de inyección se ejecuta cuando hemos golpeado un tile sin romperlo, así que es ideal para esto:

```c
    // on_wall_hit.h

    // _x, _y contain the tile coordinates.
    _t = 27; draw_invalidate_coloured_tile_gamearea ();
```

## Matar bichos a cabezazos

Emplearemos la misma macro que usamos para determinar que la velocidad era suficiente para romper un bloque, `P_BREAK_VELOCITY_OFFSET`, e inyectaremos nuestro código en `my/ci/custom_emnems_player_collision.h`. 

Detectaremos la colisión de la parte superior de la cabeza del choco con el cuadro de colisión del enemigo y, si se registra esta colisión, llamaremos a `enems_kill` y rebotaremos al choco. No nos debemos olvidar de hacer un `goto player_enem_collision_done;` al final para saltarnos la colisión normal, o si no el choco también perderá vida:

```c
```

Esto tiene un problema: como no está activado ninguno de los motores de "matar enemigos" por defecto no se estará incluyendo el sprite de la explosión (`sprite_17_a`). Para solucionarlo, lo añadimos a mano en `my/ci/extra_vars.h`:

```c

    // extra_vars.h

    [...]

    // Add the explosion manually

    extern unsigned char sprite_17_a []; 
    #asm
        ._sprite_17_a
            BINARY "sprites_extra.bin"
    #endasm
```

