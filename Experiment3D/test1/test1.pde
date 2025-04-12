// final variables
final int KSHIFT = 128;

// variables
PVector coords;
boolean[] keys;
float speed = 10;


// setup
void setup() {
  size(600,600,P3D);
  coords = new PVector(0,0,0);
  keys = new boolean[129]; // ascii, and then shift is index 128
  for (int i=0;i<keys.length;i++) {keys[i] = false;}
}

// draw
void draw() {
  background(150);
  smooth();
  translate(width/2,height/2,width/2);
  actualKeyPressedBruh();
  animate();
}

// draw for all of the animation aspects of the game
void animate() {
  manageCameraPosition(coords.x,coords.y,coords.z);
  drawObjects();
}

// place all of the Figures inside of an array of figures
void drawObjects() {
  pushMatrix();
  box(150);
  translate(150,0,0);
  box(100);
  popMatrix();
}

// manage the camera so that it fits the direction faced and the
void manageCameraPosition(float x, float y, float z) {
  // translates so everything in center
  translate(coords.x,coords.y,coords.z); // sets camera perspective
  rotateY(-2*map(width/2 - mouseX, 0, width, -PI/2, PI/2)); // rotate camera
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
}

void keyPressed() {
  if (key=='w') {keys['w'] = true;}
  if (key=='a') {keys['a'] = true;}
  if (key=='s') {keys['s'] = true;}
  if (key=='d') {keys['d'] = true;}
  if (key==' ') {keys[' '] = true;}
  if (keyCode==SHIFT) {keys[KSHIFT] = true;}
}
void keyReleased() {
  if (key=='w') {keys['w'] = false;}
  if (key=='a') {keys['a'] = false;}
  if (key=='s') {keys['s'] = false;}
  if (key=='d') {keys['d'] = false;}
  if (key==' ') {keys[' '] = false;}
  if (keyCode==SHIFT) {keys[KSHIFT] = false;}
}

// real keypressed
void actualKeyPressedBruh() {
  if (keys['w']) {coords.z+=speed;/*println("w");*/}
  if (keys['s']) {coords.z-=speed;}
  if (keys['a']) {coords.x+=speed;}
  if (keys['d']) {coords.x-=speed;}
  if (keys[KSHIFT]) {coords.y-=speed;}
  if (keys[' ']) {coords.y+=speed;}
}

