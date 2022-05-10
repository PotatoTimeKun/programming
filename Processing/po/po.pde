float x,y;
int r=0;
void setup(){
  size(600,600);
  frameRate(50);
  strokeWeight(4);
}
void draw(){
  translate(300, 300);
  translate(sin(radians(r))*150, cos(radians(r))*150);
  background(0);
  stroke(0,100,0);
  line(-450, 0, 450, 0);
  stroke(100,0,0);
  line(0, -450, 0, 450);
  stroke(255);
  fill(255);
  for(x=0;x<9;x+=0.1){
    y=pow(x,3);
    ellipse(x*10*cos(radians(r))-y*sin(radians(r)), -(x*10*sin(radians(r))+y*cos(radians(r))), 6, 6);
    ellipse(-(x*10*cos(radians(r))-y*sin(radians(r))), (x*10*sin(radians(r))+y*cos(radians(r))), 6, 6);
  }
  int r_reversed=r+90;
  for(x=-30;x<31;x+=0.1){
    y=pow(x,3);
    ellipse(x*10*cos(radians(r_reversed))-y*sin(radians(r_reversed)), -(x*10*sin(radians(r_reversed))+y*cos(radians(r_reversed))), 6, 6);
    ellipse(-(x*10*cos(radians(r_reversed))-y*sin(radians(r_reversed))), (x*10*sin(radians(r_reversed))+y*cos(radians(r_reversed))), 6, 6);
  }
  r=(r+1)%361;
}
