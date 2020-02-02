# Capítulo 13: Un juego de 128K

¡Vaya! Si has conseguido llegar hasta aquí sin mandarme a freir castañas es que debes ser todo un experto en **MTE MK1**, o quizá viste el título del capítulo por separado y has venido directamente aquí porque a lo que tú aspiras es a hacer un juego de verdaz, nada de mierdecillas. 

Sea como sea, voy a suponer que has entendido muy bien cómo funciona el multinivel en **MTE MK1** y no me entretendré en explicaciones sobre el tema. También vamos a ver alguna que otra inyección de código, que voy a suponer que sabes como va.

Vamos a construir un juego multinivel de 128K, con cutscenes, casinos y furcias. Vamos a construir

## Goku Mal

**Goku Mal** fue el primer juego para 128K de escrito con **MTE MK1** (que, con él, evolucionó a la versión 3.99.3, si mal no recuerdo). También fue nuestro último juego con el motor, ya que para el siguiente ya nos inventamos MK2.

Se trata de un juego muy sencillo que tiene cinco fases en las que básicamente avanzamos y disparamos, salvo en la cuarta, en la que dejamos un momento aparte el desarrollo puramente lineal y nos entretendremos recogiendo rosas antes de volver a la acción.

La configuración del motor será de vista lateral, con saltos y disparos en 8 direcciones. Este juego levantó una gran polémica entre los super tacañones, ya que estaba pensado para jugarse con dos botones de acción y no incluimos una opción para los que están acostumbrado a agarrarse de un joystick de un solo botón (esto no es una referencia fálica). En esta revisión corregiremos eso.

Tienes el juego completo en el directorio `/examples`. En este tutorial, además de muchas explicaciones, seguiremos paso por paso el mismo proceso que he seguido yo para montarlo en **MTE MK1** v5.

## Los juegos multinivel de 128K

Si recordaréis, un juego multinivel de 48K de **MTE MK1** se parece mucho a un juego normal, solo que antes de empezar a jugar descomprimimos nuevos datos sobre el espacio donde el motor espera encontrarlos. 

En 128K es básicamente lo mismo, pero con la diferencia de que tendremos casi toda la RAM extra como almacén de datos contenidos. En concreto, de las cinco páginas que no forman los 48K base del Spectrum de 128K, usaremos una para la música y tendremos cuatro más para datos comprimidos. ¡Y en 64K cabe mogollón de cosas!

Para que te hagas una idea, las tres fases de Helmet ocupaban menos de 7Kb.

Aunque al principio el tema acojone un poco, lo cierto es que hacer un juego de 128K es más sencillo que un multinivel de 48K, porque aunque tenga más trabajo (normalmente meteremos más contenido y además tendremos que diseñar una banda sonora), los procesos son mucho más sencillos, como veremos muy pronto. 

## Empezamos

Lo primero que haremos será reunir todos los recursos. Posteriormente veremos cómo importarlos, qué es un *level bundle* y cómo funciona **librarian**.

### Todos los tiestos.

He puesto *recursos* o *assets* porque sonaba más profesional y tal, pero la verdad es que en mojonia siempre llamamos a estas cosas *tiestos*. Vamos a ver qué tiestos lleva **Goku Mal**.

Todos los tiestos irán en la RAM extra. Generaremos un script `build_assets.bat` para construir los binarios que se cargarán en la RAM extra, incluyendo la banda sonora.

En primer lugar tendremos un buen porrón de pantallas comprimidas. Además de las tres estándar de **MTE MK1** (título, marco y final) tendremos tres splash screens que se muestran tras cargar el juego y varias con imagenes para las *cutscenes*. Esta es una lista completa:

