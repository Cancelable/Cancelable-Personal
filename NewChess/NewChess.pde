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
String currentTeam;
boolean teamOneCanCastle;
boolean teamTwoCanCastle;


// setup
void setup() {
  size(600,600);
  pieces = new Piece[8][8];
  selectedPiece = null;
  currentTeam = TEAM_ONE;
  teamOneCanCastle = true;
  teamTwoCanCastle = true;
}

// setup board pieces
void setupPieces() {
  // set up pawns
  for (int r=0;r<8;r++) {
    for (int c=0;c<8;c++) {
      
    }
  }
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
      if (pieces[i][p]!=null) {pieces[i][p].drawPiece();}
    }
  }
}

// flips move and makes the other team playable
void makeMove() {
  // flip board and update pieces with flipped
  Piece[][] fakePieces = new Piece[8][8];
  for (int r=0;r<8;r++) {
    for (int c=0;c<8;c++) {
      fakePieces[r][c] = pieces[7-r][7-c];fakePieces[r][c].setPos(c,r);
    }
  }
  pieces = fakePieces; // update
  
  // switch team
  if (currentTeam==TEAM_ONE) {
    currentTeam = TEAM_TWO;
  } else {
    currentTeam = TEAM_ONE;
  }
  // make selected piece null
  selectedPiece = null;
}

void mousePressed() {
  
}
void mouseReleased() {
  
}
