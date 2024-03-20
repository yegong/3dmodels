$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>

$e1 = 0.01;
$e2 = 0.02;
$e3 = 0.03;
$e4 = 0.04;

th = 1;
th2 = th * 2;


diff() {
    cube([62 + th2, 22.5 + th2, 45 + th]) {
        tag("remove")
        position(TOP)
        cube([62, 22.5, 45], anchor=TOP);
    }
}