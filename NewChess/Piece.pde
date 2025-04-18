public class Piece {
  
  public int xCol;
  public int yRow;
  public String team;
  //protected color pieceColor;
  protected PImage pieceImage; // initialize this in smaller classes
  public boolean[][] availableSpots;
  boolean isKing;
  
  public Piece(int x, int y, String team) {
    xCol = x;
    yRow = y;
    this.team = team;
    //if (team==TEAM_ONE) {
    //  pieceColor = WHITE_PIECE_COLOR;
    //} else if (team==TEAM_TWO) {
    //  pieceColor = BLACK_PIECE_COLOR;
    //}
    availableSpots = new boolean[8][8];
    // initially set it all false
    for (int i=0;i<8;i++) {
      for (int i2=0;i2<8;i2++) {
        availableSpots[i][i2] = false;
      }
    }
    isKing = false; // in king class, change this
  }
  
  public void drawPiece() {
    if (pieceImage!=null) {
      image(pieceImage,xCol*TILE_SIZE,yRow*TILE_SIZE);
    }
  }
  
  // override this
  public void changeAvailableSpots(Piece[][] p) {}
  
  // override this
  public void movePiece() {}
  
  protected boolean isOtherTeam(Piece other) {
    if (other!=null&&team!=other.team) {
      return true;
    }
    return false;
  }
  
  public void setPos(int x, int y) {
    xCol = x;
    yRow = y;
  }
  
  // if can move to exact spot
  public boolean canMoveTo(int x, int y) {
    if (availableSpots[y][x]) {
      return true;
    }
    return false;
  }
  
}
