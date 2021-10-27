import processing.video.*; //<>//
Capture cam;
int NUM_LETTERS = 50;
PFont f;
ArrayList<DropLetter> letters = new ArrayList<DropLetter>();

class DropLetter{
  /* for each letter that drops down, it's an object!
  speed is the initial speed of dropping down
  f isthe font used
  font_size is self-explanatory
  letter is the letter the dropletter represents
  location is the current location of dropletter
  */
  int speed;
  PFont f;
  int font_size;
  char letter;
  int x_pos;
  int y_pos;
  
  //constructor
  DropLetter(int init_speed, PFont font, int f_size, char let, int x, int y){
    speed = init_speed;
    f = font;
    font_size = f_size;
    letter = let;
    x_pos = x;
    y_pos = y;
  } 
 
  //functions
  
  int getX(){
    return x_pos;
  }
  int getY(){
    return y_pos;
  }
  void display(){
    fill(0,0,100);
    textSize(font_size);
    text(letter,x_pos,y_pos);
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
  size(800,600);
  
  cam = new Capture(this,width,height);
  cam.start();
  f = createFont("conthrax-sb.ttf",width/NUM_LETTERS);

  //setup the arraylist
  String str = "I like talking with you, simply that: conversing, a turning-with or around, as in your turning around to face me suddenly";
  String new_str = remove_spaces(str);
  print(new_str);
  
  for (int i=0; i<NUM_LETTERS; i++){
  letters.add(new DropLetter(1,f,2*width/NUM_LETTERS, new_str.charAt(i%new_str.length()), i*width/NUM_LETTERS, 0));
  }
}


void draw(){
  if (cam.available()){
    cam.read();
  }
  
  image(cam,0,0);
  filter(THRESHOLD,0.68);
  //filter(THRESHOLD,mouseX*1.0/width);
  //print(mouseX*1.0/width);
  PImage c = get();
  loadPixels();
  
  //the actual display image display
  fill(255);
  rect(0,0,width,height);
  tint(150,200,205,100);
  image(cam,0,0);

  for (DropLetter l: letters){
    l.display();
    l.update((c.get(l.getX(),l.getY())==-1),"dark");
  }
  
}
