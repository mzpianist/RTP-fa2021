//Margaret Zheng RTP final
//Eva Lewitt

ArrayList<CircleDrop> circle_group = new ArrayList<CircleDrop>();
int INIT_RADIUS = 6;
int INIT_Y = 0;
int INIT_LEN = 20*INIT_RADIUS;
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
  size(800,800);
  //CircleDrop(circle color, #line color, line width, dot radius, left angle, right angle, xpos, ypos, initial length, num of dots));
  int num_of_groups =15;
  for (int i=0; i< num_of_groups; i++){

    int r1 = int(random(-1,256));
    int r2 = int(random(-1,256));
    
    int g1 = int(random(-1,256));
    int g2 = int(random(-1,256));
   
    int b1 = int(random(-1,256));
    int b2 = int(random(-1,256));
    
    color c1 = color(r1,g1,b1);
    color c2 = color(r2,g2,b2);
    
    float ang_st = random(PI/2);
    float ang_end = random(PI/2);
    int abs_length = int(random(-0.2*height,0.05*height));
    int abs_lw = int(random(-1.5,3.4));
    
    int movement = int(random(-10*num_of_groups,10*num_of_groups));
    int rand =int(random(-2,3));
    int num_cir = max(10,int(randomGaussian()*30));
    circle_group.add(new CircleDrop(c1,c2, LW+abs_lw, INIT_RADIUS, ang_st, ang_end, int(8*width/(num_cir*num_of_groups)*i+movement)+rand, INIT_Y, INIT_LEN+abs_length, num_cir));
  }

}


void draw(){
  
  int r = int(510*3*abs(mouseX*1.0/width-0.5)-255);
  int g = int(510*3*abs(mouseX*1.0/width-5.0/6)-255);
  if(mouseX<width/6){
    g = int(mouseX*1.0/width*255*6);
  }
  int b = int(min(255,510*3*abs(mouseX*1.0/width-1.0/6)-255));
  if(mouseX>5*width*1.0/6){
    b = int((1-mouseX*1.0/width)*255*6-255);
  }
  
  //background(250);
  //int c3 = int(pow((1+mouseX*1.0/width),12)*pow((1+mouseY*1.0/height),12));
  //println(min(255,510*3*abs(mouseX/width-0.5)-255),min(255,510*3*abs(mouseX/width-5/6)-255));
  //println(mouseX*1.0/width);
  float y = mouseY*2.0/height;
  float wy = max(0,(mouseY*1.0/2/height)*510);

  background(color(max(r,0)*y+wy,max(g,0)*y+wy,max(b,0)*y+wy));
  
  for (CircleDrop c: circle_group){
    c.display();
    c.update_perspective();
  }

  noStroke();
  fill(120,20);
  rect(0,20,width,20);
  //noLoop();
  saveFrame("finalz_800.png");
  
  
}
