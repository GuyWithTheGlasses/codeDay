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
  orange = new BasicMonster((rnd.nextInt(62)+1)*20 ,(rnd.nextInt(34)+1)*20  ,loadImage("orange_ghost.png"));
  pink = new BasicMonster((rnd.nextInt(62)+1)*20,(rnd.nextInt(34)+1)*20,loadImage("pink_ghost.png"));
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
  for (int i=0; i<squares.length;i++){
   rect(i*20, 80, sidelen, sidelen);
   rect(i*20, 100, sidelen, sidelen);
   squares[i][4]=2;
   squares[i][5]=2;
  }
     
  orange.drawImage(squares);
  pink.drawImage(squares);
  delay(100);
}
