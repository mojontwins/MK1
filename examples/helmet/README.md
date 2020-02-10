# Sgt Helmet: Training Day MK1 v5 Edition

Se trata de adaptar el viejo Sgt. Helmet: Training Day a la v5. de **MTE MK1** más que nada para probar el motor de disparos. Una vez funcionando todo, haré modificaciones mínimas para poder tener las tres fases de la versión de SG-1000 en ZX Spectrum usando inyección de código.

## Primer hito: port directo

El primer hito será replicar el **Sgt. Helmet: Training Day** 1:1.

### Los tiestos

Empezamos montando este nuevo proyecto como cualquier proyecto de **MTE MK1**: Copiamos el contenido de `src` y sustituimos todos los tiestos por las cosas de Sgt. Helmet, a saber:

* `mapa.fmp` y `mapa.map` que inteligentemente renombro `mapa0.fpm` y `mapa0.map` para cuando haya más.
* `enems.ene` que renombro `enems0.ene`. Como este archivo está en formato legacy (2 bytes por hotspot) tendré que convertirlo usando Ponedor.
* `loading.png`, `title.png`, y `ending.png`, tal cual.
* `font.png`, `sprites.png` y `work.png`, que he renombrado a `work0.png`.
* `helmet.spt`, el script.

### `compile.bat`

Lo siguiente es modificar `compile.bat` para las dimensiones del mapa, el número de pantallas y cambiar los nombres de archivo que tengo diferentes:

```
	@echo off

	set game=helmet

	cd ..\script
	if not exist %game%.spt goto :noscript
	echo Compilando script
	..\..\..\src\utils\msc3_mk1.exe %game%.spt 24 > nul
	copy msc.h ..\dev\my > nul
	copy msc-config.h ..\dev\my > nul
	copy scripts.bin ..\dev\ > nul
	:noscript
	cd ..\dev

	echo Convirtiendo mapa
	..\..\..\src\utils\mapcnv.exe ..\map\mapa0.map 1 24 15 10 15 packed > nul
	cd ..\dev

	echo Convirtiendo enemigos/hotspots
	..\..\..\src\utils\ene2h.exe ..\enems\enems0.ene enems.h

	echo Importando GFX
	..\..\..\src\utils\ts2bin.exe ..\gfx\font.png ..\gfx\work0.png tileset.bin forcezero >nul

	..\..\..\src\utils\sprcnv.exe ..\gfx\sprites.png sprites.h > nul

	..\..\..\src\utils\sprcnvbin.exe ..\gfx\sprites_extra.png sprites_extra.bin 1 > nul
	..\..\..\src\utils\sprcnvbin8.exe ..\gfx\sprites_bullet.png sprites_bullet.bin 1 > nul

	..\..\..\src\utils\png2scr.exe ..\gfx\title.png ..\gfx\title.scr > nul
	..\..\..\src\utils\png2scr.exe ..\gfx\marco.png ..\gfx\marco.scr > nul
	..\..\..\src\utils\png2scr.exe ..\gfx\ending.png ..\gfx\ending.scr > nul
	..\..\..\src\utils\png2scr.exe ..\gfx\loading.png loading.bin > nul
	..\..\..\src\utils\apack.exe ..\gfx\title.scr title.bin > nul
	..\..\..\src\utils\apack.exe ..\gfx\marco.scr marco.bin > nul
	..\..\..\src\utils\apack.exe ..\gfx\ending.scr ending.bin > nul

	echo Compilando guego
	zcc +zx -vn mk1.c -o %game%.bin -lsplib2_mk2.lib -zorg=24000 > nul
	..\..\..\src\utils\printsize.exe %game%.bin
	..\..\..\src\utils\printsize.exe scripts.bin

	echo Construyendo cinta
	rem cambia LOADER por el nombre que quieres que salga en Program:
	..\..\..\src\utils\bas2tap -a10 -sLOADER loader\loader.bas loader.tap > nul
	..\..\..\src\utils\bin2tap -o screen.tap -a 16384 loading.bin > nul
	..\..\..\src\utils\bin2tap -o main.tap -a 24000 %game%.bin > nul
	copy /b loader.tap + screen.tap + main.tap %game%.tap > nul

	echo Limpiando
	del loader.tap > nul
	del screen.tap > nul
	del main.tap > nul
	del ..\gfx\*.scr > nul
	del *.bin > nul

	echo Hecho!
```

### config.h

Abrimos el `config.h` original y modificamos `my/config.h` con los valores que apliquen.

### Compilar y probar.

## Segundo hito: pasar a CIP

Necesito liberar todo el espacio que pueda, por lo que voy a pasar la lógica del juego de scripting a CIP.

El primer paso será comentar `ACTIVATE_SCRIPTING` en `my/config.h`. Luego habrá que ir siguiendo el script para ir replicando la funcionalidad en código C.

### `ENTERING_GAME`

Tenemos que empezar poniendo el flag 1 a 0. También pondremos el 2, que es el que controla la venta de la moto seminueva. Añadimos este código en `my/ci/entering_game.h`.

### `ENTERING ANY`

En esta sección se imprimen mensajes diciendo lo que hay que hacer, dependiendo del valor del flag 1. Añadimos código para esto en `my/ci/entering_screen.h`.

### `ENTERING SCREEN n`

En el mismo archivo rellenamos la funcionalidad de las secciones `ENTERING SCREEN n`.  En primer lugar, pintar las decoraciones (ordenador, bombas, moto). Creamos los arrays para estas decoraciones en `my/ci/extra_vars.h`. 

Finalmente haremos la comprobación de que hemos llegado al principio con la misión cumplida.

### PRESS-FIRE AT SCREEN n

Tendremos que detectar que el jugador se acerca al ordenador para poner las bombas. Lo haré a lo fácil: cuando `gpy` entre en el tile 5 (sea menor que 96) lanzaré la animación. Todo esto en `my/ci/extra_routines.h`.

Para la animación voy a hacer las cosas de forma inteligente: voy a emplear el array que tengo con las decos para las bombas y lo voy a recorrer haciendo la animación. Así me ahorro un porrón de código repe.

### Comparamos

Con esto hemos pasado de 31723 bytes a 30668, lo cual nos da más de 1Kb extra. En total 61440 - 24000 - 30668 = 6772 bytes para lo que nos queda por meter.

## Tercer hito: Multinivel

Ahora es cuando nos ponemos a generar la versión multinivel de nuestro güego. Lo primero que haremos será hacernos un archivo `build_assets.bat` en `dev/` que se encargue de construirnos todas las cosas. Generaremos un montón de binarios que colocaremos en `bin/` y que posteriormente veremos como incorporar en nuestro juego. Luego tendremos que modificar también `compile.bat` para quitar la generación de los archivos de mapa/cerrojos, enemigos/hotspots y para modificar la generación del tileset para que únicamente incluya la fuente.

Esa parte nos queda así:

```

```

