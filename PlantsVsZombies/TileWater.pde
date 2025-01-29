public class TileWater extends Tile {
  
  private int colX;
  private int rowY;
  
  private int xActual;
  private int yActual;
  
  public TileWater(int colX, int rowY) {
    this.colX = colX;
    this.rowY = rowY;
    
    xActual = TILE_WIDTH * colX;
    yActual = TILE_HEIGHT * rowY;
  }
  
  public int getColX() {
    return colX;
  }
  
  public int getRowY() {
    return rowY;
  }
  
  public String getTileType() {
    return WATER_TILE;
  }
  
  public void drawTile() {
    fill(WATER_BLUE);
    rect(xActual,yActual,TILE_WIDTH,TILE_HEIGHT);
  }
  
  public void drawTile(color cColor) {} // don't use this for water lol
  
  public void affectZombies() {
    
  }
  
}
