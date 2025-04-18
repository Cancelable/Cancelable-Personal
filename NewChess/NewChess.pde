// variables
final int TILE_SIZE = 600/8;
final color BLACK_TILE = color(50);
final color WHITE_TILE = color(205);
final String TEAM_ONE = "Team One";
final String TEAM_TWO = "Team Two";
final color SELECTED_COLOR = color(255,255,0);
final color MOVEABLE_COLOR = color(0,255,0);
//final String PAWN = "PAWN";
//final String KNIGHT = "KNIGHT";
//final String QUEEN = "QUEEN";
//final String KING = "KING";
//final String CASTLE = "CASTLE";
//final String BISHOP = "BISHOP";

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
  setupPieces();
}

// setup board pieces
void setupPieces() {
  // set up pawns
  for (int r=0;r<8;r++) {
    for (int c=0;c<8;c++) {
      if (r==6) {
        pieces[r][c] = new Pawn(c,r,TEAM_ONE);
      }
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
      // if can move there, draw green background
      if (selectedPiece!=null&&selectedPiece.availableSpots[i][p]) {
        fill(MOVEABLE_COLOR);
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
      if (pieces[7-r][7-c]!=null) {fakePieces[r][c] = pieces[7-r][7-c];fakePieces[r][c].setPos(c,r);}
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
void mousePressed() {
  if (selectedPiece==null) {println("selected is null");} else {println("selected not null");}
  int clickedX = (int)(mouseX/TILE_SIZE);
  int clickedY = (int)(mouseY/TILE_SIZE);
  // if no selected piece, and the piece you're over isn't null and it is the currently playing team
  if (selectedPiece==null) {
    if ((pieces[clickedY][clickedX]!=null)
         &&(pieces[clickedY][clickedX].team==currentTeam)) {
      // make it official selected piece
      println("selected set not null");
      selectedPiece = pieces[clickedY][clickedX];
    }
  }
  // if there is a selected piece
  else {
    // update where specified piece can move to
    fixAvailableSpots(selectedPiece);
    // if place hovered over is a spot you can move to
    if (selectedPiece.canMoveTo(clickedX,clickedY)) {
      // move it
      selectedPiece.movePiece(pieces,clickedX,clickedY);
      madeMove();
      println("move made");
    } else {
      if (pieces[clickedY][clickedX]!=null&&pieces[clickedY][clickedX].team==currentTeam) {
        selectedPiece = pieces[clickedY][clickedX];
      } else {
        //println("selected piece set null");
        selectedPiece = null;
      }
    }
  }
  // fix the spots of any thing clicked on
  if (pieces[clickedY][clickedX]!=null) {
    fixAvailableSpots(pieces[clickedY][clickedX]);
  }
}

// checks selected piece's potential moves to see if they cause check
void fixAvailableSpots(Piece specified) {
  specified.changeAvailableSpots(pieces);
  for (int r=0;r<8;r++) {
    for (int c=0;c<8;c++) {
      // if it's a spot that's true in current available spots
      if (specified.availableSpots[r][c]) {
        // if it puts king in check
        if (fakeMoveChecksKing(specified,c,r)) {
          // update the spot in the available spots array
          specified.availableSpots[r][c] = false;
        }
      }
    }
  }
}

// says if king in check if specific move made
// true if puts king in check, false if doesn't put king in check
boolean fakeMoveChecksKing(Piece specified,int newX, int newY) {
  // save old specified x/y
  int oldX = specified.xCol;
  int oldY = specified.yRow;
  // create fake board and copy board onto fake board
  Piece[][] fakeBoard = new Piece[8][8];
  for (int r=0;r<8;r++) {
    for (int c=0;c<8;c++) {
      if (pieces[r][c]!=null) {
        // pawns
        if (pieces[r][c].isPawn) {fakeBoard[r][c] = new Pawn(c,r,pieces[r][c].team);}
        // kings
        // bishops
        // queens
        // towers
        // knights
      }
    }
  }
  // make the fake move on the fake board
  if (fakeBoard[specified.yRow][specified.xCol]!=null) {
    fakeBoard[specified.yRow][specified.xCol].setPos(newX,newY);
  }
  fakeBoard[newY][newX] = fakeBoard[specified.yRow][specified.xCol];
  fakeBoard[oldY][oldX] = null;
  // check if king is in check on fake board
  if (isKingInCheck(fakeBoard)) {
    
  }
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

void keyPressed() {
  // secret
  if (keyCode==RIGHT) {
    madeMove();
  }
  if (key=='r') {
    setup();
  }
}
