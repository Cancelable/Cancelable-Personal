public class UI {
  
  public UI() {
    
  }  
  
  public void drawUI() {
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
}
