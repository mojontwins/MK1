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

	echo Compilando script
	cd ..\script
	..\..\..\src\utils\msc3_mk1.exe %game%.spt 24
	copy msc.h ..\dev\my > nul
	copy msc-config.h ..\dev\my > nul
	copy scripts.bin ..\dev\ > nul
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

## Segundo hito: Multinivel

Ahora es cuando nos ponemos a generar la versión multinivel de nuestro güego. Lo primero que haremos será hacernos un archivo `build_assets.bat` en `dev/` que se encargue de construirnos todas las cosas. Generaremos un montón de binarios que colocaremos en `bin/` y que posteriormente veremos como incorporar en nuestro juego. Luego tendremos que modificar también `compile.bat` para quitar la generación de los archivos de mapa/cerrojos, enemigos/hotspots y para modificar la generación del tileset para que únicamente incluya la fuente.