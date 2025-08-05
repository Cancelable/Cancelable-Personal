class Monster {
  
  float x, y, z, size = 30;
  BasicPlatform parent;

  Monster(BasicPlatform parent) {
    this.parent = parent;
    //this.x = parent.x + parent.w/2 - size/2;
    this.y = parent.y - size;
    
    this.x = (int)random(width - size) + size;
  }

  void display() {
    fill(255, 50, 50);
    ellipse(x + size/2, y + size/2, size, size);
    fill(0);
    ellipse(x + size/3, y + size/3, 5, 5);  // eye
  }

  boolean isTouching(Player p) {
    return dist(p.pos.x + p.w/2, p.pos.y + p.h/2, x + size/2, y + size/2) < (size / 2 + p.w / 2);
  }
}
