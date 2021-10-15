PImage img;
int square_size = 15;

void setup(){
  size(600,900);
  img = loadImage("test.jpg");
  
  if(img.width*1.0/img.height < width*1.0/height){
    img.resize(width,0);
  }else{
    img.resize(0, height);
  }
  //img.resize(width,height);
  //noLoop();
}

void diagonal_color(PImage im, int pos_x,int pos_y,int side){
  
  //given a specified rectangle area, take the top-most pixel and draw a rectangle of 
  //specified dimensions with that pixel's color
  //pos_x and pos_y are the starting coordinate of the square
  //side is square side length
  im.loadPixels();
  for (int i =0; i<side/2; i++){
    color c1 = img.pixels[(pos_y+i)*img.width +i+pos_x];//top left
    color c2 = img.pixels[(pos_y+(side-i-1))*img.width +pos_x+i];//bottom left
    color c3 = img.pixels[(pos_y+i)*img.width +pos_x+(side-i-1)];//top right
    color c4 = img.pixels[(pos_y+(side-i-1))*img.width +pos_x+(side-i-1)]; 
    
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
    rect(pos_x+i,pos_y+i,side-2*i,side-2*i);
  }
}

ArrayList<Integer> divisors(int n){
  ArrayList<Integer> result = new ArrayList<>();
  for(int i=1; i<n/2+1; i++){
    if (n%i ==0){
      result.add(i);
    }
    result.add(n);
  }
  return result;
}

void draw(){
  frameRate(15);
  for (int r = 0; r< width/square_size; r++){
    for (int c = 0; c< height/square_size; c++){
      diagonal_color(img, r*square_size,c*square_size, square_size);
    }
  }
  for (Integer i: divisors(width)){
    if (mouseX/10>i){
      square_size = i;
    }
  }

  saveFrame("dance1.png");
}
