//hardcode
PFont f;
void setup(){
  size(560,760);
  background(243,235,222);
  f = createFont("NHaasGroteskTXPro-75Bd.ttf", 18);
  textFont(f);
}


void draw(){
  String words = "BAUHAUS";
  float angle1 = radians(270);
  int fontSize = 140;
  float up_factor = height/60;

  //yellow
  pushMatrix();
  translate(120, height-50-up_factor);
  rotate(angle1);
  //text properties
  fill(240,210,0,0);
  textSize(fontSize);
  text(words, 0, 0);
  popMatrix();
  
  //blue
  pushMatrix();
  translate(120, height-10-up_factor);
  rotate(angle1);
  //text properties
  fill(50,160,220,80);
  textSize(fontSize);
  text(words, 0, 0);
  popMatrix();
  
  
  //red
  pushMatrix();
  translate(120, height-30-up_factor);
  rotate(angle1);
  //text properties
  fill(190,5,80,80);
  textSize(fontSize);
  text(words, 0, 0);
  popMatrix();
  saveFrame("Hardcode_Assignment3.png");
}
