public class Bishop extends Piece {
  
  private int columnX;
  private int rowY;
  private String team;
  
  private int xVal;
  private int yVal;
  
  public Bishop(int columnXSpot, int rowYSpot,String teamColor) {
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
  public boolean[][] getUnfilteredMove() {
    int x = columnX;
    int y = rowY;
    boolean[][] array = new boolean[8][8];
    
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
    // return array
    return array;
  }
  
  public boolean[][] getCanMove() {
    boolean[][] array = getUnfilteredMove();
    for (int r=0;r<array.length;r++) {
      for (int c=0;c<array[r].length;c++) {
        if (array[r][c]==true) {
          if (!isMoveLegal(board,c,r)) {
            array[r][c] = false;
          }
        }
      }
    }
    // return array
    return array;
  }
  
  //@Override
  public boolean isInCheck(Piece[][] b) {
   return true;
  }
  
  //@Override
  protected boolean isMoveLegal(Piece[][] b, int toX, int toY) {
    int x = columnX;
    int y = rowY;
    boolean moveLegal = true;
    Piece[][] draft = new Piece[8][8];
    for (int r=0;r<8;r++) {for (int c=0;c<8;c++) {draft[r][c]=b[r][c];}}
    draft[toY][toX] = new Pawn(toX,toY,getTeam());
    draft[y][x] = null;
    for (int r=0;r<draft.length;r++) {
      for (int c=0;c<draft[r].length;c++) {
        if (draft[r][c] != null &&
        draft[r][c].getLetter()=="K" &&
        draft[r][c].getTeam()==getTeam()) {
          if (draft[r][c].isInCheck(draft)) {
            moveLegal = false;
          }
        }
      }
    }
    return moveLegal;
  }
  
}
