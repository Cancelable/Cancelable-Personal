public class TileWater extends Tile {
  
  private int colX;
  private int rowY;
  
  private int xActual;
  private int yActual;
  
  private Plant myPlant;
  
  public TileWater(int colX, int rowY, Plant myPlant) {
    this.colX = colX;
    this.rowY = rowY;
    xActual = TILE_WIDTH * colX;
    yActual = TILE_HEIGHT * rowY;
    this.myPlant = myPlant;
  }
  public TileWater(int colX, int rowY) { // MAIN CONSTRUCTOR
    this(colX,rowY,null);
  }
  
  public int getColX() {
    return colX;
  }
  
  public int getRowY() {
    return rowY;
  }
  
  public int getActualX() {
    return xActual;
  }
  
  public int getActualY() {
    return yActual;
  }
  
  public String getTileType() {
    return WATER_TILE;
  }
  
  public Plant getPlant() {
    return myPlant;
  }
  
  public void setPlant(Plant newPlant) {
    myPlant = newPlant;
  }
  
  public void drawTile() {
    fill(WATER_BLUE);
    rect(xActual,yActual,TILE_WIDTH,TILE_HEIGHT);
  }
  
  public void drawTile(color cColor) {} // don't use this for water lol
  
  public void affectZombies() {
    
  }
  
}
