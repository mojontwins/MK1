// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

if (p_jetpac_on) {
	if (jetpac_counter) -- jetpac_counter; else {
		jetpac_counter = jetpac_drain_ratio [difficulty_level];
		player_deplete ();
	}
} else jetpac_counter = jetpac_drain_offset [difficulty_level];
