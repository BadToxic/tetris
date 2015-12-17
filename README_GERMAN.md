# Tetris
Frei nutzbares _GameMaker: Studio_ _Tetris_-Spiel.

## Einleitung

Tetris wird gerne geklont und nachgeahmt und das nicht zuletzt weil es so "simpel" ist. Die Programmierung hingegen, ist vielleicht nicht so trivial, wie man denken mag... je nachdem wie man es umsetzt.
Ich möchte hier meine Version, welche ich mit dem **GameMaker: Studio** (in der Version 1.4.1657) erstellt habe teilen und ein wenig dazu erklären.

In diesem Repository findet ihr das komplette Projekt inklusive Bildern und allem Code.
Insgesamt ist das Spiel nicht unbedingt anfängerfreundlich geschrieben - wir wollen es ja gleich "richtig" lernen, bzw. mal sehen, wie soetwas aussehen kann. Das heißt, der Code ist teilweise stark optimiert und es wurde kein unnötiges Drag'n'Drop verwendet. Trotzdem habe ich die Skripte übersichtlich strukturiert und umfangreich kommentiert (allerdings auf Englisch).

Im Folgenden möchte ich genauer auf die Einzelteile des Spiels eingehen und minimal erläutern.

## Die Räume:

Damit ein Spiel gestartet werden kann, muss mindestens ein Raum existieren. In Tetris haben wir drei Räume:
- `room_intro`
- `room_title`
- `room_game`

Relevant ist nur der _room_game_, die anderen sind nur schon mal vorbereitet und reichen direkt durch zum jeweils nächsten Raum.


## Die Objekte:

|Object|Use|
|-------|--------|
|`obj_all`|Persistentes (allgegenwärtiges Objekt), welches sich um alles kümmern soll, das immer und in jedem Raum passieren kann.|
|`obj_intro`|Ein Objekt das sich um ein Intro ganz zu Beginn des Spiels kümmern wird.|
|`obj_title`|Dieses Objekt soll sich um den Titelbildschirm kümmern. Von dort aus sollen z.B. verschiedene Spiel-Modi gestartet werden können.|
|**`obj_tetris_controller`**|Der Kontroller soll sich um das in-game Spielgeschehen kümmern. Er ist das Herzstück des Spiels.|
|**`obj_tetris_stone`**|Dies verkörpert einen Tetrisstein einer beliebigen Form.|
|`obj_tetris_back`|Hilfsobjekt zum Zeichnen eines Hintergrundes.|

## Die Skripte:

Dies sind nur fünf von zehn Skripten, die in dem Spiel Verwendung finden. Für die Restlichen könnt ihr in das angehängte Archiv schauen.

Wenn ein neuer Tetris-Stein erstellt wird, wird ihm eine zufällige Form übergeben. Folgendes Skript legt für eine beliebige der möglichen Formen ein 2D-Array (eine Matrix) an, welches bestimmt, welche Stein-Teile des maximal 4x4 großen Steines gesetzt sind und welche nicht.
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

Die folgenden beiden Skripte werden für den aktuell fallenden Stein aufgerufen, wenn man die Taste für eine Rechts- bzw. Linksdrehung drückt. Sie ordnen die gesetzten Tetris-Teile der oben genannten Matrix so um, dass der gesamte Stein um 90° gedreht wird.
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

Nachdem ein Stein bewegt wurde, kann mit dem nächsten Skript geprüft werden, ob er mit einem anderen Stein kollidiert. Dabei werden alle anderen Steine betrachtet und zunächst geprüft, ob sich die Bereiche der maximal möglichen Größe von 4x4 Stein-Teilen überlagern. Erst wenn das der Fall ist, werden auch die einzelnen Stein-Teile geprüft. Dieses Vorgehen ist sehr effizient und bei heutiger Rechenleistung nicht nötig... man könnte dies auch sehr viel einfacher umsetzen. Aber wie gesagt - dies soll zeigen wie man es "richtig" macht. ;)
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

