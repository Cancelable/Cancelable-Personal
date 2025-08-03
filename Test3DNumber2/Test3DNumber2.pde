boolean[] keys;


// ran once at the very start of every sketch
void setup() {
  keys = new boolean[128];
  frameRate(60); // sets tickrate 60
  size(600,600,P3D);
}


// called once every tick (frame)
void draw() {
  background(100);
}


void keyPressed() {
  if (key<128) keys[key] = true;
}
void keyReleased() {
  if (key<128) keys[key] = false;
}
// realKeyPressed
void realKeyPressed() {
  
}
