$fs = 0.1;
$fa = 3;
$epsilon = 0.01;

use <utils.scad>;

peg_radius = 2.45;
board_thickness = 1;
peg_dist = 25;
peg_offset = peg_dist + peg_radius * 2;
peg_offset_v1 = 40;

/*
 * Position: z-axis
 * Zero point: peg2
 * Direction: x-axis
 */
module hook(extra_length=0) {
    peg1_length = 7;
    peg2_length = max(board_thickness*3, 7);
    peg1_angle = atan((peg_dist-board_thickness)/peg2_length);
    
    // Peg 1
    translate([-extra_length, 0, peg_offset])
    rotate([0, 90, 0])
    cylinder(h = peg_radius+board_thickness + extra_length, r = peg_radius);
    
    translate([peg_radius+board_thickness, 0, peg_offset])
    rotate([0, 90 + peg1_angle, 0])
    rounded_cylinder(h = peg1_length, r = peg_radius, single=true);
    
    translate([peg_radius+board_thickness, 0, peg_offset])
    sphere(r = peg_radius);
    
    // Peg 2
    translate([-extra_length, 0, 0])
    rotate([0, 90, 0])
    rounded_cylinder(h = peg2_length + extra_length, r = peg_radius, single=true);
}

/* Position: z-axis
 * Zero point: bottom
 * Direction: x-axis
 */
module simple_hook() {
    stabilizer_width = peg_radius*3;
    stabilizer_height = peg_offset*0.5;
    
    // Hook
    translate([peg_radius, 0, 0])
    hook(peg_radius);
    
    // V
    cylinder(h = peg_offset, r = peg_radius);
    
    // V Stabilizer
    translate([peg_radius*0.5, -stabilizer_width*0.5, (peg_offset-stabilizer_height)*0.25])
    rounded_cube([peg_radius*0.5, stabilizer_width, stabilizer_height], radius=peg_radius*0.125);
    
    // Connector 1
    translate([0, 0, peg_offset])
    sphere(r = peg_radius);
    
    // Connector 2
    translate([0, 0, 0])
    sphere(r = peg_radius);
}

/* Position: z-axis
 * Zero point: middle bottom
 * Direction: x-axis
 */
module flat_hook1(width, thickness, extra_height=0) {
    round_radius = thickness/2;
    height = peg_offset + peg_radius*2 + extra_height;
    
    // Hook
    translate([thickness/2, 0, extra_height])
    hook(thickness/2);
    
    // Flat
    translate([-thickness/2, -width/2, -peg_radius])
    rounded_cube([thickness, width, height], round_radius);
}

/* Position: z-axis
 * Zero point: middle bottom
 * Direction: x-axis
 */
module flat_hook2(hook_offset, width, thickness, extra_height=0) {
    round_radius = thickness/2;
    height = peg_offset + peg_radius*2 + extra_height;
    
    // Hook 1
    translate([thickness/2, -hook_offset/2, extra_height])
    hook(thickness/2);
    
    // Hook 2
    translate([thickness/2, hook_offset/2, extra_height])
    hook(thickness/2);
    
    // Flat
    translate([-thickness/2, -width/2, -peg_radius])
    rounded_cube([thickness, width, height], round_radius);
}

module hook_hole_filler() {
    thickness = 2;
    height = 10;
    space = 7.8;
    cube([space, peg_radius*2, height]);
    
    translate([space, peg_radius, 0])
    cylinder(h=height, r=peg_radius);
    
    translate([0, -5, 0])
    cube([space+5, (peg_radius+5)*2, thickness]);
    
    translate([space/2, -2, thickness])
    cube([2, (peg_radius+2)*2, 0.5]);
}

module dyson_pipe_hook(hook_size) {
    simple_hook();
    hook_size_inner = hook_size;
    hook_size_actual = hook_size + peg_radius;
    
    translate([-hook_size_actual, 0, 0])
    rotate([-90, 0, 0])
    rotate_extrude(angle = 195)
    translate([hook_size_actual, 0, 0])
    circle(r=peg_radius);
}

module dyson_v_hook(hook_angle, hook_size, hook_radius_size) {
    simple_hook();
    hook_radius_size_inner = hook_radius_size;
    hook_radius_size_actual = hook_radius_size + peg_radius;
    
    translate([0, 0, -hook_size])
    cylinder(h=hook_size, r=peg_radius);
    
    translate([-hook_radius_size_actual, 0, -hook_size])
    rotate([-90, 0, 0])
    rotate_extrude(angle = 180-hook_angle)
    translate([hook_radius_size_actual, 0, 0])
    circle(r=peg_radius);
    
    translate([
        -hook_radius_size_actual-cos(hook_angle)*hook_radius_size_actual, 
        0, 
        -hook_size-sin(hook_angle)*hook_radius_size_actual,
    ])
    rotate([0, -hook_angle, 0])
    rounded_cylinder(h=hook_size, r=peg_radius, single=true);
}

module dyson_d_pipe_vertical(center_offset) {
    thickness = 3;
    d_pipe_outer_radius = 35/2;
    d_pipe_inner_r1 = 30/2;
    d_pipe_inner_r2 = 27/2;
    d_shape_offset = 9;
    round_radius = thickness/2;
    rack_flat_depth = center_offset+d_pipe_outer_radius;
    rack_flat_width = d_pipe_outer_radius*2;
    rack_rack_offset = 22.5;
    rack_height = 40;
    flat_extra_height = 5;
    
    rotate([0, 0, 180])
    flat_hook1(rack_flat_width, thickness, flat_extra_height);
    
    translate([0,-rack_flat_width/2,0])
    rounded_cube([rack_flat_depth+round_radius*2, rack_flat_width, thickness], round_radius);
    
    translate([center_offset+round_radius, 0, 0])
    union() {
        difference() {
            cylinder(h = rack_height, r1=d_pipe_inner_r1, r2=d_pipe_inner_r2);
            translate([-d_shape_offset-d_pipe_inner_r1, -d_pipe_inner_r1, 0])
            cube([d_pipe_inner_r1, d_pipe_inner_r1*2, rack_height+$epsilon]);
        }
    }
}

translate([0, 0, 5]) {
    translate([-30, -60, 0])
    rotate([90, 0, 0])
    dyson_pipe_hook(hook_size=25);
    
    translate([40, -60, 0])
    rotate([90, 0, 0])
    dyson_pipe_hook(hook_size=25);
    
    translate([-30, 0, 0])
    rotate([90, 0, 0])
    dyson_pipe_hook(hook_size=25);
    
    translate([40, 0, 0])
    rotate([90, 0, 0])
    dyson_pipe_hook(hook_size=25);
    
    translate([-40, 60, 0])
    rotate([90, 0, 0])
    dyson_v_hook(hook_angle=22.5, hook_size=25, hook_radius_size=6);
    
    translate([0, 70, 0])
    rotate([90, 0, 0])
    dyson_v_hook(hook_angle=22.5, hook_size=25, hook_radius_size=6);
    
    translate([40, 60, 0])
    rotate([90, 0, 0])
    dyson_v_hook(hook_angle=22.5, hook_size=25, hook_radius_size=6);
}

translate([0, 0, 0])
sphere(r=1);
