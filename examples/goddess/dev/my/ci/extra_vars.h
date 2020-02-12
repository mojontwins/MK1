// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

unsigned char difficulty_level = 0;

const unsigned char jetpac_drain_offset [] = { 10, 8, 4 };
const unsigned char jetpac_drain_ratio [] = { 4, 3, 2 };

const unsigned char fire_drain_amount [] = { 2, 4, 8 };

const unsigned char linear_enemy_hit [] = { 5, 10, 15 };
const unsigned char flying_enemy_hit [] = { 15, 25, 30 };

const unsigned char fanties_sight_distance [] = { 5, 10, 15 };
const unsigned char fanties_life_gauge [] = { 15, 25, 30 };

unsigned char jetpac_counter;

unsigned char _fanties_sight_distance;
unsigned char _fanties_life_gauge;

unsigned char hotspots_backup [MAP_W * MAP_H];

unsigned char p_inv, op_inv;
