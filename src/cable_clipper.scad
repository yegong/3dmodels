$fs = 0.1;
$fa = 3;
$E = 0.01;
$E2 = $E*2;

include <BOSL2/std.scad>

radius=2.5;
board_thickness=5.2;
line_radius = 0.5;

module clipper() {
    diff() {
        fwd(board_thickness*0.5)
        cuboid([radius * 2, board_thickness * 1.5, radius * 2], anchor = BACK + BOTTOM);
        
        back(1)
        linear_extrude(radius * 2)
        ellipse(r=[radius+0.3, board_thickness], anchor=BACK);
        
        
        tag("remove")
        cuboid([1, board_thickness * 3, radius * 2], anchor = BOTTOM);
        
        fwd(board_thickness*2)
        cuboid([radius * 3, board_thickness * 1, radius * 2], anchor = BACK + BOTTOM);
    }
}

clipper();