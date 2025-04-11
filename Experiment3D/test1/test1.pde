// final variables
final int KW = 0;
final int KA = 1;
final int KS = 2;
final int KD = 3;
final int KSPACE = 4;
final int KSHIFT = 5;

// variables
PVector coords;
boolean[] keys;


// setup
void setup() {
  size(600,600,P3D);
  coords = new PVector(0,0,0);
}

// draw
void draw() {
  background(150);
  
  // translates so everything in center
  translate(width/2,0,width/2);
  // rotate camera
  rotateY(-map(width/2 - mouseX, 0, width, -PI/2, PI/2));
  translate(coords.x,coords.y,coords.z);
  
  
  translate(width/2,height/2,0);
  // start code
  smooth();
  pushMatrix();
  noFill();
  translate(0,0,0);
  box(150);
  translate(0,0,150);
  box(150);
  popMatrix();
}
