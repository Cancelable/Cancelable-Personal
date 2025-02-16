public class Lawnmower {
  
  int actualX,actualY,rowY;
  
  public Lawnmower(int rowY) {
    actualX = 0;
    this.rowY = rowY;
    actualY = rowY * TILE_HEIGHT;
  }
  
  private void move() {
    actualX += 2;
  }
  
  private void attackZombies() {
    
  }
  
  
}
