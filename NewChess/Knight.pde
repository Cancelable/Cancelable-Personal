public class Knight extends Piece {
  
  public Knight(int x, int y, String teamOn) {
    super(x,y,teamOn);
    isKnight = true;
    if (teamOn==TEAM_ONE) {
      pieceImage = loadImage("WhiteHorse.png");
    } else {
      pieceImage = loadImage("BlackHorse.png");
    }
  }
  
}
