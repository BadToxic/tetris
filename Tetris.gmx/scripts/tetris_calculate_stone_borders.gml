/// tetris_calculate_stone_borders();
// Calculates the indices of the fields in the parts grid (array) of a stone for collisions with the game area borders
// by BadToxic

border_left   = controller.stone_grid_size;
border_right  = 0;
border_top    = controller.stone_grid_size;
border_bottom = 0;

for (var yy = 0; yy < controller.stone_grid_size; yy++) {
    for (var xx = 0; xx < controller.stone_grid_size; xx++) {
        if (parts[yy, xx]) {
            border_left   = min(border_left,   xx);
            border_right  = max(border_right,  xx);
            border_top    = min(border_top,    yy);
            border_bottom = max(border_bottom, yy);
        }
    }
}

border_right++;
border_bottom++;
