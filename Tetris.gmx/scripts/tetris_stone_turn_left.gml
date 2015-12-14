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
