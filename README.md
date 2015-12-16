# Tetris
Free to use GameMaker: Studio tetris game.

## Introduction
Tetris is liked to be cloned and imitated, and not least because it is so "simple". The programming, however, is perhaps not as trivial as one might think ... depending on how you implement it.
I'd like to share my version, I made with **GameMaker: Studio** (version 1.4.1657) and explain a little bit to it.

In this repository you will find the entire project, including all images and code.
Overall the game is not necessarily written beginner friendly - we want see how it's done "correctly" for learning, and let's see how it looks like. That is, the code is partly highly optimized and no unnecessary Drag'n'Drop was used. Nevertheless, I have the scripts clearly structured and extensively commented (in English).

Below are listed some individual parts of the game I want to show and explain shortly.

## The Rooms:

In order for a game can be started, there must be at least one room. In Tetris, we have three rooms:
- `room_intro`
- `room_title`
- `room_game`

Relevant is only _room_game_, the others are only prepared for bringing you directly through to the next room, for now.


## The Objects:

|Object|Use|
|-------|--------|
|`obj_all`|Persistent (ubiquitous object), which is to take care of everything that can happen always and in every room.|
|`obj_intro`|An object that is to take care of an intro at the very beginning of the game.|
|`obj_title`|This object is to look at the title screen. From there different game modes should be available to be started.|
|**`obj_tetris_controller`**|The controller is to look after the in-game happenings. It is the centerpiece of the game.|
|**`obj_tetris_stone`**|This embodies a tetris block of any form.|
|`obj_tetris_back`|Helper object for drawing a background.|

## The Scripts:

These are just five of ten scripts, which are used in the game. For the rest you can read the comments in the scripts.

When a new tetris stone is created a random form is passed to it. This script sets a 2D array (matrix) for any of the possible forms that determines which parts of the maximum of 4x4 large stone are set and which are not.
`tetris_set_stone_parts(form)`
```c_cpp
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
```

The following two scripts are called for the currently falling stone when you press the button for a right or left turn. It assigns the set of tetris parts of the above matrix, so that the entire stone is rotated by 90°.
`tetris_stone_turn_right()`
```c_cpp
/// tetris_stone_turn_right();
// Turn tetris stone clockwise
// by BadToxic

var turned;

turned[0, 0] = parts[3, 0]; turned[0, 1] = parts[2, 0]; turned[0, 2] = parts[1, 0]; turned[0, 3] = parts[0, 0];
turned[1, 0] = parts[3, 1]; turned[1, 1] = parts[2, 1]; turned[1, 2] = parts[1, 1]; turned[1, 3] = parts[0, 1];
turned[2, 0] = parts[3, 2]; turned[2, 1] = parts[2, 2]; turned[2, 2] = parts[1, 2]; turned[2, 3] = parts[0, 2];
turned[3, 0] = parts[3, 3]; turned[3, 1] = parts[2, 3]; turned[3, 2] = parts[1, 3]; turned[3, 3] = parts[0, 3];

// Check if the turning is ok - the stone still is in the game area and has no collision with another stone
tetris_stone_turn_check_collision(turned);
```

`tetris_stone_turn_left()`
```c_cpp
/// tetris_stone_turn_left();
// Turn tetris stone counter clockwise
// by BadToxic

var turned;

turned[0, 0] = parts[0, 3]; turned[0, 1] = parts[1, 3]; turned[0, 2] = parts[2, 3]; turned[0, 3] = parts[3, 3];
turned[1, 0] = parts[0, 2]; turned[1, 1] = parts[1, 2]; turned[1, 2] = parts[2, 2]; turned[1, 3] = parts[3, 2];
turned[2, 0] = parts[0, 1]; turned[2, 1] = parts[1, 1]; turned[2, 2] = parts[2, 1]; turned[2, 3] = parts[3, 1];
turned[3, 0] = parts[0, 0]; turned[3, 1] = parts[1, 0]; turned[3, 2] = parts[2, 0]; turned[3, 3] = parts[3, 0];

// Check if the turning is ok - the stone still is in the game area and has no collision with another stone
tetris_stone_turn_check_collision(turned);
```

Once a stone has been moved, you can check with the next script if it collides with another stone. For this all the other stones are checked: do the boundaries of the maximum possible size of 4x4 stone parts overlap? Only if that is the case, the individual stone parts are checked. This approach is very efficient and not necessary with today's computing power... you also can implement this much easier. But as I said - this is supposed to show how make it "right". ;)

`tetris_check_collision()`
```c_cpp
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
```

If a falling stone finally hit the ground or other stones (collide after moving), it can be tested with this script if lines are completed and can be cleared.

`tetris_check_for_clearing(clear_y1, clear_y2)`
```c_cpp
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
```

## The interaction of items:

So now you have learned about the most important parts of the game, but how do they work together? This I also want to keep short:
The object `obj_tetris_controller` is assigned to the room `room_game` in the room editor.
If the game has been started and the room was reached, the controller will take care of everything. For example it  also creates an instance of the `obj_tetris_back` object which is for handling the background.
The controller will now create an `obj_tetris_stone` instance at the top of the screen. Always after a certain time, which is set to a half of a second, or 500,000 microseconds (`fall_time = 500000`) in the create event of the controller, the current stone is moved one square down. This movement takes place in the step event of the controller.
What also happens in this event, is cecking various keystrokes, such as the arrow keys or WASD, to control the stone falling. Depending on what is pressed, the stone is moved to the left, right or down or is rotated by the scripts mentioned above. After each such action it is checked for collision again and if necessary the movement or turning will be reversed, because we do not want overlapping stones.
When a stone strikes down, that means reaching a specific height in the game area, or collides with a stone under it, then its movement is stopped. After this stop it's checked via `tetris_check_for_clearing` for completely filled rows and then a new stone will be generated at the top of the screen.

However, if fully filled lines were found, they will be removed. This process is probably the most complicated one in this program because the matrices of the stones need to be adapted and maybe stones have to be split into several pieces if the mid part(s) of these stones were cleared...
When a new stone was "thrown" in, it is to be checked if there's enough space for it. If there already a collision takes place, the playing field is full and the game therefore is over.


And so the end result looks like. It should be noted that the background was found in a Google search and the font is not by me, either. Everything else can be used freely (it will be nice to have credits to BadToxic, of course ;) ). But errors are also still included in this version - the finder will be allowed to keep them...

I know this tutorial may not be suitable for beginners, but with it you can see how GameMaker works or learn from it if you are already ready for it. ^^
Also, I would have liked it to be able to show and explain a lot more, but unfortunately I do not have the time. But if you have any questions, please feel free to comment using the original blog post's functionality - I'll try to help. :)

FULL LINK WILL FOLLOW - http://dimensionrider.blogspot.de

And at this point I will tell you that I continue with this game and will try to make something nice. ;)
