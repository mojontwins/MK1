# Capítulo 11: Code Injection Points

Tras este nombre tan rimbombante se esconde una funcionalidad muy sencilla pero que, una vez que nos vayamos empapando hasta el tuétano de **MTE MK1**, puede darnos alas. Se trata de una serie de archivos en los que podemos añadir código C que son incluidos en partes clave del código. De esa forma podremos ampliar la funcionalidad del motor de formas muy interesantes o programar el _gameplay_ igual que hacíamos mediante _scripting_, pero con mejor kung fu.

Hay una buena colección de puntos de inyección de código que están indicados en la [documentación](https://github.com/mojontwins/MK1/blob/master/docs/code_injection.md) (!), así que no nos vamos a parar en describirlos todos. Lo que haremos será tomar nuestro **Dogmole**, desactivar el _script_, y replicar toda la funcionalidad usando código C usando algunos de estos.

## Tocando el totete

Exacto: programar en C usando puntos de inyección de código significa tocarle directamente el totete al motor de **MTE MK1**. Eso significa que tendremos que conocer hasta cierto punto dónde tocar, qué tocar y cómo: qué puntos de inyección hay, las funciones de la API, variables globales importantes... Todo eso podréis mirarlo en la [documentación de los CIP](https://github.com/mojontwins/MK1/blob/master/docs/code_injection.md) y en la [API de **MTE MK1**](https://github.com/mojontwins/MK1/blob/master/docs/API.md). Sin embargo, aunque todo está ahí, trataremos de ir describiendo como es debido todo lo que usemos a medida que vayamos metiendo cosas.

## Recordando el diseño de _gameplay_

En el juego hay dos misiones: primero hay que encargarse de eliminar a todos los monjes. Esto abrirá el paso a la Universidad de Miskatonic (eliminando un piedro de la pantalla 2). Una vez abierta, tendremos que ir buscando las cajas y llevándolas al mostrador en la pantalla 0. Cuando estén las 10, terminaremos el juego.

## Empezando

Para empezar hemos copiado el proyecto en una carpeta nueva (podéis encontrarlo en `examples/dogmole_ci` del repositorio). Seguidamente, editamos `compile.bat` para cambiar el nombre del proyecto a `dogmole_ci` y posteriormente editamos `my/config.h` para comentar `ACTIVATE_SCRIPTING`.

Si recompilamos en este punto deberemos ver claramente que el _script_ ocupa 0 bytes:

```
    Compilando script
    Convirtiendo mapa
    Convirtiendo enemigos/hotspots
    Importando GFX
    Compilando guego
    dogmole_ci.bin: 26713 bytes
    scripts.bin: 0 bytes
    Construyendo cinta
    Limpiando
    Hecho!
```

## Inicializando el juego

Vamos a usar las flags para almacenar valores (en concreto las flags 1 y 3, como en el _script_ original). Sin embargo, al haber desactivado el _script_, no habrá nada que las inicialice al empezar cada partida, así que tendremos que hacerlo nosotros. Para ello usamos `my/ci/entering_game.h` (que equivale a la sección `ENTERING GAME` del _script_) y ponemos las dos flags que necesitamos a 0:

```c
    // my/ci/entering_game.h

    flags [1] = 0;
    flags [3] = 0;
```

## Decoraciones

Necesitamos imprimir decoraciones en cuatro pantallas. En el motor de **MTE MK1** tenemos la función `draw_decorations` que espera que `_gp_gen` apunte a una colección de decoraciones terminada en `0xff` y se encarga precisamente de dibujarlas. Cada decoración es un par de bytes `0xXY` y `0xTT`, el primero con las coordenadas (X, Y) y el segundo con el número de tile.

Tenemos decoraciones en las pantallas 0, 1, 6 y 18. La forma más sencilla de usar `draw_decorations` es definir arrays con nuestras decoraciones y apuntar `_gp_gen` a ellas.

Para definir nuestras propias variables usamos `my/ci/extra_vars.h`:

```c
    // my/ci/extra_vars.h

    const unsigned char decos_0 [] = { 0x37, 22, 0x47, 23, 0x15, 29, 0x16, 20, 0x17, 21, 0x66, 20, 0x67, 21, 0x77, 28, 0x12, 27, 0x13, 28, 0x22, 29, 0x23, 27, 0x32, 32, 0x33, 33, 0x91, 30, 0x92, 30, 0x93, 31, 0xff };
    const unsigned char decos_1 [] = { 0x72, 24, 0x82, 25, 0x92, 26, 0x16, 32, 0x17, 33, 0xD6, 32, 0xD7, 33, 0xff };
    const unsigned char decos_6 [] = { 0xA1, 30, 0XA2, 31, 0XA4, 35, 0xff};
    const unsigned char decos_18 [] = { 0x48, 34, 0xff };
```

El momento de presentar las decoraciones es el de entrar la pantalla. El punto de inserción de código `my/ci/entering_screen.h` se ejecuta, igual que la sección `ENTERING GAME`, justo en ese momento, después de dibujarla y prepararlo todo, y antes de enviar los resultados a la memoria de video. Es el momento perfecto para modificar la pantalla sin que se note el cambio, por tanto.

```c
    // my/ci/entering_screen.h

    _gp_gen = 0;

    switch (n_pant) {
        case 0:
            _gp_gen = decos_0; break;
        case 1:
            _gp_gen = decos_1; break;
        case 6:
            _gp_gen = decos_6; break;
        case 18:
            _gp_gen = decos_18; break;
    }

    if (_gp_gen) draw_decorations ();
```

## Contando monjes

El motor se encarga de contar los enemigos que vamos eliminados en la variable `p_killed`. Como los únicos enemigos que pueden matarse son los monjes, en cuanto `p_killed` valga 20 sabremos que hemos eliminado a todos. Para rizar el rizo, el conversor `ene2h` cuenta cada tipo de enemigo de forma que nuestro código será súper robusto si comparamos `p_killed` con el número total de enemigos de tipo 3 (que son los monjes). Las macros `N_ENEMS_TYPE_n` contienen el número exacto de enemigo de tipo n, por lo tanto tendremos que comparar con `N_ENEMS_TYPE_3`.

El sitio perfecto para hacer esta comprobación es el punto de inyección de código `my/ci/on_enems_killed.h`, que se ejecutará cada vez que eliminemos un enemigo. Para funcionar como en el _script_, levantaremos la flag 3 cuando hayamos eliminado los 20 monjes.

Abriremos `my/ci/on_enems_killed.h` y añadiremos el siguiente trozo de código:

```c
    // my/ci/on_enems_killed.h

    if (p_killed == N_ENEMS_TYPE_3) {
        flags [3] = 1;
    }
```

Otra cosa que hacíamos era usar EXTERN para ejecutar el código que mostraba el cartel de que la puerta estaba abierta. Como la función con nuestro código extern no está disponible, al haber desactivado el _scripting_, tendremos que añadir el código directamente en el `if` que acabamos de meter. Queda así:

```c
    // my/ci/on_enems_killed.h

    if (p_killed == N_ENEMS_TYPE_3) {
        flags [3] = 1;

        // Print message
        _t = 79;
        _x = 8; _y = 10; _gp_gen = my_spacer;  print_str ();
        _x = 8; _y = 12;                       print_str ();
        _x = 8; _y = 11; _gp_gen = my_message; print_str ();

        sp_UpdateNowEx (0);

        // Wait
        espera_activa (150);

        // Force reenter
        o_pant = 99;
    }
```

Este código necesita dos variables con las cadenas que se imprimen, `my_spacer` y `my_message`. Las añadimos a `my/ci/extra_vars.h`:

```c
    // my/ci/extra_vars.h

    const unsigned char decos_0 [] = { 0x37, 22, 0x47, 23, 0x15, 29, 0x16, 20, 0x17, 21, 0x66, 20, 0x67, 21, 0x77, 28, 0x12, 27, 0x13, 28, 0x22, 29, 0x23, 27, 0x32, 32, 0x33, 33, 0x91, 30, 0x92, 30, 0x93, 31, 0xff };
    const unsigned char decos_1 [] = { 0x72, 24, 0x82, 25, 0x92, 26, 0x16, 32, 0x17, 33, 0xD6, 32, 0xD7, 33, 0xff };
    const unsigned char decos_6 [] = { 0xA1, 30, 0XA2, 31, 0XA4, 35, 0xff};
    const unsigned char decos_18 [] = { 0x48, 34, 0xff };

    unsigned char *my_spacer =  "                ";
    unsigned char *my_message = " PUERTA ABIERTA ";
```

En el trozo de código que hemos escrito vemos varias cosas:

### Imprimir un string

Para imprimir un string empleamos la función `print_str`. La función, como la mayoría del motor de **MTE MK1**, no recibe ningún parámetro, pero necesita que demos valores a las globales generales `_x` e `_y` con las coordenadas, `_t` con el atributo, y `_gp_gen` apuntando a la cadena.

### Enviar el buffer a la pantalla

La impresión se hace en el buffer de **splib2**. Para que sea visible hay que decirle a la biblioteca que nos lo envíe a la pantalla. Para ello empleamos la función custom que hemos añadido en Mojonia a **splib2** `sp_UpdateNowEx` que se encarga de volcar a la pantalla los cuadros de 8x8 (rejilla de caracteres/atributos) que han cambiado. La función recibe un parámetro que puede ser 0 ó 1 dependiendo de si queremos que se actualicen los sprites en los cuadros que cambian.

### Esperar un rato

La función `espera_activa` del motor de **MTE MK1** espera un tiempo (!) y puede interrumpirse pulsando una tecla.

### Forzar reentrada

Llamamos *reentrada* a recargar completamente la pantalla. En este caso, esto es necesario porque hemos impreso un cartel que ha tapado parte de la misma. El motor de **MTE MK1** llama a `draw_scr`, que se encarga de dibujar e inicializar una nueva pantalla, cada vez que la variable `n_pant` (número de pantalla actual) y `o_pant` (número de pantalla anterior) son diferentes. Una forma fácil de redibujar la pantalla sin cambiar de idem es poner en `o_pant` a un valor no válido, como puede ser 99.

## Quitar el piedro

Usaremos de nuevo `my/ci/entering_screen.h`. Simplemente detectamos que acabamos de entrar en la pantalla 2 usando `n_pant`, consultamos el valor de `flag [3]` y usamos `update_tile` para modificar el tile:

```c
    // my/ci/entering_screen.h

    _gp_gen = 0;

    switch (n_pant) {
        case 0:
            _gp_gen = decos_0; break;
        case 1:
            _gp_gen = decos_1; break;
        case 6:
            _gp_gen = decos_6; break;
        case 18:
            _gp_gen = decos_18; break;
    }

    if (_gp_gen) draw_decorations ();

    if (n_pant == 2) {
        if (flags [3]) {
            _x = 12; _y = 7; _t = _n = 0; update_tile ();
        }
    }
```

### En qué pantalla estamos:

`n_pant` contiene el número de la pantalla actual.

### Actualizando tiles:

La función `update_tile` del motor de **MTE MK1** sirve para modificar tiles en pantalla. Además de dibujar el tile necesario se encargan de modificar los buffers necesarios para que ese tile sea interactuable, por lo que será la función que haya que llamar para hacer una modificación completa. Si sólo quisiésemos modificar gráficamente la pantalla sin modificar los buffers tendríamos que llamar a `draw_invalidate_coloured_tile_gamearea`.

La función `update_tile` no recibe parámetros, pero espera que las coordenadas donde hay que imprimir el tile estén en las variables globales `_x` e `_y` (en coordenadas de tile), el número de tile en `_t` y el comportamiento deseado en `_n`.

## La interacción con el altar

Para detectar la interacción con el altar utilizaremos el punto de inserción de código `my/ci/extra_routines.h`, que se ejecuta al final de cada vuelta del bucle principal. Lo primero que haremos será detectar que estamos en la pantalla correcta, la 0, para posteriormente ver que estamos tocando el altar.

En todo momento, `p_tx` y `p_ty` contienen las coordenadas de la casilla de tile que está tocando el centro del sprite del jugador, por lo que vienen estupendamente para lo que tenemos que hacer: detectar que estemos tocando el altar, que ocupa las casillas (3, 7) y (4, 7).

Cuando todo esto se cumpla tendremos que "liberar" el objeto y contar uno más en la flag 1. Recordad que en modo `ONLY_ONE_OBJECT`, `p_objs` vale 1 cuando llevamos un objeto y 0 cuando no. Aprovecharemos también para detectar que hemos recogido 10:

```c
    // my/ci/extra_routines.h

    if (n_pant == 0) {
        if (p_objs && p_ty == 7 && (p_tx == 3 || p_tx == 4)) {
            p_objs = 0;     // Liberamos el objeto
            ++ flags [1];   // Contamos uno más.

            if (flags [1] == 10) {
                // Terminar el juego "bien"
                success = 1;
                playing = 0;
            }
        }
    }
```

### Detectando dónde está el jugador nivel fácil

Como hemos visto, una forma muy sencilla de ver dónde está el jugador, o, mejor dicho, qué tile está tocando, es mirar `p_tx` y `p_ty`.

### Conteo interno de objetos

El conteo interno de objetos se lleva a cabo en `p_objs`. Si hemos definido `ONLY_ONE_OBJECT`, entonces `p_objs` valdrá 0 al empezar el juego y se pondrá a 1 al coger un objeto... Y entonces ya no podremos coger otro más. Que `p_objs` valga 1 significa que llevamos un objeto. Para "liberar" el objeto tendremos que ponerlo a 0.

### Conteo custom de objetos

Si definimos `OBJECT_COUNT`, en modo normal, `p_objs` se copia a `flags [OBJECT_COUNT]` siempre que cogemos un objeto, y además el marcador muestra `flags [OBJECT_COUNT]` en lugar de `p_objs`. Sin embargo, en modo `ONLY_ONE_OBJECT` `p_objs` NO se copia en `flags [OBJECT_COUNT]` aunque lo que se muestre en el marcador sea `flags [OBJECT_COUNT]`. Esto es así para que esto sirva para algo: que `p_objs` sirva únicamente como indicador de si *llevamos un objeto o no*, y usemos `flags [OBJECT_COUNT]` por nuestra cuenta para llevar la cuenta real.

### Terminar el juego

Para terminar el juego hay que poner `playing` a 0. El valor de `success` determinará si ganamos el nivel o se muestra **Game Over**.

## Y ya está.

Me hago cargo de que este capítulo es bastante árido, pero espero que sirva como ilustración del uso de los puntos de inyección de código (que, como dije al principio, están [debidamente documentados](./code_injection.md)).

Tenemos el _scripting_ para hacer muchas cosas, pero se puede lograr mucho más mediante puntos de inyección de código (por ejemplo, añadir nuevos tipos de enemigos o incluso nuevos motores de movimiento para el jugador). Obviamente, es más complicado usar los puntos de inyección de código, sobre todo si no se conoce bien cómo funciona el motor por dentro.

Otra ventaja de los puntos de inyección de código es que, para juegos con _scripts_ pequeños, generalmente ahorran bastante espacio. Quédate con este dato: [en el momento de elaborar este tutorial] usando _scripting_, Dogmole ocupa 28.189 bytes, y usando inyección de código ocupa 26.972, ¡que son 1.218 bytes menos!

Te recomiendo que te pases por los diferentes ejemplos incluidos con **MTE MK1** y revises los *postmortem* donde se explica cómo se ha resuelto la implementación de los güegos.
