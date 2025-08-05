import java.awt.Robot;
import java.awt.Window;

boolean[] keys;
Camera cam;
public PApplet parent = this;
Window window;
//Robot robot;

public Window getNativeWindow() {
  return window;
}

// ran once at the very start of every sketch
void setup() {
  fullScreen(P3D);
  //size(1000,700,P3D);
  noCursor(); 
  keys = new boolean[129]; // 128 + shift
  window = getNativeWindow();
  cam = new Camera(window);
  //try {
  //  robot = new Robot();
  //} catch (Throwable e) {
    
  //}
  frameRate(60); // sets tickrate 60
}


// called once every tick (frame)
void draw() {
  background(200); // refresh screen
  if (keyPressed && key == SHIFT) keys[128] = true;
  else keys[128] = false;
  drawObjects();
  cam.drawCamera(keys);
  //robot.mouseMove(width/2,height/2);
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
