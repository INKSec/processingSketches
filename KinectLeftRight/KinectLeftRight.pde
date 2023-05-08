import org.openkinect.processing.*;

// Kinect Library object
Kinect2 kinect2;

float minThresh = 480;
float maxThresh = 830;
PImage img;

void setup() {
  size(512, 424);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
}


void draw() {
  background(0);

  img.loadPixels();
  
  //minThresh = map(mouseX, 0, width, 0, 4500);
  //maxThresh = map(mouseY, 0, height, 0, 4500);
  
  PImage dImg = kinect2.getDepthImage();
  // Get the raw depth as array of integers
  int[] depth = kinect2.getRawDepth();
  
  int rightRecord = kinect2.depthWidth;
  int rx = 0;
  int ry = 0;
  
  int leftRecord = 0;
  int lx = 0;
  int ly = 0;
  
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  
  for (int x = 0; x < kinect2.depthWidth; x++) {
    for (int y = 0; y < kinect2.depthHeight; y++) {
      int offset = x + y * kinect2.depthWidth;
      int d = depth[offset];

      if (d > minThresh && d < maxThresh && x > 100) {
        img.pixels[offset] = color(205, 200, 150);
        
        if(y<rightRecord) {
          rightRecord = x;
          rx = x;
          ry = y;
        }
        if(y>leftRecord) {
          leftRecord = x;
          lx = x;
          ly = y;
        }
        
        
          
         
       
        
      } else {
        img.pixels[offset] = dImg.pixels[offset];
      }  
    }
  }

  img.updatePixels();
  image(img, 0, 0);
  
  float avgX = sumX / totalPixels;
  float avgY = sumY / totalPixels;
  fill(150,0,255);
  ellipse(rx, ry, 32, 32);
   ellipse(lx, ly, 32, 32);
  
  //fill(255);
  //textSize(32);
  //text(minThresh + " " + maxThresh, 10, 64);
}
