class Ammo {
  
  float x, y, z;
  float r = 6;
  float speed = 10;
  
  Ammo(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void update() {
    y -= speed;
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
    return y < 0;
  }
}
