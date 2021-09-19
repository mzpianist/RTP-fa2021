//initialize
float[] d = new float[1000]; 
//int timer;
int max=10; 
float START_weight = 5;

void setup(){
  size(600,600);
  strokeWeight(START_weight);
}

 

void draw() {

  background(0);
  fill(0);
  noFill();
  stroke(255, 100, 0);

  for (int i = 0; i<max; i++) {
    //change line width
    strokeWeight(START_weight-(START_weight-1)/max*1.0*i);
    //change color
    stroke(255-i*20,170+i*150/max,0);
    
    ellipse (width/2, height/2, d[i]*0.5, d[i]*0.5); 
    d[i]=d[i]+1+0.1*pow(i,1+0.08/max);
    //alpha(220-i*30);
  }
//saveFrame("circle.png");
}
