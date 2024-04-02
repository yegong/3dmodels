$fn= $preview ? 32 : 64;
$fa = 3;
$E = 0.01;
$E2 = $E*2;

include <BOSL2/std.scad>

d = 180;
w = 235;
h = 20;

r = 20;

notch_w = 42;
notch_h = 12;

th = 4;


diff() {
    rect_tube(size = [w, d], h = h, rounding = r, wall = th) {
        tag("remove")
        position(BACK + BOTTOM)
        cuboid([notch_w, th, notch_h / 2], rounding = -2, edges = [BOTTOM + LEFT, BOTTOM + RIGHT], anchor = BACK + BOTTOM);
        
        tag("remove")
        up(notch_h / 2)
        position(BACK + BOTTOM)
        cuboid([notch_w, th, notch_h / 2], rounding = 2, edges = [TOP + LEFT, TOP + RIGHT], anchor = BACK + BOTTOM);
    }
}