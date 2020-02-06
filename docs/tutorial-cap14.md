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

El siguiente paso será crear lo efectos de sonido. Quiero dar las gracias a **Greenweb Sevilla** y a **thEpOpE** por sus contribuciones en este apartado: el primero por la creación de un tutorial con el proceso y el segundo por escribir la herramienta de conversión y las modificaciones necesarias a **WYZ Player** para que los efectos puedan usar el canal de ruido.



## Montando el player

