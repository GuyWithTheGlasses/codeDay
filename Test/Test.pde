PImage bg;
int rad = 10;
boolean[][] squares = new boolean[height / (2*rad)][width / (2*rad)];
boolean[] keys = new boolean[4];
Circle player = new Circle(rad, rad, rad, 0, 0, 0);
Rect piggyback = new Rect(-2*rad, 0, 2*rad, 2*rad, 0, 0, 255);
int step = 2*player.getR();

void setup() {
  for (int i = 0; i < keys.length; i++) {
    keys[i] = false;
  }
  size(1280, 720);
  bg= loadImage("crew.jpg");
  //player= loadImage("clyde.jpg");
   background (bg);
}

void draw() {
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
  //noStroke();
  fill(255);

  frameRate(30);
  piggyback.setX(player.getX());
  piggyback.setY(player.getY());
  if (keys[0]) {
    player.addY(-1*step);
    player.drawShape();
    piggyback.drawShape();
  }
  else if (keys[1]) {
    player.addX(-1*step);
    player.drawShape();
    piggyback.drawShape();
  }
  else if (keys[2]) {
    player.addY(step);
    player.drawShape();
    piggyback.drawShape();
  }
  else if (keys[3]) {
    player.addX(step);
    player.drawShape();
    piggyback.drawShape();
  }
  borderCheck(player);
  
}

void updateSquares() {
}

void fillShape(Shape sh) {
  sh.drawShape();
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

void borderCheck(Circle c) {
  if (c.getX()-c.getR() < 0) {
    c.setX(c.getR());
  }
  if (c.getY()-c.getR() < 0) {
    c.setY(c.getR());
  }
  if (c.getX() > width - c.getR()) {
    c.setX(width - c.getR());
  }
  if (c.getY() > height - c.getR()) {
    c.setY(height - c.getR());
  }
}

