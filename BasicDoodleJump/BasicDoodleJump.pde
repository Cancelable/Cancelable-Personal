final int ABS_SPEED = 5;
final int JUMP_BOOST = 20;
Player player;
ArrayList<Tile> tiles;
boolean[] keys;

void setup() {
  size(600,600);
  player = new Player();
  tiles = new ArrayList<Tile>();
  tiles.add(new Tile(width/2,9*height/10+5));
  keys = new boolean[128];
}

void draw() {
  background(200);
  player.display();
  player.move(tiles);
  for (int i=0;i<tiles.size();i++) {
    tiles.get(i).display();
  }
  realKeyPressed();
}

// keypressed - keyreleased
void keyPressed() {
  if ((int)key<128) {keys[key] = true;}
}
void keyReleased() {
  if ((int)key<128) {keys[key] = false;}
}

// real keyPressed method to use
// takes in several keys at once
void realKeyPressed() {
  if (keys['r'] || keys['R']) {
    setup();
  }
  if (keys['a']||keys['A']) {
    player.applyForce(new PVector(-ABS_SPEED,0));
  }
  if (keys['d']||keys['D']) {
    player.applyForce(new PVector(ABS_SPEED,0));
  }
}

void generation() {
  
  
  
}
