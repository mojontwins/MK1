// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

for (gpit = 0; gpit < MAP_W * MAP_H; gpit ++) 
	hotspots [gpit].tipo = hotspots_backup [gpit];

p_inv = 4; 
op_inv = 0;   // Forces update

templos_mataos = puerta_abierta = 0;

_x = 1; _y = 23; _t = 71;
_gp_gen = "ONCE UPON A TIME IN BADAJOZ...";
print_str ();
