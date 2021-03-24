@echo off

if [%1]==[help] goto :help

set game=128k

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

echo Importando GFX
..\..\..\src\utils\ts2bin.exe ..\gfx\font.png notiles tileset.bin 7 >nul

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
    ram4_length=?..\bin\RAM4.bin ^
    ram6_length=?..\bin\RAM6.bin ^
    ram7_length=?..\bin\RAM7.bin ^
    mb_length=?%game%.bin  > nul

..\..\..\src\utils\pasmo.exe loader\loader.asm ..\bin\loader.bin loader.txt

..\..\..\src\utils\GenTape.exe %game%.tap ^
    basic 'GOKU MAL' 10 ..\bin\loader.bin ^
    data                loading.bin ^
    data                ..\bin\RAM1.bin ^
    data                ..\bin\RAM3.bin ^
    data                ..\bin\RAM4.bin ^
    data                ..\bin\RAM6.bin ^
    data                ..\bin\RAM7.bin ^
    data                %game%.bin

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
