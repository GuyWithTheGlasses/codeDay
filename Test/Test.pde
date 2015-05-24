import java.util.*;

PImage bg; //background image
Image player; //player image
int sidelen = 20; //length of one unit
int[][] squares; //array of units, each unit is sidelen*sidelen pixels
boolean[] keys = new boolean[4]; //keys being pressed
int step = sidelen; //distance player moves every time a key is pressed
int dir; //direction of player's movement, 0 = UP, 1 = LEFT, 2 = DOWN, 3 = RIGHT

//These two "Drawers" are here to draw the blue/green paths 
//There are probably easier ways to do this but it works so 
Rect blueDrawer = new Rect(-1*sidelen, 0, sidelen, sidelen, 0, 0, 205); 
Rect greenDrawer = new Rect(-1*sidelen, 0, sidelen, sidelen, 0, 255, 0);
ArrayList<Shape> path = new ArrayList<Shape>();

void setup() {
  //Set all keys as not pressed
  for (int i = 0; i < keys.length; i++) {
    keys[i] = false;
  }
  size(1280, 720);
  bg = loadImage("crew.jpg"); 
  background (bg);

  squares = new int[width / sidelen][height / sidelen]; //0 = empty place; 1 = safe place; 2 = temp path 
  fill (0, 0, 205);
  //Drawing the border, which will always be there
  //srawing across
  for (int across = 0; across < width; across = across+sidelen) {
    rect(across, 0, sidelen, sidelen);
    rect(across, height - sidelen, sidelen, sidelen);
    squares[across / sidelen][0] = 1;
    squares[across / sidelen][(height - sidelen) / sidelen] = 1;
  }
  //drawing vertical
  for (int vert = 0; vert < height; vert = vert+sidelen) {
    rect (0, vert, sidelen, sidelen);
    rect (width - sidelen, vert, sidelen, sidelen);
    squares[0][vert / sidelen] = 1;
    squares[(width - sidelen) / sidelen][vert / sidelen] = 1;
  }

  player = new Image(0, 0, loadImage("clyde.jpg"));
  player.drawImage();
  dir = 0;
  /*
  for (int i = 0; i < squares.length; i++) {
   for (int j = 0; j < squares[i].length; j++) {
   System.out.print(squares[i][j] + " ");
   }
   System.out.println();
   }
   System.out.println("End" + "\n");
   */
}


void draw() {
  frameRate(30);
  Image tmp = updateSquares(); 
  //Set the square the player was just at to blue/green accordingly

  //Update location of player
  boolean wasGreen = (squares[tmp.getX()][tmp.getY()] == 2); 
  //System.out.println(wasGreen);
  if (keys[0]) {
    if (checkMove(0) || !wasGreen) {
      player.addY(-1*step);
      dir = 0;
      System.out.println(checkMove(0));
    }
  } else if (keys[1]) {
    if (checkMove(1) || !wasGreen) {
      player.addX(-1*step);
      dir = 1;
      System.out.println(checkMove(1));
    }
  } else if (keys[2]) {
    if (checkMove(2) || !wasGreen) {
      player.addY(step);
      dir = 2;
      System.out.println(checkMove(2));
    }
  } else if (keys[3]) {
    if (checkMove(3) || !wasGreen) {
      player.addX(step);
      dir = 3;
      System.out.println(checkMove(3));
    }
  }
  borderCheck(player); //Move player back inside frame if necessary

  //tmp is holding the previous location of player
  if (wasGreen && squares[player.getX() / sidelen][player.getY() / sidelen] == 1) {
    fill(0, 0, 205);
    sumAndFill(); //If we just went from path back to safe squares, fill in the appropriate area
  }
  player.drawImage();
  //System.out.println(player.getX() / sidelen + ", " + player.getY() / sidelen); //testing purposes
}

/*------------------------ Methods used in draw() ------------------------------*/

