import processing.video.*; //<>// //<>//
Capture cam;
int NUM_OF_TIMS = 25;
ArrayList<DropLetter> tim = new ArrayList<DropLetter>();
PImage wide_tim;
int speed = 2;

class DropLetter{
  /* for each letter that drops down, it's an object!
  speed is the initial speed of dropping down
  f isthe font used
  font_size is self-explanatory
  letter is the letter the dropletter represents
  location is the current location of dropletter
  */
  int speed;
  int x_pos;
  int y_pos;
  
  //constructor
  DropLetter(int init_speed, int x, int y){
    speed = init_speed;
    x_pos = x;
    y_pos = y;
  } 
 
  //functions
  int getX(){return x_pos;}
  int getY(){return y_pos;}
  void display(){
    //to be written with wide tim
    wide_tim.resize(0,width/NUM_OF_TIMS);
    image(wide_tim, x_pos,y_pos);
  }
  
  void update(boolean isBlanc, String mode){
    //if detects white pixel then drop down, otherwise do nothing
    if (mode == "light"){
      if (isBlanc){
      y_pos = (y_pos+speed)%height;
    }else{
      y_pos = (y_pos-speed)%height;
    }  
    }else if (mode == "dark"){
      if (isBlanc){
      y_pos = (y_pos-speed)%height;
    }else{
      y_pos = (y_pos+speed)%height;
     }  
    } 
  }
}

//other helper functions

//1. remove spaces in given string (copied from Assignment 5 code)
String remove_spaces(String original){
  String new_str= "";
  for (int i=0; i<original.length(); i++){
    if(original.charAt(i) !=' '){
      new_str +=original.charAt(i);
    }
  }
  return new_str;
}

void setup(){
  size(1200,900);
  wide_tim = loadImage("wide_tim.png");
  cam = new Capture(this,width,height);
  cam.start();

  //setup the arraylist
  String str = "I like talking with you, simply that: conversing, a turning-with or around, as in your turning around to face me suddenly";
  String new_str = remove_spaces(str);
  print(new_str);
 
  for (int i=0; i<NUM_OF_TIMS; i++){
  tim.add(new DropLetter(speed,i*width/NUM_OF_TIMS, 0));
  }
}

void draw(){
  if (cam.available()){
    cam.read();
  }
  cam.loadPixels();
  pushMatrix();
  scale(-1,1);
  translate(-width,0);
  image(cam,0,0);
  filter(THRESHOLD,mouseX*1.0/width);
  popMatrix();
  
  PImage c = get();
  loadPixels();
  
  //the actual display image display
  pushMatrix();
  scale(-1,1);
  translate(-width,0);
  image(cam,0,0);
  popMatrix();
 
  for (DropLetter l: tim){
    l.display();
    //light mode is for light bkgd, dark mode is for dark bkgd
    l.update((c.get(l.getX(),max(0,l.getY())+width/NUM_OF_TIMS/2)==-1),"light"); 
  }
}
