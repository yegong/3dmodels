$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>

$e1 = 0.01;
$e2 = 0.02;
$e3 = 0.03;
$e4 = 0.04;


th05 = 1;
th = 2;
th2 = th * 2;



module fan_conn() {
    size = 120;
    corner = 14;
    rounding = 5;
    screw_pos = 7.5;
    screw_radius = 2;
    
    diff() {
        
        rect_tube(h = th, wall = 2, size = [size, size],
                rounding = rounding,
                irounding = rounding,
                anchor = BOTTOM
                ) {
            
            position(LEFT + FRONT + BOTTOM)
            cuboid([corner, corner, th], 
                    rounding = rounding, edges = [LEFT + FRONT, RIGHT + BACK], 
                    anchor =  LEFT + FRONT + BOTTOM) {
            
                tag("remove")
                right(screw_pos)
                back(screw_pos)
                position(LEFT + FRONT + BOTTOM)
                zcyl(r = screw_radius, h = th, anchor = BOTTOM);
            }
            
            position(LEFT + BACK + BOTTOM)
            cuboid([corner, corner, th], 
                    rounding = rounding, edges = [LEFT + BACK, RIGHT + FRONT], 
                    anchor =  LEFT + BACK + BOTTOM) {
            
                tag("remove")
                right(screw_pos)
                fwd(screw_pos)
                position(LEFT + BACK + BOTTOM)
                zcyl(r = screw_radius, h = th, anchor = BOTTOM);
            }
            
            position(RIGHT + FRONT + BOTTOM)
            cuboid([corner, corner, th], 
                    rounding = rounding, edges = [RIGHT + FRONT, LEFT + BACK], 
                    anchor =  RIGHT + FRONT + BOTTOM) {
            
                tag("remove")
                left(screw_pos)
                back(screw_pos)
                position(RIGHT + FRONT + BOTTOM)
                zcyl(r = screw_radius, h = th, anchor = BOTTOM);
            }
            
            position(RIGHT + BACK + BOTTOM)
            cuboid([corner, corner, th], 
                    rounding = rounding, edges = [RIGHT + BACK, LEFT + FRONT], 
                    anchor =  RIGHT + BACK + BOTTOM) {
            
                tag("remove")
                left(screw_pos)
                fwd(screw_pos)
                position(RIGHT + BACK + BOTTOM)
                zcyl(r = screw_radius, h = th, anchor = BOTTOM);
            }
        }
    }
}

module comp1() {
    fan_conn();
    
    rect_tube(h = 20 + th, wall = th, size = [120, 120],
            rounding = 5,
            irounding = 5,
            anchor = BOTTOM
            );

    diff() {
        zrot(45)
        cuboid([2, 135, th], anchor=BOTTOM);
        zrot(-45)
        cuboid([2, 135, th], anchor=BOTTOM);
        
        
        for (sz = [15:20:100]) {
            rect_tube(h = th, wall = 2, size = [sz, sz],
                rounding = 5,
                irounding = 5,
                anchor = BOTTOM
                );
        };
    }
}

module comp2() {
    rect_tube(h = 5 + th, wall = th, size = [120 - th2 - 0.5, 120 - th2 - 0.5],
            rounding = 5,
            irounding = 5,
            anchor = BOTTOM
            );

    diff() {
        zrot(45)
        cuboid([2, 159, th], anchor=BOTTOM);
        zrot(-45)
        cuboid([2, 159, th], anchor=BOTTOM);
        
        
        for (sz = [15:20:100]) {
            rect_tube(h = th, wall = 2, size = [sz, sz],
                rounding = 5,
                irounding = 5,
                anchor = BOTTOM
                );
        };
    }
}

comp1();