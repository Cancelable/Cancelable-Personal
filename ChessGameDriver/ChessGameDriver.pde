public Piece[][] board;
public boolean [][] canMove;
public final String black = "black";
public final String white = "white";
public String colorC;
boolean turnOver;
public int pieceLength;
PVector pieceOver;
Piece pieceSelected;
PVector spotToBeChanged;
String spotToBeChangedColor; 
boolean isPaused;
boolean gameOver;
String teamLost;

void setup() {
  size(400,400);
  board = new Piece[8][8];
  canMove = new boolean[8][8];
  colorC = setStartColor();
  pieceLength = width/board.length;
  pieceOver = new PVector(0,0);
  pieceSelected = null;
  isPaused = false;
  spotToBeChanged = null;
  gameOver = false;
  
  // function calls
  frameRate(30);
  
  initialBoardSetup();
}

void draw() {
  if (!isPaused && !gameOver) {
    checkIfGameOver();
    spotToBeChanged = null;
    turnPawnInto();
    drawBoard();
  } else {
    pickReplacementPiece();
  }
  if (gameOver) {
    gameOverScreen();
  }
}

// this makes game end if you kill king
void checkIfGameOver() {
  int whiteKingCount = 0;
  int blackKingCount = 0;
  for (int r=0;r<board.length;r++) {
    for (int c=0;c<board[r].length;c++) {
      if (board[r][c]!=null && board[r][c].getLetter()=="K") {
        if (board[r][c].getTeam()==white) {
          whiteKingCount++;
        }
        if (board[r][c].getTeam()==black) {
          blackKingCount++;
        }
      }
    }
  }
  if (whiteKingCount!=1) {
    teamLost = white;
    gameOver = true;
  }
  if (blackKingCount!=1) {
    teamLost = black;
    gameOver = true;
  }
}

void gameOverScreen() {
  background(255);
  textAlign(CENTER,TOP);
  textSize(width/15);
  fill(255,192,203);
  text(teamLost + " lost.. Click r to restart",width/2,height/2);
}

boolean spaceSelectable() {
  int xl = (int)pieceOver.x;
  int yl = (int)pieceOver.y;
  if ((board[yl][xl] != null) &&
  colorC == board[yl][xl].getTeam()){
    return true;
  } else {
    return false;
  }
}

void updateCanMove() {
  canMove = pieceSelected.getCanMove();
}

String setStartColor() {
  boolean setWhite = (random(1) > .5);
  if (setWhite) {
    return white;
  } else {
    return black;
  }
}

void changeColor() {
  //if (turnOver) {
  if (true) {
    if (colorC == black) {
      colorC = white;
    } else if (colorC == white) {
      colorC = black;
    }
  }
  turnOver = false;
}

void initialBoardSetup() {
  for (int r=0;r<board.length;r++) {
    for (int c=0;c<board[r].length;c++) {
      // pawns
      if (true) {
        // 6 is lower
        if (colorC==white&&r==6) {
          board[r][c] = new Pawn(c,r,white);
        } else if (colorC==white&&r==1) {
          board[r][c] = new Pawn(c,r,black);
        }
        else if (colorC==black&&r==6) {
          board[r][c] = new Pawn(c,r,black);
        }
        else if (colorC==black&&r==1) {
          board[r][c] = new Pawn(c,r,white);
        }
      }// pawns
    }//inside
  }
  
  // bishops
  if (true) {
    if (colorC==white) {
      board[0][2] = new Bishop(2,0,black);
      board[0][5] = new Bishop(5,0,black);
      board[7][2] = new Bishop(2,7,white);
      board[7][5] = new Bishop(5,7,white);
    }
    else if (colorC==black) {
      board[0][2] = new Bishop(2,0,white);
      board[0][5] = new Bishop(5,0,white);
      board[7][2] = new Bishop(2,7,black);
      board[7][5] = new Bishop(5,7,black);
    }
  }//bishops
  
  // castles
  if (true) {
    if (colorC==white) {
      board[0][0] = new Castle(0,0,black);
      board[0][7] = new Castle(7,0,black);
      board[7][0] = new Castle(0,7,white);
      board[7][7] = new Castle(7,7,white);
    }
    else if (colorC==black) {
      board[0][0] = new Castle(0,0,white);
      board[0][7] = new Castle(7,0,white);
      board[7][0] = new Castle(0,7,black);
      board[7][7] = new Castle(7,7,black);
    }
  }// castles
  
  // kings
  if (true) {
    if (colorC==white) {
      board[7][4] = new King(4,7,white);
      board[0][4] = new King(4,0,black);
    }
    else if (colorC==black) {
      board[7][4] = new King(4,7,black);
      board[0][4] = new King(4,0,white);
    }
  }// king
  
  // queens
  if (true) {
    if (colorC==white) {
      board[7][3] = new Queen(3,7,white);
      board[0][3] = new Queen(3,0,black);
    }
    else if (colorC==black) {
      board[7][3] = new Queen(3,7,black);
      board[0][3] = new Queen(3,0,white);
    }
  }// queens
  
  // horses
  if (true) {
    if (colorC==white) {
      board[0][1] = new Horse(1,0,black);
      board[0][6] = new Horse(6,0,black);
      board[7][1] = new Horse(1,7,white);
      board[7][6] = new Horse(6,7,white);
    }
    else if (colorC==black) {
      board[0][1] = new Horse(1,0,white);
      board[0][6] = new Horse(6,0,white);
      board[7][1] = new Horse(1,7,black);
      board[7][6] = new Horse(6,7,black);
    }
  }// horses
  
}

