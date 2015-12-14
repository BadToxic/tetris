/// string_fill_left(str, char, length);
// Fills a string with the given char ob the left side
// by BadToxic

var str, char, length;

str    = argument0;
char   = argument1;
length = argument2;

while (string_length(str) < length) {
    str = char + str;
}

return str;
