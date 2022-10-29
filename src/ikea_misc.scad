include <BOSL2/std.scad>

$fs = 0.1;
$fa = 3;

module post_card_holder() {
    difference() {
        cylinder(h = 15, r = 3/2, anchor = BOTTOM);
        
        cube([3, 0.2, 6], anchor = BOTTOM);
        
        up(9)
        cube([3, 0.2, 6], anchor = BOTTOM);
    }
    
}

post_card_holder();