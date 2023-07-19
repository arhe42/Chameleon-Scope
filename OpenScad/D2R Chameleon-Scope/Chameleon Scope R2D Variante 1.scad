$fn=50;
//Boden
cube([30,40,1]);

translate([10,-65,0])
cube([15,65,1]);

translate([25,-65,0])
cube([15,105,1]);

//Wände
minkowski(){
    cube([25,0.2,31.5]);
        cylinder();
    }
minkowski(){
    translate([0,39,0])
    cube([40,0.2,31.5]);
        cylinder();
    }

minkowski(){
    translate([10,-65,0])
    cube([0.2,65,31.5]);
        cylinder();
    }
    
minkowski(){
    translate([40,-65,0])
    cube([0.2,104,31.5]);
        cylinder();
    }
   
minkowski(){
    translate([10,-65,0])
    cube([30,0.2,31.5]);
    cylinder();
    }

//Halterung Display

translate([20,0,24])
difference(){
cube([5,40,5]);

// Löcher für die Halterung der Schrauben für das Display  
translate([-5,7,2])
rotate([0,90,0])
    cylinder(r=1.5,h=15);
    translate([-5,33,2])
rotate([0,90,0])
    cylinder(r=1.5,h=15);
    }



//Verbindung für Reflektor unten

translate([0,25,0])
difference(){
cube([20,20,1.5]);
    translate([0,0,1])
    cube([20,20,10]);
    }
translate([10,45,0])
difference(){ 
cylinder(h=1.5, r=10);
    translate([0,2.5,-1.5])
    cylinder(r=1.5, h=10); //Loch zur Befestigung der Verbindung
    }
    
    
    
//Verbindung für Reflektor oben
    
translate([0,25,30.5])
difference(){
cube([20,20,1.5]);
    translate([-1,-2,-5])
    cube([22,15,11]);
}

translate([10,45,30.5])
difference(){
cylinder(h=1.5, r=10);
   translate([-10,-17,-1])
    cube([20,10,10]);
    
    translate([0,2.5,-2])
    cylinder(r=1.5, h=10);//Loch zur Befestigung der Verbindung
}


//Halterung Linse
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


//Befestigung 1 der Klammer für die Brille
    translate([4.5,-27.5,15])
    rotate([0,90,0])
    cylinder(d=6,h=5);
    translate([3.5,-31,11.5])
    cube([2,7,7]);
    

//Befestigung 2 der Klammer für die Brille
    translate([4.5,-50.5,15])
    rotate([0,90,0])
    cylinder(d=6,h=5);
    translate([3.5,-54,11.5])
    cube([2,7,7]);
    
    
//Verbindung Reflektor

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

translate([9,-65,32.5])
cube([1,65,1]);

translate([40,-65,32.5])
cube([1,105,1]);

translate([-1,39.2,32.5])
cube([42,1,1]);

translate([9,-66,32.5])
cube([32,1,1]);

//Deckel
translate([60,-65,0])
cube([30,104,1]);

translate([90,0,0])
cube([11,39,1]);

//Halterung Linse Deckel
translate([96,0.5,1])
cube([1,38,1.5]);

translate([100,0.5,1])
cube([1,38,1.5]);

translate([96,0.5,1])
cube([1,3,5]);

translate([100,0.5,0])
cube([1,3,5]);

translate([96,35.5,0])
cube([1,3,5]);

translate([100,35.5,0])
cube([1,3,5]);
