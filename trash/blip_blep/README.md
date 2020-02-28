# Blip Blep

Un juego choco.

TODO description

## Custom vEng

Este güego emplea un motor de eje vertical personalizado que podrás ver descrito en el capítulo 15 del Tutorial de **MTE MK1**.

## Custom map renderer

Otra cosa interesante de **Blip Blep** es que emplea un decodificador de mapas personalizado que se basa en un mapa de 32 tiles comprimido con RLE53 que se descomprime en un buffer provisional para luego embellecerse según un conjunto de reglas sencillas de sustitución basadas en el contexto que puede que te sea útil en tus propios güegos.

El primer paso es decodificar el mapa. Para hacer el mapa hemos empleado muy pocos tiles, sin hacer ningún tipo de adorno, ya que estos adornos se harán posteriormente de manera automática. Así conseguirmos que el compresor RLE obtenga mejores resultados al haber más repetición.

![Mapa sin adornos](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/XX_map_simple.png)

Para esta parte usamos el decompresor de RLE en su versión RLE53 (5 bits de número de tile - 32 diferentes - y 3 bits de contador), pero no vamos a pintar en pantalla ni a rellenar directamente los buffers. Como buffer temporal utilizaremos `map_attr`, que luego machacaremos con los behs correctos al final del proceso.

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
	#define C_EQ 	0
	#define C_NEQ 	1
	#define C_UP 	2
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
		 1, C_NEQ|C_DOWN ,  1,  3,			// 1 -> 3 if b != 1
		 1, C_EQ         ,  0,  1 | 0x40,	// 1 -> 1 + rand () & 1
		 5, C_NEQ|C_UP   ,  5,  4,			// 5 -> 4 if a != 5
		 5, C_NEQ|C_DOWN ,  5,  6, 			// 5 -> 6 if b != 5
		10, C_NEQ|C_DOWN , 10, 11, 			// 10 -> 11 if b != 10
		29, C_NEQ|C_UP   , 29, 28,			// 29 -> 18 if a != 29
		0xff
	};
```

El proceso recorre, como hemos dicho, todos los tiles *temporales* de la pantalla en orden (esto es, de izquierda a derecha y de arriba a abajo). Veremos que pasa con los tiles 0 y 2, por ejemplo:

![Mapa sin adornos](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/XX_embellishing.png)

El tile 0 de la imagen es el tile número 1 del tileset. Cuando el embellecedor comienza a procesar el array `embellishments` se encuentra una coincidencia con su primera regla, que es:

|t|C|p|s
|---|---|---|---
|1|`C_NEQ|C_DOWN`|1|3

En esta regla, el comando `C` vale `C_NEQ|C_DOWN` que significa "que el tile de debajo sea distinto de", y el parámetro `p` es 1. Por tanto esta regla de sustitución se cumplirá cuando el tile actual valga 1 (`t`), y el tile de abajo (según `C`) sea distinto de 1 (`p`). En este caso no se cumple, ya que el tile que hay debajo del tile 0 también vale 1, por lo que pasaremos a la siguiente regla, que es:

|t|C|p|s
|---|---|---|---
|1|`C_EQ`|0|1|0x40

## Tiles rompiscibles decorados

Empleamos el punto de inyección de código `my/ci/on_breakable_hit.h` para sustituir los tiles que se están rompiendo por otro gráfico:


