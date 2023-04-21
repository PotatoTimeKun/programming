int windowX=1000,windowY=600;
int windowBuffer[][][];
void settings(){
    size(windowX,windowY);
    windowBuffer=new int[windowX][windowY][4];
}
void setup(){
  for(int i=0;i<windowX;i++){
    for(int j=0;j<windowY;j++){
        windowBuffer[i][j][0]=-1;
    }
  }
}
void windowShow(){
  for(int i=0;i<windowX;i++){
    for(int j=0;j<windowY;j++){
        if(windowBuffer[i][j][0]<0)continue;
        strokeWeight(0);
        stroke(windowBuffer[i][j][1],windowBuffer[i][j][2],windowBuffer[i][j][3]);
        fill(windowBuffer[i][j][1],windowBuffer[i][j][2],windowBuffer[i][j][3]);
        rect(i, windowY-j,1,1);
        windowBuffer[i][j][0]=-1;
    }
  }
}
void addBuffer(float newX,float newY,float newZ,int r,int g,int b){
    if(newZ<1 && newZ>=0)newZ=1;
    int x=int(newX*600/newZ)+windowX/2;
    int y=int(newY*600/newZ)+windowY/2;
    int z=int(newZ);
    if(x<0 || x>=windowX || y<0 || y>=windowY || z<0)return;
    if(windowBuffer[x][y][0]>=0 && z>windowBuffer[x][y][0])return;
    windowBuffer[x][y][0]=z;
    windowBuffer[x][y][1]=r;
    windowBuffer[x][y][2]=g;
    windowBuffer[x][y][3]=b;
}
Cube cube=new Cube(0,0,200,50);
Cube cube2=new Cube(0,10,200,50);
float timer=0;
void draw(){
  frameRate(20);
  background(255);
  float moveSpeed=2;
  if(key=='r')cube.xyAngle+=0.06;
  if(key=='q')cube.yzAngle+=0.06;
  if(key=='e')cube.zxAngle+=0.06;
  if(key=='w')cube.z+=moveSpeed;
  if(key=='a')cube.x-=moveSpeed;
  if(key=='s')cube.z-=moveSpeed;
  if(key=='d')cube.x+=moveSpeed;
  if(key==' ')cube.y+=moveSpeed;
  if(keyCode==SHIFT)cube.y-=moveSpeed;
  cube.show();
  cube2.show();
  windowShow();
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
  float zxAngle,yzAngle,xyAngle;
  float x,y,z;
  float size;
  Cube(float newx,float newy,float newz,float len){
    x=newx;
    y=newy;
    z=newz;
    for(int i=0;i<surfaces.length;i++){
      for(int j=0;j<surfaces[0].length;j++){
        for(int k=0;k<3;k++){
          surfaces[i][j][k]*=len;
        }
      }
    }
    xyAngle=0;
    zxAngle=0;
    yzAngle=0;
    size=len;
  }
  void show(){
    if(z<=size)return;
    float adding[][]={{-0.5,0,-0.5},{-0.5,0,-0.5},{0,-0.5,-0.5},{-0.5,-0.5,0},{0,-0.5,0.5},{-0.5,-0.5,0}};
    float mul=z/400;
    for(int i=0;i<6;i++){
        for(int j=0;j<3;j++){
            adding[i][j]*=mul;
        }
    }
    for(int i=0;i<6;i++){
        float position[]=new float[3];
        float range[]=new float[3];
        for(int j=0;j<3;j++)range[j]=abs(surfaces[i][2][j]-surfaces[i][0][j]);
        float added[]=new float[3];
        for(added[0]=0;abs(added[0])<=range[0];added[0]+=adding[i][0]){
            for(added[1]=0;abs(added[1])<=range[1];added[1]+=adding[i][1]){
                for(added[2]=0;abs(added[2])<=range[2];added[2]+=adding[i][2]){
                    for(int j=0;j<3;j++)position[j]=surfaces[i][0][j]+added[j];
                    position=rotateZX(rotateYZ(rotateXY(position,xyAngle),yzAngle),zxAngle);
                    position[0]+=x;
                    position[1]+=y;
                    position[2]+=z;
                    int r=100,g=100,b=255;
                    for(int j=0;j<3;j++){
                        if(abs(added[j]+2*adding[i][j])>range[j]||abs(added[j])<abs(2*adding[i][j])){
                            r=0;
                            g=0;
                            b=0;
                        }
                    }
                    addBuffer(position[0],position[1],position[2],r,g,b);
                    if(adding[i][2]==0)break;
                }
                if(adding[i][1]==0)break;
            }
            if(adding[i][0]==0)break;
        }
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

void keyReleased(){
  key='\0';
  keyCode=0;
}
