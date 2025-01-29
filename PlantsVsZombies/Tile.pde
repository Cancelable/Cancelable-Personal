public abstract class Tile {
  
  public Tile() {}
  
  public abstract int getColX();
  
  public abstract int getRowY();
  
  public abstract String getTileType();
  
  public abstract void drawTile();
  
  public abstract void drawTile(color cColor);
  
  public abstract void affectZombies();
  
}