void drawBoard() {
  for (int r=0;r<board.length;r++) {
    for (int c=0;c<board[r].length;c++) {
      // board square colors
      if ((r + c) % 2 == 0) {
        fill(200);
      }
      else {
        fill(100);
      }
      // spots you can move to-yellow
      if (canMove[r][c]) {
        fill(255,255,0);
      }
      // selected piece-pink
      if ((pieceSelected!=null) && (board[r][c]!=null) &&
      (board[r][c].getRowY()==pieceSelected.getRowY()) &&
      (board[r][c].getColX()==pieceSelected.getColX())
      ) {
        fill(255,192,203);
      }
      // cursor-green
      if (r==pieceOver.y && c==pieceOver.x) {
        fill(0,255,0);
      }
      // drawSquares
      square(c*pieceLength,r*pieceLength,pieceLength);
      // draw circles
      if(board[r][c]!=null) {
        board[r][c].drawPiece();
      }
    }
  }
}

void makeMove() {
  if (canMove[(int)pieceOver.y][(int)pieceOver.x] == true &&
  pieceSelected!=null && pieceSelected != board[(int)pieceOver.y][(int)pieceOver.x]) {
    
    board[(int)pieceOver.y][(int)pieceOver.x] = pieceSelected;
    board[pieceSelected.getRowY()][pieceSelected.getColX()] = null;
    
    board[(int)pieceOver.y][(int)pieceOver.x].setPieceCoords((int)pieceOver.x,(int)pieceOver.y);
    
    canMove = new boolean[8][8];
    // switch sides of board for pieces
    Piece[][] newTempBoard = new Piece[8][8];
    for (int r=0;r<board.length;r++) {
      for (int c=0;c<board[r].length;c++) {
        if (board[7-r][7-c]!=null) {
          // pawn
          if (board[7-r][7-c].getLetter()=="P") {
            newTempBoard[r][c] = new Pawn(c,r,board[7-r][7-c].getTeam());
            
          // castle
          } else if (board[7-r][7-c].getLetter()=="C") {
            newTempBoard[r][c]= new Castle(c,r,board[7-r][7-c].getTeam());
            
          // horse
          } else if (board[7-r][7-c].getLetter()=="H") {
            newTempBoard[r][c] = new Horse(c,r,board[7-r][7-c].getTeam());
            
          // bishop
          } else if (board[7-r][7-c].getLetter()=="B") {
            newTempBoard[r][c] = new Bishop(c,r,board[7-r][7-c].getTeam());
            
          // king
          } else if (board[7-r][7-c].getLetter()=="K") {
            newTempBoard[r][c] = new King(c,r,board[7-r][7-c].getTeam());
            
          // queen
          } else if (board[7-r][7-c].getLetter()=="Q") {
            newTempBoard[r][c] = new Queen(c,r,board[7-r][7-c].getTeam());
          }
        } 
      }
    }
    board = newTempBoard;
    changeColor();
  }
}

