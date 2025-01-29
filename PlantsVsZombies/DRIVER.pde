// ---FINAL VAR DECLARATION---
// nums
public final int REAL_WIDTH = (4*900)/5; // 900 is width
public final int REAL_HEIGHT = (4*500)/5; // 500 is height
public final int TILE_WIDTH = REAL_WIDTH/9; // 9 horizontal * used for more stuff
public final int TILE_HEIGHT = REAL_HEIGHT/5; // 5 vertical
// colors
public final color LIGHTEST_GREEN = #B9ECA4;
public final color MIDDLE_GREEN = #A2D38E;
public final color DARKEST_GREEN = #88B874;
public final color WATER_BLUE = #6FDAD9;
public final color INSIDE_SUN = #FFE100;
public final color OUTSIDE_SUN = #FFFF80;
// maps
public final String DEFAULT_MAP = "default";
// tiles
public final String NORMAL_TILE = "normal tile";
public final String WATER_TILE = "water tile";
// plants
public final String PEASHOOTER = "pea shooter";
public final String SUNFLOWER = "sun flower";
// zombies


// ---VAR DECLARATION---
// values
public int sunValue; // make game start at 50 though
public int coins;
public int level;
public boolean paused;
// objects
public Map map;
public ArrayList<Sun> sunArray;

// ---SETUP / DRAW---
public void setup() {
  background(100);
  size(900,500);
  initializeAsign();
  //fill(255,0,0);
  //rect(0,0,REAL_WIDTH,REAL_HEIGHT);
  //println(TILE_WIDTH + "width");
  //println(TILE_HEIGHT + "height");
  frameRate(60);
}
  
public void draw() {
  if (!paused) { // if unpaused
    unpausedDraw(); // run unpaused draw
  } else { // if paused
    pausedDraw(); // run paused draw
  }
}

// ---KEYBOARD / MOUSE METHODS---

void keyPressed() {
  if (key=='r') {
    setup();
  }
}

// ---OTHER METHODS---

public void initializeAsign() {
  sunValue = 50;
  coins = 0;
  level = 1;
  paused = false;
  map = new Map(DEFAULT_MAP);
  sunArray = new ArrayList<Sun>();
}

public void unpausedDraw() {
  animate();
}

public void pausedDraw() {
  
}

public void animate() {
  // draw map
  map.drawMap();
  // draw plants
  // draw zombies
  // draw sun
  for (int i=0;i<sunArray.size();i++) {
    sunArray.get(i).drawSun();
  }
}

public void manageSuns() {
  // new sun every 15 seconds
  if (frameCount % 15*60 == 0) {
    sunArray.add(new Sun());
  }
  // kill collected suns
  for (int i=0;i<sunArray.size();i++) {
    if (sunArray.get(i).isCollected()) {
      sunArray.remove(i);
    }
  }
}

public void managePlants() {
  
}

public void manageZombies() {
  
}
