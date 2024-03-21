# Capítulo 12: Juegos multinivel (48K)

Este capítulo es muy interesante pero no ponemos paquetito de materiales, ya que ¿qué mejor paquete que el del Sgt Helmet? Entre los ejemplos de **MTE MK1** tienes la nueva versión de uno de los juegos de Mojon Twins que más nos gusta a los Mojon Twins, esta vez con tres fases. Puedes mirar las cosas de las que hablamos aquí en marcha en ese juego.

Por cierto, este capítulo es denso como su puta madre. Pero así es la vida. Si quieres multinivel tendrás que empaparte muy bien de como funciona el motor. Así que al turrón, chino Cudeiro.

## En qué se basa el multiniveleo

Básicamente el multinivel en **MTE MK1** (¡y en **MK2**!) se basa un poco en engañar al chamán. Básicamente el motor es como el abuelo y tú vas y le cambias las pastillas de sitio y le pones las verdes en vez de las rojas.

Para entendernos, **MTE MK1** funcionará (salvo por un par de detalles) como si estuviese ejecutando un juego normal de sólo un nivel como los de la churrera de toda la vida, solo que habrá un agente que se encargará de, antes de que empiece el bucle de juego, de *descomprimir* un nuevo set formado por mapa, cerrojos, tileset, enemigos, hotspots, comportamientos y opcionalmente sprites sobre los actuales, efectivamente *cambiando de fase*.

Lo que se hace para construir un juego de **MTE MK1** multinivel es configurar una especie de nivel "dummy" o "vacío" para hacer "sitio": un mapa a 0, cerrojos vacíos, un tileset con todos los tiles negros, todas las pantallas sin enemigos ni hotspots, y un montón de comportamientos a cero. Obviamente, a esto no se puede jugar. Pero además cargamos una serie de binarios comprimidos con mapas, tilesets, enemigos... y antes de empezar el juego descomprimimos los que necesitemos sobre los espacios "vacíos" que hemos reservado.

## Activando en `config.h`

En principio, para activar el multinivel sólo tendremos que tocar un par de cosas en `my/config.h`. Obviamente, luego habrá que tunear por varios sitios, pero lo más básico es configurar esto:

```c
    #define COMPRESSED_LEVELS                   // use levels.h instead of mapa.h and enems.h (!)
    #define MAX_LEVELS                  3       // # of compressed levels
```

Esto activará los manejes necesarios para el multiniveleo y además indicará que el número de niveles de nuestra secuencia será 3. O sea, que tendremos tres niveles.

Si queremos usar un spriteset diferente en cada nivel tendremos que descomentar `PER_LEVEL_SPRITESET`.

Si queremos que las estadísticas (objetos, llaves) se mantengan de nivel a nivel, tendremos que definir `NO_RESET_STATS`.

## Modificando `compile.bat`

Como hemos dicho, los recursos comprimidos se descomprimirán sobre "espacios" especiales para cada tipo de datos que maneja el motor. Por lo general, esto implica que no tendremos que generar enemigos o mapas desde `compile.bat`. Lo único que vamos a dejar es la generación de un tileset "vacío" (porque necesitamos la fuente), un spriteset y las pantallas fijas. De hacer hueco para el resto ya se encarga **MTE MK1** con la configuración que le hemos hecho. Por tanto abrimos en `compile.bat` y:

1. Nos fumamos la conversión del mapa (`mapcnv`) y la importación de los enemigos (`ene2h`).

2. Modificamos la conversión del tileset (`ts2bin`) para que genere uno usando sólo la fuente, sin incluir tiles. Para ello empleamos la cadena `notiles` en lugar de una ruta al un archivo de tileset:

```
    ..\..\..\src\utils\ts2bin.exe ..\gfx\font.png notiles font.bin 7 >nul
```

3. Si fueramos a cambiar el spriteset en cada fase tendríamos que eliminar también la llamada a `sprcnv`.

## Preparando los assets

Los *assets* o los *recursos* son las *cosas* con las que vamos a construir nuestros niveles. Como hemos mencionado, un *nivel* de **MTE MK1** se corresponde de (voy a resumirte cosas que ya sabes):

