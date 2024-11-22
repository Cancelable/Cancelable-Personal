public class Pawn extends Piece {
  
  private int columnX;
  private int rowY;
  private String team;
  
  private int xVal;
  private int yVal;
  
  public Pawn(int columnXSpot, int rowYSpot,String teamColor) {
    columnX = columnXSpot;
    rowY = rowYSpot;
    team = teamColor;
    
    xVal = columnX*pieceLength + (pieceLength/2);
    yVal = rowY*pieceLength + (pieceLength/2);
  }
  
  //@Override
  public int getColX() {
    return columnX;
  }
  
  //@Override
  public int getRowY() {
    return rowY;
  }
  
  //@Override - idk if you need this in processing
  public String getTeam() {
    return team;
  }
  
  //@Override
  public String getLetter() {
    return "P";
  }
  
  //@Override
  void drawPiece() {
    int lolx = columnX + (pieceLength/2);
    int loly = rowY + (pieceLength/2);
    
    String firstLetter = getLetter();
    if (getTeam()==white) {
      fill(255);
    } else if (getTeam()==black) {
      fill(0);
    }
    circle(lolx,loly,pieceLength);
    textSize(width/10);
    textAlign(CENTER,CENTER);
    fill(255,0,0);
    text(firstLetter,lolx,loly);
  }
  
  //@Override
  void setPieceCoords(int x, int y) {
    // placeholder bool
    xVal = x* + (pieceLength/2);
    yVal = y + (pieceLength/2);
  }
  
  //@Override
  int getPieceX() {
    return xLoc;
  }
  
  //@Override
  int getPieceY() {
    return yLoc;
  }
  
  //@Override
  boolean isHovered() {
    if (this.equals(hoveringOver)) {
      return true;
    } else {
      return false;
    }
  }
  
  void setNewArrayCoords() {
    
  }
  
}
