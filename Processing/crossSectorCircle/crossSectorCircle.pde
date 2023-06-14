float theta=PI/2;
float R=200;
float center[]={300,200};
float r=50;
void setup(){
  size(600,600);
}
void draw(){
  background(255);
  boolean cross=false;
  cross=cross || pow(mouseX-center[0],2)+pow(mouseY-center[1],2)<=pow(r,2);
  float A[][]={{R*sin(theta/2),-R*sin(theta/2)},{R*cos(theta/2),R*cos(theta/2)}};
  float detA=det2x2(A);
  float Dx[][]={{mouseX-center[0],-R*sin(theta/2)},{mouseY-center[1],R*cos(theta/2)}};
  float detDx=det2x2(Dx);
  float Dy[][]={{R*sin(theta/2),mouseX-center[0]},{R*cos(theta/2),mouseY-center[1]}};
  float detDy=det2x2(Dy);
  float x=detDx/detA;
  float y=detDy/detA;
  cross=cross || x>0 && y>0 && pow(mouseX-center[0],2)+pow(mouseY-center[1],2)<=pow(r+R,2);
  for(int i=0;i<2;i++){
    float vx=A[0][i],vy=A[1][i];
    float a=pow(vx,2)+pow(vy,2);
    float b=-2*((mouseX-center[0])*vx+(mouseY-center[1])*vy);
    float c=pow(mouseX-center[0],2)+pow(mouseY-center[1],2)-pow(r,2);
    float D=pow(b,2)-4*a*c;
    if(D<0)continue;
    float t=(-b-sqrt(D))/(2*a);
    cross = cross || t>=0 && t<=1;
  }
  if(cross)fill(255,200,200);
  else fill(200,200,255);
  arc(center[0],center[1],2*R,2*R,PI/2-theta/2,PI/2+theta/2);
  ellipse(mouseX,mouseY,2*r,2*r);
}
float det2x2(float matrix[][]){
  return matrix[0][0]*matrix[1][1]-matrix[0][1]*matrix[1][0];
}
