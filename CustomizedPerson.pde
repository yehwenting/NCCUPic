class CustomizedPerson{
  PImage people1, people2, people3, display_person0,display_person1,display_eye, display_eyebrow, display_mouth, display_nose, 
  eye1, eye2, eye3, eye4, eye5, eyebrow1, eyebrow2, eyebrow3, eyebrow4, eyebrow5, mouth1, mouth2, mouth3, mouth4, mouth5, nose1, nose2, nose3;
  float x, y,trueY, xSpeed, ySpeed, sizeX,sizeY;
  int position;
  boolean absoluteY;
  
  CustomizedPerson(String name,String person, String eyeState,String eyebrowState,String noseState, String mouthState){
        display_person0 = loadImage("img/customizedPerson/people" + person + "-1.png");  
        display_person1 = loadImage("img/customizedPerson/people" + person + "-2.png");  
        display_eye = loadImage("img/customizedPerson/eye" + eyeState + ".png");  
        display_eyebrow = loadImage("img/customizedPerson/eyebrow" + eyebrowState + ".png");
        display_mouth = loadImage("img/customizedPerson/mouth" + mouthState + ".png");
        display_nose = loadImage("img/customizedPerson/nose" + noseState + ".png");
        
        position=(int)random(2);
        if(position==0){
          trueY=(int)random(650,720);
        }else{
          trueY=(int)random(880,height-150);
        }
        
        sizeX = 80*1.1;
        sizeY = 130*1.1;
        x = 550;
        y = 770;
        xSpeed = 5;
        //println("speed:" + xSpeed);
        ySpeed = 5;
        
  }
  
  void display(){
      boolean hDirection = (xSpeed < 0) ? true : false;
    if(hDirection) {
      pushMatrix();
      translate(x,y);
      scale(1, 1);
      if(frame==0){
        image(display_person0, 0, 0, 100, 210);
        image(display_eye, 0-19, 0, 100*1.5, 160*1.5);
        image(display_eyebrow, 0-19, 0-1, 100*1.5, 160*1.5);
        image(display_mouth, 0-19, 0, 100*1.5,  160*1.5);
        image(display_nose, 0-19, 0, 100*1.5,  160*1.5);
      }else{
        image(display_person1, 0, 0, 100, 210);
        image(display_eye, 0-19, 0, 100*1.5, 160*1.5);
        image(display_eyebrow, 0-19, 0-1, 100*1.5, 160*1.5);
        image(display_mouth, 0-19, 0, 100*1.5,  160*1.5);
        image(display_nose, 0-19, 0, 100*1.5,  160*1.5);
      }
      popMatrix();      
    } else {
      pushMatrix();
      translate(x,y);
      scale(-1, 1);
      if(frame==0){
        image(display_person0, -100, 0, 100, 210);
        image(display_eye, -100-19, 0, 100*1.5, 160*1.5);
        image(display_eyebrow, -100-19, 0-1, 100*1.5, 160*1.5);
        image(display_mouth, -100-19, 0, 100*1.5,  160*1.5);
        image(display_nose, -100-19, 0, 100*1.5,  160*1.5);
      }else{
        image(display_person1, -100, 0, 100, 210);
        image(display_eye, -100-19, 0, 100*1.5, 160*1.5);
        image(display_eyebrow, -100-19, 0-1, 100*1.5, 160*1.5);
        image(display_mouth, -100-19, 0, 100*1.5,  160*1.5);
        image(display_nose, -100-19, 0, 100*1.5,  160*1.5);
      }
      //image(boydImageSeq[choosePerson][frame], -sizeX, 0, sizeX, sizeY);
      popMatrix();
    }
    
      //image(display_person, x, y, 100, 210);
      //image(display_eye, x-19, y, 100*1.5, 160*1.5);
      //image(display_eyebrow, x-19, y-1, 100*1.5, 160*1.5);
      //image(display_mouth, x-19, y, 100*1.5,  160*1.5);
      //image(display_nose, x-19, y, 100*1.5,  160*1.5);

  }
  
  void move(){
    if(absoluteY){
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
    }else{
      if(position==0){
        y=y-5;
        if(y<trueY) absoluteY=true;
      }else{
        y=y+5;
        if(y>trueY) absoluteY=true;
      }
    }
    

  }
  


}