1. `title.png`, `marco.png` y `ending.png` ya sabes para qué son. Este juego, como ves, tiene marco separado de la pantalla de título.
2. `logo.png` tiene un logo de los Mojon Twins y el título del juego y se muestra nada más finalizar la carga.
3. `dedicado.png` es una dedicatoria, y se muestra también una única vez, al terminar la carga.
4. `controls.png` la hicimos para que los super tacañones no se quejaran mucho por no usar OPQA (¡ni QAOP!), pero no funcionó para nada porque igualmente nos pusieron a parir.
5. `intro1.png`, `intro2.png`, `intro3.png` e `intro4.png` se muestran al iniciar una nueva partida y contienen la introducción del juego.
6. `intro5.png` se muestra antes de la fase 4 y sirve para ilustrar una escena del argumento del juego.
7. `intro6.png` e `intro7.png` forman parte de la secuencia final.
8. `zoneA.png` y `zoneB.png` se muestran antes de empezar cada nivel y muestran la cara de mala hostia de Goku Mal y el número de la fase que toca.
9. Finalmente tendremos nuestra pantalla de carga, `loading.png`, que tendremos que convertir pero no comprimir. Dejaremos esta tarea para `compile.bat` más adelante.

Sin salirnos de `gfx/`, tendremos además los gráficos para construir los niveles:

1. `work0.png`, `work1.png`, `work2.png`, `work3.png` y `work4.png` contienen los tilesets de las cinco fases. Es importante notar que todos estos tilesets tienen un tile 0 que no es del todo negro, por lo que habrá que tener en cuenta esto más adelante (ya que los .MAP tendrán los valores desplazados debido al glitch de mappy que ya conocemos bien). Tenemos aquí sus archivos de comportamientos asociados, `behs0.txt` a `behs4.txt`.
2. `sprites0.png`, `sprites1.png`, `sprites2.png`, `sprites3.png` y `sprites4.png` contienen los cinco spritesets correspondientes a cada una de las cinco fases.
3. `font.png` contiene la fuente base que se usará durante el juego.
4. `level_screen_ts.png` es un charset completo que se empleará para las pantallas de nuevo nivel especiales que tiene este juego.

En `map/` tenemos los mapas de los cinco niveles, `mapa0.fmp` a `mapa4.fmp` y sus exports en formato `MAP`: `mapa0.MAP` a `mapa5.MAP`.

En `enems/` tenemos los archivos de colocación de cosas para Ponedor, `enems0.ene` a `enems4.ene`. También hemos copiado aquí los `work?.png` con los tilesets y los `mapa?.MAP` con los mapas para que Ponedor los tenga bien a mano.

Este juego no tiene scripting, así que por último tenemos la banda sonora y OGT en el directorio `mus/`. Esta OGT fue creada con **Davidian** y tiene un montón de canciones. Ahora nos vamos a centrar más en la importación y construcción del juego pero dedicaré un capítulo para hablaros de cómo montar las OGT con Wyz Player.

### Importación: pantallas fijas

Empezaremos a construir nuestro script encargado de crear los binarios con las pantallas fijas:

