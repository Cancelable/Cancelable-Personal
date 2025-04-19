// variables
final int TILE_SIZE = 600/8;
final color BLACK_TILE = color(100);
final color WHITE_TILE = color(205);
final String TEAM_ONE = "Team One";
final String TEAM_TWO = "Team Two";
final color SELECTED_COLOR = color(255,255,0);
final color MOVEABLE_COLOR = color(0,255,0);
final String GAME_TIED = "TIE";
final String CHECKMATE_ONE = "WHITE WINS! CHECKMATE";
final String CHECKMATE_TWO = "BLACK WINS! CHECKMATE";

// non final variables
Piece[][] pieces;
Piece selectedPiece;
String currentTeam;
boolean teamOneCanLeftCastle;
boolean teamOneCanRightCastle;
boolean teamTwoCanLeftCastle;
boolean teamTwoCanRightCastle;
PVector currentKingXY;
String currentGameState;
boolean paused;


// setup
void setup() {
  size(600,600);
  pieces = new Piece[8][8];
  selectedPiece = null;
  currentTeam = TEAM_ONE;
  teamOneCanLeftCastle = true;
  teamOneCanRightCastle = true;
  teamTwoCanLeftCastle = true;
  paused = false;
  teamTwoCanRightCastle = true;
  currentGameState = null;
  setupPieces();
  updateCurrentKingCoords();
  textSize(35);
  textAlign(CENTER);
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
  if (currentGameState==CHECKMATE_ONE) {
    background(255);
    fill(255,0,0);
    text(CHECKMATE_ONE,width/2,height/2);
  }
  else if (currentGameState==CHECKMATE_TWO) {
    background(0);
    fill(255,0,0);
    text(CHECKMATE_TWO,width/2,height/2);
  }
  else if (currentGameState==GAME_TIED) {
    background(#F0B3D3); // pink
    fill(255,0,0);
    text(GAME_TIED,width/2,height/2);
  }
  // nobody's won yet
  if (currentGameState==null) {
    if (!paused) {
      background(100);
      drawBoard();
    } else if (paused) {
      pausedDraw();
    }
  } else {
    fill(255,0,0);
    text("Press 'r' to restart",width/2,3*height/4);
  }
}

void pausedDraw() {
  fill(255);
  rect(30+15,15+10,20,60);
  rect(70+15,15+10,20,60);
  text("Paused",width/2,height/2 - height/10);
  text("Click SPACE to resume",width/2,height/2 + height/10);
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
      if (selectedPiece!=null) {
        int sX = selectedPiece.xCol;
        int sY = selectedPiece.yRow;
        if (pieces[i][p]!=null&&pieces[i][p]!=selectedPiece) {
          pieces[i][p].drawPiece();
        }
        image(selectedPiece.pieceImage,mouseX - (width/20),mouseY - (height/20));
      } else {
        if (pieces[i][p]!=null) {pieces[i][p].drawPiece();}
      }
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
  // update king coords
  updateCurrentKingCoords();
  // check if game is tied/checkmate
  updateGameResult();
  // make selected piece null
  selectedPiece = null;
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
  if (!paused) {
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
        
        updateCurrentKingCoords();
        int kingX = (int)currentKingXY.x;
        int kingY = (int)currentKingXY.y;
        
        if (selectedPiece==pieces[kingY][kingX]) {
          
          // team one
          if (currentTeam==TEAM_ONE) {
            if (teamOneCanLeftCastle) {
              if (clickedX==2&&clickedY==7) {
                pieces[7][0].movePiece(pieces,3,7);
              }
            }
            if (teamOneCanRightCastle) {
              if (clickedX==6&&clickedY==7) {
                pieces[7][7].movePiece(pieces,5,7);
              }
            }
          }
          
          // team two
          if (currentTeam==TEAM_TWO) {
            if (teamTwoCanLeftCastle) {
              if (clickedX==1&&clickedY==7) {
                // move rook
                pieces[7][0].movePiece(pieces,2,7);
              }
            }
            if (teamTwoCanRightCastle) {
              if (clickedX==5&&clickedY==7) {
                // move rook
                pieces[7][7].movePiece(pieces,4,7);
              }
            }
          }
        }
        // move it
        selectedPiece.movePiece(pieces,clickedX,clickedY);
        madeMove();
        //println("regular move made");
        
        
      // if piece hovered over isn't moveable to
      } else {
        // if is your own team you click on
        if (pieces[clickedY][clickedX]!=null&&pieces[clickedY][clickedX].team==currentTeam) {
          // if click on the specified piece, unselect
          if (clickedY==selectedPiece.yRow&&clickedX==selectedPiece.xCol) {
            selectedPiece = null;
          } else {
            selectedPiece = pieces[clickedY][clickedX]; // make selected piece that one
          }
        // if is just in a bum space
        } else {
          //println("selected piece set null");
          selectedPiece = null; // set selected piece null
        }
      }
    }
  }
}

