# API.md

Eventualmente. Dame un respiro D-: Esto va a ser un WIP largo. Dejarse venir con los PDF }:-D

## Variables globales

Aquí las variables globales que te pueden interesar:

### Estado

Estas variables controlan el estado del juego. En qué nivel estamos, en qué pantalla, etcétera.

* `pad0` : entrada del joystick / teclado. Consultar la documentación de splib2 para ver cómo leer la información del teclado (contiene el resultado devuelto por `sp_JoyKeyboard`, `sp_joyKempston` o `sp_JoySinclair1`).
* `flags [MAX_FLAGS]`: Banderas que pueden usarse desde el scripting o desde inyección de código. Son valores que pueden valer de 0 a 127 (en scripting) o de 0 a 255 (en inyección de código).
* `level`: Número de nivel actual.
* `n_pant`: Número de la pantalla actual.
* `o_pant`: Copia del número de la pantalla actual. Se utiliza entre otras cosas para detectar el cambio: si `n_pant != o_pant` hay que cambiar de pantalla. Cada vez que se cambia de pantalla se vuelve a hacer `o_pant = n_pant`.
* `x_pant`, `y_pant` coordenadas de la pantalla dentro del mapa, sólo si `PLAYER_CHECK_MAP_BOUNDARIES`.
* `is_rendering`: está a 1 mientras se está entrando en una nueva pantalla. Se utiliza por las funciones de `printer.h` para saber que no deben invalidar los tiles que dibujen ya que se invalidarán todos de un plumazo al terminar (ahorrando tiempo).
* `maincounter` se va incrementando con cada frame. Como es de tipo `unsigned char` cuando llegue a 255 volverá a 0.

### Generales

* `map_attr [150]` buffer con los comportamientos de todos los tiles de la pantalla actual. Para direccionar este array puede usarse le macro `COORDS(x,y)` que admite coordenadas a nivel de tiles.
* `map_buff [150]` buffer con los valores de todos los tiles de la pantalla actual. Para direccionar este array puede usarse le macro `COORDS(x,y)` que admite coordenadas a nivel de tiles.
* `brk_buff [150]` 'vida' de cada tile de la pantalla actual si es rompiscible (si activamos `BREAKABLE_WALLS`).

### Player

