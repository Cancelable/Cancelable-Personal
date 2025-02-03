public class ZombieManager {
  
  private int numZombiesPerWave;
  
  public ZombieManager() {
    numZombiesPerWave = 0;
  }
  
  public void spawnZombie() { // spawns a zombie
    zombiesArray.add(new Zombie());
  }
  
  public void spawnZombieWave() {
    totalWaveCount++;
    for (int i=0;i<numZombiesPerWave;i++) {
      spawnZombie();
      totalZombieCount++;
    }
  }
  
  // decides if you need a new wave - ZOMBIE COUNT BASED
  public boolean shouldGetNewWave() {
    int numZombiesAlive = zombiesArray.size();
    if (numZombiesPerWave < 15 && numZombiesAlive <= 0) {
      return true; // true = needs new wave ; false = doesn't need new wave
    } else if (numZombiesAlive < 3 + (numZombiesPerWave-15)) {
      return true;
    } else {
      return false;
    }
  }
  
  public int getNumZombiesPerWave() {
    return numZombiesPerWave;
  }
  
  // run as periodic
  public void run() {
    if (shouldGetNewWave()) {
      spawnZombieWave();
    }
  }
  
  
}
