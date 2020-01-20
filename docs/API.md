# API.md

Eventualmente. Dame un respiro D-: Esto va a ser un WIP largo. Dejarse venir con los PDF }:-D

## Variables globales

Aquí las variables globales que te pueden interesar:

### Estado

Estas variables controlan el estado del juego. En qué nivel estamos, en qué pantalla, etcétera.

* `pad0` : entrada del joystick / teclado. Consultar la documentación de splib2 para ver cómo leer la información del teclado (contiene el resultado devuelto por `sp_JoyKeyboard`, `sp_joyKempston` o `sp_JoySinclair1`).


### Player

* `p_x`, `p_y`: coordenadas del jugador en punto fijo 10.6, 1/64 de píxel.
* `gpx`, `gpy`: coordenadas del jugador en píxels (`gp? = p_? / 64`).
* `p_vx`, `p_vy`: velocidad del jugador en cada eje, en 1/64 de píxel por frame.
* `p_saltando`: el jugador está saltando.
* `p_cont_salto`: contador de frames de salto.
* `p_facing`: orientación del jugador. En vista lateral, valdrá 0 si mira a la derecha y 1 si mira a la izquierda. En vista genital, tomará un valor `FACING_RIGHT`, `FACING_LEFT`, `FACING_UP` y `FACING_DOWN`

### Enemies

* `enoffs`: Offset dentro del array `malotes` de los enemigos de la pantalla actual (vale `n_pant * 3`).

### Hotspots

### Generales

## Funciones
