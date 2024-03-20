include <BOSL2/std.scad>

$fn= $preview ? 32 : 64;

d = 29;
h = 18;

th = 2;

diff("remove", "keep") {
    cuboid([39.5, d + 2*th, h+th], anchor = BOTTOM + LEFT) {
        // space for esp32 mcu
        tag("remove") position(BOTTOM + RIGHT) cube([25, 26, h], anchor = BOTTOM + RIGHT);
        tag("remove") position(TOP + RIGHT) left(13)
            cube([7, 2, th], anchor = TOP + RIGHT);
        
        // space for bh1750
        tag("remove") position(BOTTOM + LEFT) cube([14.5, 14.5, h], anchor = BOTTOM + LEFT);
        tag("remove") position(TOP + LEFT) right(5.5)
            cube([3, 3, th], anchor = TOP + LEFT);
        
        // space for usb
        tag("remove") position(TOP + RIGHT)
            cube([6, 9, th], anchor = TOP + RIGHT);
        
        tag("keep") position(TOP + RIGHT + FRONT) cube([39.5, th, 12.5], anchor = BOTTOM + RIGHT + FRONT)
            tag("keep") position(TOP + BACK + RIGHT) cube([29, 5, 1], anchor = TOP + FRONT + RIGHT);
        
        tag("keep") position(TOP + RIGHT + BACK) cube([39.5, th, 12.5], anchor = BOTTOM + RIGHT + BACK)
            tag("keep") position(TOP + FRONT + RIGHT) cube([29, 5, 1], anchor = TOP + BACK + RIGHT);
    }
}

cuboid([th, d + 2*th, h+th], anchor = BOTTOM + RIGHT, rounding=1,
        edges = [LEFT + FRONT, LEFT + BACK]);

left(th)
cuboid([39.5 + th, d + 2*th, th], anchor = TOP + LEFT, rounding=1,
        edges = [LEFT + FRONT, LEFT + BACK]);