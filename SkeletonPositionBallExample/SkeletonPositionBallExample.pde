/*
Thomas Sanchez Lengeling.
 http://codigogenerativo.com/

 KinectPV2, Kinect for Windows v2 library for processing

 Skeleton color map example.
 Skeleton (x,y) positions are mapped to match the color Frame
 */

import KinectPV2.KJoint;
import KinectPV2.*;
import processing.sound.*;


KinectPV2 kinect;
SoundFile soundfile;

int coll = 0;
float handCircleRadius = 50;
float cornerCircleRadius = 50;
ArrayList<Ball> balls;
float ballWidth = 48;
float ballSpeed = 1;
boolean physics = false; // activates the ball physic
int pianoStepSize = 274; // Defines the width of a piano button. Calculated with width / amount buttons

ArrayList<SoundFile> sounds;

int time;

PFont calibri;

void setup() {
  //size(1920, 1080, P3D);
  fullScreen(P3D);
  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  kinect.enableDepthImg(true);
  //kinect.enableBodyTrackImg(true);
  //kinect.enableDepthMaskImg(true);
  
  kinect.init();
  
  sounds = new ArrayList<SoundFile>();
  sounds.add(new SoundFile(this, "cmajor.wav"));
  sounds.add(new SoundFile(this, "dmajor.wav"));
  sounds.add(new SoundFile(this, "emajor.wav"));
  sounds.add(new SoundFile(this, "fmajor.wav"));
  sounds.add(new SoundFile(this, "gmajor.wav"));
  sounds.add(new SoundFile(this, "amajor.wav"));
  sounds.add(new SoundFile(this, "hmajor.wav"));
  
  balls = new ArrayList<Ball>();
 
  
  time = millis(); // initialise timer to draw the circles
  
  calibri = createFont("calibri.ttf", 30); // used the font because the standard was blurry
  
  
  
  
  
}

void draw() {
  background(0);
  
  
  stroke(255);
  
  ellipse(width-200, height/2, cornerCircleRadius*2, cornerCircleRadius*2); // Button right side to start physics
  ellipse(width-200, height/3, cornerCircleRadius*2, cornerCircleRadius*2); // Button left side to stop physics
  ellipse(width-1600, height/16, cornerCircleRadius*2, cornerCircleRadius*2);
  ellipse(width-1400, height/16, cornerCircleRadius*2, cornerCircleRadius*2);
  ellipse(width-1200, height/16, cornerCircleRadius*2, cornerCircleRadius*2);
  //image(kinect.getDepthImage(), 0, 0, width, height);
  //image(kinect.getBodyTrackImage(), 0, 0, 1920, 1080);
  //image(kinect.getDepthMaskImage(), 0, 1080, 1920, 800);
  image(kinect.getColorImage(), 0, 0, 1920, 1080);
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
  
  

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();
      

      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      drawBody(joints);
      
      //draw different color for each hand state
      drawHandState(joints[KinectPV2.JointType_HandRight], time);
      drawHandState(joints[KinectPV2.JointType_HandLeft], time);
      
    }
  }

  //fill(255, 0, 0);
  text(frameRate, 1650, 50);
  
  for (int i = balls.size()-1; i >= 0; i--) {
    Ball ball = balls.get(i);
    if(physics == true) {
    ball.move(sounds);
    }
    ball.display();
    if(ball.y == height-50) {
     balls.remove(i);   
    }
    /*
    if (ball.finished()) {
      // Items can be deleted with remove()
      balls.remove(i);
    }
    */
  }
  
  // piano buttons
  stroke(0);
  fill(255);
  
  // x value left side, y value upper left corner, width, height
  rect(0, height-50, pianoStepSize, 50);
  rect(275, height-50, pianoStepSize, 50);
  rect(549, height-50, pianoStepSize, 50);
  rect(823, height-50, pianoStepSize, 50);
  rect(1097, height-50, pianoStepSize, 50);
  rect(1370, height-50, pianoStepSize, 50);
  rect(1645, height-50, pianoStepSize, 50);
  
  fill(0);
  
  textFont(calibri);
  //size(1920,1080);
  text("C-Dur", 0+5, height-25);
  text("D-Dur", 0+280, height-25);
  text("E-Dur", 0+554, height-25);
  text("F-Dur", 0+828, height-25);
  text("G-Dur", 0+1102, height-25);
  text("A-Dur", 0+1375, height-25);
  text("H-Dur", 0+1650, height-25);
  
  fill(255,255,255);
  text("Play", width-230, height/3);
  text("Pause", width-230, height/2);
  
  
}

