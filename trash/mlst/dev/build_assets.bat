@echo off

if [%1]==[skipscr] goto skipscr

echo Making screens
..\..\..\src\utils\png2scr ..\gfx\title.png ..\bin\title.scr > nul
..\..\..\src\utils\png2scr ..\gfx\marco.png ..\bin\marco.scr > nul
..\..\..\src\utils\png2scr ..\gfx\ending.png ..\bin\ending.scr > nul
..\..\..\src\utils\png2scr ..\gfx\logo.png ..\bin\logo.scr > nul

..\..\..\src\utils\apultra ..\bin\title.scr ..\bin\title.bin > nul
..\..\..\src\utils\apultra ..\bin\marco.scr ..\bin\marco.bin > nul
..\..\..\src\utils\apultra ..\bin\ending.scr ..\bin\ending.bin > nul
..\..\..\src\utils\apultra ..\bin\logo.scr ..\bin\logo.bin > nul

del ..\bin\*.scr > nul

:skipscr

echo Making levels
..\..\..\src\utils\buildlevels_MK1.exe ..\bin\level0.bin mapsize=4 mapfile=..\map\mapa0.MAP map_w=2 map_h=1  tilesfile=..\gfx\work0.png behsfile=..\gfx\behs0.txt spritesfile=..\gfx\sprites.png enemsfile=..\enems\enems0.ene scr_ini=0 ini_x=2 ini_y=8 max_objs=99 enems_life=2 > nul
..\..\..\src\utils\buildlevels_MK1.exe ..\bin\level1.bin mapsize=4 mapfile=..\map\mapa1.MAP map_w=1 map_h=2 fixmappy tilesfile=..\gfx\work1.png behsfile=..\gfx\behs1.txt spritesfile=..\gfx\sprites.png enemsfile=..\enems\enems1.ene scr_ini=0 ini_x=2 ini_y=2 max_objs=99 enems_life=2 > nul

..\..\..\src\utils\apultra ..\bin\level0.bin ..\bin\level0c.bin > nul
..\..\..\src\utils\apultra ..\bin\level1.bin ..\bin\level1c.bin > nul

del ..\bin\level?.bin  > nul

echo Making music
cd ..\mus
..\..\..\src\utils\pasmo WYZproPlay47aZXc.ASM ..\bin\RAM1.bin
cd ..\dev

echo DONE
..\..\..\src\utils\printsize ..\bin\RAM1.bin
..\..\..\src\utils\printsize ..\bin\RAM3.bin