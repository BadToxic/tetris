/// tetris_check_collision();
// Checks for a collision at the current position
// by BadToxic

with (obj_tetris_stone) {

    if (id != other.id) {

        var in_grid = true;
        
        if (other.x + (controller.stone_grid_size - 1) * controller.stone_size < x) {
            in_grid = false;
        }
        else if (other.x > x + (controller.stone_grid_size - 1) * controller.stone_size) {
            in_grid = false;
        }
        else if (other.y + (controller.stone_grid_size - 1) * controller.stone_size < y) {
            in_grid = false;
        }
        else if (other.y > y + (controller.stone_grid_size - 1) * controller.stone_size) {
            in_grid = false;
        }
        
        // Other stone must be in my grid
        if (in_grid) {
            // Calculate shift of other stone grid to mine
            var x_shift = (x - other.x) div controller.stone_size;
            var y_shift = (y - other.y) div controller.stone_size;
            
            var xx_min = max(0, x_shift);
            var yy_min = max(0, y_shift);
            var xx_max = min(controller.stone_grid_size, x_shift + controller.stone_grid_size);
            var yy_max = min(controller.stone_grid_size, y_shift + controller.stone_grid_size);
            
            // Run through all grid fields of my stone
            for (var yy = yy_min; yy < yy_max; yy++) {
                for (var xx = xx_min; xx < xx_max; xx++) {
                    if (other.parts[yy, xx]) {
                        if (parts[yy - y_shift, xx - x_shift]) {
                            return true;
                        }
                    }
                }
            }
        }
    }
}

return false;