void turnPawnInto() {
  for (int r=0;r<board.length;r++) {
    for (int c=0;c<board[r].length;c++) {
      if (board[r][c]!=null && board[r][c].getLetter() == "P") {
        if (board[r][c].getTeam() == colorC && r==0) {
          spotToBeChanged = new PVector(board[r][c].getColX(),board[r][c].getRowY());
          spotToBeChangedColor = board[r][c].getTeam();
          isPaused = true;
        } else if (board[r][c].getTeam() != colorC && r==7) {
          spotToBeChanged = new PVector(board[r][c].getColX(),board[r][c].getRowY());
          spotToBeChangedColor = board[r][c].getTeam();
          isPaused = true;
        }
      }
    }
  }
}

void pickReplacementPiece() {
  background(255);
  textSize(width/15);
  fill(0);
  text("Please pick a piece type",width/2,height/8);
  int distanceFromTop = height/5;
  int heightOfEach = (height - distanceFromTop)/2;
  int lowerStart = distanceFromTop + heightOfEach;
  textSize(width/10);
  fill(255,0,0);
  rect(0,distanceFromTop,width/2,heightOfEach);
  fill(0);
  text("Horse", width/4, distanceFromTop + (heightOfEach/2));
  fill(0,255,0);
  rect(width/2,distanceFromTop,width/2,heightOfEach);
  fill(0);
  text("Castle", (3*width)/4, distanceFromTop + (heightOfEach/2));
  fill(0,0,255);
  rect(0,lowerStart,width/2,heightOfEach);
  fill(0);
  text("Bishop", (width/4), lowerStart + (heightOfEach/2));
  fill(128,0,128);
  rect(width/2, lowerStart,width/2, heightOfEach);
  fill(0,128,0);
  text("Queen", (3*width)/4, lowerStart + (heightOfEach/2));
  
}

void keyPressed() {
  if (key=='r') {
    setup();
  }
  if (!isPaused && !gameOver) {
    
  // move the green
  if (keyCode==DOWN && (pieceOver.y)+1 < 8) {
    pieceOver.set(pieceOver.x,(pieceOver.y)+1);
  }
  if (keyCode==UP && (pieceOver.y)-1 >= 0) {
    pieceOver.set(pieceOver.x,(pieceOver.y)-1);
  }
  if (keyCode==RIGHT && (pieceOver.x)+1 < 8) {
    pieceOver.set((pieceOver.x)+1,pieceOver.y);
  }
  if (keyCode==LEFT && (pieceOver.x)-1 >= 0) {
    pieceOver.set((pieceOver.x)-1,pieceOver.y);
  }
  
  if (key=='s' && spaceSelectable()) {
    pieceSelected = board[(int)pieceOver.y][(int)pieceOver.x];
    updateCanMove();  
  }
  
  if (key==' ') {
    makeMove();
  }
    
  }// end of unpaused code
}

void mousePressed() {
  if (isPaused) {
    int distanceFromTop = height/5;
    int heightOfEach = (height - distanceFromTop)/2;
    int lowerStart = distanceFromTop + heightOfEach;
    if (mouseX < width/2 && mouseY < lowerStart && mouseY > distanceFromTop) {
      board[(int)spotToBeChanged.y][(int)spotToBeChanged.x] = new Horse(
      (int)spotToBeChanged.x,(int)spotToBeChanged.y,spotToBeChangedColor);
    }
    else if (mouseX < width/2 && mouseY > lowerStart) {
      board[(int)spotToBeChanged.y][(int)spotToBeChanged.x] = new Bishop(
      (int)spotToBeChanged.x,(int)spotToBeChanged.y,spotToBeChangedColor);
    }
    else if (mouseX > width/2 && mouseY < lowerStart && mouseY > distanceFromTop) {
      board[(int)spotToBeChanged.y][(int)spotToBeChanged.x] = new Castle(
      (int)spotToBeChanged.x,(int)spotToBeChanged.y,spotToBeChangedColor);
    }
    else if (mouseY > width/2 && mouseY > lowerStart) {
      board[(int)spotToBeChanged.y][(int)spotToBeChanged.x] = new Queen(
      (int)spotToBeChanged.x,(int)spotToBeChanged.y,spotToBeChangedColor);
    }
    
  }
  isPaused = false;
}
