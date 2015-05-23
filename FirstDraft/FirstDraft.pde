PImage bg;
int rad=10;
boolean [][] squares= new boolean [height/ (2*rad)][width/ (2*rad)];

void setup(){
  size(1280 ,720);
  bg= loadImage("crew.jpg");
  
}

void draw(){
  background (bg);
  fill (0,0,205);
  
  //fixed thing across
  for (int across=0; across<width; across=across+20){
     rect(across,0,20,20);
     rect (across, height-20,20,20);
  }
  
  //filled vertical
  for (int vert =0; vert <height; vert =vert+20){
    rect (0, vert, 20,20);
    rect (width -20, vert, 20,20); 
  }
}
