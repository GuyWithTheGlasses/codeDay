import java.util.*;
import java.io.*;

PImage startscreen, backbutton; //background image

boolean startScreen = true;
boolean bgScreen = false;
boolean helpScreen = false;

void setup() {
  size(1280, 720);
  startscreen = loadImage("crew.jpg");
  backbutton= loadImage("backarrow.png");
}

void draw() {
  if (startScreen) {
    background(startscreen);
    createTitle();
    createStartButton();
    createHelpButton();
  }
}

void createTitle() {
  fill(255);
   rect((width-530)/2, height/2 , 550, 100, 6);
   textSize(100);
   textAlign(CENTER, CENTER);
   fill(0);
   text("Pac-Xon", (width+10)/2, (height +75)/2);
}

void createStartButton(){
  fill(255);
   rect(width/4 - 100 , 3 * height/4 , 350, 100,6);
   textSize(80);
   textAlign(LEFT, TOP);
   fill(0);
   text("START", width/ 4 - 60 , 3* height/4);
}

void createHelpButton(){
  fill(255);
   rect(2 * width/3 -40 , 3 * height/4 , 450 , 100,6);
   textSize(60);
   textAlign(LEFT, TOP);
   fill(0);
   text("HOW TO PLAY",  2 * width/ 3 - 30  , 3* height/4 + 10);
}
