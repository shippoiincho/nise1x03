DEPTH=8;
SIZEX=25;
SIZEY=50;
HOLE=5;
HEIGHT=4;

MARGIN=0.2;
THICK=2.0;

DIFF=THICK/2;

// Top shell

difference() {
    
union() {

translate([-SIZEX-MARGIN-THICK,-SIZEY-MARGIN-THICK,0]) {    
cube([SIZEX*2+MARGIN*2+THICK*2,SIZEY*2+MARGIN*2+THICK*2,THICK]);
}


translate([-SIZEX-MARGIN-THICK,-SIZEY-MARGIN-THICK,THICK]) {    
cube([SIZEX*2+MARGIN*2+THICK*2,SIZEY*2+MARGIN*2+THICK*2-35,THICK+HEIGHT]);
}


}

{
    translate([-SIZEX-MARGIN,-SIZEY-MARGIN,0]) {    
cube([SIZEX*2+MARGIN*2,SIZEY*2+MARGIN*2-35,HEIGHT+THICK]);
}
    }

 // Button Hole
    
    translate([-25+4-0.5+MARGIN*2,25-MARGIN*2,0]) {
        cube([12.5+MARGIN*4,12.5+MARGIN*4,10]);
    }

    translate([25-4-12-MARGIN*2,25-MARGIN*2,0]) {
        cube([12.5+MARGIN*4,12.5+MARGIN*4,10]);
    }

    cylinder(20,10,10);

// Mounting Hole

translate([-SIZEX+HOLE,-SIZEY+HOLE,HEIGHT+THICK]) {
cylinder(THICK,3.5,3.5);    
}

translate([-SIZEX+HOLE,SIZEY-HOLE,0]) {
cylinder(THICK,3.5,3.5);    
}

translate([SIZEX-HOLE,-SIZEY+HOLE,HEIGHT+THICK]) {
cylinder(THICK,3.5,3.5);    
}

translate([SIZEX-HOLE,SIZEY-HOLE,0]) {
cylinder(THICK,3.5,3.5);    
}



}


//

// Mounting Hole

intersection() {

translate([-SIZEX+MARGIN,-SIZEY+MARGIN,-DEPTH]) {
    cube([SIZEX*2-MARGIN*2,SIZEY*2-MARGIN*2,DEPTH+HEIGHT+2.0]);
}

union() {

difference() {
translate([-SIZEX+HOLE,-SIZEY+HOLE,-DEPTH+2]) {
cylinder(DEPTH-2+HEIGHT+THICK,5.5,5.5);    
}
translate([-SIZEX+HOLE,-SIZEY+HOLE,-DEPTH+2]) {
cylinder(DEPTH-2+HEIGHT+THICK,3.5,3.5);    
}
}

difference() {
translate([-SIZEX+HOLE,-SIZEY+HOLE,-DEPTH]) {
cylinder(2,5.5,5.5);    
}

translate([-SIZEX+HOLE,-SIZEY+HOLE,-DEPTH]) {
cylinder(2,1.5,1.5);    
}
}


difference() {
translate([-SIZEX+HOLE,SIZEY-HOLE,-DEPTH+2]) {
cylinder(DEPTH-2,5.5,5.5);    
}
translate([-SIZEX+HOLE,SIZEY-HOLE,-DEPTH+2]) {
cylinder(DEPTH-2,3.5,3.5);    
}
}

difference() {
translate([-SIZEX+HOLE,SIZEY-HOLE,-DEPTH]) {
cylinder(2,5.5,5.5);    
}

translate([-SIZEX+HOLE,SIZEY-HOLE,-DEPTH]) {
cylinder(2,1.5,1.5);    
}
}


difference() {
translate([SIZEX-HOLE,-SIZEY+HOLE,-DEPTH+2]) {
cylinder(DEPTH-2+HEIGHT+THICK,5.5,5.5);    
}
translate([SIZEX-HOLE,-SIZEY+HOLE,-DEPTH+2]) {
cylinder(DEPTH-2+HEIGHT+THICK,3.5,3.5);    
}
}

difference() {
translate([SIZEX-HOLE,-SIZEY+HOLE,-DEPTH]) {
cylinder(2,5.5,5.5);    
}

translate([SIZEX-HOLE,-SIZEY+HOLE,-DEPTH]) {
cylinder(2,1.5,1.5);    
}
}


difference() {
translate([SIZEX-HOLE,SIZEY-HOLE,-DEPTH+2]) {
cylinder(DEPTH-2,5.5,5.5);    
}
translate([SIZEX-HOLE,SIZEY-HOLE,-DEPTH+2]) {
cylinder(DEPTH-2,3.5,3.5);    
}
}

difference() {
translate([SIZEX-HOLE,SIZEY-HOLE,-DEPTH]) {
cylinder(2,5.5,5.5);    
}

translate([SIZEX-HOLE,SIZEY-HOLE,-DEPTH]) {
cylinder(2,1.5,1.5);    
}
}

}
}