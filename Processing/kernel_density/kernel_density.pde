final float H=1;
void setup(){
  size(1000,500);
}
void draw(){
  background(255);
  noLoop();
  float data[]={4.2,5,2.3,5.9,6,4.8,3.6,4.6,2,8,6.9,5.4,3.8,4,4.4,5.1,8.7,7.9,8.5};
  translate(500,400);
  stroke(0);
  line(0,-400,0,100);
  line(-500,0,500,0);
  final float mid=(min(data)+max(data))/2;
  final float range=abs(max(data)-min(data))*2;
  stroke(255,0,0);
  for(int i=0;i<data.length;i++){
    float x=(data[i]-mid)*1000/range;
    line(x,0,x,-50);
  }
  float y[]=new float[1001];
  for(int i=-500;i<=500;i++){
    float x=range*i/1000+mid;
    y[i+500]=kernelDensity(x,data,H);
  }
  final float heightAmp=300/max(y);
  fill(0);
  stroke(0);
  line(-5,-300,5,-300);
  textSize(20);
  text(round(max(y)*100)+"%",15,-300);
  text("0%",10,0);
  text(str(mid),0,20);
  text(str(max(data)),250,20);
  text(str(min(data)),-250,20);
  for(int i=0;i<1000;i++){
    line(i-500,-y[i]*heightAmp,i-499,-y[i+1]*heightAmp);
  }
}
float kernelDensity(float x,float data[],float h){
  float result=0;
  for(int i=0;i<data.length;i++){
    result+=exp(-pow((data[i]-x)/h,2)/2);
  }
  result/=sqrt(2*PI)*h*data.length;
  return result;
}
