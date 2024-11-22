Piece[][] board;
public final String black = "black";
public final String white = "white";
String colorC;
boolean turnOver;
public int pieceLength;

void setup() {
  size(400,400);
  board = new Piece[8][8];
  colorC = setStartColor();
  pieceLength = width/board.length;
  
  // function calls
  frameRate(30);
  
  initialBoardSetup();
}

void draw() {
  //hoveringOver();
  //moveHoveringImage();
  drawBoard();
}

boolean isSpaceFree() {
  return true;
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
      //if (colorC==white) {}
      //else if (colorC==black) {}
      if ((r + c) % 2 == 0) {
        if (colorC==white) {fill(200);}
        else if (colorC==black) {fill(100);}
      }
      else {
        if (colorC==white) {fill(100);}
        else if (colorC==black) {fill(200);}
      }
      
      // magic happens
      square(c*pieceLength,r*pieceLength,pieceLength);
      if(board[r][c]!=null) {board[r][c].drawPiece();}
    }
  }
}

void keyPressed() {
  if (key=='r') {
    setup();
  }
}
