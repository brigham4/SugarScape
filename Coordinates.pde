public class Coordinates{
  int x, y, w, h;
  
  public Coordinates (int x, int y, int w, int h){
  this.x = x;
  this.y = y;
  this.w = w;
  this.h = h;
  }
  public void display(){
     rect(x,y,w,h);
  }
}