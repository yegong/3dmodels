$fs = 0.1;
$fa = 1;
$epsilon = 0.01;


rotate([0, -90, 0]) {
    cube([40, 70, 10]);

    translate([40, 35, 0])
    cylinder(h=10, r=35);
}