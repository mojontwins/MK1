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

