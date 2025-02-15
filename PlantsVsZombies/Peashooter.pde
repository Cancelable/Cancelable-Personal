public class Peashooter extends Plant {
  
  private boolean shouldDie;
  private int health;
  
  private int colX;
  private int rowY;
  
  private PImage psPic = loadImage("monkey.png"); //create the PImage object
  
  public Peashooter(int colX, int rowY) {
    shouldDie = false;
    health = 25;
    this.colX = colX;
    this.rowY = rowY;
    psPic.resize(TILE_WIDTH, TILE_HEIGHT); //change the size (width, height)
  }
  
  public int getPlantX() {
    return colX;
  }
  
  public int getPlantY() {
    return rowY;
  }
  
  public String getPlantType() {
    return PEASHOOTER;
  }
  
  public boolean shouldDie() {
    return shouldDie;
  }
  
  public void loseHealth(int amount) {
    health -= amount;
    if (health <= 0) {
      shouldDie = true;
    }
  }
  
  public void drawPlant() {
    //fill(255,0,100); // no idea what color - temp
    //circle(colX * TILE_WIDTH + TILE_WIDTH/2,rowY * TILE_HEIGHT + TILE_HEIGHT/2, TILE_WIDTH/2);
    image(psPic, colX*TILE_WIDTH, rowY*TILE_HEIGHT);
  }
  
  private boolean isZombieInRow() {
    for (int i=0;i<zombiesArray.size();i++) {
      if (zombiesArray.get(i).getRowY()==rowY
      &&zombiesArray.get(i).getActualX()<=REAL_WIDTH/*+TILE_WIDTH*/) {
        return true;
      }
    }
    return false;
  }
  
  public void shootPea() {
    if (isZombieInRow()) {
      projectiles.add(new Projectile(colX*TILE_WIDTH,rowY*TILE_HEIGHT));
    }
  }
  
  public void execute() { // not just one cycle, periodically called
    // time between shooting of every pea 
    if (frameCount % (60*2)==0) {
      shootPea();
    }
  }
  
}
