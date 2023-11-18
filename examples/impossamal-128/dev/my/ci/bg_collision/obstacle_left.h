// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

rebound = COLL_HORZ;

break_horizontal ();

if (p_vx < 0) p_vx = -p_vx;
else
	// This is a trick to override the standard p_vx = 0

