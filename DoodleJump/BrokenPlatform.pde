class BrokenPlatform extends BasicPlatform {
  
  BrokenPlatform(float x, float y, float z) {
    super(x, y, z, 60, 10, 60);
  }
  
  void initPlatform(float chance) {
    brokenPlatformTouched = false;
    c = color(150,75,0); // brown
    platformType = BROKEN_PLATFORM;
    movingDirection = 0; // no movement by default
    
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
  }
  
  void display() {
    if (brokenPlatformTouched) {
      if (w>0) {w--;}
      if (h>0) {h--;}
      if (z>0) {z--;}
    }
    super.display();
  }
}
