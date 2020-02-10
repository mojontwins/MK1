@echo off

if [%1]==[help] goto :help

set game=godkiller2

if [%1]==[justcompile] goto :compile
if [%1]==[clean] goto :clean

cd ..\script
if not exist %game%.spt goto :noscript
echo Compilando script
..\..\..\src\utils\msc3_mk1.exe %game%.spt 24 > nul
copy msc.h ..\dev\my > nul
copy msc-config.h ..\dev\my > nul
copy scripts.bin ..\dev\ > nul
:noscript
cd ..\dev

if [%1]==[justscripts] goto :compile

echo Convirtiendo mapa
..\..\..\src\utils\mapcnv.exe ..\map\mapa.map assets\mapa.h 8 5 15 10 15 > nul

echo Convirtiendo enemigos/hotspots
..\..\..\src\utils\ene2h.exe ..\enems\enems.ene assets\enems.h

echo Importando GFX
..\..\..\src\utils\ts2bin.exe ..\gfx\font.png ..\gfx\work.png tileset.bin 7 >nul

..\..\..\src\utils\sprcnv.exe ..\gfx\sprites.png assets\sprites.h > nul

..\..\..\src\utils\sprcnvbin.exe ..\gfx\sprites_extra.png sprites_extra.bin 1 > nul
..\..\..\src\utils\sprcnvbin8.exe ..\gfx\sprites_bullet.png sprites_bullet.bin 1 > nul

..\..\..\src\utils\png2scr.exe ..\gfx\loading.png loading.bin > nul

if [%1]==[justassets] goto :end

:compile
echo Compilando guego
zcc +zx -vn mk1.c -o %game%.bin -lsplib2_mk2.lib -zorg=24000 > nul
..\..\..\src\utils\printsize.exe %game%.bin
..\..\..\src\utils\printsize.exe scripts.bin

echo Construyendo cinta
..\..\..\src\utils\imanol.exe ^
    in=loader\loaderzx.asm-orig ^
    out=loader\loader.asm ^
    ram1_length=?..\bin\RAM1.bin ^
    ram3_length=?..\bin\RAM3.bin ^
    mb_length=?%game%.bin  > nul

..\..\..\src\utils\pasmo.exe loader\loader.asm ..\bin\loader.bin loader.txt

..\..\..\src\utils\GenTape.exe %game%.tap ^
    basic 'GODKILLER2' 10 ..\bin\loader.bin ^
    data                loading.bin ^
    data                ..\bin\RAM1.bin ^
    data                ..\bin\RAM3.bin ^
    data                %game%.bin

if [%1]==[justcompile] goto :end
if [%1]==[noclean] goto :end

:clean
echo Limpiando
del *.bin > nul

goto :end 

:help
echo "compile.bat help|justcompile|clean|justscripts|justassets|noclean"

:end
echo Hecho!
