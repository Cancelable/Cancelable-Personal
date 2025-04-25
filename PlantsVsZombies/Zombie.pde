import gifAnimation.*;

public class Zombie {
  
  private int health;
  private int damage;
  private int speed;
  
  private int colX;
  private int rowY;
  
  private int actualX;
  private int actualY;
  
  private Gif zombieGIF;
  
  //public Zombie(int colX, int rowY, String zombieType) {
  public Zombie(int rowY, int actualX, String zombieType) {
    this.rowY = rowY;
    colX = -1;
    actualY = rowY * TILE_HEIGHT; // on the top (lower y) edge of the square
    this.actualX = actualX;
    
    if (zombieType==DEFAULT_ZOMBIE) {
      health = 25;
      damage = 5;
      speed = -1;
      zombieGIF = new Gif(parent,"zombieGIF.gif");
    }
  } // end of constructor
  
  public Zombie(int rowY) {
    this(rowY,REAL_WIDTH + (int)random(TILE_WIDTH * 3),DEFAULT_ZOMBIE);
  }
  
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
    if ((actualX - TILE_WIDTH/2) <= REAL_WIDTH) {
      zombieGIF.loop();
      image(zombieGIF, actualX, rowY*TILE_HEIGHT);
    }
  }
  
  public void move(Tile[][] tiles) {
    if (frameCount%5==0) {
      actualX += speed;
    }
    findSetColX();
  }
  
  public void takeDamage(int dmg) {
    health -= dmg;
  }
  
  public void attackPlant(Tile[][] tiles) {
    if (tiles[rowY][colX].getPlant()!=null) {
      speed = 0;
      tiles[rowY][colX].getPlant().loseHealth(damage);
    } else {
      speed = -1;
    }
  }
  
  public void findSetColX() {
    if (actualX >= REAL_WIDTH || actualX < 0) {
      colX = -1;
    } else {
      colX = (int) (actualX/TILE_WIDTH);
    }
  }
  
  public void execute(Tile[][] tilesArray) {
    move(tilesArray);
    if (frameCount%60==0&&getColX()!=-1) {
      attackPlant(tilesArray);
    }
  }
  
}
