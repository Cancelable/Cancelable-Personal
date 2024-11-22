Piece[][] board;
public final String black = "black";
public final String white = "white";
String colorC;
boolean turnOver;
int pieceLength;
Piece hoveringOver;

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
  drawBoard();
}

void dragPiece() {
  for (int r=0;r<board.length;r++) {
    for (int c=0;c<board[r].length;c++) {
      if ((mouseX > board[r][c].getColX())
           && (mouseX < board[r][c].getColX() + pieceLength)
           && (mouseY > board[r][c].getRowY())
           && (mouseY < board[r][c].getRowY() + pieceLength)) {
             board[r][c].setSelected();
      }
    }
  }
}

void hoveringOver() {
  
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
          board[r][c] = new Pawn(c*pieceLength,r*pieceLength,white);
        } else if (colorC==white&&r==1) {
          board[r][c] = new Pawn(c*pieceLength,r*pieceLength,black);
        }
        else if (colorC==black&&r==6) {
          board[r][c] = new Pawn(c*pieceLength,r*pieceLength,black);
        }
        else if (colorC==black&&r==1) {
          board[r][c] = new Pawn(c*pieceLength,r*pieceLength,white);
        }
      }//pawns
      
      // bishops
      
      // horses
      
      // kings
      
      // queens
      
      // castles
      
    }//inside
  }
}

void drawBoard() {
  int pieceLength = height/board.length;
  int pieceWidth = width/board[0].length;
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
      rect(c*pieceWidth,r*pieceLength,pieceWidth,pieceLength);
      if(board[r][c]!=null) {drawPiece(board[r][c]);}
    }
  }
}

void drawPiece(Piece piece) {
  int lolx = piece.getColX() + pieceLength/2;
  int loly = piece.getRowY() + pieceLength/2;
  String firstLetter = piece.getLetter();
  if (piece.getTeam()==white) {
    fill(255);
  } else if (piece.getTeam()==black) {
    fill(0);
  }
  circle(lolx,loly,pieceLength);
  textSize(width/10);
  textAlign(CENTER,CENTER);
  fill(255,0,0);
  text(firstLetter,lolx,loly);
}
