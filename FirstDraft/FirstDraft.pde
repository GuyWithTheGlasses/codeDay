PImage bg;
int rad=10;
int [][] squares= new int [height/ (2*rad)][width/ (2*rad)];
BasicMonster orange,pink;

void setup(){
  size(1280 ,720);
  bg = loadImage("crew.jpg");
  orange = new BasicMonster(500,500,loadImage("orange_ghost.png"));
}

void draw(){
  background (bg);
  fill (0,0,205);
  
  //fixed thing across
  for (int across=0; across<width; across=across+20){
     rect(across,0,20,20);
     squares[0][across]=
     rect (across, height-20,20,20);
  }
  
  //filled vertical
  for (int vert =0; vert <height; vert =vert+20){
    rect (0, vert, 20,20);
    rect (width -20, vert, 20,20); 
  }
  
  orange.drawImage();
  delay(100);
}
