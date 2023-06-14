float lineXY[]={400,150};
float lineInit[]={100,200};
float lineR=50;
float r=40;
void setup(){
  size(600,600);
}
void draw(){
  float t=(lineXY[0]*(mouseX-lineInit[0])+lineXY[1]*(mouseY-lineInit[1]))/(pow(lineXY[0],2)+pow(lineXY[1],2));
  t = t>1?1:t;
  t = t<0?0:t;
  if(pow(mouseX-lineXY[0]*t-lineInit[0],2)+pow(mouseY-lineXY[1]*t-lineInit[1],2)<=pow(r+lineR,2))fill(255,200,200);
  else fill(200,200,255);
  background(255);
  ellipse(lineInit[0],lineInit[1],2*lineR,2*lineR);
  ellipse(lineInit[0]+lineXY[0],lineInit[1]+lineXY[1],2*lineR,2*lineR);
  float inv=-lineXY[0]/lineXY[1];
  float addX=sqrt(pow(lineR,2)/(1+pow(inv,2)));
  float addY=inv*addX;
  quad(lineInit[0]+addX,lineInit[1]+addY,lineInit[0]+lineXY[0]+addX,lineInit[1]+lineXY[1]+addY,lineInit[0]+lineXY[0]-addX,lineInit[1]+lineXY[1]-addY,lineInit[0]-addX,lineInit[1]-addY);
  line(lineInit[0],lineInit[1],lineInit[0]+lineXY[0],lineInit[1]+lineXY[1]);
  ellipse(mouseX,mouseY,2*r,2*r);
  float x=lineXY[0],y=lineXY[1];
  lineXY[0]=x*cos(PI/200)-y*sin(PI/200);
  lineXY[1]=x*sin(PI/200)+y*cos(PI/200);
}
