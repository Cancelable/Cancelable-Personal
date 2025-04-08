class Bullet {
  
  PVector position;
  float angle; // radians // for image
  PVector speed;
  String team;
  int damage;
  float size;
  boolean shouldDie;
  PImage sprite;
  int bounces;
  float lifeTicks;
  
  Bullet(float x, float y, float xSpeed, float ySpeed, int damage, String team, float lifeSpan) {
    position = new PVector(x,y);
    speed = new PVector(xSpeed,ySpeed);
    this.damage = 1;
    this.angle = angle;
    size = 5;
    this.team = team;
    lifeTicks = frameRate*lifeSpan;//println(lifeTicks);
    shouldDie = false;
    //sprite = loadImage(spritePath);
    //sprite = loadImage("bullet1.png");
    sprite = null; // prevents lag
    bounces = 5;
  }
  
  void bounceX() {
    speed.x = -speed.x;
  }

  void bounceY() {
    speed.y = -speed.y;
  }

  void pDisplay() {
    circle(position.x,position.y,size);
  }
  
  void drainPlayer(Player other) {
    if (other!=null&&team!=other.team) {
      other.takeDamage(damage);
      //shouldDie = true;
    }
  }

  void move() {
    position.x += speed.x;
    position.y += speed.y;
  }

  boolean outOfBounds() {
    return position.x < 0 || position.x > width || position.y > height || position.y < 0;
  }

}
