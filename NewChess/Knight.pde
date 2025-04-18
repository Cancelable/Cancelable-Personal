public class Knight extends Piece {
  
  public Knight(int x, int y, String teamOn) {
    super(x,y,teamOn);
    isKnight = true;
    if (teamOn==TEAM_ONE) {
      pieceImage = loadImage("WhiteHorse.png");
    } else if (teamOn==TEAM_TWO) {
      pieceImage = loadImage("BlackHorse.png");
    }
  }
  
  @Override
  void changeAvailableSpots(Piece[][] p) {
    int x = xCol;
    int y = yRow;
    super.changeAvailableSpots(p);
    for (int r=0;r<8;r++) {
      for (int c=0;c<8;c++) {
        if ((r==y-2) && (c == x-1 || c==x+1)) {
          if (p[r][c]==null) {
            availableSpots[r][c] = true;
          } else if (isOtherTeam(p[r][c])) {
            availableSpots[r][c] = true;
          }
        } else if ((r==y+2) && (c==x-1 || c==x+1)) {
          if (p[r][c]==null) {
            availableSpots[r][c] = true;
          } else if (isOtherTeam(p[r][c])) {
            availableSpots[r][c] = true;
          }
        } else if ((r==y+1) && (c==x+2 || c==x-2)) {
          if (p[r][c]==null) {
            availableSpots[r][c] = true;
          } else if (isOtherTeam(p[r][c])) {
            availableSpots[r][c] = true;
          }
        } else if ((r==y-1) && (c==x+2 || c==x-2)) {
          if (p[r][c]==null) {
            availableSpots[r][c] = true;
          } else if (isOtherTeam(p[r][c])) {
            availableSpots[r][c] = true;
          }
        } else {
          availableSpots[r][c] = false;
        }
      }
    }
  }
  
}
