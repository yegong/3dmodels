$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>

$e1 = 0.01;
$e2 = 0.02;
$e3 = 0.03;
$e4 = 0.04;

th05 = 1;
th = 2;
th2 = th * 2;

module comp1() {
    diff() {
        cuboid([20, 20, 3], 
                rounding = 2, edges=[RIGHT+FRONT, LEFT+FRONT],
                anchor=BOTTOM) {
        
            tag("remove")
            position(BOTTOM)
            zcyl(r = 2.55, h = 3, anchor=BOTTOM);
                    
            
            position(TOP+BACK)
            cuboid([20, 4, 20], 
                    rounding = 2, edges=[RIGHT+TOP, LEFT+TOP],
                    anchor=BOTTOM + BACK) {
                        
                tag("remove")
                up(14)
                position(BACK+BOTTOM)
                ycyl(r = 2.55, h = 4, anchor=BACK);
            }
        }
    }
}

comp1();