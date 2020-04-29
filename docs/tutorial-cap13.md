# Capítulo 13: Un juego de 128K

Si quieres saber como hacer un juego para 128K de un sólo nivel (pero con música AY y más sitio para tus cosas en RAM baja) puedes echarle un vistazo al [postmortem del port a v5 de **Godkiller 2**](https://github.com/mojontwins/MK1/tree/master/contrib/godkiller_2). Con todo lo que sabes y lo que pone ahí deberías tener suficiente.

¡Vaya! Si has conseguido llegar hasta aquí sin mandarme a freír castañas es que debes de ser todo un experto en **MTE MK1**, o quizá viste el título del capítulo por separado y has venido directamente aquí porque a lo que tú aspiras es a hacer un juego de verdaz, nada de mierdecillas.

Sea como sea, voy a suponer que has entendido muy bien cómo funciona el multinivel en **MTE MK1** y no me entretendré en explicaciones sobre el tema. También vamos a ver alguna que otra inyección de código, que voy a suponer que sabes cómo va.

Aquí vamos a construir un juego multinivel de 128K, con cutscenes, casinos y furcias. Vamos a construir

## Goku Mal

**Goku Mal** fue el primer juego para 128K escrito con **MTE MK1** (que, con él, evolucionó a la versión 3.99.3, si mal no recuerdo). También fue nuestro último juego con el motor, ya que para el siguiente ya nos inventamos MK2.

Se trata de un juego muy sencillo que tiene cinco fases en las que básicamente avanzamos y disparamos, salvo en la cuarta, en la que dejamos un momento aparte el desarrollo puramente lineal y nos entretendremos recogiendo rosas antes de volver a la acción.

La configuración del motor será de vista lateral, con saltos y disparos en 8 direcciones. Este juego levantó una gran polémica entre los súper tacañones, ya que estaba pensado para jugarse con dos botones de acción y no incluimos una opción para los que están acostumbrados a agarrarse de un joystick de un solo botón (esto no es una referencia fálica). En esta revisión corregiremos eso.

Tienes el juego completo en el directorio `/examples`. En este tutorial, además de muchas explicaciones, seguiremos paso por paso el mismo proceso que he seguido yo para montarlo en **MTE MK1** v5.

## Los juegos multinivel de 128K

Si recordáis, un juego multinivel de 48K de **MTE MK1** se parece mucho a un juego normal, solo que antes de empezar a jugar descomprimimos nuevos datos sobre el espacio donde el motor espera encontrarlos.

En 128K es básicamente lo mismo, pero con la diferencia de que tendremos casi toda la RAM extra como almacén de datos contenidos. En concreto, de las cinco páginas que no forman los 48K base del Spectrum de 128K, usaremos una para la música y tendremos cuatro más para datos comprimidos. ¡Y en 64K cabe mogollón de cosas!

Para que te hagas una idea, las tres fases de Helmet ocupaban menos de 7KB.

Aunque al principio el tema acojone un poco, lo cierto es que hacer un juego de 128K es más sencillo que un multinivel de 48K, porque aunque tenga más trabajo (normalmente meteremos más contenido y además tendremos que diseñar una banda sonora), los procesos son mucho más sencillos, como veremos muy pronto.

## Empezamos

Lo primero que haremos será reunir todos los recursos. Posteriormente veremos cómo importarlos, qué es un *level bundle* y cómo funciona **librarian**.

### Todos los tiestos.

He puesto *recursos* o *assets* porque sonaba más profesional y tal, pero la verdad es que en Mojonia siempre llamamos a estas cosas *tiestos*. Vamos a ver qué tiestos lleva **Goku Mal**.

Todos los tiestos irán en la RAM extra. Generaremos un _script_ `build_assets.bat` para construir los binarios que se cargarán en la RAM extra, incluyendo la banda sonora.

En primer lugar tendremos un buen porrón de pantallas comprimidas. Además de las tres estándar de **MTE MK1** (título, marco y final) tendremos tres _splash screens_ que se muestran tras cargar el juego y varias con imágenes para las *cutscenes*. Esta es una lista completa:

1. `title.png`, `marco.png` y `ending.png` ya sabes para qué son. Este juego, como ves, tiene marco separado de la pantalla de título.
2. `logo.png` tiene un logo de los Mojon Twins y el título del juego y se muestra nada más finalizar la carga.
3. `dedicado.png` es una dedicatoria, y se muestra también una única vez, al terminar la carga.
4. `controls.png` la hicimos para que los súper tacañones no se quejaran mucho por no usar OPQA (¡ni QAOP!), pero no funcionó para nada porque igualmente nos pusieron a parir.
5. `intro1.png`, `intro2.png`, `intro3.png` e `intro4.png` se muestran al iniciar una nueva partida y contienen la introducción del juego.
6. `intro5.png` se muestra antes de la fase 4 y sirve para ilustrar una escena del argumento del juego.
7. `intro6.png` e `intro7.png` forman parte de la secuencia final.
8. `zoneA.png` y `zoneB.png` se muestran antes de empezar cada nivel y muestran la cara de mala hostia de Goku Mal y el número de la fase que toca.
9. Finalmente tendremos nuestra pantalla de carga, `loading.png`, que tendremos que convertir pero no comprimir. Dejaremos esta tarea para `compile.bat` más adelante.

Sin salirnos de `gfx/`, tendremos además los gráficos para construir los niveles:

1. `work0.png`, `work1.png`, `work2.png`, `work3.png` y `work4.png` contienen los tilesets de las cinco fases. Es importante notar que todos estos tilesets tienen un tile 0 que no es del todo negro, por lo que habrá que tener en cuenta esto más adelante (ya que los .MAP tendrán los valores desplazados debido al _glitch_ de Mappy que ya conocemos bien). Tenemos aquí sus archivos de comportamientos asociados, `behs0.txt` a `behs4.txt`.
2. `sprites0.png`, `sprites1.png`, `sprites2.png`, `sprites3.png` y `sprites4.png` contienen los cinco spritesets correspondientes a cada una de las cinco fases.
3. `font.png` contiene la fuente base que se usará durante el juego.
4. `level_screen_ts.png` es un _charset_ completo que se empleará para las pantallas del nuevo nivel especial que tiene este juego.

En `map/` tenemos los mapas de los cinco niveles, `mapa0.fmp` a `mapa4.fmp` y sus exports en formato `MAP`: `mapa0.MAP` a `mapa5.MAP`.

En `enems/` tenemos los archivos de colocación de cosas para Ponedor, `enems0.ene` a `enems4.ene`. También hemos copiado aquí los `work?.png` con los tilesets y los `mapa?.MAP` con los mapas para que Ponedor los tenga bien a mano.

Este juego no tiene _scripting_, así que por último tenemos la banda sonora y OGT en el directorio `mus/`. Esta OGT fue creada con **Davidian** y tiene un montón de canciones. Ahora nos vamos a centrar más en la importación y construcción del juego pero dedicaré un capítulo para hablaros de cómo montar las OGT con Wyz Player.

### Importación: pantallas fijas

Empezaremos a construir nuestro _script_ encargado de crear los binarios con las pantallas fijas. Atención y muy importante: **Para que MTE MK1 funcione en modo 128K, las pantallas fijas básicas title, marco y ending deben llamarse `title.bin`, `marco.bin` y `ending.bin`**

```bat
    @echo off

    if [%1]==[skipscr] goto skipscr

    echo Converting Fixed Screens
    ..\..\..\src\utils\png2scr ..\gfx\title.png ..\bin\title.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\marco.png ..\bin\marco.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\ending.png ..\bin\ending.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\logo.png ..\bin\logo.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\dedicado.png ..\bin\dedicado.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\controls.png ..\bin\controls.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\intro1.png ..\bin\intro1.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\intro2.png ..\bin\intro2.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\intro3.png ..\bin\intro3.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\intro4.png ..\bin\intro4.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\intro5.png ..\bin\intro5.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\intro6.png ..\bin\intro6.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\intro7.png ..\bin\intro7.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\zoneA.png ..\bin\zoneA.scr > nul
    ..\..\..\src\utils\png2scr ..\gfx\zoneB.png ..\bin\zoneB.scr > nul

    ..\..\..\src\utils\apultra ..\bin\title.scr ..\bin\title.bin > nul
    ..\..\..\src\utils\apultra ..\bin\marco.scr ..\bin\marco.bin > nul
    ..\..\..\src\utils\apultra ..\bin\ending.scr ..\bin\ending.bin > nul
    ..\..\..\src\utils\apultra ..\bin\logo.scr ..\bin\logo.bin > nul
    ..\..\..\src\utils\apultra ..\bin\dedicado.scr ..\bin\dedicado.bin > nul
    ..\..\..\src\utils\apultra ..\bin\controls.scr ..\bin\controls.bin > nul
    ..\..\..\src\utils\apultra ..\bin\intro1.scr ..\bin\intro1.bin > nul
    ..\..\..\src\utils\apultra ..\bin\intro2.scr ..\bin\intro2.bin > nul
    ..\..\..\src\utils\apultra ..\bin\intro3.scr ..\bin\intro3.bin > nul
    ..\..\..\src\utils\apultra ..\bin\intro4.scr ..\bin\intro4.bin > nul
    ..\..\..\src\utils\apultra ..\bin\intro5.scr ..\bin\intro5.bin > nul
    ..\..\..\src\utils\apultra ..\bin\intro6.scr ..\bin\intro6.bin > nul
    ..\..\..\src\utils\apultra ..\bin\intro7.scr ..\bin\intro7.bin > nul
    ..\..\..\src\utils\apultra ..\bin\zoneA.scr ..\bin\zoneA.bin > nul
    ..\..\..\src\utils\apultra ..\bin\zoneB.scr ..\bin\zoneB.bin > nul

    del ..\bin\*.scr > nul

    :skipscr
```

Como normalmente en un desarrollo de este tipo las pantallas fijas son lo que menos va a evolucionar y además tardan un ratillo en comprimirse, añadimos un poco de magia _batch_. Cuando ejecutemos `build_assets.bat` con el parámetro `skipscr` la ejecución se saltará la conversión de las imágenes, lo que vendrá bien cuando tengamos que regenerar una y otra vez los mapas o la colocación de enemigos (repito, en un desarrollo normal en el que vas construyendo y depurando el juego poco a poco. Aquí ya lo tengo todo hecho).

### Importación: Level bundles

En modo 128K quisimos simplificar la importación de niveles creando los **level bundles**, que no son más que gruesos binarios que contienen todos los tiestos que definen un nivel: mapa, cerrojos, tileset, enemigos, hotspots, comportamientos y spriteset. Estos binarios se descomprimen de un plumazo sobre la zona de datos de **MTE MK1** ya que están organizados de la misma forma que ésta.

Para crear estos bundles utilizamos `buildlevels_MK1.exe` que puede recibir y recibe un millón de parámetros. Como siempre podemos ejecutar sin pasar nada y nos los chiva:

```
    C:\git\MK1\src\utils>buildlevels_MK1.exe
    buildlevel v0.5 20200125
    Builds a level bundle for MTE MK1 5.0+

    usage

    $ buildlevel.exe output.bin key1=value1 key2=value2 ...

    output.bin     Output file name.

    Parameters to buildlevel.exe are specified as key=value, where keys are as
    follows:

    MAP DATA

    mapsize        Needed if game contains differently sized levels: MAP_W*MAP:H
    mapfile        Especifies the .map file. packed/unpacked autodetected.
    map_w          Map width in screens.
    map_h          Map height in screens.
    decorations    Output filename for decorations. This makes your map packed.
    lock           Tile # for locks. (optional)
    fixmappy       Fixes mappy's 'no first black tile' behaviour

    TILESET/CHARSET DATA

    tilesfile      work.png (256x48) containing 48 16x16 tiles.
    behsfile       behs.txt containing 48 comma-separated values.
    defaultink     Value to use when PAPER=INK.

    SPRITESET

    spritesfile    sprites.png (256x?) containing N 16x16 sprites + masks.
    nsprites       # of sprites in sprites.png. If omitted, defaults to 16.

    ENEMIES

    enemsfile      enems.ene file

    HEADER STUFF

    scr_ini        Initial screen #
    ini_x          Initial x position (tiles)
    ini_y          Initial y position (tiles)
    max_objs       Max objects (can be omitted If not appliable)
    enems_life     Enems life
```

Como ves, se trata de un increíble batiburrillo de cosas de todos los conversores que hemos visto hasta el momento. Es posible que te estés preguntando por qué narices no se usa algo así también para los juegos normales y nos olvidamos de tanto conversor. Y es una pregunta muy interesante para la que ahora mismo no tengo respuesta :-D

Vamos por partes:

1. `output.bin` (obligatorio) es el nombre de archivo de salida, donde se escribirá toda la mandanga. El resto de los parámetros se escribe en formato `clave=valor`.

2. `mapsize` (opcional): indica el número total de pantallas que hay en el espacio de memoria reservado para el nivel, esto es, el resultado de multiplicar `MAP_W * MAP_H`. Esto es para juegos en los que tengas niveles de tamaños diferentes (mira el capítulo anterior para refrescar estos conceptos). Es opcional porque si todos tus niveles tienen el mismo número de pantallas te basta con especificar los siguientes parámetros:

3. `map_w` y `map_h` (obligatorios): especifican el ancho y alto en pantallas del nivel. Recuerda que `map_w * map_h` debe ser menor que el resultado de `MAP_W * MAP_H` (las macros de `my/config.h`) y por tanto menor o igual que `mapsize` si lo has especificado.

4. `mapfile` (obligatorio) es una ruta al archivo con el mapa en formato `.MAP`.

5. `decorations` (opcional) es una ruta a un archivo de salida en formato _script_ del motor con decoraciones automáticas y que puedes incluir desde tu _script_ para adornar las pantallas de forma automática. Básicamente el mapa se fuerza a *PACKED* y los tiles fuera de rango se escriben como decoraciones de las que se imprimen en los `ENTERING SCREEN`. Es una característica de `msc3` que aún no hemos comentado.

6. `lock` (opcional) sirve para especificar qué tile hace de cerrojo. Para **MTE MK1** tiene que ser el 15. Puedes omitir el parámetro si no usas cerrojos.

7. `fixmappy` (opcional) para deshacer el desbarajuste que lía Mappy si tu tileset no empieza por uno completamente negro.

8. `tilesfile` (obligatorio) debe contener la ruta al archivo con el tileset de hasta 48 tiles, que debe ser un archivo tipo png de 256x48, como hemos visto.

9. `behsfile` (obligatorio) es la ruta al archivo con los comportamientos, en el formato que vimos en el anterior capítulo: un archivo de texto con los 48 valores separados por comas.

10. `defaultink` (opcional) especifica una tinta por defecto para los patrones que solo tengan un color, igual que en `ts2bin`.

11. `spritesfile` (obligatorio) es la ruta al archivo con el spriteset en el formato de siempre.

12. `nsprites` (opcional) por si tenemos más de 16 sprites y que, por el momento, omitiremos (no soportado por el motor).

13. `enemsfile` (obligatorio) contendrá la ruta al archivo de colocación de enemigos y hotspots `.ene` del Ponedor.

14. Los datos de inicio `scr_ini`, `ini_x` e `ini_y` (obligatorios) sirven para indicar donde se empieza.

15. `max_objs` (opcional) es el número de objetos recogiscibles del nivel. Recuerda que este parámetro no se tomará en cuenta de todos modos a menos que hagamos la configuración parecida a la que explicaos en el capítulo anterior (en el apartado **Controlando la condición de final de cada nivel**) y que veremos más tarde.

16. `enems_life` (obligatorio) establece la vida de los enemigos.

Hemos dicho que **Goku Mal** es un juego muy sencillo. En él no hay _scriping_ y originalmente había algo de código _custom_, pero en esta recreación intentaremos hacerlo funcionar primero con lo más básico de **MTE MK1**. En las cuatro fases de acción en las que sólo hay que avanzar colocaremos un único ítem al final de la fase, de forma que al tocarlo terminaremos el nivel. En la fase 4, en la que hay que reunir un número de flores, igualmente terminaremos al reunirlas todas. Por tanto, la condición de final de todas las fases será sencillamente recoger todos los objetos.

Lo que tenemos que hacer ahora es escribir las cinco llamadas a `buildlevels_MK1` para generar los cinco *level bundles*. Veamos el primero.

El primer nivel se compone de `mapa0.map`, `enems0.ene`, `work0.png`, `behs0.txt` y `sprites0.png`. Se trata de un nivel vertical de 25 pantallas de altura. En este juego todos los niveles tienen 25 pantallas en diferentes geometrías menos el cuarto, que tiene 15, por lo que es necesario emplear el parámetro `mapsize`. Configuraremos `MAP_W` y `MAP_H` en `my/config.h` para que multiplicados den 25, y usaremos `mapsize=25` en todas las conversiones.

Como el primer tile de nuestro tileset no estaba vacío y lo hemos usado directamente para crear el mapa en Mappy, éste ha desplazado todos los valores una unidad y necesitaremos especificar `fixmappy`.

En el nivel se empieza en el nivel más bajo, o sea, en la pantalla 24, pegados al suelo, en la parte izquierda (coordenadas (2, 8)). En este juego no usamos cerrojos, por lo que omitiremos el parámetro. Tendremos que recordar activar `DEACTIVATE_KEYS`, ya que en el level bundle no se generarán cerrojos y por tanto tenemos que decirle al motor que no reserve sitio para ellos.

Finamente, en esta primera fase los enemigos normales soportarán dos golpes antes de morir.

Por tanto la llamada a `buildlevels_MK1.exe`, pensada para ejecutarse desde `dev/`,  sera algo así, para esta fase:

```
    $ ..\..\..\src\utils\buildlevels_MK1.exe ..\bin\level0.bin mapsize=25 mapfile=..\map\mapa0.MAP map_w=1 map_h=25 fixmappy tilesfile=..\gfx\work0.png behsfile=..\gfx\behs0.txt defaultink=7 spritesfile=..\gfx\sprites0.png enemsfile=..\enems\enems0.ene scr_ini=24 ini_x=2 ini_y=8 max_objs=1 enems_life=2
```

Si ejecutas esto directamente verás todo el proceso y todas las partes que, si te fijas, aparecen en el mismo orden que los distintos espacios reservados en `assets/levels.h` para poder plantar el binario justo ahí y que todo funcione.

Añadimos pues una llamada a `buildlevels` para cada uno de nuestros niveles, ajustando los parámetros necesarios según cada nivel. Fíjate en como las dimensiones del mapa van cambiando (aunque siempre son 25 pantallas), en cada nivel se empieza en un sitio diferente, cambia el número de objetos, y la cantidad de vida de los enemigos. Posteriormente comprimimos y limpiamos:

```
    echo Converting levels
    ..\..\..\src\utils\buildlevels_MK1.exe ..\bin\level0.bin mapsize=25 mapfile=..\map\mapa0.MAP map_w=1 map_h=25 fixmappy tilesfile=..\gfx\work0.png behsfile=..\gfx\behs0.txt defaultink=7 spritesfile=..\gfx\sprites0.png enemsfile=..\enems\enems0.ene scr_ini=24 ini_x=2 ini_y=8 max_objs=1 enems_life=2 > nul
    ..\..\..\src\utils\buildlevels_MK1.exe ..\bin\level1.bin mapsize=25 mapfile=..\map\mapa1.MAP map_w=25 map_h=1 fixmappy tilesfile=..\gfx\work1.png behsfile=..\gfx\behs1.txt defaultink=5 spritesfile=..\gfx\sprites1.png enemsfile=..\enems\enems1.ene scr_ini=0 ini_x=1 ini_y=5 max_objs=1 enems_life=2 > nul
    ..\..\..\src\utils\buildlevels_MK1.exe ..\bin\level2.bin mapsize=25 mapfile=..\map\mapa2.MAP map_w=25 map_h=1 fixmappy tilesfile=..\gfx\work2.png behsfile=..\gfx\behs2.txt defaultink=0 spritesfile=..\gfx\sprites2.png enemsfile=..\enems\enems2.ene scr_ini=24 ini_x=11 ini_y=5 max_objs=1 enems_life=3 > nul
    ..\..\..\src\utils\buildlevels_MK1.exe ..\bin\level3.bin mapsize=25 mapfile=..\map\mapa3.MAP map_w=5 map_h=3 fixmappy tilesfile=..\gfx\work3.png behsfile=..\gfx\behs3.txt defaultink=7 spritesfile=..\gfx\sprites3.png enemsfile=..\enems\enems3.ene scr_ini=10 ini_x=2 ini_y=5 max_objs=6 enems_life=3 > nul
    ..\..\..\src\utils\buildlevels_MK1.exe ..\bin\level4.bin mapsize=25 mapfile=..\map\mapa4.MAP map_w=1 map_h=25 fixmappy tilesfile=..\gfx\work4.png behsfile=..\gfx\behs4.txt defaultink=7 spritesfile=..\gfx\sprites4.png enemsfile=..\enems\enems4.ene scr_ini=0 ini_x=3 ini_y=3 max_objs=1 enems_life=4 > nul

    ..\..\..\src\utils\apultra ..\bin\level0.bin ..\bin\level0c.bin > nul
    ..\..\..\src\utils\apultra ..\bin\level1.bin ..\bin\level1c.bin > nul
    ..\..\..\src\utils\apultra ..\bin\level2.bin ..\bin\level2c.bin > nul
    ..\..\..\src\utils\apultra ..\bin\level3.bin ..\bin\level3c.bin > nul
    ..\..\..\src\utils\apultra ..\bin\level4.bin ..\bin\level4c.bin > nul

    del ..\bin\level?.bin  > nul
```

Ahora necesitamos una conversión más que usaremos luego en nuestras súper pantallas de nuevo nivel súper mega hiper chachis. Vamos a importar 192 caracteres que tenemos en `level_screen_ts.png` que descomprimiremos sobre el área del tileset para mostrar números gordunos. Para esa conversión tenemos `chr2bin`:

```
    C:\git\MK1\src\utils>chr2bin.exe
    chr2bin v0.4 20200119 ~ Usage:

    $ chr2bin charset.png charset.bin n [defaultink|noattrs]

    where:
       * charset.png is a 256x64 file with max. 256 chars.
       * charset.bin is the output, 2304/2048 bytes bin file.
       * n how many chars, 1-256
       * defaultink: a number 0-7. Use this colour as 2nd colour if there's only
         one colour in a 8x8 cell
       * noattrs: just outputs the bitmaps.
```

Para lo que vamos a usar estos gráficos no necesitamos los atributos así que los convertiremos así; luego los comprimimos y limpiamos:

```
    ..\..\..\src\utils\chr2bin ..\gfx\level_screen_ts.png ..\bin\level_screen_ts.bin 192 noattrs > nul
    ..\..\..\src\utils\apultra ..\bin\level_screen_ts.bin ..\bin\level_screen_tsc.bin > nul

    del ..\bin\level_screen_ts.bin > nul
```

### The Librarian

Aquí viene la parte guay. Hemos dicho que todos estos tiestos irán a nuestro almacenamiento en la RAM extra, que son los 64K que hay juntando las RAMs 3, 4, 6 y 7. Aparte de esto, en RAM 1 meteremos la música y el player, y las RAMs 5, 2 y 0 son las que (en ese orden) forman los 48K base que es donde se carga y opera el binario principal de nuestro juego.

Para meter todos estos tiestos en la RAM extra usaremos **The Librarian** en su versión 2, que leerá una lista de binarios y los irá metiendo en hasta cuatro archivos RAM?.bin de salida usando dos algoritmos diferentes:

1. Automático: **The Librarian** usa un algoritmo para encontrar una ordenación de los binarios que minimice el número de RAMs empleadas. Encontrar una ordenación *óptima* es un problema NP-Completo (de complejidad exponencial). **The Librarian** usa un algoritmo que encuentra una ordenación bastante buena, pero no es perfecto y a veces fallará. Por eso tenemos el modo:

2. Manual: **The Librarian** sigue el orden que aparece en el archivo de entrada con la lista.

Aunque no es necesario por ahora para este juego, **The Librarian** además acepta precargar binarios al principio de una o varias RAMs, y empezará a acomodar el resto de tus binarios detrás. Esto sirve por ejemplo para colocar el _script_ de tu juego en RAM extra, por ejemplo en RAM6. En un caso así, se renombraría `scripts.bin` como `preload6.bin` y **The Librarian** lo colocaría automáticamente al principio de RAM6 y acomodaría el resto de los binarios en las otras RAMs y tras los _scripts_ en RAM6. Así le podríamos decir al motor que los _scripts_ están al principio de RAM6 y todo funcionaría. Pero como **Goku Mal** no tiene _scripting_, pues no necesitaremos esta característica.

Finalmente, lo otro que hace **The Librarian** es generar una estructura con información sobre dónde encontrar cada binario y macros para identificarlos, que necesitaremos más adelante cuando estemos construyendo nuestro *levelset*.

Antes de que te abrumes demasiado vamos a verlo en acción. **The Librarian** usa unos cuantos parámetros que nos chivará, como es costumbre, si lo ejecutamos a pelo:

```
    C:\git\MK1\src\utils>librarian2.exe
    librarian v2.0 20200202 ~ **ERROR** list is Missing!

    usage:

    $ librarian2 list=list.txt index=output.h [bins_prefix=bins_prefix]
                 [rams_prefix=rams_prefix] [manual]

        * list.txt contains the list of binaries to store
        * output.h is the output file with the index
        * bins_prefix will be prepended to input preload?.bin & bin files
        * rams_prefix will be prepended to output RAMn.bin files
        * use manual for manual order.
```

Los parámetros hacen lo siguiente:

1. `list` (obligatorio) indica la ruta al archivo con la lista de binarios. A mí me gusta dejarla en `/bin` y llamarla `list.txt`.
2. `index` (obligatorio) indica la ruta al archivo de código que contendrá el índice de binarios (esto es: dónde encontrarlos). Para **MTE MK1** esta ruta debe ser `/dev/assets/librarian.h`.
3. `bins_prefix` (opcional) sirve para proporcionar una ruta para los archivos binarios que aparecen en la lista. Si ejecutamos **The Librarian** desde `dev/`, desde nuestro _script_, y los binarios en la lista aparecen simplemente nombrados pero estan en `bin/`, como será nuestro caso, tendremos que emplear este parámetro con el valor `../bìn/` para que **The Librarian** pueda encontrarlos.
4. `rams_prefix` (opcional) funciona parecido pero con los archivos `RAM?.bin` de salida. Si no ponemos nada los creará en `dev/`, pero queremos que estén en `bin/`, por lo que tendremos que especificar `../bin/` también como valor de este parámetro.
5. Por último, si añadimos `manual` a la línea de comando, se empleará el orden natural. Nosotros confiaremos en el algoritmo para este juego, que funcionará genialmente y ubicará los 35K de binarios comprimidos en tres páginas de RAM: RAM3, RAM4 y RAM6.

Por lo tanto, lo siguiente será añadir una nueva línea a nuestro `build_assets.bat`: la llamada a **The Librarian**, que será:

```
    echo Running The Librarian
    ..\..\..\src\utils\librarian2.exe list=..\bin\list.txt index=assets\librarian.h bins_prefix=..\bin\ rams_prefix=..\bin\ > nul
```

Y crear un archivo `list.txt` en `bin/` con la lista de todos los binarios, uno por línea, o sea:

```
    title.bin
    marco.bin
    ending.bin
    dedicado.bin
    controls.bin
    logo.bin
    zoneA.bin
    zoneB.bin
    intro1.bin
    intro2.bin
    intro3.bin
    intro4.bin
    intro5.bin
    intro6.bin
    intro7.bin
    level_screen_tsc.bin
    level0c.bin
    level1c.bin
    level2c.bin
    level3c.bin
    level4c.bin
```

### La OGT

Como hemos dicho, no nos detendremos en cómo montar una OGT aqui, sino que lo dejaremos [para otro capítulo](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap14.md). Aquí sólo veremos cómo generar RAM1 a partir de una OGT ya hecha.

Pondremos en `mus/` todo lo necesario, a saber:

1. `WYZproPlay47aZXc.ASM`, el código del _player_, ya modificado con la lista de canciones, e incluyendo nuestros instrumentos y efectos de sonido.
2. `instrumentos.asm`, con los instrumentos según exporta Wyz Tracker.
3. `efectos.asm`, con los efectos según los exporta Wyz Tracker.
4. `*.mus.bin`, todas las canciones exportadas desde Wyz Tracker y comprimidas con `apultra`.

Con todo en su sitio, sólo tendremos que llamar al ensamblador `Pasmo`, incluido en `/src/utils/`, para generar RAM1.bin y colocarla en `bin/`. Añadimos una última línea a nuestro `build_assets.bat`:

```
    echo Making music
    ..\..\..\src\utils\pasmo ..\mus\WYZproPlay47aZXc.ASM ..\bin\RAM1.bin
```

Finalmente me gusta chivar lo que ocupa cada archivo:

```
    echo DONE
    ..\..\..\src\utils\printsize ..\bin\RAM1.bin
    ..\..\..\src\utils\printsize ..\bin\RAM3.bin
    ..\..\..\src\utils\printsize ..\bin\RAM4.bin
    ..\..\..\src\utils\printsize ..\bin\RAM6.bin
```

¡Y ya lo tenemos todo! Es el momento de irse a `dev/` y ejecutar `build_assets.bat` y ver como se obtienen los diferentes `RAM?.bin` en `bin/`. El resultado de la ejecución debería ser algo parecido a esto:

```
    $ build_assets.bat
    Converting Fixed Screens
    Converting levels
    Converting more stuff
    Running The Librarian
    Making music
    DONE
    ..\bin\RAM1.bin: 14729 bytes
    ..\bin\RAM3.bin: 16136 bytes
    ..\bin\RAM4.bin: 16348 bytes
    ..\bin\RAM6.bin: 2640 bytes
```

## Modificando `compile.bat`

El siguiente paso es modificar `compile.bat` para quitar toda la importación de tiestos de un juego normal mononivel y posteriormente construir una cinta de 128K.

Nos fumaremos completamente las secciones donde se convierten mapas, enemigos, sprites y pantallas fijas (menos la pantalla de carga), pero tendremos que dejar la generación de los sprites extra y la importación de la fuente. La importación de tiestos en `compile.bat` se queda, pues, en la mínima expresión:

```
    echo Importando GFX
    ..\..\..\src\utils\ts2bin.exe ..\gfx\font.png notiles font.bin 7 >nul

    ..\..\..\src\utils\sprcnvbin.exe ..\gfx\sprites_extra.png sprites_extra.bin 1 > nul
    ..\..\..\src\utils\sprcnvbin8.exe ..\gfx\sprites_bullet.png sprites_bullet.bin 1 > nul

    if [%1]==[justassets] goto :end
```

### Generando la cinta de 128K

La carga de un juego de 128K, desde BASIC, se basa en ir cargando primero cada RAM en `$8000` y luego ejecutando una pequeña rutina en ASM que pagina la RAM correcta y posteriormente copia el bloque a `$C000`, para finalmente volver a poner la configuración de páginas como estaba para seguir cargando el siguiente bloque. Finalmente se carga el bloque principal y se ejecuta.

Así era y ha sido siempre hasta que haciendo **Ninjajar!** nos vimos en la tesitura de que estábamos llenando también RAM7 completamente y descubrimos de mala manera que el 128 BASIC corrompe RAM7. Por eso, haciendo uso de la infinita sabiduría de **Antonio Villena**, construimos un sencillo cargador en ensamble.

El cargador de marras es `dev/loader/loaderzx.asm-orig`. Este archivo tendrá que ser preprocesado para sustituir unas macros que tiene por la longitud real de los diferentes archivos que tiene que cargar y posteriormente compilado por Pasmo, pero lo primero que tendremos que hacer es adaptar el archivo a nuestro proyecto, ya que de fábrica viene preparado para cargar RAM1, RAM3, RAM4, RAM6 y RAM7.

En Goku Mal no tenemos RAM7, así que tendremos que editar el archivo y quitar el bloque que carga esta RAM, o sea, eliminar todo esto (línea 68 a la 79):

```asm
    ; RAM7
        ld  a, $17      ; ROM 1, RAM 7
        ld  bc, $7ffd
        out (C), a

        scf
        ld  a, $ff
        ld  ix, $C000
        ld  de, %%%ram7_length%%%
        call $0556
        di
```

Hecho esto nos tendremos que ir a `compile.bat` y sustituir toda la parte de generación de la cinta de 48K, o sea, esto:

```
    echo Construyendo cinta
    rem cambia LOADER por el nombre que quieres que salga en Program:
    ..\..\..\src\utils\bas2tap -a10 -sDOGMOLE loader\loader.bas loader.tap > nul
    ..\..\..\src\utils\bin2tap -o screen.tap -a 16384 loading.bin > nul
    ..\..\..\src\utils\bin2tap -o main.tap -a 24000 %game%.bin > nul
    copy /b loader.tap + screen.tap + main.tap %game%.tap > nul
```

Por esto otro:

```
    echo Construyendo cinta
    ..\..\..\src\utils\imanol.exe ^
        in=loader\loaderzx.asm-orig ^
        out=loader\loader.asm ^
        ram1_length=?..\bin\RAM1.bin ^
        ram3_length=?..\bin\RAM3.bin ^
        ram4_length=?..\bin\RAM4.bin ^
        ram6_length=?..\bin\RAM6.bin ^
        mb_length=?%game%.bin  > nul

    ..\..\..\src\utils\pasmo.exe loader\loader.asm ..\bin\loader.bin loader.txt

    ..\..\..\src\utils\GenTape.exe %game%.tap ^
        basic 'GOKU_MAL' 10 ..\bin\loader.bin ^
        data                loading.bin ^
        data                ..\bin\RAM1.bin ^
        data                ..\bin\RAM3.bin ^
        data                ..\bin\RAM4.bin ^
        data                ..\bin\RAM6.bin ^
        data                %game%.bin
```

Atención que aquí hay un poco de magias. Empezamos ejecutando `imanol.exe`, que es un programa sencillo para hacer sustituciones textuales por cosas calculadas, como la longitud de un archivo. Aquí simplemente estamos preprocesando `loaderzx.asm-orig` para generar un `loader.asm` con las longitudes correctas de cada bloque.

En la siguiente línea llamamos a Pasmo para que lo ensamble y genere un `../bin/loader.bin`.

Por último usamos GenTape del mismo **Antonio Villena** para construir la cinta con todos los bloques necesarios. Fíjate en cómo va primero la pantalla de carga seguida de los cuatro bloques para las RAMs extra que usamos (RAM1, RAM3, RAM4 y RAM6) y finalmente el binario principal. Si tu juego tiene un número de RAMs diferentes tendrás que ajustar esto también.

## Qué ha hecho The Librarian

The Librarian ha hecho algo genial: nos ha creado un archivo `assets/librarian.h` que contiene información sobre la ubicación de cada uno de nuestros tiestos, y además ha creado una macro para cada tiesto para que los podamos referenciar cómodamente en el *levelset* o donde necesitemos. Si abres el archivo verás primero la estructura `resources` con la página y el offset de cada uno de nuestros recursos:

```c
    RESOURCE resources [] = {
        { 3, 0xC000 },
        { 3, 0xC9D7 },
        { 3, 0xD357 },
        { 3, 0xDBE8 },
        { 3, 0xE470 },
        { 3, 0xECE9 },
        [...]
    };
```

Y luego una ristra de macros:

```c
    #define LEVEL0C_BIN                     0
    #define LEVEL4C_BIN                     1
    #define LEVEL2C_BIN                     2
    #define LEVEL1C_BIN                     3
    #define ZONEA_BIN                       4
    #define LEVEL3C_BIN                     5
    #define ZONEB_BIN                       6
    #define INTRO7_BIN                      7
    #define INTRO5_BIN                      8
    #define INTRO6_BIN                      9
    #define INTRO2_BIN                      10
    #define INTRO4_BIN                      11
    #define INTRO3_BIN                      12
    #define ENDING_BIN                      13
    #define INTRO1_BIN                      14
    #define DEDICADO_BIN                    15
    #define TITLE_BIN                       16
    #define LOGO_BIN                        17
    #define CONTROLS_BIN                    18
    #define LEVEL_SCREEN_TSC_BIN            19
    #define MARCO_BIN                       20
```

Cuando se activa el modo 128K (como veremos más adelante), está disponible la función `get_resource`, que sirve para descomprimir un recurso situado en RAM extra en la dirección de memoria `destination`. `n` es el número de recurso y, obviamente, podemos usar estas macros que crea **The Librarian**.

Si te fijas, las macros equivalen al nombre de archivo origen, en mayúsculas, y con `.` sustituido por `_`. Así nuestro `title.bin` puede referenciarse con la macro `TITLE_BIN`.

## El levelset

Es el momento de crear nuestro *levelset*. En modo 128K, como usamos *level bundles*, el *levelset* será mucho más sencillo. Al igual que en modo 48K, se configura en el archivo `my/levelset.h`. En modo 128K la estructura que describe un nivel es mucho más sencilla ya que la mayoría de los parámetros forman parte de la cabecera del *level bundle*:

```c
    // 128K format:
    typedef struct {
        unsigned char resource_id;
        unsigned char music_id;
        #ifdef ACTIVATE_SCRIPTING
            unsigned int script_offset;
        #endif
    } LEVEL;
```

Para cada nivel, por tanto, sólo tendremos que referenciar el recurso con el *level bundle* correspondiente al nivel, el número de la música de fondo en la OGT y, si tenemos activado el _scripting_, un offset al inicio del _script_ correspondiente al nivel, cosa que, como ya hemos mencionado varias veces en este capítulo, dejaremos para otra ocasión.

Como en modo 48K, el *levelset* se define en el array `levels`. Como no tenemos _scripting_ en **Goku Mal**, nuestro *levelset* es tal que así:

```c
    // Define your level sequence array here:
    // Resource_id, music_id, script_offset
    LEVEL levels [] = {
        { LEVEL0C_BIN, 3 },
        { LEVEL1C_BIN, 4 },
        { LEVEL2C_BIN, 5 },
        { LEVEL3C_BIN, 7 },
        { LEVEL4C_BIN, 3 },
    };
```

Los números 3, 4, 5, 7, 3 referencian músicas de la OGT que, como hemos dicho también, ya explicaremos cómo montar.

## La estructura level_data

Cuando se descomprime un *level bundle*, los primeros 16 bytes del binario corresponden con una cabecera que está accesible al motor mediante la estructura `level_data`, que vemos en el cuadro siguiente. La mayoría del espacio está desocupado, en provisión de ampliaciones futuras.

```c
    typedef struct {
        unsigned char map_w, map_h;
        unsigned char scr_ini, ini_x, ini_y;
        unsigned char max_objs;
        unsigned char enems_life;
        unsigned char d01;  // Reserved
        unsigned char d02;
        unsigned char d03;
        unsigned char d04;
        unsigned char d05;
        unsigned char d06;
        unsigned char d07;
        unsigned char d08;
        unsigned char d09;
    } LEVELHEADER;

    [...]

    extern LEVELHEADER level_data [0];
    #asm
        ._level_data defs 16
    #endasm
```

Accediendo a los datos en `level_data` podremos leer las dimensiones del nivel actual o donde vamos a empezar, el número máximo de objetos o la vida de los enemigos. Como `level_data` es un puntero a una estructura `extern`, tendremos que usar `->` para acceder a los valores de sus campos, por ejemplo:

```c
    rda = level_data->max_objs;
```

## Configurando el motor

Vamos a ver qué manejes tendríamos que hacer en `config.h` para activar el modo 128K multinivel y un par de engaños al chamán, además de dejar todo el motor listo para **Goku Mal** activando algunas cosas chulas que no hemos visto en el tutorial.

Primero vamos a montar el mínimo funcional: las fases se ejecutarán y se podrán terminar. Luego, con todo eso funcionando, veremos las personalizaciones: las *splash screens*, las *cutscenes* y los flujos de sinergia orientados a *startup* y *coaching*.

### Configuración del modo 128K multinivel

La primera es fácil. Tendremos que tocar tres directivas:

```c
    #define MODE_128K                           // Read the docs!
    [...]
    #define COMPRESSED_LEVELS                   // use levels.h instead of mapa.h and enems.h (!)
    #define MAX_LEVELS                  5       // # of compressed levels
```

Con esto tenemos el motor configurado en modo 128K y esperando un levelset en la memoria extra. Además estamos diciéndole al manejador principal que hay cinco niveles.

### La configuración de Goku Mal

Para no hacer este capítulo enorme, vamos a poner sólo lo que activamos y configuramos, entendiendo que todo lo demás va comentado y desactivado.

```c
    #define MAP_W                       5       //
    #define MAP_H                       5       // Map dimensions in screens
    #define SCR_INICIO                  99      // Initial screen
    #define PLAYER_INI_X                99      //
    #define PLAYER_INI_Y                99      // Initial tile coordinates
    //#define SCR_FIN                   99      // Last screen. 99 = deactivated.
    //#define PLAYER_FIN_X              99      //
    //#define PLAYER_FIN_Y              99      // Player tile coordinates to finish game
    #define PLAYER_NUM_OBJETOS          level_lata->max_objs    // Objects to get to finish game
    #define PLAYER_LIFE                 6       // Max and starting life gauge.
    #define PLAYER_REFILL               1       // Life recharge
    #define COMPRESSED_LEVELS                   // use levels.h instead of mapa.h and enems.h (!)
    #define MAX_LEVELS                  5       // # of compressed levels
    #define REFILL_ME                           // If defined, refill player on each level
```

En la configuración principal lo único reseñable es `PLAYER_NUM_OBJETOS`. En modo 128K, el array del *levelset* `levels` es la mínima expresión, como hemos visto, ya que la información de cada nivel va en la cabecera del *level bundle*. Por tanto, para hacer que el número de objetos que hay que conseguir en cada fase coincida con el que hemos configurado al crear los bundles, habrá que *apuntar* `PLAYER_NUM_OBJETOS` al campo `max_objs` de la estructura `level_data`.

```c
    #define BOUNDING_BOX_8_BOTTOM               // 8x8 aligned to bottom center in 16x16
    #define SMALL_COLLISION                     // 8x8 centered collision instead of 12x12
```

En el apartado de colisiones, usamos las *benévolas*, lo que hará que el _gameplay_ de este juego, que es un *shooter*, sea mucho más mejor y menos peor.

```c
    #define PLAYER_CHECK_MAP_BOUNDARIES         // If defined, you can't exit the map.
    #define DEACTIVATE_KEYS                     // If defined, keys are not present.
    #define FULL_BOUNCE                         // If defined, evil tile bounces equal MAX_VX, otherwise v/2
    #define PLAYER_FLICKERS                     // If defined, collisions make player flicker instead.
```

En el apartado de configuraciones generales configuramos para que se compruebe que no nos salimos del mapa (porque los niveles no tienen "paredes" externas para que haya más espacio para moverse), quitamos las llaves, ponemos rebote completo para con los pinchos y decimos que el jugador parpadee un rato cuando lo alcancen.

```c
    #define ENABLE_FANTIES                      // If defined, Fanties are enabled!
    #define FANTIES_BASE_CELL           2       // Base sprite cell (0, 1, 2 or 3)
    #define FANTIES_SIGHT_DISTANCE      104     // Used in our type 6 enemies.
    #define FANTIES_MAX_V               256     // Flying enemies max speed (also for custom type 6 if you want)
    #define FANTIES_A                   16      // Flying enemies acceleration.
    #define FANTIES_LIFE_GAUGE          5       // Amount of shots needed to kill flying enemies.
    #define FANTIES_TYPE_HOMING                 // Unset for simple fanties.
```

En este juego necesitamos *fanties* de tipo *homing*. De hecho, fueron introducidos en el motor justo en este juego. Los configuramos para que usen siempre el gráfico 2 y les ponemos los valores que se ven. Habrá que soltarles 5 hostias para matarlos.

```c
    #define PLAYER_CAN_FIRE                     // If defined, shooting engine is enabled.
    #define PLAYER_BULLET_SPEED         8       // Pixels/frame.
    #define MAX_BULLETS                 4       // Max number of bullets on screen. Be careful!.
    #define PLAYER_BULLET_Y_OFFSET      6       // vertical offset from the player's top.
    #define PLAYER_BULLET_X_OFFSET      0       // vertical offset from the player's left/right.
    #define ENEMIES_LIFE_GAUGE          leveldata->enems_life   // Amount of shots needed to kill enemies.
    #define RESPAWN_ON_ENTER                    // Enemies respawn when entering screen
    #define CAN_FIRE_UP                         // If defined, player can fire upwards and diagonal.
```

Aquí vemos otra fullería para adaptar un valor aparentemente fijo a algo variable usando el podewr de las macros en C: Si configuramos `ENEMIES_LIFE_GAUGE` como se ve, lograremos que el valor de vida con el que se reactiva a los enemigos a entrar en una pantalla (hemos activado `RESPAWN_ON_ENTER`) coincida con el que se define en la cabecera de cada nivel.

Ojal también al `CAN_FIRE_UP`, que permitirá que disparemos en diagonal.

```c
    #define TIMER_ENABLE                        // Enable timer
    #define TIMER_INITIAL               99      // For unscripted games, initial value.
    #define TIMER_REFILL                50      // Timer refill, using tile 21 (hotspot #5)
    #define TIMER_LAPSE                 40      // # of frames between decrements
    #define TIMER_START                         // If defined, start timer from the beginning
    #define TIMER_GAMEOVER_0                    // If defined, timer = 0 causes "game over"
    #define SHOW_TIMER_OVER                     // If defined, "TIME OVER" shows when time is up.
```

En esta sección configuramos el *timer*. Tendrá un valor inicial de 99, empezará con el nivel, se recargará con 50 unidades y cuando se acabe se mostrará "TIME'S UP!" y se acabará el juego.

```c
    #define PLAYER_HAS_JUMP                     // If defined, player is able to jump.
```

Obviamente.

```c
    #define USE_TWO_BUTTONS                 // Alternate keyboard scheme for two-buttons games
```

Este juego usa dos botones de acción: uno para saltar y otro para disparar. Como ya he comentado, por eso nos pusieron a parir los unsolobotoners, los OPQArs y los QAOPers. Unos porque no querían cambiar las teclas que usaban siempre y otros, con más razón, porque jugar con joystick era muy raro.

No hay solución buena a jugar con joystick, pero al menos la que implementa **MTE MK1** v5 es mejor que nada: cuando seleccionas joystick en un juego con `USE_TWO_BUTTONS` se remapean los controles y *arriba* significa a la vez *arriba* y *botón de salto*. No será tan controlable como teniendo dos botones, pero al menos se podrá jugar.

```c
    #define VIEWPORT_X                  1       //
    #define VIEWPORT_Y                  2       // Viewport character coordinates
    #define LIFE_X                      3       //
    #define LIFE_Y                      0       // Life gauge counter character coordinates
    #define OBJECTS_X                   99      //
    #define OBJECTS_Y                   99      // Objects counter character coordinates
    #define OBJECTS_ICON_X              99      //
    #define OBJECTS_ICON_Y              99      // Objects icon character coordinates (use with ONLY_ONE_OBJECT)
    #define KEYS_X                      99      //
    #define KEYS_Y                      99      // Keys counter character coordinates
    #define KILLED_X                    99      //
    #define KILLED_Y                    99      // Kills counter character coordinates
    #define AMMO_X                      99      //
    #define AMMO_Y                      99      // Ammo counter character coordinates
    #define TIMER_X                     29      //
    #define TIMER_Y                     0       // Timer counter coordinates
```

Sobre la colocación de los elementos no diremos nada, que la tenemos muy vista.

```c
    #define USE_AUTO_TILE_SHADOWS               // Automatic shadows using specially defined tiles 32-47.
    #define MASKED_BULLETS                      // If needed
    #define PAUSE_ABORT                         // Add h=PAUSE, y=ABORT
    #define GET_X_MORE                          // Shows "get X more" when getting an object
    #define HUD_INK                     7       // Use this attribute for digits in the hud
```

Este juego usa sombreado por tiles extra, como habrás podido descubrir si has mirado los tilesets. Queremos máscaras para que las balas se vean bien, necesitamos una pantalla de pausa, y que se muestre `GET x MORE` cuando cojamos objetos.

```c
    #define PLAYER_MAX_VY_CAYENDO       512     // Max falling speed
    #define PLAYER_G                    48      // Gravity acceleration

    #define PLAYER_VY_INICIAL_SALTO     96      // Initial junp velocity
    #define PLAYER_MAX_VY_SALTANDO      360     // Max jump velocity
    #define PLAYER_INCR_SALTO           64      // acceleration while JUMP is pressed

    #define PLAYER_INCR_JETPAC          32      // Vertical jetpac gauge
    #define PLAYER_MAX_VY_JETPAC        256     // Max vertical jetpac speed

    // IV.2. Horizontal (side view) or general (top view) movement.

    #define PLAYER_MAX_VX               192     // Max velocity
    #define PLAYER_AX                   48      // Acceleration
    #define PLAYER_RX                   32      // Friction
```

Las constantes que definen el movimiento permiten saltos muy altos, resbalones, y no demasiada velocidad horizontal.

¡Y configuración lista!

## Valores importantes diferentes en cada nivel

Antes hemos visto la fullería que hemos hecho con `PLAYER_NUM_OBJETOS` para poder controlar el final de cada fase con un número diferente de objetos, que era parecida a la que describimos para el modo 48K en el capítulo anterior, pero levemente diferente. Aprovechamos para resumir aquí cómo se implementarían otros casos en los que queramos tener valores diferentes para cosas importantes en cada nivel.

### Número de objetos

Como ya hemos visto, se trata de configurar `PLAYER_NUM_OBJETOS` al valor de la cabecera `level_data->max_objs`:

```c
    #define PLAYER_NUM_OBJETOS          (level_lata->max_objs)
```

### Llegar a un sitio concreto

Se hace exactamente igual que en modo 48K: creando arrays en `my/ci/extra_vars.h` y configurando `SCR_FIN` y opcionalmente también `PLAYER_FIN_X` y `PLAYER_FIN_Y` para que apunten a esos arrays usando la variable `level`.

### Vida de los malos

Para que el número de disparos que haya que meterles a los enemigos normales sea diferente para cada fase habrá que hacer que la macro `ENEMIES_LIFE_GAUGE` resuelva al valor correcto de la cabecera:

```c
    #define ENEMIES_LIFE_GAUGE          (leveldata->enems_life)
```

## Primera compilación

Llegados a este punto nos gusta generar y compilar todo por primera vez para ver que todo está en su sitio. Con el juego en este estado podrás jugar a todas las fases en orden:

```
    na_th_an@MOJONIA Z:\MK1\examples\goku_mal\dev
    $ build_assets.bat
    Converting Fixed Screens
    Converting levels
    Converting more stuff
    Running The Librarian
    Making music
    DONE
    ..\bin\RAM1.bin: 14729 bytes
    ..\bin\RAM3.bin: 16136 bytes
    ..\bin\RAM4.bin: 16348 bytes
    ..\bin\RAM6.bin: 2640 bytes

    na_th_an@MOJONIA Z:\MK1\examples\goku_mal\dev
    $ compile.bat
    Compilando script
    Importando GFX
    Compilando guego
    goku_mal.bin: 26873 bytes
    scripts.bin: 0 bytes
    Construyendo cinta

    File goku_mal.tap generated successfully
    Limpiando
    Hecho!
```

## Añadidos

Ahora vamos a poner las cosas especiales que hacen tu juego más pulido y molón. Usaremos inyección de código para todo.

### *Splash screens*

Las _splash screens_ son una serie de pantallas que se muestran nada más cargar el juego. Como todo el resto de los tiestos se sacan con `get_resource`. Llamaremos también a `espera_activa` para esperar unos 10 segundos entre cada pantalla (interrumpibles pulsando una tecla).

Si abrimos `assets/librarian.h` veremos que las macros que representan los recursos que necesitamos para `get_resource` son estos, que habrá que descomprimir directamente sobre la pantalla (dirección 16384):

```c
    #define LOGO_BIN                        17
    #define CONTROLS_BIN                    18
    #define DEDICADO_BIN                    15
```

El punto de inyección de código que necesitamos tocar es `my/ci/after_load.h`. Para ahorrar cortapegas vamos a crear un array en `my/ci/extra_vars.h` con la secuencia de recursos:

```c
    // extra_vars.h
    const unsigned char splash_screens [] = { LOGO_BIN, CONTROLS_BIN, DEDICADO_BIN };
```


```c
    // after_load.h

    sp_UpdateNow ();    // Clear buffer

    for (gpit = 0; gpit < 3; ++ gpit) {
        get_resource (splash_screens [gpit], 16384);
        espera_activa (500);
        wyz_play_sound (SFX_START);
        cortina ();
        blackout ();
    }
```

### Selección de idioma

La selección de idioma sirve para mostrar el texto de las cutscenes en español o inglés. Lo primero que necesitamos es, por tanto, un sitio donde almacenar la selección. Crearemos una variable `lang` en `my/ci/extra_vars.h`:

```c
    // extra_vars.h
    unsigned char lang = 99;
```

El código para seleccionar el idioma lo colocaremos también en `my/ci/after_load.h` justo detrás de las *splash screens*:

```c
    // after_load.h

    _x = 11; _y = 11; _t = 71; _gp_gen = "1. ENGLISH"; print_str ();
    _x = 11; _y = 12; _t = 71; _gp_gen = "2. SPANISH"; print_str ();
    sp_UpdateNow ();

    while (lang == 99) {
        gpjt = sp_GetKey ();
        if (gpjt == '1' || gpjt == '2') lang = gpjt - '1';
    }
    cortina ();
```

Este código hará que lang valga 0 para inglés ó 1 para español.

### El menú y los passwords

El juego es capaz de saltar a la fase que sea usando una serie de passwords textuales que no almacenan nada (el caso más sencillo). Vamos a modificar la pantalla de título por defecto para mostrar la opción de jugar o meter un password tras elegir el control. La pantalla de título se puede modificar fácilmente porque está en `my/title_screen.h`. Añadiremos nuestro código tras el que ya existe, que nos vale. Queda así:

```c
    {
        #ifdef MODE_128K
            get_resource (TITLE_BIN, 16384);
        #else
            #asm
                ld hl, _s_title
                ld de, 16384
                call depack
            #endasm
        #endif

        wyz_play_music (0);

        select_joyfunc ();

        _x = 11; _y = 16; _t = 7; _gp_gen = lang ? "-= MENU =-" : "-=SELECT=-";
        print_str ();

        _x = 11; _y = 17;         _gp_gen = lang ? "1 JUGAR   " : "1 PLAY    ";
        print_str ();

        _x = 11; _y = 18;         _gp_gen =        "2 PASSWORD";
        print_str ();

        sp_UpdateNow ();
        level = 99; while (level == 99) {
            gpjt = sp_GetKey ();
            switch (gpjt) {
                case '1': level = 0; break;
                case '2': level = check_password ();
            }
        }

        wyz_stop_sound ();
        wyz_play_sound (SFX_START);
    }
```

Imprimimos unas cosas y luego esperamos que el usuario pulse 1 ó 2. En el caso que pulse 1, se pone `level` a 0 y empezamos. Si pulsa 2, `level` valdrá el resultado de `check_password`, que es una función que tendremos que implementar. ¿Dónde? Pues en el sitio de implementar funciones, que es `my/ci/extra_functions.h`.

La función es muy tonta pero la puedes aprovechar para tus propios passwords con alguna que otra modificación:

```c
    // extra_vars.h

    #define PASSWORD_LENGTH 6
    #define MENU_Y          16
    #define MENU_X          11
    extern unsigned char passwords [0];
    #asm
        ._passwords
            defm "TETICA"
            defm "PICHON"
            defm "CULETE"
            defm "BUTACA"
    #endasm

    unsigned char *password = "****** ";
```

```c
    // extra_functions.h

    unsigned char check_password (void) {
        wyz_play_sound (SFX_START);

        _x = MENU_X; _y = MENU_Y    ; _t = 7; _gp_gen = " PASSWORD "; print_str ();
        _x = MENU_X; _y = MENU_Y + 1;       ; _gp_gen = "          "; print_str ();
        _x = MENU_X; _y = MENU_Y + 2;       ;                     print_str ();

        for (gpit = 0; gpit < PASSWORD_LENGTH; ++ gpit) password [gpit] = '.';
        password [PASSWORD_LENGTH] = ' ';

        gpit = 0;
        sp_WaitForNoKey ();
        _y = MENU_Y + 2; _t = 71; _gp_gen = password;
        while (1) {
            password [gpit] = '*';
            _x = 16 - PASSWORD_LENGTH / 2; print_str ();
            sp_UpdateNow ();

            do {
                gpjt = sp_GetKey ();
            } while (gpjt == 0);

            if (gpjt == 12 && gpit > 0) {
                password [gpit] = gpit == PASSWORD_LENGTH ? ' ' : '.';
                -- gpit;
            } else if (gpjt == 13) break;
            else if (gpjt > 'Z') gpjt -=32;

            if (gpjt >= 'A' && gpjt <= 'Z' && gpit < PASSWORD_LENGTH) {
                password [gpit] = gpjt; ++gpit;
            }

            wyz_play_sound (1);
            sp_WaitForNoKey ();
        }

        sp_WaitForNoKey ();

        // Check password
        _gp_gen = passwords;

        for (gpit = 0; gpit < MAX_LEVELS - 1; ++ gpit) {
            rda = 1; for (gpjt = 0; gpjt < PASSWORD_LENGTH; ++ gpjt) {
                if (password [gpjt] != *_gp_gen ++) rda = 0;
            }

            if (rda) return (1 + gpit);
        }

        return 0;
    }
```

Con esto y tal y como llevamos la cosa, si compilas tendrás el sistema de passwords totalmente funcional y podrás jugar a la fase que quieras poniendo el password correspondiente. Pero aún quedan más cosas que añadir.

### Las cutscenes

El sistema de cutscenes que implementaremos en una función `do_cutscene` es muy sencillo. Para cada idioma tendremos 7 cadenas de texto, una por cada imagen.  La función recibirá dos números del 1 al 7, y mostrará las imágenes y cadenas de texto entre ambos números, ambos inclusive. También recibirá un tercer parámetro con la música que debe tocar.

Hay tres puntos en los que hay que montar cutscenes: el primero es al empezar un juego nuevo; se mostrarán las cadenas 0 a 3. El segundo es antes de empezar la cuarta fase (`level == 3`); mostraremos la cadena 4. Y el tercero será al terminar la quinta fase; mostraremos las cadenas 5 y 6.

Montados todo este sistema en `my/ci/extra_routines.h` igualmente, a continuación del código que ya habíamos introducido. Puedes verlo en la carpeta del juego.

Lo que sí vamos a ver aquí son los *enganches*, o sea, las llamadas a `do_cutscene`, que habrá que pincharlas en dos puntos diferentes: Si te das cuenta, las dos primeras secuencias se muestran antes de mostrar la pantalla de "NIVEL XX", y la tercera antes de mostrar el final del juego. Por tanto, meteremos las llamadas a `do_cutscene` al principio de `my/level_screen.h` y al principio de la función `game_ending` en `my/fixed_screens.h`.

```c
    // level_screen.h
    {
        // Show cutscenes at the beginning of levels 0 and 3

        if (level == 0) do_cutscene (0, 3, 1);
        else if (level == 3) do_cutscene (4, 4, 1);

        // Show new level screen (customized)
        [...]
    }
```

```c
    // fixed_screens.h
    [...]

    void game_ending (void) {
        // Show final cutscene
        do_cutscene (5, 6, 9);

        // On to the normal ending
        [...]
    }

    [...]
```

### Las pantallas de "nuevo nivel"

Las pantallas de "nuevo nivel" de Goku Mal muestran una imagen de fondo: `zoneA.png` en la primera fase y `zoneB.png` en las siguientes. A partir de la segunda fase se muestra el password correspondiente. Además, se pinta un número bien gordo usando caracteres de un set gráfico especial que tendremos que descomprimir sobre la zona de tiles. Los números gordos se pintan atendiendo a un array lleno de números que tuve a bien de teclear en tiempos, algo que ni se me ocurriría hacer en los tiempos que corren, porque en el rato que tardo en picar números me hago un conversor automático, que es más divertido. Pero bueno, el mal ya está hecho.

Ponemos nuestras ristras en `my/ci/extra_vars.h` a continuación de todo lo que ya tenemos.

```c
    // extra_vars.h

    unsigned char levelnumbers [] = {
         64, 65, 66, 66, 66, 66, 66,  0,  0,
         67, 68, 66, 66, 66, 66, 66,  0,  0,
          0,  0, 66, 66, 66, 66, 66,  0,  0,
          0,  0, 66, 66, 66, 66, 66,  0,  0,
          0,  0, 66, 66, 66, 66, 66,  0,  0,
         69, 66, 66, 66, 66, 66, 66, 66, 70,

         71, 66, 66, 66, 66, 66, 66, 66, 72,
         66, 66, 73, 74, 74, 74, 75, 66, 66,
          0,  0, 76, 77, 78, 79, 66, 66, 80,
         81, 79, 66, 66, 82, 83, 84, 85,  0,
         66, 66, 86, 85,  0,  0,  0, 66, 66,
         66, 66, 66, 66, 66, 66, 66, 66, 66,

         66, 66, 66, 66, 66, 66, 66, 66, 66,
         66, 66, 87, 88, 89, 90, 66, 91, 92,
          0, 93, 94, 95, 66, 66, 66, 96, 97,
         98, 68, 68, 68, 68, 68, 99, 66, 66,
         66, 66,114,  0,  0,  0,115, 66, 66,
        100, 66, 66, 66, 66, 66, 66, 66,101,

          0,  0,102,103, 66,104,105,  0,  0,
        102,103, 66,104,105,  0,  0,  0,  0,
         66,104,105,  0,106,106,  0,  0,  0,
         66, 66, 66, 66, 66, 66, 66, 66, 66,
         66, 66, 66, 66, 66, 66, 66, 66, 66,
          0,  0,  0,  0, 66, 66,  0,  0,  0,

         66, 66, 66, 66, 66, 66, 66, 66, 66,
         66, 66,  0,  0,  0,  0,  0,  0,  0,
         66, 66,107,108, 66, 66, 66,109,110,
         68, 68,111,112,112,112,113, 66, 66,
         66, 66,114,  0,  0,  0,115, 66, 66,
        100, 66, 66, 66, 66, 66, 66, 66,101
    };
```

El código que saca la pantalla, toca la música de nuevo nivel y saca el numerón lo meteremos sustituyendo el que hay por defecto en `my/level_screen.h`, detrás de las llamadas a `do_cutscene` que pusimos antes. Tiene este aspecto:

```c
    // Show new level screen (customized)

    // Unpack tileset
    get_resource (LEVEL_SCREEN_TSC_BIN, (unsigned int) (tileset));

    // Show zone screen
    sp_UpdateNow ();
    blackout ();
    get_resource (level ? ZONEB_BIN : ZONEA_BIN, 16384);

    // Show password
    if (level) {
        _x = 7; _y = 18; _t = 70; _gp_gen = " PASSWORD "; print_str ();
        _gp_gen = passwords + ((level - 1) * PASSWORD_LENGTH);
        gpx = 9; for (gpit = 0; gpit < PASSWORD_LENGTH; ++ gpit) {
            #asm
                    ld  hl, (__gp_gen)
                    ld  a, (hl)
                    inc hl
                    ld  (__gp_gen), hl
                    ld  e, a

                    ld  d, 70

                    ld  a, (_gpx)
                    ld  c, a
                    inc a
                    ld  (_gpx), a

                    ld  a, 19

                    call SPPrintAtInv
            #endasm
        }
    }

    // Show big number
    map_pointer = level * 54 + levelnumbers;
    for (gpy = 16; gpy < 22; ++ gpy) {
        for (gpx = 22; gpx < 31; ++ gpx) {
            #asm
                    ld  hl, (_map_pointer)
                    ld  a, (hl)
                    inc hl
                    ld  (_map_pointer), hl
                    ld  e, a

                    ld  d, 71

                    ld  a, (_gpx)
                    ld  c, a

                    ld  a, (_gpy)

                    call SPPrintAtInv
            #endasm
        }
    }

    sp_UpdateNow ();
    wyz_play_music (2);
    espera_activa (250);
    wyz_stop_sound ();
```

### Boost al subir de pantalla

Una cosa que suele ayudar mucho al _gameplay_, sobre todo cuando el juego es más de avanzar que de explorar, es dar un pequeño boost al jugador al subir a la pantalla de arriba. Vamos a detectar que estemos cambiando de pantalla hacia arriba para dar a la VY el máximo valor negativo, lo que hará más fácil dirigir a Goku Mal a una plataforma en lugar de fallar y volver a la pantalla de abajo.

Si recordamos, `my/ci/before_entering_screen.h` se inyecta justo al ir a cambiar pantalla, cuando `n_pant` y `o_pant` son distintas. Justo ahí podremos detectar que `n_pant == (o_pant - level_data->map_w)` y en ese caso aplicar el boost:

```c
    // before_entering_screen.h

    if (n_pant == (o_pant - level_data->map_w)) p_vy = -PLAYER_MAX_VY_SALTANDO;
```

## Fin!

Otro capítulo súper denso, pero que creo que cubre todo lo que necesitabas saber pero nunca te atreviste a preguntar sobre juegos de 128K multinivel.
