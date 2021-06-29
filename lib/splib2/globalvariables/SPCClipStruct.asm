
INCLUDE "SPconfig.def"

XLIB SPCClipStruct

.SPCClipStruct
   defb 0, 0, SP_ROWEND-SP_ROWSTART
IF DISP_HIRES
   defb 64
ELSE
   defb 32
ENDIF
