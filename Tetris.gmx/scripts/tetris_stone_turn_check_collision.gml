/// tetris_stone_turn_check_collision(turned_grid);
// Check if the turning is ok - the stone still is in the game area and has no collision with another stone
// by BadToxic

var turned, tmp;

turned = argument0; // The turned grid

tmp = parts;
parts = turned;

if (tetris_check_collision()) {
    // Not enough room to turn the stone -> turn it back
    parts = tmp;
}
else {
    // Calculate the indices of the fields in the parts grid (array)
    var border_left_tmp   = border_left;
    var border_right_tmp  = border_right;
    var border_bottom_tmp = border_bottom;
    tetris_calculate_stone_borders();
    
    var outside_game_area = false;
    if (x + border_left * controller.stone_size < controller.border_left) {
        outside_game_area = true;
    }
    else if (x + border_right * controller.stone_size > controller.border_right) {
        outside_game_area = true;
    }
    else if (y + border_bottom * controller.stone_size > controller.border_bottom) {
        outside_game_area = true;
    }
    if (outside_game_area) {
        // Not allowed to turn the stone over the game areas -> turn is back and set the border indices back
        border_left   = border_left_tmp;
        border_right  = border_right_tmp;
        border_bottom = border_bottom_tmp;
        parts = tmp;
    }
}
