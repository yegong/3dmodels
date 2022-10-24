use <threadlib/threadlib.scad>
use <smooth-prim/smooth_prim.scad>
include <BOSL2/std.scad>

$fs = 0.1;
$fa = 3;

outlet_size = [33, 55, 33];
thickness = 5;

difference() {
    cuboid([outlet_size[0] + thickness * 2, outlet_size[1], outlet_size[2] + thickness * 2], rounding=2.5, except_edges=FRONT, anchor=FRONT);
    
    cuboid([outlet_size[0]+0.5, outlet_size[1]+0.5, outlet_size[2]+0.5], rounding=2.5, edges="Y", anchor=FRONT);
}

translate([0, 40, outlet_size[2] / 2 + thickness])
bolt("UNF-1/4", turns=5, higbee_arc=30);