/*
// https : // forum.processing.org/two/discussion/24912/radar-view-of-infinite-3d-space#latest
// https : // www.openprocessing.org/sketch/25255

// all spheres 
ArrayList<Obj> objs = new ArrayList();

// camera / where you are 
float xpos, ypos, zpos, 
  xlookat, ylookat, zlookat; 
float angle=0.0; // (angle left / right; 0..359)

// player is crouching yes / no 
boolean isCrouching = false; 

// "Floor" has y-value (the plane you fly in (y-direction)) 
final float floorLevel = 500.0;

// ---------------------------------------------------------------

void setup() {
  size(800, 400, P3D);

  for ( int i = 0; i < 112; i++ ) {
    objs.add( new Obj() );
  }
}//func 

void draw() {

  background(0);

  // draw Main Scene in 3D
  drawMainSceneIn3D(); 

  // read key throughout 
  keyPressedIsCheckedContinuusly();

  // HUD https : // en.wikipedia.org/wiki/Head-up_display ------------- 
  camera();
  noLights();
  hint(DISABLE_DEPTH_TEST);  
  fill(255);
  text("wasd to move, mouse to look left/right (or combine mouse and keyboard)", 18, 18);
}//func 

//---------------------------------------------------------------

void drawMainSceneIn3D() {
  // draw Main Scene in 3D (main screen)

  hint(ENABLE_DEPTH_TEST); 
  pushMatrix();
  CheckCameraMouse();
  lights();
  noFill();
  stroke(255);
  for ( Obj obj : objs ) { 
    obj.simulate(); 
    obj.draw3D();
  }
  popMatrix();
}//func

// --------------------------------------------------------------------------
// Inputs 

void keyPressedIsCheckedContinuusly() {

  float Radius = 13; 

  if (keyPressed) {

    // ----------------------------    
    // forward & backward
    if (key == 'w' || key == 'W') {
      // forward : should be running towards lookat 
      xpos =   Radius*sin(radians(angle)) + xpos;
      zpos =   Radius*cos(radians(angle)) + zpos;
    }
    if (key == 's' || key == 'S') {
      // backward
      xpos =  xpos- (Radius*sin(radians(angle))) ;
      zpos =  zpos- (Radius*cos(radians(angle))) ;
    }
    // ----------------------------    
    // left & right 
    if (key == 'a' || key == 'A') {
      // left
      xpos =   xpos- Radius*sin(radians(angle-90)) ;
      zpos =   zpos- Radius*cos(radians(angle-90)) ;
    }
    if (key == 'D' || key == 'd') {
      // right 
      xpos =   Radius*sin(radians(angle-90)) + xpos;
      zpos =   Radius*cos(radians(angle-90)) + zpos;
    } 
    // ----------------------------    
    // fly up & down 
    if (key == 'r' || key == 'R') {
      ypos-=4;  // fly up
    }
    if (key == 'f' || key == 'F') {
      ypos+=4;  // down 
      if (ypos > floorLevel-120) {  // check Floor
        ypos = floorLevel-120;
      }
    }     
    // ----------------------------    
    // fly up & down FAST 
    if (key == 'b' || key == 'B') {
      // Bird
      ypos-=400;
    }    
    if (key == 'n' || key == 'N') {
      // un-Bird: go deeper 
      ypos+=400; 
      if (ypos > floorLevel-120) { // check Floor
        ypos = floorLevel-120;
      }
    }        
    // ----------------------------        
    // crouch 
    if (key == 'c' || key == 'C') {
      // toggle 
      isCrouching=!isCrouching;
      if ( isCrouching ) {
        // crouch
        ypos = floorLevel - 40; //  height/2.0;
      } else
      {
        // stand 
        ypos = floorLevel - 120; //  height/2.0;
      }
    } // 'c'
    if (key == 'i' || key == 'I') {
      // Saves a TIFF file named "diagonal.tif"
      save("Runner1.tif");
    }
    // checkBoundaries ();
  } // keyPressed
}

// --------------------------------------------------------------------------------
// Tools 

void CheckCameraMouse () {
  // Mouse  

  float Radius = 450.0;  // radius 

  float rmx=mouseX - width/2; 
  float rmy=(mouseY - height/2)*5;

  // command map: See Help. 
  angle = map(rmx, width, 0, 0, 359); // left right 

  // look at 
  xlookat = Radius*sin(radians(angle)) + xpos;
  ylookat = map(rmy, -300, floorLevel-120, -270, height); // look up / down 
  zlookat = Radius*cos(radians(angle)) + zpos; 

  camera (xpos, ypos, zpos, 
    xlookat, ylookat, zlookat, 
    0.0, 1.0, 0.0
    );
}

//=============================================================

class Obj {

  // class for a 3D sphere

  PVector p; //position 
  color c;   //color

  // pulsating effect (OFF)
  float size, 
    primSize, 
    add=0;       // 0 = no pulsating (OFF)

  // constr 
  Obj() {

    //position 
    p = new PVector( random(-1180, 1180), random(-1180, 1180), random(-1180, 1180) );
    // p = new PVector( random(-1180, 1180), 208, random(-1180, 1180) );

    //color
    c = color( random(255), random(255), random(255) );

    size     = random(14, 21);
    primSize = size;
  }// constr 

  void simulate() {
    // move it or whatever?
    size+=add;
    if (size>primSize)
      add=-1; 
    else if (size<12)
      add=1;
  }

  void draw3D() {  
    // draw main scene in 3D
    pushMatrix();
    translate(p.x, p.y, p.z);
    noStroke();
    fill(c);
    sphere(size);
    popMatrix();
  }

  void draw2D(PGraphics pg) {

    // draw element on "pg" for map in 2D

    pg.noStroke();
    pg.fill(c);

    float f = 1.0; // 1.0 = no effect 
    pg.ellipse(p.x*f, p.z*f, max(12, size*f), max(12, size*f));
  }//method 
  //
}//class 
*/
