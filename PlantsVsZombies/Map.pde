public class Map {
  
  private String mapType;
  
  private Tile[][] mapItself;
  
  public Map(String mapType) {
    this.mapType = mapType;
    
    mapItself = new Tile[5][9]; // y,x (i think, double check)
  }
  
  public void drawMap() {
    for (int r=0;r<9;r++) {
      for (int c=0;c<5;c++) {
        
      }
    }
  }
  
}
