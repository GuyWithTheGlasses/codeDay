abstract class Shape {
  int x, y;
  int col1, col2, col3;
  //Shape prev;

  Shape(int xcor, int ycor, int c1, int c2, int c3) {
    x = xcor;
    y = ycor;
    col1 = c1;
    col2 = c2;
    col3 = c3;
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
  
  void setXY(int xcor, int ycor){
    x = xcor;
    y = ycor;
  }
  /*
  Shape getPrev(){
    return prev;
  }
  void setPrev(Shape p){
    prev = p;
  }
  */

  abstract void drawShape();
}
