class Spring {
  
  int sWidth;
  int sHeight;
  color springColor;
  PVector pos;
  
  
  Spring(Tile base) {
    sWidth = 20;
    sHeight = 20;
    pos = new PVector(base.pos.x , base.pos.y - sHeight);
    springColor = OVERWORLD_SPRING_COLOR;
  }
  
  
  void display() {
    fill(springColor);
    rect(pos.x,pos.y,sWidth,sHeight);
  }
  
  
  void moveVertically(float amount) {
    pos.y += amount;
  }
  
}
