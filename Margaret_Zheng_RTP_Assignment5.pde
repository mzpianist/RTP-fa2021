PImage img;
int square_size = 20;
PFont extrathin;
PFont thin ;
PFont medium;
PFont bold;
PFont extrabold;
int t = 0;

void setup(){
  size(560,800);
  img = loadImage("statue_of_liberty.png");
  
  if(img.width/img.height < width/height){
    img.resize(width,0);
  }else{
    img.resize(0, height);
  }
  
  /*
  Goal 0: change img to grayscale
  */
  //img.filter(GRAY);
  img.filter(THRESHOLD,0.6);
  
  //make all the fonts
  extrathin = createFont("Heading-Pro-Wide-Thin-trial.ttf",square_size+t);
  thin = createFont("Pixel Coleco.otf",square_size+3+t);
  medium = createFont("Square One.ttf",square_size+t);
  bold= createFont("Square One Bold.ttf",square_size+t);
  extrabold = createFont("Digitek.ttf",square_size-2+t);
}

/*
Goal 1: make a function avg_brightness(img, n) that returns a 2D array
that stores the average brightness of a block of pixel of side length n pixels on image img).
each entry in the 2D array should be 0 to 255.
*/

int[][] avg_brightness(PImage image, int n){
  image.loadPixels();
  int num_col = image.width/n; //how many squares wide
  int num_row = image.height/n; //how many squares tall
  
  int[][]bright = new int[num_row][num_col]; //return this
  for (int r=0; r<num_row; r++){
    for (int c=0; c<num_col; c++){ // for each block
    int brightness_sum = 0;
      for (int i=0; i<n; i++){ //width
        for(int j=0; j<n; j++){ //height
          int location = (r*n+i)*image.width+(c*n+j);
          brightness_sum += brightness(img.pixels[location]);
        }
      } 
      bright[r][c]= brightness_sum/(n*n);
    }
  }
  return bright;
}

/*
Goal 1.5: Intermediate pixelating function to see if goal 1 function works
n is size of pixellation
*/
void pixelate(PImage image,int n){
  int[][]bright = avg_brightness(img,n);
  int num_col = image.width/n; //how many squares wide
  int num_row = image.height/n; //how many squares tall
  
  for (int r=0; r<num_row; r++){
    for (int c=0; c<num_col; c++){ // for each block   
      noStroke();
      fill(bright[r][c]);
      rect(c*n,r*n,n,n);
    }
  }
}

/*
Goal 2: given any string, remove spaces; return an string with no spaces
*/
String remove_spaces(String original){
  String new_str= "";
  for (int i=0; i<original.length(); i++){
    if(original.charAt(i) !=' '){
      new_str +=original.charAt(i);
    }
  }
  return new_str;
}

/*
Goal 3: Figure something out for lettering 
write a function alter_letter(brightness, f) that, given int brightness and font f,
returns a fattened or thinned letter
probably need to download some sort of lettering
*/

void draw_letters(PImage image,int n,String s){
  int[][]bright = avg_brightness(img,n);
  int num_col = image.width/n; //how many squares wide
  int num_row = image.height/n; //how many squares tall
  
  for (int r=0; r<num_row; r++){
    for (int c=0; c<num_col; c++){ // for each block 
    
      int str_index = (r*num_col + c)%s.length();
      int br = bright[r][c];
      noStroke();
      fill(0);
      rect(c*n,r*n,n,n);
      /*
      br = 1-50: small font
      br = 50-100: medium
      br = 100-175: medium thick
      */
      if(br<=25){
        textFont(extrathin);
      }else if(br>=25 & br<75){
        textFont(thin);
      }else if(br>=75 & br<150){
        textFont(medium);
      }else if(br>=150 & br<200){
        textFont(bold);
      }else if(br>=220 & br<256){
        textFont(extrabold);
      }
      fill(255);
      text(s.charAt(str_index),c*n,r*n);
    }
  }
}

void draw(){
  background(0);
  //image(img,0,0); 
  
  
  //Uncomment to test
  /*
  //Test 1:
  int[][]test_bright = avg_brightness(img,test_s);
  for (int i = 0; i< img.width/test_s; i++){
    println("I am at integer",i);
    println("height is",img.height, "; Width is", img.width, img.width/test_s);
    println("test_bright[1][",i,"] has brightness",test_bright[1][i]);
  }
  */
  
  //pixelate(img, square_size);
  //println(remove_spaces("hello world hi"));
  String s = "Sometimes it's simply better to ignore the haters. That's the lesson that Tom's dad had been trying to teach him, but Tom still couldn't let it go. He latched onto them and their hate and couldn't let it go, but he also realized that this wasn't healthy. That's when he came up with his devious plan.";
  draw_letters(img,square_size,remove_spaces(s));

}
