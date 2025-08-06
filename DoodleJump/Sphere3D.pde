public class Sphere3D {
  
  float x, y, z, r;
  private color c;
  
  public Sphere3D(float x, float y, float z, float r, color c) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.r = r;
    this.c = c;
  }
  
  public void drawSphere() {
    fill(c);
    pushMatrix();
    translate(x,y,z);
    sphere(r);
    popMatrix();
  }
  
}
