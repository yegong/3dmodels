$fs = 0.1;
$fa = 3;
$epsilon = 0.01;

function  f(x) = ((107 - x) / (107 - 25) * 22 + 0.5) / 2;

module wmf_ruler() {
    linear_extrude(height = 10) {
        polygon([
            [f(107), 0],
            [f(95), 5],
            [f(78), 10],
            [f(60), 15],
            [f(44), 20],
            [f(31), 25],
            [f(26), 30],
            [f(25), 35],
            [f(26), 40],
            [f(31), 50],
            [f(36), 60],
            [f(40), 70],
            [f(44), 80],
            [15, 80], [15, 0]
        ]);
    }
}

module rack_d22() {
    $r = 220 / 2;
    $depth = 100;
    $width = 100;
    $height = 30;
    difference() {
    color("red")
        cube([$width, $depth, $height], center = true);
        
        translate([0, 0, $r - $height / 2 + 8])
        rotate([90, 0, 0])
        cylinder(h = $depth, r = $r, center = true);
        
        cylinder(h = $height, r = $depth / 2 - 10, center = true);
        
        translate([0, 0, 18])
        cube([$width, $depth, $height], center = true);
    }
}

module rack_d17() {
    $r = 170 / 2;
    $depth = 50;
    $width = 50;
    $height = 30;
    difference() {
    color("red")
        cube([$width, $depth, $height], center = true);
        
        translate([0, 0, $r - $height / 2 + 5])
        rotate([90, 0, 0])
        cylinder(h = $depth, r = $r, center = true);
        
        cylinder(h = $height, r = $depth / 2 - 5, center = true);
        
        translate([0, 0, 8])
        cube([$width, $depth, $height], center = true);
    }
}

rack_d22();