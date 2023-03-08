@echo off
echo ******************************************************************************
echo BUILDING LEVEL 1
echo ******************************************************************************
copy ..\map\mapa1.map
copy ..\gfx\work1.png
copy ..\gfx\sprites1.png
copy ..\enems\enems1.ene
..\utils\buildlevel.exe mapa1.map 1 25 99 font.png work1.png sprites1.png extrasprites.bin enems1.ene 24 2 7 99 3 behs1.txt level1.bin
del mapa1.map
del work1.png
del sprites1.png
del enems1.ene
echo .
echo ******************************************************************************
echo BUILDING LEVEL 2
echo ******************************************************************************
copy ..\map\mapa2.map
copy ..\gfx\work2.png
copy ..\gfx\sprites2.png
copy ..\enems\enems2.ene
..\utils\buildlevel.exe mapa2.map 25 1 99 font.png work2.png sprites2.png extrasprites.bin enems2.ene 0 4 1 99 4 behs2.txt level2.bin
del mapa2.map
del work2.png
del sprites2.png
del enems2.ene
echo .
echo ******************************************************************************
echo BUILDING LEVEL 3
echo ******************************************************************************
copy ..\map\mapa3.map
copy ..\gfx\work3.png
copy ..\gfx\sprites3.png
copy ..\enems\enems3.ene
..\utils\buildlevel.exe mapa3.map 25 1 99 font.png work3.png sprites3.png extrasprites.bin enems3.ene 24 12 1 99 5 behs3.txt level3.bin
del mapa3.map
del work3.png
del sprites3.png
del enems3.ene
echo .
echo ******************************************************************************
echo BUILDING LEVEL 4
echo ******************************************************************************
copy ..\map\mapa4.map
copy ..\gfx\work4.png
copy ..\gfx\sprites4.png
copy ..\enems\enems4.ene
..\utils\buildlevel.exe mapa4.map 1 25 99 font.png work4.png sprites4.png extrasprites.bin enems4.ene 0 4 1 99 5 behs4.txt level4.bin
del mapa4.map
del work4.png
del sprites4.png
del enems4.ene
echo .
echo ******************************************************************************
echo BUILDING LEVEL 5
echo ******************************************************************************
copy ..\map\mapa5.map
copy ..\gfx\work5.png
copy ..\gfx\sprites5.png
copy ..\enems\enems5.ene
..\utils\buildlevel.exe mapa5.map 5 5 99 font.png work5.png sprites5.png extrasprites.bin enems5.ene 10 1 7 6 5 behs5.txt level5.bin
del mapa5.map
del work5.png
del sprites5.png
del enems5.ene
echo .
echo ******************************************************************************
echo BUILDING DONE
echo ******************************************************************************