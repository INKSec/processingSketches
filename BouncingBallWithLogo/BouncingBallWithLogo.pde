import processing.sound.*;

int xPos=320;
int yPos=240;
int zPos=1;

int xSpeed=2;
int ySpeed=2;
int zSpeed=2;

int xDirection=1;
int yDirection=1;
int zDirection=1;

PImage texture;
PShape logo;

float rotationSphere=0;

SoundFile theSound;
// end of variables

void setup() {

  //size (640, 480, P3D);
  smooth();
  fullScreen(P3D);
  texture = loadImage("texture.jpg");
  logo = createShape(SPHERE, 200);
  logo.setTexture(texture);
  logo.setStroke(false);
  
  theSound = new SoundFile(this, "plop2.mp3");
  
}

void draw() {

  background(1);
  lights();


  // box setup

  stroke(255); // makes the Box visible

  // background square

  line(0, 0, -500, width, 0, -500);
  line(0, 0, -500, 0, height, -500);
  line(0, height, -500, width, height, -500);
  line(width, height, -500, width, 0, -500);

  // perspective lines

  line(0, 0, -500, 0, 0, 0);
  line(width, 0, -500, width, 0, 0);
  line(0, height, -500, 0, height, 0);
  line(width, height, -500, width, height, 0);


  // inital ball set up
  
  translate (xPos, yPos, -zPos);
  rotate(rotationSphere);
  rotateX(rotationSphere);
  rotationSphere+=0.01;
  //sphere(50);
  
  shape(logo);
  noStroke();
  //noFill();
  

  // motion setup

  xPos = xPos + (xSpeed * xDirection);  
  yPos = yPos + (ySpeed * yDirection); 
  zPos = zPos + (zSpeed * zDirection);

  if (xPos>width-50) {
    xDirection*=-1;
    theSound.play();
    
  }

  if (yPos>height-50) {
    yDirection*=-1;
    theSound.play();
  }

  if (zPos>500) {
    zDirection*=-1;
    theSound.play();
  }

  if (xPos<50) {
    xDirection*=-1;
    theSound.play();
  }

  if (yPos<50) {
    yDirection*=-1;
    theSound.play();
  }

  if (zPos<0) {
    zDirection*=-1;
    theSound.play();
  }

  //reversal
 
  
}