void drawBody(KJoint[] joints) {
    
    // draws an ellipse at the right Hand that changes color when touching one of the buttons
    if(dist(joints[KinectPV2.JointType_HandRight].getX(), joints[KinectPV2.JointType_HandRight].getY() , width-200, height/2)< (cornerCircleRadius + handCircleRadius) || 
       dist(joints[KinectPV2.JointType_HandRight].getX(), joints[KinectPV2.JointType_HandRight].getY() , width-200, height/3)< (cornerCircleRadius + handCircleRadius)){
      fill(255,0,0);
    
    } else {
    fill(0,255,0);
    }
    
    // enables or disables physics when touching a button
    if(dist(joints[KinectPV2.JointType_HandRight].getX(), joints[KinectPV2.JointType_HandRight].getY() , width-200, height/2)< (cornerCircleRadius + handCircleRadius)){  
    physics = false;
    }
     if(dist(joints[KinectPV2.JointType_HandRight].getX(), joints[KinectPV2.JointType_HandRight].getY() , width-200, height/3)< (cornerCircleRadius + handCircleRadius)){  
    physics = true;
    }
    ellipse(joints[KinectPV2.JointType_HandRight].getX(), joints[KinectPV2.JointType_HandRight].getY(), handCircleRadius*2, handCircleRadius*2);
    
    
    // draws an ellipse at the left Hand that changes color when touching one of the buttons and disable physics
    fill(0,255,0);
    ellipse(joints[KinectPV2.JointType_HandLeft].getX(), joints[KinectPV2.JointType_HandLeft].getY(), handCircleRadius*2, handCircleRadius*2);
    
    
    if(dist(joints[KinectPV2.JointType_HandLeft].getX(), joints[KinectPV2.JointType_HandLeft].getY() , width-1600, height/16)< (cornerCircleRadius + handCircleRadius)){  
      ballSpeed = 0;
    }
    if(dist(joints[KinectPV2.JointType_HandLeft].getX(), joints[KinectPV2.JointType_HandLeft].getY() , width-1400, height/16)< (cornerCircleRadius + handCircleRadius)){  
      ballSpeed = 3;
    }
    if(dist(joints[KinectPV2.JointType_HandLeft].getX(), joints[KinectPV2.JointType_HandLeft].getY() , width-1200, height/16)< (cornerCircleRadius + handCircleRadius)){  
      ballSpeed = 5;
    }
    
}

//draw joint
void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}

//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

//draw hand state
void drawHandState(KJoint joint, int time) {
  noStroke();
  handState(joint.getState(), joint, time);
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
  ellipse(0, 0, 70, 70); // add red ellipse when hand closed
  popMatrix();
}

/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */
 
void handState(int handState, KJoint a, int times) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    // makes sure you can only create a ball every x seconds
    if(millis() > times + 500) {
    balls.add(new Ball(a.getX(), a.getY(), ballWidth, ballSpeed));
    time = millis();
    }
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    break;
  }
}


/*
 if(dist(joints[KinectPV2.JointType_HandLeft].getX(), joints[KinectPV2.JointType_HandLeft].getY() , width-200, height/3)< (cornerCircleRadius + handCircleRadius)){
    fill(255,0,0);
    physics = false;
    } else {
     fill(0,255,0); 
    }
*/
