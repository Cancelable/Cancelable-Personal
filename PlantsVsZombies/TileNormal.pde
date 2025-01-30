public class TileNormal extends Tile {
  
  private int colX;
  private int rowY;
  
  private int xActual;
  private int yActual;
  
  private Plant myPlant;
  
  public TileNormal(int colX, int rowY, Plant myPlant) {
    this.colX = colX;
    this.rowY = rowY;
    xActual = TILE_WIDTH * colX;
    yActual = TILE_HEIGHT * rowY;
    this.myPlant = myPlant;
  }
  
  public TileNormal(int colX, int rowY) {
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
    return NORMAL_TILE;
  }
  
  public Plant getPlant() {
    return myPlant;
  }
  
  public void drawTile() {
    fill(255);
    rect(xActual,yActual,TILE_WIDTH,TILE_HEIGHT);
  }
  
  public void drawTile(color cColor) {
    fill(cColor);
    rect(xActual,yActual,TILE_WIDTH,TILE_HEIGHT);
  }
  
  public void affectZombies() {}
  
}
