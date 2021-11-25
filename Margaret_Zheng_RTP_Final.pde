//Margaret Zheng RTP final
//Eva Lewitt

ArrayList<CircleDrop> circle_group = new ArrayList<CircleDrop>();
int INIT_RADIUS = 5;
int INIT_Y = 20;
int INIT_LEN = 40*INIT_RADIUS;
int LW=2;
/*
Define a class object. This class object is 1 "arc" of lines should contain information of:
line_color = color of line
line_width = int, 1/2 width of line
dot_radius = int, radius of circle
dot_color = color of dot
angle_l = left angle (degree of arc it makes wrt straight vertical line thru center)
angle_r = right angle (analogous to angle_start)
(both of those angles are positive)
x_pos, y_pos = pixel of the top left strip
st_line_length = initial length, int
num_dots = number of circles
*/

class CircleDrop{
  color dot_color; color line_color;
  int line_width; int dot_radius;
  float angle_l; float angle_r;
  int x_pos; int y_pos;
  int init_line_length;
  int num_dots;
  
  //constructor
  CircleDrop(color cdot, color cline, int lw, int dr, float st_angle, float end_angle, int x, int y, int init_len, int num_cir){
    dot_color = cdot;
    line_color = cline;
    line_width = lw;
    dot_radius = dr;
    angle_l = st_angle;
    angle_r = end_angle;
    x_pos = x;
    y_pos = y;
    init_line_length = init_len;
    num_dots = num_cir;
  }
  
  void display(){
    //R is radius, L is total horizontal length 
    float L = num_dots*dot_radius*2;
    float R = L/( sin(angle_l)+sin(angle_r));
    float center = 2*R*sin(angle_l)/(sin(angle_l)+sin(angle_r));
    
    
    for (int i=0; i<num_dots; i++){
      //initiators
      //x is the abs value of x-position with respect to center
      float x = abs(center-(2*(i)+1)*dot_radius);
      //line_len is the length of the vertical line
      float line_len = sqrt(pow(R,2)-pow(x,2));
     
      //arc
      noFill();
      strokeWeight(line_width);
      stroke(line_color);
      arc(x_pos+(2*i+1)*dot_radius,y_pos+line_len+init_line_length,dot_radius*2, dot_radius*2, 0, PI);
      
      //left line
      strokeWeight(line_width);
      stroke(line_color);
      line(x_pos+2*i*dot_radius,y_pos,x_pos+2*i*dot_radius,y_pos+line_len+init_line_length);
      //right line
      line(x_pos+2*(i+1)*dot_radius,y_pos,x_pos+2*(i+1)*dot_radius,y_pos+line_len+init_line_length);
      
      //circles
      float r = red(dot_color);
      float g = green(dot_color);
      float b = blue(dot_color);
      color newcolor = color(r+random(-15,15),g+random(-15,15),b+random(-10,10));
      fill(newcolor);
      noStroke();
      circle(x_pos+(2*i+1)*dot_radius,y_pos+line_len+init_line_length,dot_radius*2);
      
      //debug
      //println("i = ", i, "left:", x_pos+2*i*dot_radius, " right line:", x_pos+2*(i+1)*dot_radius, "center=", center, "circle center: (", x_pos+(2*i+1)*dot_radius,y_pos+line_len+init_line_length, ")", "x=", x, "R=", R);    
      }
    }
    
   void update_perspective(){
     float L = num_dots*dot_radius*2;
     float R = L/( sin(angle_l)+sin(angle_r));
     float center = 2*R*sin(angle_l)/(sin(angle_l)+sin(angle_r));
     float sc = abs(center-mouseX);
     line_width = floor(sc/width*5)+LW;
   }
    
   int get_line_width(){
     return line_width;
   }
   
   void update_length(){
     float L = num_dots*dot_radius*2;
     float R = L/( sin(angle_l)+sin(angle_r));
     float center = 2*R*sin(angle_l)/(sin(angle_l)+sin(angle_r));
     while(init_line_length>-200 & init_line_length<400){
       if (center< mouseX){
         init_line_length+=1;
       }else{
         init_line_length-=1;
       }
     }
   }
    
}

