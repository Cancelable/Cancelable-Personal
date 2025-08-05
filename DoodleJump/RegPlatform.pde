class RegPlatform extends BasicPlatform {
  PImage regularPlat;
  PImage spacePlat;
  PImage icePlat;
  
  RegPlatform(float x, float y, float z) {
    super(x, y, z, 75, 20, 75, 0.3); // width of 75, height of 20, length of 75, and 30% chance of having springs
    c = color(#48A860);
  }//constructor
  
  void initPlatform(float chance) {
    brokenPlatformTouched = false;
    platformType = REG_PLATFORM;
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
  }//initPlatform
  
  void display() {
    super.display();
    
    if (spring != null) {
      spring.display();
    }
    if (monster != null) {
      monster.display();
    }
    if (jetpack != null) {
      jetpack.display();
    }
  }//display
}
