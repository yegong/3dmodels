include <BOSL2/std.scad>

$fs = 0.1;
$fa = 3;

notes_size = [99, 99, 20];
thickness = 4;
penstand_thickness = 15;

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
    
    translate([0, -(notes_size[1] / 2 - 6), thickness])
    cylinder(d1=20, d2=20, h=notes_size[2], anchor=BOTTOM);
    
    translate([-(notes_size[0] / 2 - 7.8 / 2), -(notes_size[1] / 2 + penstand_thickness / 2 + thickness / 2), thickness])
    cylinder(d1=2.8, d2=7.8, h=notes_size[2], anchor=BOTTOM);
    
    translate([0, -(notes_size[1] / 2 + penstand_thickness * 0.667), thickness])
    cuboid([55, 1, notes_size[2]], anchor=BOTTOM);
}
    