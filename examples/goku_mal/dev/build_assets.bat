@echo off

if [%1]==[skipscr] goto skipscr

echo Converting Fixed Screens
..\..\..\src\utils\png2scr ..\gfx\title.png ..\bin\title.bin > nul
..\..\..\src\utils\png2scr ..\gfx\marco.png ..\bin\marco.bin > nul
..\..\..\src\utils\png2scr ..\gfx\ending.png ..\bin\ending.bin > nul
..\..\..\src\utils\png2scr ..\gfx\logo.png ..\bin\logo.bin > nul
..\..\..\src\utils\png2scr ..\gfx\dedicado.png ..\bin\dedicado.bin > nul
..\..\..\src\utils\png2scr ..\gfx\controls.png ..\bin\controls.bin > nul
..\..\..\src\utils\png2scr ..\gfx\intro1.png ..\bin\intro1.bin > nul
..\..\..\src\utils\png2scr ..\gfx\intro2.png ..\bin\intro2.bin > nul
..\..\..\src\utils\png2scr ..\gfx\intro3.png ..\bin\intro3.bin > nul
..\..\..\src\utils\png2scr ..\gfx\intro4.png ..\bin\intro4.bin > nul
..\..\..\src\utils\png2scr ..\gfx\intro5.png ..\bin\intro5.bin > nul
..\..\..\src\utils\png2scr ..\gfx\intro6.png ..\bin\intro6.bin > nul
..\..\..\src\utils\png2scr ..\gfx\intro7.png ..\bin\intro7.bin > nul
..\..\..\src\utils\png2scr ..\gfx\zoneA.png ..\bin\zoneA.bin > nul
..\..\..\src\utils\png2scr ..\gfx\zoneB.png ..\bin\zoneB.bin > nul

..\..\..\src\utils\apultra ..\bin\title.bin ..\bin\titlec.bin > nul
..\..\..\src\utils\apultra ..\bin\marco.bin ..\bin\marcoc.bin > nul
..\..\..\src\utils\apultra ..\bin\ending.bin ..\bin\endingc.bin > nul
..\..\..\src\utils\apultra ..\bin\logo.bin ..\bin\logoc.bin > nul
..\..\..\src\utils\apultra ..\bin\dedicado.bin ..\bin\dedicadoc.bin > nul
..\..\..\src\utils\apultra ..\bin\controls.bin ..\bin\controlsc.bin > nul
..\..\..\src\utils\apultra ..\bin\intro1.bin ..\bin\intro1c.bin > nul
..\..\..\src\utils\apultra ..\bin\intro2.bin ..\bin\intro2c.bin > nul
..\..\..\src\utils\apultra ..\bin\intro3.bin ..\bin\intro3c.bin > nul
..\..\..\src\utils\apultra ..\bin\intro4.bin ..\bin\intro4c.bin > nul
..\..\..\src\utils\apultra ..\bin\intro5.bin ..\bin\intro5c.bin > nul
..\..\..\src\utils\apultra ..\bin\intro6.bin ..\bin\intro6c.bin > nul
..\..\..\src\utils\apultra ..\bin\intro7.bin ..\bin\intro7c.bin > nul
..\..\..\src\utils\apultra ..\bin\zoneA.bin ..\bin\zoneAc.bin > nul
..\..\..\src\utils\apultra ..\bin\zoneB.bin ..\bin\zoneBc.bin > nul

del ..\bin\title.bin > nul
del ..\bin\marco.bin > nul
del ..\bin\ending.bin > nul
del ..\bin\logo.bin > nul
del ..\bin\dedicado.bin > nul
del ..\bin\controls.bin > nul
del ..\bin\intro1.bin > nul
del ..\bin\intro2.bin > nul
del ..\bin\intro3.bin > nul
del ..\bin\intro4.bin > nul
del ..\bin\intro5.bin > nul
del ..\bin\intro6.bin > nul
del ..\bin\intro7.bin > nul
del ..\bin\zoneA.bin > nul
del ..\bin\zoneB.bin > nul

