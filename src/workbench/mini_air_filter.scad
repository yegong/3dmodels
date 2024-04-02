$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>

$e = 0.01;
$e2 = 0.02;

th = 2;
th0 = th / 2;
th2 = th * 2;

fan_w = 60;
fan_h = 38;
fan_screw_d = 3.2;
fan_screw_offset = 5;
fan_screw_corner = 14;

h = 180;

r = 1;

hepa_w = 17 + th;
carbon_w = 15 + th2;
spacer_w = 22;
filter_h = h - 10 * 2 - th * 4;
filter_w = spacer_w + hepa_w + carbon_w;

pillar_d = 6;
pillar_id = 3.8;
pillar_ih = 8;
m3_d = 3.2;

tlr = 0.1;
tlr2 = tlr * 2;

// 主框架，容纳风扇、风道
module main_frame() {
    diff() {
        // 风扇部分背面
        cuboid([fan_w + th2, th, h], rounding = r, except = [FRONT, RIGHT], anchor = RIGHT) {
            // 左侧板
            position(LEFT + FRONT)
            cuboid([th, fan_w + th, h], rounding = r, except = [BACK, RIGHT], anchor = LEFT + BACK);
            // 右侧板
            position(TOP + RIGHT + FRONT)
            cuboid([th, fan_w, fan_h + th2], anchor = TOP + RIGHT + BACK) {
                // 右侧板顶部对齐
                position(TOP + FRONT)
                cuboid([th, th, th], rounding = r, edges = [TOP + FRONT], anchor = TOP + BACK);
            }
            // 底板
            position(BOTTOM + FRONT)
            cuboid([fan_w + th2, fan_w + th, th], rounding = r, except = [TOP, BACK, RIGHT], anchor = BOTTOM + BACK);
            
            // 风扇上下限位
            position(TOP + FRONT)
            cuboid([fan_w + th2, th, th], rounding = r, edges = [LEFT + TOP], anchor = TOP + BACK);
            position(TOP + FRONT)
            down(fan_h + th)
            cuboid([fan_w + th2, th, th], anchor = TOP + BACK);
            
            // 风扇左侧滑槽
            position(TOP + LEFT + FRONT)
            right(th)
            cuboid([th, fan_w + th, th], rounding = r, edges = [FRONT + TOP], anchor = TOP + LEFT + BACK);
            position(TOP + LEFT + FRONT)
            right(th)
            down(fan_h + th)
            cuboid([th, fan_w, th], anchor = TOP + LEFT + BACK);
            
            // 风扇左后螺丝
            position(TOP + LEFT + FRONT)
            right(th)
            wedge([th, fan_screw_corner, fan_screw_corner], orient = RIGHT, spin=180, anchor = FRONT + RIGHT + BOTTOM) {
                tag("remove")
                up(fan_screw_offset)
                back(fan_screw_offset)
                position(FRONT + BOTTOM)
                xcyl(d = fan_screw_d, h = th);
            }
            
            // 风扇右后螺丝
            position(TOP + RIGHT + FRONT)
            left(th)
            wedge([th, fan_screw_corner, fan_screw_corner], orient = LEFT, spin=180, anchor = FRONT + LEFT + BOTTOM) {
                tag("remove")
                up(fan_screw_offset)
                back(fan_screw_offset)
                position(FRONT + BOTTOM)
                xcyl(d = fan_screw_d, h = th);
            }
            
            // 风扇右侧滑槽
            position(TOP + RIGHT + FRONT)
            left(th)
            cuboid([th, fan_w + th, th], rounding = r, edges = [FRONT + TOP], anchor = TOP + RIGHT + BACK);
            position(TOP + RIGHT + FRONT)
            left(th)
            down(fan_h + th)
            cuboid([th, fan_w, th], anchor = TOP + RIGHT + BACK);
            
            // 左中支撑
            position(LEFT + FRONT)
            right(th)
            cube([th0, fan_w, th], anchor = LEFT + BACK);
            position(LEFT + FRONT)
            right(th)
            down(h/4)
            cube([th0, fan_w, th], anchor = LEFT + BACK);
            
            // 左上热熔螺母位置(5, 5 + fan_h + th)
            position(TOP + LEFT + FRONT)
            right(5 + th)
            down(5 + fan_h + th2)
            ycyl(d = pillar_d, h = fan_w, anchor = BACK) {
                tag("remove")
                position(FRONT)
                ycyl(d = pillar_id, h = pillar_ih, anchor = FRONT);
            }
            
            // 左下热熔螺母位置(5, 5)
            position(BOTTOM + LEFT + FRONT)
            right(5 + th)
            up(5 + th)
            ycyl(d = pillar_d, h = fan_w, anchor = BACK) {
                tag("remove")
                position(FRONT)
                ycyl(d = pillar_id, h = pillar_ih, anchor = FRONT);
            }
            
            // 滤芯部分背面
            position(RIGHT)
            cuboid([filter_w, th, h], rounding = r, except = [FRONT, LEFT], anchor = LEFT) {
                // 顶板
                position(TOP + FRONT)
                cuboid([filter_w, fan_w + th, th], rounding = r, except = [BOTTOM, BACK, LEFT], anchor = TOP + BACK);
                // 底板
                position(BOTTOM + FRONT)
                cuboid([filter_w, fan_w + th, th], rounding = r, except = [TOP, BACK, LEFT], anchor = BOTTOM + BACK);
                
                // 滤芯风道顶板
                position(TOP + FRONT)
                down(10 + th)
                cuboid([filter_w, fan_w, th], anchor = TOP + BACK) {
                    // 滤芯风道顶板上设置卡扣
                    position(BOTTOM + RIGHT)
                    prismoid(size1 = [tlr2, 2], size2=[0, 0], shift=[-tlr, 0], h = th, orient=RIGHT, anchor = TOP + RIGHT);
                }
                
                // 滤芯风道顶板上方装饰
                down(th)
                position(TOP + RIGHT + FRONT)
                cuboid([th, fan_w, 10], anchor = TOP + RIGHT + BACK);
                
                // 滤芯风道底板
                position(BOTTOM + FRONT)
                up(10 + th)
                cuboid([filter_w, fan_w, th], anchor = BOTTOM + BACK) {
                    // 滤芯风道底板上设置卡扣
                    position(TOP + RIGHT)
                    prismoid(size1 = [tlr2, 2], size2=[0, 0], shift=[tlr, 0], h = th, orient=RIGHT, anchor = TOP + RIGHT);
                }
                
                // 滤芯风道底板封闭
                up(th)
                position(BOTTOM + LEFT + FRONT)
                cuboid([th, fan_w, 10], anchor = BOTTOM + LEFT + BACK);
            
                // 滤芯右侧背板限位
                left(hepa_w + carbon_w)
                position(RIGHT + FRONT)
                cuboid([th, th, filter_h], anchor = RIGHT + BACK);
            
                // 滤芯右侧顶板限位
                left(hepa_w + carbon_w)
                down(10 + th2)
                position(TOP + RIGHT + FRONT)
                cuboid([th, fan_w, th], anchor = TOP + RIGHT + BACK);
            
                // 滤芯右侧底板限位
                left(hepa_w + carbon_w)
                up(10 + th2)
                position(BOTTOM + RIGHT + FRONT)
                cuboid([th, fan_w, th], anchor = BOTTOM + RIGHT + BACK);
                
                // 滤芯风道底板下方装饰
                up(th)
                position(BOTTOM + RIGHT + FRONT)
                cuboid([th, fan_w, 10], anchor = BOTTOM + RIGHT + BACK);
            
                // 中上热熔螺母位置(filter_w - 5, 5)
                position(TOP + RIGHT + FRONT)
                left(filter_w - 5)
                down(5 + th)
                ycyl(d = pillar_d, h = fan_w, anchor = BACK) {
                    tag("remove")
                    position(FRONT)
                    ycyl(d = pillar_id, h = pillar_ih, anchor = FRONT);
                }
            
                // 右上热熔螺母位置(5, 5)
                position(TOP + RIGHT + FRONT)
                left(5 + th)
                down(5 + th)
                ycyl(d = pillar_d, h = fan_w, anchor = BACK) {
                    tag("remove")
                    position(FRONT)
                    ycyl(d = pillar_id, h = pillar_ih, anchor = FRONT);
                }
            
                // 右下热熔螺母位置(5, 5)
                position(BOTTOM + RIGHT + FRONT)
                left(5 + th)
                up(5 + th)
                ycyl(d = pillar_d, h = fan_w, anchor = BACK) {
                    tag("remove")
                    position(FRONT)
                    ycyl(d = pillar_id, h = pillar_ih, anchor = FRONT);
                }
            }
        }
    }
}

