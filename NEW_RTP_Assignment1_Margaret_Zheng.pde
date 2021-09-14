//initialize

void setup(){
  size(800,800);
  noFill();
  background(238,231,224);
  strokeWeight(1.4);
}

void draw_rand_rects(int num, float st_x, float st_y, float st_w, float st_h, float x_var, float y_var, float w_var, float h_var){
  for (int i = 0; i < num; i=i+1){//draws rectangles
    float x_rand = random(-x_var,x_var);
    float y_rand = random(-y_var,y_var);
    float w_rand = random(-w_var,w_var);
    float h_rand = random(-h_var,h_var);
    rect(st_x+x_rand, st_y+y_rand, st_w+w_rand, st_h+h_rand);
  }
}

void draw_gaussian_rects(int num, float st_x, float st_y, float st_w, float st_h, float x_var, float y_var, float w_var, float h_var){
  for (int i = 0; i < num; i=i+1){//draws rectangles
    rect(st_x+randomGaussian()*x_var, st_y+randomGaussian()*y_var, st_w+randomGaussian()*w_var, st_h+randomGaussian()*h_var);
  }
}

//the drawing part!
void draw(){}
void mousePressed(){
  /* Uniform distribution
  draw_rand_rects(30,100,100,300,300,100,100,150,100);
  save("sample_rand_30.png");
  */
  
  /* Gaussian distribution
  draw_gaussian_rects(15,150,150,250,250,50,50,70,70);
  save("sample_gaussian_15.png");
  */
  
  /*
  this function draw gaussian rectangles based on where you click
  draw_gaussian_rects(1,mouseX-width/6,mouseY-width/6,width/3,width/3,100,100,50,50);
  save("sample_mousedraw_1");
  */
  
  //perhaps an improved version (in terms of replicating Molnar's work):
  draw_gaussian_rects(4,mouseX-width/4,mouseY-width/4,width/2,width/2,width/30,width/30,width/10,width/10);
  draw_gaussian_rects(1,mouseX-width/10,mouseY-width/10,width/5,width/5,20,20,width/20,width/20);
  save("improved_sample_mousedraw_3.png");
}


/* This is the hard-code of the recreation
rect(276,273,325,299);
rect(500,440,50,50);
rect(420,400,100,100);
rect(220,180,465,450);
rect(225,270,400,410);
rect(235,150,490,455);
rect(280,170,450,425);
rect(278,185,400,390);
rect(410,380,92,92);
rect(270,195,365,380);
rect(262,226,500,490);
rect(330,340,225,220);
rect(260,260,370,340);
rect(292,200,432,425);
rect(275,267,325,340);
rect(415,370,35,37);
rect(340,285,250,255);
rect(417,310,150,155);
rect(337,332,180,183);
rect(362,295,245,245);
rect(455,345,65,65);
rect(376,300,275,270);
rect(385,312,120,125);
rect(371,330,208,205);
rect(430,355,115,112);
rect(429,370,165,165);
rect(286,260,316,309);
*/
