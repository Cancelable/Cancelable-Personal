public class Peashooter extends Plant {
  
  private boolean shouldDie;
  private int health;
  
  private int colX;
  private int rowY;
  
  public Peashooter(int colX, int rowY) {
    shouldDie = false;
    health = 25;
    this.colX = colX;
    this.rowY = rowY;
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
  
  public void shootPea() {
    projectiles.add(new Projectile(colX*TILE_WIDTH,rowY*TILE_HEIGHT));
  }
  
  public void execute() { // not just one cycle, periodically called
    if (frameCount%60==0) {
      shootPea();
    }
  }
  
}
