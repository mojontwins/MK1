@echo off
del ..\bin\*.bin

echo Making tilesets
..\..\..\src\utils\ts2bin.exe nofont ..\gfx\work0.png ..\bin\tileset0.bin 7 >nul
..\..\..\src\utils\ts2bin.exe nofont ..\gfx\work1.png ..\bin\tileset1.bin 7 >nul
..\..\..\src\utils\ts2bin.exe nofont ..\gfx\work2.png ..\bin\tileset2.bin 7 >nul

..\..\..\src\utils\apultra.exe ..\bin\tileset0.bin ..\bin\tileset0c.bin >nul
..\..\..\src\utils\apultra.exe ..\bin\tileset1.bin ..\bin\tileset1c.bin >nul
..\..\..\src\utils\apultra.exe ..\bin\tileset2.bin ..\bin\tileset2c.bin >nul

del ..\bin\tileset?.bin > nul

echo Converting maps
..\..\..\src\utils\mapcnvbin.exe ..\map\mapa0.map ..\bin\mapa_bolts0.bin 1 24 15 10 15 packed fixmappy >nul
..\..\..\src\utils\mapcnvbin.exe ..\map\mapa1.map ..\bin\mapa_bolts1.bin 1 24 15 10 15 packed fixmappy >nul
..\..\..\src\utils\mapcnvbin.exe ..\map\mapa2.map ..\bin\mapa_bolts2.bin 1 24 15 10 15 packed fixmappy >nul

..\..\..\src\utils\apultra.exe ..\bin\mapa_bolts0.bin ..\bin\mapa_bolts0c.bin >nul
..\..\..\src\utils\apultra.exe ..\bin\mapa_bolts1.bin ..\bin\mapa_bolts1c.bin >nul
..\..\..\src\utils\apultra.exe ..\bin\mapa_bolts2.bin ..\bin\mapa_bolts2c.bin >nul

del ..\bin\mapa_bolts?.bin >nul
