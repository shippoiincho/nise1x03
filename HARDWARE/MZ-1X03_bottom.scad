DEPTH=15;
SIZEX=25;
SIZEY=50;
HOLE=5;

MARGIN=0.2;
THICK=2.0;

DIFF=THICK/2;

// OUTER BOX

difference() {

translate([-SIZEX-MARGIN-THICK,-SIZEY-MARGIN-THICK,-DEPTH-THICK]) {    
cube([SIZEX*2+MARGIN*2+THICK*2,SIZEY*2+MARGIN*2+THICK*2,DEPTH+THICK]);
}

{
translate([-SIZEX-MARGIN,-SIZEY-MARGIN,-DEPTH]) {  
cube([SIZEX*2+MARGIN*2,SIZEY*2+MARGIN*2,DEPTH]);
}

// Mounting Hole

translate([-SIZEX+HOLE,-SIZEY+HOLE,-DEPTH-THICK]) {
cylinder(THICK,3.5,3.5);    
}

translate([-SIZEX+HOLE,SIZEY-HOLE,-DEPTH-THICK]) {
cylinder(THICK,3.5,3.5);    
}

translate([SIZEX-HOLE,-SIZEY+HOLE,-DEPTH-THICK]) {
cylinder(THICK,3.5,3.5);    
}

translate([SIZEX-HOLE,SIZEY-HOLE,-DEPTH-THICK]) {
cylinder(THICK,3.5,3.5);    
}

// Cable Guide

translate([-3,SIZEY,-8]) {
    cube([6,6,8]);
}

}

}

// Mounting Hole

difference() {
translate([-SIZEX+HOLE,-SIZEY+HOLE,-DEPTH]) {
cylinder(DEPTH-12,5.5,5.5);    
}
translate([-SIZEX+HOLE,-SIZEY+HOLE,-DEPTH]) {
cylinder(DEPTH-12,3.5,3.5);    
}
}

difference() {
translate([-SIZEX+HOLE,-SIZEY+HOLE,-12]) {
cylinder(2,5.5,5.5);    
}

translate([-SIZEX+HOLE,-SIZEY+HOLE,-12]) {
cylinder(2,1.5,1.5);    
}
}


difference() {
translate([-SIZEX+HOLE,SIZEY-HOLE,-DEPTH]) {
cylinder(DEPTH-12,5.5,5.5);    
}
translate([-SIZEX+HOLE,SIZEY-HOLE,-DEPTH]) {
cylinder(DEPTH-12,3.5,3.5);    
}
}

difference() {
translate([-SIZEX+HOLE,SIZEY-HOLE,-12]) {
cylinder(2,5.5,5.5);    
}

translate([-SIZEX+HOLE,SIZEY-HOLE,-12]) {
cylinder(2,1.5,1.5);    
}
}


difference() {
translate([SIZEX-HOLE,-SIZEY+HOLE,-DEPTH]) {
cylinder(DEPTH-12,5.5,5.5);    
}
translate([SIZEX-HOLE,-SIZEY+HOLE,-DEPTH]) {
cylinder(DEPTH-12,3.5,3.5);    
}
}

difference() {
translate([SIZEX-HOLE,-SIZEY+HOLE,-12]) {
cylinder(2,5.5,5.5);    
}

translate([SIZEX-HOLE,-SIZEY+HOLE,-12]) {
cylinder(2,1.5,1.5);    
}
}


difference() {
translate([SIZEX-HOLE,SIZEY-HOLE,-DEPTH]) {
cylinder(DEPTH-12,5.5,5.5);    
}
translate([SIZEX-HOLE,SIZEY-HOLE,-DEPTH]) {
cylinder(DEPTH-12,3.5,3.5);    
}
}

difference() {
translate([SIZEX-HOLE,SIZEY-HOLE,-12]) {
cylinder(2,5.5,5.5);    
}

translate([SIZEX-HOLE,SIZEY-HOLE,-12]) {
cylinder(2,1.5,1.5);    
}
}

