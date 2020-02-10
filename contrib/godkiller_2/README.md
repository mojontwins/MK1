# Nightmare on Halloween

Port a **MTE MK1 v5** del juego de **cтнonιan godĸιller** (Maxi Ruano).

Este juego demuestra el modo 128K con un solo nivel.

## 128K con un solo nivel

El modo 128K con un solo nivel fue creado ex profeso para desarrolladores que estaban creando su juego 48K pero se quedaron sin memoria suficiente. Activando este modo (`MODE_128K` sin `COMPRESSED_LEVELS`) se activa `librarian.h` y se mueven las pantallas fijas a la RAM3. De regalo tendremos música y efectos 128K.

Para portar **Godkiller 2** a **MTE MK1 v5** he hecho lo siguiente:

1. tomé como base `src/spare/compile_128k.bat` para la generación de la cinta con el cargador en ensamble para 128K.

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

4. Monté la OGT en `mus/` comprimiendo los archivos `.mus` como mandan los cánones de v5.

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
		INCBIN "ending.mus.bin"

	;; INCLUIR LOS EFECTOS DE SONIDO:

	INCLUDE "efectos.asm"

	;; Añadir entradas para cada canción
					
	TABLA_SONG:     DW      SONG_0, SONG_1

	;; Añadir entradas para cada efecto
	[...]
```
(final de `WYZproPlay47aZXc.ASM` con el playlist)

5. Apañé `my/config.h` con la configuración del juego.

6. Y mediante un extraño y misterioso proceso obtuve un resultado genial.

¡Asias Titan 😈!
