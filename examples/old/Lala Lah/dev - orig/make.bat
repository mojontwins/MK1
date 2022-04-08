@echo off
cd ..\map
mapcnv mapa.map 6 3 15 10 15 packed
copy mapa.h ..\dev
cd ..\dev
zcc +zx -vn lalalah.c -o lalalah.bin -lndos -lsplib2 -zorg=25000
..\utils\bas2tap -a10 -sLALALAH loader.bas loader.tap
..\utils\bin2tap -o screen.tap -a 16384 loading.bin
..\utils\bin2tap -o main.tap -a 25000 lalalah.bin
copy /b loader.tap + screen.tap + main.tap lalalah.tap
del loader.tap
del screen.tap
del main.tap
del lalalah.bin
echo DONE