module cover() {
    diff() {
        // 风扇部分盖子
        cuboid([fan_w + th - tlr, th, h - th2 - tlr2], anchor = RIGHT) {
            // 风扇出风口上沿
            right(th)
            position(TOP + LEFT)
            cuboid([fan_w - th2 - tlr2, th, th + tlr], rounding = r, edges = [FRONT + TOP], anchor = BOTTOM + LEFT) {
                // 风扇出风口上沿内扣
                position(BACK)
                cuboid([fan_w - th2 - tlr2, th - tlr, th + tlr], anchor = FRONT);
            
                // 风扇左前螺丝
                position(TOP + LEFT + BACK)
                wedge([th, fan_screw_corner, fan_screw_corner], orient = RIGHT, anchor = FRONT + LEFT + BOTTOM) {
                    tag("remove")
                    up(fan_screw_offset - tlr)
                    back(fan_screw_offset)
                    position(FRONT + BOTTOM)
                    xcyl(d = fan_screw_d, h = th);
                }
                
                // 风扇右后螺丝
                position(TOP + RIGHT + BACK)
                wedge([th, fan_screw_corner, fan_screw_corner], orient = LEFT, anchor = FRONT + RIGHT + BOTTOM) {
                    tag("remove")
                    up(fan_screw_offset - tlr)
                    back(fan_screw_offset)
                    position(FRONT + BOTTOM)
                    xcyl(d = fan_screw_d, h = th);
                }
            }
            
            // 风扇出风口下沿
            position(TOP + RIGHT + BACK)
            left(th2 + tlr)
            down(fan_h)
            cuboid([fan_w - th2 - tlr2, th, th], anchor = TOP + RIGHT + FRONT);
            
            // 左上热熔螺母位置(5 + fan_h + th, 5)
            tag("remove")
            position(LEFT + TOP)
            right(5 - tlr)
            down(5 + fan_h + th - tlr)
            ycyl(d = m3_d, h = th);
            
            // 左下热熔螺母位置(5, 5)
            tag("remove")
            right(5 - tlr)
            up(5 - tlr)
            position(LEFT + BOTTOM)
            ycyl(d = m3_d, h = th);
            
            // 滤芯部分盖子
            position(RIGHT)
            cuboid([filter_w, th, h - th2 - tlr2], rounding = r, edges = [FRONT + RIGHT], anchor = LEFT) {
                // 滤芯右侧底板限位
                left(hepa_w + carbon_w)
                position(RIGHT + BACK)
                cuboid([th, th, filter_h - th2 - tlr2], anchor = RIGHT + FRONT);
                
                // 中上热熔螺母位置(filter_w - 5, 5)
                tag("remove")
                position(TOP + RIGHT + FRONT)
                left(filter_w - 5)
                down(5 + th - tlr)
                ycyl(d = m3_d, h = th);
                
                // 右上热熔螺母位置(5, 5)
                tag("remove")
                position(TOP + RIGHT + FRONT)
                left(5 + th)
                down(5 + th - tlr)
                ycyl(d = m3_d, h = th);
            
                // 右下热熔螺母位置(5, 5)
                tag("remove")
                position(BOTTOM + RIGHT + FRONT)
                left(5 + th)
                up(5 + th + tlr)
                ycyl(d = m3_d, h = th);
            }
        }
    }
}

