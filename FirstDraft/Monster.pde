abstract class Monster {
  int x, y, w, h;
  PImage i;

  Monster(int x, int y, PImage i) {
    this.x=x;
    this.y=y;
    this.i= i;
    w=i.width;
    w=i.height;
  }

  void getX() {
    return x;
  }

  void getY() {
    return y;
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
   
  void drawImage() {
    image(i, x, y);
  }

  abstract void collison();
  abstract void move();
}

