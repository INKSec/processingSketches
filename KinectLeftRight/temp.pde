/*

import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;




Kinect2 kinect2;

void setup() {
  size(512,424, P3D); // Depth Image Size, P3D to render in 3d
  kinect2 = new Kinect2(this);
  
  kinect2.initDepth();
  kinect2.initDevice();
}

void draw() {
  background(0);
  pushMatrix();
  
  int skip = 16;
  int[] depth = kinect2.getRawDepth();
  
  stroke(255);
  strokeWeight(2);
  beginShape(POINTS);
  
  //PImage img = kinect2.getDepthImage(); 
  //image(img,0,0); // 0,0 for distance to edge
  
  
  for(int x = 0; x < kinect2.depthWidth; x+= skip){
    for(int y = 0; y < kinect2.depthHeight; y+=skip) {
      int offset = x + y * kinect2.depthWidth;
      int d = depth[offset];
      
      PVector point = depthToPointCloudPos(x,y,d);
      
      // Draw Point
      vertex(point.x, point.y, point.z);
      
      
      
      
    }
  }
   endShape();

  popMatrix();

  fill(255);
  text(frameRate, 50, 50);

  
  
}

PVector depthToPointCloudPos(int x, int y, float depthValue) {
  PVector point = new PVector();
  point.z = (depthValue);
  point.x = (x- CameraParams.cx) * point.z / CameraParams.fx;
  point.y = (y- CameraParams.cy) * point.y / CameraParams.fy;
  return point;
}
*/
  
  
  
  
