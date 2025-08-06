class Player {
  
  PVector pos;
  PImage player;
  PImage leftPos;
  PImage rightPos;
  boolean turnLeft;
  boolean turnRight;
  
  int w = 55, h = 55, l = 55;
  float xSpeed = 0;
  float ySpeed = 0;
  float zSpeed = 0;
  float gravity = 0.5;
  float jumpPower = -12;
  float moveSpeed = 7*balancingMultiplier;

  Player(float x, float y, float z) {
    pos = new PVector(x,y,z);
    player = loadImage("doodler.png");
    player.resize(w, h);
    rightPos = player;
    //leftPos = horizontalFlip(rightPos.copy());
    //turnRight = true;
  }

  void update() {
    ySpeed += gravity;
    pos.y += ySpeed;
    pos.x += xSpeed;
    pos.z += zSpeed;

    //if (pos.x < 0) {pos.x = width;}
    //if (pos.z < 0) {pos.z = width;}
    //if (pos.x > width) {pos.x = 0;}
    //if (pos.z > width) {pos.z = 0;}
    xSpeed = 0;
    zSpeed = 0;
  }

  void display() {
    //image(player, pos.x, pos.y);
    //rect(pos.x,pos.y,w,h); // test to see real size
  }
  
  int getIndex(PImage img, int x, int y) {
    //go through the first row of indices and find which one matches with x
    //the difference between indices in the same column is actually just the image width
    //when going downward to find the index, just increment by that amount, and increment y times
    int pixelIndex = x + (img.width * y);
    return pixelIndex;
  }//getIndex
  
  //PImage horizontalFlip(PImage pic) {
  //  PImage picCopy = pic.copy(); // copy so we can return
  //  int dist = picCopy.width - 1; // from the first index to the last index (in the first ROW)
  //  for (int col = 0; col < picCopy.width/2; col++) {
  //    for (int row = 0; row < picCopy.height; row++) {
  //      int curPixelIndex = getIndex(picCopy, col, row);
  //      int tarPixelIndex = getIndex(picCopy, col + dist, row); // target index is on the opposite side symmetrically (same distance from the VERTICAL)
      
  //      // swap the pixels' colors!
  //      color curPixel = picCopy.pixels[curPixelIndex];
  //      color tarPixel = picCopy.pixels[tarPixelIndex];
      
  //      picCopy.pixels[curPixelIndex] = tarPixel;
  //      picCopy.pixels[tarPixelIndex] = curPixel;
  //    }
  //    dist -= 2; // subtract the previous two indices (prev. current index & prev. target index)
  //  }
  //  return picCopy;
  //}//horizontalFlip
  
  // (old move) checkPlatform
  // allows jumping
  void checkPlatform(BasicPlatform p) {
    // normal boost
    if ((pos.x + w > p.x && pos.x < p.x + p.w && pos.z + l > p.z && pos.z < p.z + p.l)&&
        ((pos.y + h >= p.y && pos.y + h <= p.y + p.h)||(pos.y + h <= p.y && pos.y + h + ySpeed >= p.y + p.h))) {
        // if is not a broken platform
        if (ySpeed > 0) {
          if (p.platformType != BROKEN_PLATFORM) {
            // if it is moving platform, increase moving platform speed
            if (p.platformType == MOVING_PLATFORM&&movingPlatformSpeed < 10) {
              movingPlatformSpeed += 0.1;
            }
            // boost
            ySpeed = jumpPower;
          }
        }
        // if it is a broken platform
        else {
          p.brokenPlatformTouched = true;
        }
    }
    // spring boost
    if ((p.spring != null) && (p.spring.isTouching(this))) {
      ySpeed = jumpPower * 1.8;
      return;
    }
  }
  
  
  //// go left
  //void moveLeft() {
  //  xSpeed = -moveSpeed;
  //  if (turnRight && !turnLeft) {
  //    player = leftPos;
  //    turnRight = false;
  //    turnLeft = true;
  //  }
  //}
  
  
  //// go right
  //void moveRight() {
  //  xSpeed = moveSpeed;
  //  if (turnLeft && !turnRight) {
  //    player = rightPos;
  //    turnLeft = false;
  //    turnRight = true;
  //  }
  //}
  
  void move() {
    //float pan = map(mouseX - pmouseX, 0, width, 0, TWO_PI) * cam.sensitivity;
    PVector fakeForward = new PVector(cos(cam.pan),0,sin(cam.pan));
    PVector right = new PVector(cos(cam.pan - PI/2), 0, sin(cam.pan - PI/2));
    fakeForward.normalize();
    if (keys['w']) {pos.add(PVector.mult(fakeForward,moveSpeed));
      pos.y -= PVector.mult(fakeForward,moveSpeed).y;}
    if (keys['s']) {pos.sub(PVector.mult(fakeForward,moveSpeed));
      pos.y += PVector.mult(fakeForward,moveSpeed).y;}
    if (keys['a']) {pos.add(PVector.mult(right,moveSpeed));}
    if (keys['d']) {pos.sub(PVector.mult(right,moveSpeed));}
    cam.position = pos;
  }
  
  
  // stop moving horizontally
  void stop() {
    xSpeed = 0;
    zSpeed = 0;
  }
  
  
  // shoot
  void shoot() {
    float bx = pos.x + w / 2;
    float by = pos.y;
    float bz = pos.z + w / 2;
    bullets.add(new Ammo(bx, by,bz));
  }
  
  
}//player
