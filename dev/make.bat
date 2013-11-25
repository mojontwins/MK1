@echo off
rem cd ..\script
rem msc %1.spt msc.h 24
rem copy *.h ..\dev
rem cd ..\dev
cd ..\map
..\utils\mapcnv mapa.map 8 3 15 10 15 packed
copy mapa.h ..\dev
cd ..\dev
zcc +zx -vn %1.c -o %1.bin -lndos -lsplib2 -zorg=25000
..\utils\bas2tap -a10 -sLOADER loader.bas loader.tap
..\utils\bin2tap -o screen.tap -a 16384 loading.bin
..\utils\bin2tap -o main.tap -a 25000 %1.bin
copy /b loader.tap + screen.tap + main.tap %1.tap
del loader.tap
del screen.tap
del main.tap
del %1.bin
echo DONE
