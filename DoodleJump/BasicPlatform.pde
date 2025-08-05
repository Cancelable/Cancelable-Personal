class BasicPlatform {
  
  float x, y, z;
  int w;
  int h;
  int l;
  
  Spring spring;
  Monster monster;
  JetPack jetpack;
  
  int platformType;
  color c;
  boolean brokenPlatformTouched;
  int movingDirection;
  
  Box3D box;
  
  BasicPlatform(float x, float y, float z, int w, int h, int l, float chance) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.l = l;
    initPlatform(chance);
    box = new Box3D(x,y,z,w,h,l,c);
  }//constructor
  
  BasicPlatform(float x, float y, float z, int w, int h, int l) {
    this(x, y, z, w, h, l, 0.0);
  }//overloaded wrapper constructor (used for generating platforms with no additions like springs, monsters, or jetpacks)
  
  void initPlatform(float chance) {
    brokenPlatformTouched = false;
    c = color(0); // default black--doesn't matter since this is just the basic platform
    platformType = BASIC_PLATFORM;
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
    fill(c);
    
    box = new Box3D(x,y,z,w,h,l,c);
    box.drawBox();
    
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
