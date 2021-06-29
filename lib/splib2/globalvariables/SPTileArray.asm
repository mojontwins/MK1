
INCLUDE "SPconfig.def"

XLIB SPTileArray

.SPTileArray
   defs 512            ; LSB Tile Graphic, MSB Tile Graphic
IF DISP_HICOLOUR
   defs 512            ; LSB Tile Pallette, MSB Tile Pallette
ENDIF
