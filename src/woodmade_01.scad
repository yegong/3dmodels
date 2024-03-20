$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>
include <BOSL2/gears.scad>


$e = 0.01;
$e2 = 0.02;

diff() {
    crown_gear(circ_pitch=5, teeth=22, backing=6, face_width=4, pressure_angle=20, spin=1, anchor=BOTTOM);
    
    tag("remove")
    zcyl(d=3.8, h=20);
    
    tag("remove")
    up(3)
    torus(r_maj=22, r_min=1.5);
}


left(60)
diff() {

    bevel_gear(
        circ_pitch=5, teeth=25, mate_teeth=25, right_handed=true,
        shaft_diam=3.8, spiral=0,
        bottom=6,
        anchor=BOTTOM
    );
    
    zcyl(d=40, h=4, anchor=BOTTOM);
    
    tag("remove")
    up(2)
    torus(r_maj=20, r_min=1.5);
}

left(60)
back(60)
diff() {
    color("lightblue")
    bevel_gear(
        circ_pitch=5, teeth=25, mate_teeth=25,
        shaft_diam=3.8, spiral=0,
        slices=12, anchor=BOTTOM
    );
}