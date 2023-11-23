// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

_gp_gen = 0;

if (flags[1] == 10) flags[2] = 1;

switch (n_pant) {
    case 24:
        _gp_gen = (unsigned char *) (decos_24);
        break;
}

if (_gp_gen) draw_decorations ();