```bat
    @echo off

    if [%1]==[skipscr] goto skipscr

    echo Converting Fixed Screens
    ..\..\..\src\utils\png2scr ..\gfx\title.png ..\bin\title.bin > nul
    ..\..\..\src\utils\png2scr ..\gfx\marco.png ..\bin\marco.bin > nul
    ..\..\..\src\utils\png2scr ..\gfx\ending.png ..\bin\ending.bin > nul
    ..\..\..\src\utils\png2scr ..\gfx\logo.png ..\bin\logo.bin > nul
    ..\..\..\src\utils\png2scr ..\gfx\dedicado.png ..\bin\dedicado.bin > nul
    ..\..\..\src\utils\png2scr ..\gfx\controls.png ..\bin\controls.bin > nul
    ..\..\..\src\utils\png2scr ..\gfx\intro1.png ..\bin\intro1.bin > nul
    ..\..\..\src\utils\png2scr ..\gfx\intro2.png ..\bin\intro2.bin > nul
    ..\..\..\src\utils\png2scr ..\gfx\intro3.png ..\bin\intro3.bin > nul
    ..\..\..\src\utils\png2scr ..\gfx\intro4.png ..\bin\intro4.bin > nul
    ..\..\..\src\utils\png2scr ..\gfx\intro5.png ..\bin\intro5.bin > nul
    ..\..\..\src\utils\png2scr ..\gfx\intro6.png ..\bin\intro6.bin > nul
    ..\..\..\src\utils\png2scr ..\gfx\intro7.png ..\bin\intro7.bin > nul
    ..\..\..\src\utils\png2scr ..\gfx\zoneA.png ..\bin\zoneA.bin > nul
    ..\..\..\src\utils\png2scr ..\gfx\zoneB.png ..\bin\zoneB.bin > nul

    ..\..\..\src\utils\apultra ..\bin\title.bin ..\bin\titlec.bin > nul
    ..\..\..\src\utils\apultra ..\bin\marco.bin ..\bin\marcoc.bin > nul
    ..\..\..\src\utils\apultra ..\bin\ending.bin ..\bin\endingc.bin > nul
    ..\..\..\src\utils\apultra ..\bin\logo.bin ..\bin\logoc.bin > nul
    ..\..\..\src\utils\apultra ..\bin\dedicado.bin ..\bin\dedicadoc.bin > nul
    ..\..\..\src\utils\apultra ..\bin\controls.bin ..\bin\controlsc.bin > nul
    ..\..\..\src\utils\apultra ..\bin\intro1.bin ..\bin\intro1c.bin > nul
    ..\..\..\src\utils\apultra ..\bin\intro2.bin ..\bin\intro2c.bin > nul
    ..\..\..\src\utils\apultra ..\bin\intro3.bin ..\bin\intro3c.bin > nul
    ..\..\..\src\utils\apultra ..\bin\intro4.bin ..\bin\intro4c.bin > nul
    ..\..\..\src\utils\apultra ..\bin\intro5.bin ..\bin\intro5c.bin > nul
    ..\..\..\src\utils\apultra ..\bin\intro6.bin ..\bin\intro6c.bin > nul
    ..\..\..\src\utils\apultra ..\bin\intro7.bin ..\bin\intro7c.bin > nul
    ..\..\..\src\utils\apultra ..\bin\zoneA.bin ..\bin\zoneAc.bin > nul
    ..\..\..\src\utils\apultra ..\bin\zoneB.bin ..\bin\zoneBc.bin > nul

    del ..\bin\title.bin > nul
    del ..\bin\marco.bin > nul
    del ..\bin\ending.bin > nul
    del ..\bin\logo.bin > nul
    del ..\bin\dedicado.bin > nul
    del ..\bin\controls.bin > nul
    del ..\bin\intro1.bin > nul
    del ..\bin\intro2.bin > nul
    del ..\bin\intro3.bin > nul
    del ..\bin\intro4.bin > nul
    del ..\bin\intro5.bin > nul
    del ..\bin\intro6.bin > nul
    del ..\bin\intro7.bin > nul
    del ..\bin\zoneA.bin > nul
    del ..\bin\zoneB.bin > nul

    :skipscr
```

Como normalmente en un desarrollo de este tipo las pantallas fijas son lo que menos va a evolucionar y además tardan un ratillo en comprimirse, añadimos un poco de magia batch. Cuando ejecutemos `build_assets.bat` con el parámetro `skipscr` la ejecución se saltará la conversión de las imagenes, lo que vendrá bien cuando tengamos que regenerar una y otra vez los mapas o la colocación de enemigos (repito, en un desarrollo normal en el que vas construyendo y depurando el juego poco a poco. Aquí ya lo tengo todo hecho).

### Importación: Level bundles

En modo 128K quisimos simplificar la importación de niveles creando los **level bundles**, que no son más que gruesos binarios que contienen todos los tiestos que definen un nivel: mapa, cerrojos, tileset, enemigos, hotspots, comportamientos y spriteset. Estos binarios se descomprimen de un plumazo sobre la zone de datos de **MTE MK1** ya que están organizados de la misma forma que ésta.

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

3. `map_w` y `map_h` (obligatorios): especifican el ancho y alto en pantallas del nivel. Recuerda que `map_w * map_h` debe ser menor que el resultado de `MAP_W * MAP_H` (las constantes de `my/config.h`) y por tanto menor o igual que `mapsize` si lo has especificado.

