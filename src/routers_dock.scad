$fs = 0.1;
$fa = 3;
$epsilon = 0.01;

use <utils.scad>;

module cube_cut_corner(size, corner_size) {
    difference() {
        cube(size);
        
        translate([0, 0, 0]) {
            cube(corner_size);
        }
        
        translate([size[0]-corner_size, 0, 0]) {
            cube(corner_size);
        }
        
        translate([0, size[1]-corner_size, 0]) {
            cube(corner_size);
        }
        
        translate([size[0]-corner_size, size[1]-corner_size, 0]) {
            cube(corner_size);
        }
    }
}

module cube_cut_edge(size, edge_size) {
    difference() {
        cube(size);
        
        translate([0, 0, 0]) {
            cube([edge_size, size[1], edge_size]);
        }
        
        translate([size[0]-edge_size, 0, 0]) {
            cube([edge_size, size[1], edge_size]);
        }
        
        translate([0, size[1]-edge_size, 0]) {
            cube([size[0], edge_size, edge_size]);
        }
        
        translate([size[0]-edge_size, size[1]-edge_size, 0]) {
            cube([size[0], edge_size, edge_size]);
        }
    }
}

$dist = 10;
$w1 = 45 + 5;
$w2 = 35 + 5;
$w3 = 30 + 5;
$wa = $w1 + $w2 + $w3;
$width = $wa+4*$dist;

$da = 130;
$depth = $da+2*$dist;

$h_socket = 3;

module component_top() {
    $h1 = 5;
    $h2 = 15;
    $height = $h1 + $h2;
    difference() {
        cube([$width, $depth, $height]);
        
        translate([$dist, $dist, 0]) {
            cube_cut_edge([$w1, 127 + 5, $height], $h1);
        }
        
        translate([$w1 + 2*$dist, $dist, 0]) {
            cube_cut_edge([$w2, 106 + 5, $height], $h1);
        }
        
        translate([$w1 + $w2 + 3*$dist, $dist, 0]) {
            cube_cut_edge([$w3, 103 + 5, $height], $h1);
        }
        
        translate([$dist/2, $dist/2, 0]) {
            cylinder(h = $h_socket*2, r = 1.5, center = true);
        }
        
        translate([$width-$dist/2, $dist/2, 0]) {
            cylinder(h = $h_socket*2, r = 1.5, center = true);
        }
        
        translate([$dist/2, $depth-$dist/2, 0]) {
            cylinder(h = $h_socket*2, r = 1.5, center = true);
        }
        
        translate([$width-$dist/2, $depth-$dist/2, 0]) {
            cylinder(h = $h_socket*2, r = 1.5, center = true);
        }
    }
}
module component_bottom() {
    $dist = 10;
    $height = 25;
    $fence = 35;
    $fan_size = 122;
    difference() {
        cube([$width, $depth, $height]);
        translate([($width-$fan_size)/2, ($depth-$fan_size)/2, 0]) {
            cube([$fan_size, $fan_size, $height]);
        }
        translate([$dist/2, $dist/2, 0]) {
            cylinder(h = $h_socket*2, r = 1.5, center = true);
        }
        
        translate([$width-$dist/2, $dist/2, 0]) {
            cylinder(h = $h_socket*2, r = 1.5, center = true);
        }
        
        translate([$dist/2, $depth-$dist/2, 0]) {
            cylinder(h = $h_socket*2, r = 1.5, center = true);
        }
        
        translate([$width-$dist/2, $depth-$dist/2, 0]) {
            cylinder(h = $h_socket*2, r = 1.5, center = true);
        }
    }
    
    translate([0, 0, $height]) {
        difference() {
            cube([$width, $depth, $fence]);
            translate([$dist, $dist, 0]) {
                cube([$width-2*$dist, $depth-2*$dist, $fence]);
            }
        }
    }
        
    translate([$dist/2, $dist/2, $height+$fence]) {
        cylinder(h = ($h_socket-1)*2, r = 1.2, center = true);
    }
    
    translate([$width-$dist/2, $dist/2, $height+$fence]) {
        cylinder(h = ($h_socket-1)*2, r = 1.2, center = true);
    }
    
    translate([$dist/2, $depth-$dist/2, $height+$fence]) {
        cylinder(h = ($h_socket-1)*2, r = 1.2, center = true);
    }
    
    translate([$width-$dist/2, $depth-$dist/2, $height+$fence]) {
        cylinder(h = ($h_socket-1)*2, r = 1.2, center = true);
    }
}

component_top();
//component_bottom();