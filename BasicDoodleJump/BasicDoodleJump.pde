final int ABS_SPEED = 10;
final int JUMP_BOOST = 13;
final int TILE_MOVE_DOWN_SPEED = 10;
final int ORIGINAL_HEIGHT = int(8*600/10);
final float OVERWORLD_GRAVITY = 0.5;
final int TILE_SPACING = height;
final color OVERWORLD_SPRING_COLOR = #B5D3DE;
Player player;
ArrayList<Tile>tiles;
boolean[] keys;
boolean gameOver;
int countAddedPerJump;
int maxToAddPerJump;


void setup() {
  size(600, 600);
  frameRate(60);
  player = new Player();
  tiles = new ArrayList<Tile>();
  tiles.add(new Tile(width/2, ORIGINAL_HEIGHT));
  //tiles.add(new Tile(width/2 - 150, 5*height/10)); // test tile 1
  //tiles.add(new Tile(width/2, 3*height/10)); // test tile 2
  keys = new boolean[128];
  gameOver = false;
  countAddedPerJump = 0;
  maxToAddPerJump = (int)random(5) + 1;
}


void draw() {
  background(200);
  realKeyPressed();
  if (!gameOver) { // game running
    generation();
    managePlayer();
    manageTiles();
    playerAboveScreenManagement();
  }//game running
  else {
    gameOver();
  }
}


// keypressed - keyreleased
void keyPressed() {
  if ((int)key<128) {
    keys[key] = true;
  }
}
void keyReleased() {
  if ((int)key<128) {
    keys[key] = false;
  }
}


// real keyPressed method to use
// takes in several keys at once
void realKeyPressed() {
  if (keys['r'] || keys['R']) {
    setup();
  }
  if (keys['a']||keys['A']) {
    player.applyForce(new PVector(-ABS_SPEED, 0));
  }
  if (keys['d']||keys['D']) {
    player.applyForce(new PVector(ABS_SPEED, 0));
  }
}


// generates tiles, monsters, jetpacks, springs, etc
void generation() {
  if (tiles.size()<100) {
    tiles.add(new Tile(tiles));
  }
  //if (player.oldTile!=player.currentTile&&player.oldTile!=null&&player.currentTile!=null&&countAddedPerJump<maxToAddPerJump) {
  //  Tile newTile = new Tile();
  //  boolean touches = false;
  //  for (int i=0;i<tiles.size();i++) {
  //    if (tiles.get(i).isTouching(newTile)) {
  //      touches = true;
  //    }
  //  }
  //  if (!touches) {tiles.add(newTile);}
  //  countAddedPerJump++;
  //}
}


void manageTiles() {
  for (int i=0; i<tiles.size(); i++) {
    if (player.cHeight>=0) {
      if (player.currentTile!=null) {
        // if tile is over current normal player height
        if (!(player.currentTile.pos.y + TILE_MOVE_DOWN_SPEED > ORIGINAL_HEIGHT)) {
          tiles.get(i).moveVertically(TILE_MOVE_DOWN_SPEED);
        } else {
          tiles.get(i).moveVertically(ORIGINAL_HEIGHT - player.currentTile.pos.y);
        }
      }
    }
    tiles.get(i).display();
    if (tiles.get(i).pos.y > height) {tiles.remove(i);}
  }
}


void managePlayer() {
  player.display();
  player.move(tiles);
  player.checkIsDead();
  if (player.isDead) {gameOver = true;}
}


// gets its own method because it involves affecting both tiles and players
void playerAboveScreenManagement() {
  if (player.pos.y<player.size) {
    player.moveVertically(TILE_MOVE_DOWN_SPEED);
    for (int i=0;i<tiles.size();i++) {
      tiles.get(i).moveVertically(TILE_MOVE_DOWN_SPEED);
    }
  }
}


void gameOver() {
  background(100);
}
