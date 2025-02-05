public class Sunflower extends Plant {
  
  private int colX;
  private int rowY;
  private int health;
  private boolean shouldDie;
  
  public Sunflower(int colX, int rowY) {
    health = 25;
    this.colX = colX;
    this.rowY = rowY;
    shouldDie = false;
  }
  
  public int getPlantX() {
    return colX;
  }
  
  public  int getPlantY() {
    return rowY;
  }
  
  public String getPlantType() {
    return SUNFLOWER;
  }
  
  public boolean shouldDie() {
    return shouldDie;
  }
  
  public void loseHealth(int amount) {
    health-=amount;
    if (health<=0) {
      shouldDie = true;
    }
  }
  
  public void drawPlant() {
    fill(INSIDE_SUN); // no idea what color - temp
    circle(colX * TILE_WIDTH + TILE_WIDTH/2,rowY * TILE_HEIGHT + TILE_HEIGHT/2, TILE_WIDTH/2);
  }
  
  public void execute() {
    int aX = colX * TILE_WIDTH + (int)random(TILE_WIDTH) * 3/2;
    int aY = rowY * TILE_HEIGHT + (int)random(TILE_HEIGHT) * 3/2;
    if (frameCount%(60*10)==0) {
      sunArray.add(new Sun(aX,aY));
    }
  }
  
}
