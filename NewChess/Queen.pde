public class Queen extends Piece {
  
  public Queen(int x, int y, String teamOn) {
    super(x,y,teamOn);
    isQueen = true;
    if (teamOn==TEAM_ONE) {
      pieceImage = loadImage("WhiteQueen.png");
    } else if (teamOn==TEAM_TWO) {
      pieceImage = loadImage("BlackQueen.png");
    }
  }
  
  @Override
  void changeAvailableSpots(Piece[][] board) {
    super.changeAvailableSpots(board);
    
    int x = xCol;
    int y = yRow;
    
    // get top left
    for (int i=x-1;i>=0;i--) {
      int currentY = y-(x-i);
      if (currentY >= 0) {
        if (board[currentY][i]==null) {
          availableSpots[currentY][i] = true;
        } else if (board[currentY][i].getTeam()==board[y][x].getTeam()) {
          break;
        } else if (board[currentY][i].getTeam()!=board[y][x].getTeam()) {
          availableSpots[currentY][i] = true;
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
          availableSpots[currentY][i] = true;
        } else if (board[currentY][i].getTeam()==board[y][x].getTeam()) {
          break;
        } else if (board[currentY][i].getTeam()!=board[y][x].getTeam()) {
          availableSpots[currentY][i] = true;
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
          availableSpots[currentY][i] = true;

          break;
        } else if (board[currentY][i].getTeam()!=board[y][x].getTeam()) {
          availableSpots[currentY][i] = true;
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
          availableSpots[currentY][i] = true;
        } else if (board[currentY][i].getTeam()==board[y][x].getTeam()) {
          break;
        } else if (board[currentY][i].getTeam()!=board[y][x].getTeam()) {
          availableSpots[currentY][i] = true;
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
          availableSpots[i][x] = true;
        } else if (board[i][x].getTeam()==board[y][x].getTeam()) {
          break;
        } else if (board[i][x].getTeam()!=board[y][x].getTeam()) {
          availableSpots[i][x]=true;
          break;
        }
      } else {
        break;
      }
    }
    
    // get bottom
    for (int i=y+1;i<availableSpots.length;i++) {
      // i know this is unecessary but i need it for ocd
      if (i<availableSpots.length) {
        if (board[i][x]==null) {
          availableSpots[i][x] = true;
        } else if (board[i][x].getTeam()==board[y][x].getTeam()) {
          break;
        } else if (board[i][x].getTeam()!=board[y][x].getTeam()) {
          availableSpots[i][x] = true;
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
          availableSpots[y][i] = true;
        } else if (board[y][i].getTeam()==board[y][x].getTeam()) {
          break;
        } else if (board[y][i].getTeam()!=board[y][x].getTeam()) {
          availableSpots[y][i] = true;
          break;
        }
      } else {
        break;
      }
    }
    
    // get right
    for (int i=x+1;i<availableSpots.length;i++) {
      // i know this is unecessary but i need it for ocd
      if (i<availableSpots.length) {
        if (board[y][i]==null) {
          availableSpots[y][i] = true;
        } else if (board[y][i].getTeam()==board[y][x].getTeam()) {
          break;
        } else if (board[y][i].getTeam()!=board[y][x].getTeam()) {
          availableSpots[y][i] = true;
          break;
        }
      } else {
        break;
      }
    }
    
  }
  
}
