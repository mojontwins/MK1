// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

_x = 4; _y = 20; _t = 71;
_gp_gen = (unsigned char *) ("A EASY  B MEDIUM  C HARD");
print_str ();
sp_UpdateNow ();

difficulty_level = 99; while (difficulty_level == 99) {
	gpit = sp_GetKey ();
	if (gpit > 'Z') gpit -= 32;
	if (gpit >= 'A' && gpit <= 'C') difficulty_level = gpit - 'A';
}

_fanties_sight_distance = fanties_sight_distance [difficulty_level];
_fanties_life_gauge = fanties_life_gauge [difficulty_level];
