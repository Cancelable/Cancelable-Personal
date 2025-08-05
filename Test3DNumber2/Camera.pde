public class Camera {
  
  // this code basically stolen + modified
  // this class is basically QueasyCam
  // it is customized for my program

  private boolean controllable;
  private float speed;
  private float sensitivity;
  public PVector position;
  private float yaw;
  private float pitch;
  private PVector velocity;
  private float friction;

  private PVector center;
  private PVector up;
  private PVector right;
  private PVector forward;

  public Camera() {

    controllable = true;
    speed = 3f;
    sensitivity = 2f;
    position = new PVector(0f, 0f, 0f);
    up = new PVector(0f, 1f, 0f);
    right = new PVector(1f, 0f, 0f);
    forward = new PVector(0f, 0f, 1f);
    velocity = new PVector(0f, 0f, 0f);
    yaw = 0f;
    pitch = 0f;
    friction = 0.75f;

    perspective(PI/3f, (float)width/(float)height, 0.01f, 1000f);
  }

  public void drawCamera(boolean[] k) {
    if (!controllable) return;

    yaw   += (mouseX - pmouseX) * sensitivity * 0.01f;
    pitch -= (mouseY - pmouseY) * sensitivity * 0.01f;
    pitch = clamp(pitch, -HALF_PI + 0.01f, HALF_PI - 0.01f); // avoid flipping

    forward = new PVector(
      cos(pitch) * sin(yaw),
      sin(pitch),
      cos(pitch) * cos(yaw)
    );
    forward.normalize();

    PVector fakeForward = new PVector(forward.x, 0, forward.z);
    fakeForward.normalize();

    right = forward.cross(up);
    right.normalize();

    if (k['a']) {velocity.add(PVector.mult(right, speed));}
    if (k['d']) {velocity.sub(PVector.mult(right, speed));}
    if (k['w']) {
      velocity.add(PVector.mult(fakeForward, speed));
      velocity.y -= PVector.mult(fakeForward, speed).y;
    }
    if (k['s']) {
      velocity.sub(PVector.mult(fakeForward, speed));
      velocity.y += PVector.mult(fakeForward, speed).y;
    }
    if (k['c'] || k[128]) {velocity.add(PVector.mult(up, speed));}
    if (k[' ']) {velocity.sub(PVector.mult(up, speed));}

    velocity.mult(friction);
    position.add(velocity);

    center = PVector.add(position, forward);

    camera(position.x, position.y, position.z, center.x, center.y, center.z, up.x, up.y, up.z);
  }

  private float clamp(float x, float min, float max){
    if (x > max) return max;
    if (x < min) return min;
    return x;
  }
  
}
