public class Map {
  
  private String mapType;
  
  private Tile[][] mapItself;
  
  public Map(String mapType) {
    this.mapType = mapType;
    
    mapItself = new Tile[5][9]; // y,x (i think, double check)
    
    for (int r=0;r<5;r++) {
      for (int c=0;c<9;c++) {
        mapItself[r][c] = new TileNormal(c,r);
      }
    }
  }
  
  public void drawMap() {
    for (int r=0;r<5;r++) {
      for (int c=0;c<9;c++) {
        if ((r+c)%2==0) {
          mapItself[r][c].drawTile(MIDDLE_GREEN);
        } else if (r%2==0) {
          mapItself[r][c].drawTile(DARKEST_GREEN);
        } else {
          mapItself[r][c].drawTile(LIGHTEST_GREEN);
        }
        if (mapItself[r][c].getTileType()==WATER_TILE) {
          mapItself[r][c].drawTile();
        }
      }
    }
  }
  
}
