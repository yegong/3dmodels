$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>

outer_size = [270, 120];
th = 2.5; //thickness
th2 = th * 2; //thickness * 2

module bottom_comp(box_size, height) {
    diff() {
        cube([outer_size[0] / 2, outer_size[1], th], anchor = TOP + RIGHT);
        
        tag("remove")
        cube([box_size[0] / 2 - th, box_size[1] - th2, th], anchor = TOP + RIGHT);
        
        cube([outer_size[0] / 2, outer_size[1], th2], anchor = BOTTOM + RIGHT);
        
        tag("remove")
        cube([box_size[0] / 2, box_size[1], th2], anchor = BOTTOM + RIGHT);
    }
}

bottom_comp([258, 100], 10);