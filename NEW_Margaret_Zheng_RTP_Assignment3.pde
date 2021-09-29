//hardcode
PFont f;

void setup(){
  size(600,800);
  background(243,235,222);
  f = createFont("NHaasGroteskTXPro-75Bd.ttf", 18);
  textFont(f);
}

void text_with_kerning(String str, float[]kern, float[] Color, float[]alpha, float[]font_size, float pos_x, float pos_y, float angleRotate){
  /*
  basically lets you draw text with coloc, transparency settings while kerning
  str = the input text
  kern = kerning for each letter
  Color = [x,y,z] 3-element array specifying RGB value
  alpha = array specifying transparency for each letter
  font_size = font size for each letter
  pos_x = start position of x
  pos_y = starting position of y
  *note: alpha, font_size, and kern all need to have the correct number of elements, otherwise we will just alternate
  */
  int text_length = str.length();
  for (int i=0; i<text_length; i++){
    char ch = str.charAt(i);
    pushMatrix();
    //text properties
    translate(pos_x,pos_y);
    rotate(angleRotate);
    fill(Color[0],Color[1],Color[2],alpha[i%alpha.length]);
    textSize(font_size[i%font_size.length]);
    text(ch, kern[i%kern.length],0);
    popMatrix();
  }
}

// starting set for testing
int std_dis = 103;
float[]kerning = new float[]{0,std_dis,std_dis*2,std_dis*3,std_dis*4, std_dis*5, std_dis*6, std_dis*7, std_dis*8, std_dis*9, std_dis*10,std_dis*11};
float[]Red = new float[]{180,10,70};
float[]Yellow = new float[]{250,235,0};
float[]Blue = new float[]{0,130,220};
float[]font_size = new float[]{150};
float angleRotate = radians(270);

float x_1 = 120;
float x_2 = 120;
float x_3 = 120;
float y_1 = 730;
float y_2 = 750;
float y_3 = 770;


void draw(){
  
  text_with_kerning("BAUHAUS", kerning, Yellow, new float[]{100}, font_size, x_1, y_1, angleRotate);
  text_with_kerning("BAUHAUS", kerning, Red, new float[]{100}, font_size, x_2, y_2, angleRotate);
  text_with_kerning("BAUHAUS", kerning, Blue, new float[]{60}, font_size, x_3, y_3, angleRotate);
  
  for (int i=0; i<3; i++){
    Red[i]+= random(-5,5);
    Yellow[i] += random(-5,5);
    Blue[i] += random(-5,5);
  }
  
  /*
  x_1 += 0.4;
  x_2 += 0.8;
  x_3 += 1.2;
  */
  
  /*
  for (int i=0; i< kerning.length; i++){
    kerning[i] += random(-1,1);
  }
  */
  //angleRotate += radians(1);
 
  
  saveFrame("recreation_animate.png");
  

  
  
  
  /* all things below are for the randomized color and motion effect
  int std_dis = 30;
  float[]kerning = new float[]{0,std_dis,std_dis*2,std_dis*3,std_dis*4, std_dis*5, std_dis*6, std_dis*7, std_dis*8, std_dis*9, std_dis*10,std_dis*11};
  float[]Color = new float[]{255,255,255};
  float[]alpha = new float[]{100,100,100,100,120,130,150,160,170,180,190};
  float[]font_size = new float[]{50,50,50,50};
  float pos_x = width/2;
  float pos_y = height/2;
  float angleRotate = radians(1.0);
  angleRotate += radians(3)*random(-0.5,4);
  
  Color[0]=(Color[0]+randomGaussian()*10)%255;
  Color[1]=(Color[1]+randomGaussian()*10)%255;
  Color[2]=(Color[2]+randomGaussian()*10)%255;
  
  for (int i = 0; i<3; i++){
    if (Color[i]>0 & Color[0]<255){
      Color[i] = Color[i]+randomGaussian()*10.0;
    }else if(Color[i]<0){
      Color[i] = Color[i]+random(0,30);
    }else if(Color[i]>255){
      Color[i] = Color[i]-random(0,30);
    }
  }
 
  //restrict so it does not go out of bound
  if (pos_x<width & pos_x >0){
    pos_x+=random(-width/30,width/30);
  }else if (pos_x<0){
    pos_x+=width/10;
  }else if (pos_x>width){
    pos_x-=width/10;
  }
    
  if (pos_y<height & pos_y >0){
    pos_y+=random(-height/30,height/30);
  }else if (pos_y<0){
    pos_y+=height/20;
  }else if (pos_y>height){
    pos_y-=height/20;
  }
  println("current position", pos_x, pos_y);
  println("current color",Color[0],Color[1],Color[2]);

  //text_with_kerning("marge_z_art", kerning, Color, alpha, font_size, width/2, height/2, angleRotate*1.2);
  text_with_kerning("Gloria Lin", kerning,  new float[]{2*Color[0],2*Color[1],2*Color[2]}, alpha, font_size, pos_x, pos_y, angleRotate);
  text_with_kerning("@gzlin", kerning, new float[]{3*Color[0],4*Color[1],5*Color[2]}, alpha, font_size, 1.2*pos_x,1.2*pos_y, angleRotate*3);
  //text_with_kerning("there", kerning, new float[]{2*Color[0],2*Color[1],2*Color[2]}, alpha, font_size, width/2-100, height/2+100, angleRotate*-1);
  saveFrame("gzlin1.png");
  */
}
