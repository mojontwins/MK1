// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

	void blackout_area (void) {
		#asm
			ld  de, 22528 + 32 * VIEWPORT_Y + VIEWPORT_X
			ld  b, 20
		.bal1
			push bc
			ld  h, d 
			ld  l, e
			ld  (hl), 0
			inc de
			ld  bc, 29
			ldir
			inc de
			inc de
			pop bc
			djnz bal1
		#endasm
	}

	void break_horizontal (void) {		
		if (at1 & 16) {
			_x = cx1; _y = cy1; break_wall ();
		} 
		if (cy1 != cy2 && (at2 & 16)) {
			_x = cx1; _y = cy2; break_wall ();
		}
	}

	void break_vertical (void) {			
		if (at1 & 16) {
			_y = cy1; _x = cx1; break_wall ();
		} 
		if (cx1 != cx2 && (at2 & 16)) {
			_y = cy1; _x = cx2; break_wall ();
		}	
	}
	
	void recuadrius (void) {  
    	clear_sprites ();     
    	for (rdi = 0; rdi < 10; rdi ++) {
      		for (rdx = rdi; rdx < 30 - rdi; rdx ++) {
        		#asm
		            // sp_PrintAtInv (VIEWPORT_Y + rdi, VIEWPORT_X + rdx, 71, 0);
		            ld  de, 0x4700
		            ld  a, (_rdx)
		            add VIEWPORT_X
		            ld  c, a
		            ld  a, (_rdi)
		            add VIEWPORT_Y
		            call SPPrintAtInv
		          
		            // sp_PrintAtInv (VIEWPORT_Y + 19 - rdi, VIEWPORT_X + rdx, 71, 0);
		            ld  de, 0x4700
		            ld  a, (_rdx)
		            add VIEWPORT_X
		            ld  c, a
		            ld  a, (_rdi)
		            ld  b, a
		            ld  a, VIEWPORT_Y + 19
		            sub b
		            call SPPrintAtInv
		        #endasm

        		if (rdx < 19 - rdi) {
          			#asm
		              // sp_PrintAtInv (VIEWPORT_Y + rdx, VIEWPORT_X + rdi, 71, 0);
		              ld  de, 0x4700
		              ld  a, (_rdi)
		              add VIEWPORT_X
		              ld  c, a
		              ld  a, (_rdx)
		              add VIEWPORT_Y
		              call SPPrintAtInv

		              // sp_PrintAtInv (VIEWPORT_Y + rdx, VIEWPORT_X + 29 - rdi, 71, 0);
		              ld  de, 0x4700
		              ld  a, (_rdi)
		              ld  b, a
		              ld  a, VIEWPORT_X + 29
		              sub b
		              ld  c, a
		              ld  a, (_rdx)
		              add VIEWPORT_Y              
		              call SPPrintAtInv
		          	#endasm
        		}
      		}
      		#asm
        		halt
       			call SPUpdateNow
      		#endasm
    	}
  	}

	void recuadrius_param (void) {  
    clear_sprites ();     
    for (rdi = 0; rdi < 10; rdi ++) {
      for (rdx = rdi; rdx < 30 - rdi; rdx ++) {
        #asm
            // sp_PrintAtInv (VIEWPORT_Y + rdi, VIEWPORT_X + rdx, 71, 0);
            ld  a, (_rdi)
            and 1 
            jr  z, rpskip1
            ld  a, (_rda)
          .rpskip1
            ld  d, a
            ld  e, 0
            ld  a, (_rdx)
            add VIEWPORT_X
            ld  c, a
            ld  a, (_rdi)
            add VIEWPORT_Y
            call SPPrintAtInv
          
            // sp_PrintAtInv (VIEWPORT_Y + 19 - rdi, VIEWPORT_X + rdx, 71, 0);
            ld  a, (_rdi)
            and 1 
            jr  z, rpskip2
            ld  a, (_rda)
          .rpskip2
            ld  d, a
            ld  e, 0
            ld  a, (_rdx)
            add VIEWPORT_X
            ld  c, a
            ld  a, (_rdi)
            ld  b, a
            ld  a, VIEWPORT_Y + 19
            sub b
            call SPPrintAtInv
        #endasm

        if (rdx < 19 - rdi) {
          #asm
              // sp_PrintAtInv (VIEWPORT_Y + rdx, VIEWPORT_X + rdi, 71, 0);
              ld  a, (_rdi)
              and 1 
              jr  z, rpskip3
              ld  a, (_rda)
            .rpskip3
              ld  d, a
              ld  e, 0
              ld  a, (_rdi)
              add VIEWPORT_X
              ld  c, a
              ld  a, (_rdx)
              add VIEWPORT_Y
              call SPPrintAtInv

              // sp_PrintAtInv (VIEWPORT_Y + rdx, VIEWPORT_X + 29 - rdi, 71, 0);
              ld  a, (_rdi)
              and 1 
              jr  z, rpskip4
              ld  a, (_rda)
            .rpskip4
              ld  d, a
              ld  e, 0
              ld  a, (_rdi)
              ld  b, a
              ld  a, VIEWPORT_X + 29
              sub b
              ld  c, a
              ld  a, (_rdx)
              add VIEWPORT_Y              
              call SPPrintAtInv
          #endasm
        }
      }
      #asm
        halt
        call SPUpdateNow
      #endasm
    }
  }

  void recuadrius_plus (void) {
    // Recuadrius ping
    rda = 8 * 4;
    recuadrius_param ();

    // Recuadrius pong
    rda = 0;
    recuadrius_param ();
  }