1. Un mapa, en formato PACKED (75 bytes por pantalla, 2 tiles por byte, 16 tiles) o UNPACKED (150 bytes por pantalla, 1 tile por byte, 48 tiles).

2. Un set de cerrojos. Cada cerrojo representa eso, un cerrojo. Se almacena en qué pantalla está y en qué coordenadas, y si está abierto o cerrado.

3. Un tileset, o 192 caracteres o "patrones" y los atributos (o colores) con los que se pintan.

4. Un set de enemigos, con tres por pantalla. Cada enemigo ocupa 10 bytes.

5. Un set de hotspots, uno por pantalla. Cada hotspot ocupa 3 bytes.

6. Un set de comportamientos de tile.

7. Opcionalmente (en 48K, en 128K no es opcional) un spriteset de 16 tiles de 144 bytes más una "cabecera" de 16 bytes (2320 bytes).

Nosotros tendremos que generar nuestro conjunto de recursos, comprimirlos en formato aplib, y luego combinarlos para formar los niveles. El primer paso, por tanto (aparte de, ejem, *hacerlos*) será generar binarios comprimidos de cada uno de ellos, en el formato de **MTE MK1**.

Personalmente, a mí me gusta crearme un archivo `.bat` aparte de `compile.bat` que se encargue de convertir y comprimir todos los _assets_. En este archivo llamaremos a los conversores para cada recurso y luego comprimiremos el resultado. Puedes guardarlo todo en `/bin` y así no lo tienes por medio.

Si eres una persona avispada estarás pensando que no paro de hablar de binarios y algunos de los conversores echan archivos .h con los arrays en formato código. Y así es, ¡cinco puntos para Gryffindor, señorita Granger! Por suerte, hay versiones de esos conversores pensadas para multinivel que escupen binarios. Y en esta sección lo vamos a ver usando la generación de recursos de **Helmet** como ejemplo.

### Tilesets sin fuente

¿Para qué vamos a guardar la fuente varias veces? Si recordáis, cuando hablamos de `ts2bin` mencionamos que se le podía decir que no pillara fuente. Si en vez de la ruta a nuestro archivo `font.png` ponemos `nofont`, el binario generado sólo contendrá los 192 patrones que forman los tiles (desde el 64 al 255) y los atributos, algo así:

```
    ..\..\..\src\utils\ts2bin.exe nofont ..\gfx\work0.png ..\bin\tileset0.bin 6 >nul
```

En **Helmet** tenemos tres fases y usamos tres tilesets diferentes, por lo que verás tres líneas de `ts2bin` diferentes en `build_assets.bat`. Recuerda que el numerito que se pasa como cuarto parámetro es la tinta por defecto que se debe usar si en un patrón sólo hay un color. Fijaos que en la fase 2, donde el suelo es mayormente cyan, pasamos un "5".

