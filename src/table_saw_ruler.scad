$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>

$e = 0.01;
$e2 = 0.02;


diff() {
    cuboid([5, 15, 40], anchor=BOTTOM) {
        tag("remove")
        position(TOP + LEFT)
        cuboid([1.2, 15, 25], anchor=TOP + LEFT);
        
        position(BOTTOM + LEFT)
        cuboid([5.4, 5.6, 40], rounding=2.5, except=[LEFT, RIGHT], anchor=BOTTOM + RIGHT);
        
        tag("remove")
        up(10)
        position(BOTTOM + RIGHT)
        xcyl(r=1.3, h=10.4, anchor=RIGHT);
        
        tag("remove")
        up(10)
        position(BOTTOM + RIGHT)
        xcyl(r=1.8, h=3, anchor=RIGHT);
        
        tag("remove")
        up(30)
        position(BOTTOM + RIGHT)
        xcyl(r=2, h=10.4, anchor=RIGHT);
    }
}