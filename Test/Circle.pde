class Circle extends Shape {
  int r;

  Circle(int xcor, int ycor, int rad, int c1, int c2, int c3) {
    super(xcor, ycor, c1, c2, c3);
    r = rad;
  }

  int getR() {
    return r;
  }
  void setR(int rad) {
    r = rad;
  }

  void drawShape() {
    fill(col1, col2, col3);
    ellipse(x, y, 2*r, 2*r);
  }
  
}

