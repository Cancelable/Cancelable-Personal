// ---FINAL VAR DECLARATION---
// nums
public final int REAL_WIDTH = (4*900)/5; // 900 is width
public final int REAL_HEIGHT = (4*600)/5; // 600 is height
public final int TILE_WIDTH = REAL_WIDTH/9; // 9 horizontal
public final int TILE_HEIGHT = REAL_HEIGHT/5; // 5 vertical
// colors
public final color LIGHTEST_GREEN = #B9ECA4;
public final color MIDDLE_GREEN = #A2D38E;
public final color DARKEST_GREEN = #88B874;
public final color WATER_BLUE = #6FDAD9;
// maps
public final String DEFAULT_MAP = "default";
// tiles
public final String NORMAL_TILE = "normal tile";
public final String WATER_TILE = "water tile";
// plants
// zombies


// ---VAR DECLARATION---
public int sunValue; // make game start at 50 though
public int coins;
public int level;

public boolean paused = false;

// ---SETUP / DRAW---
public void setup() {
  size(900,600);
  sunValue = 0;
  coins = 0;
  level = 1;
  //fill(255,0,0);
  //rect(0,0,REAL_WIDTH,REAL_HEIGHT);
  //println(REAL_WIDTH + "width" + 4*width/5);
  //println(REAL_HEIGHT + "height" + 4*height/5);
}
  
public void draw() {
  if (!paused) { // if unpaused
    unpausedDraw();
  } else {
    pausedDraw();
  }
}

// ---KEYBOARD / MOUSE METHODS---

// ---OTHER METHODS---

public void unpausedDraw() {
  
}

public void pausedDraw() {
  
}
