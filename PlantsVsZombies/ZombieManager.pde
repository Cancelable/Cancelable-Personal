public class ZombieManager {
  
  private int numZombiesPerWave;
  
  public ZombieManager() {
    numZombiesPerWave = 1; // keep as 1 so that initial wave can spawn
  }
  
  public void spawnZombie() { // spawns a zombie
    // first zombie
    if (numZombiesPerWave==1) {
      zombiesArray.add(new Zombie((int)random(5),REAL_WIDTH + TILE_WIDTH + (int)random(TILE_WIDTH * 3),DEFAULT_ZOMBIE));
    // rest of cases
    } else {
      zombiesArray.add(new Zombie());
    } // permanent
  }
  
  // expand on this
  public void spawnZombieWave() {
    //zombiesArray.add(new Zombie(3,600,DEFAULT_ZOMBIE)); // TEMPORARY ------ FOR TESTING
    totalWaveCount++;
    for (int i=0;i<numZombiesPerWave;i++) {
      spawnZombie();
      totalZombieCount++;
    }
    if (totalWaveCount>2) {numZombiesPerWave+=2;}
  }
  
  // decides if you need a new wave - ZOMBIE COUNT BASED
  public boolean shouldGetNewWave() {
    int numZombiesAlive = zombiesArray.size();
    if (numZombiesPerWave < 15 && numZombiesAlive <= 0) {
      return true; // true = needs new wave ; false = doesn't need new wave
    // makes one more zombie per wave after certain
    } else if (numZombiesAlive < 3 + (numZombiesPerWave-15)) {
      return true;
    } else {
      return false;
    }
  }
  
  public void drawZombies() {
    for (int i=0;i<zombiesArray.size();i++) {
      zombiesArray.get(i).drawZombie();
    }
  }
  
  public int getNumZombiesPerWave() {
    return numZombiesPerWave;
  }
  
  public void killDeadZombies() {
    for (int i=0;i<zombiesArray.size();i++) {
      if (zombiesArray.get(i).getHealth() <= 0) {
        money++; // 1 more money for every zombie killed
        zombiesArray.remove(i);
      }
    }
  }
  
  // run as periodic
  public void run() {
    if (shouldGetNewWave()) {
      spawnZombieWave();
    }
    for (int i=0;i<zombiesArray.size();i++) {
      zombiesArray.get(i).execute(map.getMapItself());
    }
    killDeadZombies();
    println(zombiesArray.size() + "zombies");
    println(projectiles.size() + "projectiles");
  }
  
}
