float v[]={1,1};
float r[]={0,0};
float center[]={0,0};
int centerMode=4;
int vxMode=0;
int vyMode=0;
float t=0;
float baisoku=3;
int points[][]=new int[500][2];
int pointer=0;
void setup(){
  size(1000,600);
  strokeWeight(3);
  for(int i=0;i<500;i++){
    points[i][0]=1000;
    points[i][1]=1000;
  }
}
void draw(){
  background(255);
  frameRate(60);
  translate(300,300);
  stroke(0);
  fill(255);
  rect(-300,-300,599,599);
  line(-300,0,300,0);
  line(0,-300,0,300);
  stroke(255,0,0);
  fill(255,0,0);
  switch(centerMode){
    case 0:
      center[0]=200;
      center[1]=200;
      break;
    case 1:
      center[0]=200-3*t*baisoku;
      center[1]=200;
      break;
    case 2:
      center[1]=200-3*t*baisoku;
      center[0]=200;
      break;
    case 3:
      center[0]=200-3*t*baisoku;
      center[1]=200-3*t*baisoku;
      break;
    case 4:
      center[0]=200*cos(t/5);
      center[1]=200*sin(t/5);
      break;
    case 5:
      center[0]=-10*t;
      center[1]=2*pow(t-10,2);
      break;
  }
  if(center[0]<=300)ellipse(center[0],-center[1],5,5);
  switch(vxMode){
    case 0:
      v[0]=t;
      break;
    case 1:
      v[0]=10;
      break;
    case 2:
      v[0]=20*exp(-0.1*t);
      break;
    case 3:
      v[0]=t*t;
      break;
  }
  switch(vyMode){
    case 0:
      v[1]=t;
      break;
    case 1:
      v[1]=10;
      break;
    case 2:
      v[1]=20*exp(-0.1*t);
      break;
    case 3:
      v[1]=t*t;
      break;
  }
  float distance=d(r[0],r[1],center[0],center[1]);
  for(int i=0;i<2;i++){
    v[i]+=20*exp(-0.001*distance)*(center[i]-r[i])/(distance+0.1);
    r[i]+=baisoku/60*v[i];
    points[pointer][i]=int(r[i]);
  }
  stroke(100,100,200);
  for(int i=0;i<500;i++){
    if(points[i][0]>300)continue;
    point(points[i][0],-points[i][1]);
  }
  if(r[0]<=300)
  {
    stroke(100,250,100);
    line(r[0],-r[1],r[0]+v[0],-(r[1]+v[1]));
    fill(100,250,100);
    ellipse(r[0]+v[0],-(r[1]+v[1]),5,5);
    stroke(0);
    fill(0);
    ellipse(r[0],-r[1],5,5);
  }
  fill(0);
  stroke(0);
  textSize(20);
  text("t="+nf(t,0,1),400,-270);
  text("v=("+nf(v[0],0,1)+","+nf(v[1],0,1)+")",400,-240);
  text("black=("+nf(r[0],0,1)+","+nf(r[1],0,1)+")",400,-210);
  text("red=("+nf(center[0],0,1)+","+nf(center[1],0,1)+")",400,-180);
  String vModeStr[]={"t","10","20e^-0.1t","t^2"};
  text("v=("+vModeStr[vxMode]+","+vModeStr[vyMode]+")",400,-100);
  fill(150,150,255);
  for(int i=0;i<4;i++)rect(600,-300+i*60,100,50);
  fill(0);
  text("t <- 0",630,-270);
  text("red",630,-210);
  text("v_x",630,-150);
  text("v_y",630,-90);
  t+=baisoku/60;
  pointer=(pointer+1)%500;
}
float d(float x1,float y1,float x2,float y2){
  return sqrt(pow(x1-x2,2)+pow(y1-y2,2));
}
void init(){
  for(int j=0;j<500;j++){
    points[j][0]=1000;
    points[j][1]=1000;
  }
  t=0;
  r[0]=0;
  r[1]=0;
}
void mouseClicked(){
  for(int i=0;i<4;i++){
    if(mouseX-300<600 || mouseY-300>-300+i*60+50 || mouseY-300<-300+i*60)continue;
    switch(i){
      case 0:
        init();
        break;
      case 1:
        centerMode=(centerMode+1)%6;
        init();
        break;
      case 2:
        vxMode=(vxMode+1)%4;
        init();
        break;
      case 3:
        vyMode=(vyMode+1)%4;
        init();
        break;
    }
  }
}
