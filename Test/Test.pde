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
    rect (50, 50, 700, 700, 6, 6, 6, 6);
    //Rules();
  }
}

void clickBack() {
  if ((mousePressed && (mouseButton == LEFT)) && overBack()) {
    if (helpScreen == true) { 
      startScreen = true;
      bgScreen = false;
      helpScreen = false;
    }
  }
}

