# Godkiller 2

Port a **MTE MK1 v5** del juego de **cтнonιan godĸιller** (Maxi Ruano).

Este juego demuestra el modo 128K con un solo nivel.

## 128K con un solo nivel

El modo 128K con un solo nivel fue creado ex profeso para desarrolladores que estaban creando su juego 48K pero se quedaron sin memoria suficiente. Activando este modo (`MODE_128K` sin `COMPRESSED_LEVELS`) se activa `librarian.h` y se mueven las pantallas fijas a la RAM3. De regalo tendremos música y efectos 128K.

Para portar **Godkiller 2** a **MTE MK1 v5** he hecho lo siguiente:

1. tomé como base `src/spare/compile_128k.bat` para la generación de la cinta con el cargador en ensamble para 128K. No hay que olvidarse de poner el número de pantallas (40) en la llamada a `msc3_mk1` y las dimensiones del mapa en `mapcnv`. Además, este juego es `UNPACKED`.

2. Hice las modificaciones al mismo descritas en el capítulo 13 del tutorial (eliminar carga de RAM4, RAM6 y RAM7)

3. Construí `build_assets.bat` para construir los tiestos que van a la RAM extra: en este caso, las pantallas fijas y la OGT.

```
    @echo off

    if [%1]==[skipscr] goto skipscr

    echo Converting Fixed Screens
    ..\..\..\src\utils\png2scr ..\gfx\title.png ..\bin\title.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\ending.png ..\bin\ending.scr > nul

    ..\..\..\src\utils\apultra ..\bin\title.scr ..\bin\title.bin > nul
    ..\..\..\src\utils\apultra ..\bin\ending.scr ..\bin\ending.bin > nul

    del ..\bin\*.scr > nul

    :skipscr

    echo Running The Librarian
    ..\..\..\src\utils\librarian2.exe list=..\bin\list.txt index=assets\librarian.h bins_prefix=..\bin\ rams_prefix=..\bin\ > nul

    echo Making music
    cd ..\mus
    ..\..\..\src\utils\pasmo ..\mus\WYZproPlay47aZXc.ASM ..\bin\RAM1.bin > nul
    cd ..\dev

    echo DONE
    ..\..\..\src\utils\printsize ..\bin\RAM1.bin
    ..\..\..\src\utils\printsize ..\bin\RAM3.bin
```
(`dev/build_assets.bat`)

4. Monté la OGT en `mus/` comprimiendo los archivos `.mus` como mandan los cánones de v5. También he añadido "empty.mus.bin" porque el juego no tiene música ingame pero el sistema necesita un stub.

```
    @echo off
    ..\..\..\src\utils\apultra.exe menu.mus menu.mus.bin
    ..\..\..\src\utils\apultra.exe ending.mus ending.mus.bin
```
(`mus/pack_music.bat`)

```asm
    [...]
    ;; Las canciones tienen que estar comprimidas con aplib
                
    SONG_0:
        INCBIN "menu.mus.bin"
    SONG_1:
        INCBIN "empty.mus.bin"
    SONG_2:
        INCBIN "ending.mus.bin"

    ;; INCLUIR LOS EFECTOS DE SONIDO:

    INCLUDE "efectos.asm"

    ;; Añadir entradas para cada canción
                    
    TABLA_SONG:     DW      SONG_0, SONG_1, SONG_2

    ;; Añadir entradas para cada efecto
    [...]
```
(final de `WYZproPlay47aZXc.ASM` con el playlist)

5. Apañé `my/config.h` con la configuración del juego.

6. Y mediante un extraño y misterioso proceso obtuve un resultado genial.

## Transformación

Creo que es muy interesante tomcar este juego en su estado actual y convertirlo para eliminar el script e implementar las cosas que hace de otras formas. Vamos a repasar el script del juego y decidir cómo vamos a implementar cada parte.

¿Es mejor no usar script? Generalmente, para juegos de un solo nivel o que sólo tengan un script para todos los niveles *sí*, pero esto dependerá mucho de las características del juego y del script. En este caso lo vamos a hacer por puro interés pedagógico.

