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

    for (int r=0;r<array.length;r++) {
      for (int c=0;c<array[r].length;c++) {
        // if spot ahead directly is free, make it available
        if (board[r][c]==null && c==x && r==y-1 && (y+1 <= 8) && (y-1 >= 0)) {
          array[r][c] = true;
        // else if piece on left
        } else if (board[r][c]!=null && c==(x-1) && r==y-1 && board[r][c].getTeam()!=getTeam()) {
          array[r][c] = true;
        // else if piece on right
        } else if (board[r][c]!=null && c==(x+1) && r==y-1 && board[r][c].getTeam()!=getTeam()) {
          array[r][c] = true;
        // else
        } else {
          array[r][c] = false;
        }
        // checks for can move 2 pieces
        if (y==6 && (y-2)==r && board[r][c]==null && c==x) {
          array[r][c] = true;
        }
      }
    }
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
  protected boolean wouldNotPlaceInCheck() {
   return true;
  }
  
  //@Override
  protected boolean isMoveLegal(Piece[][] b, int toX, int toY) {
    int x = columnX;
    int y = rowY;
    boolean moveLegal = true;
    Piece[][] draft = b;
    draft[toY][toX] = new Pawn(toX,toY,getTeam());
    draft[y][x].setPieceCoords(toX,toY);
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
  
  //@Override
  public boolean isInCheck(Piece[][] b) {
    return false;
  }
  

  
}
