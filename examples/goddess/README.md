# Cheril the Goddess

**Cheril The Goddess** fue elaborado ampliando sobre la versión 4 de **MTE MK1**. Si os sabéis la historia recordaréis que se trata de la rama de desarrollo que se abandonó. Como v5 ha evolucionado a partir de 3.99, hay muchas cosas que se usaban en **Cheril The Goddess** que ya no forman parte del motor. 

En esta versión implementaremos todas estas características usando inyección de código y además emplearemos hotspots personalizados para implementar gran parte de la lógica del juego que originalmente estaba implementada mediante scripting.

El juego original tenía además tres niveles de dificultad que modificaban algunos parámetros.

## El objetivo principal

El objetivo del juego es entrar en el templo que hay en la pantalla 7. La entrada del templo está tras una cancela (que hay que pintar) en la parte derecha de la pantalla. Podemos detectar que hemos "llegado a nuestro objetivo" cuando **Cheril** toque la casilla (14, 4). Por tanto este será el primer juego de **Mojon Twins** que utilice esta condición de *ganar juego*: por posición. En `my/config.h`:

```
    // config.h
    [...]
    #define SCR_FIN                     7
    #define PLAYER_FIN_X                14
    #define PLAYER_FIN_Y                4   
    [...]
```

## Simulando características de v4

Estas son las características de v4 que no forman parte del motor y cómo las vamos a implementar:

### Volar resta vida

En este juego, **Cheril** puede volar, pero eso le cuesta vida. Para ello añadiremos código en `my/ci/on_jetpac_boost.h`. El sistema funcionaba en base a un sencillo contador y una pequeña máquina de estados. Tras N frames, se resta 1 punto de vida cada M frames. Estos valores N y M dependen del nivel de dificultad. Empezaremos definiendo dos arrays con los valores según el nivel (0 fácil a 2 difícil) y las variables que necesitaremos:

```c
    // extra_vars.h

    unsigned char difficulty_level;

    const unsigned char jetpac_drain_offset [] = { 10, 8, 4 };
    const unsigned char jetpac_drain_ratio [] = { 4, 3, 2 };

    unsigned char jetpac_counter;
```

