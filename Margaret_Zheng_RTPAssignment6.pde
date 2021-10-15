PImage img;

void setup(){
  size(600,700);
  img = loadImage("mcc.jpg");
  img.resize(width,height);
  //noLoop();
}
/*
void diagonal_color(PImage im, int pos_x,int pos_y,int w,int h){
  
  //given a specified rectangle area, take the top-most pixel and draw a rectangle of 
  //specified dimensions with that pixel's color
  //pos_x and pos_y are the starting coordinate
  //w and h are the dimensions of rectangle
  
  im.loadPixels();
  color c = get(pos_x,pos_y);
  fill(c);
  rect(pos_x,pos_y,w,h);
}
*/

//single picture output

void draw(){
  image(img,0,0);
  int num_rect = min(width/2,height/2);
  for (int i =0; i<num_rect; i++){
    img.loadPixels();
    color c1 = img.pixels[i*width+i];//top left
    color c2 = img.pixels[(height-i-1)*width+i];//bottom left
    color c3 = img.pixels[i*width+(width-i-1)];//top right
    color c4 = img.pixels[(height-i-1)*width+(width-i-1)]; //bottom right
    
    color col;
    float ran = random(0,1);
    if (ran <0.25){
      col = c1;
    }else if (ran < 0.5){
      col = c2;
    }else if (ran<0.75){
      col = c3;
    }else{
      col = c4;
    }
    fill(col);

    noStroke();
    rect(i,i,width-2*i,height-2*i);   
  }
  saveFrame("me_vksdjqh.png");
}
