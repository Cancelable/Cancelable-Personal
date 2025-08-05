final PVector startCoords = new PVector(0,0,0);

boolean[] keys;
Camera cam;
PApplet parent = this;


// ran once at the very start of every sketch
void setup() {
  fullScreen(P3D);
  //size(1000,700,P3D);
  noCursor();
  keys = new boolean[129]; // 128 + shift
  cam = new Camera(this);
  frameRate(60); // sets tickrate 60
}


// called once every tick (frame)
void draw() {
  background(200); // refresh screen
  cam.keys = keys;
  drawObjects();
  
  noCursor();
}


// keypressed/keyreleased
void keyPressed() {
  if (key<128) keys[key] = true;
}
void keyReleased() {
  if (key<128) keys[key] = false;
}
// realKeyPressed is where you genuinely take advantage of keys
void realKeyPressed() {
  
}


void drawObjects() {
  pushMatrix();
  box(50);
  popMatrix();
}
