$fn= $preview ? 32 : 64;
$fa = 3;
$E = 0.01;
$E2 = $E*2;

include <BOSL2/std.scad>

// 灯带非标铝型材2040 端盖
// 宽40mm x 高20mm x 壁厚0.9mm
// 盖宽10mm，中间留D6孔走线

module ledstrip_2040(length=10) {
    al_w = 40;
    al_h = 20;
    al_th = 0.9;
    tlr = 0.1;
    tlr2 = tlr * 2;
    diff() {
        // 端盖主体
        cuboid([al_w, al_h, length], rounding = 2, except=[TOP, BACK]) {
            // 穿线孔
            tag("remove")
            position(BOTTOM)
            zcyl(d = 6, h = length, anchor = BOTTOM);
            
            // 背部固定片，厚度1.5
            fwd(al_th)
            position(TOP + BACK)
            cuboid([40 - al_th * 2 - tlr * 2, 1.5, 10], anchor = BOTTOM + BACK) {
                // 背部固定片两端加厚以卡入型材背部和侧板的缝隙
                for (d = [LEFT, RIGHT]) {
                    position(d + BACK)
                    prismoid(size1 = [3, 3.8], size2 = [3, 2.8], shift = [0, 0.5], h = 10, anchor = d + BACK);
                }
                // 固定片卡子
                position(TOP + BACK)
                prismoid(size1 = [3, tlr2], size2 = [3, 0], shift = [0, -tlr], h = 3, anchor = TOP + FRONT);
            }
            
            // 左侧固定片
            position(TOP + LEFT + BACK)
            fwd(8.5)
            right(al_th)
            cuboid([1.5, 6, 10], anchor = BOTTOM + LEFT + BACK) {
                // 固定片卡子
                position(TOP + LEFT)
                prismoid(size1 = [tlr2, 3], size2 = [0, 3], shift = [tlr, 0], h = 3, anchor = TOP + RIGHT);
            }
            
            // 右侧固定片
            position(TOP + RIGHT + BACK)
            fwd(8.5)
            left(al_th)
            cuboid([1.5, 6, 10], anchor = BOTTOM + RIGHT + BACK) {
                // 固定片卡子
                position(TOP + RIGHT)
                prismoid(size1 = [tlr2, 3], size2 = [0, 3], shift = [-tlr, 0], h = 3, anchor = TOP + LEFT);
            }
        }
    }
}

// 线槽, 向槽底转向
module cable_duct_base_45(length) {
    th = 0.8;
    iw = 5;
    ih = 3;
    bw = iw + 4 * th;
    bh = ih + th;
    
    diff() {
        cuboid([bw, length + bh, bh]) {
            tag("remove")
            position(BOTTOM)
            cuboid([bw - th * 2, length + bh, ih], anchor = BOTTOM);
            
            tag("remove")
            position(FRONT)
            prismoid(size1 = [bw, 0], size2 = [bw, bh], shift=[0, bh/2], h = bh, anchor = FRONT);
        }
    }
}

// 线槽, 向槽底转向
module cable_duct_cover_45(length) {
    th = 0.8;
    iw = 5;
    ih = 3;
    bw = iw + 4 * th;
    bh = ih + th;
    
    diff() {
        cuboid([bw, length + bh + th, th]) {
            right(th + 0.1)
            position(TOP + LEFT)
            cuboid([th, length + bh + th, ih], anchor = BOTTOM + LEFT) {
                if (length > 40) {
                    for (i = [0 : 20 : length - 20]) {
                        // 固定片卡子
                        fwd(i + 10)
                        position(TOP + LEFT + BACK)
                        prismoid(size1 = [0.2, 2], size2 = [0, 1], shift = [0.1, 0], h = ih/2, anchor = TOP + RIGHT + BACK);
                    }
                }
                else {
                    position(TOP + LEFT)
                    prismoid(size1 = [0.2, 2], size2 = [0, 1], shift = [0.1, 0], h = ih/2, anchor = TOP + RIGHT);
                }
            }
            
            left(th + 0.1)
            position(TOP + RIGHT)
            cuboid([th, length + bh + th, ih], anchor = BOTTOM + RIGHT) {
                if (length > 40) {
                    for (i = [0 : 20 : length - 20]) {
                        // 固定片卡子
                        fwd(i + 10)
                        position(TOP + RIGHT + BACK)
                        prismoid(size1 = [0.2, 2], size2 = [0, 1], shift = [-0.1, 0], h = ih/2, anchor = TOP + LEFT + BACK);
                    }
                }
                else {
                    position(TOP + RIGHT)
                    prismoid(size1 = [0.2, 2], size2 = [0, 1], shift = [-0.1, 0], h = ih/2, anchor = TOP + LEFT);
                }
            }
            
            tag("remove")
            position(FRONT + BOTTOM)
            prismoid(size1 = [bw, 0], size2 = [bw, bh + th], shift=[0, (bh + th)/2], h = bh + th, anchor = FRONT + BOTTOM);
        }
    }
}

ledstrip_2040(130);
