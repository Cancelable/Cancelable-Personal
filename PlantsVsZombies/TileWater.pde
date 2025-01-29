public class TileWater extends Tile {
  
  private int colX;
  private int rowY;
  
  public TileWater(int colX, int rowY) {
    this.colX = colX;
    this.rowY = rowY;
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
    
  }
  
  public void affectZombies() {
    
  }
  
}