4. `mapfile` (obligatorio) es una ruta al archivo con el mapa en formato `.MAP`.

5. `decorations` (opcional) es una ruta a un archivo de salida en formato script del motor con decoraciones automáticas y que puedes incluir desde tu script para adornar las pantallas de forma automática. Básicamente el mapa se fuerza a *PACKED* y los tiles fuera de rango se escriben como decoraciones de las que se imprimen en los `ENTERING SCREEN`. Es una característica de `msc3` que aún no hemos comentado.

6. `lock` (opcional) sirve para especificar qué tile hace de cerrojo. Para **MTE MK1** tiene que ser el 15. Puedes omitir el parámetro si no usas cerrojos.

7. `fixmappy` (opcional) para deshacer el desbarajuste que lía mappy si tu tileset no empieza por uno completamente negro.

8. `tilesfile` (obligatorio) debe contener la ruta al archivo con el tileset de hasta 48 tiles, que debe ser un archivo tipo png de 256x48, como hemos visto.

9. `behsfile` (obligatorio) es la ruta al archivo con los comportamientos, en el formato que vimos en el anterior capítulo: un archivo de texto con los 48 valores separados por comas.

10. `defaultink` (opcional) especifica una tinta por defecto para los patrones que solo tengan un color, igual que en `ts2bin`.

11. `spritesfile` (obligatorio) es la ruta al archivo con el spriteset en el formato de siempre.

12. `nsprites` (opcional) por si tenemos más de 16 sprites y que, por el momento, omitiremos (no soportado por el motor).

13. `enemsfile` (obligatorio) contendra la ruta al archivo de colocación de enemigos y hotspots `.ene` del Ponedor.

14. Los datos de inicio `scr_ini`, `ini_x` e `ini_y` (obligatorios) sirven para indicar donde se empieza.

15. `max_objs` (opcional) es el número de objetos recogiscibles del nivel. Recuerda que este parámetro no se tomará en cuenta de todos modos a menos que hagamos la configuración parecida a la que explicaos en el capítulo anterior (en el apartado **Controlando la condición de final de cada nivel**) y que veremos mas tarde.

16. `enems_life` (obligatorio) establece la vida de los enemigos.

Hemos dicho que **Goku Mal** es un juego muy sencillo. En él no ha scriping y originalmente había algo de código custom, pero en esta recreación intentaremos hacerlo funcionar primero con lo más básico de **MTE MK1**. En las cuatro fases de acción en las que sólo hay que avanzar colocaremos un único item al final de la fase, de forma que al tocarlo terminaremos el nivel. En la fase 4, en la que hay que reunir un número de flores, igualmente terminaremos al reunirlas todas. Por tanto, la condición de final de todas las fases será sencillamente recoger todos los objetos.

Lo que tenemos que hacer ahora es escribir las cinco llamadas a `buildlevels_MK1` para generar los cinco *level bundles*. Veamos el primero.

El primer nivel se compone de `mapa0.map`, `enems0.ene`, `work0.png`, `behs0.txt` y `sprites0.png`. Se trata de un nivel vertical de 25 pantallas de altura. En este juego todos los niveles tienen 25 pantallas en diferentes geometrías menos el cuarto, que tiene 15, por lo que es necesario emplear el parametro `mapsize`. Configuraremos `MAP_W` y `MAP_H` en `my/config.h` para que multiplicados den 25, y usaremos `mapsize=25` en todas las conversiones.

Como el primer tile de nuestro tileset no estaba vacío y lo hemos usado directamente para crear el mapa en mappy, éste ha desplazado todos los valores una unidad y necesitaremos especificar `fixmappy`.

En el nivel se empieza en el nivel más bajo, o sea, en la pantalla 24, pegados al suelo, en la parte izquierda (coordenadas (2, 8)). En este juego no usamos cerrojos, por lo que omitiremos el parámetro. Tendremos que recordar activar `DEACTIVATE_KEYS`, ya que en el level bundle no se generarán cerrojos y por tanto tenemos que decirle al motor que no reserve sitio para ellos.