Empezamos yendo a `my/config.h` y desactivando el scripting.

### El texto de cada pantalla

Al entrar en cada pantalla ponemos un textito en la parte baja del marcador. Lo añadimos en `my/ci/entering_screen.h`:

```c
    // entering_screen.h

    _x = 6; _y = 23; _t = 71;
    _gp_gen = "   CIUDAD_DE_DIS  "; print_str ();
```

### Los tres objetos

El objetivo del juego es llevar tres objetos a un sitio específico. Los tres objetos, **antorcha**, **escudo** y **tablilla**. La **antorcha** además te sirve para acceder a un par de sitios por diferentes vias.

Hay muchas formas de implementar los objetos. **Godkiller 2** los planta en el mapa como tiles y luego emplea el script para que el jugador los recoja. Se detecta que se pulsa la tecla de acción, se modifican algunos flags y se borra el gráfico. El problema es que luego el juego no recuerda que se han cogido y vuelven a aparecer, aunque ya no se puedan coger. Esto se podría resolver metiendo nuevas cláusulas `ENTERING SCREEN` pero nuestro objetivo es eliminar el script y hacer las cosas de otra forma.

Nosotros vamos a implementar los tres objetos como hotspots de tipo custom que inyectaremos en `my/ci/hotspots_custom.h`. Hemos reordenado levemente el tileset para tener los tres objetos seguidos en las posiciones de tile 21, 22 y 23. Fijáos en como funcionan los hotspots

![Tileset Godkiller 2](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/XX_godkiller_TS.png)

Por razones históricas y de ampliaciones mal pensadas, los hotspots 1-3 mapean raro (el 1 al 17, el 2 al 18, pero el 3 al 16 en vez de al 19), pero del 4 en adelante siempre se cumple que para el hotspot de tipo N se emplea el tile 16+N: para la recarga de munición (hotspot tipo 4) se emplea el tile 20, y para la recarga de tiempo (hotspot tipo 5, sin usar en este juego) se emplea el tile 21. 

Esta es la característica que podemos usar para crear nuevos tipos de hotspot. Como los tiles que representan los objetos son el 21, el 22 y el 23, podemos mapearlos a los hotspots "custom" números 5, 6 y 7. Esta es una lista de donde se ubican:

|#|Hotspot|`n_pant`|(x,y)
|---|---|---|---
|`5`|Escudo|38|(6,4)
|`6`|Tablilla|8|(6,1)
|`7`|Antorcha|15|(13,4)

Lo primero que toca es editar el mapa y eliminarlos de las pantallas donde están puestos: la 8, la 15 y la 38. Seguidamente, abriremos el Ponedor y colocaremos los hotspots en el sitio correcto, según la tabla de más arriba.

Una vez hecho esto, vamos a añadir código para que el motor los gestione. Para no andar creando variables, vamos a usar `flags [ID_HOTSPOT]` para controlar que están cogidos, y `flags [0]` para hacer una cuenta de ellos (de 0 a 3). Del borrado y persistencia se encarga el motor. Para colocarlos en el marcador usaremos la función `draw_invalidate_coloured_tile_gamearea` de la API

```c
    // hotspots_custom.h
    case 5:
    case 6:
    case 7:
        rda = hotspots [n_pant].tipo;

        ++ flags [0];
        flags [rda] = 1;
        wyz_play_sound (7);

        _x = (rda << 1) + 16; _y = 0; _t = 16 + rda;
        draw_coloured_tile ();
        invalidate_tile ();
        break;
```

Esto está bien para empezar, pero al coger los objetos se imprime un texto para cada uno. Podemos crear los textos en `my/ci/extra_vars.h` y hacer un array con ellos que emplear directamente en `my/ci/hotspots_custom.h`. Quedaría así:

```c
    // extra vars.h 
    extern unsigned char *textos_hotspots [0]; 

    #asm
        .texto0 defm "VOLUNTAD_DE_CRONOS", 0
        .texto1 defm "___RUNAS_DE_DIS___", 0
        .texto2 defm "___FUEGO_ESTIGIO__", 0

        ._textos_hotspots 
            defw texto0, texto1, texto2
    #endasm
```

