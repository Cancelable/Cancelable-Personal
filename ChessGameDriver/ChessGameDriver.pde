Piece[][] board;
public boolean [][] canMove;
public final String black = "black";
public final String white = "white";
String colorC;
boolean turnOver;
public int pieceLength;
PVector pieceOver;
Piece pieceSelected;

void setup() {
  size(400,400);
  board = new Piece[8][8];
  canMove = new boolean[8][8];
  colorC = setStartColor();
  pieceLength = width/board.length;
  pieceOver = new PVector(0,0);
  pieceSelected = null;
  
  // function calls
  frameRate(30);
  
  initialBoardSetup();
}

void draw() {
  drawBoard();
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
  if (turnOver) {
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
      
      // bishops
      // bishops
      
      // horses
      // horses
      
      // kings
      // kings
      
      // queens
      // queens
      
      // castles
      // castles
      
    }//inside
  }
}

void drawBoard() {
  for (int r=0;r<board.length;r++) {
    for (int c=0;c<board[r].length;c++) {
      if ((r + c) % 2 == 0) {
        if (colorC==white) {fill(200);}
        else if (colorC==black) {fill(100);}
      }
      else {
        if (colorC==white) {fill(100);}
        else if (colorC==black) {fill(200);}
      }
      if (canMove[r][c]) {
        fill(255,255,0);
      }
      if ((pieceSelected!=null) && (board[r][c]!=null) &&
      (board[r][c].getRowY()==pieceSelected.getRowY()) &&
      (board[r][c].getColX()==pieceSelected.getColX())
      ) {
        fill(255,192,203);
      }
      if (r==pieceOver.y && c==pieceOver.x) {
        fill(0,255,0);
      }
      // drawSquares
      square(c*pieceLength,r*pieceLength,pieceLength);
      if(board[r][c]!=null) {
        // draw circle
        board[r][c].drawPiece();
      }
    }
  }
}

void makeMove() {
  //if (canMove[(int)pieceOver.y][(int)pieceOver.x]) {
  if ((pieceSelected!=null) && true) {
    Piece temporaryPiece = pieceSelected;
    board[(int)pieceOver.y][(int)pieceOver.x] = temporaryPiece;
    board[temporaryPiece.getRowY()][temporaryPiece.getColX()] = null;
    
    board[(int)pieceOver.y][(int)pieceOver.x].setPieceCoords((int)pieceOver.x,(int)pieceOver.y);
    
  }
}

void keyPressed() {
  if (key=='r') {
    setup();
  }
  
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
  }
  
  if (key==' ') {
    makeMove();
  }
  
}
