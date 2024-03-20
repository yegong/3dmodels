$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>

$e1 = 0.01;
$e2 = 0.02;
$e3 = 0.03;
$e4 = 0.04;

th = 3;
th2 = th * 2;

module comp1(depth, width, height, rounding=0, extra) {
    diff() {
        cuboid([width+th, depth+th2, height+th], anchor=BOTTOM) {
            if (extra) {
                position(BOTTOM + LEFT)
                cuboid([30, 20, th], anchor=BOTTOM + LEFT) {
                    
            
                tag("remove")
                right(10)
                position(BOTTOM)
                zcyl(r=1.5, h=th+$e1, anchor=BOTTOM);
                
                
                tag("remove")
                right(10)
                up(th+$e1)
                position(BOTTOM)
                zcyl(r=3.05, h=1.1, anchor=TOP);
                }
            }
            
            tag("remove")
            up($e1)
            right($e1)
            position(TOP + RIGHT)
            cuboid([width, depth, height], rounding=rounding, edges=[LEFT+FRONT, LEFT+BACK], anchor=TOP + RIGHT);
            
            tag("remove")
            right(th/2)
            position(BOTTOM)
            zcyl(r=1.5, h=th+$e1, anchor=BOTTOM);
            
            
            tag("remove")
            up(th+$e1)
            right(th/2)
            position(BOTTOM)
            zcyl(r=3.05, h=1.1, anchor=TOP);
        }
    }
}

comp1(105, 10, 10, 4, true);

right(35)
comp1(105, 10, 10, 4, false);