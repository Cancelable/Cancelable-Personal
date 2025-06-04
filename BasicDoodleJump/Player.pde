class Player {
  
  PVector pos;
  boolean isDead;
  int size;
  PVector acceleration;
  PVector velocity;
  boolean flying;
  
  Player() {
    pos = new PVector(width/2,9*height/10);
    isDead = false;
    size = 20;
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    flying = false;
  }
  
  void move(ArrayList<Tile> array) {
    if (!flying) {
      applyGravity();
      // bounce off things
      for (int i=0;i<array.size();i++) {
        if (velocity.y>=0 && array.get(i).isTouching(pos.x,pos.y)) {
          velocity.y = 0; // stop it from potentially going down
          acceleration.y = -JUMP_BOOST; // go up
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
  }
  
  void applyForce(PVector force) {
    PVector scaleForce = force.copy();
    //scaleForce.div(mass);
    acceleration.add(scaleForce);
  }
  
  void applyGravity() {
    applyForce(new PVector(0,1));
  }
  
  void jetPack() {
    
  }
  
  void display() {
    fill(255,0,0);
    circle(pos.x,pos.y,size);
  }
  
}
