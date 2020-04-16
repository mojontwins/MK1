# Capítulo 15: Custom Vertical Engine

O *vEng* personalizado. Cómo me gusta inventarme términos y que luego la gente los use. En Mojonia nos encanta que digáis "perspectiva genital". Pero ¿qué es un deso? Pues muy sencillo: una forma fácil de introducir tu propio código para controlar el movimiento en el eje vertical.

Programar un nuevo eje vertical suele generar una necesidad: definir una nueva forma de organizar los 8 _cells_ de animación del sprite del jugador para adecuarse al nuevo tipo de movimiento. Por suerte esto también lo tenemos cubierto: es fácil definir tu propia animación para el personaje.

¿Por qué sólo el vertical? Para no liarla. También se puede cambiar el horizontal, pero no lo cubriremos en este capítulo. Tienes un par de breves ejemplos en la [documentación de los puntos de inyección de código](https://github.com/mojontwins/MK1/blob/master/docs/code_injection.md).

Para añadir tu propio eje vertical deberás poner código en `my/ci/custom_veng.h`.

## El pifostio de los movimientos verticales.

A ver, voy a intentar explicar cómo está montado el eje vertical así a modo de culturilla general y así podremos entender mejor el tema.

Como sabrás, desde el día 1 **MTE MK1** soporta juegos en vista lateral y en vista genital. Además de otras historias, la principal diferencia radica en cómo se maneja el eje vertical, ya que el eje horizontal se controla exactamente igual para ambas vistas.

* En vista genital, el eje vertical lo controla el teclado. Si pulsas arriba se aplica aceleración hacia arriba, y si pulsas abajo se aplica aceleración hacia abajo. Si no pulsas nada se aplica fricción en el sentido contrario al movimiento.

* En vista lateral, el eje vertical lo controla la gravedad, de forma que en todo momento se aplica aceleración hacia abajo. Aparte de esto, hay un par de formas de conseguir velocidad negativa (hacia arriba): mediante los diversos tipos de salto o el jetpac.

Desde v5, **MTE MK1** permite varias cosas interesantes:

* Activar varias características del eje vertical *a la vez*. Si, en modo de vista lateral, definimos `VENG_SELECTOR` en `my/config.h`, podremos marcar a la vez varios motores de eje vertical (salto, jetpac, bootee, teclado (como en vista genital)) y elegir cuál está activo en cada momento dándole valores a la variable `veng_selector` (hay macros creadas en `definitions.h` para las selecciones: `VENG_JUMP`, `VENG_JETPAC`, `VENG_BOOTEE` y `VENG_KEYS`, respectivamente).

* Desactivar la gravedad en modo de vista lateral.

* Añadir tu código personalizado para manejar el eje vertical.

Esto permite muchas combinaciones. Lo más básico (que será lo que haremos en este capítulo), es dejar la gravedad tal y como está, desactivar todo lo demás (salto, jetpac, bootee y teclado), y añadir código para gestionar el movimiento del choco. Dejaremos comentado `VENG_SELECTOR` y desactivaremos todas las macros que controlan el movimiento vertical en modo lateral:

```c
    // my/config.h

    //#define PLAYER_HAS_JUMP                   // If defined, player is able to jump.
    //#define PLAYER_HAS_JETPAC                 // If defined, player can thrust a vertical jetpac
    //#define PLAYER_BOOTEE                     // Always jumping engine.
    //#define PLAYER_VKEYS                      // Use with VENG_SELECTOR. Advanced.
    //#define PLAYER_DISABLE_GRAVITY            // Disable gravity. Advanced.
```

Pero si os dais cuenta, con estas características las posibilidades son infinitas. Por ejemplo sé podría añadir el movimiento de nadar de **Ninjajar** en `my/ci/custom_veng.h`, activar `VENG_SELECTOR`, y cambiar entre salto o nadar con diferentes valores de `PLAYER_G` dependiendo de si estamos o no en el agua.

Otra cosa que me gustaría mencionar una *feature*: desde siempre (desde la versión 3.0 de 2011), si tu juego no usa disparos, puedes activar a la vez (y sin `VENG_SELECTOR`) el jetpac y los saltos normales, ya que el primero emplea la tecla *arriba* y los segundos la tecla *fire*.

## El movimiento choco

Desde hace mucho tiempo en Mojonia habíamos querido hacer un juego protagonizado por un choco, Blip Blep, que hiciese cosas chocosas en el espacio, cerca de la galaxia de Choconia, y dijera ¡Blip, Blep!. Para eso el choco tendría que moverse como un choco, por lo que diseñamos este movimiento que describo aquí:

* Gravedad baja, para simular espacio o debajo del agua.
* Velocidad horizontal y aceleración/fricción bajas, para idem, y sobre todo porque la mayor parte del tiempo el choco no está posado en plataformas y queda mejor.
* Cuando pulsas FIRE, el choco se comprime *haciendo fuerza*.
* Al soltar FIRE, el choco sale propulsado hacia arriba con la fuerza que había hecho.

Cuanto más tiempo pulses FIRE, con más fuerza se impulsará el choco al soltarlo, por lo que necesitamos un contador, un valor de incremento, y un valor máximo.

Con esta especificación podemos programar el movimiento básico del chico en sólo unas cuantas líneas de código. Necesitaremos antes definir algunas variables y macros:

```c
    // extra_vars.h

    // Custom vEng

    unsigned char fire_pressed;
    signed int p_thrust;

    #define P_THRUST_ADD    16
    #define P_THRUST_MAX    384
```

Usaremos `fire_pressed` como bandera que nos servirá detectar cuando hemos "despulsado" la tecla de disparo. Si ponemos `fire_pressed` a 1 cuando detectamos que está pulsada y a 0 cuando detectamos que no, si vemos que NO se está pulsando la tecla de disparo pero `fire_pressed` vale 1 eso significará que se acaba de dejar de pulsar.

`p_thrust` será donde iremos acumulando "fuerza". Al notar que se libera la tecla de disparo se asignará esta "fuerza" a `p_vy` en negativo (hacia arriba). `P_THRUST_MAX` permite configurar la velocidad con la que se acumula la "fuerza", y `P_THRUST_MAX` el valor máximo que se alcanzará. Los valores de más arriba significa que la velocidad máxima que se transferirá a `p_vy` será de 384, y que esta se alcanzará tras 384/16 = 24 frames pulsando la tecla de disparo.

Implementémoslo:

```c
    if ((pad0 & sp_FIRE) == 0) {
        fire_pressed = 1;
        p_thrust -= P_THRUST_ADD;
        if (p_thrust < -P_THRUST_MAX) p_thrust = -P_THRUST_MAX;
        pad0 = 0xff;
    } else {
        if (fire_pressed) {
            p_vy = p_thrust;
            p_thrust = 0;
        }
        fire_pressed = 0;
    }
```

Como no estamos usando varios ejes verticales excluyentes no necesitamos activar VENG_SELECTOR ni emplear la variable `veng_selector`.

## La animación choco

Todo esto no queda nada bien si no cambiamos la animación. Hemos hecho este *spriteset* para el choco con 8 cells de animación:

![El choco](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/15_sprites_choco.png)

Los dos primeros muestran al choco en su animación "idle", cuando se está pulsando nada ni ascendiendo (sólo dejando que la gravedad y la inercia muevan al choco).

Los cuatro siguientes muestran al choco desplazándose hacia la izquierda y hacia la derecha. Hay dos cells de animación para cada dirección. Los iremos alternando si el choco "nada" hacia esa dirección. Si el choco está subiendo tras "lanzarse" (lo de pulsar la tecla de disparo para "hacer fuerza") no se animarán y se usará sólo el primer cell.

El siguiente cell muestra al choco "haciendo fuerza", y el último al choco ascendiendo verticalmente tras soltar el botón de disparo.

Habrá otras implementaciones posibles, pero esta me parece muy legible. Me gusta precalcular el número de frame en una variable temporal (`rda` aquí) y luego emplear el array `player_cells` que contiene 8 punteros a los 8 cells:

```c
    // custom-animation.h

    if (fire_pressed) {
        rda = 6;
    } else {
        if (gpx == gpox) {
            if (p_vy < 0) rda = 7;
            else rda = (maincounter >> 4) & 1;
        } else {
            rda = 4 - (p_facing << 1);
            if (p_vy >= 0) rda += ((gpx >> 3) & 1);
        }
    }

    p_next_frame = player_cells [rda];
```

No hay que olvidarse de activar `PLAYER_CUSTOM_ANIMATION` en `my/config.h`.

## Más cosas para el choco

Queremos que el choco pueda romper bloques rompiscibles cuando se haya lanzado hacia arriba con la suficiente fuerza. Para eso tendremos que ampliar nuestro código en `my/ci/custom_veng.h`. Detectaremos la colisión en el punto central de la fila superior del cuadro de 16x16 que contiene al sprite. Como esto sólo va a detectarse con el choco a determinada velocidad negativa, en este píxel hay cabeza de choco porque el choco estará estirado y quedará bien.

Pensando en que (misteriosamente) queramos reutilizar este movimiento en otro juego con otras características, vamos a hacerlo bien y usar `#ifdef` como mandan los cánones. Añadimos:

```c
    // custom_veng.h

    [...]

    #ifdef BREAKABLE_WALLS
        // Detect head
        if (p_vy < -P_BREAK_VELOCITY_OFFSET) {
            cx1 = ptx1; cx2 = ptx2;
            cy1 = cy2 = (gpy - 1) >> 4;
            cm_two_points ();

            if (at1 & 16) {
                _x = cx1; _y = cy1;
                break_wall ();
                p_vy = P_BREAK_VELOCITY_OFFSET;
            }

            if (cx1 != cx2 && (at2 & 16)) {
                _x = cx2; _y = cy2;
                break_wall ();
                p_vy = P_BREAK_VELOCITY_OFFSET;
            }
        }
    #endif
```

`P_BREAK_VELOCITY_OFFSET` es el valor mínimo de velocidad que hay que llevar para romper un piedro, y lo definimos con las demás macros en `my/ci/extra_vars.h`:

```c
    // extra_vars.h

    #define P_BREAK_VELOCITY_OFFSET 128
```

## Fricción del agua

El problema de esto es que nos hemos puesto en la tesitura de que, al rebotar hacia abajo, `p_vy` puede valer más que `PLAYER_MAX_VY_CAYENDO` y esto no quedaría bien, ya que la implementación de la gravedad limita la velocidad hacia abajo a este valor. Lo que vamos a hacer es desactivar la gravedad y usar nuestra propia implementación.

Primero descomentamos `PLAYER_DISABLE_GRAVITY` en `my/config.h`. y luego añadimos:

```c
    // custom_veng.h

    [...]

    // Water gravity & friction
    if (p_vy < PLAYER_MAX_VY_CAYENDO) {
        p_vy += PLAYER_G;
        if (p_vy > PLAYER_MAX_VY_CAYENDO) p_vy = PLAYER_MAX_VY_CAYENDO;
    } else {
        p_vy -= P_WATER_FRICTION;
        if (p_vy < PLAYER_MAX_VY_CAYENDO) p_vy = PLAYER_MAX_VY_CAYENDO;
    }
```

La macro que nos queda, `P_WATER_FRICTION`, la definimos igualmente en `my/ci/extra_vars.h`:

```c
    // extra_vars.h

    #define P_WATER_FRICTION        16
```

## Otro ejemplo

Aquí tenéis un motor de movimiento parecido a Subaquatic (que no era **MTE MK1**, ni se le parecía), basado en este spriteset:

![Subaquatic](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/15_sprites_subaquatic.png)

```c
    // config.h
    //#define PLAYER_HAS_JUMP                   // If defined, player is able to jump.
    //#define PLAYER_HAS_JETPAC                 // If defined, player can thrust a vertical jetpac
    //#define PLAYER_BOOTEE                     // Always jumping engine. Don't forget to disable "HAS_JUMP" and "HAS_JETPAC"!!!
    //#define PLAYER_VKEYS                      // Use with VENG_SELECTOR. Advanced.
    #define PLAYER_DISABLE_GRAVITY              // Disable gravity. Advanced.

    [...]

    #define PLAYER_MAX_VX               128     // Max velocity
    #define PLAYER_AX                   32      // Acceleration
    #define PLAYER_RX                   64      // Friction
```

```c
    // extra_vars.h

    #define P_MAX_VY_FLOATING           128
    #define P_AY_FLOATING               16
    #define P_MAX_VY_DIVING             128
    #define P_AY_DIVING                 32
```

```c
    // custom_veng.h

    if ((pad0 & sp_DOWN) == 0) {
        // Dive
        p_vy += P_AY_DIVING;
        if (p_vy > P_MAX_VY_DIVING) p_vy = P_MAX_VY_DIVING;
    } else {
        // Float
        p_vy -= P_AY_FLOATING;
        if (p_vy < -P_MAX_VY_FLOATING) p_vy = -P_MAX_VY_FLOATING;
    }
```

```c
    // custom_animation.h

    rda = p_facing ? 0 : 4
    if (p_vy > 0 || p_vx) rda += (maincounter >> 2) & 1;
```

## Y esto es todo.

Ya has aprendido (o no) cómo añadir tu propio manejador del eje vertical del movimiento, que además rima con pimiento.
