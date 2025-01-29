public class Sun { // class just deals with an INDIVIDUAL SUN
  
  private int xActual;
  private int yActual;
  
  private int fRemaining;
  
  private boolean collected;
  
  public Sun(int colX, int rowY, int fallRemaining) {
    xActual = (colX * TILE_WIDTH) + (TILE_WIDTH/2);
    yActual = yActual * TILE_HEIGHT;
    
    fRemaining = fallRemaining;
    
    collected = false;
  }
  
  public Sun() {
    this((int)random(9),0,(int)random(REAL_HEIGHT/10,(REAL_HEIGHT*9)/10));
  }
  
  public void drawSun() {
    fill(OUTSIDE_SUN);
    rectMode(CENTER);
    //rotate((float)(Math.PI)/2.0);
    square(xActual,yActual,(2*TILE_WIDTH)/3);
    //rotate(-(float)(Math.PI)/2.0);
    fill(INSIDE_SUN);
    circle(xActual,yActual,(2*TILE_WIDTH)/3);
    rectMode(CORNER);
  }
  
  public void sunFalling() {
    if (fRemaining > 0) {
      yActual++;
      fRemaining--;
    }
  }
  
  public void collect() {
    sunValue += 25;
    collected = true;
  }
  
  public boolean isCollected() {
    return collected;
  }
  
}