* `p_x`, `p_y`: coordenadas del jugador en punto fijo 10.6, 1/64 de píxel.
* `gpx`, `gpy`: coordenadas del jugador en píxels (`gp? = p_? / 64`).
* `p_tx`, `p_ty`: coordenadas de la casilla (coordenadas de tile) sobre la que está el punto central del sprite del jugador.
* `p_vx`, `p_vy`: velocidad del jugador en cada eje, en 1/64 de píxel por frame.
* `ptgmx`, `ptgmy`: valocidad a la que una plataforma móvil está desplazando al jugador (si `p_gotten` vale 1).
* `p_saltando`: el jugador está saltando.
* `p_cont_salto`: contador de frames de salto.
* `p_facing`: orientación del jugador. En vista lateral, valdrá 0 si mira a la derecha y 1 si mira a la izquierda. En vista genital, tomará un valor `FACING_RIGHT`, `FACING_LEFT`, `FACING_UP` y `FACING_DOWN`
* `p_estado`, `p_ct_estado`: Estados alterables (por ahora, `EST_NORMAL` o '`EST_PARP` (parpadeando)).
* `possee`: en vista lateral, el jugador está sobre una plataforma fija.
* `p_gotten`: en vista lateral, el jugador está moviéndose con una plataforma móvil.
* `p_life`: vida del jugador.
* `p_objs`: cuenta de items coleccionables recogidos.
* `p_keys`: cuenta de llaves que tiene el jugador.
* `p_fuel`: cantidad de combustible para el jet pac.
* `p_killed`: número de enemigos eliminados por el jugador.
* `p_ammo`: munición disponible.
* `p_disparando`: el jugador pulsó el botón de disparo y aún no lo soltó.
* `p_facing_v` y `p_facing_h`: se emplean en la vista genital para almacenar valores temporales que luego se resuelven en `p_facing` dependiendo de si está o no definida `TOP_OVER_SIDE`.
* `p_killme`: el jugador fue alcanzado por un enemigo o colisionó con un tile que mata y debe morir este frame (se consume en el bucle principal a cada vuelta).

### Enemies

Hay un array principal: `malotes` viene del archivo `.ene` convertido y es una estructura en RAM conteniendo valores de todos los enemigos de forma que estos son persistentes entre pantallas; los arrays `en_an_*` contienen todos información de los tres enemigos que hay en la pantalla actual:

* `enoffs`: Offset dentro del array `malotes` de los enemigos de la pantalla actual (vale `n_pant * 3`).
* `malotes`: Información general (persistente) de todos los enemigos del nivel actual. Se trata de un array de structs `MALOTE` con esta definición:

```c
	typedef struct {
		unsigned char x, y;
		unsigned char x1, y1, x2, y2;
		char mx, my;
		char t;
	#ifdef PLAYER_CAN_FIRE
		unsigned char life;
	#endif
	} MALOTE;
```

* `enit`: Se utiliza siempre para iterar enemigos. En los puntos de inyección de código que se incluyen dentro de bucles de enemigos (`enems_load.h`, `enems_move.h`, `on_enems_killed`), siempre apunta al enemigo actual que se está procesando.
* `en_an_base_frame [3]`: Frame base (0, 2, 4 o 6) de los enemigos. Sirven para construir índices de la tabla `enem_frames`, que contiene punteros a los 8 gráficos de los enemigos:

```c
	const unsigned char *enem_frames [] = {
		sprite_9_a, sprite_10_a, sprite_11_a, sprite_12_a, 
		sprite_13_a, sprite_14_a, sprite_15_a, sprite_16_a
	};
```

* `en_an_frame [3]`, `en_an_count` se utilizan para animar a los enemigos normales. Cada 4 frames (contadas por `en_an_count`), el valor de cada `en_an_frame` alterna entre 0 y 1. `en_an_count` También se utiliza como contador de frames mientras se muestra la explosión en modo 128K.
* `en_an_next_frame [3]`: contiene un puntero al gráfico con el que se actualizará el sprite. Los sprites de los enemigos se animan cambiando estos valores.
* `en_an_current_frame [3]`: contiene un puntero al gráfico que muestra el sprite. Se emplea internamente junto con `en_an_next_frame` pues las funciones de splib2 necesitan un desplazamiento en cada cuadro de juego para saber si cambiar el gráfico.
* `en_an_state [3]`: estado actual de cada enemigo. Se emplea para señalar que un sprite está en su animación de morir (en modo 128K) o para contener el estado actual de los enemigos tipo fanties si se han configurado de tipo *homing*.

#### Fanties

* `en_an_x [3]`, `en_an_y [3]` contienen coordenadas de punto fijo (1/64 de pixel) de los enemigos tipo fanties.
* `en_an_vx [3]`, `en_an_vy [3]` contienen velocidades en cada eje en 1/64 de píxel por frame de los enemigos tipo fanties.

#### EIJs (perseguidores)

* `en_an_alive [3]` el enemigo está "muerto" (sin aparecer, valor 0), "apareciendo" (valor 1), o "vivo" (ha aparecido, está moviéndose y es matable, valor 2).
* `en_an_dead_row [3]` cuenta de frames que el enemigo debe permanecer en el estado 0.
* `en_an_rawv [3]` es el valor absoluto de la velocidad con la que se mueve el sprite y valdrá 1, 2 o 4.

#### Copias temporales

Para ahorrar tiempo y memoria (y hacer que el posible paso a ensamble se más sencillo) a cada frame y para cada enemigo se copian temporalmente los valores de `malotes` en el siguiente conjunto de variables temporales (nótese que hay una por cada componente del struct).  En los puntos de inyección de código `enems_move.h` y `on_enems_killed` contendrán los valores del enemigo actual **y pueden modificarse**, ya que al final de cada vuelta del bucle de actualización se actualiza `malotes` con los nuevos valores.

* `_en_x`, `_en_y`: Coordenadas (en pixels) del enemigo actual.
* `_en_x1`, `_en_x2`, `_en_y1`, `_en_y2`: Límites de trayectoria del enemigo actual. `_en_x1`, `_en_y1` se utilizan además en los fanties y en los EIJs para señalar el punto de origen donde fueron definidos los enemigos en Ponedor. Puedes reutilizar estas variables en tus tipos custom de enemigos como quieras.
* `_en_mx`, `_en_my`: Píxels en cada eje que deberá moverse el enemigo en el frame actual.
* `_en_t`: Tipo del enemigo.
* `_en_life`: Vida del enemigo.

## Balas

* `bullets_estado [MAX_BULLETS]` vale 1 si la bala está activa.
* `bullets_x [MAX_BULLETS]` y `bullets_y [MAX_BULLETS]` contienen las coordenadas en pixels de la bala.
* `bullets_mx [MAX_BULLETS]` y `bullets_my [MAX_BULLETS]` contienen cuántos píxels debe moverse cada bala en cada eje cada frame mientras esté activa.
* `bullets_life [MAX_BULLETS]` "duración" de la bala, que se decrementa cada frame hasta llegar a 0, momento en el que la bala desaparece, si se activa `LIMITED_BULLETS`.

### Hotspots

Los hotspots del nivel actual se almacenan en un array `hotspots` de estructuras `HOTSPOT` que tiene estos miembros:

```c
	typedef struct {
		unsigned char xy, tipo, act;
	} HOTSPOT;
```

Si el hotspot de la pantalla actual está activo (no se ha recogido y es distinto de 0), entonces:

* `hotspot_x`, `hotspot_y` coordenadas (en pixels) del hotspot. El jugador colisionará con el cuadrado que va desde este punto hasta (`hotspot_x` + 15, `hotspot_y` + 15).
* `orig_tile` es el tile que había originalmente en lugar del hotspot.

### Timer

* `timer_on` - El temporizador está activo.
* `timer_t` - Valor del temporizador.
* `timer_frames` - El valor de `timer_t` se decrementa cada `timer_frames` cuadros de juego.
* `timer_count` - Contador de cuadros. Cuando llega a `timer_frames` se decrementa `timer_t`.
* `timer_zero` - Se pone a 1 cada vez que `timer_t` llega a 0.

### Scripting

* `f_zone_ac` vale 1 si `ENABLE_FIRE_ZONE` está activo y hemos definido desde el script una *fire zone*.
* `fzx1`, `fzy1`, `fzx2`, `fzy2` son los límites del rectángulo definido como *fire zone*.

### Miscelánea

* `pushed_any` se activa al empujar con el botón de disparo si `FIRE_TO_PUSH` y sirve como flag interno para no soltar un disparo.
* `rdx`, `rdy`, `rda`, `rdb`, `rdc`, `rdd`, `rdn` son variables para hacer tiestos temporales.
* `gen_pt` puntero de propósito general
* `_x`, `_y`, `_n`, `_t`, `_gp_gen` se emplean como "pseudoparámetros" para muchas funciones de la API.
* `cx1`, `cy1`, `cx2`, `cy2`, `at1`, `at2` son "pseudoparámetros" de entrada y salida para funciones de colisión.
* `x0`, `y0`, `x1`, `y1` se emplean como "pseudoparámetros" en funciones de mover y destruir tiles.
* `ptx1`, `pty1`, `ptx2`, `pty2` se utilizan para definir el *bounding box* para la colisión del jugador con el escenario.

## Funciones

Esta referencia no cubre todas y cada una de las funciones del motor, ya que hay mucho de tramolla interna que poco uso va a darte a la hora de escribir código custom en los puntos de inyección de código. Estas son, pues, las **funciones interesantes**, divididas en módulos.

Puedes ver una lista de todas las funciones de **MTE MK1** en el archivo `dev/prototypes.h`.

Hay muchas funciones que no reciben parámetros pero sí *pseudoparámetros* en forma de valores a variables globales generales. Estos suelen ser las variables `_x`, `_y`, `_n`, `_t`, y `_gp_gen`.

### Printer

#### `void draw_coloured_tile (void)`

Dibuja un tile del tileset **sin invalidarlo** en cualquier punto de la pantalla (incluso fuera del área de juego o *viewport*). La función espera estos *pseudoparámetros*:

* `_x`, `_y`: coordenadas de **caracter** (x = 0-30; y = 0-22) donde imprimir el tile.
* `_t`: Número de tile (0-47).

Para que el tile se actualizado en la próxima llamada a `sp_UpdateNow` o `sp_UpdateNowEx` habrá que llamar a la siguiente función, `invalidate_tile`, sobre las mismas coordenadas.

#### `void invalidate_tile (void)`

Invalida un área del buffer de 2x2 caracteres. La función espera estos *pseudoparámetros*:

* `_x`, `_y`: coordenadas de **caracter** (x = 0-30; y = 0-22) donde imprimir el tile.

#### `void invalidate_viewport (void)`

Invalida todo el área de juego (30x20 carácteres a partir de (`VIEWPORT_X`, `VIEWPORT_Y`)). Los cambios serán visibles en la próxima llamada a `sp_UpdateNow` o `sp_UpdateNowEx`.

#### `draw_coloured_tile_gamearea (void)`

Dibuja un tile del tileset en la rejilla del área de juego **sin invalidarlo**. Generalmente no llamaremos a esta función directamente. La función espera estos *pseudoparámetros*:

* `_x`, `_y`: coordenadas de **rejilla de tile** (x = 0-14; y = 0-9) donde imprimir el tile.
* `_t`: Número de tile (0-47).

#### `draw_invalidate_coloured_tile_gamearea (void)`

Dibuja un tile del tileset en la rejilla del área de juego y lo invalida (internamente hace una llamada a `draw_coloured_tile_gamearea` y otra a `invalidate_tile`). La función espera estos *pseudoparámetros*:

* `_x`, `_y`: coordenadas de **rejilla de tile** (x = 0-14; y = 0-9) donde imprimir el tile.
* `_t`: Número de tile (0-47).

#### `update_tile (void)`

Dibuja un tile del tileset en la rejilla del área de juego, lo invalida, y actualiza los buffers `map_buff` y `map_attr`, haciendo el tile interactuable (internamente hace una llamada a `draw_invalidate_coloured_tile_gamearea` y posteriormente modifica los buffers). La función espera estos *pseudoparámetros*:

* `_x`, `_y`: coordenadas de **rejilla de tile** (x = 0-14; y = 0-9) donde imprimir el tile.
* `_t`: Número de tile (0-47).
* `_n`: Valor para beh, que puede ser `behs [_t]` o cualquier otro valor.

#### `void print_number2 (void)`

Imprime un número decimal de dos cifras en el color `HUD_INK` (definido en `my/config.h`). Internamente se utiliza para los marcadores. La función espera estos *pseudoparámetros*:

* `_x`, `_y`: coordenadas de **caracter** (x = 0-30; y = 0-22) donde imprimir el valor.
* `_t`: Valor (0-99).

#### `void print_str (void)`

Imprime el contenido de una cadena o cualquier buffer terminado en 0 en pantalla. La función espera estos *pseudoparámetros*:

* `_x`, `_y`: coordenadas de **caracter** (x = 0-30; y = 0-22) donde imprimir la cadena.
* `_t`: atributo (color).
* `_gp_gen`: debe apuntar al inicio de la cadena o del buffer terminado en 0.

Recordemos que podemos hacer algo así en C y que z88dk el quisquilloso se lo come:

```c
	_x = 2; _y = 2; _t = 6;
	_gp_gen = "OLA K ASE";
	print_str ();
```

#### `void blackout_area (void)`

Pinta de negro el área de juego.

#### `void clear_sprites (void)`

Saca los sprites de la pantalla. El resultado será visible en el próximo `sp_UpdateNow ()`.

### Contenido de los buffers y colisión

#### `unsigned char attr (char x, char y)`

Devuelve el comportamiento del tile situado en las coordenadas (`x`, `y`) de la rejilla de la pantalla actual. Equivale a `map_attr [COORDS (x,y)]`.

#### `unsigned char qtile (unsigned char x, unsigned char y)`

Devuelve el número del tile situado en las coordenadas (`x`, `y`) de la rejilla de la pantalla actual. Equivale a `map_buff [COORDS (x,y)]`.

#### `unsigned char collide (void)`

Sirve para saber si el player colisiona con un ente de 16x16 pixels situado en las coordenadas (`cx2`, `cy2`). Si se define `SMALL_COLLISION` la caja de colisión es de 8x8. Si no, es de 13x13. Devuelve `1` si hay colisión.

#### `unsigned char cm_two_points (void)`

Se emplea para hacer colisiones por caja cuando un objeto avanza en cierta dirección. Devuelve los comportamientos de los tiles que tocan los puntos (`cx1`, `cy1`) y (`cx2`, `cy2`) en las variables `at1` y `at2`, respectivamente.

### Enemigos

#### `void enems_draw_current (void)`

Actualiza el sprite del enemigo `enit` a la posición `_en_x`, `_en_y` y cambia su gráfico si `en_an_current_frame` ha cambiado.

#### `void enems_kill (void)`

Mata al enemigo `enit` (levanta el bit 4 de `_en_t`). Nótese que si se llama desde fuera el bucle principal de enemigos habrá que dar un valor correcto a `_en_t` antes de llamar y actualizar el array `malotes` después:

```c 
	_en_t = malotes [enoffs + enit].t;
	enems_kill ();
	malotes [enoffs + enit].t = _en_t;
```

### Sonido (48K)

#### `void beep_fx (unsigned char n)`

Toca el efecto de sonido `n` (0-9). Esta es la tabla de sonidos:

|#|Cosa
|---|---
|0|Enemigo / tile destruido
|1|Enemigo / tile golpeado
|2|Empujar bloque
|3|Salto
|4|Jugador golpeado
|5|Enemigo pisado
|6|Disparo
|7|Coger llave / Recarga de tiempo
|8|Abrir cerrojo / Coger refill
|9|Coger objeto / Munición

### Sonido (128K)

#### `void wyz_play_sound (unsigned char fx_number)`

#### `void wyz_play_music (unsigned char song_number)`

#### `void wyz_stop_sound (void)`

### Miscelanea

#### `unsigned char rand (void)`

Devuelve un número pseudo-aleatorio entre 0 y 255: `rda = rand ();`.

#### `unsigned int abs (int n)`

Devuelve el valor absoluto de un número.

#### `void step (void)`

Hace un sonidito minimal de "paso".

#### `void cortina (void)`

Efecto de borrado de pantalla bonito.

## Bajo nivel y splib2

#### Imprimir un caracter

#### Leer los controles


