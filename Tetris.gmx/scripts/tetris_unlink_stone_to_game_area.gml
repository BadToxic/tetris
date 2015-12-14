/// tetris_unlink_stone_to_game_area(stone_instance);
// Removed stone references from the game area array.
// by BadToxic

var stone_instance;

stone_instance = argument0;

var xx = (stone_instance.x - border_left) div stone_size;
var yy = (stone_instance.y - border_top)  div stone_size;


for (var parts_yy = stone_instance.border_top; parts_yy < stone_instance.border_bottom; parts_yy++) {
    for (var parts_xx = stone_instance.border_left; parts_xx < stone_instance.border_right; parts_xx++) {
        if (stone_instance.parts[parts_yy, parts_xx]) {
            game_area[yy + parts_yy, xx + parts_xx] = -1;
        }
    }
}
