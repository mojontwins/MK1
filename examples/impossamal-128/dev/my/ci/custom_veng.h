// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Modify p_vy
// Don't forget to use the veng_selector if VENG_SELECTOR is defined.

if ((pad0 & sp_DOWN) == 0 || (pad0 & sp_FIRE) == 0) {
	if (p_vy < -P_MAX_VY_FRENANDO) p_vy = -P_MAX_VY_FRENANDO;
}

rebound = COLL_NONE;
