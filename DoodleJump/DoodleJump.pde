import queasycam.*;

// DRIVER FILE

// GLOBAL VARIABLES 
final int BASIC_PLATFORM = 0;
final int REG_PLATFORM = 1;
final int BROKEN_PLATFORM = 2;
final int MOVING_PLATFORM = 3;
final int JETPACK_TICK = 60*5;

int mode;
final int REGULAR_MODE = 0;
final int SPACE_MODE = 1;
final int ICE_MODE = 2;
final int MAX_BULLETS = 50;
final float RELOAD_COOLDOWN = 60*1.25f;
final int FIRE_RATE = 15;

PImage background;
PImage BKGRD_REG_MODE;

Player player;
float balancingMultiplier;
ArrayList<BasicPlatform> platforms;
ArrayList<Ammo> bullets;
int bulletsShot;
int lastReloadFrameCount;
int score;
int coins;
float movingPlatformSpeed;
float scrollY;
public boolean[] keys;
boolean gameOver;
color currentBackgroundColor;
int jetpackTicks;
public QueasyCam cam;

// setup
void setup() {
  //size(500, 900, P3D);
  fullScreen(P3D);
  frameRate(60);
  mode = REGULAR_MODE;
  cam = new QueasyCam(this);
  cam.speed = 0;
  cam.sensitivity = 2;
  score = 0;
  scrollY = 0;
  lastReloadFrameCount = 0;
  balancingMultiplier = 1.5;
  jetpackTicks = 0;
  bulletsShot = 0;
  keys = new boolean[130];
  gameOver = false;
  movingPlatformSpeed = 2;
  player = new Player(width / 4, height - 100, width/4);
  platforms = new ArrayList<BasicPlatform>();
  bullets = new ArrayList<Ammo>();
  
  BKGRD_REG_MODE = loadImage("background_reg_mode.png");

  // Create starting platforms
  for (int i = 1; i < 10; i++) {
    float x = random(balancingMultiplier*width/4 - 60);
    float y = height - i * 60;
    float z = random(balancingMultiplier*width/4 - 60);
    platforms.add(new RegPlatform(x, y, z));
  }
  
  platforms.set(0, new RegPlatform(width/4, height * (9.5/10), width/4));
}

void setBackground() {
  if (mode == REGULAR_MODE) {
    background = BKGRD_REG_MODE;
  }
}

