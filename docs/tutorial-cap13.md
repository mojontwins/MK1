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
8. `zonaA.png` y `zoneB.png` se muestran antes de empezar cada nivel y muestran la cara de mala hostia de Goku Mal y el número de la fase que toca.
9. Finalmente tendremos nuestra pantalla de carga, `loading.png`, que tendremos que convertir pero no comprimir. Dejaremos esta tarea para `compile.bat` más adelante.

Sin salirnos de `gfx/`, tendremos además los gráficos para construir los niveles:

1. `work0.png`, `work1.png`, `work2.png`, `work3.png` y `work4.png` contienen los tilesets de las cinco fases. Es importante notar que todos estos tilesets tienen un tile 0 que no es del todo negro, por lo que habrá que tener en cuenta esto más adelante (ya que los .MAP tendrán los valores desplazados debido al glitch de mappy que ya conocemos bien). Tenemos aquí sus archivos de comportamientos asociados, `behs0.txt` a `behs4.txt`.
2. `sprites0.png`, `sprites1.png`, `sprites2.png`, `sprites3.png` y `sprites4.png` contienen los cinco spritesets correspondientes a cada una de las cinco fases.
3. `font.png` contiene la fuente base que se usará durante el juego.
4. `level_screen_ts.png` es un charset completo que se empleará para las pantallas de nuevo nivel especiales que tiene este juego.

En `map/` tenemos los mapas de los cinco niveles, `mapa0.fmp` a `mapa4.fmp` y sus exports en formato `MAP`: `mapa0.MAP` a `mapa5.MAP`.

En `enems/` tenemos los archivos de colocación de cosas para Ponedor, `enems0.ene` a `enems4.ene`. También hemos copiado aquí los `work?.png` con los tilesets y los `mapa?.MAP` con los mapas para que Ponedor los tenga bien a mano.

Este juego no tiene scripting, así que por último tenemos la banda sonora y OGT en el directorio `mus/`. Esta OGT fue creada con **Davidian** y tiene un montón de canciones. Ahora nos vamos a centrar más en la importación y construcción del juego pero dedicaré un apartado al final para hablaros de como montar las OGT con Wyz Player.

### Importación: pantallas fijas

Empezaremos a construir nuestro script encargado de crear los binarios con las pantallas fijas:

```bat
    @echo off

    if [%1]==[skipscr] goto skipscr

    ..\..\..\src\utils\png2scr ..\gfx\title.png ..\bin\title.bin
    ..\..\..\src\utils\png2scr ..\gfx\marco.png ..\bin\marco.bin
    ..\..\..\src\utils\png2scr ..\gfx\ending.png ..\bin\ending.bin
    ..\..\..\src\utils\png2scr ..\gfx\logo.png ..\bin\logo.bin
    ..\..\..\src\utils\png2scr ..\gfx\dedicado.png ..\bin\dedicado.bin
    ..\..\..\src\utils\png2scr ..\gfx\controls.png ..\bin\controls.bin
    ..\..\..\src\utils\png2scr ..\gfx\intro1.png ..\bin\intro1.bin
    ..\..\..\src\utils\png2scr ..\gfx\intro2.png ..\bin\intro2.bin
    ..\..\..\src\utils\png2scr ..\gfx\intro3.png ..\bin\intro3.bin
    ..\..\..\src\utils\png2scr ..\gfx\intro4.png ..\bin\intro4.bin
    ..\..\..\src\utils\png2scr ..\gfx\intro5.png ..\bin\intro5.bin
    ..\..\..\src\utils\png2scr ..\gfx\intro6.png ..\bin\intro6.bin
    ..\..\..\src\utils\png2scr ..\gfx\intro7.png ..\bin\intro7.bin
    ..\..\..\src\utils\png2scr ..\gfx\zonaA.png ..\bin\zonaA.bin
    ..\..\..\src\utils\png2scr ..\gfx\zonaB.png ..\bin\zonaB.bin

    ..\..\..\src\utils\apultra ..\bin\title.bin ..\bin\titlec.bin
    ..\..\..\src\utils\apultra ..\bin\marco.bin ..\bin\marcoc.bin
    ..\..\..\src\utils\apultra ..\bin\ending.bin ..\bin\endingc.bin
    ..\..\..\src\utils\apultra ..\bin\logo.bin ..\bin\logoc.bin
    ..\..\..\src\utils\apultra ..\bin\dedicado.bin ..\bin\dedicadoc.bin
    ..\..\..\src\utils\apultra ..\bin\controls.bin ..\bin\controlsc.bin
    ..\..\..\src\utils\apultra ..\bin\intro1.bin ..\bin\intro1c.bin
    ..\..\..\src\utils\apultra ..\bin\intro2.bin ..\bin\intro2c.bin
    ..\..\..\src\utils\apultra ..\bin\intro3.bin ..\bin\intro3c.bin
    ..\..\..\src\utils\apultra ..\bin\intro4.bin ..\bin\intro4c.bin
    ..\..\..\src\utils\apultra ..\bin\intro5.bin ..\bin\intro5c.bin
    ..\..\..\src\utils\apultra ..\bin\intro6.bin ..\bin\intro6c.bin
    ..\..\..\src\utils\apultra ..\bin\intro7.bin ..\bin\intro7c.bin
    ..\..\..\src\utils\apultra ..\bin\zonaA.bin ..\bin\zonaAc.bin
    ..\..\..\src\utils\apultra ..\bin\zonaB.bin ..\bin\zonaBc.bin

    :skipscr
```

Como normalmente en un desarrollo de este tipo las pantallas fijas son lo que menos va a evolucionar y además tardan un ratillo en comprimirse, añadimos un poco de magia batch. Cuando ejecutemos `build_assets.bat` con el parámetro `skipscr` la ejecución se saltará la conversión de las imagenes, lo que vendrá bien cuando tengamos que regenerar una y otra vez los mapas o la colocación de enemigos (repito, en un desarrollo normal en el que vas construyendo y depurando el juego poco a poco. Aquí ya lo tengo todo hecho).

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
                                                                                 
    TILESET/CHARSET DATA                                                         
                                                                                 
    fontfile       font.png (256x16) containing 64 8x8 chars, ASCII 32-95.       
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

7. `fontfile` (obligatorio) debe contener la ruta al archivo 