class Node {
  int x, y;
  Node prev;

  Node(int xcor, int ycor) {
    x = xcor;
    y = ycor;
    prev = null;
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
  Node getPrev() {
    return prev;
  }
  void setPrev(Node n) {
    prev = n;
  }
}

