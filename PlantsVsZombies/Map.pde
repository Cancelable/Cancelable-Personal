public class Map {
  
  private String mapType;
  
  private Tile[][] mapItself;
  
  public Map(String mapType) {
    this.mapType = mapType;
    
    mapItself = new Tile[5][9]; // y,x (i think, double check)
    
    if (mapType == DEFAULT_MAP) {
      for (int r=0;r<5;r++) {
        for (int c=0;c<9;c++) {
          mapItself[r][c] = new TileNormal(c,r);
        }
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
  }// end of function
  
  public String getTileTypeAt(int x, int y) {
    return mapItself[y][x].getTileType();
  }
  
  public void managePlants() {
    for (int r=0;r<mapItself.length;r++) {
      for (int c=0;c<mapItself[r].length;c++) {
        if (mapItself[r][c].getPlant()!=null) {
          mapItself[r][c].getPlant().execute();
        }
      }
    }
    killDeadPlants();
  }
  
  public Tile[][] getMapItself() {
    return mapItself;
  }
  
  private void killDeadPlants() {
    for (int r=0;r<mapItself.length;r++) {
      for (int c=0;c<mapItself[r].length;c++) {
        if (mapItself[r][c].getPlant()!=null) { // if plant not already null
          if (mapItself[r][c].getPlant().shouldDie()) { // if plant should die
            mapItself[r][c].setPlant(null); // set plant to null
          }
        }
      }
    }
  }
  
}
