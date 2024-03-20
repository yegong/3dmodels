$fs = 0.1;
$fa = 3;

include <BOSL2/std.scad>

size = 100;
thick = 2.4;
thick2 = 1.2;
bottom = 1.2;
epsilon = 0.05;
connector_length = 10;
connector_offset = 25;

module connector1(height) {
    length1 = connector_length - (thick2) - 2*epsilon;
    length2 = connector_length - (thick2 * (epsilon/thick2)) - 2*epsilon;
    depth = thick2 - epsilon;
    down(height/2)
    xrot(90)
    prismoid(size1=[length1,height], size2=[length2,height], h=depth, shift=[0,0], anchor=BOTTOM+FRONT);
}


module connector2(height) {
    length1 = connector_length-thick2;
    length2 = connector_length;
    depth = thick2;
    down(height/2)
    xrot(90)
    prismoid(size1=[length1,height], size2=[length2,height], h=depth, shift=[0,0], anchor=BOTTOM+FRONT);
}

module box(height, rows, cols) {
    diff() {
        cuboid([size, size, height], rounding=2, except=[TOP,BOTTOM], anchor=BOTTOM) {
            position(TOP)
            tag("remove")
            cuboid([size-2*thick, size-2*thick, height - bottom], rounding=2, except=[TOP,BOTTOM], anchor=TOP);
            
            position(FRONT)
            left(connector_offset)
            connector1(height);
            position(FRONT)
            left(-connector_offset)
            connector1(height);
            
            tag("remove")
            position(BACK)
            left(connector_offset)
            connector2(height);
            tag("remove")
            position(BACK)
            left(-connector_offset)
            connector2(height);
            
            position(LEFT)
            fwd(connector_offset)
            zrot(-90)
            connector1(height);
            position(LEFT)
            fwd(-connector_offset)
            zrot(-90)
            connector1(height);
            
            tag("remove")
            position(RIGHT)
            fwd(connector_offset)
            zrot(-90)
            connector2(height);
            tag("remove")
            position(RIGHT)
            fwd(-connector_offset)
            zrot(-90)
            connector2(height);
            
            for ($i = [-1: 2: 1]) {
                for ($j = [-1: 2: 1]) {
                    tag("remove")
                    fwd($i * (size/2-thick/1.35))
                    left($j * (size/2-thick/1.35))
                    position(BOTTOM)
                    cylinder(thick2+epsilon, r1=thick2/2+epsilon, r2=thick2/3+epsilon, anchor=BOTTOM);
                }
            }
            
            for ($i = [-1: 2: 1]) {
                for ($j = [-1: 2: 1]) {
                    fwd($i * (size/2-thick/1.35))
                    left($j * (size/2-thick/1.35))
                    position(TOP)
                    cylinder(thick2, r1=thick2/2, r2=thick2/3, anchor=BOTTOM);
                }
            }
            
            if (rows > 1) {
                zp = size/2 - thick + thick2/2;
                offset_ = (size - 2*thick + thick2) / rows;
                for ($i = [1: rows-1]) {
                    tag("keep")
                    left(-zp + $i*offset_)
                    position(BOTTOM)
                    cuboid([thick2, size-2*thick, height], anchor=BOTTOM);
                }
            }
            
            if (cols > 1) {
                zp = size/2 - thick + thick2/2;
                offset_ = (size - 2*thick + thick2) / cols;
                for ($i = [1: cols-1]) {
                    tag("keep")
                    fwd(-zp + $i*offset_)
                    position(BOTTOM)
                    cuboid([size-2*thick, thick2, height], anchor=BOTTOM);
                }
            }
        }
    }
}

box(20, 3, 2);