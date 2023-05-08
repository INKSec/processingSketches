import org.openkinect.processing.*;

// Kinect Library object
Kinect2 kinect2;


PImage img;
float minThresh = 800;
float maxThresh = 1600;
float fullScreenScale;

void setup() {
  
  fullScreen(P3D);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  
  fullScreenScale = width / float(640);
   img =createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
    scale(fullScreenScale, fullScreenScale);
  
}


void draw() {
  background(0);
  scale(fullScreenScale, fullScreenScale);
  img.loadPixels();
  
  //minThresh = map(mouseX, 0, width, 0, 4500);
  //maxThresh = map(mouseY, 0, height, 0, 4500);
  

  // Get the raw depth as array of integers
  int[] depth = kinect2.getRawDepth();
  
 
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  
 for (int x = 0; x < kinect2.depthWidth; x++) {
    for (int y = 0; y < kinect2.depthHeight; y++) {
      int offset = x + y * kinect2.depthWidth;
      int d = depth[offset];

      if (d > minThresh && d < maxThresh && x > 100) {
        img.pixels[offset] = color(100,100,230);
        //color(255, 0, 150);
         
        sumX += x;
        sumY += y;
        totalPixels++;
        
      } else {
        img.pixels[offset] = color(0);
      }  
    }
 }

  img.updatePixels();
  image(img, 0, 0);
  
  
 
  
  //fill(255);
  //textSize(32);
  //text(minThresh + " " + maxThresh, 10, 64);
}
