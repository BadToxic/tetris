/// tetris_check_for_clearing(clear_y1, clear_y2);
// This script is called after a stone was placed and checks for lines that can be cleared
// by BadToxic

var clear_y1 = /*max(       0, */argument0;
var clear_y2 = /*min(fields_y, */argument1;

var lines_to_clear = ds_list_create();

// Check for lines
for (var yy = clear_y1; yy < clear_y2; yy++) {
    var clear_line = true;
    for (var xx = 0; xx < fields_x; xx++) {
        if (game_area[yy, xx] < 0) {
            // In this line is a gap - skip it
            xx = fields_x;
            clear_line = false;
        }
    }
    if (clear_line) { // Remember this line to clear
        ds_list_add(lines_to_clear, yy);
    }
}


// Clear found lines
if (!ds_list_empty(lines_to_clear)) {
    fix_bottoms = ds_list_create();
    
    switch (ds_list_size(lines_to_clear)) {
        case 1: {
            score += global.SCORE_LINES_CLEARED_1;
            break;
        }
        case 2: {
            score += global.SCORE_LINES_CLEARED_2;
            break;
        }
        case 3: {
            score += global.SCORE_LINES_CLEARED_3;
            break;
        }
        case 4: {
            score += global.SCORE_LINES_CLEARED_4;
        }
    }
    
    while (!ds_list_empty(lines_to_clear)) {
        var yy = ds_list_find_value(lines_to_clear, 0);
        for (var xx = 0; xx < fields_x; xx++) {
            //if (game_area[yy, xx] >= 0) {
                var stone_instance = game_area[yy, xx];
                
                var parts_index_y = yy - (stone_instance.y - border_top) div stone_size;
                var parts_index_x = xx - (stone_instance.x - border_left) div stone_size;
                
                stone_instance.parts[parts_index_y, parts_index_x] = 0;
                stone_instance.parts_number--;
                if (stone_instance.parts_number <= 0) {
                    with (stone_instance) {
                        instance_destroy();
                    }
                }
                else {
                    if (stone_instance.border_top == parts_index_y) {
                        stone_instance.border_top++;
                    }
                    else if (stone_instance.border_bottom > parts_index_y + 1) {  // Stone has to be divided
                        // Duplicate stone
                        var new_stone_instance = tetris_duplicate_stone(stone_instance);
                        
                        // Delete all parts of new stone above the cleared line
                        for (var yyy = 0; yyy <= parts_index_y; yyy++) {
                            for (var xxx = 0; xxx < stone_grid_size; xxx++) {
                                new_stone_instance.parts[yyy, xxx] = 0;
                            }
                        }
                        new_stone_instance.border_top = parts_index_y + 1;
                        
                        // Refresh game area array references for the new stone
                        tetris_link_stone_to_game_area(new_stone_instance);
                        
                        // Delete all parts of old stone underneath the cleared line
                        for (var yyy = parts_index_y + 1; yyy < stone_grid_size; yyy++) {
                            for (var xxx = 0; xxx < stone_grid_size; xxx++) {
                                stone_instance.parts[yyy, xxx] = 0;
                            }
                        }
                        
                        // Refresh game area array references for the old stone
                        tetris_link_stone_to_game_area(stone_instance);
                        
                        stone_instance.border_bottom = parts_index_y + 1;   // Don't divide the same stone two times in a row
                    }
                    if (stone_instance.border_bottom > parts_index_y) {  // Stone needs a bottom border correction
                        // Only add it, if not already included
                        if (ds_list_find_index(fix_bottoms, stone_instance) < 0) {
                            ds_list_add(fix_bottoms, stone_instance);
                        }
                    }
                }
                game_area[yy, xx] = -1;
            //}
        }
        ds_list_delete(lines_to_clear, 0);
        
        // Fix bottom borders of divided stones
        for (var stone_index = 0; stone_index < ds_list_size(fix_bottoms); stone_index++) {
            var stone_instance = ds_list_find_value(fix_bottoms, stone_index);
            if (instance_exists(stone_instance)) { // Could already be deleted
                var parts_index_y = yy - (stone_instance.y - border_top) div stone_size;
                stone_instance.border_bottom = parts_index_y;
            }
        }
        ds_list_clear(fix_bottoms);
    }
    
    // Clean up the lists memory
    ds_list_destroy(lines_to_clear);
    ds_list_destroy(fix_bottoms);
    
    // Now remember all stones above the cleared line(s) to let them fall later // TODO:  AND BELOW also stone parts may need to fall
    ds_list_clear(falling_stones);
    
    for (var yy = clear_y2 - 2; yy >= 0; yy--) {
        for (var xx = 0; xx < fields_x; xx++) {
            if (game_area[yy, xx] >= 0) {
                // Only add it, if not already included
                if (ds_list_find_index(falling_stones, game_area[yy, xx]) < 0) {
                    ds_list_add(falling_stones, game_area[yy, xx]);
                }
            }
        }
    }
}
