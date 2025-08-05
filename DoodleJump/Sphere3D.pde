public class Sphere3D {
  
  float x, y, z, r;
  private color c;
  
  public Sphere3D(float x, float y, float z, float r, color c) {
    
  }
  
  public void drawSphere() {
    fill(c);
    pushMatrix();
    translate(x,y,z);
    sphere(r);
    popMatrix();
  }
  
}
