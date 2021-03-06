PImage bg;
int rad=10;
int sidelen=20;
int[][] squares; //0 = empty place; 1 = safe place; 2 = temp path asicMonster orange,pink;
boolean gamePlaying=false;
BasicMonster orange, pink;
Random rnd=new Random();

void setup(){
  size(1280 ,720);
  bg = loadImage("crew.jpg");
  orange = new BasicMonster((rnd.nextInt(61)+1)*20 ,(rnd.nextInt(34)+1)*20  ,loadImage("orange_ghost.png"));
  pink = new BasicMonster((rnd.nextInt(61)+1)*20,(rnd.nextInt(34)+1)*20,loadImage("pink_ghost.png"));
}

void draw(){
  background (bg);
  squares= new int[width / sidelen][height / sidelen];
  fill (0,0,205);
  
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
  fill(0,205,0);
  for (int b = 20; b < width-20; b = b+sidelen) {
    rect(b, 80, sidelen, sidelen);
    squares[b/sidelen][4] = 2;
    squares[0][4]=1;
    squares[63][4]=1;
}
     
  orange.drawImage(squares);
  pink.drawImage(squares);
  delay(100);
}
