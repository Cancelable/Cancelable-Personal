// variables
final int TILE_SIZE = 600/8;
final color BLACK_TILE = color(50);
final color WHITE_TILE = color(205);
final String TEAM_ONE = "Team One";
final String TEAM_TWO = "Team Two";
final color SELECTED_COLOR = color(#99FCBB);
//final color BLACK_PIECE_COLOR = color(#7BC193);

// non final variables
Piece[][] pieces;
Piece selectedPiece;
String currentTeam;
boolean teamOneCanCastle;
boolean teamTwoCanCastle;
PVector currentKingXY;


// setup
void setup() {
  size(600,600);
  pieces = new Piece[8][8];
  selectedPiece = null;
  currentTeam = TEAM_ONE;
  teamOneCanCastle = true;
  teamTwoCanCastle = true;
  currentKingXY = new PVector(4,7);
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
      
      // pick colors
      if (!((i+p) % 2 == 0)) {
        fill(BLACK_TILE);
      } else {
        fill(WHITE_TILE);
      }
      // if selected, draw selected background
      if (selectedPiece!=null&&selectedPiece.xCol==p&&selectedPiece.yRow==i) {
        fill(SELECTED_COLOR);
      }
      
      // draw individual square
      square(p*TILE_SIZE,i*TILE_SIZE,TILE_SIZE);
      
      
      // draw pieces
      if (pieces[i][p]!=null) {pieces[i][p].drawPiece();}
    }
  }
}

// flips move and makes the other team playable
void madeMove() {
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
  // update kingXY
  for (int r=0;r<8;r++) {
    for (int c=0;c<8;c++) {
      if (pieces[r][c]!=null&&pieces[r][c].isKing&&pieces[r][c].team==currentTeam) {
        currentKingXY = new PVector(c,r);
        break;
      }
    }
  }
}

// mouse clicked
void mouseClicked() {
  // if no selected piece, and the piece you're over isn't null and it is the currently playing team
  if (selectedPiece==null) {
    if ((pieces[(int)(mouseY/TILE_SIZE)][(int)(mouseX/TILE_SIZE)]!=null)
         &&(pieces[(int)(mouseY/TILE_SIZE)][(int)(mouseX/TILE_SIZE)].team==currentTeam)) {
      //// update available spots
      //pieces[(int)(mouseY/TILE_SIZE)][(int)(mouseX/TILE_SIZE)].changeAvailableSpots(pieces);
      // get rid of moves that would put king in check
      fixAvailableSpots(pieces[(int)(mouseY/TILE_SIZE)][(int)(mouseX/TILE_SIZE)]);
      // make it official selected piece
      selectedPiece = pieces[(int)(mouseY/TILE_SIZE)][(int)(mouseX/TILE_SIZE)];
    }
  }
  // if there is a selected piece
  else {
    // if place hovered over is a spot you can move to
    if (selectedPiece.canMoveTo((int)(mouseX/TILE_SIZE),(int)(mouseY/TILE_SIZE))) {
      // move it
      pieces[(int)(mouseY/TILE_SIZE)][(int)(mouseX/TILE_SIZE)] = selectedPiece;
      pieces[(int)(mouseY/TILE_SIZE)][(int)(mouseX/TILE_SIZE)].setPos((int)(mouseX/TILE_SIZE),(int)(mouseY/TILE_SIZE));
      madeMove();
    } else {
      selectedPiece = null;
    }
  }
}

// checks selected piece's potential moves to see if they cause check
void fixAvailableSpots(Piece specified) {
  specified.changeAvailableSpots(pieces);
  for (int r=0;r<8;r++) {
    for (int c=0;c<8;c++) {
      
    }
  }
}

// says if king in check if specific move made
// true if puts king in check, false if doesn't put king in check
boolean fakeMoveChecksKing(Piece specified,int newX, int newY) {
  // create fake board and copy board onto fake board
  Piece[][] fakeBoard = new Piece[8][8];
  for (int r=0;r<8;r++) {
    for (int c=0;c<8;c++) {
      fakeBoard[r][c] = pieces[r][c];
    }
  }
  // make the fake move on the fake board
  fakeBoard[specified.yRow][specified.xCol].setPos(newX,newY);
  fakeBoard[newY][newX] = fakeBoard[specified.yRow][specified.xCol];
  // 
  
  return false;
}

// is king in check on custom board
boolean isKingInCheck(Piece[][] board) {
  for (int r=0;r<8;r++) {
    for (int c=0;c<8;c++) {
      if (board[r][c]!=null&&board[r][c].team!=currentTeam) {
        board[r][c].changeAvailableSpots(pieces);
        if (board[r][c].canMoveTo((int)currentKingXY.x,(int)currentKingXY.y)) {
          return true;
        }
      }
    }
  }
  
  return false;
}
