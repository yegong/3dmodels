$fs = 0.1;
$fa = 3;
$epsilon = 0.01;

peg_radius = 2.45;
board_thickness = 1;
peg_dist = 25;
peg_offset = peg_dist + peg_radius * 2;
peg_offset_v1 = 40;

/**
 * Utility to create rounded cube (not centered)
 */
module rounded_cube(size, radius=0) {
    union() {
        //body
        translate([radius, radius, radius])
        cube([size[0] - radius*2, size[1] - radius*2, size[2] - radius*2]);
        
        translate([0, radius, radius])
        cube([size[0], size[1] - radius*2, size[2] - radius*2]);
        translate([radius, 0, radius])
        cube([size[0] - radius*2, size[1], size[2] - radius*2]);
        translate([radius, radius, 0])
        cube([size[0] - radius*2, size[1] - radius*2, size[2]]);
        
        //edge
        for(x = [radius, size[0] - radius]) {
            for(y = [radius, size[1] - radius]) {
                translate([x, y, radius])
                cylinder(h = size[2] - radius*2, r = radius);
            }
        }
        for(y = [radius, size[1] - radius]) {
            for(z = [radius, size[2] - radius]) {
                translate([radius, y, z])
                rotate([0, 90, 0])
                cylinder(h = size[0] - radius*2, r = radius);
            }
        }
        for(x = [radius, size[0] - radius]) {
            for(z = [radius, size[2] - radius]) {
                translate([x, radius, z])
                rotate([-90, 0, 0])
                cylinder(h = size[1] - radius*2, r = radius);
            }
        }
        
        //corner
        for(x = [radius, size[0] - radius]) {
            for(y = [radius, size[1] - radius]) {
                for(z = [radius, size[2] - radius]) {
                    translate([x, y, z])
                    sphere(r = radius);
                }
            }
        }
    }
}

/**
 * Utility to create rounded cylinder (not centered)
 */
module rounded_cylinder(h, r) {
    union() {
        translate([0, 0, r])
        cylinder(h = h - 2*r, r=r);
        
        translate([0, 0, r])
        sphere(r = r);
        
        translate([0, 0, h - r])
        sphere(r = r);
    }
}

/*
 * Position: z-axis
 * Zero point: peg2
 * Direction: x-axis
 */
module hook(extra_length=0) {
    peg1_length = 5;
    peg2_length = board_thickness*3;
    peg1_angle = atan((peg_dist-board_thickness)/peg2_length);
    
    // Peg 1
    translate([-extra_length, 0, peg_offset])
    rotate([0, 90, 0])
    cylinder(h = peg_radius+board_thickness + extra_length, r = peg_radius);
    
    translate([peg_radius+board_thickness, 0, peg_offset])
    rotate([0, 90 + peg1_angle, 0])
    cylinder(h = peg1_length, r = peg_radius);
    
    translate([peg_radius+board_thickness, 0, peg_offset])
    sphere(r = peg_radius);
    
    // Peg 2
    translate([-extra_length, 0, 0])
    rotate([0, 90, 0])
    cylinder(h = peg2_length + extra_length, r = peg_radius);
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
    translate([peg_radius*0.5, -stabilizer_width/2, (peg_offset-stabilizer_height)*0.25])
    rounded_cube([peg_radius*0.25, stabilizer_width, stabilizer_height], radius=peg_radius/4);
    
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

translate([-100, -100, 5]) {
    translate([0, 0, 0])
    dyson_d_pipe_vertical(center_offset = 25);

    translate([0, 70, 0])
    dyson_d_pipe_vertical(center_offset = 25);

    translate([0, 140, 0])
    dyson_d_pipe_vertical(center_offset = 25);
    
    translate([80, 0, 0])
    dyson_d_pipe_vertical(center_offset = 25);

    translate([80, 70, 0])
    dyson_d_pipe_vertical(center_offset = 25);

    translate([80, 140, 0])
    dyson_d_pipe_vertical(center_offset = 40);
}

translate([0, 0, 0])
sphere(r=1);
