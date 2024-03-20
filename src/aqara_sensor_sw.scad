$fn= $preview ? 32 : 64;
$fa = 3;
$E = 0.01;
$E2 = $E*2;

include <BOSL2/std.scad>


module comp1() {
    diff() {
        cuboid([20, 40, 11], rounding=2, except_edges=[BOTTOM, TOP], anchor=BOTTOM) {
            
            tag("remove")
            position(TOP)
            cuboid([16.5, 35, 9], rounding=2, except_edges=[BOTTOM, TOP], anchor=TOP);
            
            
            tag("remove")
            position(BOTTOM)
            zcyl(d=3, h=3, anchor=BOTTOM);
            
            tag("remove")
            back(12)
            position(BOTTOM)
            zcyl(d=3, h=3, anchor=BOTTOM);
        }
    }
}


module comp2() {
    diff() {
        cuboid([20, 40, 2], rounding=2, except_edges=[BOTTOM, TOP], anchor=BOTTOM) {
            tag("remove")
            position(TOP + FRONT)
            cuboid([10, 1, 1], anchor=TOP + FRONT);
            
            position(TOP)
            rect_tube(h = 2, wall = 1, size = [16.25, 34.75], rounding=2, anchor=BOTTOM);
        }
    }
}


module comp3() {
    diff() {
        cuboid([20, 24, 11], rounding=2, except_edges=[BOTTOM, TOP], anchor=BOTTOM) {
            
            tag("remove")
            position(TOP)
            cuboid([8, 21, 9], except_edges=[BOTTOM, TOP], anchor=TOP);
            
            
            tag("remove")
            back(6)
            position(BOTTOM)
            zcyl(d=3, h=3, anchor=BOTTOM);
            
            tag("remove")
            fwd(6)
            position(BOTTOM)
            zcyl(d=3, h=3, anchor=BOTTOM);
        }
    }
}


module comp4() {
    diff() {
        cuboid([20, 24, 2], rounding=2, except_edges=[BOTTOM, TOP], anchor=BOTTOM) {
            tag("remove")
            position(TOP + FRONT)
            cuboid([10, 1, 1], anchor=TOP + FRONT);
            
            position(TOP)
            rect_tube(h = 2, wall = 1, size = [7.75, 20.75], rounding=2, anchor=BOTTOM);
        }
    }
}


module comp5() {
    diff() {
        cuboid([10.5, 24, 1.5], anchor=BOTTOM) {
            tag("remove")
            back(6)
            position(BOTTOM)
            zcyl(d=3.5, h=1.5, anchor=BOTTOM);
            
            tag("remove")
            fwd(6)
            position(BOTTOM)
            zcyl(d=3.5, h=1.5, anchor=BOTTOM);
        }
    }
}

comp4();