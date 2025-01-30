public class Zombie {
  
  private int health;
  private int damage;
  private int speed;
  
  private int colX;
  private int rowY;
  
  private int actualX;
  private int actualY;
  
  public Zombie(int colX, int rowY, String zombieType) {
    this.colX = colX;
    this.rowY = rowY;
    actualX = colX * TILE_WIDTH;
    actualY = rowY * TILE_HEIGHT;
    
    if (zombieType==DEFAULT_ZOMBIE) {
      health = 25;
      damage = 5;
      speed = -1;
    }
    
  } // end of constructor
  
  public void drawZombie() {
    
  }
  
  public void move(Tile[][] tiles) {
    if (frameCount%5==0) {
      actualX -= speed;
    }
    // figure out what tile we're on
    for (int i=0;i<tiles[rowY].length;i++) {
      if (actualX > tiles[rowY][i].getActualX() && actualX <= tiles[rowY][i].getActualX() + TILE_WIDTH) {
        colX = i;
      }
    }
  }
  
  public void attackPlant(Tile[][] tiles) {
    if (tiles[rowY][colX].getPlant()!=null) {
      tiles[rowY][colX].getPlant().loseHealth(damage);
    }
  }
  
  public void execute(Tile[][] tilesArray) {
    if (frameCount % 2 == 0) {
      move(tilesArray);
    }
    if (frameCount % 60 == 0) {
      attackPlant(tilesArray);
    }
  }
  
}
