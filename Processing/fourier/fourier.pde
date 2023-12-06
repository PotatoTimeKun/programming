float f(float x){
  if(x<=-PI)return abs(x-2*int((int(x/PI)-1)/2)*PI);
  return abs(x-2*int((int(x/PI)+1)/2)*PI);
}

float a_n(int n){
  if(n==0)return PI;
  if(n%2==0)return 0;
  return -4/PI/n/n;
}

float b_n(int n){
  return 0;
}

float f_fourier(float x,int nMax){
  float sum=a_n(0)/2;
  for(int n=1;n<nMax;n++){
    sum+=a_n(n)*cos(n*x)+b_n(n)*sin(n*x);
  }
  return sum;
}

void setup(){
  size(600,400);
  textSize(20);
}

int fourier_n=50;

void draw(){
  noLoop();
  background(255);
  pushMatrix();
    translate(300,100);
    stroke(0);
    line(-300,0,300,0);
    line(0,50,0,-50);
    fill(0);
    text("f(x)",-250,-70);
    stroke(255,0,0);
    float start[]={-4*PI,f(-4*PI)};
    for(float x=-4*PI;x<4*PI;x+=8*PI/600){
      line(start[0]*300/PI/4,-start[1]*50/PI,x*300/PI/4,-f(x)*50/PI);
      start[0]=x;
      start[1]=f(x);
    }
  popMatrix();
  pushMatrix();
    translate(300,300);
    stroke(0);
    line(-300,0,300,0);
    line(0,50,0,-50);
    fill(0);
    text("f(x) (fourier) n="+str(fourier_n),-250,-70);
    stroke(255,0,0);
    start[0]=-4*PI;
    start[1]=f_fourier(-4*PI,fourier_n);
    for(float x=-4*PI;x<4*PI;x+=8*PI/600){
      line(start[0]*300/PI/4,-start[1]*50/PI,x*300/PI/4,-f_fourier(x,fourier_n)*50/PI);
      start[0]=x;
      start[1]=f_fourier(x,fourier_n);
    }
  popMatrix();
}
