# Cheril the Goddess

**Cheril The Goddess** fue elaborado ampliando sobre la versión 4 de **MTE MK1**. Si os sabéis la historia recordaréis que se trata de la rama de desarrollo que se abandonó. Como v5 ha evolucionado a partir de 3.99, hay muchas cosas que se usaban en **Cheril The Goddess** que ya no forman parte del motor. 

En esta versión implementaremos todas estas características usando inyección de código y además emplearemos hotspots personalizados para implementar gran parte de la lógica del juego que originalmente estaba implementada mediante scripting.

El juego original tenía además tres niveles de dificultad que modificaban algunos parámetros.

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

### Elegir el nivel de dificultad

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

    const unsigned char fanties_sight_distance [] = { 5, 10, 15 };
    const unsigned char fanties_life_gauge [] = { 15, 25, 30 };

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

### La lógica de los objetos

Vamos a modificar levemente el diseño del juego para que se pueda implementar mediante hotspots personalizados a la vez que lo hacemos algo más interesante: se trata de abrir una cancela con una llave. Sin embargo el cerrojo está oculto y sólo se puede abrir si "vencemos" a los tres templos.

En cada templo hay una baldosa con un simbolo, del que los templos toman su nombre: el templo de la piedra, el templo de papel y el templo de las tijeras. Sobre cada baldosa hay un objeto: el que corresponde a cada templo.

Tendremos que reordenar estos objetos colocando en cada templo el que le venza (ya sabes como va el juego) acarreándolos de uno en uno. Eso hará aparecer el cerrojo, y entonces no tendremos más que llevar la llave hasta allí.

Lo vamos a hacer todo con hotspots personalizados. El juego no usa ningún tipo de hotspots, así que los tenemos todos para nosotros. Veamos nuestro tileset y recordemos como se relacionan tiles y tipos de hotspot.

![Tileset Cheril the Goddess](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/XX_goddess_TS.png)

En este juego, que "un hotspot sea de tipo A", significa que contiene el objeto A, aquel que corresponde al tile 16+A (excepto si A = 3, recuerda). Así representaremos a nuestros objetos: tipo 4 significa "vacío", tipo 5 significa "piedra", tipo 6 "papel", tipo 7 "tijeras" y tipo 8 "llave".

Definiremos además una variable `p_inv` para almacenar el objeto que lleva **Cheril**. En el manejador de los hotspots de 4 a 8 lo que se hará será simplemente intercambiar el valor de `p_inv` con el del tipo de hotspot si se colisiona y se pulsa *abajo*.

```c
    // extra_vars.h

    unsigned char hotspots_backup [MAP_W * MAP_H];

    unsigned char p_inv;
```

Los hotspots los colocaremos con el Ponedor. Como nos vamos a cargar los datos durante el juego, nada más cargar el juego haremos una copia de seguridad de los tipos y la restauraremos antes de empezar a jugar cada vez

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
```

Añadiremos igualmente algo de código a `my/ci/extra_routines.h` para dibujar el objeto que lleva **Cheril** en el marcador cuando cambie.
