class Node {
  int x, y;
  Node prev;
  int priority;
  int steps;

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
  
  //These are only used when we create nodes for fillBorder, an A* search.
  int getPri() {
    return priority;
  }
  void setPri(int p) {
    priority = p;
  }

  int getSteps() {
    return steps;
  }
  void setSteps(int s) {
    steps = s;
  }
}

