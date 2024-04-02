$fn= $preview ? 32 : 64;

include <BOSL2/std.scad>

$e = 0.01;
$e2 = 0.02;

th = 1.6;
th2 = th * 2;
th0 = th / 2;

// 末端软管连接设备的公头
module pipe_male_connector() {

    // 连接设备的公头
    tube(h=10, od1=24.5, od2=25, id=21, anchor = BOTTOM) {
        position(TOP)
        tube(h=1, od1 = 25, od2=25 + 1 * 2, id = 21, anchor = BOTTOM);
        
        // 无支撑的台阶，用于分割两段接头，避免任意一侧过度插入
        up(1)
        position(TOP)
        tube(h=1, od = 25 + 1 * 2, id = 21, anchor = BOTTOM);
        
        up(2)
        position(TOP)
        tube(h=1, od1 = 25 + 1 * 2, od2 = 25, id = 21, anchor = BOTTOM);
        
        // 和25内径软管对接
        up(3)
        position(TOP)
        tube(h=40, od1=25, od2=24.5, id = 21, anchor = BOTTOM);
        
        // 十字强化
        position(BOTTOM) {
            cuboid([21, th0, 10 + 3 + 40], anchor = BOTTOM);
            cuboid([th0, 21, 10 + 3 + 40], anchor = BOTTOM);
        }
    }
}

// 台锯母头
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


// 吸尘箱母头转换为内部软管
module box_famale_to_pipe() {
    // 母头，对接外部吸尘管
    tube(h = 10, id1 = 25, id2 = 24.5, wall = th, anchor = BOTTOM);
    
    // 直径过度
    up(10)
    tube(h = 3, id1 = 24.5, wall = th, od2 = 26.5, id2 = 21, anchor = BOTTOM) {
        
        // 十字强化
        position(TOP) {
            cuboid([24.5, th0, 3], anchor = TOP);
            cuboid([th0, 24.5, 3], anchor = TOP);
        }
    }
    
    // 接内部25内径软管对接
    up(13)
    tube(h = 30, od1 = 26.5, od2 = 25.5, id = 21, anchor = BOTTOM) {
        
        // 十字强化
        position(TOP) {
            cuboid([21, th0, 30], anchor = TOP);
            cuboid([th0, 21, 30], anchor = TOP);
        }
    }
    
    // 底座
    diff() {
        cuboid([40, 40, 1.5],
                rounding = 1,
                except=[TOP, BOTTOM],
                anchor = TOP
                );
        
        tag("remove")
        up($e)
        zcyl(d = 25, h = 1.5 + $e2, anchor = TOP);
    }
    
}
// 吸尘器管道桌面过孔，分别对接32和25内径管道
module table_via_hole() {
    diff() {
        // 过孔
        cuboid(size = [27, 50, 32], rounding = 2, except = [TOP, BOTTOM], anchor = BOTTOM) {
            
            // 和25内径软管对接
            position(TOP)
            tube(od1 = 24.5, od2 = 25, id1 = 21, id2 = 21, h = 40, anchor = BOTTOM) {
                // 十字强化
                tag("keep")
                position(TOP) {
                    cuboid([24.5, th0, 40], anchor = TOP);
                    cuboid([th0, 24.5, 40], anchor = TOP);
                }
            }
            
            // 在过孔中心打孔
            tag("remove")
            position(TOP)
            zcyl(d1 = 24, d2 = 21, h = 32, anchor = TOP);
            
            // 十字强化
            tag("keep")
            position(TOP) {
                cuboid([27, th0, 32], anchor = TOP);
                cuboid([th0, 50, 32], anchor = TOP);
            }
            
            // 接桌面下方32管道
            //// 化方为圆形
            position(BOTTOM)
            rect_tube(size1 = [33, 33], size2 = [27, 50], isize2 = [24, 24], h = 10, rounding1 = 16.5, rounding2 = 2, irounding2 = 12, wall = th, anchor = TOP) {
            
                // 十字强化
                tag("keep")
                position(BOTTOM) {
                    cuboid([27, th0, 10], anchor = BOTTOM);
                    cuboid([th0, 33, 10], anchor = BOTTOM);
                    cuboid([30, th0, 5], anchor = BOTTOM);
                }
                
                //// 和32内径软管对接
                position(BOTTOM)
                tube(od1 = 32, od2 = 33, wall = th, h = 40, anchor = TOP) {
                    // 十字强化支持
                    position(BOTTOM) {
                        cuboid([32, th0, 40], anchor = BOTTOM);
                        cuboid([th0, 32, 40], anchor = BOTTOM);
                    }
                }
            }
        }
    }
}

