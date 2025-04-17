public class Piece {
  
  public int xCol;
  public int yRow;
  public String team;
  //protected color pieceColor;
  protected PImage pieceImage; // initialize this in smaller classes
  public boolean[][] availableSpots;
  
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
  }
  
  // Override this in smaller classes
  public void drawPiece() {
    if (pieceImage!=null) {
      image(pieceImage,xCol*TILE_SIZE,yRow*TILE_SIZE);
    }
  }
  
}
