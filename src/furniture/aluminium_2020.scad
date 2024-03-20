$fn= $preview ? 32 : 64;
$fa = 3;
$E = 0.01;
$E2 = $E*2;

include <BOSL2/std.scad>

// 铝型材2020 45度端口保护盖

sc=1.4142;

prismoid(size1=[22 * sc, 20], size2=[22 * sc, 20], rounding=1, h=2, anchor=BOTTOM) {
    intersect() {
        position(TOP)
        yrot(45)
        down(2.5)
        cyl(l=10, d1=4.6, d2=4, anchor=BOTTOM) {
            tag("intersect")
            up(2.5)
            yrot(-45)
            position(BOTTOM)
            prismoid(size1=[20 * sc, 20], size2=[20 * sc, 20], rounding=1, h=6.5, anchor=BOTTOM);
        }
        
    }
    
    position(TOP + FRONT)
    prismoid(size1=[5.6 * sc, 3], size2=[5 * sc, 3], shift=[5, 0], h=5, anchor=BOTTOM + FRONT);
    
    back(2.2)
    position(TOP + FRONT)
    prismoid(size1=[10 * sc, 2], size2=[10 * sc, 1.5], shift=[5, 0.25], h=5, anchor=BOTTOM + FRONT);
    
    position(TOP + BACK)
    prismoid(size1=[5.6 * sc, 3], size2=[5 * sc, 3], shift=[5, 0], h=5, anchor=BOTTOM + BACK);
    
    fwd(2.2)
    position(TOP + BACK)
    prismoid(size1=[10 * sc, 2], size2=[10 * sc, 1.5], shift=[5, -0.25], h=5, anchor=BOTTOM + BACK);
}