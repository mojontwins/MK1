// tilanim.h
// Rutina para animar tiles.

#define MAX_TILANIMS 64
#define UPDATE_FREQ 7
unsigned char max_tilanims;
unsigned char tacount;

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

unsigned char tait;
void do_tilanims (void) {
	if (max_tilanims == 0) return;
	
	tacount = (tacount + 1) & UPDATE_FREQ;
	if (!tacount) {
		// Select tile
		tait = rand () % max_tilanims;
		
		// Flip bit 7:
		tilanims [tait].ft = tilanims [tait].ft ^ 128;
		
		// Draw tile
		draw_coloured_tile (
			VIEWPORT_X + ((tilanims [tait].xy >> 4) << 1), 
			VIEWPORT_Y + ((tilanims [tait].xy & 15) << 1), 
			(tilanims [tait].ft & 127) + (tilanims [tait].ft >> 7));
	}
}
