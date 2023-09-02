final float ang_max=PI/3;
final float g=9.8;
final float m=1;
final float S_0=m*g*(3-2*cos(ang_max));
float S,ang,t,l,angSpeed,angStart;
boolean start=false;
boolean over=false;
float fallX,fallY;

void setup(){
  size(600,600);
}
void draw(){
  background(255);
  if(!start)return;
  if(S>=S_0){
    textSize(20);
    fill(0);
    stroke(0);
    strokeWeight(1);
    text("maxAng="+str(angStart)+"\nS_0="+str(S_0),20,20);
    if(!over){
      fallX=l*100*sin(ang)+300;
      fallY=l*100*cos(ang);
      t=0;
      over=true;
    }
    translate(fallX,fallY);
    fill(0,0,255);
    stroke(0,0,255);
    strokeWeight(2);
    ellipse(l*100*angSpeed*cos(ang)*t,-l*100*angSpeed*sin(ang)*t+100*m*g*t*t/2,10,10);
    t+=1./frameRate;
    return;
  }
  angSpeed+=-g/l*sin(ang)/frameRate;
  ang+=angSpeed/frameRate;
  S=m*g*(3*cos(ang)-2*cos(angStart));
  t+=1./frameRate;
  textSize(20);
  fill(0);
  stroke(0);
  strokeWeight(1);
  text("maxAng="+str(angStart)+"\nS="+str(S)+"\nS_0="+str(S_0),20,20);
  translate(300,0);
  fill(0,0,255);
  stroke(0,0,255);
  strokeWeight(2);
  line(0,0,l*100*sin(ang),l*100*cos(ang));
  ellipse(l*100*sin(ang),l*100*cos(ang),10,10);
}
void mousePressed(){
  start=true;
  over=false;
  final float X=mouseX-300,Y=mouseY;
  l=sqrt(pow(X,2)+pow(Y,2))/100;
  ang=atan(X/Y);
  angStart=ang;
  angSpeed=0;
  S=m*g*(3*cos(ang)-2*cos(angStart));
  t=0;
}
