translate( [40,80,15.9] ) cube([19.5,71.5-1,2.2], true, $fn=100);
//Plattform
difference(){
    rotate(-90,[50,0,0]) translate( [48.5,-14,88.5] ) cylinder (h = 3.75, r=2, $fn=100);
    rotate(-90,[50,0,0]) translate( [48.5,-14,88.25] ) cylinder (h = 8, r=0.8, $fn=100);
    translate( [49.5,90,15.5] ) cube([3,5,4], true);
}

//Fixation
difference(){
    rotate(-90,[50,0,0]) translate( [48.5,-14,68.5] ) cylinder (h = 3.75, r=2, $fn=100);
    rotate(-90,[50,0,0]) translate( [48.5,-14,68.25] ) cylinder (h = 8, r=0.8, $fn=100);
    translate( [49.5,70,15.5] ) cube([3,5,4], true);
}