public class Castle extends Piece {
  
  private int columnX;
  private int rowY;
  private String team;
  
  private int xVal;
  private int yVal;
  
  // 1 for pieces from bottom
  // -1 for pieces from top
  private int upDownConstant;
  
  public Castle(int columnXSpot, int rowYSpot,String teamColor) {
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
    return "C";
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
    
    int maxAbove = 0;
    int maxBelow = 0;
    int maxLeft = 0;
    int maxRight = 0;
    
    // max above
    for (int i=rowY;i<board.length - rowY;i++) {
      if (board[i][columnX]==this) {}
      else if (board[i][columnX]==null) {maxAbove++;}
      else if (board[i][columnX]!=null) {
        if (board[i][columnX].getTeam()==getTeam()) {break;}
        else if (board[i][columnX].getTeam()!=getTeam()) {maxAbove++;break;}
      }
    }
    
    // max below
    for (int i=rowY;i>0;i--) {
      if (board[i][columnX]==this) {}
      else if (board[i][columnX]==null) {maxBelow++;}
      else if (board[i][columnX]!=null) {
        if (board[i][columnX].getTeam()==getTeam()) {break;}
        else if (board[i][columnX].getTeam()!=getTeam()) {maxBelow++;break;}
      }
    }
    
    // max right
    for (int i=columnX;i<board[rowY].length;i++) {
      if (board[rowY][i]==this) {}
      else if (board[rowY][i]==null) {maxRight++;}
      else if (board[rowY][i]!=null) {
        if (board[rowY][i].getTeam()==getTeam()) {break;}
        else if (board[rowY][i].getTeam()!=getTeam()) {maxRight++;break;}
      }
    }
    
    // check left
    for (int i=columnX;i<0;i--) {
      if (board[rowY][7-i]==this) {}
      else if (board[rowY][i]==null) {maxLeft++;}
      else if (board[rowY][i]!=null) {
        if (board[rowY][i].getTeam()==getTeam()) {break;}
        else if (board[rowY][i].getTeam()!=getTeam()) {maxLeft++;break;}
      }
    }
    
    for (int r=0;r<array.length;r++) {
      for (int c=0;c<array[r].length;c++) {
        System.out.println("maxbelow" + maxBelow);
        System.out.println("y"+y);
        if (c==x && r < y && r >= y - maxBelow) {
          array[r][c] = true;
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
