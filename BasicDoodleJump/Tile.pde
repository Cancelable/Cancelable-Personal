class Tile {
  
  int tLength;
  int tHeight;
  PVector pos;
  
  Tile(int x, int y) {
     tLength = (int)random(40) + 50;
     tHeight = 10;
     pos = new PVector(x - tLength/2,y+tHeight);
  }
  Tile () {
    this((int)random(width),0);
  }
  
  void display() {
    fill(0,255,0);
    rect(pos.x,pos.y,tLength,tHeight);
  }
  
  boolean isTouching(float x, float y) {
    if (x >= pos.x && x <= pos.x + tLength && y <= pos.y) {
      if (y > pos.y - tHeight) {
        return true;
      }
    }
    return false;
  }
  
}