Fíjate también en cómo colocamos la salida de la conversión en `/bin` especificando la ruta relativa desde `/dev` directamente en el tercer parámetro. Si esto de rutas relativas te suena a chino deberías leer [algún tutorial sobre el tema](https://www.abrirllave.com/cmd/rutas-relativas-y-absolutas.php) y reforzar tus conocimientos de la ventana de línea de comandos.

El siguiente paso es comprimirlo todo. Puedes usar `apack` de toda la vida o `apultra`. Apultra es [un nuevo compresor de Emmanuel Marty](https://github.com/emmanuel-marty/apultra) que comprime un poco más que el viejo `apack`. Por contra es bastante más lento, pero si tu PC no es como el mío y pertenece a la actualidad no lo notarás.

Por convención, la versión comprimida de cada binario se llamará igual que el binario pero con una "c" al final, e igualmente la dejaremos en `/bin`. Personalmente me encargo además de borrar los archivos sin comprimir por el tema del orden y la limpieza. Esta sección, para **Helmet**, queda así:

```
    echo Making tilesets
    ..\..\..\src\utils\ts2bin.exe nofont ..\gfx\work0.png ..\bin\tileset0.bin 6 >nul
    ..\..\..\src\utils\ts2bin.exe nofont ..\gfx\work1.png ..\bin\tileset1.bin 5 >nul
    ..\..\..\src\utils\ts2bin.exe nofont ..\gfx\work2.png ..\bin\tileset2.bin 6 >nul

    ..\..\..\src\utils\apultra.exe ..\bin\tileset0.bin ..\bin\tileset0c.bin >nul
    ..\..\..\src\utils\apultra.exe ..\bin\tileset1.bin ..\bin\tileset1c.bin >nul
    ..\..\..\src\utils\apultra.exe ..\bin\tileset2.bin ..\bin\tileset2c.bin >nul

    del  ..\bin\tileset?.bin > nul
```

Tomamos nota de los archivos generados: `tileset0c.bin`, `tileset1c.bin` y  `tileset2c.bin`.

### Importando mapas y cerrojos binariamente

El viejo `mapcnv` que venimos usando desde tiempos inmemoriales sacaba un archivo de código con dos arrays, uno para el mapa y otro para los cerrojos, por lo que no nos sirve. Por suerte un día se reprodujo por gemación y en la carpeta apareció su análogo binario, el señor `mapcnvbin`, que toma los mismos parámetros (y nos los chiva igualmente al ejecutar simplemente):

```
    $ ..\utils\mapcnvbin.exe
    ** USO **
       MapCnvBin archivo.map archivo.h ancho_mapa alto_mapa ancho_pantalla alto_pantalla tile_cerrojo [packed] [fixmappy]

       - archivo.map : Archivo de entrada exportado con Mappy en formato raw.
       - archivo.h : Archivo de salida
       - ancho_mapa : Ancho del mapa en pantallas.
       - alto_mapa : Alto del mapa en pantallas.
       - ancho_pantalla : Ancho de la pantalla en tiles.
       - alto_pantalla : Alto de la pantalla en tiles.
       - tile_cerrojo : Nº del tile que representa el cerrojo.
       - packed : Escribe esta opción para mapas de la churrera de 16 tiles.
       - fixmappy : Escribe esta opción para arreglar lo del tile 0 no negro

    Por ejemplo, para un mapa de 6x5 pantallas para MTE MK1:

       MapCnvBin mapa.map mapa.bin 6 5 15 10 15 packed

    Output will contain the map, and then the bolts
```

`mapcnvbin` genera un binario con la misma información que `mapcnv`: el mapa en el formato indicado y seguidamente los cerrojos. En la llamada añadiremos `packed` si el mapa es de 16 tiles y `fixmappy` si el primer tile del tileset no era negro completamente y Mappy nos hizo la fullería de desplazar todo el tileset:

```
    ..\..\..\src\utils\mapcnvbin.exe ..\map\mapa0.map ..\bin\mapa_bolts0.bin 1 24 15 10 15 packed fixmappy >nul
```

De nuevo ponemos la salida en `/bin`.

Igual que con los tilesets, el siguiente paso será comprimir los binarios. Seguimos la misma convención para los nombres de los archivos y también limpiamos los archivos originales sin comprimir. En **Helmet**:

```
    echo Converting maps
    ..\..\..\src\utils\mapcnvbin.exe ..\map\mapa0.map ..\bin\mapa_bolts0.bin 1 24 15 10 15 packed fixmappy >nul
    ..\..\..\src\utils\mapcnvbin.exe ..\map\mapa1.map ..\bin\mapa_bolts1.bin 1 24 15 10 15 packed fixmappy >nul
    ..\..\..\src\utils\mapcnvbin.exe ..\map\mapa2.map ..\bin\mapa_bolts2.bin 1 24 15 10 15 packed fixmappy >nul

    ..\..\..\src\utils\apultra.exe ..\bin\mapa_bolts0.bin ..\bin\mapa_bolts0c.bin >nul
    ..\..\..\src\utils\apultra.exe ..\bin\mapa_bolts1.bin ..\bin\mapa_bolts1c.bin >nul
    ..\..\..\src\utils\apultra.exe ..\bin\mapa_bolts2.bin ..\bin\mapa_bolts2c.bin >nul

    del  ..\bin\mapa_bolts?.bin >nul
```

Tomamos nota de los archivos generados: `mapa_bolts0c.bin`, `mapa_bolts1c.bin` y `mapa_bolts2c.bin`. Como veis, intento que los nombres de archivo sean lo más descriptivos posible.

### Importando los enemigos y hotspots binariamente

De la misma forma que pasaba con los mapas, normalmente usábamos un conversor que generaba un archivo de código C (`ene2h`) que ahora no nos sirve. La utilidad que emplearemos será `ene2bin_mk1`. Ojal, que el formato es diferente al de **MK2** y no nos vale el `ene2bin` de MK2. Si lo ejecutamos sin parámetros vemos qué espera de nosotros:

```
    $ ..\utils\ene2bin_mk1.exe
    $ ene2bin_mk1.exe enems.ene enems+hotspots.bin life_gauge [2bytes]

    The 2bytes parameter is for really old .ene files which
    stored the hotspots 2 bytes each instead of 3 bytes.
    As a rule of thumb:
    .ene file created with ponedor.exe -> 3 bytes.
    .ene file created with colocador.exe for MK1 -> 2 bytes.

```

El funcionamiento es análogo, aunque deberemos fijarnos muy bien en el parámetro `life_gauge`. Para ahorrar código, como este valor va en la estructura y se descomprime cada vez que empezamos el nivel, si va ya puesto en el binario nos ahorramos el código que lo inicializa. En **helmet** este valor es 2.

Seguidamente comprimimos y borramos y bla bla. Nos queda así:

```
    echo Converting enems
    ..\..\..\src\utils\ene2bin_mk1.exe ..\enems\enems0.ene ..\bin\enems_hotspots0.bin 2 >nul
    ..\..\..\src\utils\ene2bin_mk1.exe ..\enems\enems1.ene ..\bin\enems_hotspots1.bin 2 >nul
    ..\..\..\src\utils\ene2bin_mk1.exe ..\enems\enems2.ene ..\bin\enems_hotspots2.bin 2 >nul

    ..\..\..\src\utils\apultra.exe ..\bin\enems_hotspots0.bin ..\bin\enems_hotspots0c.bin >nul
    ..\..\..\src\utils\apultra.exe ..\bin\enems_hotspots1.bin ..\bin\enems_hotspots1c.bin >nul
    ..\..\..\src\utils\apultra.exe ..\bin\enems_hotspots2.bin ..\bin\enems_hotspots2c.bin >nul

    del  ..\bin\enems_hotspots?.bin
```

Tomamos nota de los archivos generados: `enems_hotspots0c.bin`, `enems_hotspots1c.bin` y `enems_hotspots2c.bin`.

### Los comportamientos (behs)

El array `behs` de `my/config.h` ya no se utilizará. En su lugar tendremos un binario de 48 bytes comprimido con los sets de comportamientos. Para generar estos binarios de forma sencilla tenemos `behs2bin`, que toma una lista de 48 valores separada por comas y la convierte en un binario de 48 bytes.

Lo primero por tanto será crear los archivos con las listas de comportamientos. Nosotros en **Helmet** usamos dos, ya que los dos primeros tilesets son equivalentes y podemos reaprovechar los comportamientos.

Así se ve un archivo de texto con comportamientos. Nada muy excitante:

```
    0,0,8,8,8,8,8,8,17,8,8,8,8,8,10,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0
```
Nótese que están todos seguidos y separados por comas, sin saltos de linea ni ninguna otra decoración, para asegurarnos de que el conversor, que es bastante tontete, no se hace la picha un lío con los valores. 

Esto equivale a este tileset:

![La primera fase de Helmet](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/12_ts_helmet_0.png)

Nosotros hemos tenido a bien guardarlos en `/gfx` junto a los tilesets que representan, pero tú organízate como mejor veas. Tenemos dos: `behs0_1.txt` para las dos primeras fases (recuerda que los verdaderos programadores empieza a contar por 0) y `behs_2.txt` para la tercera.

`behs2bin` únicamente toma dos parámetros: fichero de entrada con la lista en modo texto, y fichero de salida con los 48 bytes en binario. Y luego se comprimen y se borran los originales y bla bla:

```
    del  ..\bin\enems_hotspots?.bin

    echo Converting behs
    ..\..\..\src\utils\behs2bin.exe ..\gfx\behs0_1.txt ..\bin\behs0_1.bin >nul
    ..\..\..\src\utils\behs2bin.exe ..\gfx\behs2.txt ..\bin\behs2.bin >nul

    ..\..\..\src\utils\apultra.exe ..\bin\behs0_1.bin ..\bin\behs0_1c.bin >nul
    ..\..\..\src\utils\apultra.exe ..\bin\behs2.bin ..\bin\behs2c.bin >nul

    del  ..\bin\behs0_1.bin
    del  ..\bin\behs2.bin
```

Toma nota de los últimos archivos generados: `behs0_1c.bin` y `behs2.bin`. Ya lo tenemos todo.

## El levelset

El levelset es un array que contiene información sobre cada nivel de tu juego. Se define en `my/levelset.h` y sus miembros son elementos con esta estructura:

```c
    // 48K format:
    typedef struct {
        unsigned char map_w, map_h;
        unsigned char scr_ini, ini_x, ini_y;
        unsigned char max_objs;
        unsigned char *c_map_bolts;
        unsigned char *c_tileset;
        unsigned char *c_enems_hotspots;
        unsigned char *c_behs;
        #ifdef PER_LEVEL_SPRITESET
            unsigned char *c_sprites;
        #endif
        #ifdef ACTIVATE_SCRIPTING
            unsigned int script_offset;
        #endif
    } LEVEL;
```

(en modo 48K; en modo 128K es más sencillo pero ya lo veremos en otro capítulo, más adelante). El tema está en crear un array que referencie qué recursos necesitamos para cada nivel y algunos valores relevantes. Pero antes necesitamos que los recursos *estén disponibles*.

La forma de hacerlo es crear una referencia externa a ellos y posteriormente incluirlos desde ensamble en línea con la directiva `BINARY`. Super top todo. Soy consciente de que esto se complica, pero puedes tirar de receta.

Básicamente primero se define una referencia externa para poder añadir cosas a nuestro array:

```c
    extern unsigned char my_extern_array [0];
```

Esto sencillamente le dice al compilador que hay "algo" fuera que se llama `my_extern_array`. (Probablemente haya mejores formas de hacer esto, pero eso es lo que se traga `z88dk` y si no está roto, no lo arregles).

Luego se mete una sección de ensamble en línea y se mete lo que antes hemos referenciado, tal que así:

```c
    #asm
        ._my_extern_array
            BINARY "my_extern_binary.bin"
    #endasm
```

Ojal como la etiqueta del ensamble equivale al nombre del array externo referenciado arriba, pero con un subrayado delante. Porque cuando se compila el C y se genera ensamble, los identificadores de C se convierten en etiquetas de ensamble con el subrayado delante. Y cosas.

El `BINARY` lo que hace es incluir como datos lo que se encuentre en el archivo cuya ruta recibe como parámetro. Y esto es lo que nos hace el truco.

De esta forma estamos metiendo muy fácilmente los binarios que necesitamos en nuestro código, y será la técnica que emplearemos para meter todos los recursos comprimidos. Los importaremos e incluiremos de esta manera en `my/levelset.h` y posteriormente los referenciaremos en el array del *levelset*.

Ahora es cuando coges el papel donde habías apuntado todos los binarios que tenías. Yo he creado estas referencias externas para incluirlos todos. Fíjate en cómo se incluye la ruta relativa donde está el archivo `mk1.c`, o sea, `../bin/`:

```c
    // In 48K mode, include here your compressed binaries:

    extern unsigned char map_bolts_0 [0];
    extern unsigned char map_bolts_1 [0];
    extern unsigned char map_bolts_2 [0];
    extern unsigned char tileset_0 [0];
    extern unsigned char tileset_1 [0];
    extern unsigned char tileset_2 [0];
    extern unsigned char enems_hotspots_0 [0];
    extern unsigned char enems_hotspots_1 [0];
    extern unsigned char enems_hotspots_2 [0];
    extern unsigned char behs_0_1 [0];
    extern unsigned char behs_2 [0];

    #asm
        ._map_bolts_0
            BINARY "../bin/mapa_bolts0c.bin"
        ._map_bolts_1
            BINARY "../bin/mapa_bolts1c.bin"
        ._map_bolts_2
            BINARY "../bin/mapa_bolts2c.bin"
        ._tileset_0
            BINARY "../bin/tileset0c.bin"
        ._tileset_1
            BINARY "../bin/tileset1c.bin"
        ._tileset_2
            BINARY "../bin/tileset2c.bin"
        ._enems_hotspots_0
            BINARY "../bin/enems_hotspots0c.bin"
        ._enems_hotspots_1
            BINARY "../bin/enems_hotspots1c.bin"
        ._enems_hotspots_2
            BINARY "../bin/enems_hotspots2c.bin"
        ._behs_0_1
            BINARY "../bin/behs0_1c.bin"
        ._behs_2
            BINARY "../bin/behs2c.bin"
    #endasm
```

Con esto de arriba tendremos de gratis un puntero al inicio de cada uno de los recursos de los niveles de nuestro juego, así que ya podemos crear el array con el *levelset*. Este array debe llamarse `levels` e incluir toda la información para cada nivel. Vamos a echar un vistazo al de **Helmet** y vamos comentando:

```c
    // Define your level sequence array here:
    // map_w, map_h, scr_ini, ini_x, ini_y, max_objs, c_map_bolts, c_tileset, c_enems_hotspots, c_behs, script
    LEVEL levels [] = {
        { 1, 24, 23, 12, 7, 99, map_bolts_0, tileset_0, enems_hotspots_0, behs_0_1 },
        { 1, 24, 23, 12, 7, 99, map_bolts_1, tileset_1, enems_hotspots_1, behs_0_1 },
        { 1, 24, 23, 6, 8, 99, map_bolts_2, tileset_2, enems_hotspots_2, behs_2 }
    };
```

Como son muchos campos siempre me hago una chuleta en un comentario. Porque uno es listo, pero no tanto. Vamos a verlos en orden (que es el mismo orden con el que se han definido en el `struct` de más arriba):

1. **Ancho del nivel**, o `map_w` (ver la nota más adelante sobre niveles de diferentes tamaños).
2. **Alto del nivel**, o `map_h`.
3. **Pantalla de inicio**, o `scr_ini`.
4. **Coordenada X de inicio**, o `ini_x`, es coordenadas de tiles.
5. **Coordenada Y de inicio**, o `ini_y`, es coordenadas de tiles.
6. **Máximo de objetos para terminar el nivel**, o `max_objs`, o 99 si esto no debe ser tomado en cuenta, ya que 99, en este contexto, es un valor fuera de rango (ver la siguiente sección).
7. Puntero al recurso con el **mapa y los cerrojos**, o `c_map_bolts`.
8. Puntero al recurso con el **tileset** o `c_tileset`.
9. Puntero al recurso con los **enemigos y hotspots**, o `c_enems_hotspots`.
10. Puntero al recurso con los **comportamientos**, o `c_behs`.
11. *Si vamos a usar un spriteset diferente por cada fase* (en **Helmet** no), un puntero al recurso con el **spriteset**, o (c_sprites).
12. *Si el scripting está activado* (en **Helmet** no), el **offset dentro del script para este nivel**, o `script_offset`. Estos offsets se generan en `my/msc_config.h` al compilar un script multi-nivel, y son historias de `msc3` que aún no hemos visto y que dejaremos para otro momento.

Con esto tendríamos definido nuestro *levelset*. Pero aún hay que tunear un poquito.

## Controlando la condición de final de cada nivel

Esto puede complicarse hasta niveles estratosféricos dependiendo de como sea tu juego, sobre todo si va a tener variedad. En realidad todas estas historias terminan siendo muy sencillas cuando empiezas a manejarte realmente bien con el motor y los puntos de inyección de código son tus amigos y tus amantes. Voy a intentar dar aquí un porrón de información y luego ya ves tú qué haces con ella.

### Número de objetos

De fábrica, **MTE MK1** terminará la fase actual si `p_objs` vale `PLAYER_NUM_OBJETOS` y `PLAYER_NUM_OBJETOS` fue definida (si no se define, el código de la comprobación no se incluye). Esto va muy bien si ponemos el mismo número de objetos para coleccionar en todas las fases pero ¿y si queremos poner un número diferente en cada fase?

Para lograrlo, *engañaremos al chamán* (TM). Este es el código C que hace la comprobación de que tenemos todos los objetos (en `mainloop/game_loop.h`):

```c
    #ifdef PLAYER_NUM_OBJETOS
        || p_objs == PLAYER_NUM_OBJETOS
    #endif
```

Los `#define` sirven para que el preprocesador de C haga sustituciones textuales, por lo que si queremos que el número sea diferente para cada fase no tendremos más que definir `PLAYER_NUM_OBJETOS` para que no sea un literal numérico, sino el acceso a una variable.

En nuestro *levelset* tenemos información sobre el número de objetos de la fase: el miembro `num_objs` de la estructura `LEVEL`. En **MTE MK1** el nivel actual se almacena en la variable `level`, por lo que el número de objetos definido para el nivel actual es `levels [level].num_objs`. Por tanto, si nos vamos a `my/config.h` y definimos así `PLAYER_NUM_OBJS` lo tenemos:

```c
    #define PLAYER_NUM_OBJETOS          (levels [level].num_objs)
```

### Llegar a un sitio concreto

Aquí estamos en una situación igual. *Engañaremos al Chamán* (TM) de igual manera. Este es el código que comprueba que hemos llegado al sitio concreto:

```c
    #ifdef SCR_FIN
        || (n_pant == SCR_FIN
        #if defined PLAYER_FIN_X && defined PLAYER_FIN_Y
            && ((gpx + 8) >> 4) == PLAYER_FIN_X && ((gpy + 8) >> 4) == PLAYER_FIN_Y
        #endif
        )
    #endif
```

Como se ve, si sólo queremos que se detecte que llegamos a la pantalla final, `SCR_FIN` debe estar definida pero `PLAYER_FIN_X` y `PLAYER_FIN_Y` no; si todas están definidas se comprobará también la posición.

Como esto lo hemos usado muy poco no tuve a bien meterlo en la estructura `LEVEL`, pero podemos controlarlo nosotros igualmente con un poco de inyección de código (ver el [capítulo 11](./tutorial-cap11.md)). Veamos el caso en que queramos comprobar las tres cosas.

En primer lugar creamos tres arrays con los valores para cada fase de nuestro juego en `my/ci/extra_vars.h`. Vamos a poner que tenemos tres fases en nuestro juego ficticio que deben acabarse en las pantallas 5, 17 y 12, y coordenadas (7,8), (10,6) y (1,1), respectivamente.

```c
    // my/ci/extra_vars.h
    unsigned char scr_fin [MAX_LEVELS]      = { 5, 17, 12 };
    unsigned char player_fin_x [MAX_LEVELS] = { 7, 10,  1 };
    unsigned char player_fin_y [MAX_LEVELS] = { 8,  6,  1 };
```

Y con esto, no tenemos más que hacer las definiciones basándonos en estos arrays y la variable `level` en `my/config.h`.

```c
    #define SCR_FIN                     scr_fin [level]
    #define PLAYER_FIN_X                player_fin_x [level]
    #define PLAYER_FIN_Y                player_fin_y [level]
```

### _Scripting_

Terminar el nivel mediante _scripting_ es muy sencillo. Al igual que para juegos de un solo nivel, si comentamos la definición de las macros `MAX_OBJECTS` y `SCR_FIN` y activamos el _scripting_, la única forma de terminar la fase será ejecutando

```
    WIN GAME
```

desde el _script_. Además, en multilevel tenemos otra:

```
    GAME ENDING
```

Que se salta todas las fases que quedan y muestra directamente el final del güego.

### Inyección de código custom

Con la inyección de código es como más fullerías se pueden hacer (ya hemos visto una). Tienes puntos de inyección de códigos muy interesantes para modificar el comportamiento general y aburrido del motor (una fase después de la otra, desde la 0 a la última). Puedes hacer cosas muy interesantes en `my/ci/before_game`, `my/ci/entering_game.h`, `my/ci/extra_routines.h` y `my/ci/after_game_loop.h` para personalizar hasta el infinito, pero hay algunas cosas automáticas que puedes manejar con muy poco código, generalmente en los puntos de inyección que se ejecutan durante el juego (es buen momento para mirar [la documentación](https://github.com/mojontwins/MK1/blob/master/docs/code_injection.md)):

Para interrumpir el bucle del juego hay que poner la variable `playing` a 0. Entonces, el motor va a actuar de una u otra forma según el valor un conjunto de variables:

1. Si `success` vale 1, significa que hemos terminado el nivel "BIEN". Si no hacemos nada más, el motor saltará al nivel siguiente o mostrará el final si llegamos a `MAX_LEVELS`. Si, en cambio, vale 0, mostrará la pantalla de Game Over.

2. Si queremos mostrar el final del juego directamente, lo mejor es poner `success` a 1 y establecer `level` a un valor fuera de rango, mayor que `MAX_LEVELS`. Por convención usaremos `0xff`. Hacer esto hace que se interrumpa el bucle de juego y se muestre el final:

```c
    success = 1; level = 0xff;
```

3. Si tenemos el _scripting_ activado podemos lograr lo mismo poniendo `script_result` a 4.

4. Si tenemos el _scripting_ desactivado y ponemos `warp_to_level` a 1, o si lo tenemos activado y ponemos `script_result` a 3, se volverá a ejecutar el bucle de juego sin modificar `level`, `n_pant`, `p_x`, `gpx`, `p_y` ni `gpy`, por lo que podemos usar para saltar de un nivel a un punto concreto de otro:

```c
    level = 2;
    n_pant = 20;
    gpx = 5 << 4; p_x = gpx << FIXBITS;
    gpy = 7 << 4; p_y = gpy << FIXBITS;
    warp_to_level = success = 1;
```

Eso terminará el bucle de juego y saltará al nivel 2, pantalla 20, y pondrá al jugador en las coordenadas (de tile) (5, 7).

## Niveles de diferentes tamaños

Aquí estoy, verborrea loca en Groenlandia, aquí estoy soltando panoja según se me va ocurriendo. Es que son muchas cosas. Quizá algún día venga alguien y ordene esto mejor.

Sí, puedes hacer niveles de diferentes tamaños, de eso te has tenido que dar cuenta porque tienes `map_w` y `map_h` en la estructura `LEVEL`. A lo mejor también te has dado cuenta de la clave de todo esto: como el sistema funciona descomprimiendo un binario comprimido en un espacio en el que hemos hecho sitio, y este sitio se hace obviamente haciendo caso de las variables `MAP_W` y `MAP_H`, entonces ha de cumplirse que el número de pantallas del nivel que más tenga tiene que ser menor o igual que `MAP_W` * `MAP_H`. Si te habías dado cuenta de este detalle, otros diez puntos para Gryffindor, señorita Granger, y una estrellita.

En efecto, aunque la geometría del nivel de igual, tiene que caber en el buffer. Al final la geometría da lo mismo, porque un mapa o un conjunto de enemigos y hotspots no deja de estar ordenados como una tira de pantallas en memoria.

Por tanto, lo que hay que hacer es ver cuál es tu nivel más grande (el que más pantallas tenga) y hacer que los valores de `MAP_W` y `MAP_H` en `my/config.h` coincidan con sus dimensiones. Con esto ya lo tienes.

Pero ojaldrio con esto, porque hay un **INCREÍBLE GOTCHA**. **MK1** tiene una optimización por la cual, si se detecta que `MAP_W` o `MAP_H` valen 1, no se incluye el código correspondiente a los cambios de pantalla en el eje que mida 1 de largo. Si tu juego tiene niveles con diferentes geometrías **ten mucho cuidado con no poner 1 en ninguno de estos valores**. Calcula el máximo de pantallas de otra forma, aunque desperdices algo de memoria. Sorry but not sorry, esto se rompe muy poco pero ahorra muchos quebraderos de cabeza en el 90% de los casos.

## Y listo

Como ves, ya me detengo menos en decir tonterías y más en vomitar información, pero a estas alturas del cuento asumo que las bases están bien interiorizadas y además nos estamos moviendo ya a niveles más avanzados. Así que agárrate, que vienen más curvas.
