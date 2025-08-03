boolean[] keys;
Camera cam;


// ran once at the very start of every sketch
void setup() {
  keys = new boolean[128];
  cam = new Camera();
  frameRate(60); // sets tickrate 60
  size(1000,700,P3D);
}


// called once every tick (frame)
void draw() {
  background(200); // refresh screen
  drawObjects();
  cam.drawCamera(keys);
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