:skipscr

echo Converting levels
..\..\..\src\utils\buildlevels_MK1.exe ..\bin\level0.bin mapsize=25 mapfile=..\map\mapa0.MAP map_w=1 map_h=25 fixmappy tilesfile=..\gfx\work0.png behsfile=..\gfx\behs0.txt defaultink=7 spritesfile=..\gfx\sprites0.png enemsfile=..\enems\enems0.ene scr_ini=24 ini_x=2 ini_y=8 max_objs=1 enems_life=2 > nul
..\..\..\src\utils\buildlevels_MK1.exe ..\bin\level1.bin mapsize=25 mapfile=..\map\mapa1.MAP map_w=25 map_h=1 fixmappy tilesfile=..\gfx\work1.png behsfile=..\gfx\behs1.txt defaultink=5 spritesfile=..\gfx\sprites1.png enemsfile=..\enems\enems1.ene scr_ini=0 ini_x=1 ini_y=5 max_objs=1 enems_life=2 > nul
..\..\..\src\utils\buildlevels_MK1.exe ..\bin\level2.bin mapsize=25 mapfile=..\map\mapa2.MAP map_w=25 map_h=1 fixmappy tilesfile=..\gfx\work2.png behsfile=..\gfx\behs2.txt defaultink=0 spritesfile=..\gfx\sprites2.png enemsfile=..\enems\enems2.ene scr_ini=24 ini_x=11 ini_y=5 max_objs=1 enems_life=3 > nul
..\..\..\src\utils\buildlevels_MK1.exe ..\bin\level3.bin mapsize=25 mapfile=..\map\mapa3.MAP map_w=5 map_h=3 fixmappy tilesfile=..\gfx\work3.png behsfile=..\gfx\behs3.txt defaultink=7 spritesfile=..\gfx\sprites3.png enemsfile=..\enems\enems3.ene scr_ini=10 ini_x=2 ini_y=5 max_objs=6 enems_life=3 > nul
..\..\..\src\utils\buildlevels_MK1.exe ..\bin\level4.bin mapsize=25 mapfile=..\map\mapa4.MAP map_w=1 map_h=25 fixmappy tilesfile=..\gfx\work4.png behsfile=..\gfx\behs4.txt defaultink=7 spritesfile=..\gfx\sprites4.png enemsfile=..\enems\enems4.ene scr_ini=0 ini_x=3 ini_y=3 max_objs=1 enems_life=4 > nul

..\..\..\src\utils\apultra ..\bin\level0.bin ..\bin\level0c.bin > nul
..\..\..\src\utils\apultra ..\bin\level1.bin ..\bin\level1c.bin > nul
..\..\..\src\utils\apultra ..\bin\level2.bin ..\bin\level2c.bin > nul
..\..\..\src\utils\apultra ..\bin\level3.bin ..\bin\level3c.bin > nul
..\..\..\src\utils\apultra ..\bin\level4.bin ..\bin\level4c.bin > nul

del ..\bin\level?.bin  > nul

echo Converting more stuff
..\..\..\src\utils\chr2bin ..\gfx\level_screen_ts.png ..\bin\level_screen_ts.bin noattrs > nul
..\..\..\src\utils\apultra ..\bin\level_screen_ts.bin ..\bin\level_screen_tsc.bin > nul

del ..\bin\level_screen_ts.bin > nul 

echo Running The Librarian
..\..\..\src\utils\librarian2.exe list=..\bin\list.txt index=assets\librarian.h bins_prefix=..\bin\ rams_prefix=..\bin\

echo Making music
cd ..\mus
..\..\..\src\utils\pasmo ..\mus\WYZproPlay47aZX.ASM ..\bin\RAM1.bin
cd ..\dev

echo DONE
..\..\..\src\utils\printsize ..\bin\RAM1.bin
..\..\..\src\utils\printsize ..\bin\RAM3.bin
..\..\..\src\utils\printsize ..\bin\RAM4.bin
..\..\..\src\utils\printsize ..\bin\RAM6.bin
