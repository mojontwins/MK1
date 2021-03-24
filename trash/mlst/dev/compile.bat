@echo off

if [%1]==[help] goto :help

set game=mlst

if [%1]==[justcompile] goto :compile
if [%1]==[clean] goto :clean

cd ..\script
if not exist %game%.spt goto :noscript
echo Compilando script
..\..\..\src\utils\msc3_mk1.exe %game%.spt 4 rampage > nul
copy msc.h ..\dev\my > nul
copy msc-config.h ..\dev\my > nul
copy scripts.bin ..\bin\preload3.bin > nul
:noscript
cd ..\dev

if [%1]==[justscripts] goto :compile

echo Importando GFX
..\..\..\src\utils\ts2bin.exe ..\gfx\font.png notiles font.bin 7 >nul

..\..\..\src\utils\sprcnvbin.exe ..\gfx\sprites_extra.png sprites_extra.bin 1 > nul
..\..\..\src\utils\sprcnvbin8.exe ..\gfx\sprites_bullet.png sprites_bullet.bin 1 > nul

..\..\..\src\utils\png2scr.exe ..\gfx\loading.png loading.bin > nul

if [%1]==[justassets] goto :end

:compile
echo Running The Librarian
..\..\..\src\utils\librarian2.exe list=..\bin\list.txt index=assets\librarian.h bins_prefix=..\bin\ rams_prefix=..\bin\ > nul

echo Compilando guego
zcc +zx -vn -m mk1.c -o %game%.bin -lsplib2_mk2.lib -zorg=24000 > nul
..\..\..\src\utils\printsize.exe %game%.bin
..\..\..\src\utils\printsize.exe ..\script\scripts.bin

echo Construyendo cinta
echo Construyendo cinta
..\..\..\src\utils\imanol.exe ^
    in=loader\loaderzx.asm-orig ^
    out=loader\loader.asm ^
    ram1_length=?..\bin\RAM1.bin ^
    ram3_length=?..\bin\RAM3.bin ^
    mb_length=?%game%.bin  > nul

..\..\..\src\utils\pasmo.exe loader\loader.asm ..\bin\loader.bin loader.txt

..\..\..\src\utils\GenTape.exe %game%.tap ^
    basic 'MLST'     10 ..\bin\loader.bin ^
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
