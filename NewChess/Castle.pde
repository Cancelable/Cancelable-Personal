public class Castle extends Piece {
  
  int cOriginalX;
  int cOriginalY;
  
  public Castle(int x, int y, String teamOn) {
    super(x,y,teamOn);
    isCastle = true;
    if (teamOn==TEAM_ONE) {
      pieceImage = loadImage("WhiteCastle.png");
    } else if (teamOn==TEAM_TWO) {
      pieceImage = loadImage("BlackCastle.png");
    }
    cOriginalX = x;
    cOriginalY = y;
  }
  
  @Override
  public void changeAvailableSpots(Piece[][] board) {
    super.changeAvailableSpots(board);
    
    int x = xCol;
    int y = yRow;
    
    int maxAbove = 0;
    int maxBelow = 0;
    int maxLeft = 0;
    int maxRight = 0;
    
    // max above
    for (int i=yRow;i<board.length;i++) {
      if (board[i][xCol]==this) {}
      else if (board[i][xCol]==null) {maxAbove++;}
      else if (board[i][xCol]!=null) {
        if (!isOtherTeam(board[i][xCol])) {break;}
        else if (board[i][xCol].getTeam()!=getTeam()) {maxAbove++;break;}
      }
    }
    
    // max below
    for (int i=yRow;i>=0;i--) {
      if (board[i][xCol]==this) {}
      else if (board[i][xCol]==null) {maxBelow++;}
      else if (board[i][xCol]!=null) {
        if (board[i][xCol].getTeam()==getTeam()) {break;}
        else if (board[i][xCol].getTeam()!=getTeam()) {maxBelow++;break;}
      }
    }
    
    // max right
    for (int i=xCol;i<board[yRow].length;i++) {
      if (board[yRow][i]==this) {}
      else if (board[yRow][i]==null) {maxRight++;}
      else if (board[yRow][i]!=null) {
        if (board[yRow][i].getTeam()==getTeam()) {break;}
        else if (board[yRow][i].getTeam()!=getTeam()) {maxRight++;break;}
      }
    }
    
    // check left
    for (int i=xCol;i>=0;i--) {
      if (board[yRow][i]==this) {}
      else if (board[yRow][i]==null) {maxLeft++;}
      else if (board[yRow][i]!=null) {
        if (board[yRow][i].getTeam()==getTeam()) {break;}
        else if (board[yRow][i].getTeam()!=getTeam()) {maxLeft++;break;}
      }
    }
    
    for (int r=0;r<availableSpots.length;r++) {
      for (int c=0;c<availableSpots[r].length;c++) {
        if (c==x && r < y && r >= (y - maxBelow)) {
          availableSpots[r][c] = true;
        }
        else if (c==x && r > y && r <= (y + maxAbove)) {
          availableSpots[r][c] = true;
        }
        else if (r==y && c < x && c >= (x - maxLeft)) {
          availableSpots[r][c] = true;
        }
        else if (r==y && c > x && c <= (x + maxRight)) {
          availableSpots[r][c] = true;
        }
        else {
          availableSpots[r][c] = false;
        }
      }
    }
    
  }
  
  @Override
  public void movePiece(Piece[][] board, int x, int y) {
    super.movePiece(board,x,y);
    if (xCol!=cOriginalX||yRow!=cOriginalY) {
      if (team==TEAM_ONE) {
        if (cOriginalX==0) {
          teamOneCanLeftCastle = false;
        } else if (cOriginalX==7) {
          teamOneCanRightCastle = false;
        }
      } else if (team==TEAM_TWO) {
        if (cOriginalX==0) {
          teamTwoCanLeftCastle = false;
        } else if (cOriginalX==7) {
          teamTwoCanRightCastle = false;
        }
      }
    }
  }
  
}
