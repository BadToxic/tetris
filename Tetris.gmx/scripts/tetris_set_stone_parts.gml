/// tetris_set_stone_parts(form);
// Initializes the parts array of a tetris stone to the given form enum
// by BadToxic

var form_enum = argument0;

parts[3, 3] = 0;

switch (form_enum) {
    case global.TETRIS_FORM_T: {
        parts[0, 0] = 0; parts[0, 1] = 0; parts[0, 2] = 0; parts[0, 3] = 0;
        parts[1, 0] = 0; parts[1, 1] = 1; parts[1, 2] = 0; parts[1, 3] = 0;
        parts[2, 0] = 1; parts[2, 1] = 1; parts[2, 2] = 1; parts[2, 3] = 0;
        parts[3, 0] = 0; parts[3, 1] = 0; parts[3, 2] = 0; parts[3, 3] = 0;
        break;
    }
    case global.TETRIS_FORM_I: {
        parts[0, 0] = 0; parts[0, 1] = 1; parts[0, 2] = 0; parts[0, 3] = 0;
        parts[1, 0] = 0; parts[1, 1] = 1; parts[1, 2] = 0; parts[1, 3] = 0;
        parts[2, 0] = 0; parts[2, 1] = 1; parts[2, 2] = 0; parts[2, 3] = 0;
        parts[3, 0] = 0; parts[3, 1] = 1; parts[3, 2] = 0; parts[3, 3] = 0;
        break;
    }
    case global.TETRIS_FORM_Z: {
        parts[0, 0] = 0; parts[0, 1] = 0; parts[0, 2] = 0; parts[0, 3] = 0;
        parts[1, 0] = 1; parts[1, 1] = 1; parts[1, 2] = 0; parts[1, 3] = 0;
        parts[2, 0] = 0; parts[2, 1] = 1; parts[2, 2] = 1; parts[2, 3] = 0;
        parts[3, 0] = 0; parts[3, 1] = 0; parts[3, 2] = 0; parts[3, 3] = 0;
        break;
    }
    case global.TETRIS_FORM_S: {
        parts[0, 0] = 0; parts[0, 1] = 0; parts[0, 2] = 0; parts[0, 3] = 0;
        parts[1, 0] = 0; parts[1, 1] = 1; parts[1, 2] = 1; parts[1, 3] = 0;
        parts[2, 0] = 1; parts[2, 1] = 1; parts[2, 2] = 0; parts[2, 3] = 0;
        parts[3, 0] = 0; parts[3, 1] = 0; parts[3, 2] = 0; parts[3, 3] = 0;
        break;
    }
    case global.TETRIS_FORM_Q: {
        parts[0, 0] = 0; parts[0, 1] = 0; parts[0, 2] = 0; parts[0, 3] = 0;
        parts[1, 0] = 0; parts[1, 1] = 1; parts[1, 2] = 1; parts[1, 3] = 0;
        parts[2, 0] = 0; parts[2, 1] = 1; parts[2, 2] = 1; parts[2, 3] = 0;
        parts[3, 0] = 0; parts[3, 1] = 0; parts[3, 2] = 0; parts[3, 3] = 0;
        break;
    }
    case global.TETRIS_FORM_L: {
        parts[0, 0] = 0; parts[0, 1] = 0; parts[0, 2] = 0; parts[0, 3] = 0;
        parts[1, 0] = 0; parts[1, 1] = 1; parts[1, 2] = 0; parts[1, 3] = 0;
        parts[2, 0] = 0; parts[2, 1] = 1; parts[2, 2] = 0; parts[2, 3] = 0;
        parts[3, 0] = 0; parts[3, 1] = 1; parts[3, 2] = 1; parts[3, 3] = 0;
        break;
    }
    case global.TETRIS_FORM_J: {
        parts[0, 0] = 0; parts[0, 1] = 0; parts[0, 2] = 0; parts[0, 3] = 0;
        parts[1, 0] = 0; parts[1, 1] = 0; parts[1, 2] = 1; parts[1, 3] = 0;
        parts[2, 0] = 0; parts[2, 1] = 0; parts[2, 2] = 1; parts[2, 3] = 0;
        parts[3, 0] = 0; parts[3, 1] = 1; parts[3, 2] = 1; parts[3, 3] = 0;
        break;
    }
}

// Count the parts
parts_number = 0;
for (var yy = 0; yy < array_height_2d(parts); yy++) {
    for (var xx = 0; xx < array_length_2d(parts, yy); xx++) {
        if (parts[yy, xx]) {
            parts_number++;
        }
    }
}
