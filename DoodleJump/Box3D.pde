public class Box3D {
  
  public float x, y, z;
  public float w, h, l;
  public color c;
  
  public Box3D(float x, float y, float z, float w, float h, float l, color c) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.l = l;
    this.c = c;
  }
  
  public void drawBox() {
    fill(c);
    pushMatrix();
    translate(x,y,z);
    box(w,h,l);
    popMatrix();
  }
  
}
