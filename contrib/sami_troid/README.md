# Sami Troid

Port a **MTE MK1 v5** del juego de **Son Link**. Puedes obtener la versión original del juego y el manual desde su [página de github](https://github.com/son-link/SamiTroid/).

Este juego es interesante porque tiene un mapa unpacked enorme. La versión original empleaba un conversor de mapas de Antonio Villena que trabajaba sobre archivos tmx de Tiled. Para montar esta versión he optado por traérmelo un poco a mi terreno y, aprovechando que las pantallas tienen bastante repetición, probar con compresión RLE.

## Decodificación custom de mapas

Una característica poco documentada de **MTE MK1** es que puedes emplear tu propio decompresor de mapas, sustituyendo a los que trae el engine. Para ello tienes que añadir 

```c
    #define USE_MAP_CUSTOM_DECODER
```

al principio de `config.h` o en `mk1.c`, e incluir tu código en `my/map_custom_decoder.h`. El código debe funcionar de forma análoga al decodificador de mapas PACKED / UNPACKED que viene por defecto: debe pintar los tiles en pantalla sin invalidarlos y rellenar los arrays `map_buff` y `map_attr` (y también `brk_buff` si usas tiles rompiscibles).

Para este juego voy a emplear un decoder que escribí para la revisión de **Tenebra Macabre**, que emplea mapas comprimidos en RLE62, una implementación muy sencilla que emplea seis bits para describir el tile (64 máximo; necesitamos 48 así que va bien) y 2 bits para la longitud de las repeticiones (máximo 4). El compresor, `rle62map_sp.exe`, genera dos archivos binarios: `<prefix>.map.bin` con los índices que necesita y los datos para el mapa, y `<prefix>.locks.bin` con los cerrojos. **MTE MK1** espera el mapa, la definición del tipo cerrojo, y los cerrojos en `assets/mapa.h`, pero por suerte `rle62map_sp.exe` ha sido actualizado e hipervitaminado para que también lo genere :D

Modificamos `compile.bat` para que llame a `rle62map_sp.exe` en lugar de a `mapcnv.exe`.

```bat
    ..\..\..\src\utils\rle62map_sp.exe in=..\map\mapa.map mk1h=assets\mapa.h out=mapa size=8,9 tlock=15 mk1locks > nul
```

Haciendo una ligera prueba, comprobamos que el mapa, que ocuparía 72x150 = 10800 bytes, se queda en 4004, un tamaño mucho más manejable. Además, la decodificación de RLE62 no es más lenta que con los datos en bruto.

El sistema se completa con el código que he añadido a `my/map_custom_loader.h` al que puedes echar un vistazo si te pica la curiosidad y que, obviamente, puedes usar en tus juegos a discreción.

## El final boss

El jefe final es un bicho que se mueve a toda velocidad frente a la puerta y que tendremos que eliminar. Como este juego no usa plataformas se aprovechó el tipo 4 para implementar este boss, pero para replicar esta funcionalidad necesitamos conseguir tres cosas:

* Debe empezar con 16 puntos de vida
* No debe resucitarse al entrar de nuevo en la pantalla
* Al morir, debe levantar un flag

Empezaremos creando una variable y no nos olvidaremos de reiniciarlo en cada partida (el juego original usaba `flags [10]` pero como no usamos scripting pondremos una variable normal):

```c
    // extra_vars.h 

    unsigned char boss_killed;
```

```c
    // entering_game.h

    boss_killed = 0;
```

En la función que carga los enemigos de cada fase tenemos el punto de inserción `my/ci/enems_extra_mods.h` que se ejecuta al final de la carga de cada enemigo. Ahí podremos controlar que no vuelva a la vida una vez matado y o que tenga más vida:

```c
    // enems_extra_mods.h

    if (malotes [enoffsmasi].t == 4) {
        if (boss_killed) {
            malotes [enoffsmasi].t |= 0x10;     // Stay dead
        } else {
            malotes [enoffsmasi].life = 16;
        }
    }    
```

Hecho esto, sólo queda hacer que al morir active `boss_killed`, ya que necesitaremos esa variable para comprobar la condición del final del juego, más adelante. Cada vez que se muere un enemigo se ejecuta el CIP `my/ci/on_enems_killed.h`:

```c
    boss_killed = (_en_t == (4|16));
```

Nótese en "|16": esto es porque cuando se ejecuta este CIP el enemigo ya está marcado como "muerto", o sea, tiene el bit 4 arriba, entonces su tipo se convierte en t|16.

## Deshaciendo el script

**Sami Troid** es un juego de "coger los objetos uno a uno y llevarlos a tal sitio", como ocurre con **Dogmole**, así que desharemos el script original y lo implementaremos todo con sencillas inyecciones de código. Vamos a ir haciéndolo sección a sección y reescribiendo cada cláusula. Este juego emplea el flag 1 para almacenar el número de objetos que se ha llevado a la incubadora.

### La pantalla de la incubadora

```
    ENTERING SCREEN 35
        IF FLAG 1 > 9
        THEN
            SET TILE (8, 7) = 44
        END
        
        IF FLAG 1 = 14
        THEN
            SET TILE (8, 7) = 45
        END
    END
```

Este script modifica un tile de la pantalla dependiendo del número de huevos que hayamos llevado a la incubadora. Añadimos el código a `my/ci/entering_screen.h`:

```c
    // entering_screen.h
    if (n_pant == 35) {
        if (flags [1] > 9) {
            _x = 8; _y = 7;  _n = 0;
            _t = flags [1] == 14 ? 45 : 44;
            update_tile ();
        }
    }
```

En esta pantalla, obviamente, tenemos también interacción. En este juego se hacía pulsando la dirección "Abajo"

```
    PRESS_FIRE ON SCREEN 35
        IF PLAYER_IN_X 112, 143
        IF PLAYER_IN_Y 128, 159
        IF PLAYER_HAS_OBJECTS
        THEN
           DEC OBJECTS 1
           INC FLAG 1, 1
           SOUND 5
        END

        IF FLAG 1 > 9
        THEN
            SET TILE (8, 7) = 44
        END

        IF FLAG 1 = 14
        THEN
            SET TILE (8, 7) = 45
        END
    END
```

Todas las interacciones de este tipo, como siempre, las colocamos en `my/ci/extra_routines.h`. Pero nos damos cuenta de que hay código repetido: el que modifica la pantalla según el valor de `flags [1]`, así que crearemos una función en `my/ci/extra_functions.h` para esto, con lo que el conjunto nos queda así:

```c
    // extra_functions.h

    void screen_35_decoration (void) {
        if (flags [1] > 9) {
            _x = 8; _y = 7;  _n = 0;
            _t = flags [1] == 14 ? 45 : 44;
            update_tile ();
        }
    }
```

```c
    // entering_screen.h
    
    if (n_pant == 35) screen_35_decoration ();
```

```c
    // extra_routines.h
    
    if ((pad0 & sp_DOWN) == 0) {
        if (n_pant == 35) {
            if (gpx >= 112 && gpx <= 243) {
                if (gpy >= 128 && gpy <= 159) {
                    p_objs = 0;
                    ++ flags [1];
                    beep_fx (5);

                    screen_35_decoration ();
                }
            }
        }
    }
```

### Modificaciones al mapa

Hay dos modificaciones en el mapa que dependen del valor de `flags [1]`:

```
    ENTERING SCREEN 1
        IF FLAG 1 = 14
        THEN
            SET TILE (0, 3) = 0
        END
    END

    ENTERING SCREEN 42
        IF FLAG 1 > 9
        THEN
            SET TILE (14, 2) = 0
        END
    END
```

Añadimos todo esto en `my/ci/entering_screen.h`. Hemos reorganizado todo un poco para manejar todas las pantallas en un `switch`:

```c
    // entering_screen.h

    switch (n_pant) {
        case 35:
            screen_35_decoration ();
            break;

        case 1:
            if (flags [1] == 14) {
                _x = 0; _y = 3; _t = _n = 0;
                update_tile ();
            }
            break;

        case 42:
            if (flags [1] > 9) {
                _x = 14; _y = 2; _t = _n = 0;
                update_tile ();
            }
            break;
    }
```

### Final del juego

El final del juego se da en la pantalla 0 al accionar el tile en la posición (3, 8) si el boss está muerto:

```c
    // extra_routines.h

    if ((pad0 & sp_DOWN) == 0) {
        [...]

        if (n_pant == 0) {
            if (p_tx == 3 && p_ty == 8) {
                if (boss_killed) {
                    success = 1;
                    playing = 0;
                }
            }
        }
    }
```

## Sonidos custom

Este juego emplea un set de sonidos custom contenido en un archivo `beeper3.bin` que hemos colocado en `/bin`. Estas rutinas son completamente independientes entre sí y ocupa cada una 50 bytes. Para hacerlo funcionar tendremos que cambiar `beeper.h` para que llame a los puntos de entrada correctos:

```c
    extern unsigned char beeper [];

    #asm
        ._beeper
            BINARY "../bin/beeper3.bin"
    #endasm


    void beep_fx (unsigned char n) {
        #asm
            xor a
            ld  (23624), a
        #endasm

        switch (n) {
            case 0:
                #asm
                        call _beeper
                #endasm
                break;
            case 1:
                #asm
                    call _beeper + 50
                #endasm
                break;          

            [...]
        }
    }
```

## Configuración del teclado

**Sami Troid** utiliza una configuración diferente del teclado:

* A, Left/Izquierda: Left/Izquierda
* C, Right/Derecha: Right/Derecha
* S, Down/Abajo: Action/Acción
* N, Up/Arriba: Jump/Salto
* M, Fire/Fuego: Shoot/Disparo

Así que se la pondremos en `my/config.h`:

```c
    //#define USE_TWO_BUTTONS                   // Alternate keyboard scheme for two-buttons games
    #ifdef USE_TWO_BUTTONS
        // Define here if you selected the TWO BUTTONS configuration
        [...]
    #else
        // Define here if you selected the NORMAL configuration

        struct sp_UDK keys = {
            0x047f, // .fire
            0x08fe, // .right
            0x01fd, // .left
            0x02fd, // .down
            0x087f  // .up
        };
    #endif
```

## Y terminado

Otro port, otro tutorial. ¡Gracias, **Son Link**!
