float x=0,y=0,z=200;
float xyAngle=0,yzAngle=0,zxAngle=0;
float edges[][][]={
{{50,50,50},{50,50,-50}},
{{50,50,50},{-50,50,50}},
{{-50,50,-50},{50,50,-50}},
{{-50,50,50},{-50,50,-50}},
{{50,50,50},{50,-50,50}},
{{50,50,-50},{50,-50,-50}},
{{-50,50,50},{-50,-50,50}},
{{-50,50,-50},{-50,-50,-50}},
{{50,-50,50},{50,-50,-50}},
{{50,-50,50},{-50,-50,50}},
{{-50,-50,-50},{50,-50,-50}},
{{-50,-50,50},{-50,-50,-50}},
};
void setup(){
  size(600,600);
  textSize(20);
}
float timer=0;
void draw(){
  background(255);
  fill(0);
  text("move key:wasd space shift\nrotate key:qer",10,20);
  translate(300,300);
  for(int i=0;i<edges.length;i++){
    float from[]=rotateXY(rotateYZ(rotateZX(edges[i][0],zxAngle),yzAngle),xyAngle);
    float to[]=rotateXY(rotateYZ(rotateZX(edges[i][1],zxAngle),yzAngle),xyAngle);
    from[0]+=x;
    from[1]+=y;
    from[2]+=z;
    to[0]+=x;
    to[1]+=y;
    to[2]+=z;
    line(from[0]*600/from[2],-from[1]*600/from[2],to[0]*600/to[2],-to[1]*600/to[2]);
  }
  if(key=='r')xyAngle+=0.03;
  if(key=='q')yzAngle+=0.03;
  if(key=='e')zxAngle+=0.03;
  if(key=='w')z++;
  if(key=='a')x--;
  if(key=='s')z--;
  if(key=='d')x++;
  if(key==' ')y++;
  if(keyCode==SHIFT)y--;
}
float[] rotateXY(float[] position,float angle){
  float rotated[]=new float[3];
  rotated[0]=position[0]*cos(angle)-position[1]*sin(angle);
  rotated[1]=position[0]*sin(angle)+position[1]*cos(angle);
  rotated[2]=position[2];
  return rotated;
}
float[] rotateYZ(float[] position,float angle){
  float rotated[]=new float[3];
  rotated[0]=position[0];
  rotated[1]=position[1]*cos(angle)-position[2]*sin(angle);
  rotated[2]=position[1]*sin(angle)+position[2]*cos(angle);
  return rotated;
}
float[] rotateZX(float[] position,float angle){
  float rotated[]=new float[3];
  rotated[0]=position[0]*cos(angle)-position[2]*sin(angle);
  rotated[1]=position[1];
  rotated[2]=position[0]*sin(angle)+position[2]*cos(angle);
  return rotated;
}
void keyReleased(){
  key='\0';
  keyCode=0;
}
