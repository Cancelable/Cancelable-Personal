import java.awt.Point;
import java.awt.Robot;
import java.awt.AWTException;
import java.awt.MouseInfo;
import java.awt.Component;

public class Camera {

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

  private Robot robot;
  private Component parentWindow; // reference to your Processing window/frame

  private int skipFramesAfterWarp = 0;

  public Camera(Window window) {
    this.parentWindow = window;

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

    try {
      robot = new Robot();
    } catch (AWTException e) {
      println("Could not initialize mouse centering Robot: " + e.getMessage());
    }

    perspective(PI / 3f, (float) width / (float) height, 0.01f, 1000f);
  }

  public void drawCamera(boolean[] k) {
    if (!controllable || robot == null || parentWindow == null) return;

    // Get window position on screen
    Point windowPos = parentWindow.getLocationOnScreen();

    int centerX = windowPos.x + width / 2;
    int centerY = windowPos.y + height / 2;

    Point mp = MouseInfo.getPointerInfo().getLocation();
    int mouseScreenX = mp.x;
    int mouseScreenY = mp.y;

    float deltaX = mouseScreenX - centerX;
    float deltaY = mouseScreenY - centerY;

    if (skipFramesAfterWarp == 0) {
      yaw   -= deltaX * sensitivity * 0.01f;
      pitch += deltaY * sensitivity * 0.01f;
      pitch = clamp(pitch, -HALF_PI + 0.01f, HALF_PI - 0.01f);
    } else {
      skipFramesAfterWarp--;
    }

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

    if (k['a']) velocity.add(PVector.mult(right, speed));
    if (k['d']) velocity.sub(PVector.mult(right, speed));
    if (k['w']) {
      velocity.add(PVector.mult(fakeForward, speed));
      velocity.y -= PVector.mult(fakeForward, speed).y;
    }
    if (k['s']) {
      velocity.sub(PVector.mult(fakeForward, speed));
      velocity.y += PVector.mult(fakeForward, speed).y;
    }
    if (k['c'] || k[128]) velocity.add(PVector.mult(up, speed));
    if (k[' ']) velocity.sub(PVector.mult(up, speed));

    velocity.mult(friction);
    position.add(velocity);

    center = PVector.add(position, forward);

    camera(position.x, position.y, position.z, center.x, center.y, center.z, up.x, up.y, up.z);

    // Warp mouse back to window center
    robot.mouseMove(centerX, centerY);

    skipFramesAfterWarp = 2;  // skip next 2 frames to avoid jump from warp
  }

  private float clamp(float x, float min, float max) {
    if (x > max) return max;
    if (x < min) return min;
    return x;
  }
}
