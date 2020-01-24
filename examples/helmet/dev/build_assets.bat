@echo off
rem del  ..\bin\*.bin

echo Making tilesets
..\..\..\src\utils\ts2bin.exe nofont ..\gfx\work0.png ..\bin\tileset0.bin 7 >nul
..\..\..\src\utils\ts2bin.exe nofont ..\gfx\work1.png ..\bin\tileset1.bin 7 >nul
..\..\..\src\utils\ts2bin.exe nofont ..\gfx\work2.png ..\bin\tileset2.bin 7 >nul

..\..\..\src\utils\apultra.exe ..\bin\tileset0.bin ..\bin\tileset0c.bin >nul
..\..\..\src\utils\apultra.exe ..\bin\tileset1.bin ..\bin\tileset1c.bin >nul
..\..\..\src\utils\apultra.exe ..\bin\tileset2.bin ..\bin\tileset2c.bin >nul

rem del  ..\bin\tileset?.bin > nul

echo Converting maps
..\..\..\src\utils\mapcnvbin.exe ..\map\mapa0.map ..\bin\mapa_bolts0.bin 1 24 15 10 15 packed fixmappy >nul
..\..\..\src\utils\mapcnvbin.exe ..\map\mapa1.map ..\bin\mapa_bolts1.bin 1 24 15 10 15 packed fixmappy >nul
..\..\..\src\utils\mapcnvbin.exe ..\map\mapa2.map ..\bin\mapa_bolts2.bin 1 24 15 10 15 packed fixmappy >nul

..\..\..\src\utils\apultra.exe ..\bin\mapa_bolts0.bin ..\bin\mapa_bolts0c.bin >nul
..\..\..\src\utils\apultra.exe ..\bin\mapa_bolts1.bin ..\bin\mapa_bolts1c.bin >nul
..\..\..\src\utils\apultra.exe ..\bin\mapa_bolts2.bin ..\bin\mapa_bolts2c.bin >nul

rem del  ..\bin\mapa_bolts?.bin >nul

echo Converting enems
..\..\..\src\utils\ene2bin_mk1.exe ..\enems\enems0.ene ..\bin\enems_hotspots0.bin 2 >nul
..\..\..\src\utils\ene2bin_mk1.exe ..\enems\enems1.ene ..\bin\enems_hotspots1.bin 2 >nul
..\..\..\src\utils\ene2bin_mk1.exe ..\enems\enems2.ene ..\bin\enems_hotspots2.bin 2 >nul

..\..\..\src\utils\apultra.exe ..\bin\enems_hotspots0.bin ..\bin\enems_hotspots0c.bin >nul
..\..\..\src\utils\apultra.exe ..\bin\enems_hotspots1.bin ..\bin\enems_hotspots1c.bin >nul
..\..\..\src\utils\apultra.exe ..\bin\enems_hotspots2.bin ..\bin\enems_hotspots2c.bin >nul

rem del  ..\bin\enems_hotspots?.bin

echo Converting behs
..\..\..\src\utils\behs2bin.exe ..\gfx\behs0_1.txt ..\bin\behs0_1.bin >nul
..\..\..\src\utils\behs2bin.exe ..\gfx\behs2.txt ..\bin\behs2.bin >nul

..\..\..\src\utils\apultra.exe ..\bin\behs0_1.bin ..\bin\behs0_1c.bin >nul
..\..\..\src\utils\apultra.exe ..\bin\behs2.bin ..\bin\behs2c.bin >nul

rem del  ..\bin\behs0_1.bin
rem del  ..\bin\behs2.bin

echo Done!!
