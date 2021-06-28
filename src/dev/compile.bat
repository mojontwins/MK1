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
..\utils\ts2bin.exe ..\gfx\font.png ..\gfx\work.png tileset.bin 7 >nul

..\utils\sprcnv.exe ..\gfx\sprites.png assets\sprites.h > nul

..\utils\sprcnvbin.exe ..\gfx\sprites_extra.png sprites_extra.bin 1 > nul
..\utils\sprcnvbin8.exe ..\gfx\sprites_bullet.png sprites_bullet.bin 1 > nul

..\utils\png2scr.exe ..\gfx\title.png ..\gfx\title.scr > nul
..\utils\png2scr.exe ..\gfx\marco.png ..\gfx\marco.scr > nul
..\utils\png2scr.exe ..\gfx\ending.png ..\gfx\ending.scr > nul
..\utils\png2scr.exe ..\gfx\loading.png loading.bin > nul
..\utils\apultra.exe ..\gfx\title.scr ..\bin\title.bin > nul
..\utils\apultra.exe ..\gfx\marco.scr ..\bin\marco.bin > nul
..\utils\apultra.exe ..\gfx\ending.scr ..\bin\ending.bin > nul

if [%1]==[justassets] goto :end

rem echo Running The Librarian
rem ..\utils\librarian2.exe list=..\bin\list.txt index=assets\librarian.h bins_prefix=..\bin\ rams_prefix=..\bin\ > nul

rem *** Música AY: Descomenta el player que vayas a usar (Wyz o Arkos) ***

rem echo Compilando musica 128k - Wyz Player
rem cd ..\mus
rem ..\utils\apultra.exe menu.mus menu.bin
rem ..\utils\apultra.exe level1.mus level1.bin
rem ..\utils\pasmo WYZproPlay47aZXc.ASM ..\bin\RAM1.bin 
rem cd ..\dev

rem echo Compilando musica 128k - Arkos Player
rem cd ..\mus_arkos
rem if [%1]==[nomus] goto :nomus
rem ..\utils\build_mus_bin.exe ram1.bin > nul
rem :nomus
rem copy ram1.bin ..\bin
rem copy arkos-addresses.h ..\dev\sound
rem cd ..\dev

:compile
echo Compilando guego
zcc +zx -vn mk1.c -O3 -crt0=crt.asm -o %game%.bin -lsplib2_mk2.lib -zorg=24000 > nul
rem zcc +zx -vn mk1.c -o %game%.bin -lsplib2_mk2.lib -zorg=24000 > nul
..\utils\printsize.exe %game%.bin
..\utils\printsize.exe scripts.bin

rem *** Tipo de cargador ***

echo Construyendo cinta
rem cambia LOADER por el nombre que quieres que salga en Program:
..\utils\bas2tap -a10 -sLOADER loader\loader.bas loader.tap > nul
..\utils\bin2tap -o screen.tap -a 16384 loading.bin > nul
..\utils\bin2tap -o main.tap -a 24000 %game%.bin > nul
copy /b loader.tap + screen.tap + main.tap %game%.tap > nul
rem echo Construyendo cinta 128k
rem ..\utils\imanol.exe ^
rem in=loader\loaderzx.asm-orig ^
rem out=loader\loader.asm ^
rem ram1_length=?..\bin\RAM1.bin ^
rem ram3_length=?..\bin\RAM3.bin ^
rem mb_length=?%game%.bin  > nul

rem ..\utils\pasmo.exe loader\loader.asm ..\bin\loader.bin loader.txt

rem cambia LOADER por el nombre que quieres que salga en Program:
rem ..\utils\GenTape.exe %game%.tap ^
rem basic 'LOADER' 10 ..\bin\loader.bin ^
rem data                loading.bin ^
rem data                ..\bin\RAM1.bin ^
rem data                ..\bin\RAM3.bin ^
rem data                %game%.bin

if [%1]==[justcompile] goto :end
if [%1]==[noclean] goto :end

:clean
echo Limpiando
del loader.tap > nul
del screen.tap > nul
del main.tap > nul
del ..\gfx\*.scr > nul
del *.bin > nul

goto :end 

:help
echo "compile.bat help|justcompile|clean|justscripts|justassets|noclean"

:end
echo Hecho!
