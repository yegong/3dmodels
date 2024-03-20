$fn= $preview ? 32 : 64;
$fa = 3;
$E = 0.01;
$E2 = $E*2;
include <BOSL2/std.scad>

th = 2;
th2 = th * 2;
notes_size = 105;
penstand_th = 15;

/*
difference() {
    fwd(penstand_thickness / 2)
    cuboid([notes_size[0] + thickness * 2, 
            notes_size[1] + thickness * 2 + penstand_thickness, 
            notes_size[2] + thickness],
            rounding=2, except_edges=BOTTOM, anchor=BOTTOM);
    
    up(thickness)
    cuboid([notes_size[0], 
            notes_size[1], 
            notes_size[2]],
            anchor=BOTTOM);
    
    translate([-(notes_size[0] / 2 - 7.8 / 2), -(notes_size[1] / 2 + penstand_thickness / 2 + thickness / 2), thickness])
    cylinder(d1=3.8, d2=9, h=notes_size[2], anchor=BOTTOM);
}
*/

cuboid([notes_size + th2, notes_size + th2 + penstand_th, th]);