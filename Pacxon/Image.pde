class Image{
  int x, y, w, h;
  PImage i;
  
  Image(int xcor, int ycor, PImage img){
    x = xcor;
    y = ycor;
    i = img;
    w = i.width;
    h = i.height;
  }
  
  int getX() {
    return x;
  }
  void setX(int xcor) {
    x = xcor;
  }

  int getY() {
    return y;
  }
  void setY(int ycor) {
    y = ycor;
  }
  
  void addX(int inc) {
    x = x + inc;
  }
  void addY(int inc) {
    y = y + inc;
  }
  
  int getW() {
    return w;
  }
  void setW(int wid) {
    w = wid;
  }
  
  int getH() {
    return h;
  }
  void setH(int hei) {
    y = hei;
  }

  
  void setImage(String s){
    i = loadImage(s);
    w = i.width;
    h = i.height;
  }
  void drawImage(){
    image(i, x, y);
  }
  
}
