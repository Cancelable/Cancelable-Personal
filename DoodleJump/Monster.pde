class Monster {
  
  float x, y, z, size = 30;
  BasicPlatform parent;

  Monster(BasicPlatform parent) {
    this.parent = parent;
    //this.x = parent.x + parent.w/2 - size/2;
    this.y = parent.y - size;
    
    this.x = (int)random(width/2 - size) + size;
    this.z = (int)random(width/2 - size) + size;
  }

  void display() {
    //fill(255, 50, 50);
    //ellipse(x + size/2, y + size/2, size, size);
    //fill(0);
    //ellipse(x + size/3, y + size/3, 5, 5);  // eye
    Sphere3D redness = new Sphere3D(x,y,z,size,color(255,50,50));
    redness.drawSphere();
  }

  // check if is touching player
  boolean isTouching(Player p) {
    float w = size;
    if (p.ySpeed > 0
            && p.pos.x+p.w>x
            && p.pos.x<x + w
            && p.pos.y+p.h >= y
            && p.pos.y+p.h <= y+10
            && p.pos.z+p.l>z
            && p.pos.z<z + w) {
              return true;
    } else {
      return false;
    }
  }
}
