PImage imgA,imgB;
float t=0;
void setup(){
  size(600,600,P2D);
  imgA=loadImage("a.png");
  imgB=loadImage("b.png");
  noStroke();
}
void draw(){
  background(255);
  tint(255,255);
  beginShape();
  texture(imgA);
  vertex(0,0,0,0);
  vertex(0,t,0,imgA.height*t/600.);
  vertex(t,0,imgA.width*t/600.,0);
  endShape();
  beginShape();
  texture(imgB);
  vertex(600,600,imgB.width,imgB.height);
  vertex(600,-600+t,imgB.width,imgB.height*(-600+t)/600.);
  vertex(-600+t,600,imgB.width*(-600+t)/600.,imgB.height);
  endShape();
  for(int i=0;i<255;i+=10){
  tint(255,255-i);
  beginShape();
  texture(imgB);
  vertex(t-i,0,imgB.width*(t-i-1)/600.,0);
  vertex(t-i+10,0,imgB.width*(t-i+10)/600.,0);
  vertex(t-600-i+10,600,imgB.width*(t-600-i+10)/600.,imgB.height);
  vertex(t-600-i,600,imgB.width*(t-600-i)/600.,imgB.height);
  endShape();
  }
  t+=4;
}
