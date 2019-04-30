class WalkingPerson{
  
  float x, y, xSpeed, ySpeed, sizeX,sizeY;
  int numberOfPeople = 5;
  int numberOfFrames = 2; // The number of frames in the animation
  int rate =0;
  int frame = 0;
  int choosePerson;
  PImage[][] boydImageSeq = new PImage[numberOfPeople][numberOfFrames];
  
  WalkingPerson(int speed,int placeX, int placeY){
    choosePerson=(int)random(4);
    //for(int i=1; i<5; i++) {
      for(int j=1; j<3;j++){
        String imageName = "img/walking/" + choosePerson +"-"+j+ ".png";
        boydImageSeq[choosePerson][j-1] = loadImage(imageName);
      }
    //}
    sizeX = 80*1.1;
    sizeY = 130*1.1;
    x = placeX;
    y = placeY;
    xSpeed = speed;
    //println("speed:" + xSpeed);
    ySpeed = 5;
    
  }
  
  void move(){
      frame = (frame+1) % numberOfFrames;  // Use % to cycle through frames
      x += xSpeed; 
      //y += ySpeed;
    //if(y<400 || y>700){
    //  ySpeed = -ySpeed;
    //  y += ySpeed;
    //}
  
    if(x<100 || x>width+120) { 
      xSpeed =-xSpeed;
      x += xSpeed;  
    }
  }
  
  void downMove(){
    frame = (frame+1) % numberOfFrames;  // Use % to cycle through frames
      x += xSpeed; 
      //y += ySpeed;
    if(x<-120 || x>1000) { 
      xSpeed =-xSpeed;
      x += xSpeed;  
    } 
  }
  void shake(){
    y+=ySpeed*9;
    ySpeed=-ySpeed;
  }
 
  void display(){
    
    boolean hDirection = (xSpeed < 0) ? true : false;
    if(hDirection) {
      pushMatrix();
      translate(x,y);
      scale(1, 1);
      image(boydImageSeq[choosePerson][frame], 0, 0, sizeX, sizeY);
      popMatrix();      
    } else {
      pushMatrix();
      translate(x,y);
      scale(-1, 1);
      image(boydImageSeq[choosePerson][frame], -sizeX, 0, sizeX, sizeY);
      popMatrix();
    }
  }
  
  
}
