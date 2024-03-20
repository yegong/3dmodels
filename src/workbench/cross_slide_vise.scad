$fn= $preview ? 32 : 64;
$fa = 3;
$E = 0.01;
$E2 = $E*2;

include <BOSL2/std.scad>

// 十字台钳

module left_component() {
    diff() {
        cuboid([55, 15, 35], anchor=BOTTOM + FRONT) {
            position(BOTTOM + FRONT)
            cuboid([90, 15, 5], anchor=TOP + FRONT) {
                tag("remove")
                left(67/2)
                position(BOTTOM)
                zcyl(d=5, h=5, anchor=BOTTOM);
                
                tag("remove")
                right(67/2)
                position(BOTTOM)
                zcyl(d=5, h=5, anchor=BOTTOM);
                
                position(BOTTOM)
                cuboid([8.3, 15, 3.2], anchor=TOP) {
                    position(BOTTOM)
                    cuboid([15, 15, 3], anchor=TOP);
                }
            }
            
            position(BOTTOM + FRONT)
            cuboid([90, 15, 5], anchor=TOP + BACK) {
                tag("remove")
                position(BOTTOM)
                zcyl(d=5, h=5, anchor=BOTTOM);
                
                position(BOTTOM)
                left(33.5)
                {
                    cuboid([8.3, 15, 3.2], anchor=TOP) {
                        position(BOTTOM)
                        cuboid([15, 15, 3], anchor=TOP);
                    }
                }
                
                position(BOTTOM)
                right(33.5)
                {
                    cuboid([8.3, 15, 3.2], anchor=TOP) {
                        position(BOTTOM)
                        cuboid([15, 15, 3], anchor=TOP);
                    }
                }
                
                left(55/2)
                position(TOP)
                prismoid(size1=[5,15], size2=[5,0], shift=[0,15/2], h=35, anchor=BOTTOM + LEFT);
                
                right(55/2)
                position(TOP)
                prismoid(size1=[5,15], size2=[5,0], shift=[0,15/2], h=35, anchor=BOTTOM + RIGHT);
            }
        }
    }
}

module left2_component() {
    diff() {
        cuboid([55, 15, 0], anchor=BOTTOM + FRONT) {
            position(BOTTOM + FRONT)
            cuboid([90, 15, 5], anchor=TOP + FRONT) {
                tag("remove")
                left(67/2)
                position(BOTTOM)
                zcyl(d=5, h=5, anchor=BOTTOM);
                
                tag("remove")
                right(67/2)
                position(BOTTOM)
                zcyl(d=5, h=5, anchor=BOTTOM);
                
                position(BOTTOM)
                cuboid([8.3, 15, 3.2], anchor=TOP) {
                    position(BOTTOM)
                    cuboid([15, 15, 3], anchor=TOP);
                }
            }
            
            position(BOTTOM + FRONT)
            cuboid([90, 15, 5], anchor=TOP + BACK) {
                tag("remove")
                position(BOTTOM)
                zcyl(d=5, h=5, anchor=BOTTOM);
                
                position(BOTTOM)
                left(33.5)
                {
                    cuboid([8.3, 15, 3.2], anchor=TOP) {
                        position(BOTTOM)
                        cuboid([15, 15, 3], anchor=TOP);
                    }
                }
                
                position(BOTTOM)
                right(33.5)
                {
                    cuboid([8.3, 15, 3.2], anchor=TOP) {
                        position(BOTTOM)
                        cuboid([15, 15, 3], anchor=TOP);
                    }
                }
            }
        }
    }
}


