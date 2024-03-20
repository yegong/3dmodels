$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>

$e1 = 0.01;
$e2 = 0.02;
$e3 = 0.03;
$e4 = 0.04;

th = 2;
th3 = th * 3;

module holder() {
    height = 100;
    base = 20;
    joint = 10;
    
    cuboid([base, height, th], anchor = BOTTOM) {
        left(th)
        position(TOP)
        cuboid([th, height, joint], anchor = BOTTOM);
        
        right(th)
        position(TOP)
        cuboid([th, height, joint], anchor = BOTTOM);
        
        position(TOP + BACK)
        cuboid([th3, th, joint], anchor = BOTTOM + BACK);
    }
}

module joint(ways, has_bottom) {
    height = 20;
    joint = 10;
    cuboid([th3, th3, height], anchor = BOTTOM) {
        if (has_bottom) {
            position(LEFT + BOTTOM)
            cuboid([joint, th3, th], anchor = RIGHT + BOTTOM);
        }
            
        back(th)
        position(LEFT)
        cuboid([joint, th, height], anchor = RIGHT);
        
        fwd(th)
        position(LEFT)
        cuboid([joint, th, height], anchor = RIGHT);
        
        if (has_bottom) {
            position(RIGHT + BOTTOM)
            cuboid([joint, th3, th], anchor = LEFT + BOTTOM);
        }
            
        back(th)
        position(RIGHT)
        cuboid([joint, th, height], anchor = LEFT);
        
        fwd(th)
        position(RIGHT)
        cuboid([joint, th, height], anchor = LEFT);
        
        if (ways >= 3) {
            if (has_bottom) {
                position(FRONT + BOTTOM)
                cuboid([th3, joint, th], anchor = BACK + BOTTOM);
            }
                
            left(th)
            position(FRONT)
            cuboid([th, joint, height], anchor = BACK);
            
            right(th)
            position(FRONT)
            cuboid([th, joint, height], anchor = BACK);
        }
        
        if (ways == 4) {
            if (has_bottom) {
                position(BACK + BOTTOM)
                cuboid([th3, joint, th], anchor = FRONT + BOTTOM);
            }
                
            left(th)
            position(BACK)
            cuboid([th, joint, height], anchor = FRONT);
            
            right(th)
            position(BACK)
            cuboid([th, joint, height], anchor = FRONT);
        }
    }
}

module panel(length) {
    height = 100;
    cuboid([length, height, th - 0.25], anchor = BOTTOM) {
        position(TOP + BACK)
        cuboid([length, th, th3], anchor = BOTTOM + BACK);
    }
    
}

panel(138);