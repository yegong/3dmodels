include <BOSL2/std.scad>

cube([105, 10, 10]) {
    for ( i = [0 : 5] ) {
        position(TOP + FRONT + LEFT) right(i * 20) cube([5, 5, 15], anchor = BOTTOM + FRONT + LEFT);
    }
}