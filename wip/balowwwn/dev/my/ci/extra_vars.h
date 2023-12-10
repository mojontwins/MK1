// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

unsigned char *c_screen_address;			// Current screen address in map array
unsigned char *restore_table_ptr = 0xde00; 	// Pointer to the restore table 

// These LUTs make my life easier when it's time to restore the map

unsigned char tile_restore_lut [] = {
	0xff, 0x00, 0xff, 0xff, 
	0xff, 0xff, 0x01, 0xff, 
	0xff, 0xff, 0xff, 0xff, 
	0xff, 0xff, 0x03, 0xff
};

unsigned char tile_restore_reverse_lut [] = {
	0x01, 0x06, 0x0e
};
