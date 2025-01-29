public class TileNormal extends Tile {
  
  private int colX;
  private int rowY;
  
  private int xActual;
  private int yActual;
  
  private Plant myPlant;
  
  public TileNormal(int colX, int rowY) {
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
    return NORMAL_TILE;
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
