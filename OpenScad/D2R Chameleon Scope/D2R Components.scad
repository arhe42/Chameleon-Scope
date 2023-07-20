$fn=50;

cube([30,40,1]);
translate([10,-45,0])
cube([15,45,1]);
//Walls
minkowski(){
cube([25,0.2,31.5]);
    cylinder();}
minkowski(){
translate([0,39,0])
cube([40,0.2,31.5]);
cylinder();}
//
minkowski(){
    translate([10,-45,0])
    cube([0.2,45,31.5]);
    cylinder();
    }
    
minkowski(){
    translate([40,-45,0])
    cube([0.2,84,31.5]);
    cylinder();
}
   
minkowski(){
    translate([10,-45,0])
    cube([30,0.2,31.5]);
    cylinder();
}

// Display attachment

translate([20,0,24])
difference(){
cube([5,40,5]);
translate([-5,7,2])
rotate([0,90,0])
    cylinder(r=1.5,h=15);
    
    translate([-5,33,2])
rotate([0,90,0])
    cylinder(r=1.5,h=15);
    }

translate([25,-45,0])
cube([15,85,1]);


//Connector for Reflector low

translate([0,25,0])
difference(){
cube([20,20,1.5]);
    translate([0,0,1])
    cube([20,20,10]);}
translate([10,45,0])
difference(){
cylinder(h=1.5, r=10);
    translate([0,2.5,-1.5])
    cylinder(r=1.5, h=10);}
    
    
    
//connector for reflector up
    
translate([0,25,30.5])
difference(){
cube([20,20,1.5]);
translate([-1,-2,-5])
    cube([22,15,11]);}

translate([10,45,30.5])
difference(){
difference(){
cylinder(h=1.5, r=10);
   translate([-10,-17,-1])
    cube([20,10,10]);
}
    translate([0,2.5,-2])
    cylinder(r=1.5, h=10);}


//attachment lens
translate([0,0,1])
cube([1,38,1.5]);

translate([4,0,1])
cube([1,38,1.5]);

cube([1,3,5]);

translate([4,0,0])
cube([1,3,5]);

translate([0,36,0])
cube([1,3,5]);

translate([4,36,0])
cube([1,3,5]);


//attachment glasses 1
    translate([4.5,-20.5,15])
    rotate([0,90,0])
    cylinder(d=6,h=5);
    translate([3.5,-24,11.5])
    cube([2,7,7]);
    

//attachment glasses 2
    translate([4.5,-40.5,15])
    rotate([0,90,0])
    cylinder(d=6,h=5);
    translate([3.5,-44,11.5])
    cube([2,7,7]);
    
    
//attachment reflector

translate([-10,70,0]){

$fn=50;
translate([22.5,0,0]){

translate([0,0,28.5])
cylinder(h=1, r=1.25);
    
translate([0,0,-1])
cylinder(h=1, r=1.25);
    
cylinder(h=28.5, r=5.5);
   
translate([3,-4.5,0])
cube([13,9,28.5]);}

difference(){
rotate([0,0,135])
translate([-30.5,-39,0])
cube([9,15,28.5]);


rotate([0,0,135])
translate([-27,-44.5,-1])
cube([2,14,30]);}

}
//Halterung Deckel
translate([-1,-1,32.5])
cube([10,1,1]);

translate([9,-45,32.5])
cube([1,45,1]);

translate([40,-45,32.5])
cube([1,85,1]);

translate([-1,39.2,32.5])
cube([42,1,1]);

translate([9,-46,32.5])
cube([32,1,1]);

//led
translate([60,-45,0])
cube([30,84,1]);

translate([90,0,0])
cube([11,39,1]);

//attachment for lens at the led
translate([96,1,1])
cube([1,37,1.5]);

translate([100,1,1])
cube([1,37,1.5]);

translate([96,1,1])
cube([1,3,5]);

translate([100,1,0])
cube([1,3,5]);

translate([96,35,0])
cube([1,3,5]);

translate([100,35,0])
cube([1,3,5]);
