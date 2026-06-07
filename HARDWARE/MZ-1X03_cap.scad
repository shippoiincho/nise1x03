MARGIN=0.2;

difference() {

intersection() {

difference() {
    
sphere(14);

sphere(12);

}

cylinder(15,0,30);

}

translate([-2-MARGIN,-1.5-MARGIN,10]) {
cube([4+MARGIN*2,3+MARGIN*2,4]);
}

}



difference() {

translate([0,0,11]) {
    cylinder(10,3.5,3.5);
}

translate([-2-MARGIN,-1.5-MARGIN,11]) {
cube([4+MARGIN*2,3+MARGIN*2,5]);
}


}

translate([0,0,21]) {
    cylinder(2,7,7);
}
