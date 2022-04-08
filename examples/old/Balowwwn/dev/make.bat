@echo off
cd ..\map
mapcnv mapa.map 5 7 15 10 15 packed
copy mapa.h ..\dev
cd ..\dev
zcc +zx -vn balowwwn.c -o balowwwn.bin -lndos -lsplib2 -zorg=25000
..\utils\bas2tap -a10 -sBALOWWWN loader.bas loader.tap
..\utils\bin2tap -o screen.tap -a 16384 loading.bin
..\utils\bin2tap -o main.tap -a 25000 balowwwn.bin
copy /b loader.tap + screen.tap + main.tap balowwwn.tap
del loader.tap
del screen.tap
del main.tap
del balowwwn.bin
echo DONE
