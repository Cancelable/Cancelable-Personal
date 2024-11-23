public class Bishop extends Piece {
  
  private int columnX;
  private int rowY;
  private String team;
  
  private int xVal;
  private int yVal;
  
  // 1 for pieces from bottom
  // -1 for pieces from top
  private int upDownConstant;
  
  public Bishop(int columnXSpot, int rowYSpot,String teamColor) {
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
    return "B";
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
    
    int topLeft = 0;
    int topRight = 0;
    int lowLeft = 0;
    int lowRight = 0;
    
    // get topLeft right
    for (int i=0;i<(board[x].length);i++) {
      int currentX = x - i;
      int currentY = y - i;
      //if (board[yval][i]==this) {}
      if (board[currentY][currentX]==null) {System.out.println("lol");topLeft++;}
      else if (board[currentY][currentX]!=null) {
        if (board[currentY][currentX].getTeam()==getTeam()) {break;}
        else if (board[currentY][currentX].getTeam()!=getTeam()) {topLeft++;break;}
      }
    }
    
    // get topRight right
    for (int i=x;i<board.length;i++) {
      int yval = y - (i-x);
      //if (board[yval][i]==this) {}
      if (board[yval][i]==null) {topRight++;}
      else if (board[yval][i]!=null) {
        if (board[yval][i].getTeam()==getTeam()) {break;}
        else if (board[yval][i].getTeam()!=getTeam()) {topRight++;break;}
      }
    }
    
    // get lowLeft right
    for (int i=x;i>=0;i--) {
      int yval = y + (x-i);
      //if (board[yval][i]==this) {}
      if (board[yval][i]==null) {lowLeft++;}
      else if (board[yval][i]!=null) {
        if (board[yval][i].getTeam()==getTeam()) {break;}
        else if (board[yval][i].getTeam()!=getTeam()) {lowLeft++;break;}
      }
    }
    
    // get lowRight right
    for (int i=x;i<board.length;i++) {
      int yval = y + (i-x);
      //if (board[yval][i]==this) {}
      if (board[yval][i]==null) {lowRight++;}
      else if (board[yval][i]!=null) {
        if (board[yval][i].getTeam()==getTeam()) {break;}
        else if (board[yval][i].getTeam()!=getTeam()) {lowRight++;break;}
      }
    }
    
    
    for (int r=0;r<array.length;r++) {
      for (int c=0;c<array[r].length;c++) {
        
        if ((c+r == r - (y-r) + 4)) {
          if (board[c][r]==null) {
            
          }
        }
        
       
        System.out.println("topleft"+topLeft);
        System.out.println("topright"+topRight);
        System.out.println("lowleft"+lowLeft);
        System.out.println("lowright"+lowRight);
              
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
