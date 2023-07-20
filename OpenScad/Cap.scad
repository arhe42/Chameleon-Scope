//Option_1
//Plattform
translate( [40,80,15.9] ) cube([19.25,71.5-1,2.2], true, $fn=100);

difference(){
    rotate(-90,[50,0,0]) translate( [47,-14,88.5] ) cylinder (h = 3.75, r=2.25, $fn=100);
    rotate(-90,[50,0,0]) translate( [47,-14,88.25] ) cylinder (h = 8, r=0.8, $fn=100);
    translate( [48,90,15.5] ) cube([3,5,4], true);
}

//Fixation
difference(){
    rotate(-90,[50,0,0]) translate( [47,-14,68.5] ) cylinder (h = 3.75, r=2.25, $fn=100);
    rotate(-90,[50,0,0]) translate( [47,-14,68.25] ) cylinder (h = 8, r=0.8, $fn=100);
    translate( [48,70,15.5] ) cube([3,5,4], true);
}

//Option_2
//Plattform
translate( [60,80,15.9] ) cube([19.25,71.5-1,2.2], true, $fn=100);

//Fixation
translate( [68.75,90.5,14] ) cube([1.5,3,3], true);
translate( [68.75,70.5,14] ) cube([1.5,3,3], true);
