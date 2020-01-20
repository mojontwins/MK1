# Code Injection Points

En este documento veremos para qué sirve cada punto de inyección de código de **MTE MK1** v5. Para obtener información sobre las API de **MTE MK1** y las variables globales consultar [la API](https://github.com/mojontwins/MK1/blob/master/docs/API.md).

## General

### `extra_vars.h`

Se incluye al final de `definitions.h` y permite definir las variables y constantes extra que necesitemos en nuestro código.

### `after_load.h`

Se ejecuta una única vez tras terminar la carga y la inicialización del sistema. Puede emplearse para alguna pantalla tipo *splash screen* o inicializaciones propias.

### `before_game.h`

Se ejecuta antes de empezar el juego, justo tras seleccionar control en la pantalla de título.

### `entering_game.h`

Se ejecuta al empezar el bucle de juego, exactamente igual que la sección `ENTERING GAME` del script. Nótese que `before_game.h` se incluye *antes de empezar el juego* pero `entering_game.h` se incluye *antes de empezar cada nivel*.

### `before_entering_screen.h`

Se ejecuta antes de hacer un cambio de pantalla, justo tras detectar que el jugador va a salir de la misma o, más generalmente, cuando `n_pant` y `o_pant` tienen valores diferentes. En este punto, y en condiciones normales, `o_pant` contendrá el número de la pantalla que estamos abandonando y `n_pant` el de la pantalla a la que nos dirigimos. Justo después de `before_entering_screen.h` se llamará a `draw_scr` y se inicializarán todos los enemigos.

### `entering_screen.h`

Se ejecuta tras el cambio de pantalla, antes de volver al bucle principal, al igual que las secciones `ENTERING SCREEN` del script. En este punto la pantalla ya está en el buffer, los enemigos y hotspots están inicializados, etc.

### `extra_routines.h`

Se ejecuta a cada vuelta del bucle de juego, justo al final, tras haber actualizado todos los actores, dibujado los cambios, etc. Puede usarse para realizar el tipo de tareas que se delegaban a `PRESS_FIRE` en el script pero con más flexibilidad

### `after_game_loop.h`

Se ejecuta al salir del bucle principal del juego. Aquí podremos jugar con los valores de `level`, `success` y `script_result` si queremos implementar lógicas de niveles o quizá aprovechar para mostrar mensajes o secuencias de salida. [En 128K] la música está parada y la pantalla borrada.

## Hotspots

### `hotspots_custom.h`

Sirve para añadir nuevos tipos de hotspots. El código que añadas a este archivo se añadirá al `switch` que comprueba el tipo de hotspot cuando el jugador lo ha tocado, por lo que deberás añadir tu código en forma de nuevos `case` directamente:

```c
	case 7:
		// Mi implementación del hotspot de tipo 7
		beep_fx (7);
		break;

	case 8: 
		// Otro hotspot especial que añado
		++ flags [8];
		break;
```

## Módulo de enemigos

### `enems_load.h`

Junto con `enems_move.h`, sirve para añadir nuevos tipos de enemigos. El código que añadas a este archivo se añadirá al `switch` que comprueba el tipo de enemigo por si hay que inicializar algún valor especial cada vez que se entra en una pantalla, por lo que deberás añadir tu código en forma de nuevos `case` directamente, por ejemplo:

```c
	case 5:
		// This enemy type has a fixed base frame: 
		en_an_base_frame [enit] = 4;
		break;
```

### `enems_move.h`

Junto con `enems_init.h`, sirve para añadir nuevos tipos de enemigos. El código que añadas a este archivo se añadirá al `switch` que comprueba el tipo de enemigo para saber cómo debe moverlo durante el bucle de juego, por lo que deberás añadir tu código en forma de nuevos `case` directamente, por ejemplo: 

```c
	case 5:
		// static, idle, dummy enemy
		active = 1;
		break;
```

En este punto, `enit` es el número de enemigo, `enoffsmasi` su índice general dentro del array `malotes`,  y sus valores estáran copiados en `_en_x`, `_en_y`, `_en_mx`, `_en_my`, `_en_x1`, `_en_y1`, `_en_x2`, `_en_y2`, `_en_t` y `_en_life`. Para que el enemigo sea interactuable (se pueda matar o colisionar) habrá que poner `active` a 1.

### `on_enems_killed.h`

Se ejecuta cada vez que el jugador elimina un enemigo, al igual que la sección `PLAYER_KILLS_ENEMY` del script. En este punto, `enit` es el número de enemigo, `enoffsmasi` su índice general dentro del array `malotes`, etc.

## Módulo de jugador

### `custom_veng.h`

Sirve para añadir un manejador custom para el eje vertical de movimiento del jugador. Esto tiene bastantes implicaciones y formas de usar. Se explicará en un tutorial próximamente.

## Miscelánea

### `on_tile_pushed.h`

Se ejecuta cada vez que hemos empujado un bloque. En este punto podremos usar estas variables para obtener información sobre el bloque que se ha movido:

* `x0`, `y0` son las coordenadas donde estaba el bloque *antes* de moverse.
* `x1`, `y1` son las coordenadas adonde se ha movido el bloque.
* `rda` contiene el valor del tile que se ha cubierto con el bloque.

### `on_unlocked_bolt.h`

Se ejecuta cada vez que el jugador abra un cerrojo. `p_keys` ya se ha decrementado en este punto. El cerrojo está en las coordenadas (`x0, y0`).
