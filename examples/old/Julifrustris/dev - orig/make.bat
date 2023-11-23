@echo off
cd ..\map
mapcnv mapa.map 20 2 15 10 15 packed
copy mapa.h ..\dev
cd ..\dev
zcc +zx -vn julifrustris.c -o julifrustris.bin -lndos -lsplib2 -zorg=25000
..\utils\bas2tap -a10 -sJULIFRUS loader.bas loader.tap
..\utils\bin2tap -o screen.tap -a 16384 loading.bin
..\utils\bin2tap -o main.tap -a 25000 julifrustris.bin
copy /b loader.tap + screen.tap + main.tap julifrustris.tap
del loader.tap
del screen.tap
del main.tap
del julifrustris.bin
echo DONE
