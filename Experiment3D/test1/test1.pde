// final variables

// variables
PVector coords;

// setup
void setup() {
  size(600,600,P3D);
  coords = new PVector(0,0,0);
}

// draw
void draw() {
  background(150);
  rotateY(map(mouseX, 0, width, -PI/2, PI/2));
  translate(width/2,height/2,0);
  // start code
  smooth();
  pushMatrix();
  //translate(232,192,0);
  noFill();
  box(150);
  popMatrix();
  //pushMatrix();
  //beginCamera();
  //rotateZ(PI/3);
  //endCamera();
  //popMatrix();
}

void cube() {
  box(100);
}
