public class King extends Piece {
  
  public King(int x, int y, String teamOn) {
    super(x,y,teamOn);
    isKing = true;
    if (teamOn==TEAM_ONE) {
      pieceImage = loadImage("WhiteKing.png");
    } else if (teamOn==TEAM_TWO) {
      pieceImage = loadImage("BlackKing.png");
    }
  }
  
  @Override
  public void changeAvailableSpots(Piece[][] p) {
    super.changeAvailableSpots(p);
    for (int r=0;r<8;r++) {
      for (int c=0;c<8;c++) {
        if (abs(c-xCol)<=1 && abs(r-yRow)<=1) {
          if (p[r][c]==null) {
            availableSpots[r][c] = true;
          } else {
            if (isOtherTeam(p[r][c])) {
              availableSpots[r][c] = true;
            }
          }
        }
      }
    }
  }
  
}
