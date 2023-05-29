int windowX=1000,windowY=600;
int windowBuffer[][][];
Object cube[]={new Ball(100,0,160,25),new Cube(100,50,160,25),new Cube(-70,10,200,40),
new Cube(0,0,160,25),new Cube(0,50,160,50),new Ball(-100,-50,300,60)};
boolean showed[]=new boolean[cube.length];
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
  for(int i=0;i<cube.length;i++)showed[i]=true;
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

void addBufferDirect(int newX,int newY,int newZ,int r,int g,int b){
    if(newZ<1 && newZ>=0)newZ=1;
    int x=newX+windowX/2;
    int y=newY+windowY/2;
    int z=newZ;
    if(x<0 || x>=windowX || y<0 || y>=windowY || z<0)return;
    if(windowBuffer[x][y][0]>=0 && z>windowBuffer[x][y][0])return;
    windowBuffer[x][y][0]=z;
    windowBuffer[x][y][1]=r;
    windowBuffer[x][y][2]=g;
    windowBuffer[x][y][3]=b;
}

float timer=0;
void draw(){
  frameRate(20);
  for(int i=0;i<cube.length;i++)
  {
    cube[i].zxAngle+=0.05;
  }
  float moveSpeed=2;
  if(key=='r')cube[0].xyAngle+=0.06;
  if(key=='q')cube[0].yzAngle+=0.06;
  if(key=='e')cube[0].zxAngle+=0.06;
  if(key=='w')cube[0].z+=moveSpeed;
  if(key=='a')cube[0].x-=moveSpeed;
  if(key=='s')cube[0].z-=moveSpeed;
  if(key=='d')cube[0].x+=moveSpeed;
  if(key==' ')cube[0].y+=moveSpeed;
  if(keyCode==SHIFT)cube[0].y-=moveSpeed;
  for(int i=0;i<cube.length;i++){
    if(!showed[i])return;
  }
  background(255);
  windowShow();
  objectNum=0;
  for(int i=0;i<cube.length;i++)
  {
    showed[i]=false;
  }
  for(int i=0;i<cube.length+10;i++)
  {
    thread("showObject");
  }
}

int objectNum=0;
void showObject(){
  int num=objectNum++;
  if(num>=cube.length)return;
  cube[num].show();
  showed[num]=true;
}

float direct[]={0,2./sqrt(5),-1./sqrt(5)};

class Object{
  float x,y,z;
  float zxAngle,yzAngle,xyAngle;
  Object(){}
  void show(){}
}

class Cube extends Object{
  float surfaces[][][]={
    {{0.5,0.5,0.5},{0.5,0.5,-0.5},{-0.5,0.5,-0.5},{-0.5,0.5,0.5}},
    {{0.5,-0.5,0.5},{0.5,-0.5,-0.5},{-0.5,-0.5,-0.5},{-0.5,-0.5,0.5}},
    {{0.5,0.5,0.5},{0.5,0.5,-0.5},{0.5,-0.5,-0.5},{0.5,-0.5,0.5}},
    {{0.5,0.5,-0.5},{-0.5,0.5,-0.5},{-0.5,-0.5,-0.5},{0.5,-0.5,-0.5}},
    {{-0.5,0.5,-0.5},{-0.5,0.5,0.5},{-0.5,-0.5,0.5},{-0.5,-0.5,-0.5}},
    {{0.5,0.5,0.5},{-0.5,0.5,0.5},{-0.5,-0.5,0.5},{0.5,-0.5,0.5}},
  };
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
    float X=x,Y=y,Z=z,zxAng=zxAngle,yzAng=yzAngle,xyAng=xyAngle;
    if(Z<=size)return;
    float adding[][]={{-0.5,0,-0.5},{-0.5,0,-0.5},{0,-0.5,-0.5},{-0.5,-0.5,0},{0,-0.5,0.5},{-0.5,-0.5,0}};
    float mul=Z/400;
    for(int i=0;i<6;i++){
        for(int j=0;j<3;j++){
            adding[i][j]*=mul;
        }
    }
    float normal[][]={{0,1,0},{0,-1,0},{1,0,0},{0,0,-1},{-1,0,0},{0,0,1}};
    for(int i=0;i<6;i++){
        normal[i]=rotateZX(rotateYZ(rotateXY(normal[i],xyAng),yzAng),zxAng);
        float lux=0;
        for(int j=0;j<3;j++)lux+=normal[i][j]*direct[j];
        float position[]=new float[3];
        float range[]=new float[3];
        for(int j=0;j<3;j++)range[j]=abs(surfaces[i][2][j]-surfaces[i][0][j]);
        float added[]=new float[3];
        for(added[0]=0;abs(added[0])<=range[0];added[0]+=adding[i][0]){
            for(added[1]=0;abs(added[1])<=range[1];added[1]+=adding[i][1]){
                for(added[2]=0;abs(added[2])<=range[2];added[2]+=adding[i][2]){
                    for(int j=0;j<3;j++)position[j]=surfaces[i][0][j]+added[j];
                    position=rotateZX(rotateYZ(rotateXY(position,xyAng),yzAng),zxAng);
                    position[0]+=X;
                    position[1]+=Y;
                    position[2]+=Z;
                    int r=int(100*(0.6+0.4*lux)),g=int(100*(0.6+0.4*lux)),b=int(255*(0.6+0.4*lux));
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

class Ball extends Object{
  float r;
  Ball(float X,float Y,float Z,float R){
    x=X;
    y=Y;
    z=Z;
    r=R;
  }
  void show(){
    if(z<=r)return;
    int R=int(r*600/z);
    int center[]={int(x*600/z),int(y*600/z),int(z)};
    for(int i=-R;i<=R;i++){
      for(int j=-R;j<=R;j+=1){
        if(pow(i,2)+pow(j,2)>pow(R,2))continue;
        float k=-sqrt(pow(R,2)-pow(i,2)-pow(j,2));
        float normal[]={float(i)/R,float(j)/R,k/R};
        float lux=0;
        for(int l=0;l<3;l++)lux+=direct[l]*normal[l];
        int rColor=int(100*(0.6+0.4*lux)),gColor=int(100*(0.6+0.4*lux)),bColor=int(255*(0.6+0.4*lux));
        addBufferDirect(i+center[0],j+center[1],int(k*z/600)+center[2],rColor,gColor,bColor);
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
