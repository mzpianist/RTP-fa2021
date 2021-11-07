import processing.video.*;
Capture cam;
int distortion = 200;
float offset1 = 0;
float offset2 = 0;
float easing = 0.05;
ArrayList<Integer> bright = new ArrayList<Integer>(height);
int pixel_size = 2;

void setup(){
  size(800,600);
  cam = new Capture(this,width,height);
  cam.start();
  
  for (int b=0; b< height; b++){
    bright.add(0);
  }
}

void draw_horizontal_glitch(int split,int thick1,int thick2, int op){
  /*
  split is where the height of rectangle becomes larger (under) and stays 1 (over)
  op is opaqueness (i.e. opposite of transparency)
  thickness is how thick we want the lines below "split" to be
  */
  //first part
  for (int i = 0; i< split; i+=thick1){
    float r1 = random(0,width-1);
    float r2 = random(0,width-1);
    int ra1 = int(min(r1,r2));
    int ra2 = int(max(r1,r2));
    fill(bright.get(i),op);
    noStroke();
    rect(0,i,ra1,thick1);
 
    fill(bright.get(i),op);
    noStroke();
    rect(ra2,i,width-ra2,thick1);
  }
  
  //second part
  for (int j = split; j<height; j+=thick2){
    float r1 = random(0,width-1);
    float r2 = random(0,width-1);
    int ra1 = int(min(r1,r2));
    int ra2 = int(max(r1,r2));
    color c = bright.get(j);
    float rand = random(0,1);
    if (rand>0.9){
      c=-1;
      ra1=0;
      ra2=width;
      op=255;
    }else if (rand<0.2){
      c=-16777215;
      ra1=0;
      ra2=width;
      op=255;
    }
    fill(c,op);
    noStroke();
    rect(0,j,ra1,thick2);
    fill(c,op);
    noStroke();
    rect(ra2,j,width-ra2,thick2);
  }
  }



void draw_vertical_glitch(int split,int thick1,int thick2, int op){
  /*
  split is where the height of rectangle becomes larger (under) and stays 1 (over)
  op is opaqueness (i.e. opposite of transparency)
  thickness is how thick we want the lines below "split" to be
  */
  //first part
  for (int i = 0; i< split; i+=thick1){
    float r1 = random(0,height-1);
    float r2 = random(0,height-1);
    int ra1 = int(min(r1,r2));
    int ra2 = int(max(r1,r2));
    fill(bright.get(i),op);
    noStroke();
    rect(i,0,thick1,ra1);
 
    fill(bright.get(i),op);
    noStroke();
    rect(i,ra2,thick1,height-ra2);
  }
  
  //second part
  for (int j = split; j<height; j+=thick2){
    float r1 = random(0,height-1);
    float r2 = random(0,height-1);
    int ra1 = int(min(r1,r2));
    int ra2 = int(max(r1,r2));
    color c = bright.get(j);
    float rand = random(0,1);
    if (rand>0.9){
      c=-1;
      ra1=0;
      ra2=width;
      op=255;
    }else if (rand<0.2){
      c=-16777215;
      ra1=0;
      ra2=width;
      op=255;
    }
    fill(c,op);
    noStroke();
    rect(j,0,ra1,thick2);
    fill(c,op);
    noStroke();
    rect(j,ra2,height-ra2,thick2);
  }
  }
  
  
  
  
  
  
  
  
void draw(){
  if (cam.available()){
    cam.read();
  }
  
  //the reference
  image(cam,0,0);
  filter(GRAY);
  //filter(POSTERIZE,10);
  //PImage img = get();
  loadPixels();
  for (int i = 0; i<height; i++){
    float r = random(0,width);
    color c = get(int(r),i);
    bright.set(i,c);
  }
 
  //the original 
  image(cam,0,0);
  filter(GRAY);

  //first overlay
  float dx = (mouseX-cam.width/2) - offset1;
  offset1 += dx * easing;
  tint(180, 255*abs(mouseX-width/2)/width/2);
  //tint(255, 255*abs(mouseX-width/2)/width/2);  
  image(cam, offset1, 0);
  filter(GRAY);
  
  //second overlay
  float dy = (mouseX-cam.width/2) + offset2;
  offset2 -= dy * easing*0.5;
  tint(255, 255*abs(mouseX-width/2)/width/2);  // Display at half opacity
  image(cam, offset2, 0);
  filter(GRAY);
  
  //glitch
  draw_horizontal_glitch(width/2,1,2,80);
  //draw_vertical_glitch(height/2,1,2,100);
  
  saveFrame("glitch9.png");
}
