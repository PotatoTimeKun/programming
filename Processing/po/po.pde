float x,y;
int r=0;
void setup(){
  size(600,600);
}
void draw(){
  translate(300,300);
  translate(sin(radians(r))*150,cos(radians(r))*150);
  frameRate(50);
  background(0);
  stroke(0,100,0);
  y=0;
  for(x=-450;x<451;x++){
    ellipse(x,-y,2,2);
  }
  stroke(100,0,0);
  x=0;
  for(y=-450;y<451;y++){
    ellipse(x,-y,2,2);
  }
  stroke(255);
  fill(255);
  for(x=-30;x<31;x+=0.1){
    y=pow(x,3);
    ellipse(x*10*cos(radians(r))-y*sin(radians(r)),-(x*10*sin(radians(r))+y*cos(radians(r))),6,6);
  }
  int rr=r+90;
  for(x=-30;x<31;x+=0.1){
    y=pow(x,3);
    ellipse(x*10*cos(radians(rr))-y*sin(radians(rr)),-(x*10*sin(radians(rr))+y*cos(radians(rr))),6,6);
  }
  r=(r+1)%361;
}
