include <BOSL2/std.scad>

$fn= $preview ? 32 : 64;

width = 12;

module power() {
    cube([140, width, 1]) {
        position(TOP+LEFT)
        cube([1, width, 10], anchor = TOP + RIGHT);
        
        position(TOP+RIGHT)
        cube([1, width, 10], anchor = TOP + LEFT);
    }
}

power();