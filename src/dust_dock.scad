$fs = 0.1;
$fa = 3;
$E = 0.01;
$E2 = $E*2;

include <BOSL2/std.scad>

width = 32;
th = 2;
th2 = th * 2;

module comp1() {
    diff() {
        cuboid([10, width, 70], anchor=BOTTOM + LEFT) {
            tag("remove")
            position(TOP + LEFT)
            cuboid([10-th, width-th2, 60], anchor=TOP + LEFT);
            
            position(BOTTOM + LEFT)
            cuboid([100, width, 20], anchor=BOTTOM + RIGHT) {
                tag("remove")
                position(TOP + RIGHT)
                cuboid([100-th, width-th2, 10], anchor=TOP + RIGHT);
            }
            
            tag("remove")
            up(20)
            position(RIGHT + BOTTOM)
            xcyl(d=25.5, h=2, anchor=RIGHT + BOTTOM);
        }
    }

    fwd(40)
    tube(h=2, od=27, id=23, anchor = BOTTOM) {
        position(TOP)
        tube(h=30, od=25, od2=24.5, id1=23, id2=23,
                anchor = BOTTOM);
    }

    back(40)
    cuboid([10, width, 2], anchor=BOTTOM);
}

module comp2() {
    diff() {
        cuboid([100, width, 2], anchor=BOTTOM + RIGHT) {
            position(BOTTOM + RIGHT)
            cuboid([2, width, 50], anchor=BOTTOM + RIGHT) {
                tag("remove")
                fwd(5)
                position(RIGHT + BACK + TOP)
                cuboid([2, 3, 40], anchor=RIGHT + BACK + TOP);
                
                tag("remove")
                position(RIGHT + TOP)
                cuboid([2, 3, 40], anchor=RIGHT + TOP);
                
                tag("remove")
                back(5)
                position(RIGHT + FRONT + TOP)
                cuboid([2, 3, 40], anchor=RIGHT + FRONT + TOP);
            }
            
            for (l = [10:20:90]) {
                tag("remove")
                right(l)
                position(BOTTOM + LEFT)
                cuboid([2, width - th2, 2], anchor=BOTTOM + LEFT);
            };
        }
    }
}

comp2();