void setup(){
  size(3000,700);
  //CircleDrop(circle color, #line color, line width, dot radius, left angle, right angle, xpos, ypos, initial length, num of dots));
  circle_group.add(new CircleDrop(#FFEF00, #FFFF00, LW+3, INIT_RADIUS, PI/3, PI/2.5, 0*INIT_RADIUS, INIT_Y, INIT_LEN-10*INIT_RADIUS, 28));
  circle_group.add(new CircleDrop(#272E7F, #FFF6A0, LW+1, INIT_RADIUS, PI/2, PI/2, 40*INIT_RADIUS, INIT_Y, INIT_LEN-12*INIT_RADIUS+2, 16));
  circle_group.add(new CircleDrop(#383EAA, #FFF6A0, LW, INIT_RADIUS, PI/2, PI/2, 72*INIT_RADIUS, INIT_Y, INIT_LEN+20*INIT_RADIUS, 16));
  circle_group.add(new CircleDrop(#FFDF00, #FFEF00, LW+1, INIT_RADIUS, PI/3, PI/4, 72*INIT_RADIUS, INIT_Y, INIT_LEN-30*INIT_RADIUS, 27));
  circle_group.add(new CircleDrop(#059894, #0545C0, LW, INIT_RADIUS, PI/2, PI/2, 110*INIT_RADIUS+1, INIT_Y, INIT_LEN+30*INIT_RADIUS, 24));
  
  circle_group.add(new CircleDrop(#85E5D3, #0586E5, LW, INIT_RADIUS, PI/4, PI/2.4, 158*INIT_RADIUS, INIT_Y, INIT_LEN-10*INIT_RADIUS, 16));
  circle_group.add(new CircleDrop(#FF9549, #FFEEA4, LW, INIT_RADIUS, PI/6, PI/2, 172*INIT_RADIUS-1, INIT_Y, INIT_LEN-22*INIT_RADIUS, 32));

  circle_group.add(new CircleDrop(#383EAA, #D6B998, LW, INIT_RADIUS, PI/5, PI/2, 236*INIT_RADIUS, INIT_Y, INIT_LEN+20*INIT_RADIUS, 15));
  circle_group.add(new CircleDrop(#FFF6E7, #EFDF2B, LW+3, INIT_RADIUS, PI/4, PI/2, 264*INIT_RADIUS, INIT_Y, INIT_LEN-30*INIT_RADIUS, 24));
  circle_group.add(new CircleDrop(#001F0F, #DE99A1, LW-1, INIT_RADIUS, PI/5, PI/2, 236*INIT_RADIUS, INIT_Y, INIT_LEN+20*INIT_RADIUS, 33));
  circle_group.add(new CircleDrop(#EFC82B, #FFEF2B, LW+1, INIT_RADIUS, PI/2, PI/4, 300*INIT_RADIUS+1, INIT_Y, INIT_LEN-4*INIT_RADIUS, 12));
  circle_group.add(new CircleDrop(#FFEF2A, #CCC8B5, LW, INIT_RADIUS, PI/1.5, PI/2, 324*INIT_RADIUS, INIT_Y, INIT_LEN+10*INIT_RADIUS, 16));
  
  circle_group.add(new CircleDrop(#FFFFFF, #FF4000, LW+1, INIT_RADIUS, PI/2, PI/2, 338*INIT_RADIUS-1, INIT_Y, INIT_LEN+12*INIT_RADIUS, 30));
  circle_group.add(new CircleDrop(#13c7f0, #f0fcff, LW, INIT_RADIUS, PI/2, PI/2, 386*INIT_RADIUS, INIT_Y, INIT_LEN-20*INIT_RADIUS, 20));
  
  circle_group.add(new CircleDrop(#1962ff, #ffEE00, LW, INIT_RADIUS, PI/2, PI/8, 400*INIT_RADIUS+1, INIT_Y, INIT_LEN+10*INIT_RADIUS, 25));
  circle_group.add(new CircleDrop(#1962ff, #fffF00, LW, INIT_RADIUS, 0, PI/3, 450*INIT_RADIUS+1, INIT_Y, INIT_LEN, 20));
  circle_group.add(new CircleDrop(#fffFA9, #42d1f5, LW, INIT_RADIUS, PI/2, PI/2, 474*INIT_RADIUS, INIT_Y, INIT_LEN+40*INIT_RADIUS, 18));
  circle_group.add(new CircleDrop(#27cc95, #f56558, LW, INIT_RADIUS, PI/2, PI/2, 490*INIT_RADIUS, INIT_Y, INIT_LEN, 25));
}


void draw(){
  background(250);
  for (CircleDrop c: circle_group){
    c.display();
    c.update_perspective();
    print(c.get_line_width());
  }
  println();
  noStroke();
  fill(120,20);
  rect(0,20,width,20);
  //noLoop();
  saveFrame("inprogress1.png");
  
  
}
