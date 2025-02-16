import gifAnimation.*;

public class Peashooter extends Plant {
  
  private boolean shouldDie;
  private int health;
  
  private int colX;
  private int rowY;
  
  private Gif peashooterActual;
  private Gif peashooterChilling = new Gif(parent,"peashooterChilling.gif");
  private Gif peashooterShooting = new Gif(parent,"peashooterAttacking.gif");
  
  public Peashooter(int colX, int rowY) {
    shouldDie = false;
    health = 25;
    this.colX = colX;
    this.rowY = rowY;
    peashooterActual = peashooterChilling;
    peashooterActual.loop();
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
    image(peashooterActual,colX*TILE_WIDTH,rowY*TILE_HEIGHT);
  }
  
  private boolean isZombieInRow() {
    for (int i=0;i<zombiesArray.size();i++) {
      if (zombiesArray.get(i).getRowY()==rowY
      &&zombiesArray.get(i).getActualX()<=REAL_WIDTH/*+TILE_WIDTH*/) {
        peashooterActual = peashooterShooting;
        peashooterActual.loop();
        return true;
      }
    }
    peashooterActual = peashooterChilling;
    peashooterActual.loop();
    return false;
  }
  
  public void shootPea() {
    if (isZombieInRow()) {
      projectiles.add(new Projectile(colX*TILE_WIDTH+TILE_WIDTH,rowY*TILE_HEIGHT));
    }
  }
  
  public void execute() { // not just one cycle, periodically called
    // time between shooting of every pea 
    if ((frameCount % (6*14)==0)) {
      shootPea();
    }
  }
  
}
