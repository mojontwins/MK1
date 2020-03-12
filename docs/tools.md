# Herramientas de MTE MK1

En este documento describimos brevemente las diferentes herramientas disponibles en el toolchain. Para más información, consúltese el tutorial.

## `apack.exe`

Conversor en formato aplib. Versión legacy.

## `apultra.exe`

Conversor en formato aplib con mejor ratio de conversión, realizado por **Emmanuel Marty**. Más info en el [repositorio de **apultra**](https://github.com/emmanuel-marty/apultra).

```
	$ apultra.exe in.bin out.bin
```

* Comprime `in.bin` y genera `out.bin`. Se puede usar rutas absolutas o relativas.

## `asm2z88dk.exe`

Procesa archivos en ensamble para adaptarlos a las peculiaridades de **z88dk**. Ojal, **no se trata de una herramienta de propósito general**. Aunque puede que se porte bien con otros archivos, está escrita básicamente para preparar los archivos exportados desde **Beepola** y **BeepFX**.

```
	$ asm2z88dk.exe in.asm out.h [mk1]

	in.asm - standard assembly (pasmo)
	out.h - output filename

	This program:
	 1. Changes labels: to .labels
	 2. Adds #asm / #endasm
	 3. If mk1, removes DI/EI and stuff
```

* Procesa `in.asm` y genera `out.h`. Se puede usar rutas absolutas o relativas.
* Si se añade `mk1`, eliminará DI/EI y hará otras fullerías específicas.

Ver el [capítulo 10 del tutorial](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap10.md).

## `bas2tap.exe`

Por **Martijn Van Der Heide**. Convierte un archivo en formato texto con un programa en Sinclair BASIC a un archivo .tap con un bloque BASIC.

```
	$ bas2tap.exe

	BAS2TAP v2.5 by Martijn van der Heide of ThunderWare Research Center

	Usage: BAS2TAP [-q] [-w] [-e] [-c] [-aX] [-sX] FileIn [FileOut]
	       -q = quiet: no banner, no progress indication
	       -w = suppress generation of warnings
	       -e = write errors to stdout in stead of stderr channel
	       -c = case independant tokens (be careful here!)
	       -n = disable syntax checking
	       -a = set auto-start line in BASIC header
	       -s = set "filename" in BASIC header
```

## `behs2bin.exe`

Toma un archivo de texto con una lista separada por comas de 48 valores y genera un archivo binario de 48 bytes con esos valores. Se emplea para importar arrays de comportamientos (*behs*) en juegos multi nivel.

```
	$ utils\behs2bin.exe
	behs2bin 0.1
	usage

	$ behs2bin behs.txt behs.bin

	where:
	   * behs.txt behaviours file
	   * behs.bin output binary file
```

* Procesa `behs.txt` y genera `behs.bin`. Se puede usar rutas absolutas o relativas.

Ver el [capítulo 12 del tutorial](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap12.md).

## `bin2tap.exe`

Por **mike/zeroteam**. Convierte un archivo en formato binario a un archivo .tap con un 'CODE' con su contenido.

```
	$ bin2tap.exe --help
	bin2tap v.1.3
	Copyright (C) 2009 mike/zeroteam
	Usage: bin2tap [options] file.bin

	Options:
	  -o output_file      output TAP file
	  -a address          start address of binary file [32768]
	  -b                  include BASIC loader
	  -c clear_address    CLEAR address in BASIC loader [24575]
	  -r run_address      address where to start bin. file for BASIC loader [32768]
	  -cb border_colour   border colour set by loader [0]
	  -cp paper_colour    paper colour set by loader [0]
	  -ci ink_colour      ink colour set by loader [7]
	  -d80                create D80 syntax loader
	  -append             append tap at end of file
	  -hp | --header-poke include POKE command for dissabling tape headers
	  -h  | --help        usage information
	  -v  | --version     version info
```

## `buildlevels_MK1.exe`

Toma los recursos y configuración de un nivel y genera un level bundle para **MTE MK1** v5 (modo 128K multinivel).

```
    $ buildlevels_MK1.exe                                     
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

* `output.bin` (obligatorio) es el nombre de archivo de salida, donde se escribirá toda la mandanga. El resto de los parámetros se escribe en formato `clave=valor`.
* `mapsize` (opcional): indica el número total de pantallas que hay en el espacio de memoria reservado para el nivel, esto es, el resultado de multiplicar `MAP_W * MAP_H`. Es opcional porque si todos tus niveles tienen el mismo número de pantallas te basta con especificar los siguientes parámetros:
* `map_w` y `map_h` (obligatorios): especifican el ancho y alto en pantallas del nivel. Recuerda que `map_w * map_h` debe ser menor que el resultado de `MAP_W * MAP_H` (las macros de `my/config.h`) y por tanto menor o igual que `mapsize` si lo has especificado.
* `mapfile` (obligatorio) es una ruta al archivo con el mapa en formato `.MAP`.
* `decorations` (opcional) es una ruta a un archivo de salida en formato script del motor con decoraciones automáticas y que puedes incluir desde tu script para adornar las pantallas de forma automática. Básicamente el mapa se fuerza a *PACKED* y los tiles fuera de rango se escriben como decoraciones de las que se imprimen en los `ENTERING SCREEN`. Debe usarse en combinación con el scripting.
* `lock` (opcional) sirve para especificar qué tile hace de cerrojo. Para **MTE MK1** tiene que ser el 15. Puedes omitir el parámetro si no usas cerrojos.
* `fixmappy` (opcional) para deshacer el desbarajuste que lía mappy si tu tileset no empieza por uno completamente negro.
* `tilesfile` (obligatorio) debe contener la ruta al archivo con el tileset de hasta 48 tiles, que debe ser un archivo tipo png de 256x48, como hemos visto.
* `behsfile` (obligatorio) es la ruta al archivo con los comportamientos, en el formato que vimos en el anterior capítulo: un archivo de texto con los 48 valores separados por comas.
* `defaultink` (opcional) especifica una tinta por defecto para los patrones que solo tengan un color, igual que en `ts2bin`.
* `spritesfile` (obligatorio) es la ruta al archivo con el spriteset en el formato de siempre.
* `nsprites` (opcional) por si tenemos más de 16 sprites y que, por el momento, omitiremos (no soportado por el motor).
* `enemsfile` (obligatorio) contendra la ruta al archivo de colocación de enemigos y hotspots `.ene` del Ponedor.
* Los datos de inicio `scr_ini`, `ini_x` e `ini_y` (obligatorios) sirven para indicar donde se empieza.
* `max_objs` (opcional) es el número de objetos recogiscibles del nivel. Recuerda que este parámetro no se tomará en cuenta de todos modos a menos que hagamos la configuración parecida a la que explicaos en el capítulo anterior (en el apartado **Controlando la condición de final de cada nivel**) y que veremos mas tarde.
* `enems_life` (obligatorio) establece la vida de los enemigos.

Consúltese el [capítulo 13 del tutorial](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap13.md).

## `chr2bin.exe`

Convierte N patrones desde un archivo png de 256x64 bytes. Util para customs.

```
    $ chr2bin.exe
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

* `charset.png` nombre de archivo de entrada. Debe tener 256x64 pixels, por lo que podrá contener un máximo de 256 patrones.
* `charset.bin` es el nombre de archivo de salida.
* `n` es el número de caracteres
* `defaultink` es el número de tinta por defecto si el patrón sólo tiene un color liso.
* `noattrs` sacar sólo los bitmaps, sin atributos.

Ver el [capítulo 13 del tutorial](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap13.md).

## `ene2bin_mk1.exe`

Exporta un set de enemigos y hotspots `.ene` en formato binario para juegos multinivel.

```
    $ ene2bin_mk1.exe
    $ ene2bin_mk1.exe enems.ene enems+hotspots.bin life_gauge [2bytes]

    The 2bytes parameter is for really old .ene files which
    stored the hotspots 2 bytes each instead of 3 bytes.
    As a rule of thumb:
    .ene file created with ponedor.exe -> 3 bytes.
    .ene file created with colocador.exe for MK1 -> 2 bytes.
```

* `enems.ene` es el archivo de entrada.
* `enems+hotspots.bin` es el archivo de salida
* `life_gauge` es el número de impactos que deben recibir los enemigos antes de morir (por defecto).

Ver el [capítulo 12 del tutorial](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap12.md).

## `ene2h.exe`

Exporta un set de enemigos y hotspots `.ene` en formato de arrays y structs de código C.

```
    $ ene2h.exe
    $ ene2h.exe enems.ene enems.h [2bytes]

    The 2bytes parameter is for really old .ene files which
    stored the hotspots 2 bytes each instead of 3 bytes.
    As a rule of thumb:
    .ene file created with ponedor.exe -> 3 bytes.
    .ene file created with colocador.exe for MK1 -> 2 bytes.
```

* `enems.ene` es el archivo de entrada.
* `enems+hotspots.bin` es el archivo de salida
* `life_gauge` es el número de impactos que deben recibir los enemigos antes de morir (por defecto).

Ver el [capítulo 6 del tutorial](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap06.md).

## `GenTape.exe`

Por **Antonio villena**. Construye un archivo *.tap* a partir de una colección de bloques. En **MTE MK1** se emplea para generar las cintas de los juegos 128K.

[Código fuente](https://github.com/antoniovillena/zx7b/blob/master/GenTape/GenTape.c)

Ver el [capítulo 13 del tutorial](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap06.md).

## `imanol.exe`

Realiza sustituciones sencillas en un archivo de texto buscando patrones y sustituyéndolos por textos o cálculos con tamaños de archivos. Como un **sed** muy específico.

```
	$ imanol
	imanol v0.2
	Pattern Find And Replace Preprocessor for MK2 0.90+

	usage:

	$ imanol.exe in=infile.txt out=outfile.txt key=value ...

	Parameters to imanol.exe are specified as key=value, where keys are
	as follow:

	in             Input filename with %%%find%%% parameters.
	out            Output filename.
	key            %%%find%%% parameter to search for and be replaced by value

	If the value starts with '?', the actual text which is written is the result
	of a simple summatory expresion as in ?V1+V2+V3+... where Vn can be either a
	number or a filename. If Vn is a filename, the value summed is the file size.

	If you don't know what's this for, you don't need it.
```

Por ejemplo, si en el archivo de entrada `infile.txt` encuentra esta linea:

```
	¡El archivo %%%exe_name%%% ocupa %%%exe_size%%% bytes!
```

Y usas estos parámetros:

```
	$ imanol.exe in=infile.txt out=outfile.txt exe_size=?imanol.exe exe_name=imanol.exe
```

Se generará un archivo `outfile.txt` que será igual que `infile.txt` salvo por esa linea, que se habrá convertido en:

```
	¡El archivo imanol.exe ocupa 69120 bytes!
```

Ya que `imanol.exe` ocupa 69120 bytes y hemos sustituido `exe_size` por `?imanol.exe` (nótese el `?`; significa *el tamaño de `imanol.exe`*) y `exe_name` por `imanol.exe`.

Ver el [capítulo 13 del tutorial](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap06.md).

## `librarian2.exe`

Sirve para empaquetar un conjunto de binarios en páginas extra de RAM. Librarian2 busca una buena organización para minimizar el número de páginas usadas, siempre que sea posible (aunque no lo intenta con demasiada intensidad).

```
    * librarian2.exe
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

* `list` (obligatorio) indica la ruta al archivo con la lista de binarios.
* `index` (obligatorio) indica la ruta al archivo de código que contendrá el índice de binarios (esto es: dónde encontrarlos). Para **MTE MK1** esta ruta debe ser `/dev/assets/librarian.h`.
* `bins_prefix` (opcional) sirve para proporcionar una ruta para los archivos binarios que aparecen en la lista. Si ejecutamos **The Librarian** desde `dev/`, desde nuestro script, y los binarios en la lista aparecen simplemente nombrados pero estan en `bin/`, como será nuestro caso, tendremos que emplear este parámetro con el valor `../bìn/` para que **The Librarian** pueda encontrarlos.
* `rams_prefix` (opcional) funciona parecido pero con los archivos `RAM?.bin` de salida. Si no ponemos nada los creará en `dev/`, pero quereos que estén en `bin/`, por lo que tendremos que especificar `../bin/` también como valor de este parámetro.
* Por último, si añadimos `manual` a la linea de comando, se empleará el orden natural. Nosotros confiaremos en el algoritmo para este juego, que funcionará genialmente y ubicará los 35K de binarios comprimidos en tenemos en tres páginas de RAM: RAM3, RAM4 y RAM6.

Ver el [capítulo 13 del tutorial](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap06.md).

## `mapcnv.exe`

Esta utilidad pilla archivos `MAP` de **Mappy** y los divide en pantallas, generando un archivo de código .C con los arrays y estructuras necesarias. Además, si estamos usando tilesets de 16 tiles, empaqueta 2 tiles por cada byte).

```
$ ..\utils\mapcnv.exe
** USO **
   MapCnv archivo.map archivo.h ancho_mapa alto_mapa ancho_pantalla alto_pantalla tile_cerrojo [packed] [fixmappy]

   - archivo.map : Archivo de entrada exportado con mappy en formato raw.
   - archivo.h : Archivo de salida
   - ancho_mapa : Ancho del mapa en pantallas.
   - alto_mapa : Alto del mapa en pantallas.
   - ancho_pantalla : Ancho de la pantalla en tiles.
   - alto_pantalla : Alto de la pantalla en tiles.
   - tile_cerrojo : Nº del tile que representa el cerrojo.
   - packed : Escribe esta opción para mapas de la churrera de 16 tiles.
   - fixmappy : Escribe esta opción para arreglar lo del tile 0 no negro

Por ejemplo, para un mapa de 6x5 pantallas para MTE MK1:

   MapCnv mapa.map mapa.h 6 5 15 10 15 packed
```

* `archivo.map` es el archivo de entrada con nuestro mapa recién exportado de **Mappy**.
* `archivo.h` es el nombre de archivo para la salida.
* `ancho_mapa` es el ancho del mapa en pantallas. 
* `alto_mapa` es el alto del mapa en pantallas. 
* `ancho_pant` es el ancho de cada pantalla en tiles. Para **MTE MK1**, siempre es 15.
* `alto_pant` es el alto de cada pantalla en tiles. Para **MTE MK1**, siempre es 10.
* `tile_cerrojo` es el número de tile que hace de cerrojo. Para **MTE MK1** siempre ha de ser el tile número 15. Si tu juego no usa cerrojos, pon aquí un valor fuera de rango como 99. 
* `packed` se pone, tal cual, si nuestro tileset es de 16 tiles. Si usamos un tileset de 48 tiles, simplemente no ponemos nada. 
* `fixmappy` lo pondremos si nuestro tileset no tiene un primer tile todo a negro y pasamos de hacer un tileset especial, dejando que mappy lo insertase. Así `mapcnv` lo tiene en cuenta y hace sus fullerias.

Ver el [capítulo 3 del tutorial](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap03.md).

## `mapcnvbin.exe`

Análogo, pero exportando binarios. El resultado contendrá todo el mapa y acto seguido los cerrojos.

```
    $ ..\utils\mapcnvbin.exe
    ** USO **
       MapCnvBin archivo.map archivo.h ancho_mapa alto_mapa ancho_pantalla alto_pantalla tile_cerrojo [packed] [fixmappy]

       - archivo.map : Archivo de entrada exportado con mappy en formato raw.
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

* `archivo.map` es el archivo de entrada con nuestro mapa recién exportado de **Mappy**.
* `archivo.h` es el nombre de archivo para la salida.
* `ancho_mapa` es el ancho del mapa en pantallas. 
* `alto_mapa` es el alto del mapa en pantallas. 
* `ancho_pant` es el ancho de cada pantalla en tiles. Para **MTE MK1**, siempre es 15.
* `alto_pant` es el alto de cada pantalla en tiles. Para **MTE MK1**, siempre es 10.
* `tile_cerrojo` es el número de tile que hace de cerrojo. Para **MTE MK1** siempre ha de ser el tile número 15. Si tu juego no usa cerrojos, pon aquí un valor fuera de rango como 99. 
* `packed` se pone, tal cual, si nuestro tileset es de 16 tiles. Si usamos un tileset de 48 tiles, simplemente no ponemos nada. 
* `fixmappy` lo pondremos si nuestro tileset no tiene un primer tile todo a negro y pasamos de hacer un tileset especial, dejando que mappy lo insertase. Así `mapcnv` lo tiene en cuenta y hace sus fullerias.

Ver el [capítulo 12 del tutorial](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap12.md).

## `msc3_mk1.exe`

Compilador de scripts. Información detallada en la [documentación de MSC3](https://github.com/mojontwins/MK1/blob/master/docs/scripting.md).

## `png2scr.exe`

Convierte un archivo `png` creado con las restricciones de los gráficos de Spectrum a formato `scr` (imagen binaria de la porción de RAM que el Spectrum emplea para componer la imagen).

Con respecto a la paleta del Spectrum, como todas estas cosas, los valores que soportan por defecto los conversores incluidos en el toolchain son bastante arbitrarios. Para que todo vaya bien, usa unos valores de R, G, B de 200 si quieres representar los colores sin BRIGHT y de 255 si quieres representar los colores con BRIGHT. A Mappy no le gusta el magenta intenso (255, 0, 255), así que para este color puedes usar por ejemplo (254, 0, 255).

Si no te quieres rayar, usa los colores de esta paleta:

![Paleta](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/02_palette.png)

## `ponedor.exe`

Utilidad de colocación de enemigos y hotspots. 

```
    $ ..\utils\ponedor.exe -h
    Edit an existing set:
    $ ponedor.exe file.ene

    Create new set:
    $ ponedor.exe new out=file.ene map=file.map tiles=file.png|bmp [adjust=n] size=w,h
                      [scrsize=w,h] [nenems=n] [x2]

    out           output filename
    map           map file (raw, headerless, 1 byte per tile, row order)
    tiles         tileset in png or bmp format.
    adjust        substract this number from every byte read from the map file. Def=0
    size          map size in screens
    scrsize       screen size in tiles. Def=16,12
    nenems        number of enemies per screen. Def=3
    x2            zoom x2 (hacky)
```

Cuando ejecutas el Ponedor (por ejemplo, haciendo doble click sobre `ponedor.bat` en `/enems`) aparecerá la pantalla principal en al que podemos cargar un proyecto existente o configurar uno nuevo:

![Creando un nuevo proyecto](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/06_ponedor_create_new.png)

* `Map W` y `Map H` son el **ancho** y el **alto** de nuestro mapa **en pantallas**, o sea, las **dimensiones del mapa**. En el caso de **dogmole** habría que rellenar 8 y 3.
* `Scr W` y `Scr H` son las **dimensiones de cada pantalla**, en **tiles**. Para todos los güegos de **MTE MK1** estos valores son 15 y 10 (de hecho, vienen ya puestos por defecto). No toques aquí.
* `Nenems` es el número de enemigos máximo por pantalla. En **MTE MK1** debe ser 3, ni más ni menos. También viene puesto por defecto. No toques aquí tampoco.
* `Adjust` podrá valer 0 o 1, dependiendo se Mappy hizo fullerías. Si recordarás, a la hora de explicar cómo se montaba el mapa, mencionamos que Mappy quiere un tile negro como tile 0 y que si no se lo das, él se lo pone desplazando un espacio todos los tuyos. **Si te pasó esto, deberás cambiar el 0 que aparece en esta casilla por un 1**. De ese modo nuestro Ponedor estará coscado y pintará bien el mapa.
* Donde pone `TS` tenemos que poner la ruta del archivo con el tileset, que debería ser `work.png` a secas si lo has copiado en `enems`, aunque puedes usar el botón `Find` para ubicarlo desde un explorador si no te apetece escribir 8 caracteres.
* En `Map` hay que poner la ruta del archivo con el mapa, que debería ser `mapa.map` a secas si lo copiaste a `enems`. También puedes usar `Find`.
* No te olvides de poner **el nombre de archivo de salida** en la casilla `Output`. Si no quieres tocar `compile.bat`, este nombre debe ser `enems.ene`. 

Si prefieres usar la linea de comandos como yo, 

* Para editar un archivo `.ene` existente, simplemente ejecutar `ponedor.exe archivo.ene`.
* Para crear un archivo `.ene` nuevo, especificar `new` como primer parámetro, y acto seguido:
* `out=file.ene` para el archivo de salida.
* `map=mapa.map` el archivo con el mapa.
* `tiles=file.png` el tileset.
* `adjust=1` si tu primer tile no era negro sólido.
* `size=w,h` con `w` y `h` el tamaño en pantallas.
* `scrsize=15,10`, las dimensiones de cada pantalla para **MTE MK1**.
* `nenems=3`, el número de enemigos por pantalla para **MTE MK1**.
* En cualquier caso, `x2` hace la pantalla algo más grande.

Ver el [capítulo 6 del tutorial](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap06.md).

## `printsize.exe`

Escribe el tamaño del archivo que recibe como parámetro.

## `rle53map_sp.exe` y `rle62map_sp.exe`

Comprimen un mapa en formato RLE 5.3 o 6.2 indexado para usar con decodificadores de mapas personalizados. Dadme la coña para que escriba un tutorial sobre esto, o mirad **Sami Troid** o **Blip Blep**.

## `sprcnv.exe`

Utilidad de conversión de spritesets.

```
    $ ..\utils\sprcnv.exe
    ** USO **
       sprcnv archivo.png archivo.h [nomask]

    Convierte un Spriteset de 16 sprites
```

Ver el [capítulo 4 del tutorial](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap04.md).

## `sprcnv2.exe`

## `sprcnvbin.exe`

## `sprcnvbin8.exe`

## `tmxcnv.exe`

## `ts2bin.exe`

## `WyzFx2Asm.exe`