Emplearemos `p_jetpac_on` para saber si estamos o no empezando a volar (controlando nuestra pequeña máquina de estados. Cuando sea el momento de restar vida llamaremos a `player_deplete`.

```c
    // on_jetpac_boost.h

    if (p_jetpac_on) {
        if (jetpac_counter) -- jetpac_counter; else {
            jetpac_counter = jetpac_drain_ratio [difficulty_level];
            player_deplete ();
        }
    } else jetpac_counter = jetpac_drain_offset [defficulty_level];
```

### Disparar resta vida

Disparar también le cuesta vida a **Cheril**. Usaremos `my/ci/on_player_fires.h`. La cantidad de vida que se resta también depende del nivel de dificultad, por lo que tendremos que añadir otro array:

```c
    // extra_vars.h

    [...]
    const unsigned char fire_drain_amount [] = { 2, 4, 8 };
```

```c
    // on_player_fires.h

    p_kill_amt = fire_drain_amount [difficulty_level];
    player_deplete ();
```

### Colisiónes custom contra los enemigos

En v4 se podía elegir cuánta vida te quitaban los enemigos lineales y cuánta los enemigos voladores. En v5 esto lo podemos hacer jugando con `p_kill_amt` en el CIP `my/ci/on_enems_collision.h`. Los valores que se restan dependen también del nivel de dificultad:

```c
    // extra_vars.h

    const unsigned char linear_enemy_hit [] = { 5, 10, 15 };
    const unsigned char flying_enemy_hit [] = { 15, 25, 30 };
```

```c
    // on_enems_collision.h

    p_kill_amt = (_en_t == 6) ? 
        flying_enemy_hit [difficulty_level] :
        linear_enemy_hit [difficulty_level];
```

## Elegir el nivel de dificultad

Además de los que hemos visto, elegir el nivel de dificultad modifica otros valores: `FANTIES_SIGHT_DISTANCE` y `FANTIES_LIFE_GAUGE`. Al emplearse directamente para mover enemigos pondremos los arrays correspondientes pero sacaremos sus valores a variables globales, que serán las que asingaremos como valor de las macros:

```c
    // config.h
    [...]
    #define FANTIES_SIGHT_DISTANCE      _fanties_sight_distance
    [...]
    #define FANTIES_LIFE_GAUGE          _fanties_life_gauge
    [...]
```

```c
    // extra_vars.h

    const unsigned char fanties_sight_distance [] = { 60, 80, 100 };
    const unsigned char fanties_life_gauge [] = { 5, 10, 15 };

    unsigned char _fanties_sight_distance;
    unsigned char _fanties_life_gauge;
```

Antes de empezar a jugar tendremos que mostrar un menú para elegir el nivel de forma que podamos dar valor a `difficulty_level` y precalcular `_fanties_sight_distance` y `_fanties_life_gauge`. Esto lo podemos hacer en `my/ci/before_game.h`

```c
    // before_game.h

    _x = 4; _y = 20; _t = 71;
    _gp_gen = "A EASY  B MEDIUM  C HARD";
    print_str ();
    sp_UpdateNow ();

    difficulty_level = 99; while (difficulty_level == 99) {
        gpit = sp_GetKey ();
        if (gpit > 'Z') gpit -= 32;
        if (gpit >= 'A' && gpit <= 'C') difficulty_level = gpit - 'A';
    }

    _fanties_sight_distance = fanties_sight_distance [difficulty_level];
    _fanties_life_gauge = fanties_life_gauge [difficulty_level];
```

## Decoraciones

Este fue el primer juego en el que se usó el script para colocar cosas en la pantalla con tiles fuera del rango mapeable, o sea, decoraciones. Estas son tan sencillas que se limitan a un sólo tile por pantalla salvo en la pantalla 7 donde también hay que pintar la cancela si no hemos activado la puerta.

Estas son las decoraciones "monotile":

|`n_pant`|(x, y)|`_t`|Descripción
|---|---|---|---
|7|(10, 5)|28|Cerrojo
|11|(12, 8)|31|Cámara de recarga
|15|(11, 7)|31|Cámara de recarga
|12|(7, 6)|26|Baldosa "papel"
|18|(6, 8)|25|Baldosa "piedra"
|22|(4, 8)|27|Baldosa "tijeras"

Para hacerlo de forma sencilla vamos a hacer un array con estos datos y luego usaremos código en `my/ci/entering_screen.h` para pintar. Añadimos el array en `my/ci/extra_vars.h`:

```c
    // extra_vars.h

    const unsigned char simple_decorations [] = {
        7, 10, 5, 28,   // Cerrojo
        11, 12, 8, 31,  // Cámara de recarga
        15, 11, 7, 31,  // Cámara de recarga
        12, 7, 6, 26,   // Baldosa papel
        18, 6, 8, 25,   // Baldosa piedra
        22, 4, 8, 27    // Baldosa tijeras
    };
```

Y el código en `my/ci/entering_screen.h`:

```c
    // entering_screen.h

    _gp_gen = simple_decorations;
    for (gpit = 0; gpit < 6; gpit ++) {
        if (*_gp_gen == n_pant) {
            ++ _gp_gen;
            _x = *_gp_gen; ++ _gp_gen;
            _y = *_gp_gen; ++ _gp_gen;
            _t = *_gp_gen; ++ _gp_gen;
            _n = 8;
            update_tile ();
            break;
        } else _gp_gen += 4;
    }
```

## La lógica de los objetos

Vamos a modificar levemente el diseño del juego para que se pueda implementar mediante hotspots personalizados a la vez que lo hacemos algo más interesante: se trata de abrir una cancela con una llave. Sin embargo el cerrojo está oculto y sólo se puede abrir si "vencemos" a los tres templos.

En cada templo hay una baldosa con un simbolo, del que los templos toman su nombre: el templo de la piedra, el templo de papel y el templo de las tijeras. Perdidos por el escenario hay tres objetos: los que corresponden a cada templo.

Tendremos que reordenar estos objetos colocando en cada templo el que le venza (ya sabes como va el juego) acarreándolos de uno en uno. Eso hará aparecer el cerrojo, y entonces no tendremos más que llevar la llave hasta allí.

Lo vamos a hacer todo con hotspots personalizados. El juego no usa ningún tipo de hotspots, así que los tenemos todos para nosotros. Veamos nuestro tileset y recordemos como se relacionan tiles y tipos de hotspot.

![Tileset Cheril the Goddess](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/XX_goddess_TS.png)

En este juego, que "un hotspot sea de tipo A", significa que contiene el objeto A, aquel que corresponde al tile 16+A (excepto si A = 3, recuerda). Así representaremos a nuestros objetos: tipo 4 significa "vacío", tipo 5 significa "piedra", tipo 6 "papel", tipo 7 "tijeras" y tipo 8 "llave".

Definiremos además una variable `p_inv` para almacenar el objeto que lleva **Cheril**. En el manejador de los hotspots de 4 a 8 lo que se hará será simplemente intercambiar el valor de `p_inv` con el del tipo de hotspot si se colisiona y se pulsa *abajo*.

```c
    // extra_vars.h

    unsigned char hotspots_backup [MAP_W * MAP_H];

    unsigned char p_inv, op_inv;
```

Los hotspots los colocaremos con el Ponedor. Mirando el script original del juego hemos hecho esta lista, en la que también incluimos puntos de recarga (que veremos más adelante):

|`n_pant`|(x,y)|Khe|Descripción
|---|---|---|---
|0|(2, 5)|8|Llave
|2|(7, 6)|7|Tijeras
|5|(6, 6)|5|Piedra
|7|(10, 4)|4|Cerrojo
|11|(12, 7)|3|Cámara de recarga 2
|12|(7, 4)|4|Templo del papel (poner tijeras)
|15|(11, 6)|3|Cámara de recarga 1
|18|(6, 7)|4|Templo de la piedra (poner papel)
|22|(4, 7)|4|Templo de las tijeras (poner piedra)
|23|(12, 7)|6|Papel

El hotspot del cerrojo habrá que tratarlo aparte porque sólo debe estar interactuable si hemos colocado todos los otros objetos en su lugar, pero eso lo veremos luego.

Como nos vamos a cargar los datos durante el juego, nada más cargar el juego haremos una copia de seguridad de los tipos y la restauraremos antes de empezar a jugar cada vez

```c
    // after_load.h

    for (gpit = 0; gpit < MAP_W * MAP_H; gpit ++) 
        hotspots_backup [gpit] = hotspots [gpit].tipo;
```

```c
    // entering_game.h

    for (gpit = 0; gpit < MAP_W * MAP_H; gpit ++) 
        hotspots [gpit].tipo = hotspots_backup [gpit];

    p_inv = 4; 
    op_inv = 0;   // Forces update
```

De esta forma y con poquísimo código tendriamos implementado todo el manejo de objetos:

```c
    // hotspots_custom.h

    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
        if ((pad0 & sp_DOWN) == 0) {
            _t = p_inv;
            p_inv = hotspots [n_pant].tipo;
            hotspots [n_pant].tipo = _t;

            // Update graphic
            _x = hotspot_x >> 4; _y = hotspot_y >> 4; _t += 16;
            draw_invalidate_coloured_tile_gamearea ();

            beep_fx (9);
        }

        hotspot_destroy = 0;
        break;
```

Añadiremos igualmente algo de código a `my/ci/extra_routines.h` para dibujar el objeto que lleva **Cheril** en el marcador cuando cambie.

```c
    // extra_routines.h

    if (op_inv != p_inv) {
        op_inv = p_inv;

        _x = 0; _y = 14; _t = 16 + p_inv;
        draw_coloured_tile ();
        invalidate_tile ();
    }
```

## Cámaras de recarga

Las cámaras las hemos puesto con Ponedor como hotspots de tipo 3. Para desactivar el manejo de recargas del motor no hay que olvidarse de descomentar `DEACTIVATE_REFILLS` en `my/config.h`. Luego añadiremos un nuevo caso en `my/ci/hotspots_custom.h`. Queremos que la recarga funcione al pulsar *abajo* y que el hotspot no se desactive:

```c
    // hotspots_custom.h

    case 3:
        if ((pad0 & sp_DOWN) == 0) {
            p_life = PLAYER_LIFE;
            beep_fx (8);
        }

        hotspot_destroy = 0;
        break;
```

## Lógica del juego: comprobar templos

Lo primero que hay que hacer en el juego es vencer a los tres templos. Esto activará el cerrojo de la pantalla 7 para abrir la puerta y terminar.

Un buen momento para comprobar que tenemos todos los objetos en su sitio será tras colocar uno. Para que los objetos estén bien puestos esta debe ser la configuración:

|`n_pant`|templo|objeto
|---|---|---
|12|Papel|Tijeras (7)
|18|Piedra|Papel (6)
|22|Tijeras|Piedra (5)

Para almacenar el estado de los templos (para poder consultar fácilmente si están o no vencidos) y de la puerta de salida usaremos unas variables que habrá que definir e inicializar:

```c
    // extra_vars.h

    unsigned char templos_mataos;
    unsigned char puerta_abierta;
```

```c
    // entering_game.h

    templos_mataos = puerta_abierta = 0;

    _x = 1; _y = 23; _t = 71;
    _gp_gen = "ONCE UPON A TIME IN BADAJOZ...";
    print_str ();
```

Como hemos dicho, comprobaremos que los objetos estén **en su sitio** siempre que coloquemos uno, esto es, tendremos que completar el código en `my/ci/hotspots_custom.h`:

```c
    // hotspots_custom.h
    
    [...]

    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
        if ((pad0 & sp_DOWN) == 0) {
            _t = p_inv;
            p_inv = hotspots [n_pant].tipo;
            hotspots [n_pant].tipo = _t;

            // Update graphic
            _x = hotspot_x >> 4; _y = hotspot_y >> 4; _t += 16;
            draw_invalidate_coloured_tile_gamearea ();

            beep_fx (9);

            // Check
            if (
                hotspots [12].tipo == 7 && // Scissors on Paper
                hotspots [18].tipo == 6 && // Paper on Stone
                hotspots [22].tipo == 5    // Stone on Scissors
            ) {
                templos_mataos = 1;
                _x = 1; _y = 23; _t = 71;
                _gp_gen = "A BOLT APPEARED ELSEWHERE...";
                print_str ();
                beep_fx (0);
            }
        }

        hotspot_destroy = 0;
        break;
```

Teniendo `templos_mataos` vamos a preparar la entrada a la pantalla 7. Según el valor de esto, el hotspot "cerrojo" debe estar o no activo, incluso aparecer o no.

Un hotspot está activo y es interactuable si `hotspots [n_pant].act` vale 1, así que hacer que el cerrojo funcione dependiendo .

Recordemos que en nuestro array de decoraciones el cerrojo era el número cero. Vamos a hacer una fullería para que el bucle que recorre las decoraciones empiece en 0 o en 1 dependiendo del valor de `templos_mataos`: sólo se debe pintar el cerrojo (empezar el bucle por 0) si vale 1.

También pintaremos la puerta si es necesario:

```c
    rda = templos_mataos ^ 1;
    _gp_gen = simple_decorations + (rda ? 4 : 0);
    for (gpit = rda; gpit < 6; gpit ++) {
        if (*_gp_gen == n_pant) {
            ++ _gp_gen;
            _x = *_gp_gen; ++ _gp_gen;
            _y = *_gp_gen; ++ _gp_gen;
            _t = *_gp_gen; ++ _gp_gen;
            _n = 8;
            update_tile ();
            break;
        } else _gp_gen += 4;
    }

    hotspots [7].act = templos_mataos;

    if (n_pant == 7 && puerta_abierta == 0) {
        _x = 13; _y = 3; _t = 29; _n = 8; update_tile ();
        _x = 13; _y = 4; _t = 30; _n = 8; update_tile ();
    }
```

## Abriendo la puerta

Cuando usemos el hotspot de la pantalla 7 para meter la llave tendremos que hacer una pequeña animación y establecer las variables para preparar al juego para el final. Añadiremos la comprobación, por tanto, a nuestro `my/ci/hotspots_custom.h`.

```c
    // hotspots_custom.h

    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
        if ((pad0 & sp_DOWN) == 0) {
            [...]

            if (
                n_pant == 7 && 
                puerta_abierta == 0 &&
                hotspots [7].tipo == 8
            ) {
                puerta_abierta = 1;

                // Animation
                _x = 13; _y = 3; _t = 0; _n = 0; update_tile ();
                _x = 13; _y = 4; _t = 29; _n = 0; update_tile ();
                sp_UpdateNow ();
                beep_fx (0);
                _x = 13; _y = 4; _t = 0; _n = 0; update_tile ();
                sp_UpdateNow ();
                beep_fx (0);
            }
        }
```

### ¡Y listo!

Ya hemos aprendido a montar un sistema sencillo de objetos usando hotspots, lo cual puede dar bastante juego.
