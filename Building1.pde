class Building1{
  
  float x, y,sizeX,sizeY;
  int numberOfFrames = 55; // The number of frames in the animation
  int rate =0;
  int frame = 0;
  PImage[] boydImageSeq = new PImage[numberOfFrames];
  Building1(){
  for(int i=0; i<numberOfFrames; i++) {
    String imageName = "img/building1/" + i + ".png";
    boydImageSeq[i] = loadImage(imageName);
    }
    sizeX = 1000;
    sizeY = 500;
    x = (width/3-40);
    y = (height/3-170);
  }
  void display(){
    //println(y);
    //for(int i =0; i<10; i++){
      frame = (frame+1) % numberOfFrames;
      
    //}
    image(boydImageSeq[frame], x, y, sizeX, sizeY);
    
  }
  
  
}
