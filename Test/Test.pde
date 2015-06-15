import java.util.*;
import java.io.*;

PImage startscreen, backbutton, backarrow,bg; //background image

boolean startScreen = true;
boolean bgScreen = false;
boolean helpScreen = false;

int startboxX, startboxY, helpboxX, helpboxY;

void setup() {
  size(1280, 720);

  startboxX = width/4 - 100;
  startboxY =  3 * height/4 ;
  helpboxX = 2 * width/3 -40;
  helpboxY = 3 * height/4 ;

  bg=startscreen = loadImage("crew.jpg");
  backbutton= loadImage("backarrow.png");
}

void draw() {
  if (startScreen) {
    background(startscreen);
    createTitle();
    hoverMenuScreen();
    clickStart();
    clickHelp();
  }
  
  if(helpScreen){
    hoverBack();
    clickBack();
  }
}

//--------------create------------------

void createTitle() {
  fill(255);
  rect((width-530)/2, height/2, 550, 100, 6);
  textSize(100);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Pac-Xon", (width+10)/2, (height +75)/2);
}

void createStartButton() {
  rect(startboxX, startboxY, 350, 100, 6);
  textSize(80);
  textAlign(LEFT, TOP);
  fill(0);
  text("START", width/ 4 - 60, 3* height/4);
}

void createHelpButton() {

  rect(helpboxX, helpboxY, 450, 100, 6);
  textSize(60);
  textAlign(LEFT, TOP);
  fill(0);
  text("HOW TO PLAY", 2 * width/ 3 - 30, 3* height/4 + 10);
}

void createBack() {
  ellipse(30, 30, 50, 50);
  backarrow = loadImage("arrow.png");
  image(backarrow, 5, 5, 50, 50);
}

//------------hoverness----------------
boolean overStart() {
  if ((mouseX >= startboxX && mouseX <= (startboxX + 350)) && (mouseY >= startboxY && mouseY <= (startboxY + 100))) {
    return true;
  }
  return false;
}

boolean overHelp() {
  if ((mouseX >= helpboxX && mouseX <= (helpboxX + 450)) && (mouseY >= helpboxY && mouseY <= (helpboxY + 100))) {
    return true;
  }
  return false;
}

boolean overBack() {
  if ((mouseX >= 5 && mouseX <= 55) && (mouseY >= 5 && mouseY <= 55)) {
    return true;
  }
  return false;
}

void hoverMenuScreen() {
  if (overStart()) {
    fill(0, 200, 0, 50);
    createStartButton();
  } else {
    fill(255);
    createStartButton();
  }
  if (overHelp()) {
    fill(200, 0, 0, 50);
    createHelpButton();
  } else {
    fill(255);
    createHelpButton();
  }
}

void hoverBack() {
  if (overBack()) {
    fill(180, 0, 0); 
    createBack();
  } else {
    fill(255);
    createBack();
  }
} 

//---------clicked------------------
void clickStart() {
  if ((mousePressed && (mouseButton == LEFT)) && overStart()) {
    startScreen = false;
    bgScreen = true;
    helpScreen = false;
  }
}

void clickHelp() {
  if ((mousePressed && (mouseButton == LEFT)) && overHelp()) {
    startScreen = false;
    bgScreen = false;
    helpScreen = true;
    image(bg, 0, 0);
    createBack();
    fill(255);
    rect(100, height/2 + 50, 1080, 200, 6);
    rules();
  }
}

void clickBack() {
  if ((mousePressed && (mouseButton == LEFT)) && overBack()) {
      startScreen = true;
      bgScreen = false;
      helpScreen = false;
  }
}

//---------------Rules of the Game---------------

void rules(){
  int firstLine=height/2 + 60;
  int i=15;
  fill(0);
  textAlign(CENTER, CENTER);
  textSize (18);
  text("Rules of Pac-Xon", width/2, firstLine);
  textSize(13);
  text("Use the W,A,S, and D keys to move Thluffy SinClair around the field.", width/2,firstLine+ i);
  text("The safe zone is the blue squares. Thluffy may freely wonder about this area.", width/2,firstLine+ 2* i);
  text("Thluffy will draw a path (the green squares) on uncharted area (the gray squares).", width/2,firstLine+ 3* i);
  text("If you have successfully made a path from one blue square to another square, then the area without a monster will fill.", width/2,firstLine+ 4*i);
  text("If there are monsters on both sides of the path, then only the path will turn into blue squares.", width/2,firstLine+ 5 *i);
  text("However, if a monster hits your path before you make it to another blue square, then you will loose a life.", width/2,firstLine+ 6*i);
  text("The goal of the game is to fill up AT LEAST 80% of the field with blue squares.", width/2,firstLine+ 7* i);
  text("Once you have reached 80%, you will automatically advanced to the next level.", width/2,firstLine+ 8*i);
  text("good Luck! May the odds be ever in your favor!", width/2,firstLine+ 9*i);
}
