@echo off
echo ### COMPILANDO SCRIPT ###
cd ..\script
msc blaster.spt msc.h 25
copy *.h ..\dev
cd ..\dev
echo -------------------------------------------------------------------------------
echo ### REGENERANDO MAPA ###
cd ..\map
..\utils\mapcnv mapa.map 5 5 15 10 15 packed
copy mapa.h ..\dev
cd ..\dev
echo -------------------------------------------------------------------------------
echo ### REGENERANDO ENEMS ###
..\enems\ene2churrera.exe ..\enems\enems.ene enems.h gencounter
echo -------------------------------------------------------------------------------
echo ### REGENERANDO GRÁFICOS ###
echo Tileset...
..\utils\ts2bin.exe ..\gfx\font.png ..\gfx\work.png maints.bin forcezero > nul
echo Spriteset...
..\utils\sprcnv.exe ..\gfx\sprites.png sprites.h > nul
echo Pantallas fijas ...
..\utils\png2scr.exe ..\gfx\title.png ..\gfx\title.scr > nul
..\utils\png2scr.exe ..\gfx\loading.png loading.bin  > nul
..\utils\png2scr.exe ..\gfx\ending.png ..\gfx\ending.scr  > nul
..\utils\apack.exe ..\gfx\title.scr title.bin  > nul
..\utils\apack.exe ..\gfx\ending.scr ending.bin > nul
echo Todo correcto!
del ..\gfx\title.scr > nul
del ..\gfx\ending.scr > nul
echo -------------------------------------------------------------------------------
echo ### COMPILANDO GUEGO ###
zcc +zx -vn blaster.c -o blaster.bin -lndos -lsplib2 -zorg=24200
echo -------------------------------------------------------------------------------
echo ### CONSTRUYENDO CINTA ###
..\utils\bas2tap -a10 -sBLASTER loader.bas loader.tap
..\utils\bin2tap -o screen.tap -a 16384 loading.bin
..\utils\bin2tap -o main.tap -a 24200 blaster.bin
copy /b loader.tap + screen.tap + main.tap blaster.tap
echo -------------------------------------------------------------------------------
echo ### LIMPIANDO ###
del loader.tap
del screen.tap
del main.tap
del blaster.bin
echo -------------------------------------------------------------------------------
echo ### DONE ###
