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
                irounding = rounding,
                anchor = BOTTOM
                ) {
            
            position(LEFT + FRONT + BOTTOM)
            cuboid([corner, corner, th05], 
                    rounding = rounding, edges = [LEFT + FRONT, RIGHT + BACK], 
                    anchor =  LEFT + FRONT + BOTTOM) {
            
                tag("remove")
                right(screw_pos)
                back(screw_pos)
                position(LEFT + FRONT + BOTTOM)
                zcyl(r = screw_radius, h = th05, anchor = BOTTOM);
            }
            
            position(LEFT + BACK + BOTTOM)
            cuboid([corner, corner, th05], 
                    rounding = rounding, edges = [LEFT + BACK, RIGHT + FRONT], 
                    anchor =  LEFT + BACK + BOTTOM) {
            
                tag("remove")
                right(screw_pos)
                fwd(screw_pos)
                position(LEFT + BACK + BOTTOM)
                zcyl(r = screw_radius, h = th05, anchor = BOTTOM);
            }
            
            position(RIGHT + FRONT + BOTTOM)
            cuboid([corner, corner, th05], 
                    rounding = rounding, edges = [RIGHT + FRONT, LEFT + BACK], 
                    anchor =  RIGHT + FRONT + BOTTOM) {
            
                tag("remove")
                left(screw_pos)
                back(screw_pos)
                position(RIGHT + FRONT + BOTTOM)
                zcyl(r = screw_radius, h = th, anchor = BOTTOM);
            }
            
            position(RIGHT + BACK + BOTTOM)
            cuboid([corner, corner, th05], 
                    rounding = rounding, edges = [RIGHT + BACK, LEFT + FRONT], 
                    anchor =  RIGHT + BACK + BOTTOM) {
            
                tag("remove")
                left(screw_pos)
                fwd(screw_pos)
                position(RIGHT + BACK + BOTTOM)
                zcyl(r = screw_radius, h = th05, anchor = BOTTOM);
            }
        }
    }
}

led_width = 12;
led_cover = 10;

module comp1() {

    fwd(120/2)
    fan_conn();
    
    left(120/2)
    cube([led_width + th, 150, th], anchor = BOTTOM + RIGHT + BACK) {
        position(TOP + LEFT + FRONT)
        cube([th, 150 - 5.2, led_cover], anchor = BOTTOM + LEFT + FRONT);
    }

    right(120/2)
    cube([led_width + th, 150, th], anchor = BOTTOM + LEFT + BACK) {
        position(TOP + RIGHT + FRONT)
        cube([th, 150 - 5.2, led_cover], anchor = BOTTOM + RIGHT + FRONT);
    }

    fwd(120)
    cube([120, 30, th], anchor = BOTTOM + BACK) {
        position(TOP + FRONT)
        cube([120 + 2 * (led_width + th), th, led_cover], anchor = BOTTOM + FRONT);
    }

    fwd(2)
    cube([120, th, led_cover], anchor = BOTTOM + FRONT);
}

module comp2() {

    fwd(120/2)
    fan_conn();
    
    left(120/2)
    cube([led_width + th, 122, th], anchor = BOTTOM + RIGHT + BACK) {
        position(TOP + LEFT + FRONT)
        back(10)
        cube([th, 122 + 5 - 10, led_cover], anchor = BOTTOM + LEFT + FRONT);
        position(TOP + RIGHT + FRONT)
        cube([th, 16, led_cover], anchor = BOTTOM + RIGHT + FRONT);
    }

    right(120/2)
    cube([led_width + th, 122, th], anchor = BOTTOM + LEFT + BACK) {
        position(TOP + RIGHT + FRONT)
        cube([th, 122 + 5, led_cover], anchor = BOTTOM + RIGHT + FRONT);
        position(TOP + LEFT + FRONT)
        cube([th, 16, led_cover], anchor = BOTTOM + LEFT + FRONT);
    }

    fwd(122)
    cube([120, 2, th], anchor = BOTTOM + FRONT) {
        position(TOP + FRONT)
        cube([120 + 2 * (led_width + th), th, led_cover], anchor = BOTTOM + FRONT);
    }

    fwd(2)
    cube([120, th, led_cover], anchor = BOTTOM + FRONT);
}

comp1();