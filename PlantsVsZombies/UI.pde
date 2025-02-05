public class UI {
  
  private int pageNum; // page number that you're on looking through almacen
  
  public UI() {
    pageNum = 0; // 0 is page 1
  }
  
  private void drawUIBackground() {
    // draw background dawg
    fill(UI_BACKGROUND_COLOR);
    beginShape();
    vertex(0,REAL_HEIGHT);
    vertex(0,height);
    vertex(width,height);
    vertex(width,0);
    vertex(REAL_WIDTH,0);
    vertex(REAL_WIDTH,REAL_HEIGHT);
    endShape();
  }
  
  private void drawValueDisplay() {
    // draw box
    rect(REAL_WIDTH+30,30,125,100);
    // draw sun icon
    fill(OUTSIDE_SUN);
    rectMode(CENTER);
    square(REAL_WIDTH+60,60,(2*TILE_WIDTH)/4);
    fill(INSIDE_SUN);
    circle(REAL_WIDTH+60,60,(2*TILE_WIDTH)/4);
    rectMode(CORNER);
    // write sunValue
    textSize(55);
    text(sunValue,REAL_WIDTH+90,77);
    // money
    fill(LIGHTEST_GREEN);
    square(REAL_WIDTH+40,85,TILE_WIDTH/2);
    fill(DARKEST_GREEN);
    textSize(30);
    text("$$",REAL_WIDTH+46,114);
    // money text
    textSize(55);
    text(money,REAL_WIDTH+90,120);
  }
  
  private void drawShovelAndIcon() {
    // draw box behind
    fill(UI_BACKGROUND_COLOR);
    if (mouseMode==SHOVEL_MOUSE_MODE) {fill(LIGHTER_UI_BACKGROUND_COLOR);}
    rect(REAL_WIDTH+30,145,125,50);
    // draw shovel:
    // handle
    fill(#964B00); // BROWN
    rect(REAL_WIDTH+73/*idk if 60 CHECK LATER*/,165,57,10);
    // blade part of shovel
    fill(WATER_BLUE);
    arc(REAL_WIDTH+70, 165, 40, 40, 0, PI, CHORD);
  }
  
  private void drawPlantMenu() {
    // make boxes
    for (int i=0;i<3;i++) {
      fill(UI_BACKGROUND_COLOR);
      // ***
      // ADD FOR EACH PLANT
      // ***
      if (pageNum==0&&i==0&&mouseMode==PEASHOOTER) {fill(LIGHTER_UI_BACKGROUND_COLOR);} // peashooter
      if (pageNum==0&&i==1&&mouseMode==SUNFLOWER) {fill(LIGHTER_UI_BACKGROUND_COLOR);} // sunflower
      rect(45+i*3*TILE_WIDTH,REAL_HEIGHT+20,150,55);
    }
    // box 1(leftmost): topleft(45,REAL_HEIGHT+20) , bottomright(45+150,REAL_HEIGHT+20+55)
    // box 2(middle): topleft(45+1*3*TILE_WIDTH,REAL_HEIGHT+20) , bottomright(45+3*TILE_WIDTH+150,REAL_HEIGHT+20+55)
    // box 3 (rightmost): topleft(45+2*3*TILE_WIDTH,REAL_HEIGHT+20) , bottomright(45+2*3*TILE_WIDTH+150,REAL_HEIGHT+20+55)
    
    // put the text name
    // ***
    // ADD HERE FOR EACH PLANT
    // ***
    fill(255);
    textSize(21);
    if (pageNum==0) {
      text("Peashooter(100)",47,REAL_HEIGHT+55); // peashooter
      text("Sunflower(50)",300,REAL_HEIGHT+55); // sunflower
      // whatever tf
    }
  }
  
  //
  
  // ---METHODS THAT ARE IMPORTANT---
  
  // draws all the UI stuff
  public void drawUI() {
    drawUIBackground();
    drawValueDisplay();
    drawShovelAndIcon();
    drawPlantMenu();
  }
  
  // one cycle of mousePressed when not paused
  public void mousePressedUI() {
    
    // collect sun
    if (mouseMode==DEFAULT_MOUSE_MODE) {
      for (int i=0;i<sunArray.size();i++) {
        int sW = (2*TILE_WIDTH)/3;
        // if mouse coords within range of sun
        if ((mouseX>sunArray.get(i).getActualX()-sW)
        &&(mouseX<sunArray.get(i).getActualX()+sW)
        &&(mouseY>sunArray.get(i).getActualY()-sW)
        &&(mouseY<sunArray.get(i).getActualY()+sW)) {
          sunArray.get(i).collect();
        }
      }
    }//collect sun
    
    // using shovel
    if (mouseMode==SHOVEL_MOUSE_MODE) {
      if (mouseX<REAL_WIDTH&&mouseX>0&&mouseY<REAL_HEIGHT&&mouseY>0) {
        if (map.getMapItself()[mouseY/TILE_HEIGHT][mouseX/TILE_WIDTH].getPlant()!=null) {
          map.getMapItself()[mouseY/TILE_HEIGHT][mouseX/TILE_WIDTH].setPlant(null);
        }
      }
    }//using shovel
    
    // click/unclick shovel
    if (mouseX>REAL_WIDTH+30&&mouseY>145&&mouseX<REAL_WIDTH+30+125&&mouseY<145+50) {
      if (mouseMode == SHOVEL_MOUSE_MODE) {
        println("top");
        mouseMode = DEFAULT_MOUSE_MODE;
      } else {
        println("bottom");
        mouseMode = SHOVEL_MOUSE_MODE;
      }
    }
    
    // set mouseMode to plants based off menu
      // box 2(middle): topleft(45+1*3*TILE_WIDTH,REAL_HEIGHT+20) , bottomright(45+3*TILE_WIDTH+150,REAL_HEIGHT+20+55)
      // box 3 (rightmost): topleft(45+2*3*TILE_WIDTH,REAL_HEIGHT+20) , bottomright(45+2*3*TILE_WIDTH+150,REAL_HEIGHT+20+55)
      
    // ***
    // ADD HERE FOR EACH PLANT
    // ***
    // FIRST BOX
    if (mouseX>45&&mouseX<45+150&&mouseY>REAL_HEIGHT+20&&mouseY<REAL_HEIGHT+20+55) {
      // first page
      if (pageNum==0) {
        // if already selected it
        if (mouseMode!=PEASHOOTER) {
          mouseMode = PEASHOOTER;
        } else {
          mouseMode = DEFAULT_MOUSE_MODE;
        }
      }//first page
    }
    // SECOND BOX
    if (mouseX>45+3*TILE_WIDTH&&mouseY>REAL_HEIGHT+20&&mouseX<45+3*TILE_WIDTH+150&&mouseY<REAL_HEIGHT+20+55) {
      // first page
      if (pageNum==0) {
        if (mouseMode!=SUNFLOWER) {
          mouseMode = SUNFLOWER;
        } else {
          mouseMode = DEFAULT_MOUSE_MODE;
        }
      }
    }
    // THIRD BOX
    if (true) {
      // first page
      if (pageNum==0) {
        
      }
    }
    
    // ***
    // ADD HERE FOR EACH PLANT
    // ***
    // place plants
    if (mouseX>0&&mouseY>0&&mouseX<REAL_WIDTH&&
    mouseY<REAL_HEIGHT&&map.getMapItself()[mouseY/TILE_HEIGHT][mouseX/TILE_WIDTH].getPlant()==null) {// (if no plants and within map)
      
      // place peashooter
      if (mouseMode==PEASHOOTER && sunValue>=100) {
        map.getMapItself()[mouseY/TILE_HEIGHT][mouseX/TILE_WIDTH].setPlant(new Peashooter(mouseX/TILE_WIDTH,mouseY/TILE_HEIGHT)); // peashooter
        sunValue-=100;
      }
      
      // place sunflower
      if (mouseMode==SUNFLOWER && sunValue>=50) {
        map.getMapItself()[mouseY/TILE_HEIGHT][mouseX/TILE_WIDTH].setPlant(new Sunflower(mouseX/TILE_WIDTH,mouseY/TILE_HEIGHT)); // sunflower
        sunValue-=50;
      }
      
      
    }//place plants
    
    
  }
  
}
