# API.md

Eventualmente. Dame un respiro D-: Esto va a ser un WIP largo. Dejarse venir con los PDF }:-D

## Antes de empezar

¿Cuánto puede ocupar mi güego? Pues en 48K la pila se coloca bajando desde 61697. No suele ocupar mucho, y 61697 - 24000 = 37697. Pongamos que **37.500 bytes** es una buena marca.

## Variables globales

Aquí las variables globales que te pueden interesar:

### Estado

Estas variables controlan el estado del juego. En qué nivel estamos, en qué pantalla, etcétera.

* `pad0` : entrada del joystick / teclado. Consultar la documentación de splib2 para ver cómo leer la información del teclado (contiene el resultado devuelto por `sp_JoyKeyboard`, `sp_joyKempston` o `sp_JoySinclair1`).
* `flags [MAX_FLAGS]`: Banderas que pueden usarse desde el _scripting_ o desde inyección de código. Son valores que pueden valer de 0 a 127 (en _scripting_) o de 0 a 255 (en inyección de código).
* `level`: Número de nivel actual.
* `warp_to_level`: **Si no está activo el scripting**, podemos poner a 1 esta variable mediante inyección de código, establecer `level`, `n_pant`, `p_x`, `p_y`, `gpx` y `gpy` y poner `playing` a 0 para saltar a cualquier punto de otro nivel.
* `n_pant`: Número de la pantalla actual.
* `o_pant`: Copia del número de la pantalla actual. Se utiliza entre otras cosas para detectar el cambio: si `n_pant != o_pant` hay que cambiar de pantalla. Cada vez que se cambia de pantalla se vuelve a hacer `o_pant = n_pant`.
* `x_pant`, `y_pant` coordenadas de la pantalla dentro del mapa, sólo si `PLAYER_CHECK_MAP_BOUNDARIES`.
* `is_rendering`: está a 1 mientras se está entrando en una nueva pantalla. Se utiliza por las funciones de `printer.h` para saber que no deben invalidar los _tiles_ que dibujen ya que se invalidarán todos de un plumazo al terminar (ahorrando tiempo).
* `maincounter` se va incrementando con cada _frame_. Como es de tipo `unsigned char` cuando llegue a 255 volverá a 0.

### Generales

* `map_attr [150]` _buffer_ con los comportamientos de todos los _tiles_ de la pantalla actual. Para direccionar este array puede usarse le macro `COORDS(x,y)` que admite coordenadas a nivel de _tiles_.
* `map_buff [150]` _buffer_ con los valores de todos los _tiles_ de la pantalla actual. Para direccionar este array puede usarse la macro `COORDS(x,y)` que admite coordenadas a nivel de _tiles_.
* `brk_buff [150]` 'vida' de cada _tile_ de la pantalla actual si es rompiscible (si activamos `BREAKABLE_WALLS`).

### Player

