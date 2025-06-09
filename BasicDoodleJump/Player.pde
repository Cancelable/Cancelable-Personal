class Player {
  
  PVector pos;
  boolean isDead;
  int size;
  PVector acceleration;
  PVector velocity;
  boolean flying;
  int cHeight;
  Tile currentTile;
  Tile oldTile;
  
  Player() {
    pos = new PVector(width/2,ORIGINAL_HEIGHT - size);
    isDead = false;
    size = 20;
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    flying = false;
    cHeight = 0;
    currentTile = null;
    oldTile = null;
  }
  
  void move(ArrayList<Tile> array) {
    if (!flying) {
      applyGravity();
      // bounce off things
      for (int i=0;i<array.size();i++) {
        if (velocity.y>=0 && array.get(i).isTouching(pos.x,pos.y,velocity.y)&&array.get(i).pos.y>0) {
          oldTile = currentTile;
          currentTile = array.get(i);
          if (currentTile!=oldTile) {countAddedPerJump = 0;}
          acceleration.y = -JUMP_BOOST; // go up
          //int potentialCHeight = ORIGINAL_HEIGHT - (int)array.get(i).pos.y + array.get(i).tHeight;
          cHeight = ORIGINAL_HEIGHT - (int)array.get(i).pos.y + array.get(i).tHeight;
          //if (potentialCHeight > cHeight) {cHeight = potentialCHeight;}
          velocity.y = 0; // stop it from potentially going down
          break;
        }
      }
      velocity.add(acceleration);
      pos.add(velocity);
      acceleration.mult(0);
      velocity.x = 0;
    }
    // flying (jetpack)
    else {
      
    }
    // if past right side of screen
    if (pos.x > width) {
      pos.x = pos.x - width;
    }
    // if past left side of screen
    if (pos.x < 0) {
      pos.x = pos.x + width; 
    }
  }//move
  
  void applyForce(PVector force) {
    PVector scaleForce = force.copy();
    //scaleForce.div(mass);
    acceleration.add(scaleForce);
  }
  
  void applyGravity() {
    applyForce(new PVector(0,OVERWORLD_GRAVITY));
  }
  
  void jetPack() {
    
  }
  
  void display() {
    fill(255,0,0);
    circle(pos.x,pos.y,size);
  }
  
  void checkIsDead() {
    // check if y greater than height
    if (pos.y >= height) {
      isDead = true;
    }
    
  }
  
  
  void moveVertically(float amount) {
    pos.y += amount;
  }
  
}
