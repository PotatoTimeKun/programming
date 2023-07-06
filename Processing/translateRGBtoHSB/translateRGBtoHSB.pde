int h(int r,int g,int b){
  float range=max(r,g,b)-min(r,g,b);
  if(range==0)range=1;
  if(g==max(r,g,b))
    return int(((b-r)/range+2)*255/6);
  else if(b==max(r,g,b))
    return int(((r-g)/range+4)*255/6);
  return int((((g-b)/range+6)*255/6)%255);
}
int s(int r,int g,int b){
  int maxRGB=max(r,g,b)==0?1:max(r,g,b);
  return (max(r,g,b)-min(r,g,b))*255/maxRGB;
}
int b(int r,int g,int b){
  return max(r,g,b); 
}

void setup(){
  size(500,500);
}
int rgb[]={0,0,0};
void draw(){
  background(255);
  pushMatrix();
  translate(100,130);
  stroke(255,0,0);
  line(-255/2*60./100,255/2*60./100,255/2*60./100,255/2*60./100);
  stroke(0,255,0);
  line(-255/2*60./100,255/2*60./100,-255/2*60./100,-255/2*60./100);
  stroke(0,0,255);
  line(-255/2*60./100,255/2*60./100,-255/2*60./100+255/5.,255/2*60./100-255/5.);
  stroke(0);
  fill(0);
  ellipse((rgb[0]-255/2)*60./100+rgb[2]/5.,(-rgb[1]+255/2)*60./100-rgb[2]/5.,4,4);
  popMatrix();
  pushMatrix();
  translate(100,400);
  line(-255/2*60./100,255/2*60./100,255/2*60./100,255/2*60./100);
  line(-255/2*60./100,255/2*60./100,-255/2*60./100,-255/2*60./100);
  line(-255/2*60./100,255/2*60./100,-255/2*60./100+255/5.,255/2*60./100-255/5.);
  stroke(0);
  fill(0);
  ellipse((h(rgb[0],rgb[1],rgb[2])-255/2)*60./100+b(rgb[0],rgb[1],rgb[2])/5.,(-s(rgb[0],rgb[1],rgb[2])+255/2)*60./100-b(rgb[0],rgb[1],rgb[2])/5.,4,4);
  popMatrix();
  textSize(20);
  text("RGB",10,20);
  text("rgb=("+str(rgb[0])+","+str(rgb[1])+","+str(rgb[2])+")",280,100);
  text("HSB",10,300);
  text("hsb=("+str(h(rgb[0],rgb[1],rgb[2]))+","+str(s(rgb[0],rgb[1],rgb[2]))+","+str(b(rgb[0],rgb[1],rgb[2]))+")",280,400);
  fill(rgb[0],rgb[1],rgb[2]);
  rect(300,0,100,50);
  colorMode(HSB);
  fill(h(rgb[0],rgb[1],rgb[2]),s(rgb[0],rgb[1],rgb[2]),b(rgb[0],rgb[1],rgb[2]));
  rect(300,300,100,50);
  colorMode(RGB);
}
void keyPressed(){
  if(key=='d')rgb[0]++;
  if(key=='a')rgb[0]--;
  if(key=='w')rgb[2]++;
  if(key=='s')rgb[2]--;
  if(key==' ')rgb[1]++;
  if(keyCode==SHIFT)rgb[1]--;
  for(int i=0;i<3;i++){
    if(rgb[i]<0)rgb[i]=0;
    if(rgb[i]>255)rgb[i]=255;
  }
}
