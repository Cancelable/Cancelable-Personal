public class Projectile {
  
  private int xActual;
  private int yActual;
  private int rowY;
  private int speedX;
  private int speedY;
  private boolean shouldDie;
  private int damage;
  private int projectileWidth;
  
  public Projectile(int xActual, int yActual, int speedX, int speedY, int damage) {
    this.xActual = xActual;
    this.yActual = yActual;
    rowY = yActual/TILE_HEIGHT;
    this.speedX = speedX;
    this.speedY = speedY;
    shouldDie = false;
    this.damage = damage;
    projectileWidth = TILE_WIDTH/4;
  }
  
  public Projectile(int xActual, int yActual, int speedX) {
    this(xActual,yActual,speedX,0,5);
  }
  
  public Projectile(int xActual, int yActual) { // sends min damage (peashooter)
    this(xActual,yActual,2,0,5);
  }
  
  public Projectile(String specialProjectileType) {
    
  }
  
  public void moveProjectile() {
    xActual += speedX;
    yActual += speedY;
    if (xActual>REAL_WIDTH||xActual<0||yActual<0||yActual>REAL_HEIGHT) {
      shouldDie = true;
    }
  }
  
  public boolean getShouldDie() {
    return shouldDie;
  }
  
  public void drawProjectile() {
    fill(0,255,255); // yellow - temp
    circle(xActual,yActual + TILE_HEIGHT/2,projectileWidth);
  }
  
  public void attackZombie() {
    for (int i=0;i<zombiesArray.size();i++) {
      if (zombiesArray.get(i).getRowY()==rowY
      &&zombiesArray.get(i).getActualX()>xActual-projectileWidth
      &&zombiesArray.get(i).getActualX()<xActual+projectileWidth) {
        zombiesArray.get(i).takeDamage(damage);
        damage = 0;
        shouldDie = true;
      }
    }
  }
  
}