* `p_x`, `p_y`: coordenadas del jugador en punto fijo 12.4, 1/14 de píxel.
* `gpx`, `gpy`: coordenadas del jugador en píxeles (`gp? = p_? / 64`).
* `p_tx`, `p_ty`: coordenadas de la casilla (coordenadas de tile) sobre la que está el punto central del sprite del jugador.
* `p_vx`, `p_vy`: velocidad del jugador en cada eje, en 1/16 de píxel por frame.
* `ptgmx`, `ptgmy`: velocidad a la que una plataforma móvil está desplazando al jugador (si `p_gotten` vale 1).
* `p_saltando`: el jugador está saltando.
* `p_cont_salto`: contador de _frames_ de salto.
* `p_jetpac_on`: el jetpac está propulsando (estamos pulsando *arriba*).
* `p_facing`: orientación del jugador. En vista lateral, valdrá 0 si mira a la derecha y 1 si mira a la izquierda. En vista genital, tomará un valor `FACING_RIGHT`, `FACING_LEFT`, `FACING_UP` y `FACING_DOWN`
* `p_estado`, `p_ct_estado`: Estados alterables (por ahora, `EST_NORMAL` o '`EST_PARP` (parpadeando)).
* `possee`: en vista lateral, el jugador está sobre una plataforma fija.
* `p_gotten`: en vista lateral, el jugador está moviéndose con una plataforma móvil.
* `p_life`: vida del jugador.
* `p_objs`: cuenta de ítems coleccionables recogidos.
* `p_keys`: cuenta de llaves que tiene el jugador.
* `p_fuel`: cantidad de combustible para el jetpac.
* `p_killed`: número de enemigos eliminados por el jugador.
* `p_ammo`: munición disponible.
* `p_disparando`: el jugador pulsó el botón de disparo y aún no lo soltó.
* `p_facing_v` y `p_facing_h`: se emplean en la vista genital para almacenar valores temporales que luego se resuelven en `p_facing` dependiendo de si está o no definida `TOP_OVER_SIDE`.
* `p_killme`: el jugador fue alcanzado por un enemigo o colisionó con un _tile_ que mata y debe morir este _frame_ (se consume en el bucle principal a cada vuelta).
* `p_kill_amt`: cuánta vida se restará cuando `p_killme` se pone a cierto. Se resetea a 1 al principio de cada _frame_.

### Enemies

Hay un array principal: `malotes` viene del archivo `.ene` convertido y es una estructura en RAM conteniendo valores de todos los enemigos de forma que estos son persistentes entre pantallas; los arrays `en_an_*` contienen todos información de los tres enemigos que hay en la pantalla actual:

* `enoffs`: _Offset_ dentro del array `malotes` de los enemigos de la pantalla actual (vale `n_pant * 3`).
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
* `en_an_base_frame [3]`: _Frame_ base (0, 2, 4 ó 6) de los enemigos. Sirven para construir índices de la tabla `enem_cells`, que contiene punteros a los 8 gráficos de los enemigos:

```c
    const unsigned char *enem_cells [] = {
        sprite_9_a, sprite_10_a, sprite_11_a, sprite_12_a,
        sprite_13_a, sprite_14_a, sprite_15_a, sprite_16_a
    };
```

* `en_an_frame [3]`, `en_an_count` se utilizan para animar a los enemigos normales. Cada 4 _frames_ (contadas por `en_an_count`), el valor de cada `en_an_frame` alterna entre 0 y 1. `en_an_count` También se utiliza como contador de _frames_ mientras se muestra la explosión en modo 128K.
* `en_an_next_frame [3]`: contiene un puntero al gráfico con el que se actualizará el _sprite_. Los _sprites_ de los enemigos se animan cambiando estos valores.
* `en_an_current_frame [3]`: contiene un puntero al gráfico que muestra el _sprite_. Se emplea internamente junto con `en_an_next_frame` pues las funciones de splib2 necesitan un desplazamiento en cada cuadro de juego para saber si cambiar el gráfico.
* `en_an_state [3]`: estado actual de cada enemigo. Se emplea para señalar que un _sprite_ está en su animación de morir (en modo 128K) o para contener el estado actual de los enemigos tipo fanties si se han configurado de tipo *homing*.

#### Fanties

* `en_an_x [3]`, `en_an_y [3]` contienen coordenadas de punto fijo (1/16 de pixel) de los enemigos tipo fanties.
* `en_an_vx [3]`, `en_an_vy [3]` contienen velocidades en cada eje en 1/16 de píxel por frame de los enemigos tipo fanties.

#### EIJs (perseguidores)

* `en_an_alive [3]` el enemigo está "muerto" (sin aparecer, valor 0), "apareciendo" (valor 1), o "vivo" (ha aparecido, está moviéndose y es matable, valor 2).
* `en_an_dead_row [3]` cuenta de _frames_ que el enemigo debe permanecer en el estado 0.
* `en_an_rawv [3]` es el valor absoluto de la velocidad con la que se mueve el _sprite_ y valdrá 1, 2 ó 4.

#### Copias temporales

Para ahorrar tiempo y memoria (y hacer que el posible paso a ensamble se más sencillo) a cada _frame_ y para cada enemigo se copian temporalmente los valores de `malotes` en el siguiente conjunto de variables temporales (nótese que hay una por cada componente del struct).  En los puntos de inyección de código `enems_move.h` y `on_enems_killed` contendrán los valores del enemigo actual **y pueden modificarse**, ya que al final de cada vuelta del bucle de actualización se actualiza `malotes` con los nuevos valores.

* `_en_x`, `_en_y`: Coordenadas (en píxeles) del enemigo actual.
* `_en_x1`, `_en_x2`, `_en_y1`, `_en_y2`: Límites de trayectoria del enemigo actual. `_en_x1`, `_en_y1` se utilizan además en los fanties y en los EIJs para señalar el punto de origen donde fueron definidos los enemigos en Ponedor. Puedes reutilizar estas variables en tus tipos _custom_ de enemigos como quieras.
* `_en_mx`, `_en_my`: Píxeles en cada eje que deberá moverse el enemigo en el _frame_ actual.
* `_en_t`: Tipo del enemigo.
* `_en_life`: Vida del enemigo.

## Balas

* `bullets_estado [MAX_BULLETS]` vale 1 si la bala está activa.
* `bullets_x [MAX_BULLETS]` y `bullets_y [MAX_BULLETS]` contienen las coordenadas en píxeles de la bala.
* `bullets_mx [MAX_BULLETS]` y `bullets_my [MAX_BULLETS]` contienen cuántos píxeles debe moverse cada bala en cada eje cada frame mientras esté activa.
* `bullets_life [MAX_BULLETS]` "duración" de la bala, que se decrementa cada _frame_ hasta llegar a 0, momento en el que la bala desaparece, si se activa `LIMITED_BULLETS`.

### Hotspots

Los _hotspots_ del nivel actual se almacenan en un array `hotspots` de estructuras `HOTSPOT` que tiene estos miembros:

```c
    typedef struct {
        unsigned char xy, tipo, act;
    } HOTSPOT;
```

Si el _hotspot_ de la pantalla actual está activo (no se ha recogido y es distinto de 0), entonces:

* `hotspot_x`, `hotspot_y` coordenadas (en píxeles) del _hotspot_. El jugador colisionará con el cuadrado que va desde este punto hasta (`hotspot_x` + 15, `hotspot_y` + 15).
* `orig_tile` es el _tile_ que había originalmente en lugar del _hotspot_.

### Timer

* `timer_on` - El temporizador está activo.
* `timer_t` - Valor del temporizador.
* `timer_frames` - El valor de `timer_t` se decrementa cada `timer_frames` cuadros de juego.
* `timer_count` - Contador de cuadros. Cuando llega a `timer_frames` se decrementa `timer_t`.
* `timer_zero` - Se pone a 1 cada vez que `timer_t` llega a 0.

### Scripting

* `f_zone_ac` vale 1 si `ENABLE_FIRE_ZONE` está activo y hemos definido desde el _script_ una *fire zone*.
* `fzx1`, `fzy1`, `fzx2`, `fzy2` son los límites del rectángulo definido como *fire zone*.

### Miscelánea

* `pushed_any` se activa al empujar con el botón de disparo si `FIRE_TO_PUSH` y sirve como flag interna para no soltar un disparo.
* `rdx`, `rdy`, `rda`, `rdb`, `rdc`, `rdd`, `rdn` son variables para hacer tiestos temporales.
* `gen_pt` puntero de propósito general
* `_x`, `_y`, `_n`, `_t`, `_gp_gen` se emplean como "pseudoparámetros" para muchas funciones de la API.
* `cx1`, `cy1`, `cx2`, `cy2`, `at1`, `at2` son "pseudoparámetros" de entrada y salida para funciones de colisión.
* `x0`, `y0`, `x1`, `y1` se emplean como "pseudoparámetros" en funciones de mover y destruir _tiles_.
* `ptx1`, `pty1`, `ptx2`, `pty2` se utilizan para definir el *bounding box* para la colisión del jugador con el escenario.

### Cells de animación

* `player_cells []` es un array que contiene 8 punteros a los 8 _cells_ de animación para el jugador. Puedes usarlo si defines `PLAYER_CUSTOM_ANIMATION` e implementas tu propio sistema de animación.
* `enem_cells []` es un array que contiene 8 punteros a los 8 _cells_ de animación para los enemigos.

## Funciones

Esta referencia no cubre todas y cada una de las funciones del motor, ya que hay mucho de tramoya interna que poco uso va a darte a la hora de escribir código _custom_ en los puntos de inyección de código. Estas son, pues, las **funciones interesantes**, divididas en módulos.

Puedes ver una lista de todas las funciones de **MTE MK1** en el archivo `dev/prototypes.h`.

Hay muchas funciones que no reciben parámetros pero sí *pseudoparámetros* en forma de valores a variables globales generales. Estos suelen ser las variables `_x`, `_y`, `_n`, `_t`, y `_gp_gen`.

### Printer

#### `void draw_coloured_tile (void)`

Dibuja un _tile_ del _tileset_ **sin invalidarlo** en cualquier punto de la pantalla (incluso fuera del área de juego o *viewport*). La función espera estos *pseudoparámetros*:

* `_x`, `_y`: coordenadas de **carácter** (x = 0-30; y = 0-22) donde imprimir el _tile_.
* `_t`: Número de tile (0-47).

Para que el _tile_ se actualizado en la próxima llamada a `sp_UpdateNow` o `sp_UpdateNowEx` habrá que llamar a la siguiente función, `invalidate_tile`, sobre las mismas coordenadas.

#### `void invalidate_tile (void)`

Invalida un área del _buffer_ de 2x2 caracteres. La función espera estos *pseudoparámetros*:

* `_x`, `_y`: coordenadas de **carácter** (x = 0-30; y = 0-22) donde imprimir el _tile_.

#### `void invalidate_viewport (void)`

Invalida todo el área de juego (30x20 caracteres a partir de (`VIEWPORT_X`, `VIEWPORT_Y`)). Los cambios serán visibles en la próxima llamada a `sp_UpdateNow` o `sp_UpdateNowEx`.

#### `draw_coloured_tile_gamearea (void)`

Dibuja un _tile_ del _tileset_ en la rejilla del área de juego **sin invalidarlo**. Generalmente no llamaremos a esta función directamente. La función espera estos *pseudoparámetros*:

* `_x`, `_y`: coordenadas de **rejilla de tile** (x = 0-14; y = 0-9) donde imprimir el _tile_.
* `_t`: Número de _tile_ (0-47).

#### `draw_invalidate_coloured_tile_gamearea (void)`

Dibuja un _tile_ del _tileset_ en la rejilla del área de juego y lo invalida (internamente hace una llamada a `draw_coloured_tile_gamearea` y otra a `invalidate_tile`). La función espera estos *pseudoparámetros*:

* `_x`, `_y`: coordenadas de **rejilla de tile** (x = 0-14; y = 0-9) donde imprimir el _tile_.
* `_t`: Número de _tile_ (0-47).

#### `update_tile (void)`

Dibuja un _tile_ del _tileset_ en la rejilla del área de juego, lo invalida, y actualiza los _buffers_ `map_buff` y `map_attr`, haciendo el _tile_ interactuable (internamente hace una llamada a `draw_invalidate_coloured_tile_gamearea` y posteriormente modifica los _buffers_). La función espera estos *pseudoparámetros*:

* `_x`, `_y`: coordenadas de **rejilla de tile** (x = 0-14; y = 0-9) donde imprimir el _tile_.
* `_t`: Número de _tile_ (0-47).
* `_n`: Valor para beh, que puede ser `behs [_t]` o cualquier otro valor.

#### `void draw_decorations (void)`

Sirve para pintar ristras de _tiles_ (decoraciones). s. `draw_decorations` espera que `_gp_gen` apunte a una colección de decoraciones terminada en `0xff`. Podemos crear arrays con decoraciones en `my/ci/extra_vars.h`.

#### `void print_number2 (void)`

Imprime un número decimal de dos cifras en el color `HUD_INK` (definido en `my/config.h`). Internamente se utiliza para los marcadores. La función espera estos *pseudoparámetros*:

* `_x`, `_y`: coordenadas de **carácter** (x = 0-30; y = 0-22) donde imprimir el valor.
* `_t`: Valor (0-99).

#### `void print_str (void)`

Imprime el contenido de una cadena o cualquier _buffer_ terminado en 0 en pantalla. La función espera estos *pseudoparámetros*:

* `_x`, `_y`: coordenadas de **carácter** (x = 0-30; y = 0-22) donde imprimir la cadena.
* `_t`: atributo (color).
* `_gp_gen`: debe apuntar al inicio de la cadena o del _buffer_ terminado en 0.

Recordemos que podemos hacer algo así en C y que z88dk el quisquilloso se lo come:

```c
    _x = 2; _y = 2; _t = 6;
    _gp_gen = "OLA K ASE";
    print_str ();
```

#### `void blackout_area (void)`

Pinta de negro el área de juego.

#### `void clear_sprites (void)`

Saca los _sprites_ de la pantalla. El resultado será visible en el próximo `sp_UpdateNow ()`.

### Contenido de los buffers y colisión

#### `unsigned char attr (char x, char y)`

Devuelve el comportamiento del _tile_ situado en las coordenadas (`x`, `y`) de la rejilla de la pantalla actual. Equivale a `map_attr [COORDS (x,y)]`.

#### `unsigned char qtile (unsigned char x, unsigned char y)`

Devuelve el número del _tile_ situado en las coordenadas (`x`, `y`) de la rejilla de la pantalla actual. Equivale a `map_buff [COORDS (x,y)]`.

#### `unsigned char collide (void)`

Sirve para saber si el _player_ colisiona con un ente de 16x16 píxeles situado en las coordenadas (`cx2`, `cy2`). Si se define `SMALL_COLLISION` la caja de colisión es de 8x8. Si no, es de 13x13. Devuelve `1` si hay colisión.

#### `unsigned char cm_hb_collision (void)`

Se emplea para hacer colisiones por caja cuando un objeto avanza en cierta dirección. Devuelve los comportamientos de los _tiles_ que tocan los puntos (`cx1`, `cy1`) y (`cx2`, `cy2`) en las variables `at1` y `at2`, respectivamente.

### Enemigos

#### `void enems_draw_current (void)`

Actualiza el _sprite_ del enemigo `enit` a la posición `_en_x`, `_en_y` y cambia su gráfico si `en_an_current_frame` ha cambiado.

#### `void enems_kill (void)`

Mata al enemigo `enit` (levanta el bit 4 de `_en_t`). Nótese que si se llama desde fuera el bucle principal de enemigos habrá que dar un valor correcto a `_en_t` antes de llamar y actualizar el array `malotes` después:

```c
    _en_t = malotes [enoffs + enit].t;
    enems_kill ();
    malotes [enoffs + enit].t = _en_t;
```

### Jugador

#### `void player_deplete (void)`

Resta a la vida del jugador `p_kill_amt` unidades que, si no lo hemos modificado durante el _frame_ actual, valdrá 1.

### Sonido (48K)

#### `void beep_fx (unsigned char n)`

Toca el efecto de sonido `n` (0-9). Esta es la tabla de sonidos:

|#|Cosa
|---|---
|0|Enemigo / _tile_ destruido
|1|Enemigo / _tile_ golpeado
|2|Empujar bloque
|3|Salto
|4|Jugador golpeado
|5|Enemigo pisado
|6|Disparo
|7|Coger llave / Recarga de tiempo
|8|Abrir cerrojo / Coger _refill_
|9|Coger objeto / Munición

### Sonido (128K)

#### `void wyz_play_sound (unsigned char fx_number)`

#### `void wyz_play_music (unsigned char song_number)`

#### `void wyz_stop_sound (void)`

### Miscelánea

#### `unsigned char rand (void)`

Devuelve un número pseudo-aleatorio entre 0 y 255: `rda = rand ();`.

#### `unsigned int abs (int n)`

Devuelve el valor absoluto de un número.

#### `void step (void)`

Hace un sonidito minimal de "paso".

#### `void cortina (void)`

Efecto de borrado de pantalla bonito.

### Compresión

#### `void get_resource (unsigned char n, unsigned int destination);`

Está disponible en modo `128K` y sirve para descomprimir un recurso situado en RAM extra en la dirección de memoria `destination`. `n` es el número de recurso y, obviamente, podemos usar las constantes que crea **The Librarian**.

#### `void unpack (unsigned int from, unsigned int to);`

Está disponible en modo `48K` cuando se activa `COMPRESSED_LEVELS`. Sirve para descomprimir desde la dirección `from` a la dirección `to`. Pueden usarse punteros si les haces un cast a `(unsigned int)`.

## El juego de caracteres y el _tileset_

Al estar construido sobre **splib2**, **MTE MK1** es capaz de presentar 256 patrones, o caracteres, o trozos de 8x8 píxeles. De estos 256 caracteres, los primeros 64 se utilizan para imprimir textos y valores numéricos, y los 192 restantes para componer hasta 48 _metatiles_ de 2x2 patrones.

Entender cómo se organizan estos _tiles_ en memoria viene muy bien para hacer muchas fullerías interesantes.

### Modo sencillo: un solo nivel

En el modo sencillo, que se emplea cuando el juego solo lleva un nivel (esto es, `COMPRESSED_LEVELS` está desactivado), el _charset_, el _tileset_, y los atributos ocupan una zona de memoria contigua de 2.304 bytes a partir de la dirección de memoria a la que apunta la variable `tileset`:

- 512 bytes para los 64 caracteres de la fuente (8 × 64 = 512).
- 1.536 bytes para los 192 caracteres que se emplean en dibujar los 48 _metatiles_ (48 × 4 × 8 = 1536).
- 256 bytes para 256 atributos: uno por cada carácter del set.

Los atributos solo se emplean en realidad para los caracteres 64 a 255, pero ahorrarse los 64 primeros (que no se usan) añadiría una complejidad al *backend* que ocuparía más de 64 bytes.

### Modo multinivel

En el modo multinivel, la fuente está separada del resto (colocada en memoria a partir de la dirección de memoria a la que apunta la variable `font`), de forma que `tileset` apunta directamente al primer byte del primer carácter que se utiliza para dibujar los _metatiles_ (el 64). Los atributos van justo después. Esto está hecho así para que en los *level bundles* se pueda hacer un bloque con todo lo que cambia sin tener que comprimir la fuente en cada nivel (que es lo que ocurría en MK1 < 5.0 o MK2 < 1.0).

### Cambiando el _tileset_

En juegos multinivel, cada nivel define su propio _tileset_ (por lo general), pero puede surgir la necesidad de tener que reemplazar el _tileset_ en medio de un nivel (por ejemplo si tu juego tiene un único nivel). Vamos a poner el ejemplo de un juego mononivel en el que queramos alternar entre tres _tilesets_, que hemos llamado `work0.png`, `work1.png` y `work2.png`.

`assets/tileset.h` espera un _charset_ completo, así que generaremos uno que contenga la fuente y un _metatileset_ "vacío". Por suerte, `ts2bin.exe` puede hacer esto por nosotros. Modificamos la llamada en `compile.bat` para que no tome ningún `work.png`; especificando `blank` se generarán caracteres y atributos a 0:

```
    ..\utils\ts2bin.exe ..\gfx\font.png blank ..\bin\tileset.bin 7 >nul
```

Luego habrá que importar los tres _tilesets_ y comprimirlos. No queremos incluir ninguna fuente, por eso especificamos `none` en vez de la ruta para la fuente. Colocaremos el resultado en `/bin`. Posteriormente usaremos `apultra.exe` para comprimir. Podemos añadir estas líneas debajo de la que acabamos de modificar:

```
    ..\utils\ts2bin.exe nofont ..\gfx\work0.png ..\bin\work0.bin 7 >nul
    ..\utils\ts2bin.exe nofont ..\gfx\work1.png ..\bin\work1.bin 7 >nul
    ..\utils\ts2bin.exe nofont ..\gfx\work2.png ..\bin\work2.bin 7 >nul

    ..\utils\apultra.exe ..\bin\work0.bin ..\bin\work0c.bin >nul
    ..\utils\apultra.exe ..\bin\work1.bin ..\bin\work1c.bin >nul
    ..\utils\apultra.exe ..\bin\work2.bin ..\bin\work2c.bin >nul
```

Ya tenemos todo lo que necesitamos. `tileset.bin`, que contiene la fuente y un _tileset_ vacío, se importa en `assets/tileset.h`, pero nuestros bloques comprimidos tendremos que incluirlos en nuestro código _custom_. Un buen sitio es `my/ci/extra_vars.h`:

```c
    // extra_vars.h

    extern unsigned char ts0 [0];
    extern unsigned char ts1 [0];
    extern unsigned char ts2 [0];

    #asm
        ._ts0
            BINARY "../bin/work0c.bin"
        ._ts1
            BINARY "../bin/work1c.bin"
        ._ts2
            BINARY "../bin/work2c.bin"
    #endasm
```

Con esto, tendremos `ts0`, `ts1` y `ts2` para apuntar a nuestros _tilesets_ comprimidos, y con los `BINARY` los hemos incluido en nuestro binario. Ahora hay que decidir en qué momento descomprimirlos. Esto dependerá mucho de tu juego, pero pongamos un ejemplo que será bastante válido porque en la mayoría de los juegos se vuelve atrás (si en tu juego no se vuelve atrás esto sería mucho más sencillo):

Nuestro juego ficticio tiene 30 pantallas, y queremos usar un _tileset_ en cada 10.

Para reducir los delays (descomprimir un _tileset_ tarda tiempo), vamos a controlar qué _tileset_ hay cargado y cargaremos un nuevo sólo si es necesario. Usaremos una variable `cur_tileset` que crearemos en `my/ci/extra_vars.h`. Para incluir una inicialización automática, emplearemos un valor fuera de rango al inicio del juego, para que la primera vez que se cargue una pantalla se descomprima el _tileset_ correcto sin importar donde empecemos (lo que puede venir bien si estamos haciendo _debug_):

```c
    // entering_game.h

    cur_tileset = 99;   // Fuera de rango
```

Al entrar en cada pantalla comprobaremos donde estamos y el valor de `cur_tileset` para decidir si cambiamos de _tileset_. También nos haremos un array con los punteros a los binarios comprimidos:

```c
    // extra_vars.h

    unsigned char cur_tileset;
    unsigned char *tsc [] = { ts0, ts1, ts2 };
```

Para cambiar de _tileset_ habrá que descomprimir nuestros binarios comprimidos, que contienen el _metatileset_ y sus atributos, en el sitio correcto. Como estamos en configuración *mononivel*, esto será a partir de `tileset + 512`, para saltarnos la fuente. Un buen sitio es justo antes de cambiar de pantalla, para que la próxima se pinte con el nuevo _tileset_ al invalidarse todo el _viewport_:

```c
    // before_entering_screen.h

    if (n_pant < 10) rda = 0;
    else if (n_pant < 20) rda = 1;
    else rda = 2;

    if (rda != cur_tileset) {
        cur_tileset = rda;
        _gp_gen = tsc [cur_tileset];
        #asm
            ld hl, (__gp_gen)
            ld de, _tileset + 512
            call depack
        #endasm
    }
```

## Bajo nivel y splib2

Iré apuntando aquí cosas de splib2 que piense que pueden ser interesantes a la hora de escribir tu propio código en los puntos de inyección. Generalmente usarás sólo la API del motor, pero es posible que haya que afinar en un momento dado.

### Descripción muy general de cómo funciona splib2

O al menos la parte gráfica. Y muy _grosso modo_.

**splib2** divide la pantalla en celdas de carácter, esto es, en una rejilla de 32x24 celdas. En el totete de **splib2** cada celda tiene asignadas cuatro cosas: un número de carácter o *patrón* de fondo, un atributo para ese *patrón*, un puntero a una lista de _sprites_ que lo pisan (que puede ser nulo), y un bit que indica si es *válido*. Todas las operaciones se hacen sobre estas estructuras de datos. Para mostrar los resultados llamamos a una función que actualiza la pantalla **enviando a la misma únicamente las celdas de la rejilla que hayan sido *invalidadas*** usando precisamente el bit que hemos nombrado antes.

Move un _sprite_ por la pantalla, por ejemplo, invalida celdas: las que pisaba el _sprite_ antes de moverse, y las que pisa después. De esa forma, en la siguiente actualización, se redibujarán todas esas celdas y parecerá que el _sprite_ se ha movido sin borrar el fondo.

A la hora de pintar _tiles_ del motor, para no tener que hacer cálculos para cada patrón del _tile_, primero se modifican las estructuras y luego se invalida el cuadro de un plumazo. Es más, a la hora de pintar una nueva pantalla se escriben todos los *patrones* y atributos en las estructuras de **splib2** y luego se invalida toda la pantalla de una vez, ganando mucha velocidad. Es por eso por lo que en la lista de funciones has visto muchas en las que se indica que *no se invalida* y hay que llamar a una función de invalidación si se quiere ver los cambios reflejados en pantalla.

**splib2** está escrita en ensamble y es bastante potente, pero para que sea fácil de usar desde un programa C viene con una interfaz C que a veces mete bastante _overhead_ (por ejemplo en `sp_moveSprAbs` y otras funciones que tienen muchos parámetros) por lo que, para ganar ciclos y espacio, pasamos de la interfaz C en **MTE MK1** y usamos directamente las rutinas en ensamble. Esto implica siempre preparar los parámetros a mano y meterlos en registros desde ensamble en línea.

### Imprimir un carácter

Para imprimir un carácter se empleaba la función `sp_PrintAtInv`, pero se ha tratado de prescindir de la interfaz C de **splib2** para las funciones más llamadas, por lo que para imprimir un carácter o *patrón* tenemos que usar directamente las tripas de *splib2*.

#### Necesitamos invalidar el carácter impreso

Para ello llamaremos a la rutina `spPrintAtInv` que recibe los siguientes parámetros en registros:

|Reg.|Parámetro
|---|---
|A|Fila (0..23)
|C|Columna (0..31)
|D|Atributo
|E|Nº de *patrón*

Por ejemplo, para imprimir una A color azul sobre cyan en la posición 7, 8:

```c
    #asm
            ld  a, 8
            ld  c, 7
            ld  d, 5*8+1
            ld  e, 33

            call spPrintAtInv
    #endasm
```

#### Vamos a imprimir muchos caracteres juntos

En ese caso lo mejor es atacar directamente a las estructuras de datos de **splib2** y luego invalidar. La estructura de datos que contiene caracteres, atributos y punteros a listas de _sprites_ es una tabla de 32x24 celdas de 4 bytes cada una. Para imprimir un carácter en la tabla habrá que moverse a la celda correcta y escribir primero el atributo y luego el número de patrón, dejando sin tocar los otros dos bytes.

Para encontrar la posición donde tenemos que escribir dadas unas coordenadas podemos llamar a la rutina `SPCompDListAddr`, que recibe estos parámetros:

|Reg.|Parámetro
|---|---
|A|Fila (0..23)
|C|Columna (0..31)

Que devolverá la dirección de la celda en `HL`. Una vez obtenida, podemos iterar y movernos por el _buffer_ incrementando o decrementando el puntero de forma correcta. Puedes ver las funciones en `printer.h` para ver cómo se usa.

Una vez modificado el _buffer_ no tenemos más que invalidar el rectángulo. Para eso utilizamos la rutina `spInvalidate`, que recibe los siguientes parámetros:

|Reg.|Parámetro
|---|---
|B|Fila esquina superior izquierda (0..23)
|C|Columna esquina superior izquierda (0..31)
|D|Fila esquina inferior derecha (0..23)
|E|Columna esquina inferior derecha (0..31)
|IY|Puntero al rectángulo de clipping

Para `IY` tenemos definidos dos rectángulos: uno a toda la pantalla (`fsClipStruct`) y otro sólo para el área de juego (`vpClipStruct`).

### Leer los controles

En cada _frame_ leemos los controles y los escribimos en la variable `pad0`. Los controles pulsados se pueden evaluar mirando los bits que estén a 0. **splib2** define una serie de constantes para hacer esto más sencillo:

|Constante|Significado
|---|---
|`sp_LEFT`|izquierda
|`sp_RIGHT`|derecha
|`sp_UP`|arriba
|`sp_DOWN`|abajo
|`sp_FIRE`|disparo

Por ejemplo, para comprobar si se está pulsando 'abajo':

```c
    if ((pad0 & sp_DOWN) == 0) {
        // Estamos pulsando "abajo"
    }
```

## Cómo hacer...

### Ganar o perder

Para hacer que el nivel termine satisfactoriamente habrá que...

```c
    success = 1;
    playing = 0;
```

Para producir un *game over* inmediato, simplemente:

```c
    success = playing = 0;
```

## ¿Algo más?

Si crees que debería aparecer algo que no está dímelo.
