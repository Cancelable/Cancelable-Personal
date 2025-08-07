class Ammo {
  
  float x, y, z;
  float r = 6;
  float speed = 10;
  
  PVector velocity;
  
  int myFrameCount;
  
  Ammo(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
    velocity = cam.getForward();
    velocity.normalize();
    velocity.mult(speed);
    myFrameCount = frameCount;
  }
  
  void update() {
    x += velocity.x;
    y += velocity.y;
    z += velocity.z;
  }
  
  // display
  void display() {
    //fill(0);
    //ellipse(x, y, r*2, r*2);
    Sphere3D blackBall = new Sphere3D(x,y,z,r,10);
    blackBall.drawSphere();
  }

  // return positive if hits xd
  boolean hits(Monster m) {
    //return dist(x, y, m.x + m.size/2, m.y + m.size/2) < r + m.size/2;
    PVector temp = new PVector(x,y,z);
    PVector tempM = new PVector(m.x,m.y,m.z);
    return temp.dist(tempM) < r + m.size/2;
  }

  boolean offscreen() {
    PVector temp = new PVector(x,y,z);
    PVector tempP = new PVector(player.pos.x,player.pos.y,player.pos.z);
    return y < 0 || y > height || (temp.dist(tempP) > width);
  }
}
