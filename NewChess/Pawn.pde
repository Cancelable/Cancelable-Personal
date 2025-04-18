public class Pawn extends Piece {
  
  boolean isFirstMove;
  
  public Pawn(int x, int y, String teamOn) {
    super(x,y,teamOn);
    if (teamOn==TEAM_ONE) {
      pieceImage = loadImage("BlackPawn.png");
    } else if (teamOn==TEAM_TWO) {
      pieceImage = loadImage("WhitePawn.png");
    }
    isFirstMove = true;
  }
  
  @Override
  public void changeAvailableSpots(Piece[][] p) {
    for (int r=0;r<8;r++) {
      for (int c=0;c<8;c++) {
        if (isFirstMove) {
          if (p[r][c]) {
            
          } else {
            
          }
        // if not first move
        } else {
          if () {
            
          } else {
            
          }
        }
      }
    }
  }
  
}
