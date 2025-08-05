class JetPack {
  
  float x, y, z, w = 35, h = 50;
  PImage jetpack;
  boolean show; // based off collectedJetpack in parent
  
  JetPack(BasicPlatform parent) {
    x = parent.x + w;
    y = parent.y - 3*h/4;
    z = parent.z + w;
    show = true;
    jetpack = loadImage("jetpack.png");
    jetpack.resize((int)w,(int)h);
  }
  
  // display
  void display() {
    //if (show) image(jetpack,x,y);
    if (show) {};
  }
  
  // check if is touching player
  boolean isTouching(Player p) {
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
