public class Piece {
  
  public int xCol;
  public int yRow;
  public String team;
  //protected color pieceColor;
  public PImage pieceImage; // initialize this in smaller classes
  public boolean[][] availableSpots;
  boolean isKing;
  boolean isQueen;
  boolean isPawn;
  boolean isBishop;
  boolean isKnight;
  boolean isCastle;
  
  public Piece(int x, int y, String team) {
    xCol = x;
    yRow = y;
    this.team = team;
    availableSpots = new boolean[8][8];
    // initially set it all false
    for (int i=0;i<8;i++) {
      for (int i2=0;i2<8;i2++) {
        availableSpots[i][i2] = false;
      }
    }
    // change the individual one in individual subclass
    isKing = false;
    isQueen = false;
    isPawn = false;
    isBishop = false;
    isKnight = false;
    isCastle = false;
  }
  
  public void drawPiece() {
    if (pieceImage!=null) {
      image(pieceImage,xCol*TILE_SIZE,yRow*TILE_SIZE);
    }
  }
  
  // override this
  public void changeAvailableSpots(Piece[][] p) {
    // reset it
    for (int r=0;r<8;r++){for(int c=0;c<8;c++){availableSpots[r][c]=false;}}
  }
  
  public void movePiece(Piece[][] board, int x, int y) {
    int oldX = xCol;
    int oldY = yRow;
    setPos(x,y);
    board[y][x] = this;
    board[oldY][oldX] = null;
  }
  
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
  
  /* INSTRUCTIONS FOR CREATING A NEW TYPE OF PIECE:
  //
  // - Override the changeAvailableSpots(Piece[][] p) method
  // - In the constructor, set the corresponding PieceImage
  // - In the constructor, set true the correct isPiece boolean
  //
  */
  
  public String getTeam() {
    return team;
  }
  
}
