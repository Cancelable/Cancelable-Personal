public abstract class Piece {
  
  public Piece() {
    
  }
  
  public abstract int getColX();
  
  public abstract int getRowY();
  
  public abstract String getTeam();
  
  public abstract String getLetter();
  
  public abstract void drawPiece();
  
  public abstract void setPieceCoords(int x, int y);
  
  public abstract int getPieceX();
  
  public abstract int getPieceY();
  
  public abstract boolean[][] getCanMove();
  
  protected abstract boolean wouldNotPlaceInCheck();
  
  protected abstract boolean isMoveLegal(Piece[][] b, int toX, int toY);
  
}
