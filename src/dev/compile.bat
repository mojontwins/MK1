@echo off

if [%1]==[help] goto :help

set game=lala_beta

if [%1]==[justcompile] goto :compile
if [%1]==[clean] goto :clean

cd ..\script
if not exist %game%.spt goto :noscript
echo Compilando script
..\utils\msc3_mk1.exe %game%.spt 30 > nul
copy msc.h ..\dev\my > nul
copy msc-config.h ..\dev\my > nul
copy scripts.bin ..\dev\ > nul
:noscript
cd ..\dev

if [%1]==[justscripts] goto :compile

echo Convirtiendo mapa
..\utils\mapcnv.exe ..\map\mapa.map assets\mapa.h 6 5 15 10 15 packed > nul

echo Convirtiendo enemigos/hotspots
..\utils\ene2h.exe ..\enems\enems.ene assets\enems.h

echo Importando GFX
..\utils\ts2bin.exe ..\gfx\font.png ..\gfx\work.png ..\bin\tileset.bin 7 >nul

..\utils\sprcnv3.exe ..\gfx\sprites.png > nul

..\utils\sprcnvbin.exe ..\gfx\sprites_extra.png ..\bin\sprites_extra.bin 1 > nul
..\utils\sprcnvbin8.exe ..\gfx\sprites_bullet.png ..\bin\sprites_bullet.bin 1 > nul

..\utils\png2scr.exe ..\gfx\title.png ..\gfx\title.scr > nul
..\utils\png2scr.exe ..\gfx\marco.png ..\gfx\marco.scr > nul
..\utils\png2scr.exe ..\gfx\ending.png ..\gfx\ending.scr > nul
..\utils\png2scr.exe ..\gfx\loading.png ..\bin\loading.bin > nul
..\utils\apultra.exe ..\gfx\title.scr ..\bin\title.bin > nul
..\utils\apultra.exe ..\gfx\marco.scr ..\bin\marco.bin > nul
..\utils\apultra.exe ..\gfx\ending.scr ..\bin\ending.bin > nul

if [%1]==[justassets] goto :end

:compile
echo Compilando guego
zcc +zx -m -vn mk1.c -o ..\bin\%game%.bin -lsplib2_mk2.lib -zorg=24000 > nul
rem zcc +zx -a -vn mk1.c -o %game%.asm > nul
..\utils\printsize.exe ..\bin\%game%.bin
..\utils\printsize.exe scripts.bin

echo Construyendo cinta
rem cambia LOADER por el nombre que quieres que salga en Program:
..\utils\bas2tap -a10 -sLOADER loader\loader.bas loader.tap > nul
..\utils\bin2tap -o screen.tap -a 16384 ..\bin\loading.bin > nul
..\utils\bin2tap -o main.tap -a 24000 ..\bin\%game%.bin > nul
copy /b loader.tap + screen.tap + main.tap %game%.tap > nul

if [%1]==[justcompile] goto :end
if [%1]==[noclean] goto :end

:clean
echo Limpiando
del loader.tap > nul
del screen.tap > nul
del main.tap > nul
del ..\gfx\*.scr > nul
del scripts.bin > nul
if [%1]==[fullcleanup] goto :fullcleanup

goto :end 

:fullcleanup
del ..\bin\*.bin > nul

:help
echo "compile.bat help|justcompile|clean|justscripts|justassets|noclean"

:end
echo Hecho!
