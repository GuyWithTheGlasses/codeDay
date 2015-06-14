PImage bg;
int rad=10;
int sidelen=20;
int[][] squares;
BasicMonster orange,pink;

void setup(){
  size(1280 ,720);
  bg = loadImage("crew.jpg");
  orange = new BasicMonster(500,500,loadImage("orange_ghost.png"));
}

void draw(){
  background (bg);
  fill (0,0,205);
  
  squares = new int[width / sidelen][height / sidelen]; //0 = empty place; 1 = safe place; 2 = temp path 
  fill (0, 0, 205);
  //Drawing the border, which will always be there

  //drawing top and bottom borders
  for (int a = 0; a < width; a = a+sidelen) {
    rect(a, 0, sidelen, sidelen);
    rect (a, 20, sidelen, sidelen);
    rect (a, height - 2 * sidelen, sidelen, sidelen);
    rect (a, height - sidelen, sidelen, sidelen);
    squares[a/sidelen][0] = 1;
    squares[a/sidelen][1] = 1;
    squares[a/sidelen][(height - 2 * sidelen) / sidelen] = 1;
    squares[a/sidelen][(height - sidelen) / sidelen] = 1;
  }
  //drawing left and right borders
  for (int v = 0; v < height; v = v+sidelen) {
    rect (0, v, sidelen, sidelen);
    rect(width - sidelen, v, sidelen, sidelen);
    squares[0][v/sidelen] = 1;
    squares[(width - sidelen) / sidelen][v/sidelen] = 1;
  }
  
  for (int i = 0; i < squares.length; i++) {
   for (int j = 0; j < squares[i].length; j++) {
   System.out.print(squares[i][j] + " ");
   }
   System.out.println();
   }
   System.out.println("End" + "\n");
   
  orange.drawImage(squares);
  delay(100);
}
