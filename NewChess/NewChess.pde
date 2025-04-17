// variables
final int TILE_SIZE = 600/8;
final color BLACK_TILE = color(50);
final color WHITE_TILE = color(205);
final String TEAM_ONE = "Team One";
final String TEAM_TWO = "Team Two";
//final color WHITE_PIECE_COLOR = color(#99FCBB);
//final color BLACK_PIECE_COLOR = color(#7BC193);

// non final variables
Piece[][] pieces;
Piece selectedPiece;


// setup
void setup() {
  size(600,600);
  pieces = new Piece[8][8];
  selectedPiece = null;
  
}

// setup board pieces
void setupPieces() {
  
}

// draw
void draw() {
  drawBoard();
  
}

void drawBoard() {
  for (int i=0;i<8;i++) {
    for (int p=0;p<8;p++) {
      
      // draw board itself
      if (!((i+p) % 2 == 0)) {
        fill(BLACK_TILE);
      } else {
        fill(WHITE_TILE);
      }
      square(p*TILE_SIZE,i*TILE_SIZE,TILE_SIZE);
      
      // draw pieces
      if (pieces[p][i]!=null) {pieces[p][i].drawPiece();
    }
  }
}
