public class Horse extends Piece {
  
  private int columnX;
  private int rowY;
  private String team;
  
  private int xVal;
  private int yVal;
  
  // 1 for pieces from bottom
  // -1 for pieces from top
  private int upDownConstant;
  
  public Horse(int columnXSpot, int rowYSpot,String teamColor) {
    columnX = columnXSpot;
    rowY = rowYSpot;
    team = teamColor;
    
    xVal = columnX*pieceLength + (pieceLength/2);
    yVal = rowY*pieceLength + (pieceLength/2);
    
    setUpDownConstant();
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
    return "H";
  }
  //@Override
  void drawPiece() {
    String firstLetter = getLetter();
    if (getTeam()==white) {
      fill(255);
    } else if (getTeam()==black) {
      fill(0);
    }
    circle(xVal,yVal,pieceLength);
    textSize(width/10);
    textAlign(CENTER,CENTER);
    fill(255,0,0);
    text(firstLetter,xVal,yVal);
  }
  
  //@Override
  public void setPieceCoords(int x, int y) {
    columnX = x;
    rowY = y;
    // placeholder bool
    xVal = x*pieceLength + (pieceLength/2);
    yVal = y*pieceLength + (pieceLength/2);
  }
  
  //@Override
  public int getPieceX() {
    return xVal;
  }
  
  //@Override
  public int getPieceY() {
    return yVal;
  }
  
  //@Override
  public boolean[][] getCanMove() {
    int x = columnX;
    int y = rowY;
    boolean[][] array = new boolean[8][8];
    for (int r=0;r<array.length;r++) {
      for (int c=0;c<array[r].length;c++) {
        
        if ((r==y-2) && (c == x-1 || c==x+1)) {
          if (board[r][c]==null) {
            array[r][c] = true;
          } else if (board[r][c].getTeam()!=getTeam()) {
            array[r][c] = true;
          }
        } else if ((r==y+2) && (c==x-1 || c==x+1)) {
          if (board[r][c]==null) {
            array[r][c] = true;
          } else if (board[r][c].getTeam()!=getTeam()) {
            array[r][c] = true;
          }
        } else if ((r==y+1) && (c==x+2 || c==x-2)) {
          if (board[r][c]==null) {
            array[r][c] = true;
          } else if (board[r][c].getTeam()!=getTeam()) {
            array[r][c] = true;
          }
        } else if ((r==y-1) && (c==x+2 || c==x-2)) {
          if (board[r][c]==null) {
            array[r][c] = true;
          } else if (board[r][c].getTeam()!=getTeam()) {
            array[r][c] = true;
          }
        } else {
          array[r][c] = false;
        }
        
      }
    }
    return array;
  }
  
  //@Override
  protected boolean wouldNotPlaceInCheck() {
   return true;
  }
  
  //@Override
  protected void setUpDownConstant() {
    if (colorC==team) {
      upDownConstant = 1;
    } else {
      upDownConstant = -1;
    }
  }
  
  
  
}
