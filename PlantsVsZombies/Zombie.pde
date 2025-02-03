public class Zombie {
  
  private int health;
  private int damage;
  private int speed;
  
  private int colX;
  private int rowY;
  
  private int actualX;
  private int actualY;
  
  //public Zombie(int colX, int rowY, String zombieType) {
  public Zombie(int rowY, int actualX, String zombieType) {
    this.rowY = rowY;
    colX = -1;
    actualY = rowY * TILE_HEIGHT;
    this.actualX = actualX;
    
    if (zombieType==DEFAULT_ZOMBIE) {
      health = 25;
      damage = 5;
      speed = -1;
    }
    
  } // end of constructor
  
  public Zombie(String zombieType) {
    this((int)random(5),REAL_WIDTH + (int)random(TILE_WIDTH * 3),zombieType);
  }
  
  public Zombie() { // default zombie
    this(DEFAULT_ZOMBIE);
  }
  
  public int getColX() {
    return colX; // -1 is not on board
  }
  
  public int getRowY() {
    return rowY; // -1 is not on board
  }
  
  public int getActualX() {
    return actualX;
  }
  
  public int getActualY() {
    return actualY;
  }
  
  public int getHealth() {
    return health;
  }
  
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
  
  public void checkWhatTileIsOver() {
    if (actualX > REAL_WIDTH || actualX < 0) {
      colX = -1;
    } else {
      colX = (int) (actualX/TILE_WIDTH);
    }
  }
  
  public void execute(Tile[][] tilesArray) {
    if (frameCount % 2 == 0) {
      move(tilesArray);
    }
    if (frameCount%60==0&&getColX()!=-1) {
      attackPlant(tilesArray);
    }
  }
  
}
