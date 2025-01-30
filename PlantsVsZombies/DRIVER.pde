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
// mouse mode
public final String DEFAULT_MOUSE_MODE = "default mouse mode";
public final String SHOVEL_MOUSE_MOPDE = "shovel mouse mode";
// plants
public final String PEASHOOTER = "pea shooter";
public final String SUNFLOWER = "sun flower";
// zombies
public final String DEFAULT_ZOMBIE = "default zombie";
// images
PImage defaultZombie;


// ---VAR DECLARATION---
// values
public int sunValue; // make game start at 50 though
public int coins;
public int level;
public boolean paused;
public int totalZombieCount;
// mouse mode
public String mouseMode;
// objects
public Map map;
public ArrayList<Sun> sunArray;
public ArrayList<Zombie> zombiesArray;
public ArrayList<Projectile> projectiles;

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

void mousePressed() {
  
}

// ---OTHER METHODS---

public void initializeAsign() {
  sunValue = 50;
  coins = 0;
  level = 1;
  paused = false;
  map = new Map(DEFAULT_MAP);
  sunArray = new ArrayList<Sun>();
  zombiesArray = new ArrayList<Zombie>();
  totalZombieCount = 0;
  mouseMode = DEFAULT_MOUSE_MODE;
  projectiles = new ArrayList<Projectile>();
  defaultZombie = loadImage("zombie.jpg");
}

public void unpausedDraw() {
  animate();
  manageSuns();
  manageThePlants();
  manageZombies();
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
  // draw ui
  drawUI();
}

public void manageSuns() {
  // new sun every 8 seconds
  if (frameCount % (8*60) == 0) {
    sunArray.add(new Sun());
  }
  for (int i=0;i<sunArray.size();i++) {
    // move new Suns
    sunArray.get(i).sunFalling();
    // kill all collected suns
    if (sunArray.get(i).isCollected()) {
      sunArray.remove(i);
    }
  }
}

public void manageThePlants() {
  map.managePlants();
}

public void manageZombies() {
  
}

public void manageProjectiles() {
  
}

public void drawUI() {
  
}
