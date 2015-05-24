class BasicMonster extends Monster{
 int x,y;
 PImage i;
 
 BasicMonster(int x,int y, PImage i){
    super (x,y,i); 
 }
 
 void getX(){
    super.getX(); 
 }
 
 void getY(){
    super.getY(); 
 }
 
 void drawImage(){
    image(i,x,y); 
 }
 
 void move();
   
}
