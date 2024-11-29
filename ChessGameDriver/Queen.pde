public class Queen extends Piece {
  
  private int columnX;
  private int rowY;
  private String team;
  
  private int xVal;
  private int yVal;
  
  // 1 for pieces from bottom
  // -1 for pieces from top
  private int upDownConstant;
  
  public Queen(int columnXSpot, int rowYSpot,String teamColor) {
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
    return "Q";
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
    
    // get top left
    for (int i=x-1;i>=0;i--) {
      int currentY = y-(x-i);
      if (currentY >= 0) {
        if (board[currentY][i]==null) {
          array[currentY][i] = true;
        } else if (board[currentY][i].getTeam()==board[y][x].getTeam()) {
          break;
        } else if (board[currentY][i].getTeam()!=board[y][x].getTeam()) {
          array[currentY][i] = true;
          break;
        }
      } else {
        break;
      }
    }
    
    // get bottom right
    for (int i=x+1;i<board.length;i++) {
      int currentY = y+(i-x);
      if (currentY < board.length) {
        if (board[currentY][i]==null) {
          array[currentY][i] = true;
        } else if (board[currentY][i].getTeam()==board[y][x].getTeam()) {
          break;
        } else if (board[currentY][i].getTeam()!=board[y][x].getTeam()) {
          array[currentY][i] = true;
          break;
        }
      } else {
        break;
      }
    }
    
    // get bottom left
    for (int i=x-1;i>=0;i--) {
      int currentY = y+(x-i);
      if (currentY<board.length) {
        if (board[currentY][i]==null) {
          array[currentY][i] = true;
        } else if (board[currentY][i].getTeam()==board[y][x].getTeam()) {
          break;
        } else if (board[currentY][i].getTeam()!=board[y][x].getTeam()) {
          array[currentY][i] = true;
          break;
        }
      } else {
        break;
      }
    }
    
    // get top right
    for (int i=x+1;i<board.length;i++) {
      int currentY = y-(i-x);
      if (currentY >= 0) {
        if (board[currentY][i]==null) {
          array[currentY][i] = true;
        } else if (board[currentY][i].getTeam()==board[y][x].getTeam()) {
          break;
        } else if (board[currentY][i].getTeam()!=board[y][x].getTeam()) {
          array[currentY][i] = true;
          break;
        }
      } else {
        break;
      }
    }
    
    // get top
    for (int i=y-1;i>=0;i--) {
      // i know this is unecessary but i need it for ocd
      if (y>=0) {
        if (board[i][x]==null) {
          array[i][x] = true;
        } else if (board[i][x].getTeam()==board[y][x].getTeam()) {
          break;
        } else if (board[i][x].getTeam()!=board[y][x].getTeam()) {
          array[i][x]=true;
          break;
        }
      } else {
        break;
      }
    }
    
    // get bottom
    for (int i=y-1;i<array.length;i++) {
      // i know this is unecessary but i need it for ocd
      if (i<array.length) {
        if (board[i][x]==null) {
          array[i][x] = true;
        } else if (board[i][x].getTeam()==board[y][x].getTeam()) {
          break;
        } else if (board[i][x].getTeam()!=board[y][x].getTeam()) {
          array[i][x] = true;
          break;
        }
      } else {
        break;
      }
    }
    
    // get left
    for (int i=x-1;i>=0;i--) {
      // i know this is unecessary but i need it for ocd
      if (i>=0) {
        if (board[y][i]==null) {
          array[y][i] = true;
        } else if (board[y][i].getTeam()==board[y][x].getTeam()) {
          break;
        } else if (board[y][i].getTeam()!=board[y][x].getTeam()) {
          array[y][i] = true;
          break;
        }
      } else {
        break;
      }
    }
    
    // get right
    for (int i=x+1;i<array.length;i++) {
      // i know this is unecessary but i need it for ocd
      if (i<array.length) {
        if () {
          
        } else if () {
          
        } else if () {
          
        }
      } else {
        break;
      }
    }
    
    
    // return array
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
