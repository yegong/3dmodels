$fs = 0.1;
$fa = 3;
$E = 0.01;
$E2 = $E*2;

use <threadlib/threadlib.scad>
include <BOSL2/std.scad>

peg_radius = 2.1;
board_thickness = 5.2;
peg_dist = 25;
peg_offset = peg_dist + peg_radius * 2;
peg_offset_v1 = 40;
thickness = 4;

/*
 * Position: z-axis
 * Zero point: FRONT
 * Direction: x-axis
 */
module hook() {
    peg1_length = 6;
    peg2_length = 6;
    peg1_angle = atan((peg_offset-peg_radius)/(peg2_length+peg_radius+board_thickness/2));
    
    // Peg 1
    up(peg_offset/2)
    fwd(thickness)
    color("red")
    ycyl(h = peg_radius+board_thickness+thickness, r = peg_radius, anchor=FRONT) {
        
        position(BACK)
        xrot(-peg1_angle)
        ycyl(h = peg1_length, r = peg_radius, anchor=FRONT) {
            position(BACK) sphere(r = peg_radius);
            position(FRONT) sphere(r = peg_radius);
        }
        
    }
    
    // Peg 2
    down(peg_offset/2)
    color("red")
    ycyl(h = peg2_length, r = peg_radius, anchor=FRONT) {
        position(BACK)
        sphere(r = peg_radius+0.05);
    }
}

/* Position: z-axis
 * Zero point: FRONT
 * Direction: x-axis
 */
module flat_hook1(width, thickness, extra_height=0) {
    rr = thickness/4;
    height = peg_offset + peg_radius*2 + extra_height;
    
    // Flat
    cuboid([width, thickness, height], rounding=rr, anchor=FRONT) {
        up(extra_height/4-rr)
        position(BACK)
        hook();
    }
}

module camera() {
    depth = 80;
    center_offset = 50;
    rr = thickness / 4;
    
    width_ext1 = 45 + thickness*2;
    width_ext2 = 45 + thickness*3;
    rack_height = 30;
    flat_extra_height = thickness*3.75;
    
    flat_hook1(width_ext2, thickness, flat_extra_height);
    
    remove_height = thickness*4;
    
    diff("remove", "keep") {
        down(peg_offset/2)
        prismoid(size1=[width_ext1,thickness*3], 
                 size2=[width_ext1,thickness], 
                 shift=[0,thickness*1], h=depth,
                 rounding=rr,
                 orient=FRONT) {
            
            right(rr)
            down(rr)
            position(LEFT+BOTTOM+BACK)
            prismoid(size1=[thickness,thickness*4], 
                     size2=[thickness,rr*2], 
                     shift=[0,thickness*2], h=rack_height,
                     rounding=rr,
                     orient=BACK,
                     anchor=LEFT+BOTTOM+BACK);
            
            left(rr)
            down(rr)
            position(RIGHT+BOTTOM+BACK)
            prismoid(size1=[thickness,thickness*4], 
                     size2=[thickness,rr*2], 
                     shift=[0,thickness*2], h=rack_height,
                     rounding=rr,
                     orient=BACK,
                     anchor=RIGHT+BOTTOM+BACK);
                     
            up(center_offset)
            position(BACK+BOTTOM)
            ycyl(h=8, r=6, anchor=BACK);
                     
            tag("remove")
            up(center_offset)
            position(BACK+BOTTOM)
            ycyl(h=remove_height, r=3.2, anchor=BACK);
            
            
            tag("remove")
            up(center_offset)
            position(BACK+BOTTOM)
            difference() {
                cube([width_ext1, remove_height, width_ext1], anchor=BOTTOM+BACK);
                ycyl(h=remove_height, r=width_ext1/2, anchor=BACK);
            };
                     
            tag("remove")
            up(center_offset - 32)
            position(BACK+BOTTOM)
            cube([14, remove_height, 8], anchor=TOP+BACK);
        }
    }
}

// camera();

module tripod_adapter() {
    radius = 10/2;
    radius2 = 26;
    height = 20;
    thickness = 2;
    
    xrot(180)
    diff("remove", "keep") {
        zcyl(h=height, r=radius+3, anchor=BOTTOM);
        
        up(height)
        bolt("UNF-1/4", turns=7, higbee_arc=30);
        
        tag("keep")
        left(radius)
        zcyl(h=height-thickness, r=1, anchor=BOTTOM);
        
        tag("keep")
        right(radius)
        zcyl(h=height-thickness, r=1, anchor=BOTTOM);
        
        tag("remove")
        zcyl(h=height-thickness, r=radius, anchor=BOTTOM);
    }
    
    left(2 * radius2)
    diff("remove", "keep") {
        zcyl(h=thickness, r=radius2, anchor=BOTTOM);
        
        tag("remove")
        zcyl(h=height, r=3.5, anchor=BOTTOM);
    }
}

// tripod_adapter();

module camera_dock_bolt() {
    diff() {
        linear_extrude(4)
        hexagon(or=6);
        
        up(4)
        cylinder(r=2.65, h=6);
        
        up(6+4)
        bolt("UNF-1/4", turns=6, higbee_arc=60);
    }
}

// camera_dock_bolt();

module precense_sensor_dock() {
    diff() {
        ycyl(r = 45/2, h = thickness, anchor=FRONT) {
            position(BACK)
            hook();
            
            position(FRONT)
            tag("remove")
            ycyl(r = 36/2, h = 0.5, anchor=FRONT);
        }
    }
}

precense_sensor_dock();