//initialize
float[] d = new float[1000]; 
//int timer;
int max=10; 
float START_weight = 5;
float speed = 1;
void setup(){
  size(1000,1000);
  strokeWeight(START_weight);
}

void draw() {
  background(0);
  fill(0);
  noFill();
  stroke(255, 100, 0);

  for (int i = 0; i<max; i++) {
    //change line width
    strokeWeight(START_weight-(START_weight-1)/max*0.8*i);
    //change color
    stroke(255-i*20,170+i*150/max,0);
    
    ellipse (width/2, height/2, d[i]*speed, d[i]*speed); 
    d[i]=d[i]+1+0.1*pow(i,1+0.08/max);
    //alpha(220-i*30);
  }
saveFrame("circle1.png");
}
