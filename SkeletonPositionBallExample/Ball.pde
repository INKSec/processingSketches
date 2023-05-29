

class Ball {
  
  float x;
  float y;
  float speed;
  float gravity;
  float w;
  float life = 800;
  
  
  Ball(float tempX, float tempY, float tempW) {
    x = tempX;
    y = tempY;
    w = tempW;
    speed = 0;
    gravity = 0.1;
  }
  
    void move(ArrayList<SoundFile> sounds) {
    // Add gravity to speed
    speed = speed + gravity;
    // Add speed to y location
    y = y + speed;
    // If square reaches the bottom
    // Reverse speed
    if (y > height-50) {
      // Dampening
      speed = speed * -0.8;
      
      y = height-50;
      
      if(x>0 && x<=274) {sounds.get(0).play();}
      if(x>274 && x<=548) {sounds.get(1).play();}
      if(x>548 && x<=822) {sounds.get(2).play();}
      if(x>823 && x<=1096) {sounds.get(3).play();}
      if(x>1096 && x<=1370) {sounds.get(4).play();}
      if(x>1370 && x<=1644) {sounds.get(5).play();}
      if(x>1644 && x<1920) {sounds.get(6).play();}
      
      
    }
  }
  
  boolean finished() {
    // Balls fade out
    life--;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void display() {
    // Display the circle
    fill(0,life);
    //stroke(0,life);
    ellipse(x,y,w,w);
  }
}  
