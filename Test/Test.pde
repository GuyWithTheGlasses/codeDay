import java.util.*;

PImage bg;
Image player;
int sidelen = 20;
int[][] squares; 
boolean[] keys = new boolean[4];
int step = sidelen;
//Circle player = new Circle(rad, rad, rad, 0, 0, 0);
Rect blueDrawer = new Rect(-1*sidelen, 0, sidelen, sidelen, 0, 0, 255);
Rect greenDrawer = new Rect(-1*sidelen, 0, sidelen, sidelen, 0, 255, 0);
ArrayList<Shape> path = new ArrayList<Shape>();

void setup() {
  for (int i = 0; i < keys.length; i++) {
    keys[i] = false;
  }
  size(1280, 720);
  bg = loadImage("crew.jpg");
  background (bg);

  squares= new int[height / sidelen][width / sidelen]; //0= empty place; 1=safe place; 2 = temp path 

  fill (0, 0, 205);
  //Drawing the border, which will always be there
  //fixed thing across
  for (int across=0; across<width; across=across+20) {
    rect(across, 0, 20, 20);
    rect (across, height-20, 20, 20);
    squares[0][across/20]=1;
    squares[(height-20)/20][across/20]=1;
  }

  //filled vertical
  for (int vert =0; vert <height; vert =vert+20) {
    rect (0, vert, 20, 20);
    rect (width -20, vert, 20, 20);
    squares[vert/20][0]=1;
    squares[vert/20][(width-20)/20]=1;
  }

  player = new Image(0, 0, loadImage("clyde.jpg"));
  player.drawImage();
}

void draw() {
  //noStroke();
  fill(255);
  frameRate(30);
  updateSquares();
  if (keys[0]) {
    player.addY(-1*step);
  } else if (keys[1]) {
    player.addX(-1*step);
  } else if (keys[2]) {
    player.addY(step);
  } else if (keys[3]) {
    player.addX(step);
  }
  borderCheck(player);
  player.drawImage();
  System.out.println(squares[player.getY()/20][player.getX()/20]);
}

void updateSquares() {
  int sqcolor = squares[player.getY() / 20][player.getX() / 20];
  if (sqcolor == 1) {
    blueDrawer.setXY(player.getX(), player.getY());
    blueDrawer.drawShape();
  } else if (sqcolor == 0) {
    greenDrawer.setXY(player.getX(), player.getY());
    greenDrawer.drawShape();
    squares[greenDrawer.getY()/20][greenDrawer.getX()/20]=2;
    path.add(greenDrawer);
  }
}

void sumSides() {
  int sum1 = 0;
  int sum2 = 0;
  int x1, y1, x2, y2;
  boolean side1 = false; //side1==true when we're adding to sum1
  for (int i = 1; i < squares.length; i++) {
    for (int j = 1; j < squares[i].length; j++) {
      if (squares[i][j] == 0) {
        if (side1) {
          sum1++;
          x1 = i;
          y1 = j;
        } else {
          sum2++;
          x2 = i;
          y2 = j;
        }
      }
      if (squares[i][j] == 2) {
        side1 = !side1;
        squares[i][j] = 1;
        blueDrawer.setXY(j*20, i*20);
        blueDrawer.drawShape();
      }
    }
  }
  if (sum1 < sum2) {
    //floodFill(x1, y1);
  } else {
    //floodFill(x2, y2);
  }
}
 
void floodFill(int x, int y){
  
}
 
void fillSquare() {
  int sqcolor = squares[player.getY() / 20][player.getX() / 20];
  if (sqcolor == 1) {
    for (int i = 0; i < path.size (); i++) {
      Shape sh = path.get(i);
      blueDrawer.setXY(sh.getX(), sh.getY());
      blueDrawer.drawShape();
    }
  }
}

void keyPressed() {    
  if (key == 'w' ||  key == 'W') {
    keys[0]=true;
  }
  if (key == 'a' || key == 'A') {
    keys[1]=true;
  }
  if (key == 's' || key == 'S') {
    keys[2]=true;
  }
  if (key == 'd' || key == 'D') {
    keys[3]=true;
  }
}
void keyReleased() {
  if (key == 'w' || key == 'W') {
    keys[0]=false;
  }
  if (key == 'a' || key == 'A') {
    keys[1]=false;
  }
  if (key == 's' || key == 'S') {
    keys[2]=false;
  }
  if (key == 'd' || key == 'D') {
    keys[3]=false;
  }
}

boolean borderCheck(Image i) {
  boolean out=false;
  if (i.getX()< 0) {
    i.setX(0);
    out=true;
  }
  if (i.getY()<0) {
    i.setY(0);
    out=true;
  }
  if (i.getX() > width - i.getW()) {
    i.setX(width - i.getW());
    out=true;
  }
  if (i.getY() > height - i.getH()) {
    i.setY(height - i.getH());
    out=true;
  }
  return out;
}

