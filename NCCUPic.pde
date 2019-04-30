import mqtt.*;
import processing.sound.*;
import ddf.minim.*;
Minim minim;
AudioPlayer raining;
AudioPlayer sunny;
AudioPlayer crashh;

SoundFile file;
SoundFile crash;
//SoundFile crashh;
SoundFile shh;
//SoundFile raining;

WalkingPerson[] walkingPerson,walkingPersonDown;
CustomizedPerson[] customizedPeople;
int cusCount=0;
boolean[] cus=new boolean [10];
CustomizedPerson customizedPerson;

ShhPerson shhPerson;
Building1 building1;
PImage bar,bg,bg1,bg2,bg3,building_1,rain;
float pp=0, ss=0,force=0, shhX = 165, shhY = 175, shhSpeed = 0.1, shhW = 62.5, shhH = 62.5, shhSize = 30;

int numberOfFrames = 2;  // The number of frames in the animation
int frame = 0;
PImage[] boydImageSeq = new PImage[numberOfFrames];
int r, g, b,bodyx; 
int rate=0;
int rainY1=0,rainY2,rainY3;
int speed;

boolean showimage = true; 
boolean test = false;
boolean ifShh = false;


MQTTClient client;

void settings() {
  fullScreen();
}

void setup() {
  bg=loadImage("img/bg.jpg");
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  bg3=loadImage("img/bg3.png");
  building_1=loadImage("img/building1.png");
  bar=loadImage("img/bar.png");
  rain=loadImage("img/rain.png");
  //image(bg, 0, 0,1250,625);
  //image(bar, 315, 50, 200, 50);
  //image(building_1, 0, 0,1250,625);
  
  //MQTT
  client = new MQTTClient(this);
  client.connect("tcp://140.119.163.195:1883", "processingMain");
  client.subscribe("iot_data/voice",0);
  client.subscribe("slider",0);
  client.subscribe("force",0);
  client.subscribe("face/people",0);
  client.subscribe("face/name",0);
  client.subscribe("face/eye",0);
  client.subscribe("face/eyebrow",0);
  client.subscribe("face/mouth",0);
  client.subscribe("face/nose",0);

  bodyx=300;
  frameRate(24);
  r = 0;
  g = 0;
  b = 0;
  customizedPeople=new CustomizedPerson[10];
  for(int i=0;i<10;i++){
    cus[i]=false;
  }
  walkingPerson= new WalkingPerson[10];
  for(int i=0;i<10;i++){
    int x = (int)random(200,width);
    int y = (int)random(650,720);
    int speed = (int)random(-10,10);

    while(speed>-2 && speed<2){
      speed = (int)random(-20,20);
    }
    walkingPerson[i]=new WalkingPerson(speed,x,y);
  }
  walkingPersonDown= new WalkingPerson[5];
  for(int i=0;i<5;i++){
    int x = (int)random(0,1000);
    int y = (int)random(880,height-150);
    int speed = (int)random(-10,10);
    while(speed>-2 && speed<2){
      speed = (int)random(-20,20);
    }
    walkingPersonDown[i]=new WalkingPerson(speed,x,y);
  }
  
  shhPerson=new ShhPerson();
  building1=new Building1();
  
  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "sound/morning.mp3");
  //file.loop();
  crash = new SoundFile(this, "sound/crash.mp3");
  //crashh = new SoundFile(this, "sound/crashh.mp3");
  shh = new SoundFile(this, "sound/shh.mp3");
  minim = new Minim(this);
  raining = minim.loadFile("sound/raining.mp3");
  sunny = minim.loadFile("sound/morning.mp3");
  crashh = minim.loadFile("sound/crashh.mp3");
  //raining.play();
  sunny.play();
  
  //rain
  rainY2=height*(-1);
  rainY3=height*(-2);
}

