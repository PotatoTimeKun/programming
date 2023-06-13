final float H=1; //バンド幅
float data[]={4.2,5,2.3,5.9,6,4.8,3.6,4.6,2,8,6.9,5.4,3.8,4,4.4,5.1,8.7,7.9,8.5};//標本
float graphData[]=new float[1001];
final float mid=(min(data)+max(data))/2;
final float range=abs(max(data)-min(data))*2;
void setup(){
  size(1000,500);
  for(int i=-500;i<=500;i++){
    float x=range*i/1000+mid;
    graphData[i+500]=kernelDensity(x,data,H);
  }
  textSize(20);
}
void draw(){
  background(255);
  translate(500,400);
  stroke(200);
  final float heightAmp=300/max(graphData);
  float sum=0;
  for(int i=0;i<mouseX;i++){
    sum+=graphData[i]*range/1000;
    line(i-500,0,i-500,-graphData[i]*heightAmp);
  }
  stroke(0);
  line(0,-400,0,100);
  line(-500,0,500,0);
  stroke(255,0,0);
  for(int i=0;i<data.length;i++){
    float x=(data[i]-mid)*1000/range;
    line(x,0,x,-50);
  }
  fill(0);
  stroke(0);
  line(-5,-300,5,-300);
  text(round(max(graphData)*100)+"%",15,-300);
  text("0%",10,0);
  text(str(mid),0,20);
  text(str(max(data)),250,20);
  text(str(min(data)),-250,20);
  for(int i=0;i<1000;i++){
    line(i-500,-graphData[i]*heightAmp,i-499,-graphData[i+1]*heightAmp);
  }
  stroke(0,0,255);
  float mouseXdensity=kernelDensity((mouseX-500)*range/1000+mid,data,H);
  line(mouseX-500,0,mouseX-500,-mouseXdensity*heightAmp);
  fill(0,0,255);
  text(round(mouseXdensity*100)+"%",mouseX-500,-mouseXdensity*heightAmp);
  fill(100);
  text(sum,mouseX-500,-mouseXdensity*heightAmp-20);
}
float kernelDensity(float x,float data[],float h){
  float result=0;
  for(int i=0;i<data.length;i++){
    result+=exp(-pow((data[i]-x)/h,2)/2);
  }
  result/=sqrt(2*PI)*h*data.length;
  return result;
}