Finamente, en esta primera fase los enemigos normales soportarán dos golpes antes de morir.

Por tanto la llamada a `buildlevels_MK1.exe`, pensada para ejecutarse desde `dev/`,  sera algo así, para esta fase:

```
    $ ..\..\..\src\utils\buildlevels_MK1.exe ..\bin\level0.bin mapsize=25 mapfile=..\map\mapa0.MAP map_w=1 map_h=25 fixmappy tilesfile=..\gfx\work0.png behsfile=..\gfx\behs0.txt defaultink=7 spritesfile=..\gfx\sprites0.png enemsfile=..\enems\enems0.ene scr_ini=24 ini_x=2 ini_y=8 max_objs=1 enems_life=2
```

Si ejecutas esto directamente verás todo el proceso y todas las partes que, si te fijas, aparecen en el mismo orden que los distintos espacios reservados en `assets/levels.h` para poder plantar el binario justo ahí y que todo funcione.

Añadimos pues una llamada a buildlevels para cada uno de nuestros niveles, ajustando los parámetros necesarios según cada nivel. Fíjate en como las dimensiones del mapa van cambiando (aunque siempre son 25 pantallas), en cada nivel se empieza en un sitio diferente, cambia el número de objetos, y la cantidad de vida de los enemigos. Posteriormente comprimimos y limpiamos:

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

Ahora necesitamos una conversión más que usaremos luego en nuestras super pantallas de nuevo nivel super mega hiper chachis. Vamos a importar un tileset completo que tenemos en `level_screen_ts.png`. En la imagen hay 256 caracteres en 256x64 pixels, y para importar algo así tenemos `chr2bin`:

```
    C:\git\MK1\src\utils>chr2bin.exe
    chr2bin v0.4 20200119 ~ Usage:

    $ chr2bin charset.png charset.bin [defaultink|noattrs]

    where:
       * charset.png is a 256x64 file with 256 chars.
       * charset.bin is the output, 2304/2048 bytes bin file.
       * defaultink: a number 0-7. Use this colour as 2nd colour if there's only
         one colour in a 8x8 cell
       * noattrs: just outputs the bitmaps.
```

Para lo que vamos a usar estos gráficos no necesitamos los atributos así que los convertiremos así; luego los comprimimos y limpiamos:

```
    ..\..\..\src\utils\chr2bin ..\gfx\level_screen_ts.png ..\bin\level_screen_ts.bin noattrs > nul
    ..\..\..\src\utils\apultra ..\bin\level_screen_ts.bin ..\bin\level_screen_tsc.bin > nul

    del ..\bin\level_screen_ts.bin > nul 
```

### The Librarian

Aquí viene la parte guay. Hemos dicho que todos estos tiestos irán a nuestro almacenamiento en la RAM extra, que son los 64K que hay juntando las RAMs 3, 4, 6 y 7. Aparte de esto, en RAM 1 meteremos la música y el player, y las RAMs 5, 2 y 0 son las que (en ese orden) forman los 48K base que es donde se carga y opera el binario principal de nuestro juego.

Para meter todos estos tiestos en la RAM extra usaremos **The Librarian** en su versión 2, que leerá una lista de binarios y los irá metiendo en hasta cuatro archivos RAM?.bin de salida usando dos algoritmos diferentes:

1. Automático: **The Librarian** usa un algoritmo para encontrar una ordenación de los binarios que minimice el número de RAMs empleadas. Encontrar una ordenación *óptima* es un problema NP-Completo (de complejidad exponencial). **The Librarian** usa un algoritmo que encuentra una ordenación bastante buena, pero no es perfecto y a veces fallará. Por eso tenemos el modo:

2. Manual: **The Librarian** sigue el orden que aparece en el archivo de entrada con la lista.

