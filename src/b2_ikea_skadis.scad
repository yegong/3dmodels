$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>


cuboid([47, 5, 5], rounding=1, except=[FRONT]) {
    
    position(BACK + LEFT)
    cuboid([5, 15, 5], anchor=BACK + LEFT, rounding=1);
    
    right(10-0.1)
    position(BACK + LEFT)
    cuboid([5, 15, 5], anchor=BACK + LEFT, rounding=1);
    
    position(BACK + RIGHT)
    cuboid([5, 15, 5], anchor=BACK + RIGHT, rounding=1);
    
    left(10-0.1)
    position(BACK + RIGHT)
    cuboid([5, 15, 5], anchor=BACK + RIGHT, rounding=1);
}