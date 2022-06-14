final int window=600;
float[] xy=new float[6];
void settings(){
  size(window,window);
}
void setup(){
  textAlign(CENTER,CENTER);
  strokeWeight(10);
  textSize(30);
}
void draw(){
  translate(window/2,window/2);
  background(0);
  frameRate(1);
  stroke(255);
  fill(0);
  ellipse(0,0,window-20,window-20);
  fill(255);
  for(int i=0;i<60;i++){
    point(cos((60.-i)/30.*PI+PI/2.)*window/2.2,-sin((60.-i)/30.*PI+PI/2.)*window/2.2);
  }
  for(int i=0;i<12;i++){
    text(str(i),cos((12.-i)/6.*PI+PI/2.)*window/2.5,-sin((12.-i)/6.*PI+PI/2.)*window/2.5);
  }
  xy[0]=cos((12.-hour())/6.*PI+PI/2.);
  xy[1]=sin((12.-hour())/6.*PI+PI/2.);
  xy[2]=cos((60.-minute())/30.*PI+PI/2.);
  xy[3]=sin((60.-minute())/30.*PI+PI/2.);
  xy[4]=cos((60.-second())/30.*PI+PI/2.);
  xy[5]=sin((60.-second())/30.*PI+PI/2.);
  int[] rgb={0,0,0};
  for(int i=0;i<3;i++){
    rgb[i]=255;
    stroke(rgb[0],rgb[1],rgb[2]);
    point(xy[i*2]*window/2.2,-xy[i*2+1]*window/2.2);
    rgb[i]=0;
  }
  stroke(255);
  line(0,0,(xy[0]+xy[2]+xy[4])*window/9.,(-xy[1]-xy[3]-xy[5])*window/9.);
  translate((xy[0]+xy[2]+xy[4])*window/9.,(-xy[1]-xy[3]-xy[5])*window/9.);
  if((xy[0]+xy[2]+xy[4])<0)
    rotate(atan((-xy[1]-xy[3]-xy[5])/(xy[0]+xy[2]+xy[4]))-PI/2);
  else
    rotate(atan((-xy[1]-xy[3]-xy[5])/(xy[0]+xy[2]+xy[4]))+PI/2);
  triangle(5,5,-5,5,0,0);
}
