// variables
final int TILE_SIZE = 600/8;
final color BLACK_TILE = color(100);
final color WHITE_TILE = color(205);
final String TEAM_ONE = "Team One";
final String TEAM_TWO = "Team Two";
final color SELECTED_COLOR = color(255,255,0);
final color MOVEABLE_COLOR = color(0,255,0);

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
  setupPieces();
  updateCurrentKingCoords();
}

// setup board pieces
void setupPieces() {
  // set up pawns
  for (int r=0;r<8;r++) {
    for (int c=0;c<8;c++) {
      
      
      // pawns
      if (r==6) {
        pieces[r][c] = new Pawn(c,r,TEAM_ONE);
      }
      if (r==1) {
        pieces[r][c] = new Pawn(c,r,TEAM_TWO);
      }
      // knights/horses
      if (c==1||c==6) {
        if (r==0) {
          pieces[r][c] = new Knight(c,r,TEAM_TWO);
        } else if (r==7) {
          pieces[r][c] = new Knight(c,r,TEAM_ONE);
        }
      }
      // kings
      if (c==4) {
        if (r==0) {
          pieces[r][c] = new King(c,r,TEAM_TWO);
        } else if (r==7) {
          pieces[r][c] = new King(c,r,TEAM_ONE);
        }
      }
      // queens
      if (c==3) {
        if (r==0) {
          pieces[r][c] = new Queen(c,r,TEAM_TWO);
        } else if (r==7) {
          pieces[r][c] = new Queen(c,r,TEAM_ONE);
        }
      }
      // bishops
      if (c==2||c==5) {
        if (r==0) {
          pieces[r][c] = new Bishop(c,r,TEAM_TWO);
        } else if (r==7) {
          pieces[r][c] = new Bishop(c,r,TEAM_ONE);
        }
      }
      // rooks/castles
      if (c==0||c==7) {
        if (r==0) {
          pieces[r][c] = new Castle(c,r,TEAM_TWO);
        } else if (r==7) {
          pieces[r][c] = new Castle(c,r,TEAM_ONE);
        }
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
  // update king coords
  updateCurrentKingCoords();
}

void updateCurrentKingCoords() {
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
  //if (selectedPiece==null) {println("selected is null");} else {println("selected not null");}
  int clickedX = (int)(mouseX/TILE_SIZE);
  int clickedY = (int)(mouseY/TILE_SIZE);
  
  // fix the spots of any thing clicked on
  if (pieces[clickedY][clickedX]!=null) {
    fixAvailableSpots(pieces[clickedY][clickedX]);
  }
  
  // if no selected piece, and the piece you're over isn't null and it is the currently playing team
  if (selectedPiece==null) {
    if ((pieces[clickedY][clickedX]!=null)
         &&(pieces[clickedY][clickedX].team==currentTeam)) {
      // make it official selected piece
      //println("selected set not null");
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
      //println("move made");
    } else {
      if (pieces[clickedY][clickedX]!=null&&pieces[clickedY][clickedX].team==currentTeam) {
        selectedPiece = pieces[clickedY][clickedX];
      } else {
        //println("selected piece set null");
        selectedPiece = null;
      }
    }
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
  int oldX = specified.xCol;
  int oldY = specified.yRow;
  
  Piece[][] fakeBoard = new Piece[8][8];
  PVector kingPos = null; // well use this to find the king
  
  for (int r=0; r<8; r++) {
    for (int c=0; c<8; c++) {
      if (pieces[r][c] != null) {
        Piece original = pieces[r][c];
        Piece copy = null;
        
        // pawns
        if (original.isPawn) {copy = new Pawn(c,r,original.team);}
        // kings
        if (original.isKing) {copy = new King(c,r,original.team);}
        // knights/horses
        if (original.isKnight) {copy = new Knight(c,r,original.team);}
        // bishop
        if (original.isBishop) {copy = new Bishop(c,r,original.team);}
        // rook
        if (original.isCastle) {copy = new Castle(c,r,original.team);}
        // queen
        if (original.isQueen) {copy = new Queen(c,r,original.team);}
        
        if (copy != null) {
          fakeBoard[r][c] = copy;
          if (copy.isKing && copy.team == currentTeam) {
            kingPos = new PVector(c, r); // track the king's position
          }
        }
      }
    }
  }
  

  // perform the fake move
  if (fakeBoard[oldY][oldX] != null) {
    fakeBoard[oldY][oldX].setPos(newX, newY);
    fakeBoard[newY][newX] = fakeBoard[oldY][oldX];
    fakeBoard[oldY][oldX] = null;

    // if we moved the king, update position
    if (fakeBoard[newY][newX].isKing && fakeBoard[newY][newX].team == currentTeam) {
      kingPos = new PVector(newX, newY);
    }
  }
  
  // flip fakeBoard
  Piece[][] evenFakerBoard = new Piece[8][8];
  for (int r=0;r<8;r++) {
    for (int c=0;c<8;c++) {
      evenFakerBoard[r][c] = fakeBoard[7-r][7-c];
      if (evenFakerBoard[r][c]!=null) {
        evenFakerBoard[r][c].setPos(c,r);
      }
    }
  }
  fakeBoard = evenFakerBoard;
  
  // flip king pos with it
  kingPos = new PVector(7 - kingPos.x, 7 - kingPos.y);

  // now check if that king is in check
  return isKingInCheck(fakeBoard, kingPos);
}

// is king in check on custom board
boolean isKingInCheck(Piece[][] board, PVector kingPos) {
  for (int r=0; r<8; r++) {
    for (int c=0; c<8; c++) {
      if (board[r][c] != null && board[r][c].team != currentTeam) {
        board[r][c].changeAvailableSpots(board);
        if (board[r][c].canMoveTo((int)kingPos.x, (int)kingPos.y)) {
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
