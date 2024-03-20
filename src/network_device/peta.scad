$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>


linear_extrude(3) {
    text("Peta", size = 20, font="Josefin Sans");
}