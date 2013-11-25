// tilanim.h
// Rutina para animar tiles.

#define MAX_TILANIMS 64;
unsigned char max_tilanims;

typedef struct {
	unsigned char xy;
	unsigned char ft;
} TILANIM;

TILANIM tilanims [MAX_TILANIMS];

void add_tilanim (unsigned char x, unsigned char y, unsigned char t) {
	tilanims [max_tilanims].xy = (x << 4) + y;
	tilanims [max_tilanims].ft = t;
	
	max_tilanims ++;
}

void do_tilanims (void) {
	if (max_tilanims == 0) return;
	
	// Select tile
	gpit = rand () % max_tilanims;
	
	// Flip bit 7:
	tilanims [gpit].ft = tilanims [gpit].ft ^ 128;
	
	// Draw tile
	draw_coloured_tile (
		VIEWPORT_X + (tilanims [gpit].xy >> 4), 
		VIEWPORT_Y + (tilanims [gpit].xy & 15), 
		(tilanims [gpit].ft & 127) + (tilanims [gpit].ft >> 7));
}