Wenn ein fallender Stein schließlich aufgeschlagen ist, also nach einer Bewegung kollidiert ist, kann mit diesem Skript geprüft werden, ob Zeilen vollständig ausgefüllt sind und somit also aufgelöst werden können.
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

## Das Zusammenspielen der Einzelteile:

So, jetzt habt ihr die wichtigsten Bausteine des Spiels kennengelernt, doch wie hängen diese zusammen? Auch dies möchte ich nur minimalistisch ansprechen:
Der Raum `room_game` bekommt das Objekt `obj_tetris_controller` im Raum-Editor zugewiesen.
Wenn das Spiel nun gestartet wurde und man den Raum erreicht hat, wird sich dieser Kontroller um alles kümmern. Er erstellt z.B. auch eine Instanz des `obj_tetris_back` Objektes, welches sich um den Hintergrund kümmern soll.
Der Kontroller erstellt nun eine `obj_tetris_stone` Instanz am oberen Bildschirmrand. Immer nach einer bestimmten Zeit, welche im Create-Event des Controllers auf eine halbe Sekunde, bzw. 500000 Mikrosekunden festgelegt wurde (`fall_time = 500000`), wird der aktuelle Stein ein Feld nach unten bewegt. Diese Bewegung findet im Step-Event des Kontrollers statt.
Was in diesem Event ebenfalls noch passiert, ist die Überprüfung auf verschiedene Tastendrücke, wie etwa den Pfeiltasten oder WASD, zum Steuern des fallenden Steines. Je nachdem, was gedrückt wird, wird der Stein nach links, rechts oder unten verschoben, bzw. mit Hilfe der obigen Skripte gedreht. Nach einer jeden solchen Aktion wird erneut auf Kollision geprüft und die Aktion ggf. rückgängig gemacht, denn wir wollen ja nicht dass Steine sich überlagern.
Wenn ein Stein unten aufschlägt, also eine gewisse Höhe auf dem Spielfeld erreicht hat, oder mit einem Stein unter sich kollidiert, dann wird seine Bewegung gestoppt. Nach diesem Stopp wird via `tetris_check_for_clearing` auf auflösbare Zeilen geprüft und danach ein neuer Stein am oberen Bildschirmrand generiert. Wurden allerdings voll ausgefüllte Zeilen gefunden, so werden diese entfernt. Dieser Vorgang ist vermutlich der komplizierteste in diesem Programm, da hierfür die Matrizen der Steine angepasst werden müssen und evtl. sogar ein Stein in mehrere Steine gespalten werden muss, weil vielleicht nur seine Mitte aufgelöst wurde...
Wenn ein neuer Stein "eingeworfen" wird, muss geprüft werden, ob er dafür auch genügend Platz hat. Wenn bereits hier eine Kollision stattfindet, ist das Spielfeld voll und das Spiel somit vorbei.

Es bleibt anzumerken, dass der Hintergrund bei einer Google-Suche gefunden wurde und auch die Schriftart nicht von mir ist. Alles andere darf gerne frei verwendet werden (gerne natürlich auch mit Credits an BadToxic ;) ). Aber auch Fehler sind in dieser Version noch enthalten - der Finder darf sie gerne behalten...

Ich weiß, dieses Tutorial ist nicht unbedingt für Einsteiger geeignet, aber man kann damit doch ganz schön sehen, wie der GameMaker funktioniert oder davon lernen wenn man schon dafür bereit ist. ^^
Auch hätte ich noch sehr viel zeigen und erklären können, doch leider fehlt mir dazu die Zeit. Doch wenn ihr Fragen habt, nutzt gerne die Kommentarfunktion des originalen Blog-Posts - ich werde versuchen zu helfen. :)

DIREKTLINK FOLGT - http://dimensionrider.blogspot.de

Und an dieser Stelle verrate ich noch, dass ich auch an dem Spiel weiter mache und versuche etwas schönes auf die Beine zu stellen. ;)
