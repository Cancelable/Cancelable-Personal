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
  smooth();
  translate(width/2,height/2,0);
  animate();
}

// draw for all of the animation aspects of the game
void animate() {
  manageCameraPosition(coords.x,coords.y,coords.z);
  drawObjects();
}

// place all of the Figures inside of an array of figures
void drawObjects() {
  box(150);
  translate(150,0,0);
  box(100);
}

// manage the camera so that it fits the direction faced and the 
void manageCameraPosition(float x, float y, float z) {
  // translates so everything in center
  rotateY(-map(width/2 - mouseX, 0, width, -PI/2, PI/2)); // rotate camera
  translate(coords.x,coords.y,coords.z); // sets camera perspective
}
