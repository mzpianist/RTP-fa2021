/*
define an object, which is a block that has a triangle in it.
We can change the triangles' colors as well!
*/

class TriBlock{
  /*
  (xpos, ypos) is the upper left corner coordinate for each square;
  color_1 is the color for triangle
  side_length is the side length of the unit triblock square
  st takes on values 1,2,3,4
  
  */
  color color_1;
  color color_2;
  float xpos;
  float ypos;
  float side_length;
  int st;
 
  //constructor
  TriBlock (color c1, color c2, float x, float y, float s, int status){ 
      color_1 = c1;
      color_2 = c2;
      xpos = x;
      ypos = y;
      side_length = s;
      st = status;
   }
   //functions
   void display(){
     fill(color_2);
     rect(xpos,ypos,side, side);
     //for triangle
     fill(color_1);
     noStroke();
     if (st==1){
       pushMatrix();
       triangle(xpos, ypos, xpos, ypos+side_length, xpos+side_length, ypos+side_length);
       popMatrix();
     }else if (st==2){
       pushMatrix();
       triangle(xpos, ypos, xpos+side_length, ypos, xpos, ypos+side_length);
       popMatrix();
     }else if (st==3){
       pushMatrix();
       triangle(xpos, ypos, xpos+side_length, ypos, xpos+side_length, ypos+side_length);
       popMatrix();  
     }else if (st==0){
       pushMatrix();
       triangle(xpos, ypos+side_length, xpos+side_length, ypos, xpos+side_length, ypos+side_length);
       popMatrix();
     }
   }
   int getStatus(){
     return st;
   }
   void updateStatus(){
     st = (st+1)%4;
   }
   void randomColor(){
     color_1 = color(random(0,255),random(0,255), random(0,255));
     color_2 = color(random(0,255),random(0,255), random(0,255));
   }
   
   void colorDrift(float a){
     color_1 = color(red(color_1)+random(-a,a),green(color_1)+random(-a,a), blue(color_1)+random(-a,a));
     color_1 = color(red(color_2)+random(-a,a),green(color_2)+random(-a,a), blue(color_2)+random(-a,a));
   }
}

color C1 = #000000;
color C2 = #ffffff;
/*
color C1 = color(random(0,255),random(0,255), random(0,255));
color C2 = color(random(0,255),random(0,255), random(0,255));
*/
int num_wid = 28;
int num_hgt = 16;
int side = 30;
float start_x = 0;
float start_y =0;

TriBlock[][] blocks = new TriBlock[num_wid][num_hgt];

void setup(){
  noLoop();
  size(840,480);
  for (int i =0; i< num_wid; i++){
    for (int j = 0; j < num_hgt; j++){
        blocks[i][j] = new TriBlock(C1, C2, start_x + side*i, start_y+side*j, side, int(random(0,4)));
        blocks[i][j].display();
      }
    }
}
void draw(){
  for (int i =0; i< num_wid; i++){
    for (int j = 0; j < num_hgt; j++){
        blocks[i][j].display();
        //blocks[i][j].colorDrift(2);
        
     }
   }
 }
void mouseMoved(){
  blocks[mouseX/side][mouseY/side].updateStatus();
  //blocks[mouseX/side][mouseY/side].colorDrift(100);
  println(mouseX,mouseY, mouseX/side, mouseY/side, blocks[mouseX/side][mouseY/side].getStatus());
  redraw();
  saveFrame("Assignment4_demo1.png");
}