// draw
void draw() {
  //setBackground();
  //background(background);
  background(#ECF0C2);
  
  lights();
  
  realKeyPressed();
  
  // if game continuing
  if (!gameOver) {
    //Box3D bottom = new Box3D(0,height,0,width,10,width,#3F8DF0);
    //bottom.drawBox();
    
    // display player
    //player.display();
    // update player
    player.update();
    // push everything down if player above height
    playerHeightCheck();
    
    // deal with platforms/monsters
    managePlatforms();
    // make sure theres always 10 platforms
    generation();
    // manage bullets
    manageBullets();
    // jetpack behavior
    jetpack();
  
    // display score on screen
    fill(0);
    textSize(16);
    textAlign(LEFT);
    text("Score: " + score, 10, 20);
  
    fallBelowScreenCheck();
  }
  // game over screen
  else {
    fill(255,0,0);
    textSize(16);
    text("Game Over",width/2,height/2);
    coins += score;
    score = 0;
  }
}


float minPlatformY() {
  float minY = height;
  for (BasicPlatform p : platforms) {
    if (p.y < minY) minY = p.y;
  }
  return minY;
}


// key pressed/released
void keyPressed() {
  if ((int)key<128) {
    keys[key] = true;
  }
  if (keyCode==LEFT) {keys[128] = true;}
  if (keyCode==RIGHT) {keys[129] = true;}
}
void keyReleased() {
  if ((int)key<128) {
    keys[key] = false;
  }
  if (keyCode==LEFT) {keys[128] = false;}
  if (keyCode==RIGHT) {keys[129] = false;}
}


// real keyPressed (dont put stuff in other one)
void realKeyPressed() {
  if (keys['p']||keys['P']) {
    if (!gameOver) {setup();}
    else {fakeRestart();}
    
  }
  player.move();
  //if (keys[' ']) {
  //  int numBullets = bullets.size();
  //  if (bulletsShot < MAX_BULLETS) {
  //    if (frameCount - lastReloadFrameCount > RELOAD_COOLDOWN) {
  //      if (bulletsShot > 0 && frameCount - bullets.get(bullets.size()-1).myFrameCount>=FIRE_RATE) {
  //        player.shoot();
  //        bulletsShot++;
  //      }
  //      else if (bulletsShot==0) {
  //        player.shoot();
  //        bulletsShot++;
  //      }
  //    }
  //  }
  //}
  
  // shoot
  int framesSinceReload = frameCount - lastReloadFrameCount;
  if (keys[' ']&&framesSinceReload > RELOAD_COOLDOWN) {
    
    // first bullet
    if (bulletsShot == 0) {
      player.shoot();
    }
    
    // second - last bullet
    if (bulletsShot>0 && bulletsShot < MAX_BULLETS) {
      if (bullets.size()==0) player.shoot();
      else {
        int lastFrameCountShot = bullets.get(bullets.size()-1).myFrameCount;
        int frameCountDiff = frameCount - lastFrameCountShot;
        if (frameCountDiff > FIRE_RATE) {
          player.shoot();
        }
      }
    }
    
  }
  // reload
  if (keys['r']||keys['R']) {
    bulletsShot = 0;
    lastReloadFrameCount = frameCount;
  }
}


// move everything down if the player goes up
void playerHeightCheck() {
  float diff = height / 2 - player.pos.y;
  if (diff > 0) {
    scrollY += diff;
    player.pos.y += diff;
    for (BasicPlatform p : platforms) {
      p.y += diff;
      if (p.spring != null) {p.spring.y += diff;}
      if (p.monster != null) {p.monster.y += diff;}
      if (p.jetpack != null) {p.jetpack.y += diff;}
    }
    for (Ammo b : bullets) {
      b.y += diff;
    }
  }
}


// platforms updates
// (as well as monsters because theyre inside of platforms)
void managePlatforms() {
  // run through all platforms
  for (int i = platforms.size() - 1; i >= 0; i--) {
    BasicPlatform p = platforms.get(i);
    p.display();
    player.checkPlatform(p);
    
    // moving platforms
    if (p.platformType == MOVING_PLATFORM) {
      if (p.x < p.w) {
        p.movingDirection = 1;
      }
      if (p.x > (width - p.w)) {
        p.movingDirection = -1;
      }
      p.x += p.movingDirection * movingPlatformSpeed;
      p.z += p.movingDirection * movingPlatformSpeed;
    }

    // hit a monster (u lost xd)
    if (p.monster != null && p.monster.isTouching(player)) {
      // if in jetpack
      if (jetpackTicks>0) {
        p.monster = null;
      }
      // normal (not in jetpack)
      else {
        fill(255, 0, 0);
        textSize(40);
        textAlign(CENTER);
        text("Game Over!", width / 2, height / 2);
        gameOver = true;
      }
    }
    // touches jetpack
    if (p.jetpack != null && p.jetpack.isTouching(player)) {
      jetpackTicks = JETPACK_TICK;
      p.jetpack.show = false;
    }
    // kill platforms off screen
    if (p.y > height) {
      platforms.remove(i);
      score++;
    }
  }
}


// generate platforms
void generation() {
  // always have 100 platforms
  // exactly 10 are always on screen
  while (platforms.size() < 100) {
    float highestY = minPlatformY();
    float newY = highestY - 60;
    float newX = random((width/4)*balancingMultiplier - 60);
    float newZ = random((width/4)*balancingMultiplier - 60);
    if ((int)random(100) < 90 || platforms.get(platforms.size() - 1).platformType == BROKEN_PLATFORM) {
      if ((int)random(100)<90) {
        platforms.add(new RegPlatform(newX, newY, newZ));
      } else {
        platforms.add(new MovingPlatform(newX, newY, newZ));
      }
    }
    else {
      // broken platform
      platforms.add(new BrokenPlatform(newX, newY, newZ));
    }
  }
}


// manage bullets
void manageBullets() {
  // run through all bullets
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Ammo b = bullets.get(i);
    b.update();
    b.display();

    // if bullet hits monster
    for (BasicPlatform p : platforms) {
      if (p.monster != null && b.hits(p.monster)) {
        p.monster = null;
        bullets.remove(i);
        score += 5;
        break;
      }
    }

    // kill bullets not on screen
    if (i < bullets.size() && b.offscreen()) {
      bullets.remove(i);
    }
  }
}


// check if player below screen
// end game if so
public void fallBelowScreenCheck() {
  // if you fall below screen then game over
  if (player.pos.y > height) {
    fill(255, 0, 0);
    textSize(40);
    textAlign(CENTER);
    text("Game Over", width / 2, height / 2);
    gameOver = true;
  }
}


// restart without losing coins
void fakeRestart() {
  int realCoins = coins;
  setup();
  coins = realCoins;
}


// jetpack
void jetpack() {
  
  if (jetpackTicks>0) {
    player.ySpeed = -10;
    //PImage jetpack = loadImage("jetpack.png");
    //jetpack.resize((int)player.w,(int)player.h);
    //if (player.turnLeft) {
    //  //image(jetpack,player.pos.x+player.w/2,player.pos.y);
      
    //}
    //if (player.turnRight) {
    //  //image(jetpack,player.pos.x-player.w/2,player.pos.y);
      
    //}
    jetpackTicks--;
  }
}
