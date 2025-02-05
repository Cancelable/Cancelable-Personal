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
  
  //
  
  // ---METHODS THAT ARE IMPORTANT---
  
  // draws all the UI stuff
  public void drawUI() {
    drawUIBackground();
    drawValueDisplay();
    drawShovelAndIcon();
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
    
  }
  
}
