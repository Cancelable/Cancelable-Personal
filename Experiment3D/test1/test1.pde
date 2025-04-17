import queasycam.*;

// final variables
final int KSHIFT = 128;

// variables
PVector coords;
float angle;
boolean[] keys;
float speed = 10;
QueasyCam cam;


// setup
void setup() {
  size(1000,563,P3D);
  coords = new PVector(0,0,0);
  cam = new QueasyCam(this);
  keys = new boolean[129]; // ascii, and then shift is index 128
  angle = 0;
  for (int i=0;i<keys.length;i++) {keys[i] = false;}
}

// draw
void draw() {
  background(150);
  smooth();
  translate(width/2,height/2,width/2);
  actualKeyPressedBruh();
  animate();
}

// draw for all of the animation aspects of the game
void animate() {
  //manageCameraPosition(coords.x,coords.y,coords.z);
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
  
}

void keyPressed() {
  if (key=='w') {keys['w'] = true;}
  if (key=='a') {keys['a'] = true;}
  if (key=='s') {keys['s'] = true;}
  if (key=='d') {keys['d'] = true;}
  if (key==' ') {keys[' '] = true;}
  if (keyCode==SHIFT) {keys[KSHIFT] = true;}
}
void keyReleased() {
  if (key=='w') {keys['w'] = false;}
  if (key=='a') {keys['a'] = false;}
  if (key=='s') {keys['s'] = false;}
  if (key=='d') {keys['d'] = false;}
  if (key==' ') {keys[' '] = false;}
  if (keyCode==SHIFT) {keys[KSHIFT] = false;}
}

// real keypressed
void actualKeyPressedBruh() {
  if (keys['w']) {}
  if (keys['s']) {}
  if (keys['a']) {}
  if (keys['d']) {}
  if (keys[KSHIFT]) {}
  if (keys[' ']) {}
}
