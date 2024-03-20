$fs = 0.1;
$fa = 3;
$E = 0.01;
$E2 = $E*2;

include <BOSL2/std.scad>

module hook(d, h, x=5) {
    cuboid([5, 5, 50], rounding=1) {
        position(TOP + FRONT)
        cuboid([5, 15, 5], anchor=FRONT + TOP, rounding=2) {
            position(TOP + BACK)
            cuboid([5, 5, 7], anchor=TOP + BACK, rounding=2, except=[BOTTOM]);
            
            down(7)
            position(TOP + BACK)
            prismoid(size1=[5,4], size2=[5,5], shift=[0, -0.50], h=5, rounding=2, anchor = TOP + BACK);
        }
        
        down(40)
        position(TOP + FRONT)
        cuboid([5, 15, 5], anchor=FRONT + TOP, rounding=1) {
            position(TOP + BACK)
            cuboid([5, 5, 7], anchor=TOP + BACK, rounding=2, except=[BOTTOM]);
            
            down(7)
            position(TOP + BACK)
            prismoid(size1=[5,4], size2=[5,5], shift=[0, -0.50], h=5, rounding=2, anchor = TOP + BACK);
        }
        
        position(BOTTOM + BACK)
        cuboid([x, d + 5 + x, x], rounding=1, anchor=BOTTOM + BACK) {
            position(BOTTOM + FRONT)
            cuboid([x, x, h + x], rounding=1, anchor=BOTTOM + FRONT);
        }
    }
}

hook(4, 2, 4);