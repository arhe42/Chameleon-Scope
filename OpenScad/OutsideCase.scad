
gBreite= 21;
gLaenge=72;
gHoehe=30;
gTX=40;
gTY=80;

//Camera
kRadius=4.2;
kTranslateX=37;

difference(){
    minkowski(){
        translate( [gTX,gTY,0] ) cube([gBreite+3,gLaenge+3,gHoehe+3], true);
       sphere(2, $fn=50);
    }
    
    //Camera
    rotate(-90,[50,0,0]) translate( [kTranslateX,0,20] ) cylinder (h = 40, r=kRadius, $fn=100);
    
    minkowski(){
        translate( [gTX,gTY,0] ) cube([gBreite+1,gLaenge+1,gHoehe+1], true);
       sphere(2, $fn=50);
    }
    
    minkowski(){
        translate( [gTX,gTY+10,0] ) cube([gBreite+1,gLaenge+1,gHoehe+1], true);
       sphere(2, $fn=50);
    }
}

//Fixation
difference(){
    rotate(-90,[50,0,0]) translate( [58,-5,40.5] ) cylinder (h = 77, r=6.5, $fn=100);
    rotate(-90,[50,0,0]) translate( [58,-5,38] ) cylinder (h = 85, r=3.5, $fn=100);
    translate( [65,80,5] ) cube([10,80,1], true);
    
    minkowski(){
        translate( [gTX,gTY,0] ) cube([gBreite+1,gLaenge+1,gHoehe+1], true);
       sphere(2, $fn=50);
    }
    
    minkowski(){
        translate( [gTX,gTY+10,0] ) cube([gBreite+1,gLaenge+1,gHoehe+1], true);
       sphere(2, $fn=50);
    }
}