//updateSquares() redraws the blue and green squares of the path each time the player
//moves a square. It returns an Image (because we were too lazy to make another class
//to hold an x and y coordinate) so draw() can check if the player just stepped
//from a blue square to a green square. If so, then we need to sumAndFill().
Image updateSquares() {
  int px = player.getX();
  int py = player.getY();
  int sqcolor = squares[px / sidelen][py / sidelen];
  if (sqcolor == 1) {
    blueDrawer.setXY(px, py);
    blueDrawer.drawShape();
  } else if (sqcolor == 0) {
    greenDrawer.setXY(px, py);
    greenDrawer.drawShape();
    squares[px / sidelen][py / sidelen] = 2;
    path.add(greenDrawer);
  }
  return new Image(px / sidelen, py / sidelen);
}

//returns true if move is valid, returns false if our player would make an illegal moveddd
//whether it be running into its own path or an enemy, in which case we have to implement death
//int d = direction of movement, 0 = UP, 1 = LEFT, 2 = DOWN, 3 = RIGHT
//Currently this only stops the player from moving backwards
boolean checkMove(int d) {
  if (d == 0  && dir == 2){
    return false;
  } else if (d == 1 && dir == 3){
    return false;
  } else if (d == 2 && dir == 0){
    return false;
  } else if (d == 3 && dir == 1){
    return false;
  } else {
    return true;
  }
}

//sumAndFill() sums the number of squares on both sides of the green path drawm by Pac-Xon. 
//Then, depending on which side is smaller, it uses floodFill() to fill the side with less squares
//with blue squares. Along the way, it turns the green path into blue squares as well. 
void sumAndFill() {
  int sum1 = 0;
  int sum2 = 0;
  int x1 = 0, y1 = 0, x2 = 0, y2 = 0;
  boolean side1 = true; //side1==true when we're adding to sum1
  for (int j = 1; j < squares[0].length - 1; j++) {
    for (int i = 1; i < squares.length - 1; i++) {
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
      } else if (squares[i][j] == 2) {
        while (squares[i][j] == 2) {
          squares[i][j] = 1;
          rect(i*sidelen, j*sidelen, sidelen, sidelen);
          i++;
        }
        side1 = !side1;
      }
      /*
      System.out.println("Start");
       for (int m = 0; m < squares[0].length; m++) {
       for (int n = 0; n < squares.length; n++) {
       System.out.print(squares[n][m] + " ");
       }
       System.out.println();
       }
       System.out.println("End" + "\n");
       */
    }
  }
  if (sum1 < sum2) {
    floodFill(x1, y1);
  } else {
    floodFill(x2, y2);
  }
}

//floodFill(x,y) fills an area of the grid with blue squares. It starts from any 
//point whose value is currently 0 and turns all the squares connected to it blue. 
//This is done using a breadth-first search method. 
void floodFill(int x, int y) {
  fill(0, 0, 205);
  Frontier f = new Frontier();
  f.add(new Image(x, y));

  int tx = 0, ty = 0;
  Image current = null;

  while (!f.isEmpty ()) {
    current = f.remove();
    int cx = current.getX();
    int cy = current.getY();
    //System.out.println(cx + ", " + cy);
    if (squares[cx][cy] == 1) {
      f.remove();
    } else {
      squares[cx][cy] = 1;
      rect(cx*sidelen, cy*sidelen, sidelen, sidelen);
    }
    if (cx < squares.length - 1 && squares[cx+1][cy] == 0) {
      f.add(new Image(cx+1, cy));
    }
    if (cx > 0 && squares[cx-1][cy] == 0) {
      f.add(new Image(cx-1, cy));
    }
    if (cy < squares[cx].length - 1 && squares[cx][cy+1] == 0) {
      f.add(new Image(cx, cy+1));
    }
    if (cy > 0 && squares[cx][cy-1] == 0) {
      f.add(new Image(cx, cy-1));
    }
    /*
    System.out.println("Start");
     for (int j = 0; j < squares[0].length; j++) {
     for (int i = 0; i < squares.length; i++) {
     System.out.print(squares[i][j] + " ");
     }
     System.out.println();
     }
     System.out.println("End" + "\n");
     */
  }
}

/*------------------ keyPressed/Released and borderCheck ----------------------*/

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


//borderCheck(i) checks if the Image i is outside of the screen
//If so, it moves it back to the screen's border
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

