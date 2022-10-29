include <BOSL2/std.scad>

$fs = 0.1;
$fa = 3;

d = 29;
h = 18;

th = 2;

diff("remove", "keep") {
    cuboid([41, d + 2*th, h+th], anchor = BOTTOM + LEFT) {
        tag("remove") position(BOTTOM + RIGHT) cube([22, 18.5, h], anchor = BOTTOM + RIGHT);
        tag("remove") position(TOP + RIGHT) left(13)
            cube([6, 2, 2], anchor = TOP + RIGHT);
        
        tag("remove") position(BOTTOM + LEFT) cube([19, 15, h], anchor = BOTTOM + LEFT);
        tag("remove") position(TOP + LEFT) right(5.5)
            cube([3, 3, 2], anchor = TOP + LEFT);
        
        tag("keep") position(TOP + RIGHT + FRONT) cube([29, 2, 12.5], anchor = BOTTOM + RIGHT + FRONT)
            tag("keep") position(TOP + BACK) cube([29, 5, 1], anchor = TOP + FRONT);
        
        tag("keep") position(TOP + RIGHT + BACK) cube([29, 2, 12.5], anchor = BOTTOM + RIGHT + BACK)
            tag("keep") position(TOP + FRONT) cube([29, 5, 1], anchor = TOP + BACK);
    }
}
cuboid([2, d + 2*th, h+th], anchor = BOTTOM + RIGHT, rounding=1,
        edges = [LEFT + FRONT, LEFT + BACK]);