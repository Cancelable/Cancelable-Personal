class MovingPlatform extends BasicPlatform {
  
  MovingPlatform(float x, float y, float z) {
    super(x, y, z, 60, 10, 60);
  }
  
  void initPlatform(float chance) {
    brokenPlatformTouched = false;
    c = color(#79D9E3); // lighter blue color
    platformType = MOVING_PLATFORM;
    movingDirection = 1; // moving to the right is the default
    
    // make springs appear more common than monsters or jetpacks
    if (random(1) < chance) {
      spring = new Spring(this);
    } 
    else if (random(1) < chance/3) {
      monster = new Monster(this);
    } 
    else if (random(1) < chance/3) {
      jetpack = new JetPack(this);
    }
    
    // half of the moving platforms will move to the left
    if (random(1) < 0.5) {
      movingDirection = -1;
    }
  }
}
