///tetris_duplicate_stone(stone_instance);
// Duplicates a tetris stone
// by BadToxic

var stone_instance, new_stone_instance;

stone_instance = argument0;

new_stone_instance = instance_create(stone_instance.x, stone_instance.y, obj_tetris_stone);

// Copy all values
new_stone_instance.parts = stone_instance.parts;
new_stone_instance.controller = stone_instance.controller;
new_stone_instance.image_blend = stone_instance.image_blend;

new_stone_instance.border_left   = stone_instance.border_left;
new_stone_instance.border_right  = stone_instance.border_right;
new_stone_instance.border_top    = stone_instance.border_top;
new_stone_instance.border_bottom = stone_instance.border_bottom;
new_stone_instance.form = stone_instance.form;
new_stone_instance.parts_number = stone_instance.parts_number;

return new_stone_instance;