Aunque no es necesario por ahora para este juego, **The Librarian** además acepta precargar binarios al principio de una o varias RAMs, y empezará a acomodar el resto de tus binarios detrás. Esto sirve por ejemplo para colocar el script de tu juego en RAM extra, por ejemplo en RAM6. En un caso así, se renombraría `scripts.bin` como `preload6.bin` y **The Librarian** lo colocaría automáticamente al principio de RAM6 y acomodaría el resto de los binarios en las otras RAMs y tras los scripts en RAM6. Así le podríamos decir al motor que los scripts están al principio de RAM6 y todo funcionaría. Pero como **Goku Mal** no tiene scripting, pues no necesitareos esta característica.

Finalmente, lo otro que hace **The Librarian** es generar una estructura con información sobre dónde encontrar cada binario y constantes para identificarlos, que necesitaremos más adelante cuando estemos construyendo nuestro *levelset*.

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
3. `bins_prefix` (opcional) sirve para proporcionar una ruta para los archivos binarios que aparecen en la lista. Si ejecutamos **The Librarian** desde `dev/`, desde nuestro script, y los binarios en la lista aparecen simplemente nombrados pero estan en `bin/`, como será nuestro caso, tendremos que emplear este parámetro con el valor `../bìn/` para que **The Librarian** pueda encontrarlos.
4. `rams_prefix` (opcional) funciona parecido pero con los archivos `RAM?.bin` de salida. Si no ponemos nada los creará en `dev/`, pero quereos que estén en `bin/`, por lo que tendremos que especificar `../bin/` también como valor de este parámetro.
5. Por último, si añadimos `manual` a la linea de comando, se empleará el orden natural. Nosotros confiaremos en el algoritmo para este juego, que funcionará genialmente y ubicará los 35K de binarios comprimidos en tenemos en tres páginas de RAM: RAM3, RAM4 y RAM6.

Por lo tanto, lo siguiente será añadir una nueva linea a nuestro `build_assets.bat`: la llamada a **The Librarian**, que será:

```
    echo Running The Librarian
    ..\..\..\src\utils\librarian2.exe list=..\bin\list.txt index=assets\librarian.h bins_prefix=..\bin\ rams_prefix=..\bin\
```

Y crear un archivo `list.txt` en `bin/` con la lista de todos los binarios, uno por linea, o sea:

```
    titlec.bin
    marcoc.bin
    endingc.bin
    dedicadoc.bin
    controlsc.bin
    logoc.bin
    zoneAc.bin
    zoneBc.bin
    intro1c.bin
    intro2c.bin
    intro3c.bin
    intro4c.bin
    intro5c.bin
    intro6c.bin
    intro7c.bin
    level_screen_tsc.bin
    level0c.bin
    level1c.bin
    level2c.bin
    level3c.bin
    level4c.bin
```

### La OGT

Como hemos dicho, no nos detendremos en cómo montar una OGT aqui, sino que lo dejaremos para otro capítulo. Aquí sólo veremos cómo generar RAM1 a partir de una OGT ya hecha.

Pondremos en `mus/` todo lo necesario, a saber:

1. `WYZproPlay47aZX.ASM`, el código del player, ya modificado con la lista de canciones, e incluyendo nuestros instrumentos y efectos de sonido.
2. `instrumentos.asm`, con los instrumentos según exporta Wyz Player.
3. `efectos.asm`, con los efectos según los exporta Wyz Player.
4. `*.mus`, todas las canciones.

Con todo en su sitio, sólo tendremos que llamar al ensamblador `pasmo`, incluido en `/src/utils/`, para generar RAM1.bin y colocarla en `bin/`. Añadimos una última linea a nuestro `build_assets.bat`:

```
    echo Making music
    ..\..\..\src\utils\pasmo ..\mus\WYZproPlay47aZX.ASM ..\bin\RAM1.bin
```

¡Y ya lo tenemos todo! Es el momento de irse a `dev/` y ejecutar `build_assets.bat` y ver como se obtienen los diferentes `RAM?.bin` en `bin/`.

## Configurando el motor

### Configuración

### El lelvelset

## Modificando `compile.bat`

## Controlando la condición de final de cada nivel, versión 128K