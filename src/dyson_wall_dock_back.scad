$fs = 0.1;
$fa = 3;
$epsilon = 0.01;

include <BOSL2/std.scad>
use <utils.scad>;

cuboid([25, 200, 15], rounding=1, except=[TOP,BOTTOM,FRONT], anchor=FRONT+BOTTOM+LEFT);

translate([30, 0, 0])
cuboid([25, 200, 15], rounding=1, except=[TOP,BOTTOM,FRONT], anchor=FRONT+BOTTOM+LEFT);

translate([60, 0, 0])
cuboid([31, 102, 15], rounding=1, except=[TOP,BOTTOM,LEFT], anchor=FRONT+BOTTOM+LEFT);