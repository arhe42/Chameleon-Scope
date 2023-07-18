//Hülle
difference(){
    
translate([8,-148,0])
cube([37,65,35]);

translate([8.5,-146.5,0.5])
 cube([36,64,34]);}   
 //Befestigung Brille1
    translate([3.5,-112.5,15])
    rotate([0,90,0])
    cylinder(d=6,h=5);
    translate([2.5,-116,11.5])
    cube([2,7,7]);
    

//Befestigung Brille2
    translate([3.5,-137.5,15])
    rotate([0,90,0])
    cylinder(d=6,h=5);
    translate([2.5,-141,11.5])
    cube([2,7,7]);