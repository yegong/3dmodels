$fn= $preview ? 32 : 64;
$fa = 3;
$E = 0.01;
$E2 = $E*2;

include <BOSL2/std.scad>

// 用于叠放嘉立创等纸盒的抽屉架
// 侧板使用Honeycomb(HCB)系统，这里只需要制作隔板
// * 隔板对于HCB的孔的位置，嵌入螺母连接
// * 隔板热熔螺母的距离不对称，前后翻转后正好相差1/2 dist_2，也就是两个相邻单元在水平面投影的距离
// * 隔板是一个矩形/正方形，前后方中部各切掉一块梯形区域方便抓取

// 抽屉尺寸 175 x 175
depth = 175;
width = 175;
// 前后方切割部分深度
cut_depth = 25;
// 前后方被切割后形成的3个平行边边长
sub_edge = (depth - cut_depth / tan(60) * 2) / 3;

// 壁、厚数据
th_shell = 4;
th_h = 3.2;
th_inner = 1.6;

// 隔板六边形间距
hex_dist_1 = 13.4 + th_inner;
hex_dist_2 = hex_dist_1 * cos(30) * 2;
hex_opposite_side = hex_dist_1 - th_inner;
hex_side = hex_opposite_side / tan(60);
rows = (ceil(depth / 2 / hex_dist_1) + 1) * 4;
cols = (ceil(width / 2 / hex_dist_2) + 1) * 2;

// HSW间距
hsw_dist_1 = 23.6; // 距离为1的单元
hsw_dist_2 = 40.88; // 距离为2的单元，也是同一排最近的两个单元

// M3螺母数据
m3_nut_opposite_side = 5.5;
m3_nut_side = m3_nut_opposite_side / tan(60);
m3_nut_th = 2.4;

// 适配器尺寸
adapter_height = 13.4 / 2;
adapter_side = adapter_height / tan(60) * 2;
adapter_th = 4;

// 螺母数量和第一个螺母的位置
nuts = floor((depth - hsw_dist_2 / 2 - m3_nut_side * 2) / hsw_dist_2) + 1;
nut_offset = (depth - (hsw_dist_2 / 2) - hsw_dist_2 * (nuts - 1)) / 2;

echo(nut_offset);
echo(depth - nut_offset - (nuts - 1) * hsw_dist_2);

// M3螺栓直径
m3_d = 3.2;

// 支座壁厚
foot_th = adapter_th;
// 支座接地面宽度
foot_width = adapter_th + 2 * 7.5;
foot_depth = depth;
// 高度等于HSW单元
foot_hex_opposite_side = 23.6;
foot_hex_side = foot_hex_opposite_side / tan(60);


module drawer_deck() {
    // 抽屉板的多边形（外框）
    linear_extrude(th_h) {
        shell2d(-th_shell) {
            // 抽屉板的多边形外边界
            deck_shape();
        }
    }
    
    // 抽屉板的多边形再生成一次多边形（填充），删除其中六边形，保留蜂巢结构
    diff() {
        force_tag("")
        linear_extrude(th_h) {
            deck_shape();
        }
        // 删除蜂巢结构
        for (r = [-rows/2 : rows/2]) {
            for (c = [-cols/2 : cols/2]) {
                y = r / 2 * hex_dist_1;
                x = r % 2 == 0 ? c * hex_dist_2 : (c - 1/2) * hex_dist_2;
                
                force_tag("remove")
                move([x, y, 0])
                linear_extrude(th_h) {
                    hexagon(side = hex_side);
                }
            }
        }
    }
    // 两边到HCB的连接，使用螺栓以增强稳定性
    for (i = [0:nuts-1]) {
        back(nut_offset + hsw_dist_2 * i)
        fwd(depth/2) {
            left(width/2 - adapter_th/2)
            zrot(90)
            hsw_m3_adapter();
            
            right(width/2 - adapter_th/2)
            zrot(-90)
            hsw_m3_adapter();
        }
    }
}

module deck_shape() {
    polygon([
        [-width/2, -depth/2],
        [-width/2, depth/2],
        [-width/2 + sub_edge, depth/2],
        [-sub_edge/2, depth/2 - cut_depth],
        [sub_edge/2, depth/2 - cut_depth],
        [width/2 - sub_edge, depth/2],
        [width/2, depth/2],
        [width/2, -depth/2],
        [width/2 - sub_edge, -depth/2],
        [sub_edge/2, -depth/2 + cut_depth],
        [-sub_edge/2, -depth/2 + cut_depth],
        [-width/2 + sub_edge, -depth/2],
    ]);
}

module hsw_m3_adapter() {
    diff() {
        prismoid(size1 = [adapter_side, adapter_th], size2 = [adapter_side * 2, adapter_th], h = adapter_height, anchor = TOP) {
            tag("remove")
            ycyl(d = m3_d, h = adapter_th);
            
            tag("remove")
            position(FRONT)
            xrot(-90)
            linear_extrude(m3_nut_th)
            hexagon(side = m3_nut_side);
        }
    }
}

module hsw_foot_m3_adapter() {
    diff("remove2") {
        up(foot_hex_opposite_side/2)
        right(foot_th / 2)
        cube([0, 0, 0], anchor = RIGHT) {
            yrot(-90)
            linear_extrude(foot_th)
            hexagon(side = foot_hex_side, realign=true);
            
            tag("remove2")
            xcyl(d = m3_d, h = 5, anchor = RIGHT);
            
            tag("remove2")
            position(FRONT)
            yrot(-90)
            linear_extrude(m3_nut_th)
            hexagon(side = m3_nut_side, realign=true);
        }
    }
}

// 单独的模块，生成HSW的支撑脚
module hsw_foot() {
    diff() {
        cuboid([foot_width, foot_depth, foot_th / 2], chamfer = foot_width / 4, except = [TOP, BOTTOM]) {
            for (i = [0:nuts-1]) {
                back(nut_offset + hsw_dist_2 * i) {
                    position(FRONT + TOP)
                    hsw_foot_m3_adapter();
                    
                    tag("remove")
                    position(FRONT + BOTTOM)
                    cuboid([foot_th / 3, foot_hex_side - foot_th * 2, foot_th / 2 + foot_hex_opposite_side / 3], anchor = BOTTOM);
                }
            }
        }
    }
}

hsw_foot();