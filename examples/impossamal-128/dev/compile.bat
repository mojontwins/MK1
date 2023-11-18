@echo off

if [%1]==[help] goto :help

set game=impossamal128

if [%1]==[justcompile] goto :compile
if [%1]==[clean] goto :clean

cd ..\script
if not exist %game%.spt goto :noscript
echo Compilando script
..\..\..\src\utils\msc3_mk1.exe %game%.spt 25 > nul
copy msc.h ..\dev\my > nul
copy msc-config.h ..\dev\my > nul
copy scripts.bin ..\dev\ > nul
:noscript
cd ..\dev

if [%1]==[justscripts] goto :compile

echo Convirtiendo mapa
..\..\..\src\utils\mapcnv.exe ..\map\mapa.map assets\mapa.h 25 1 15 10 15 > nul

echo Convirtiendo enemigos/hotspots
..\..\..\src\utils\ene2h.exe ..\enems\enems.ene assets\enems.h

echo Importando GFX
..\..\..\src\utils\ts2bin.exe ..\gfx\font.png ..\gfx\work.png tileset.bin 4 >nul

..\..\..\src\utils\sprcnv.exe ..\gfx\sprites.png assets\sprites.h > nul

..\..\..\src\utils\sprcnvbin.exe ..\gfx\sprites_extra.png sprites_extra.bin 1 > nul
..\..\..\src\utils\sprcnvbin8.exe ..\gfx\sprites_bullet.png sprites_bullet.bin 1 > nul

..\..\..\src\utils\png2scr.exe ..\gfx\title.png ..\gfx\title.scr > nul
..\..\..\src\utils\png2scr.exe ..\gfx\marco.png ..\gfx\marco.scr > nul
..\..\..\src\utils\png2scr.exe ..\gfx\ending.png ..\gfx\ending.scr > nul
..\..\..\src\utils\png2scr.exe ..\gfx\loading.png loading.bin > nul
..\..\..\src\utils\apultra.exe ..\gfx\title.scr ..\bin\title.bin > nul
..\..\..\src\utils\apultra.exe ..\gfx\marco.scr ..\bin\marco.bin > nul
..\..\..\src\utils\apultra.exe ..\gfx\ending.scr ..\bin\ending.bin > nul

if [%1]==[justassets] goto :end

echo Compilando textos
..\..\..\src\utils\textstuffer.exe ..\texts\texts.txt texts.bin 24

echo Running The Librarian
..\..\..\src\utils\librarian2.exe list=..\bin\list.txt index=assets\librarian.h bins_prefix=..\bin\ rams_prefix=..\bin\ > nul

rem *** Música AY: Descomenta el player que vayas a usar (Wyz o Arkos) ***

rem echo Compilando musica 128k - Wyz Player
rem cd ..\mus
rem ..\..\..\src\utils\apultra.exe menu.mus menu.bin
rem ..\..\..\src\utils\apultra.exe level1.mus level1.bin
rem ..\..\..\src\utils\pasmo WYZproPlay47aZXc.ASM ..\bin\RAM1.bin 
rem cd ..\dev

echo Compilando musica 128k - Arkos Player
cd ..\mus_arkos
if [%1]==[nomus] goto :nomus
..\..\..\src\utils\build_mus_bin.exe ram1.bin > nul
:nomus
copy ram1.bin ..\bin
copy arkos-addresses.h ..\dev\sound
cd ..\dev

:compile
echo Compilando guego
zcc +zx -vn mk1.c -O3 -crt0=crt.asm -o %game%.bin -lsplib2_mk2.lib -zorg=24000 > nul
rem zcc +zx -vn mk1.c -o %game%.bin -lsplib2_mk2.lib -zorg=24000 > nul
..\..\..\src\utils\printsize.exe %game%.bin
..\..\..\src\utils\printsize.exe scripts.bin

rem *** Tipo de cargador ***

rem echo Construyendo cinta
rem cambia LOADER por el nombre que quieres que salga en Program:
rem ..\..\..\src\utils\bas2tap -a10 -sIMPOSSAMAL loader\loader.bas loader.tap > nul
rem ..\..\..\src\utils\bin2tap -o screen.tap -a 16384 loading.bin > nul
rem ..\..\..\src\utils\bin2tap -o main.tap -a 24000 %game%.bin > nul
rem copy /b loader.tap + screen.tap + main.tap %game%.tap > nul
	echo Construyendo cinta 128k
	..\..\..\src\utils\imanol.exe ^
		in=loader\loaderzx.asm-orig ^
		out=loader\loader.asm ^
		ram1_length=?..\bin\RAM1.bin ^
		ram3_length=?..\bin\RAM3.bin ^
		mb_length=?%game%.bin  > nul

	..\..\..\src\utils\pasmo.exe loader\loader.asm ..\bin\loader.bin loader.txt

	rem cambia LOADER por el nombre que quieres que salga en Program:
	..\..\..\src\utils\GenTape.exe %game%.tap ^
		basic 'IMPOSSAMAL128' 10 ..\bin\loader.bin ^
		data                loading.bin ^
		data                ..\bin\RAM1.bin ^
		data                ..\bin\RAM3.bin ^
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
