$fn= $preview ? 32 : 64;
$fa = 3;
$E = 0.01;
$E2 = $E*2;

include <BOSL2/std.scad>

module height_fixer() {
    diff() {
        cuboid([15, 30, 6], rounding=1, except_edges=[TOP, BOTTOM]);
    }
}

module mag_dock1() {
    diff() {
        cuboid([30, 25, 1]) {
            position(TOP)
            rect_tube(h = 1.5, wall = 1.5, isize = [19.5, 9.5], anchor=BOTTOM);
            
            tag("remove")
            position(BOTTOM)
            cyl(r=2, h=1, anchor=BOTTOM);
        }
    }
}

module mag_dock2() {
    diff() {
        rect_tube(h = 1.5, wall = 5, isize = [20, 10]) {
            position(TOP)
            rect_tube(h = 1.5, 
            wall = 1.5, 
            isize = [20, 10], anchor=BOTTOM);
            
            tag("remove")
            position(BOTTOM)
            cyl(r=2, h=1, anchor=BOTTOM);
        }
    }
}

mag_dock1();