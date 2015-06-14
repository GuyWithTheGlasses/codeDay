PImage bg;
int rad=10;
int sidelen=20;
int [][] squares= new int[width / sidelen][height / sidelen];
BasicMonster orange,pink;

void setup(){
  size(1280 ,720);
  bg = loadImage("crew.jpg");
  orange = new BasicMonster(500,500,loadImage("orange_ghost.png"));
}

void draw(){
  background (bg);
  fill (0,0,205);
  
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

  orange.drawImage();
  delay(100);
}
