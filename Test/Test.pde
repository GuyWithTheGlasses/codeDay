import java.util.*;
import java.io.*;

PImage bg; //background image
Image player; //player image
Monster orange, pink; //monster AI
Monster o2, p2; //follow the monsters to clean up their trails
int sidelen = 20; //length of one unit
int[][] squares; //array of units, each unit is sidelen*sidelen pixels
boolean[] keys = new boolean[4]; //keys being pressed
int step = sidelen; //distance player moves every time a key is pressed
int dir; //direction of player's movement, 0 = UP, 1 = LEFT, 2 = DOWN, 3 = RIGHT
Random rnd=new Random();

ArrayList<Node> path = new ArrayList<Node>(); 
//keeps track of the path Pac-Xon is drawing with Nodes containing x and y

PFrontier pf = new PFrontier(); //for fillBorder
Node current = null; //for fillBorder

void setup() {
  //Set all keys as not pressed
  for (int i = 0; i < keys.length; i++) {
    keys[i] = false;
  }
  size(1280, 720);
  bg = loadImage("crew.jpg"); 
  //background (bg);
  //background (75);
  fill(75);
  for(int i = 0 ; i < width ; i += sidelen){
    for(int j = 0 ; j < height ; j += sidelen){
      rect(i, j, sidelen, sidelen);
    }
  }

  orange = new Monster((rnd.nextInt(61)+1)*20, (rnd.nextInt(34)+1)*20, loadImage("orange_ghost.png"));
  pink = new Monster((rnd.nextInt(61)+1)*20, (rnd.nextInt(34)+1)*20, loadImage("pink_ghost.png"));

  squares = new int[width / sidelen][height / sidelen]; //0 = empty place; 1 = safe place; 2 = temp path 
  fill (0, 0, 205);
  //Drawing the border, which will always be there

  //drawing top and bottom borders
  for (int a = 0; a < width; a = a+sidelen) {
    rect(a, 0, sidelen, sidelen);
    rect (a, height - sidelen, sidelen, sidelen);
    squares[a/sidelen][0] = 1;
    squares[a/sidelen][(height - sidelen) / sidelen] = 1;
  }
  //drawing left and right borders
  for (int v = 0; v < height; v = v+sidelen) {
    rect (0, v, sidelen, sidelen);
    rect(width - sidelen, v, sidelen, sidelen);
    squares[0][v/sidelen] = 1;
    squares[(width - sidelen) / sidelen][v/sidelen] = 1;
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
  //background (bg);
  
  fill (0, 0, 205);
  //Drawing the border, which will always be there
/*
  //drawing top and bottom borders
  for (int a = 0; a < width; a = a+sidelen) {
    rect(a, 0, sidelen, sidelen);
    rect (a, height - sidelen, sidelen, sidelen);
    squares[a/sidelen][0] = 1;
    squares[a/sidelen][(height - sidelen) / sidelen] = 1;
  }
  //drawing left and right borders
  for (int v = 0; v < height; v = v+sidelen) {
    rect (0, v, sidelen, sidelen);
    rect(width - sidelen, v, sidelen, sidelen);
    squares[0][v/sidelen] = 1;
    squares[(width - sidelen) / sidelen][v/sidelen] = 1;
  }
  */
  Node tmp = updateSquares(); 
  //Set the square the player was just at to blue/green accordingly


  int prevcolor = squares[tmp.getX()][tmp.getY()];
  //For use when determining whether to fill

  //Update location of player
  if (keys[0]) {
    if (checkMove(0) || prevcolor != 2) {
      player.addY(-1*step);
      dir = 0;
      //System.out.println(checkMove(0));
    }
  } else if (keys[1]) {
    if (checkMove(1) || prevcolor != 2) {
      player.addX(-1*step);
      dir = 1;
      //System.out.println(checkMove(1));
    }
  } else if (keys[2]) {
    if (checkMove(2) || prevcolor != 2) {
      player.addY(step);
      dir = 2;
      //System.out.println(checkMove(2));
    }
  } else if (keys[3]) {
    if (checkMove(3) || prevcolor != 2) {
      player.addX(step);
      dir = 3;
      //System.out.println(checkMove(3));
    }
  }
  borderCheck(player); //Move player back inside frame if necessary

  int curcolor = squares[player.getX() / sidelen][player.getY() / sidelen];

  //Now we determine what needs to be done depending on the colors of the squares
  if (prevcolor == 1 && curcolor != 1) {
    //Make the corner of the shape green as well to enable filling algorithm later
    squares[tmp.getX()][tmp.getY()] = 2;
    path.add(new Node(tmp.getX(), tmp.getY()));
  } else if (prevcolor == 2 && curcolor == 1) {
    //We'll mark this square with a value of 5 to indicate that it is the solution point
    squares[player.getX() / sidelen][player.getY() / sidelen] = 5;
    path.add(new Node(player.getX() / sidelen, player.getY() / sidelen));

    Node start = path.get(0);
    Node end = path.get(path.size() - 1);

    //Convert the border to green (from 1 to 2)
    fillBorder(start.getX(), start.getY());

    //then fill in the appropriate squares inside that new green-bordered shape
    //by finding a starting point inside the shapes
    findAndFill();
  }

  player.drawImage();
  //printsq();
  fill(75);
  //noStroke();
  rect(orange.getX(), orange.getY(), sidelen, sidelen);
  rect(pink.getX(), pink.getY(), sidelen, sidelen);
  orange.drawImage(squares);
  pink.drawImage(squares);
  delay(50);
}

/*----------------------------- Methods used in draw() ----------------------------------*/

//updateSquares() redraws the blue and green squares of the path each time the player
//moves a square. It returns an Node so draw() can check if the player just stepped
//from a blue square to a green square. If so, then we need to fill the squares. 
Node updateSquares() {
  int px = player.getX();
  int py = player.getY();
  int sqcolor = squares[px / sidelen][py / sidelen];
  Node sq = new Node(px / sidelen, py / sidelen);
  if (sqcolor == 1) {
    fill(0, 0, 205);
    rect(px, py, sidelen, sidelen);
  } else if (sqcolor == 0 || sqcolor == 2) {
    squares[px / sidelen][py / sidelen] = 2;
    fill(0, 255, 0);
    rect(px, py, sidelen, sidelen);
    path.add(sq);
  }
  return sq;
}

//returns true if move is valid, returns false if our player would make an illegal move
//whether it be running into its own path or an enemy, in which case we have to implement death
//int d = direction of movement, 0 = UP, 1 = LEFT, 2 = DOWN, 3 = RIGHT
//Currently this only stops the player from moving backwards
boolean checkMove(int d) {
  int px = player.getX() / sidelen;
  int py = player.getY() / sidelen;
  if (px <= 0 || px >= width/sidelen - 1 || py <= 0 || py >= height/sidelen - 1)
    return true;

  boolean nextGreen = false;
  if (d == 0) {
    nextGreen = squares[px][py-1] == 2;
  } else if (d == 1) {
    nextGreen = squares[px-1][py] == 2;
  } else if (d == 2) {
    nextGreen = squares[px][py+1] == 2;
  } else if (d == 3) {
    nextGreen = squares[px+1][py] == 2;
  }
  return !(Math.abs(d - dir) == 2) && !nextGreen;
}

//Finds a path between the two squares at which our player left and went back into the blue squares
//Then fills that path with green squares to allow us to floodFill() properly later
void fillBorder(int x, int y) {
  Node start = new Node(x, y);
  start.setSteps(0);
  //This algorithm uses an A* seach for optimal runtime
  start.setPri(astarPri(start, path.get(path.size() - 1)));
  pf.add(start);

  while (!pf.isEmpty ()) {
    current = pf.remove();
    int cx = current.getX();
    int cy = current.getY();

    if (squares[cx][cy] == 5) {
      //If we've found the other end of the border, we trace back through our path
      //filling it in with green along the way
      Node t = current;
      while (t != null) {
        path.add(t);
        squares[t.getX()][t.getY()] = 2;
        t = t.getPrev();
      }

      //When that's done, all the squares that were marked as -1 are reverted back to 1
      for (int i = 0; i < squares.length; i++) {
        for (int j = 0; j < squares[i].length; j++) {
          if (squares[i][j] == -1) {
            squares[i][j] = 1;
            //printsq();
          }
        }
      }
      break;
    }

    //If we haven't solved it, we mark the current square as -1, or "visited"
    else if (squares[cx][cy] == 1) {
      squares[cx][cy] = -1;
      //printsq();
    }
    //and add all adjacent squares that meet the requirements
    addToFront(cx+1, cy);
    addToFront(cx-1, cy);
    addToFront(cx, cy+1);
    addToFront(cx, cy-1);
  }
}

/* -------------- Additional methods used in fillBorder ------------------*/
void addToFront(int tx, int ty) {
  //Also records the priority of the square being added
  Node tmp = null;

  //Out-of-bounds check
  if (tx < 0 || tx >= squares.length || ty < 0 || ty >= squares[0].length) {
    return;
  }
  //Add the Node and set all its information
  else if (squares[tx][ty] == 1 || squares[tx][ty] == 5) {
    tmp = new Node(tx, ty);
    tmp.setPrev(current);
    tmp.setSteps(current.getSteps() + 1);
    tmp.setPri(astarPri(tmp, path.get(path.size() - 1)));
    pf.add(tmp);
  }
}
int astarPri(Node a, Node dest) {
  return Math.abs((dest.getX() - a.getX())) + Math.abs((dest.getY() - a.getY())) + a.getSteps();
}
/*---------------------------------------------------------------------------*/

//Now we find a starting point for the floodFill (hence the name)
void findAndFill() {
  int minX = Integer.MAX_VALUE, minY = Integer.MAX_VALUE;
  //By finding the upper-left-most corner of the border, we can
  //lower the amount of times we have to loop to find a square 
  //inside of the shape that must be filled
  for (Node n : path) {
    if (n.getX() < minX) {
      minX = n.getX();
    }
    if (n.getY() < minY) {
      minY = n.getY();
    }
  }
  //Now we do the standard looping technique
  boolean found = false; //to be able to break out of both for loops
  for (int i = minX + 1; found != true && i < squares.length; i++) {
    for (int j = minY + 1; found != true && j < squares[i].length; j++) {   
      //printsq();
      boolean allGreen = false;
      //We check all 4 directions for green squares
      boolean up = false, down = false, left = false, right = false;
      int cx = i, cy = j;
      for (int u = 1; u <= cy; u++) {
        if (squares[cx][cy - u] == 2) {
          up = true;
          break;
        }
      }
      cx = i;
      cy = j;
      for (int d = 1; d < squares[i].length - cy; d++) {
        if (squares[cx][cy + d] == 2) {
          down = true;
          break;
        }
      }
      cx = i;
      cy = j;
      for (int l = 1; l <= cx; l++) {
        if (squares[cx - l][cy] == 2) {
          left = true;
          break;
        }
      }
      cx = i;
      cy = j;
      for (int r = 1; r < squares.length - cx; r++) {
        if (squares[cx + r][cy] == 2) {
          right = true;
          break;
        }
      }
      //If all 4 directions are green, then we're good!
      allGreen = up && down && left && right;
      if (allGreen) {
        found = true;
        floodFill(i, j);
      }
    }
  }
}

//Once we find a square inside the desired area with the previous algorithm
//we can floodFill starting from that square to make all of it blue.
void floodFill(int x, int y) {
  Frontier f = new Frontier();
  f.add(new Node(x, y));
  Node current = null;
  fill(0, 0, 205);

  while (!f.isEmpty ()) {
    current = f.remove();
    int cx = current.getX();
    int cy = current.getY();
    //If the square is valid for filling, we mark it for later
    if (squares[cx][cy] == 0 || squares[cx+1][cy] == 1) {
      squares[cx][cy] = 4; //aka "visited"
      // printsq();
    }
    //Then we add all the adjacent squares to the frontier, but only if they're blank or blue. 
    if (cx < squares.length - 1 && (squares[cx+1][cy] == 0 || squares[cx+1][cy] == 1)) {
      f.add(new Node(cx+1, cy));
    }
    if (cx > 0 && (squares[cx-1][cy] == 0 || squares[cx-1][cy] == 0)) {
      f.add(new Node(cx-1, cy));
    }
    if (cy < squares[cx].length - 1 && (squares[cx][cy+1] == 0 || squares[cx][cy+1] == 1)) {
      f.add(new Node(cx, cy+1));
    }
    if (cy > 0 && (squares[cx][cy-1] == 0 || squares[cx][cy-1] == 1)) {
      f.add(new Node(cx, cy-1));
    }
  }
  //When we're done, fill all the nodes we just visited as blue
  fill(0, 0, 205);
  for (int i = 0; i < squares.length; i++) {
    for (int j = 0; j < squares[i].length; j++) {
      if (squares[i][j] == 4) {
        squares[i][j] = 1;
        rect(i*sidelen, j*sidelen, sidelen, sidelen);
        //printsq();
      }
    }
  }
  //And fill in all nodes on the path as blue as well
  for (Node n : path) {
    squares[n.getX()][n.getY()] = 1;
    rect(n.getX()*sidelen, n.getY()*sidelen, sidelen, sidelen);
    //printsq();
  }
  path.clear();
}

/*------------- keyPressed/Released, borderCheck, and Utilities ----------------*/

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

//borderCheck(i) checks if the Node i is outside of the screen
//If so, it moves it back to the screen's border
boolean borderCheck(Image i) {
  boolean out = false;
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

void delay(int time) {
  try {
    Thread.sleep(time);
  } 
  catch (Exception e) {
  }
}

void printsq() {
  delay(50);
  for (int i = 0; i < squares[0].length; i++) {
    for (int j = 0; j < squares.length; j++) {
      System.out.printf("%2d ", squares[j][i]);
    }
    System.out.println();
  }
  System.out.println("\n");
}