// 焊台用过滤器，活性炭容器
module solder_vacuum_filter() {
    diff() {
        // 容器外壳
        cuboid([80, 80, 25], anchor = BOTTOM) {
            
            // 容器空腔
            tag("remove")
            position(TOP)
            cuboid([80 - th2, 80 - th2, 25 - th], anchor = TOP);
            
            // 背部网格
            tag("remove") {
                for (i = [0 : 9.6 : 67.2]) {
                    for (j = [0 : 3.072 : 73.728]) {
                        fwd(i + th + th0)
                        right(j + th + th0)
                        position(LEFT + BACK + BOTTOM)
                        cuboid([2, 10 - th, th], anchor = LEFT + BACK + BOTTOM);
                    }
                }
            }
            
            for (i = [-1, 1]) {
                for (j = [-1, 1]) {
                    of = 80 / 2 - 12 / 2 - th;
                    left(i * of)
                    back(j * of) {
                        //磁铁区域底部不设置网格
                        tag("keep")
                        position(BOTTOM)
                        cuboid(size = [12, 12, th0], anchor = BOTTOM);
                        
                        //磁铁区域底部不设置网格
                        tag("remove")
                        up(th0)
                        position(BOTTOM)
                        cuboid(size = [12, 12, th0], anchor = BOTTOM);
                        
                        //磁铁外径约束
                        tag("keep")
                        up(th0)
                        position(BOTTOM)
                        rect_tube(size = [12, 12], isize = [10.5, 10.5], irounding = 5, wall = 2, h = 2.5, anchor = BOTTOM);
                    }
                }
            }
        }
    }
}


// 焊台用过滤器，活性炭容器盖子
module solder_vacuum_filter_cover() {
    diff() {
        // 底部外框
        cuboid([80, 80, th2], anchor = BOTTOM) {
            // 网格
            tag("remove") {
                for (i = [0 : 9.6 : 67.2]) {
                    for (j = [0 : 3.072 : 73.728]) {
                        fwd(i + th + th0)
                        right(j + th + th0)
                        position(LEFT + BACK + BOTTOM)
                        cuboid([2, 10 - th, th2], anchor = LEFT + BACK + BOTTOM);
                    }
                }
            }
            
            // 嵌入容器另一半的部分
            position(TOP)
            rect_tube(size = [80 - th2 - 0.3, 80 - th2 - 0.3], wall = th0, h = th2, anchor = BOTTOM);
            
            // 四边各自放置一个卡扣
            up(th)
            left(40 - th)
            position(TOP)
            prismoid(size1 = [0.2, 2], size2=[0, 0], shift=[0.1, 0], h = th, anchor = BOTTOM);
            
            up(th)
            right(40 - th)
            position(TOP)
            prismoid(size1 = [0.2, 2], size2=[0, 0], shift=[-0.1, 0], h = th, anchor = BOTTOM);
            
            up(th)
            fwd(40 - th)
            position(TOP)
            prismoid(size1 = [2, 0.2], size2=[0, 0], shift=[0, 0.1], h = th, anchor = BOTTOM);
            
            up(th)
            back(40 - th)
            position(TOP)
            prismoid(size1 = [2, 0.2], size2=[0, 0], shift=[0, -0.1], h = th, anchor = BOTTOM);
            
            // 设置缺口方便拆卸
            tag("remove")
            position(TOP + LEFT)
            cuboid([th, 4, th0], anchor = TOP + LEFT);
        }
    }
}

// 焊台用过滤器，转为软管母头
module solder_vacuum_female_adapter() {
    diff() {
        // 底层框架
        rect_tube(size = [80, 80], wall = th, h = 2.5 + 7.5, anchor = BOTTOM) {
            
            for (i = [-1, 1]) {
                for (j = [-1, 1]) {
                    of = 80 / 2 - 12 / 2 - th;
                    left(i * of)
                    back(j * of) {
                        //磁铁区域底部
                        tag("keep")
                        position(BOTTOM)
                        cuboid(size = [12, 12, th0], anchor = BOTTOM);
                        
                        //磁铁外径约束
                        tag("keep")
                        up(th0)
                        position(BOTTOM)
                        rect_tube(size = [12, 12], isize = [10.5, 10.5], irounding = 5, wall = 2, h = 2.5, anchor = BOTTOM);
                    }
                }
            }
            
            position(TOP)
            rect_tube(size1 = [80, 80], isize2 = [24.5 + 0.3, 24.5 + 0.3], shift = [0, 12], rounding2 = 14, wall = th, h = 40, anchor = BOTTOM) {
                
                // 母头，对接外部吸尘管
                position(TOP)
                tube(h = 10, id1 = 24.5 + 0.3, id2 = 25 + 0.3, wall = th, anchor = BOTTOM);
            }
        }
    }
}

solder_vacuum_filter();