public class Camera {
  
  private boolean controllable;
  private float speed;
  private float sensitivity;
  public PVector position;
  private float pan;
  private float tilt;
  private PVector velocity;
  private float friction;
  
  private PVector center;
  private PVector up;
  private PVector right;
  private PVector forward;
  private PVector target;
  // mouseX,mouseY,pmouseX,pmouseY
  
  public Camera() {

    controllable = true;
    speed = 3f;
    sensitivity = 2f;
    position = new PVector(0f, 0f, 0f);
    up = new PVector(0f, 1f, 0f);
    right = new PVector(1f, 0f, 0f);
    forward = new PVector(0f, 0f, 1f);
    velocity = new PVector(0f, 0f, 0f);
    pan = 0f;
    tilt = 0f;
    friction = 0.75f;

    perspective(PI/3f, (float)width/(float)height, 0.01f, 1000f);
  }
  
  public void drawCamera(boolean[] k) {
    //if (!controllable) return;
    
    int w = width;
    int h = height;
    
    //if (mouseX < 1 && (mouseX - pmouseX) < 0){
    //  //robot.mouseMove(w-2, mouseY);
    //  mouseX = w-2;
    //  pmouseX = w-2;
    //}
        
    //if (mouseX > w-2 && (mouseX - pmouseX) > 0){
    //  //robot.mouseMove(2, mouseY);
    //  mouseX = 2;
    //  pmouseX = 2;
    //}
    
    //if (mouseY < 1 && (mouseY - pmouseY) < 0){
    //  //robot.mouseMove(mouseX, h-2);
    //  mouseY = h-2;
    //  pmouseY = h-2;
    //}
    
    //if (mouseY > h-1 && (mouseY - pmouseY) > 0){
    //  //robot.mouseMove(mouseX, 2);
    //  mouseY = 2;
    //  pmouseY = 2;
    //}
    
    pan += map(mouseX - pmouseX, 0, width, 0, TWO_PI) * sensitivity;
    tilt += map(mouseY - pmouseY, 0, height, 0, PI) * sensitivity;
    tilt = clamp(tilt, -PI/2.01f, PI/2.01f);
    
    if (tilt == PConstants.PI/2) tilt += 0.001f;

    forward = new PVector(cos(pan), tan(tilt), sin(pan));
    forward.normalize();
    right = new PVector(cos(pan - PI/2), 0, sin(pan - PI/2));
        
    target = PVector.add(position, forward);
        
    //pmouseX = mouseX;
    //pmouseY = mouseY;
    
    if (k['a']) {velocity.add(PVector.mult(right, speed));}
    if (k['d']) {velocity.sub(PVector.mult(right, speed));}
    if (k['w']) {velocity.add(PVector.mult(forward, speed));}
    if (k['s']) {velocity.sub(PVector.mult(forward, speed));}
    if (k['c']) {velocity.add(PVector.mult(up, speed));}
    if (k[' ']) {velocity.sub(PVector.mult(up, speed));}

    velocity.mult(friction);
    position.add(velocity);
    
    position.y = position.y - velocity.y; // makes it not go vertically
    
    center = PVector.add(position, forward);
    //println("ran");
    camera(position.x, position.y, position.z, center.x, center.y, center.z, up.x, up.y, up.z);
  }
  
  private float clamp(float x, float min, float max){
    if (x > max) return max;
    if (x < min) return min;
    return x;
  }
  
}
