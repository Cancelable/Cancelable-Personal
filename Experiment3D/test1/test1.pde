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
float speed = 10;


// setup
void setup() {
  size(600,600,P3D);
  coords = new PVector(0,0,0);
  keys = new boolean[6];
  for (int i=0;i<keys.length;i++) {keys[i] = false;}
}

// draw
void draw() {
  background(150);
  smooth();
  actualKeyPressedBruh();
  translate(width/2,0,width/2);
  animate();
}

// draw for all of the animation aspects of the game
void animate() {
  manageCameraPosition(coords.x,coords.y,coords.z);
  drawObjects();
}

// place all of the Figures inside of an array of figures
void drawObjects() {
  pushMatrix();
  box(150);
  translate(150,0,0);
  box(100);
  popMatrix();
}

// manage the camera so that it fits the direction faced and the 
void manageCameraPosition(float x, float y, float z) {
  // translates so everything in center
  rotateY(-map(width/2 - mouseX, 0, width, -PI/2, PI/2)); // rotate camera
  translate(coords.x,coords.y,coords.z); // sets camera perspective
  translate(width/2,height/2,0);
}

void keyPressed() {
  if (key=='w') {
    keys[KW] = true;}
    if (key=='a') {
    keys[KA] = true;}
    keys[KS] = true;
    keys[KD] = true;
    keys[KSPACE] = true;
    keys[KSHIFT] = true;
  }
}

void keyReleased() {
  keys[KW] = false;
  keys[KA] = false;
  keys[KS] = false;
  keys[KD] = false;
  keys[KSPACE] = false;
  keys[KSHIFT] = false;
}

void actualKeyPressedBruh() {
  if (keys[KW]) {coords.z+=speed;println("w");}
  if (keys[KS]) {coords.z-=speed;}
  if (keys[KA]) {coords.x-=speed;}
  if (keys[KD]) {coords.x+=speed;}
  if (keys[KSHIFT]) {coords.y-=speed;}
  if (keys[KSPACE]) {coords.y+=speed;}
}
