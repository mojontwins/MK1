@echo off
cd ..\map
mapcnv mapa.map 6 5 15 10 15 packed
copy mapa.h ..\dev
cd ..\dev
zcc +zx -vn bootee.c -o bootee.bin -lndos -lsplib2 -zorg=25000
..\utils\bas2tap -a10 -sCHERILBOT loader.bas loader.tap
..\utils\bin2tap -o screen.tap -a 16384 loading.bin
..\utils\bin2tap -o main.tap -a 25000 bootee.bin
copy /b loader.tap + screen.tap + main.tap bootee.tap
del loader.tap
del screen.tap
del main.tap
del bootee.bin
echo DONE
