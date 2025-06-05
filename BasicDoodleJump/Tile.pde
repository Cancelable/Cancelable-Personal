class Tile {
  
  int tLength;
  int tHeight;
  PVector pos;
  Spring spring;
  
  Tile(int x, int y) {
     tLength = (int)random(50) + 70;
     tHeight = (int)random(20) + 10;
     pos = new PVector(x - tLength/2,y+tHeight+5);
     spring = null;
     if ((int)random(100)>90) {spring = new Spring((int)pos.x + (int)random(tLength),(int)pos.y);}
  }
  Tile () {
    this((int)random(width),0);
  }
  Tile(ArrayList<Tile> array) {
    
  }
  
  void display() {
    fill(0,255,0);
    rect(pos.x,pos.y,tLength,tHeight);
  }
  
  boolean isTouching(float x, float y, float yVelocity) {
    if (x >= pos.x && x <= pos.x+tLength && ((y >= pos.y && y <= pos.y+tHeight)||(y<=pos.y && y+yVelocity>=pos.y+tHeight))) {
      return true;
    }
    return false;
  }
  
  boolean isTouching(Tile other) {
    PVector l1 = new PVector(pos.x,pos.y);
    PVector r1 = new PVector(pos.x + tLength,pos.y + tHeight);
    PVector l2 = new PVector(other.pos.x,other.pos.y);
    PVector r2 = new PVector(other.pos.x + other.tLength,other.pos.y + other.tHeight);
    
    if (l1.x > r2.x || l2.x > r1.x) {
      return false;
    }
    
    if (r1.y > l2.y || r2.y > l1.y) {
      return false;
    }
    
    return true;
  }
  
  void moveVertically(float amount) {
    pos.y += amount;
  }
  
}
