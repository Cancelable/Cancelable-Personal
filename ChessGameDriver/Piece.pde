public abstract class Piece {
  
  public Piece() {
    
  }
  
  public abstract int getColX();
  
  public abstract int getRowY();
  
  public abstract String getTeam();
  
  public abstract String getLetter();
  
  public abstract void drawPiece();
  
  public abstract void setPieceCoords();
  
  public abstract int getPieceX();
  
  public abstract int getPieceY();
  
  public abstract boolean isHovered();
  
  public abstract void setNewArrayCoords();
  
}
