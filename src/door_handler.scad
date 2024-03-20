$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>

diff() {
    cuboid([20, 15, 80], rounding=3, except=[BACK, BOTTOM], anchor=BOTTOM + BACK) {
        tag("remove")
        position(BACK)
        cuboid([8.4, 4.1, 81], anchor=BACK);
    }
}