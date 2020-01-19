@echo off

set game=dogmole

echo Compilando script
cd ..\script
..\..\..\src\utils\msc3_mk1.exe %game%.spt 24 > nul
copy msc.h ..\dev\my > nul
copy msc-config.h ..\dev\my > nul
copy scripts.bin ..\dev\ > nul
cd ..\dev

echo Convirtiendo mapa
..\..\..\src\utils\mapcnv.exe ..\map\mapa.map 8 3 15 10 15 packed > nul
cd ..\dev

echo Convirtiendo enemigos/hotspots
..\..\..\src\utils\ene2h.exe ..\enems\enems.ene enems.h

echo Importando GFX
..\..\..\src\utils\ts2bin.exe ..\gfx\font.png ..\gfx\work.png tileset.bin 7 >nul

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
