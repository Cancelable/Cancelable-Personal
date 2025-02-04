public class UI {
  
  public UI() {
    // nothing lol
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
  
  // ---METHODS THAT ARE IMPORTANT---
  
  // draws all the UI stuff
  public void drawUI() {
    drawUIBackground();
    drawValueDisplay();
  }
  
  public void mousePressedUI() {
    
  }
  
}