void mouseReleased() {
  int clickedX = (int)(mouseX/TILE_SIZE);
  int clickedY = (int)(mouseY/TILE_SIZE);
  
  // if there is a selected piece
    if (selectedPiece!=null) {
      // update where specified piece can move to
      fixAvailableSpots(selectedPiece);
      // if place hovered over is a spot you can move to
      if (selectedPiece.canMoveTo(clickedX,clickedY)) {
        
        updateCurrentKingCoords();
        int kingX = (int)currentKingXY.x;
        int kingY = (int)currentKingXY.y;
        
        if (selectedPiece==pieces[kingY][kingX]) {
          
          // team one
          if (currentTeam==TEAM_ONE) {
            if (teamOneCanLeftCastle) {
              if (clickedX==2&&clickedY==7) {
                pieces[7][0].movePiece(pieces,3,7);
              }
            }
            if (teamOneCanRightCastle) {
              if (clickedX==6&&clickedY==7) {
                pieces[7][7].movePiece(pieces,5,7);
              }
            }
          }
          
          // team two
          if (currentTeam==TEAM_TWO) {
            if (teamTwoCanLeftCastle) {
              if (clickedX==1&&clickedY==7) {
                // move rook
                pieces[7][0].movePiece(pieces,2,7);
              }
            }
            if (teamTwoCanRightCastle) {
              if (clickedX==5&&clickedY==7) {
                // move rook
                pieces[7][7].movePiece(pieces,4,7);
              }
            }
          }
        }
        // move it
        selectedPiece.movePiece(pieces,clickedX,clickedY);
        madeMove();
        //println("regular move made");
        
        
      // if piece hovered over isn't moveable to
      } else {
        // if is your own team you click on
        if (pieces[clickedY][clickedX]!=null&&pieces[clickedY][clickedX].team==currentTeam) {
          // if click on the specified piece, unselect
          if (clickedY==selectedPiece.yRow&&clickedX==selectedPiece.xCol) {
            selectedPiece = null;
          } else {
            selectedPiece = pieces[clickedY][clickedX]; // make selected piece that one
          }
        // if is just in a bum space
        } else {
          //println("selected piece set null");
          selectedPiece = null; // set selected piece null
        }
      }
    }
}

// checks selected piece's potential moves to see if they cause check
void fixAvailableSpots(Piece specified) {
  specified.changeAvailableSpots(pieces);
  
  // castling
  updateCurrentKingCoords();
  if (currentTeam==TEAM_ONE&&!isKingInCheck(pieces,currentKingXY)) {
    if (teamOneCanLeftCastle&&pieces[7][1]==null&&pieces[7][2]==null&&pieces[7][3]==null) {
      // left castle team one
      pieces[(int)currentKingXY.y][(int)currentKingXY.x].availableSpots[7][2] = true;
    }
    if (teamOneCanRightCastle&&pieces[7][6]==null&&pieces[7][5]==null) {
      // right castle team one
      pieces[(int)currentKingXY.y][(int)currentKingXY.x].availableSpots[7][6] = true;
    }
  }
  if (currentTeam==TEAM_TWO&&!isKingInCheck(pieces,currentKingXY)) {
    if (teamTwoCanLeftCastle&&pieces[7][1]==null&&pieces[7][2]==null) {
      // left castle team two
      pieces[(int)currentKingXY.y][(int)currentKingXY.x].availableSpots[7][1] = true;
    }
    if (teamTwoCanRightCastle&&pieces[7][6]==null&&pieces[7][5]==null&&pieces[7][4]==null) {
      // right castle team two
      pieces[(int)currentKingXY.y][(int)currentKingXY.x].availableSpots[7][5] = true;
    }
  }
  
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
  if (key==' ') {
    paused = !paused;
  }
}

// check / update if game is over yet or not
void updateGameResult() {
  boolean checked = false;
  boolean cantMove = false;
  updateCurrentKingCoords();
  if (isKingInCheck(pieces,currentKingXY)) {println("king in check");checked = true;}
  int countPossibleMoves = 0;
  firstLoop:
  for (int r=0;r<8&&countPossibleMoves==0;r++) {
    for (int c=0;c<8;c++) {
      if (pieces[r][c]!=null&&pieces[r][c].getTeam()==currentTeam) {
        fixAvailableSpots(pieces[r][c]);
        for (int r2=0;r2<8;r2++) {
          for (int c2=0;c2<8;c2++) {
            if (pieces[r][c].availableSpots[r2][c2]) {
              countPossibleMoves++;
              break firstLoop;
            }
          }
        }
      }
    }
  }
  //println("possible moves" + countPossibleMoves);
  if (countPossibleMoves==0) {
    cantMove = true;
  }
  
  if (checked&&cantMove) {
    println("checkmate");
    if (currentTeam==TEAM_ONE) {
      currentGameState = CHECKMATE_TWO; // black/team 1 won
    } else if (currentTeam==TEAM_TWO) {
      currentGameState = CHECKMATE_ONE; // white/team 2 won
    }
  }
  if (cantMove&&!checked) {
    currentGameState = GAME_TIED;
  }
}
