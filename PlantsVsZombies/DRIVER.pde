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
public final color UI_BACKGROUND_COLOR = #6e7c7d;
public final color LIGHTER_UI_BACKGROUND_COLOR = #98a3a2;
// maps
public final String DEFAULT_MAP = "default";
// tiles
public final String NORMAL_TILE = "normal tile";
public final String WATER_TILE = "water tile";
// mouse mode
public final String DEFAULT_MOUSE_MODE = "default mouse mode";
public final String SHOVEL_MOUSE_MODE = "shovel mouse mode";
// plants
public final String PEASHOOTER = "pea shooter";
public final String SUNFLOWER = "sun flower";
// zombies
public final String DEFAULT_ZOMBIE = "default zombie";
// images
// PApplet
public PApplet parent = this;


// ---VAR DECLARATION---
// values
public int sunValue; // make game start at 50 though
public int money;
public int level;
public boolean paused;
public int totalZombieCount;
public int totalWaveCount;
// mouse mode
public String mouseMode; // mode / action that mouse is in
// objects
public Map map;
public ArrayList<Sun> sunArray;
public ArrayList<Zombie> zombiesArray;
public ArrayList<Projectile> projectiles;
public ZombieManager zombieManager;
public UI ui;

// ---SETUP / DRAW---
public void setup() {
  background(100);
  size(900,500);
  initializeAsign();
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
  // reset
  if (key=='r') {
    setup();
  }
  // pause stuff
  if (key == ' ' && !paused) {
    paused=true;
  } else if (key == ' ' && paused) {
    paused = false;
  }
}

void mousePressed() {
  // if unpaused
  if (!paused) {
    // putting all the sun stuff because that means you can hold down to pick up sun
    ui.mousePressedUI();
  }
}

// ---OTHER METHODS---

public void initializeAsign() {
  sunValue = 100; // should be 25 - set other for testing
  money = 0;
  level = 1;
  paused = false;
  map = new Map(DEFAULT_MAP);
  sunArray = new ArrayList<Sun>();
  zombiesArray = new ArrayList<Zombie>();
  totalZombieCount = 0;
  totalWaveCount = 0;
  mouseMode = DEFAULT_MOUSE_MODE;
  projectiles = new ArrayList<Projectile>();
  //defaultZombie = loadImage("zombie.jpg");
  zombieManager = new ZombieManager();
  ui = new UI();
}

public void unpausedDraw() {
  animate();
  manageSuns();
  manageThePlants();
  manageProjectiles();
  manageZombies();
}

public void pausedDraw() {
  //println(projectiles.size()); maxes out about 305
}

public void animate() {
  // draw map
  map.drawMap(); // draws grid and plants
  // draw zombies
  zombieManager.drawZombies();
  // draw projectiles
  for (int i=0;i<projectiles.size();i++) {
    projectiles.get(i).drawProjectile();
  }
  // draw sun
  for (int i=0;i<sunArray.size();i++) {
    sunArray.get(i).drawSun();
  }
  // draw ui
  ui.drawUI();
}

public void manageSuns() {
  // new sun every 10 seconds
  if (frameCount % (10*60) == 0) {
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
  zombieManager.run();
}

public void manageProjectiles() {
  for (int i=0;i<projectiles.size();i++) {
    projectiles.get(i).moveProjectile();
    projectiles.get(i).attackZombie();
    if (projectiles.get(i).getShouldDie()) {
      projectiles.remove(i);
    }
  }
}
