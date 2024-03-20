$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>

$e1 = 0.01;
$e2 = 0.02;
$e3 = 0.03;
$e4 = 0.04;

td = 1;
th = 2;
th2 = th * 2;

sep_h = 12;

diff() {
    cuboid([48 + th2, 52 + th2, th]) {
        position(BOTTOM)
        rect_tube(size = [48 + th2, 52 + th2], wall = 2, h = 33, anchor = TOP);
        
        tag("remove")
        left(5.5 + th)
        fwd(5.5)
        position(TOP + RIGHT + BACK)
        zcyl(h = th, d=3.5, anchor = TOP);
        
        tag("remove")
        right(5.5 + th)
        back(5.5)
        position(TOP + LEFT + FRONT)
        zcyl(h = th, d=3.5, anchor = TOP);
        
        for (x = [5, 18, 29]) {
            right(x + th)
            fwd(5)
            position(BOTTOM + LEFT + BACK)
            zcyl(h = 12 - 10, d=5+1, anchor = TOP);
            
            tag("remove")
            right(x + th)
            fwd(5)
            position(TOP + LEFT + BACK)
            zcyl(h = th2, d=5, anchor = TOP);
            
            tag("remove")
            right(x + th)
            down(6)
            position(BOTTOM + LEFT + BACK)
            ycyl(h = th, d=5, anchor=BACK);
            
            ///
            
            left(x + th)
            back(5)
            position(BOTTOM + RIGHT + FRONT)
            zcyl(h = 12 - 10, d=5+1, anchor = TOP);
            
            tag("remove")
            left(x + th)
            back(5)
            position(TOP + RIGHT + FRONT)
            zcyl(h = th2, d=5, anchor = TOP);
            
            tag("remove")
            left(x + th)
            down(6)
            position(BOTTOM + RIGHT + FRONT)
            ycyl(h = th, d=5, anchor = FRONT);
        }
        
        back(8.25)
        position(BOTTOM)
        cuboid([48, td, sep_h], anchor = TOP);
        
        fwd(8.25)
        position(BOTTOM)
        cuboid([48, td, sep_h], anchor = TOP);
        
        position(BOTTOM)
        cuboid([td, 30, sep_h], anchor = TOP);
        
        ///
        
        fwd(th + 10)
        position(BOTTOM + BACK)
        cuboid([48, td, sep_h], anchor = TOP + BACK);

        back(th + 10)
        position(BOTTOM + FRONT)
        cuboid([48, td, sep_h], anchor = TOP + FRONT);
        
        ///
        
        for (x = [11, 23, 35]) {
            fwd(th)
            right(x + th)
            position(BOTTOM + LEFT + BACK)
            cuboid([td, 10, sep_h], anchor = TOP + LEFT + BACK);
            
            back(th)
            left(x + th)
            position(BOTTOM + RIGHT + FRONT)
            cuboid([td, 10, sep_h], anchor = TOP + RIGHT + FRONT);
        }
        
        ///
            
        tag("remove")
        position(TOP + RIGHT + FRONT)
        left(18 + 4.5)
        back(10)
        down(0.4)
        linear_extrude(0.4) {
            text("L1", size = 3, font="Josefin Sans Bold");
        }

        tag("remove")
        position(TOP + RIGHT + FRONT)
        left(29 + 5)
        back(10)
        down(0.4)
        linear_extrude(0.4) {
            text("L11", size = 3, font="Josefin Sans Bold");
        }

        tag("remove")
        position(TOP + RIGHT + FRONT)
        left(5 + 5.5)
        back(10)
        down(0.4)
        linear_extrude(0.4) {
            text("L12", size = 3, font="Josefin Sans Bold");
        }
            
        tag("remove")
        position(TOP + LEFT + BACK)
        right(18)
        fwd(10 + 2)
        down(0.4)
        linear_extrude(0.4) {
            text("L2", size = 3, font="Josefin Sans Bold");
        }
            
        tag("remove")
        position(TOP + LEFT + BACK)
        right(5-0.75)
        fwd(10 + 2)
        down(0.4)
        linear_extrude(0.4) {
            text("L21", size = 3, font="Josefin Sans Bold");
        }
            
        tag("remove")
        position(TOP + LEFT + BACK)
        right(29-1)
        fwd(10 + 2)
        down(0.4)
        linear_extrude(0.4) {
            text("L22", size = 3, font="Josefin Sans Bold");
        }
    }
}