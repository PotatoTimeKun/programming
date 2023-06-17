float laser[][]=new float[1000][2];
float laserSpeed=2;
int laserIndex=0;
float laserAngle=PI/4;
void setup(){
  size(600,600);
  for(int i=0;i<1000;i++)for(int j=0;j<2;j++)laser[i][j]=-1;
  laser[0][0]=100;
  laser[0][1]=100;
  laser[1][0]=100+laserSpeed/sqrt(2);
  laser[1][1]=100+laserSpeed/sqrt(2);
  strokeWeight(5);
  stroke(100,100,255);
}
void draw(){
  background(255);
  float mouseDistance=sqrt(pow(mouseX-laser[laserIndex][0],2)+pow(mouseY-laser[laserIndex][1],2));
  float gaiseki=(laser[(laserIndex+1)%1000][0]-laser[laserIndex][0])*(mouseY-laser[laserIndex][1])/mouseDistance-(laser[(laserIndex+1)%1000][1]-laser[laserIndex][1])*(mouseX-laser[laserIndex][0])/mouseDistance;
  laserAngle+=PI/50*gaiseki/laserSpeed;
  laserIndex=(laserIndex+1)%1000;
  laser[(laserIndex+1)%1000][0]=laser[laserIndex][0]+laserSpeed*cos(laserAngle);
  laser[(laserIndex+1)%1000][1]=laser[laserIndex][1]+laserSpeed*sin(laserAngle);
  for(int i=(laserIndex+2)%1000;(i+1)%1000!=laserIndex;i=(i+1)%1000){
    if(laser[i][0]<0 || laser[(i+1)%1000][0]<0)continue;
    line(laser[i][0],laser[i][1],laser[(i+1)%1000][0],laser[(i+1)%1000][1]);
  }
}
