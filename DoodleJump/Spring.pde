class Spring {
  
  float x, y, z, w = 20, h = 10, l = 20;
  BasicPlatform parent;
  
  
  Spring(BasicPlatform parent) {
    this.parent = parent;
    this.x = parent.x + parent.w/2 - w/2;
    this.y = parent.y - h;
    this.z = parent.z + parent.l/2 - l/2;
  }
  
  
  // display
  void display() {
    //fill(255, 0, 0);
    //rect(x, y, w, h);
    Box3D springBox = new Box3D(x-w,y,z-l,w,h,l,color(255,0,0));
    springBox.drawBox();
  }
  
  
  // check if is touching player
  boolean isTouching(Player p) {
    if (p.ySpeed > 0
            && p.pos.x+p.w>x
            && p.pos.x<x + w
            && p.pos.y+p.h >= y
            && p.pos.y+p.h <= y+10
            && p.pos.z+p.l>z
            && p.pos.z<z+l) {
              return true;
    } else {
      return false;
    }
  }
  
  
}
