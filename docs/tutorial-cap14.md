# Capítulo 14: Sonido 128K

En este capítulo veremos cómo montar una banda sonora u OGT usando WYZ Tracker 1.5.2 de **Augusto Ruiz** y WYZ Player 4.7 de **WYZ**. 

## Introducción y preparativos

Lo primero que necesitamos hacer es descomprimir y preparar WYZ Tracker. Para eso:

1. descomprimiremos el archivo `env/WYZTracker-0.5.0.2.zip` donde estemos instalando las utilidades.
2. Entraremos en el directorio de WYZ Tracker y ejecutaremos `oalinst.exe` para instalar OpenAL. Dale a todo si a todo guay.

![OpenAL installer](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/14_openal.png)

3. Ya podremos ejecutar WYZ Tracker mediante su ejecutable `WYZTracker.exe` (¡no tiene pérdida!). Si tienes problemas para ejecutarlo, prueba a ejecutarlo como Administrador. Mi ratio entre problemas y no problemas es 50% en mis equipos, pero de una forma u otra termina funcionando.

## Música

La música de tu juego se compone de canciones que se comprimen de forma individual en formato aplib y se descomprimen a un buffer antes de tocarlas.

El sistema de sonido emplea RAM1. Tiene 16K para el player, la música comprimida, y el buffer de descompresión. Recuerda que tu binario no debe ocupar más de 16K menos lo que ocupe la canción más grande, o no se podrá descomprimir para tocarla.

### Instrumentos y efectos

Las canciones están compuestas por una serie de eventos ordenados en el tiempo: notas musicales o percusiones. Las notas suenan a través de los *instrumentos*, que definen más o menos el timbre (añade muchas comillas, tú ya me entiendes), y la percusión mediante los *efectos*.

Para hacer una OGT para **MTE MK1** la restricción es que todas las canciones tienen que usar el mismo set de instrumentos y el mismo set de efectos. No nos vamos a poner aquí a decir cómo tienes que manejarte haciendo música, pero la técnica suele ser hacer la primera canción e ir creando los instrumentos y efectos según te van haciendo falta, grabarlos, y cuando empieces la siguiente canción cargar los mismos sets, y, si necesitas algún instrumento o efecto más, añadirlo. Trabajar de forma incremental, vaya. 

