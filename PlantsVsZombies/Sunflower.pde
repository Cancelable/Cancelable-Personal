import gifAnimation.*;

public class Sunflower extends Plant {
  
  private int colX;
  private int rowY;
  private int health;
  private boolean shouldDie;
  private int frameCountStart;
  
  private Gif sunflowerGIF;
  
  public Sunflower(int colX, int rowY) {
    frameCountStart = frameCount;
    health = 25;
    this.colX = colX;
    this.rowY = rowY;
    shouldDie = false;
    sunflowerGIF = new Gif(parent,"sunflowerGIF.gif");
    sunflowerGIF.loop();
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
    //fill(INSIDE_SUN); // no idea what color - temp
    //circle(colX * TILE_WIDTH + TILE_WIDTH/2,rowY * TILE_HEIGHT + TILE_HEIGHT/2, TILE_WIDTH/2);
    image(sunflowerGIF,colX*TILE_WIDTH,rowY*TILE_HEIGHT);
  }
  
  public void execute() {
    if ((frameCount-frameCountStart)%(60*24)==0) {
      sunArray.add(new Sun(colX,rowY));
    }
  }
  
}
