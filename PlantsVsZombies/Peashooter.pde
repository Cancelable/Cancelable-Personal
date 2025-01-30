public class Peashooter extends Plant {
  
  private boolean shouldDie;
  private int health;
  
  public Peashooter() {
    shouldDie = false;
    health = 25;
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
    projectiles.add(new Projectile());
  }
  
  public void execute() {
    
  }
  
}
