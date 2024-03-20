$fn= $preview ? 32 : 64;

use <threadlib/threadlib.scad>
include <BOSL2/std.scad>

bolt("M4", turns=5, higbee_arc=30);

up(3.8)
diff() {
    cylinder(d=7.5, h=35, anchor=BOTTOM);
}