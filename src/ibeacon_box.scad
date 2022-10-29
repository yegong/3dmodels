include <BOSL2/std.scad>

$fs = 0.1;
$fa = 3;

w = 70;
d = 62 + 5;
h = 20;

th = 2;

diff("remove", "keep") {
    cube([w+2*th, d+2*th, h+th], anchor = BOTTOM) {
        tag("remove") position(TOP) cube([w, d, h], anchor = TOP);
        
        tag("keep") position(BOTTOM + RIGHT)
            fwd(55/2) left(5 + 3 - 1.1) cube([5, 5, 4], anchor = BOTTOM + RIGHT);
        tag("keep") position(BOTTOM + RIGHT)
            fwd(55/2) left(5 + 3) cylinder(r = 1.3, h = 5, anchor = BOTTOM + RIGHT);
        tag("keep") position(BOTTOM + RIGHT) 
            back(55/2) left(5 + 3 - 1.1) cube([5, 5, 4], anchor = BOTTOM + RIGHT);
        tag("keep") position(BOTTOM + RIGHT)
            back(55/2) left(5 + 3) cylinder(r = 1.3, h = 5, anchor = BOTTOM + RIGHT);
        
        tag("keep") position(BOTTOM + RIGHT) 
            fwd(55/2) left(58 + 3 - 1.1) cube([5, 5, 4], anchor = BOTTOM + RIGHT);
        tag("keep") position(BOTTOM + RIGHT)
            fwd(55/2) left(58 + 3) cylinder(r = 1.3, h = 6, anchor = BOTTOM + RIGHT);
        tag("keep") position(BOTTOM + RIGHT) 
            back(55/2) left(58 + 3 - 1.1) cube([5, 5, 4], anchor = BOTTOM + RIGHT);
        tag("keep") position(BOTTOM + RIGHT)
            back(55/2) left(58 + 3) cylinder(r = 1.3, h = 6, anchor = BOTTOM + RIGHT);
        
        tag("remove") position(RIGHT + BOTTOM)
            up(2 + 0.8 + 2) back(15.5) cube([2, 8, 3.5], anchor = RIGHT + FRONT + BOTTOM);
        tag("remove") position(RIGHT + BOTTOM)
            up(2 + 0.8 + 2) fwd(8.5) cube([2, 16, 14.5], anchor = RIGHT + FRONT + BOTTOM);
        tag("remove") position(RIGHT + BOTTOM)
            up(2 + 0.8 + 2 + 1) fwd(22) cube([2, 6, 6.5], anchor = RIGHT + FRONT + BOTTOM);
        tag("remove") position(RIGHT + TOP)
            fwd(22) cube([2, 2, 4], anchor = RIGHT + FRONT + UP);
    }
}

left(w+3*th)
cube([w+2*th, d+2*th, th], anchor = BOTTOM) {
    position(TOP) cube([w, d, th], anchor = BOTTOM);
}