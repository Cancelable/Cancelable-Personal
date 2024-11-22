public class Pawn extends Piece {
  
  private int columnX;
  private int rowY;
  private String team;
  
  private int xLoc;
  private int yLoc;
  
  public Pawn(int columnXSpot, int rowYSpot,String teamColor) {
    columnX = columnXSpot;
    rowY = rowYSpot;
    team = teamColor;
    
    xLoc = columnX * pieceLength;
    yLoc = rowY * pieceLength;
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
  void drawPiece(/*Piece piece*/) {
    int lolx;
    int loly;
    lolx = xLoc;
    loly = yLoc;
    /*if (isHovered()) {
      lolx = (int)mouseX;
      loly = (int)mouseY;
    }
    else {
      lolx = xLoc + (pieceLength/2);
      loly = yLoc + (pieceLength/2);
    }*/
    String firstLetter = /*piece.*/getLetter();
    if (/*piece.*/getTeam()==white) {
      fill(255);
    } else if (/*piece.*/getTeam()==black) {
      fill(0);
    }
    circle(lolx,loly,pieceLength);
    textSize(width/10);
    textAlign(CENTER,CENTER);
    fill(255,0,0);
    text(firstLetter,lolx,loly);
  }
  
  //@Override
  void setPieceCoords() {
    // placeholder bool
    if (isHovered()) {
      xLoc = (int)mouseX;
      yLoc = (int)mouseY;
    } else {
      xLoc = columnX + (pieceLength/2);
      yLoc = rowY + (pieceLength/2);
    }
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
