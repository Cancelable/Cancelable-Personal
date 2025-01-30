public class Projectile {
  
  int xActual;
  int yActual;
  int speedX;
  int speedY;
  boolean shouldDie;
  
  public Projectile(int xActual, int yActual, int speedX, int speedY, int damage) {
    this.xActual = xActual;
    this.yActual = yActual;
    this.speedX = speedX;
    this.speedY = speedY;
    shouldDie = false;
  }
  
  public Projectile(int xActual, int yActual, int speedX) {
    this(xActual,yActual,speedX,0,5);
  }
  
  public Projectile(int xActual, int yActual) { // sends min damage (peashooter)
    this(xActual,yActual,1,0,5);
  }
  
  public void moveProjectile() {
    xActual += speedX;
    yActual += speedY;
  }
  
  public boolean getShouldDie() {
    return shouldDie;
  }
  
  public void attackZombie() {
    
  }
  
}
