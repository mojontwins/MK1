// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

unsigned char difficulty_level = 0;

const unsigned char jetpac_drain_offset [] = { 10, 8, 4 };
const unsigned char jetpac_drain_ratio [] = { 4, 3, 2 };

const unsigned char fire_drain_amount [] = { 2, 4, 8 };

const unsigned char linear_enemy_hit [] = { 5, 10, 15 };
const unsigned char flying_enemy_hit [] = { 15, 25, 30 };

const unsigned char fanties_sight_distance [] = { 60, 80, 100 };
const unsigned char fanties_life_gauge [] = { 5, 10, 15 };

unsigned char jetpac_counter;

unsigned char _fanties_sight_distance;
unsigned char _fanties_life_gauge;

const unsigned char simple_decorations [] = {
	7, 10, 5, 28,	// Cerrojo
	11, 12, 8, 31, 	// Cámara de recarga
	15, 11, 7, 31, 	// Cámara de recarga
	12, 7, 6, 26, 	// Baldosa papel
	18, 6, 8, 25, 	// Baldosa piedra
	22, 4, 8, 27	// Baldosa tijeras
};

unsigned char hotspots_backup [MAP_W * MAP_H];

unsigned char p_inv, op_inv;

unsigned char templos_mataos;
unsigned char puerta_abierta;
