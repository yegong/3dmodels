$fs = 0.1;
$fa = 3;
$epsilon = 0.01;

use <utils.scad>;

height = 10;
inner_radius = 44/2;
outer_radius = 50/2;
height2 = 2;


translate([-100, -100, 5]) {
    difference() {
        cylinder(h=height+height2, r=outer_radius);
        
        translate([0, 0, height])
        cylinder(h=height2 + $epsilon, r=inner_radius);
    }
}

translate([0, 0, 0])
sphere(r=1);