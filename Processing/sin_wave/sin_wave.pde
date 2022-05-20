final int window_x=1000;
final int window_y=700;
float t=0,T=1,lambda=200, A=100;
float T2=1,lambda2=200, A2=100;
int sign=1;
void settings(){
  size(window_x,window_y);
}
void setup(){
  textSize(20);
  frameRate(100);
}
void draw(){
  background(0);
  stroke(255);
  fill(255);
  text("Enter -> Button Change(swap +/-)",700,20);
  text("y",60,120);
  text("x",window_x-20,(window_y-100)/2+120);
  translate(50,(window_y-100)/2+100);
  line(-50,0,window_x-50,0);
  line(0,-(window_y-100)/2,0,(window_y-100)/2);
  stroke(255,0,0);
  fill(255,0,0);
  for(int x=-50;x<window_x-50;x++){
    if(x>t*lambda/T)break;
    ellipse(x,A*sin(2.0*PI*(t/T-x/lambda)),5,5);
  }
  fill(0,255,0);
  stroke(0,255,0);
  for(int x=0;x<window_x;x++){
    if(x>t*lambda2/T2)break;
    ellipse(window_x-x-50,A2*sin(2.0*PI*(t/T2-x/lambda2)),5,5);
  }
  fill(0,0,255);
  stroke(0,0,255);
  for(int x=-50;x<window_x;x++){
    if(x<=t*lambda/T && x>=window_x-50-t*lambda2/T2)
      ellipse(x,A*sin(2.0*PI*(t/T-x/lambda))+A2*sin(2.0*PI*(t/T2-(window_x-x-50)/lambda2)),5,5);
  }
  translate(-50,-(window_y-100)/2-100);
  fill(255,0,0);
  String tx="";
  if(sign==1)tx="+";
  text("t="+nf(t,0,2),10,20);
  text(tx+sign,10,40);
  text(tx+(10*sign),40,40);
  text("A="+A,90,40);
  text(tx+sign,10,60);
  text(tx+nf((0.1*sign),0,1),40,60);
  text("T="+nf(T,0,1),90,60);
  text(tx+sign,10,80);
  text(tx+(10*sign),40,80);
  text("lambda="+lambda,90,80);
  fill(0,255,0);
  text("t="+nf(t,0,2),410,20);
  text(tx+sign,410,40);
  text(tx+(10*sign),440,40);
  text("A="+A2,490,40);
  text(tx+sign,410,60);
  text(tx+nf((0.1*sign),0,1),440,60);
  text("T="+nf(T2,0,1),490,60);
  text(tx+sign,410,80);
  text(tx+(10*sign),440,80);
  text("lambda="+lambda2,490,80);
  t+=0.01;
}
void mousePressed(){
  if(mouseX<35){
    if(mouseY<20)return;
    else if(mouseY<40)A+=sign;
    else if(mouseY<60)T+=sign;
    else if(mouseY<80)lambda+=sign;
  }
  else if(mouseX<85){
    if(mouseY<20)return;
    else if(mouseY<40)A+=sign*10;
    else if(mouseY<60)T+=sign*0.1;
    else if(mouseY<80)lambda+=sign*10;
  }else if(mouseX<400){
    return;
  }
  else if(mouseX<435){
    if(mouseY<20)return;
    else if(mouseY<40)A2+=sign;
    else if(mouseY<60)T2+=sign;
    else if(mouseY<80)lambda2+=sign;
  }
  else if(mouseX<485){
    if(mouseY<20)return;
    else if(mouseY<40)A2+=sign*10;
    else if(mouseY<60)T2+=sign*0.1;
    else if(mouseY<80)lambda2+=sign*10;
  }
}
void keyPressed(){
  if(key==ENTER)sign=(sign==1)?-1:1;
}
