$fs = 0.1;
$fa = 3;
$E = 0.01;
$E2 = $E*2;

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
        up(extra_height/2-rr)
        position(BACK)
        hook();
    }
}

module dyson_d_pipe_vertical(center_offset) {
    thickness = 4;
    rr = thickness / 4;
    d_pipe_outer_radius = 35/2;
    d_pipe_inner_r1 = 29/2;
    d_pipe_inner_r2 = 27/2;
    d_shape_offset = 9;
    rack_flat_depth = center_offset+d_pipe_outer_radius;
    
    pipe_width = d_pipe_outer_radius*2;
    pipe_width_ext1 = pipe_width + thickness*2;
    pipe_width_ext2 = pipe_width + thickness*3;
    rack_rack_offset = 22.5;
    rack_height = 30;
    flat_extra_height = thickness*1.75;
    
    flat_hook1(pipe_width_ext2, thickness, flat_extra_height);
    
    diff("remove", "keep") {
        down(peg_offset/2)
        prismoid(size1=[pipe_width_ext1,thickness*2], 
                 size2=[pipe_width_ext1,thickness], 
                 shift=[0,thickness*0.5], h=rack_flat_depth,
                 rounding=rr,
                 orient=FRONT) {
                     
            up(center_offset)
            position(BACK+BOTTOM)
            ycyl(h = rack_height, r1=d_pipe_inner_r1, r2=d_pipe_inner_r2, anchor=FRONT);
            
            right(rr)
            down(rr)
            position(LEFT+BOTTOM+BACK)
            prismoid(size1=[thickness,d_shape_offset], 
                     size2=[thickness,rr*2], 
                     shift=[0,d_shape_offset/2], h=rack_height,
                     rounding=rr,
                     orient=BACK,
                     anchor=LEFT+BOTTOM+BACK);
            
            left(rr)
            down(rr)
            position(RIGHT+BOTTOM+BACK)
            prismoid(size1=[thickness,d_shape_offset], 
                     size2=[thickness,rr*2], 
                     shift=[0,d_shape_offset/2], h=rack_height,
                     rounding=rr,
                     orient=BACK,
                     anchor=RIGHT+BOTTOM+BACK);
                
            tag("remove")
            up(center_offset-d_shape_offset)
            position(BACK+BOTTOM)
            cube([d_pipe_inner_r1*2, rack_height, d_pipe_inner_r1-d_shape_offset], anchor=TOP+FRONT);
                     
            tag("remove")
            up(center_offset)
            fwd(thickness*3)
            position(BACK+BOTTOM)
            ycyl(h = rack_height+thickness*3, r1=thickness, r2=thickness, anchor=FRONT);
        }
    }
}

dyson_d_pipe_vertical(25);