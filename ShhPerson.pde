class ShhPerson{
  
  float x, y,sizeX,sizeY;
  int numberOfFrames = 247; // The number of frames in the animation
  int rate =0;
  int frame = 0;
  PImage[] boydImageSeq = new PImage[numberOfFrames];
  ShhPerson(){
  for(int i=0; i<numberOfFrames; i++) {
    String imageName = "img/shh/123_" + nf(i, 5) + ".png";
    boydImageSeq[i] = loadImage(imageName);
    }
    sizeX = 430;
    sizeY = 160;
    x = 355;
    y = 368;
  }
  void display(){
    //println(frame);
    for(int i =0; i<10; i++){
      frame = (frame+1) % numberOfFrames;
    }
    image(boydImageSeq[frame], x, y, sizeX*0.5, sizeY*0.5);
    
  }
  
  
}