module hepa() {
    // 滤芯出风侧
    rect_tube(size = [fan_w - tlr2, filter_h - tlr2], wall = th2, h = th0, orient = RIGHT, spin = 90, anchor = BOTTOM) {
        
        // 滤芯出风侧中间放置
        for (of = [-filter_h/2 : filter_h/8 : filter_h/2-$e]) {
            fwd(of)
            position(BOTTOM)
            cuboid([fan_w - tlr2, th, th0], anchor = BOTTOM);
        }
        
        // 滤芯四周围栏
        position(TOP)
        rect_tube(size = [fan_w - tlr2, filter_h - tlr2], wall = th, h = hepa_w - th0 - tlr2, anchor = BOTTOM);
    }
}

module activated_carbon() {
    diff() {
        // 滤芯出风侧
        cuboid(size = [fan_w - tlr2, filter_h - tlr2, th], orient = RIGHT, spin = 90, anchor = BOTTOM) {
            // 滤芯四周围栏
            position(TOP)
            rect_tube(size = [fan_w - tlr2, filter_h - tlr2], wall = th, h = carbon_w - th2 - tlr2, anchor = BOTTOM) {
                position(TOP)
                // 滤芯进风侧
                cuboid(size = [fan_w - tlr2, filter_h - tlr2, th], anchor = BOTTOM);
            }
            
            // 滤芯进风侧、出风侧开孔
            tag("remove") {
                h_step = (filter_h - th2 - th) / 16;
                w_step = (fan_w - th2) / 18;
                for (i = [0 : h_step : filter_h - h_step]) {
                    for (j = [0 : w_step : fan_w - th2 - w_step]) {
                        fwd(i + th2 + h_step * 0.05)
                        right(j + th + w_step * 0.167)
                        position(LEFT + BACK + BOTTOM)
                        cuboid([w_step * 0.67, h_step * 0.9, hepa_w], anchor = LEFT + BACK + BOTTOM);
                    }
                }
            }
            
            // 顶部加注口板面厚度增加到th2
            position(BOTTOM + BACK)
            cuboid([fan_w - tlr2, th2, carbon_w - tlr2], anchor = BOTTOM + BACK) {
                // 第一层开size缩小th * 0.5的孔
                tag("remove")
                position(BACK)
                cuboid([fan_w - tlr2 - th, th, carbon_w - tlr2 - th], anchor = BACK) {
                    tag("remove")
                    right(th * 0.2)
                    position(LEFT)
                    cuboid([th * 0.7, th * 1.2, 5], anchor = RIGHT);
                }
                
                // 第一层开size缩小th的孔
                tag("remove")
                fwd(th)
                position(BACK)
                cuboid([fan_w - tlr2 - th * 2, th, carbon_w - tlr2 - th * 2], anchor = BACK);
            }
        }
    }
}

module activated_carbon_cover() {
    // 盖板
    cuboid([fan_w - tlr2 * 2 - th, carbon_w - tlr2 * 2 - th, th - tlr]) {
        // 盖板内圈
        position(TOP)
        rect_tube(size = [fan_w - tlr2 * 2 - th * 2, carbon_w - tlr2 * 2 - th * 2], wall = th0, h = th2);
        
        // 两边各自放置一个卡扣
        up(th)
        left(fan_w / 2 - tlr - th)
        position(TOP)
        prismoid(size1 = [tlr2, 2], size2=[0, 0], shift=[tlr, 0], h = th, anchor = BOTTOM);
            
        up(th)
        right(fan_w / 2 - tlr - th)
        position(TOP)
        prismoid(size1 = [tlr2, 2], size2=[0, 0], shift=[-tlr, 0], h = th, anchor = BOTTOM);
        
    }
}
main_frame();