![Grabar instrumentos](https://raw.githubusercontent.com/mojontwins/MK1/master/docs/wiki-img/14_wyz_instrumentos.png)

### Exportando

Cuando se está trabajando en la OGT usamos el propio formato de WYZ Tracker (archivos `.wyz`) para almacenar las canciones. Sin embargo, y como suele ocurrir, eso no nos sirve directamente.

El formato que toca **WYZ Player** es el formato `mus`. Desde el menú `Archivo → Exportar` podremos exportar la canción que esté cargada en el tracker.

Esto generará dos archivos:

1. Archivo `.mus`, con la canción en sí.
2. Archivo `.mus.asm`, con los instrumentos y efectos de la canción.

Cuando tengamos exportadas todas las canciones, podremos descartar todos los archivos `.mus.asm` menos el que esté más completo. Este lo renombraremos como `instrumentos.asm`. Este archivo y todos los `.mus` los colocaremos en el directorio `/mus` junto con el código del player, `WYZproPlay47aZXc.ASM`.

El siguiente paso será comprimir todos los archivos `.mus`. Te recomiendo que te crees un archivo `.bat` para hacer esto de forma automática porque siempre hay algún retoquecillo que te obliga a reconstruirlo todo. Puedes tomar como ejemplo este archivo que he creado para la OGT de **Goku Mal** y que he puesto en `/mus` para ejecutar a mano cuando lo necesite:

```
@echo off
..\..\..\src\utils\apultra.exe 01_TITLE!.mus 01_TITLE!.mus.bin
..\..\..\src\utils\apultra.exe 02_INTRO!!!.mus 02_INTRO!!!.mus.bin
..\..\..\src\utils\apultra.exe 03_ZONE123!.mus 03_ZONE123!.mus.bin
..\..\..\src\utils\apultra.exe 04_FASE1.mus 04_FASE1.mus.bin
..\..\..\src\utils\apultra.exe 05_FASE2.mus 05_FASE2.mus.bin
..\..\..\src\utils\apultra.exe 06_FASE3.mus 06_FASE3.mus.bin
..\..\..\src\utils\apultra.exe 07_ZONE5!.mus 07_ZONE5!.mus.bin
..\..\..\src\utils\apultra.exe 08_FASE5.mus 08_FASE5.mus.bin
..\..\..\src\utils\apultra.exe 10_GAME_OVER!.mus 10_GAME_OVER!.mus.bin
..\..\..\src\utils\apultra.exe 09_ENDING!.mus 09_ENDING!.mus.bin
```

## Efectos de sonido

El siguiente paso será crear lo efectos de sonido. Quiero dar las gracias a **GreenWebSevilla** y a **thEpOpE** por sus contribuciones en este apartado: el primero por la creación de un [tutorial](https://github.com/mojontwins/MK1/blob/master/docs/contribs/Manual%20FX%20para%20MK2%20con%20WYZ.pdf) con el proceso y el segundo por escribir la herramienta de conversión `WyzFx2Asm.exe` y las modificaciones necesarias a **WYZ Player** para que los efectos puedan usar el canal de ruido.

Aunque obviamente todo es posible y te puedes poner a refinar esto muchísimo más, por defecto **MTE MK1** tiene la siguiente lista de sonidos numerados, como siempre, a partir de cero:

|#|Khe
|---|---
|0|Efecto "START"
|1|Tile rompiscible golpeado
|2|Tile rompiscible destruído
|3|Empujar una caja / abrir un cerrojo
|4|Disparar
|5|Coger un objeto coleccionable
|6|Matar a un enemigo
|7|Golpear a un enemigo
|8|Modo "un sólo objeto", recoger
|9|Modo "un sólo objeto", ya tengo
|10|Coger una llave
|11|Coger cualquier tipo de refill
|12|Sartar
|13|Pincharse
|14|Ser golpeado por enemigo

La lista está compuesta por una serie de macros definidos en el archivo `assets/ay_fx_numbers.h`, por si alguna vez tienes la necesidad de cambiarlo o ampliarlo.

Para cambiar los efectos de sonido tendremos que crear una lista de *efectos* equivalente en **WYZ Player**. El primer efecto se convertirá en el primer efecto de sonido (el 0, "START"), el segundo efecto en el segundo efecto de sonido, etcétera. Puedes encontrar más detalles sobre el tema en [el tutorial de **GreenWebSevilla**](https://github.com/mojontwins/MK1/blob/master/docs/contribs/Manual%20FX%20para%20MK2%20con%20WYZ.pdf) y en el [manual de WYZ Tracker](https://sites.google.com/site/augustoruiz/wyztracker#TOC-Editor-de-efectos)

Una vez que tengamos la lista creada, la grabaremos en formato `.fx`. El siguiente paso es convertirla a código ASM, y para ello emplearemos la herramienta de conversión `WyzFx2Asm.exe` de **thEpOpE**  que encontraremos en `/src/utils/`.

Esta herramienta funciona de forma interactiva. Al ejecutarla, nos pedirá que ubiquemos primero el archivo `.fx` de entrada, y seguidamente, que seleccionemos una ubicación para el archivo de salida `efectos.asm`. Elegiremos el directorio `mus/` de nuestro proyecto.

## Montando el player

Lo siguiente será montar nuestro playlist en el player. Para eso tenemos que editar el código de **WYZ Player**, o sea, el archivo `WYZproPlay47aZX.ASM` que esta en `mus/`.

Lo primero que hay que hacer es incluir todas las canciones comprimidas de nuestra OGT en orden, usando una etiqueta `SONG_n`, con `n` el número de orden empezando en 0, para cada una. Encontrarás donde hacerlo porque en el archivo originalmente hay un *stub* `SONG_0` que deberás eliminar para poner tu lista. Por ejemplo, para la OGT de **Goku Mal** nos quedaria así:

```asm
    ;; Las canciones tienen que estar comprimidas con aplib
                
    SONG_0:
        INCBIN "01_TITLE!.mus.bin"
    SONG_1:
        INCBIN "02_INTRO!!!.mus.bin"
    SONG_2:
        INCBIN "03_ZONE123!.mus.bin"
    SONG_3:
        INCBIN "04_FASE1.mus.bin"
    SONG_4:
        INCBIN "05_FASE2.mus.bin"
    SONG_5:
        INCBIN "06_FASE3.mus.bin"
    SONG_6:
        INCBIN "07_ZONE5!.mus.bin"
    SONG_7:
        INCBIN "08_FASE5.mus.bin"
    SONG_8:
        INCBIN "10_GAME_OVER!.mus.bin"
    SONG_9:
        INCBIN "09_ENDING!.mus.bin"
```

Ahora hay que hacer un array con esas etiquetas para que el motor las pueda usar. Un poco más abajo verás la etiqueta `TABLA_SONG`. Ahí, tras el `DW`, deberás referenciar las etiquetas de todas tus canciones. Para **Goku Mal** queda así:

```asm
    ;; Añadir entradas para cada canción
                    
    TABLA_SONG:     DW      SONG_0, SONG_1, SONG_2, SONG_3
                    DW      SONG_4, SONG_5, SONG_6, SONG_7
                    DW      SONG_8, SONG_9
```

Si no hemos alterado la lista de efectos de sonido, no tendremos que tocar nada más. Si sí que lo hemos hecho, habra que modificar la lista etiquetada como `TABLA_EFECTOS` para que aparezcan los efectos en orden. Por defecto sale así:

```asm
;; Añadir entradas para cada efecto

TABLA_EFECTOS:  DW      EFECTO0, EFECTO1, EFECTO2, EFECTO3
                DW      EFECTO4, EFECTO5, EFECTO6, EFECTO7
                DW      EFECTO8, EFECTO9, EFECTO10, EFECTO11
                DW      EFECTO12, EFECTO13, EFECTO14
```

¡Y listo! Todo debería estar en su sitio. Si no lo está, revísalo todo y hazlo más despacito.

