# Herramientas de MTE MK1

En este documento describimos brevemente las diferentes herramientas disponibles en el toolchain. Para más información, consúltese el tutorial.

## apack.exe

Conversor en formato aplib. Versión legacy.

## apultra.exe

Conversor en formato aplib con mejor ratio de conversión, realizado por **Emmanuel Marty**. Más info en el [repositorio de **apultra**](https://github.com/emmanuel-marty/apultra).

```
	$ apultra.exe in.bin out.bin
```

* Comprime `in.bin` y genera `out.bin`. Se puede usar rutas absolutas o relativas.

## asm2z88dk.exe

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

## bas2tap.exe

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

## behs2bin.exe

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

## bin2tap.exe

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

## buildlevels_MK1.exe

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

## chr2bin.exe

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


Ver el [capítulo 13 del tutorial](https://github.com/mojontwins/MK1/blob/master/docs/tutorial-cap13.md).

## downgrademap.exe

## ene2bin_mk1.exe

## ene2h.exe

## flipenems.exe

## flipmap.exe

## GenTape.exe

## h2ene.exe

## h2map.exe

## imanol.exe

## librarian2.exe

## mapcnv.exe

## mapcnvbin.exe

## msc3_mk1.exe

## pasmo.exe

## png2scr.exe

## ponedor.exe

## printsize.exe

## reordenator.exe

## rle53map_sp.exe

## rle62map_sp.exe

## sprcnv.exe

## sprcnv2.exe

## sprcnvbin.exe

## sprcnvbin8.exe

## tmxcnv.exe

## ts2bin.exe

## WyzFx2Asm.exe
