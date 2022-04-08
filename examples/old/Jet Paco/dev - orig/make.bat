@echo off
cd ..\map
mapcnv mapa.map 7 5 15 10 15 packed
copy mapa.h ..\dev
cd ..\dev
zcc +zx -vn jetpaco.c -o jetpaco.bin -lndos -lsplib2 -zorg=25000
..\utils\bas2tap -a10 -sJETPACO loader.bas loader.tap
..\utils\bin2tap -o screen.tap -a 16384 loading.bin
..\utils\bin2tap -o main.tap -a 25000 jetpaco.bin
copy /b loader.tap + screen.tap + main.tap jetpaco.tap
del loader.tap
del screen.tap
del main.tap
del jetpaco.bin
echo DONE
