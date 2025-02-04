public class ZombieManager {
  
  private int numZombiesPerWave;
  
  public ZombieManager() {
    numZombiesPerWave = 1; // keep as 1 so that initial wave can spawn
  }
  
  public void spawnZombie() { // spawns a zombie
    zombiesArray.add(new Zombie()); // permanent
    // temps:
    zombiesArray.add(new Zombie(0));
    zombiesArray.add(new Zombie(1));
    zombiesArray.add(new Zombie(2));
    zombiesArray.add(new Zombie(3));
    zombiesArray.add(new Zombie(4));
  }
  
  public void spawnZombieWave() {
    //money += 5; // 5 new coins every new wave
    //System.out.println("spawned new zombie wave");
    //System.out.println("length of array" + zombiesArray.size());
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
  }
  
}
