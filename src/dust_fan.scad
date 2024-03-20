$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>

$e1 = 0.01;
$e2 = 0.02;
$e3 = 0.03;
$e4 = 0.04;


th05 = 1;
th = 1;
th2 = th * 2;

module dust_fan() {
    so = 140;
    pos1 = 7.5;
    r1 = 2;
    
    diff() {
        rect_tube(h = th, wall = 11, size = [so, so],
            anchor = BOTTOM
            ) {
            
            tag("remove")
            right(pos1)
            back(pos1)
            position(LEFT + FRONT + BOTTOM)
            zcyl(r = r1, h = th, anchor = BOTTOM);
            
            tag("remove")
            right(pos1)
            fwd(pos1)
            position(LEFT + BACK + BOTTOM)
            zcyl(r = r1, h = th, anchor = BOTTOM);
        
            tag("remove")
            left(pos1)
            back(pos1)
            position(RIGHT + FRONT + BOTTOM)
            zcyl(r = r1, h = th, anchor = BOTTOM);
        
            tag("remove")
            left(pos1)
            fwd(pos1)
            position(RIGHT + BACK + BOTTOM)
            zcyl(r = r1, h = th, anchor = BOTTOM);
            
            position(TOP)
            rect_tube(h = 18, wall = th, size = [so, so],
                anchor = BOTTOM);
        };
        
    }
}

dust_fan();