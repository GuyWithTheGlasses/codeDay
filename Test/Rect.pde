class Rect extends Shape {
  int w, h;

  Rect(int xcor, int ycor, int wid, int hei, int c1, int c2, int c3) {
    super(xcor, ycor, c1, c2, c3);
    w = wid;
    h = hei;
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
    h = hei;
  }

  void drawShape() {
    fill(col1, col2, col3);
    rect(x, y, w, h);
  }
  
}

