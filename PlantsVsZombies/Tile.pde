public abstract class Tile {
  
  public Tile() {}
  
  // each has its own plant (or null) object
  
  public abstract int getColX();
  
  public abstract int getRowY();
  
  public abstract int getActualX();
  
  public abstract int getActualY();
  
  public abstract String getTileType();
  
  public abstract Plant getPlant();
  
  public abstract void setPlant(Plant newPlant);
  
  public abstract void drawTile();
  
  public abstract void drawTile(color cColor);
  
  public abstract void affectZombies();
  
}
