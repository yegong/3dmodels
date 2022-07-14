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
module rounded_cylinder(h, r, single=false) {
    union() {
        translate([0, 0, single?0:r])
        cylinder(h = h - (single?r:2*r), r=r);
        
        if(!single) {
            translate([0, 0, r])
            sphere(r = r);
        }
        
        translate([0, 0, h - r])
        sphere(r = r);
    }
}