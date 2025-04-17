class Piece {
  
  int xCol;
  int yRow;
  String team;
  color pieceColor;
  PImage pieceImage;
  
  Piece(int x, int y, String pieceTeam) {
    xCol = x;
    yRow = y;
    team = pieceTeam;
    if (team==TEAM_ONE) {
      pieceColor = WHITE_PIECE_COLOR;
    } else if (team==TEAM_TWO) {
      pieceColor = BLACK_PIECE_COLOR;
    }
  }
  
  void drawPiece() {
    
  }
  
}
