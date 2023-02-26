void setup(){
  size(1000,600);
}
Cube cube=new Cube(0,0,200,100);
float xyAngle=0,yzAngle=0,zxAngle=0;
void draw(){
  background(255);
  translate(500,300);
  cube.show();
  if(key=='r')xyAngle+=0.03;
  if(key=='q')yzAngle+=0.03;
  if(key=='e')zxAngle+=0.03;
  if(key=='w')cube.z++;
  if(key=='a')cube.x--;
  if(key=='s')cube.z--;
  if(key=='d')cube.x++;
  if(key==' ')cube.y++;
  if(keyCode==SHIFT)cube.y--;
  cube.rotate(xyAngle,yzAngle,zxAngle);
}
class Cube{
  float surfaces[][][]={
    {{0.5,0.5,0.5},{0.5,0.5,-0.5},{-0.5,0.5,-0.5},{-0.5,0.5,0.5}},
    {{0.5,-0.5,0.5},{0.5,-0.5,-0.5},{-0.5,-0.5,-0.5},{-0.5,-0.5,0.5}},
    {{0.5,0.5,0.5},{0.5,0.5,-0.5},{0.5,-0.5,-0.5},{0.5,-0.5,0.5}},
    {{0.5,0.5,-0.5},{-0.5,0.5,-0.5},{-0.5,-0.5,-0.5},{0.5,-0.5,-0.5}},
    {{-0.5,0.5,-0.5},{-0.5,0.5,0.5},{-0.5,-0.5,0.5},{-0.5,-0.5,-0.5}},
    {{0.5,0.5,0.5},{-0.5,0.5,0.5},{-0.5,-0.5,0.5},{0.5,-0.5,0.5}},
  };
  float rotated[][][]=new float[6][4][3];
  float x,y,z;
  Cube(float newx,float newy,float newz,float len){
    x=newx;
    y=newy;
    z=newz;
    for(int i=0;i<6;i++){
      for(int j=0;j<4;j++){
        for(int k=0;k<3;k++){
          surfaces[i][j][k]*=len;
        }
        rotated[i][j][0]=surfaces[i][j][0]+x;
        rotated[i][j][1]=surfaces[i][j][1]+y;
        rotated[i][j][2]=surfaces[i][j][2]+z;
      }
    }
  }
  void rotate(float xyAngle,float yzAngle,float zxAngle){
    for(int i=0;i<6;i++){
      for(int j=0;j<4;j++){
        rotated[i][j]=rotateXY(rotateYZ(rotateZX(surfaces[i][j],zxAngle),yzAngle),xyAngle);
        rotated[i][j][0]+=x;
        rotated[i][j][1]+=y;
        rotated[i][j][2]+=z;
      }
    }
  }
  void show(){
    sortSurface(rotated);
    fill(100,100,255);
    strokeWeight(3);
    for(int i=0;i<6;i++){
      beginShape();
      for(int j=0;j<4;j++){
        vertex(rotated[i][j][0]*600/rotated[i][j][2],-rotated[i][j][1]*600/rotated[i][j][2]);
      }
      vertex(rotated[i][0][0]*600/rotated[i][0][2],-rotated[i][0][1]*600/rotated[i][0][2]);
      endShape();
    }
  }
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
void sortSurface(float surfaces[][][]){
  for(int i=0;i<surfaces.length-1;i++){
    int maxIndex1=i;
    int maxIndex2=0;
    for(int j=i;j<surfaces.length;j++){
      float max=surfaces[j][0][2];
      int maxIndex=0;
      for(int k=0;k<surfaces[j].length;k++){
        if(surfaces[j][k][2]<max)continue;
        max=surfaces[j][k][2];
        maxIndex=k;
      }
      if(max<surfaces[maxIndex1][maxIndex2][2])continue;
      maxIndex1=j;
      maxIndex2=maxIndex;
    }
    float tmp;
    for(int k=0;k<4;k++){
      for(int l=0;l<3;l++){
        tmp=surfaces[i][k][l];
        surfaces[i][k][l]=surfaces[maxIndex1][k][l];
        surfaces[maxIndex1][k][l]=tmp;
      }
    }
  }
}
void keyReleased(){
  key='\0';
  keyCode=0;
}
