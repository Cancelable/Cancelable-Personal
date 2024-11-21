Piece[][] board;
String black = "black";
String white = "white";
String colorC;
boolean turnOver;

void setup() {
  size(400,400);
  board = new Piece[8][8];
  colorC = setStartColor();
}

void draw() {
  
}

void makeMove() {
  
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
