import java.util.*;

class Monster {
  int x, y, w, h, xdir, ydir, rad, xspeed, yspeed, startdir;
  PImage i;
  Random rand= new Random();

  Monster(int xcor, int ycor, PImage img) {
    x = xcor;
    y = ycor;
    i = img;
    w = i.width;
    h = i.height;
    rad=w;
    xspeed=20;
    yspeed=20;
    startdir();
  }
  
  Monster(int xcor, int ycor){
    x = xcor;
    y = ycor;
    i = null;
    xspeed = 20;
    yspeed = 20;
  }

  void startdir() {
    startdir=rand.nextInt(4);
    if (startdir == 0) {
      xdir=-1;
      ydir=-1;
    } else if (startdir == 1) {
      xdir=1;
      ydir=-1;
    } else if (startdir == 2) {
      xdir=-11;
      ydir=1;
    } else if (startdir == 3) {
      xdir=1;
      ydir=-1;
    }
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


  void setImage(String s) {
    i = loadImage(s);
    w = i.width;
    h = i.height;
  }
  void drawImage(int [][] squares) {
    autoMove(squares);
    collision(squares);
    image(i, x, y);
  }

  void autoMove(int[][] squares ) {
    x=x+ (xspeed * xdir);
    y= y + (yspeed* ydir);
    try {
      if (squares[x/20-1][y/20] ==1|| squares[x/20+1][y/20] ==1) {
        xdir*=-1;
      }
      if (squares[x/20][y/20-1] ==1|| squares[x/20][y/20+1] ==1) {
        ydir*=-1;
      }
    }
    catch(Exception e) {
      System.out.println("lol");
    }
  }

  void collision (int[][] squares) {
    try {
      if (squares[x/20-1][y/20] ==2|| squares[x/20+1][y/20] ==2) {
        xdir*=-1;
      }
      if (squares[x/20][y/20-1] ==2|| squares[x/20][y/20+1] ==2) {
        ydir*=-1;
      }
    } 
    catch(Exception e) { 
      System.out.println("D:");
    }
  }
}

