import java.util.*;
import java.io.*;

PImage bg; //background image
Image player; //player image
int sidelen = 20; //length of one unit
int[][] squares; //array of units, each unit is sidelen*sidelen pixels
boolean[] keys = new boolean[4]; //keys being pressed
int step = sidelen; //distance player moves every time a key is pressed
int dir; //direction of player's movement, 0 = UP, 1 = LEFT, 2 = DOWN, 3 = RIGHT

ArrayList<Node> path = new ArrayList<Node>(); 
//keeps track of the path Pac-Xon is drawing with Nodes containing x and y
boolean solved = false; //for fillBorder

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
  Node tmp = updateSquares(); 
  //Set the square the player was just at to blue/green accordingly
  
  boolean wasGreen = (squares[tmp.getX()][tmp.getY()] == 2); 
  //For use when determining whether to fill

  //Update location of player
  if (keys[0]) {
    if (checkMove(0) || !wasGreen) {
      player.addY(-1*step);
      dir = 0;
      //System.out.println(checkMove(0));
    }
  } else if (keys[1]) {
    if (checkMove(1) || !wasGreen) {
      player.addX(-1*step);
      dir = 1;
      //System.out.println(checkMove(1));
    }
  } else if (keys[2]) {
    if (checkMove(2) || !wasGreen) {
      player.addY(step);
      dir = 2;
      //System.out.println(checkMove(2));
    }
  } else if (keys[3]) {
    if (checkMove(3) || !wasGreen) {
      player.addX(step);
      dir = 3;
      //System.out.println(checkMove(3));
    }
  }
  borderCheck(player); //Move player back inside frame if necessary

  //If we just went from a green square to a blue square, then we need to fill some shape.
  if (wasGreen && squares[player.getX() / sidelen][player.getY() / sidelen] == 1) {
    Node start = path.get(0);
    Node end = path.get(path.size() - 1);
    
    //Convert the border to green (from 1 to 2)
    fillBorder(start.getX(), start.getY(), end.getX(), end.getY());
    
    //then fill in the appropriate squares inside that new green-bordered shape
    convertBlue();
  }
  
  player.drawImage();
  //System.out.println(player.getX() / sidelen + ", " + player.getY() / sidelen); //testing purposes
  for(int i = 0 ; i < squares[0].length ; i++){
    for(int j = 0 ; j < squares.length ; j++){
       System.out.printf("%2d " , squares[j][i]);
    }
    System.out.println();
  }
  System.out.println("\n");
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
  } else if (sqcolor == 0) {
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


//Takes the border of the shape Pac-Xon has drawn that is still blue(1) and
//converts it to green(2). This is done so the algorithm for filling in actually works. 
//x and y are the start point, sx and sy are the solution point
void fillBorder(int x, int y, int sx, int sy) {

  //We know the points at which Pac-Xon left and came back to the blue squares. 
  //So we can do a breadth-first search to always return the shortest path between those 2,
  //which is the line that must be turned blue.
  Frontier f = new Frontier();
  f.add(new Node(x, y));
  Node current = null;
  
  while (!f.isEmpty ()) {
    current = f.remove();
    int cx = current.getX();
    int cy = current.getY();
    //System.out.println(cx + ", " + cy);
    if (cx == sx && cy == sy) {
      //If we've reached the other endpoint of the border
      //Trace back through the path and make the border green
      Node t = current;
      while (t != null) {
        path.add(t);
        squares[t.getX()][t.getY()] = 2;
        t = t.getPrev();
      }
      //And reset all the squares we marked as "visited" back to blue
      for (int i = 0; i < squares.length; i++) {
        for (int j = 0; j < squares[i].length; j++) {
          if (squares[i][j] == -1) {
            squares[i][j] = 1;
          }
        }
      }
      break;
    }

    //If we haven't solved it, we do our usual business  
    if (squares[cx][cy] == 1) {
      squares[cx][cy] = -1;
    }
    Node tmp;
    if (cx < squares.length - 1 && squares[cx+1][cy] == 1) {
      tmp = new Node(cx+1, cy);
      tmp.setPrev(current);
      f.add(tmp);
    }
    if (cx > 0 && squares[cx-1][cy] == 1) {
      tmp = new Node(cx-1, cy);
      tmp.setPrev(current);
      f.add(tmp);
    }
    if (cy < squares[cx].length - 1 && squares[cx][cy+1] == 1) {
      tmp = new Node(cx, cy+1);
      tmp.setPrev(current);
      f.add(tmp);
    }
    if (cy > 0 && squares[cx][cy-1] == 1) {
      tmp = new Node(cx, cy-1);
      tmp.setPrev(current);
      f.add(tmp);
    }
  }
}

//We now convert all the necessary squares to blue
//This is done by checking if, traveling in all 4 directions from a square,
//we eventually hit a green square
void convertBlue() {
  for (int i = 0; i < squares.length; i++) {
    for (int j = 0; j < squares[i].length; j++) {
      boolean allGreen = false;
      //Now we check all 4 directions for green squares
      boolean up = false, down = false, left = false, right = false;
      int cx = i, cy = j;
      for (int u = 1; u <= cy; u++) {
        if (squares[cx][cy - u] == 2) {
          up = true;
          break;
        }
      }
      //cx = i;
      cy = j;
      for (int d = 1; d < squares[i].length - cy; d++) {
        if (squares[cx][cy + d] == 2) {
          down = true;
          break;
        }
      }
      //cx = i;
      cy = j;
      for (int l = 1; l <= cx; l++) {
        if (l < cx && squares[cx - l][cy] == 2) {
          left = true;
          break;
        }
      }
      cx = i;
      //cy = j;
      for (int r = 1; r < squares.length - cx; r++) {
        if (squares[cx + r][cy] == 2) {
          right = true;
          break;
        }
      }

      allGreen = up && down && left && right;
      if (allGreen) {
        squares[i][j] = 1;
        fill(0, 0, 205);
        rect(i*sidelen, j*sidelen, sidelen, sidelen);
      }
    }
  }
  //Reset all the squares on the path to blue as well
  for(Node n: path){
    squares[n.getX()][n.getY()] = 1;
    fill(0, 0, 205);
    rect(n.getX()*sidelen, n.getY()*sidelen, sidelen, sidelen);
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