```c
    // hotspots_custom.h
    case 5:
    case 6:
    case 7:
        rda = hotspots [n_pant].tipo;

        ++ flags [0];
        flags [rda] = 1;
        wyz_play_sound (7);

        _x = (rda << 1) + 16; _y = 0; _t = 16 + rda;
        draw_coloured_tile ();
        invalidate_tile ();

        _gp_gen = textos_hotspots [rda - 5];
        _x = 6; _y = 23; _t = 71; 
        print_str ();
        break;
```

No nos olvidemos de inicializar estas flags

```c
    // entering_game.h
    flags [0] = flags [5] = flags [6] = flags [7] = 0;
```

### Los teletransportadores

En el juego hay tres teletransportadores. Dos se puede activar directamente acercándose y pulsando la tecla de acción. El tercero sólo se puede activar si llevas la **antorcha**. 

|Origen|Destino|Objeto
|---|---|---
|10, (6, 3)|10, (6, 7)|**antorcha** (`7`)
|28, (7, 5)|35, (7, 2)| 
|35, (3, 5)|3, (10, 4)| 

Para replicar estos comportamientos detectaremos que se pulsa la tecla M en `my/ci/extra_routines.h` y actuaremos en consecuencia según el sitio donde estemos. Para ahorrar código meteremos los valores de las teletransportaciones en una serie de arrays en `my/ci/extra_vars.h`:

```c
    // extra vars.h 
    [...]

    const unsigned char warp_from_x [] =    {  6,  7,  3 };
    const unsigned char warp_from_y [] =    {  3,  5,  5 };
    const unsigned char warp_to_n_pant [] = { 10, 35,  3 };
    const unsigned char warp_to_x [] =      {  6,  7, 10 };
    const unsigned char warp_to_y [] =      {  7,  2,  4 };
```

```c
    // extra_routines.h
    if (sp_KeyPressed (KEY_M)) {
        rda = 0;
        switch (n_pant) {
            case 10:
                if (flags [7]) {
                    rda = 1;
                    _x = 6; _y = 23; _t = 71; 
                    gp_gen = " LA LLAMA TE GUIA "; print_str ();
                }
                break;

            case 28:
                rda = 2;
                break;

            case 35:
                rda = 3;
                break;
        }

        if (rda) {
            rda --;
            if (p_tx == warp_from_x [rda] && p_ty == warp_from_y [rda]) {
                n_pant = warp_to_n_pant [rda];
                gpx = warp_to_x [rda] << 4; p_x = gpx << FIXBITS;
                gpy = warp_to_y [rda] << 4; p_y = gpy << FIXBITS;
                wyz_play_sound (5);
            }
        }
    }

```

### Otro uso de la antorcha

Si la antorcha se usa en la pantalla 11, coordenadas de tile (12, 7), debemos modificar la pantalla. Lo añadimos dentro de `my/ci/extra_routines.h`, detrás del código anterior:

```c
    // extra_routines.h
    if (sp_KeyPressed (KEY_M)) {

        [...]

        if (flags [7] && n_pant == 11 && p_tx == 12 && p_ty == 7) {
            _x = 12; _y = 8; _t = _n = 0; update_tile ();
            wyz_play_sound (5);
        }
    }
```

### Condición de final

El final se mostrará cuando pulsemos *acción* en la posición (7, 1) de la pantalla 4 llevando los tres objetos y habiendo coleccionado todos los item (hotspots tipo 1). Será lo último que coloquemos en  `my/ci/extra_routines.h`:

```c
    // extra_routines.h
    if (sp_KeyPressed (KEY_M)) {

        [...]

        if (n_pant == 4 && p_tx == 7 && p_ty == 1) {
            if (p_objs == 15 && flags [0] == 3) {
                success = 1;
                playing = 0;            
            }
        }
    }
```

## Listo

Y con esto y un bizcocho, portar el juego del Sr. Ruano me ha servido para probar el modo 128K sin niveles y para currarme un minitutorialito práctico.

¡Asias Titan 😈!
