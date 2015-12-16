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
TBD
```

The following two scripts are called for the currently falling stone when you press the button for a right or left turn. It assigns the set of tetris parts of the above matrix, so that the entire stone is rotated by 90°.
`tetris_stone_turn_right()`
```c_cpp
TBD
```

`tetris_stone_turn_left()`
```c_cpp
TBD
```

Once a stone has been moved, you can check with the next script if it collides with another stone. For this all the other stones are checked: do the boundaries of the maximum possible size of 4x4 stone parts overlap? Only if that is the case, the individual stone parts are checked. This approach is very efficient and not necessary with today's computing power... you also can implement this much easier. But as I said - this is supposed to show how make it "right". ;)

`tetris_check_collision()`
```c_cpp
TBD
```

If a falling stone finally hit the ground or other stones (collide after moving), it can be tested with this script if lines are completed and can be cleared.

`tetris_check_for_clearing(clear_y1, clear_y2)`
```c_cpp
TBD
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
