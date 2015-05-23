class Image{
  int x, y;
  PImage i;
  
  Image(int xcor, int ycor, PImage img){
    x = xcor;
    y = ycor;
    i = img;
  }
  
  int getX() {
    return x;
  }
  void setX(int a) {
    x = a;
  }

  int getY() {
    return y;
  }
  void setY(int b) {
    y = b;
  }
  
  void addX(int inc) {
    x = x + inc;
  }
  void addY(int inc) {
    y = y + inc;
  }
  
  void setImage(String s){
    i = loadImage(s);
  }
  void drawImage(){
    image(i, x, y);
  }
  
}
