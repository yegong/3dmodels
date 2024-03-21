$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>

$e = 0.01;
$e2 = 0.02;

module pipe_male_connector() {
    tube(h=50, od=27, od2=25, id1=24, id2=22,
            anchor = BOTTOM);

    up(50)
    tube(h=10, od1=25, od2=24.5, id=22,
            anchor = BOTTOM);
}

module vacuum_to_pipe_connector() {
    tube(h=40, od1=25, od2=28, id1=22, id=23,
            anchor = BOTTOM);

    up(40)
    tube(h=50, od1=26, od2=27, id1=23, id=25,
            anchor = BOTTOM);
}

module saw_to_famale_adapter() {
    w = 49.5;
    d = 32.5;
    
    intersect() {
        rect_tube(h = 10, wall = 1.5, size = [w, d],
            rounding = 5,
            irounding = 5,
            anchor = BOTTOM
            ) {
            position(BOTTOM)
            tag("intersect")
            cuboid([w, d/2, 10], anchor = BOTTOM + FRONT);
        }
    }
    
    intersect() {
        rect_tube(h = 10, wall = 1.5, size = [w, d],
            rounding = 1,
            irounding = 1,
            anchor = BOTTOM
            ) {
            position(BOTTOM)
            tag("intersect")
            cuboid([w, d/2, 10], anchor = BOTTOM + BACK);
        }
    }

    tube(h=10, id1=25, id2=24.5, wall=1.5,
            anchor = BOTTOM);

    diff() {
        back(3)
        cuboid([w + 20 - 4, d + 10 - 4, 1.5],
                rounding = 1,
                except=[TOP, BOTTOM],
                anchor = TOP
                );
        
        tag("remove")
        up($e)
        zcyl(d = 25, h = 1.5 + $e2,
                anchor = TOP
                );
    }
}

module box_famale_to_pipe() {
    tube(h=10, id1=25, id2=24.5, wall=1.5,
            anchor = BOTTOM);
    
    up(10)
    tube(h=5, od1=28, od2=25, id1=24.5, id2=22,
            anchor = BOTTOM);
    
    up(15)
    tube(h=20, od=25, od2=24.5, id=22,
            anchor = BOTTOM);
    
    diff() {
        cuboid([40, 40, 1.5],
                rounding = 1,
                except=[TOP, BOTTOM],
                anchor = TOP
                );
        
        tag("remove")
        up($e)
        zcyl(d = 25, h = 1.5 + $e2,
                anchor = TOP
                );
    }
    
}

vacuum_to_pipe_connector();