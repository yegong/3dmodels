$fn= $preview ? 32 : 64;
$fa = 3;
$E = 0.1;
$E2 = $E*2;
include <BOSL2/std.scad>

angle = 20;


cuboid([2, 100, 40], anchor=BOTTOM) {
    
    fwd(20)
    position(LEFT + BOTTOM)
    prismoid(size1=[45, 2], size2=[45 - tan(angle) * 20, 2], shift=[tan(angle) * 20 / 2, 0], h=20, anchor = RIGHT + BOTTOM);
    
    back(20)
    position(LEFT + BOTTOM)
    prismoid(size1=[45, 2], size2=[45 - tan(angle) * 20, 2], shift=[tan(angle) * 20 / 2, 0], h=20, anchor = RIGHT + BOTTOM);
    
    left(45)
    position(LEFT + BOTTOM)
    prismoid(size1=[2,75], size2=[2,75], shift=[tan(angle) * 40, 0], h=40, anchor = RIGHT + BOTTOM);
}