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
    corner = 12;
    rounding = 5;
    screw_pos = 7.5;
    screw_radius = 2;
    
    diff() {
        cuboid([size, size, th], 
                rounding = rounding, 
                except = [TOP, BOTTOM],
                anchor = BOTTOM) {
                    
        
            tag_diff("remove", "k2", "r2")
            down($e1)
            position(BOTTOM)
            cuboid([size - th2, size - th2, th + $e2], 
                rounding = rounding, 
                    except = [TOP, BOTTOM],
                    anchor = BOTTOM) {
                    
                tag("k2")
                position(LEFT + FRONT + BOTTOM)
                cuboid([corner, corner, th], 
                        rounding = rounding, edges = RIGHT + BACK, anchor =  LEFT + FRONT + BOTTOM);
                
                tag("k2")
                position(RIGHT + FRONT + BOTTOM)
                cuboid([corner, corner, th], 
                        rounding = rounding, edges = LEFT + BACK, anchor =  RIGHT + FRONT + BOTTOM);
                
                tag("k2")
                position(LEFT + BACK + BOTTOM)
                cuboid([corner, corner, th], 
                        rounding = rounding, edges = RIGHT + FRONT, anchor =  LEFT + BACK + BOTTOM);
                
                tag("k2")
                position(RIGHT + BACK + BOTTOM)
                cuboid([corner, corner, th], 
                        rounding = rounding, edges = LEFT + FRONT, anchor =  RIGHT + BACK + BOTTOM);
            }
            
            tag("remove")
            right(screw_pos)
            back(screw_pos)
            position(LEFT + FRONT + BOTTOM)
            zcyl(r = screw_radius, h = th, anchor = BOTTOM);
            
            tag("remove")
            left(screw_pos)
            back(screw_pos)
            position(RIGHT + FRONT + BOTTOM)
            zcyl(r = screw_radius, h = th, anchor = BOTTOM);
            
            tag("remove")
            right(screw_pos)
            fwd(screw_pos)
            position(LEFT + BACK + BOTTOM)
            zcyl(r = screw_radius, h = th, anchor = BOTTOM);
            
            tag("remove")
            left(screw_pos)
            fwd(screw_pos)
            position(RIGHT + BACK + BOTTOM)
            zcyl(r = screw_radius, h = th, anchor = BOTTOM);
        }
    }
}