void draw() {
  noTint();
  image(bg, 0, 0,width,height);
  image(bg1,0, 0,width,height);
  
  // crush building
  if(showimage){
    image(building_1,(width/3-40),(height/3-170), 1000, 500);
  }
  if(force>2){
    showimage = false;
    test = true;
    crash.play();
    crashh.play();
  }
  if(test==true){
    building1.display();
  }
  if(building1.frame>50){
    showimage = true;
    test = false;
    crash.stop();
    building1.frame=0;
   }
  
  //walking people
    for(int i=0;i<10;i++){
      if(ss>3 && walkingPerson[i].x>width){
      walkingPerson[i].xSpeed=0;
    }else if(test==true && walkingPerson[i].x>(width/3) && walkingPerson[i].x<(width/3)+500){
      walkingPerson[i].xSpeed=0;
      walkingPerson[i].shake();
    }else{
      if(ss>3){
          if(walkingPerson[i].xSpeed<0){
            speed = -(int)ss*7;
            walkingPerson[i].xSpeed=speed;
          }else{
            speed = (int)ss*10;
            walkingPerson[i].xSpeed=speed;
          }
      }else if(walkingPerson[i].xSpeed==0){
        walkingPerson[i].x = (int)random(width,width+200);
        speed = (int)random(-20,-10);
        walkingPerson[i].xSpeed=speed;
      }else{
          if(walkingPerson[i].xSpeed<0){
          speed = (int)random(-20,-2);
          walkingPerson[i].xSpeed=speed;
          }else{
            speed = (int)random(2,20);
            walkingPerson[i].xSpeed=speed;
          }
      }
    }
      
    //println("speed:" + speed);
    walkingPerson[i].display();
    walkingPerson[i].move();
  }
  
  image(bg2,0, 0,width,height);
  
  for(int i=0;i<5;i++){
    if(ss>3 && (walkingPersonDown[i].x>width || walkingPersonDown[i].x<-80)){
      walkingPersonDown[i].xSpeed=0;
    }else{
      if(ss>3){
          if(walkingPersonDown[i].xSpeed<0){
          speed = -(int)ss*10;
          walkingPersonDown[i].xSpeed=speed;
          }else{
            speed = (int)ss*10;
            walkingPersonDown[i].xSpeed=speed;
          }
      }else if(walkingPersonDown[i].xSpeed==0){
        walkingPersonDown[i].x = (int)random(-80,-300);
        speed = (int)random(20,10);
        walkingPersonDown[i].xSpeed=speed;
      }else{
          if(walkingPersonDown[i].xSpeed<0){
          speed = (int)random(-20,-2);
          walkingPersonDown[i].xSpeed=speed;
          }else{
            speed = (int)random(2,20);
            walkingPersonDown[i].xSpeed=speed;
          }
      }
    }
      
    //println("speed:" + speed);
    walkingPersonDown[i].display();
    walkingPersonDown[i].downMove();
  }
  
  
  image(bg3,0, 0,width,height);
  image(bar, 245, 160, 200, 50);
  
  //shh person
  if(pp > 100){
    ifShh = true;
    shh.play();
    
   }
   if(ifShh){
     shhPerson.display();
     
   }
   if(shhPerson.frame>230){
     ifShh=false;
     shh.stop();
   }
   
   for(int i=0;i<10;i++){
     if(cus[i]){
      customizedPeople[i].display();
      customizedPeople[i].move();
    }
   }
   
  
  line(0, 750, width, 750);
  line(0, 910, width, 910);
  line(550, 0, 550, height);
  line(650, 0, 650, height);

  // rain display
  tint(255, 51*ss);  // Display at half opacity
  image(rain,0,rainY1,width,height);
  image(rain,0,rainY2,width,height);
  rainY1+=100;
  rainY2+=100;
  if(rainY1>=height){  rainY1=rainY2-height; }
  if(rainY2>=height){  rainY2=rainY1-height; }
  if(ss>3){
    if(sunny.isPlaying()){
      sunny.pause();
    }
    if(!raining.isPlaying()){
        raining.loop();
    }
  }else{
    if(!sunny.isPlaying()){
      sunny.loop();
    }
    if(raining.isPlaying()){
        raining.pause();
    }
  }
  
  //line(0, 1000, 1000, height);
  
  
}

void mousePressed() {
  //client.publish("/hello", "world123");
}

void messageReceived(String topic, byte[] payload) {
  //println("new message: " + topic + " - " + new String(payload));
  if(topic.equals("iot_data/voice")){
    String p= new String(payload);
    pp=float(p);
  }else if(topic.equals("slider")){
    String s= new String(payload);
    ss=float(s);
  }else if(topic.equals("force")){
    String f= new String(payload);
    force=float(f);
  }else if(topic.equals("face/people")){
    String value=new String(payload);
    String[] face=value.split(" ");
    String person = String.valueOf(face[1].charAt(0));
    String eyebrow = String.valueOf(face[1].charAt(1));
    String eye = String.valueOf(face[1].charAt(2));
    String nose = String.valueOf(face[1].charAt(3));
    String mouth = String.valueOf(face[1].charAt(4));
    customizedPeople[cusCount]= new CustomizedPerson("h",person,eye,eyebrow,nose,mouth);
    cus[cusCount]=true;
    cusCount=(cusCount+1)%10;
    print("new message: " + topic + " - " + new String(payload));
  }
  //println(force);
  noStroke();
  fill(234,136,151);
  rect(255,180,(pp)*1.5,12);
  //image(bar, 10, -100, 1100, 100);
}
