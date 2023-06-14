float Rect[]={100,200,300,200};
float R=30;
void setup(){
  size(600,600);
}
void draw(){
  background(255);
  rect(Rect[0],Rect[1],Rect[2],Rect[3]);
  boolean crossRect;
  crossRect=inRect(Rect[0]-R,Rect[1],Rect[0]+Rect[2]+R,Rect[1]+Rect[3],mouseX,mouseY);
  crossRect=crossRect||inRect(Rect[0],Rect[1]-R,Rect[0]+Rect[2],Rect[1]+R+Rect[3],mouseX,mouseY);
  for(int i=0;i<2;i++)
    for(int j=0;j<2;j++)
      crossRect=crossRect||inCircle(mouseX,mouseY,R,Rect[0]+i*Rect[2],Rect[1]+j*Rect[3]);
  if(crossRect)fill(255,200,200);
  else fill(200,200,255);
  ellipse(mouseX,mouseY,2*R,2*R);
}
boolean inRect(float x1,float y1,float x2,float y2,float x,float y){
  if(min(x1,x2)<=x && max(x1,x2)>=x && min(y1,y2)<=y && max(y1,y2)>=y)return true;
  return false;
}
boolean inCircle(float centerX,float centerY,float r,float x,float y){
  if(pow(centerX-x,2)+pow(centerY-y,2)<=pow(r,2))return true;
  return false;
}