module middle_component() {
    diff() {
        cuboid([90, 15, 35], anchor=BOTTOM + FRONT) {
            left(37/2)
            position(FRONT)
            ycyl(d=5.9, h=3, anchor=BACK) {
                tag("remove")
                position(FRONT)
                ycyl(d=3.5, h=10, anchor=FRONT);
            }
            
            right(37/2)
            position(FRONT)
            ycyl(d=5.9, h=3, anchor=BACK) {
                tag("remove")
                position(FRONT)
                ycyl(d=3.5, h=10, anchor=FRONT);
            }
            
            position(BOTTOM + BACK)
            cuboid([90, 30, 5], anchor=TOP + BACK) {
                position(BOTTOM)
                cuboid([8.0, 30, 3.7], anchor=TOP) {
                    position(BOTTOM)
                    cuboid([14.5, 30, 3], anchor=TOP);
                }
                
                position(BOTTOM)
                left(33.5)
                {
                    cuboid([8.0, 30, 3.7], anchor=TOP) {
                        position(BOTTOM)
                        cuboid([14.5, 30, 3], anchor=TOP);
                    }
                }
                
                position(BOTTOM)
                right(33.5)
                {
                    cuboid([8.0, 30, 3.7], anchor=TOP) {
                        position(BOTTOM)
                        cuboid([14.5, 30, 3], anchor=TOP);
                    }
                }
                
                position(TOP + LEFT + FRONT)
                prismoid(size1=[5,15], size2=[5,0], shift=[0,15/2], h=35, anchor=BOTTOM + LEFT + FRONT);
                
                position(TOP + RIGHT + FRONT)
                prismoid(size1=[5,15], size2=[5,0], shift=[0,15/2], h=35, anchor=BOTTOM + RIGHT + FRONT);
            }
        }
    }
}

module right_component() {
    diff() {
        cuboid([55, 15, 35], anchor=BOTTOM + FRONT) {
            
            tag("remove")
            position(BACK)
            ycyl(d=8.2, h=20, anchor=BACK);
            
            tag("remove")
            position(BACK)
            ycyl(d=10.2, h=10.5, anchor=BACK);
            
            tag("remove")
            left(8)
            position(BACK)
            ycyl(d=2, h=6, anchor=BACK);
            
            tag("remove")
            right(8)
            position(BACK)
            ycyl(d=2, h=6, anchor=BACK);
            
            tag("remove")
            up(8)
            position(BACK)
            ycyl(d=2, h=6, anchor=BACK);
            
            tag("remove")
            down(8)
            position(BACK)
            ycyl(d=2, h=6, anchor=BACK);
            
            position(BOTTOM + FRONT)
            cuboid([90, 15, 5], anchor=TOP + FRONT) {
                tag("remove")
                left(68/2)
                position(BOTTOM)
                zcyl(d=5, h=5, anchor=BOTTOM);
                
                tag("remove")
                right(68/2)
                position(BOTTOM)
                zcyl(d=5, h=5, anchor=BOTTOM);
                
                position(BOTTOM)
                cuboid([8.1, 14.5, 3.5], anchor=TOP) {
                    position(BOTTOM)
                    cuboid([15, 15, 3], anchor=TOP);
                }
            }
            
            position(BOTTOM + FRONT)
            cuboid([90, 15, 5], anchor=TOP + BACK) {
                
                position(BOTTOM)
                left(33.5)
                {
                    cuboid([8.1, 14.5, 3.5], anchor=TOP) {
                        position(BOTTOM)
                        cuboid([15, 15, 3], anchor=TOP);
                    }
                }
                
                position(BOTTOM)
                right(33.5)
                {
                    cuboid([8.1, 14.5, 3.5], anchor=TOP) {
                        position(BOTTOM)
                        cuboid([15, 15, 3], anchor=TOP);
                    }
                }
                
                left(55/2)
                position(TOP)
                prismoid(size1=[5,15], size2=[5,0], shift=[0,15/2], h=35, anchor=BOTTOM + LEFT);
                
                right(55/2)
                position(TOP)
                prismoid(size1=[5,15], size2=[5,0], shift=[0,15/2], h=35, anchor=BOTTOM + RIGHT);
            }
        }
    }
}


left2_component();