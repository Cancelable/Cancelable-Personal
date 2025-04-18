public class Pawn extends Piece {
  
  public Pawn(int x, int y, String teamOn) {
    super(x,y,teamOn);
    if (teamOn==TEAM_ONE) {
      pieceImage = loadImage("WhitePawn.png");
    } else if (teamOn==TEAM_TWO) {
      pieceImage = loadImage("BlackPawn.png");
    }
  }
  
  @Override
  public void changeAvailableSpots(Piece[][] p) {
    // reset it
    for (int r=0;r<8;r++){for(int c=0;c<8;c++){availableSpots[r][c]=false;}}
    // set true ones true
    for (int r=0;r<8;r++) {
      for (int c=0;c<8;c++) {
        // in the same column (x val)
        if (xCol==c) {
          // check space in front to see if free
          if (yRow>0&&r==yRow-1&&p[r][c]==null) {
            availableSpots[r][c] = true;
          }
          // check space in front 2 spots if hasnt moved pawn yet
          if (yRow==6&&r==yRow-2&&p[r-2][c]==null&&p[r-1][c]==null) {
            availableSpots[r][c] = true;
          }
        }
        // if not in the same column
        if (r==yRow-1&&(xCol-1==c||xCol+1==c)) {
          if (isOtherTeam(p[r][c])) {
            availableSpots[r][c] = true;
          }
        }
      }
    }
  }
  
}
