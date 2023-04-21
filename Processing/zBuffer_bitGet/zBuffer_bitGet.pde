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
    int x=int(newX*600/newZ)+windowX/2;
    int y=int(newY*600/newZ)+windowY/2;
    int z=int(newZ);
    if(x<0 || x>=windowX || y<0 || y>=windowY || z<=0)return;
    if(windowBuffer[x][y][0]>=0 && z>windowBuffer[x][y][0])return;
    windowBuffer[x][y][0]=z;
    windowBuffer[x][y][1]=r;
    windowBuffer[x][y][2]=g;
    windowBuffer[x][y][3]=b;
}
Cube cube=new Cube(0,0,200,50);
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
    for(int i=-windowX/2;i<windowX/2;i++){
        for(int j=-windowY/2;j<windowY/2;j++){
            for(int k=0;k<6;k++){
                float surface[][]=new float[surfaces[k].length][3];
                for(int l=0;l<surfaces[k].length;l++){
                    surface[l]=rotateZX(rotateYZ(rotateXY(surfaces[k][l],xyAngle),yzAngle),zxAngle);
                    surface[l][0]+=x;
                    surface[l][1]+=y;
                    surface[l][2]+=z;
                }
                float target[]={i,j};
                if(!inRect(surface,target))continue;
                point(i+windowX/2,windowY-(j+windowY/2));
                float targetZ=getZ(i,j,surface);
                addBuffer(i*targetZ/600,j*targetZ/600,targetZ,100,100,255);
            }
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

float determinant(float matrix[][]){
    if(matrix.length==2){
        return matrix[0][0]*matrix[1][1]-matrix[0][1]*matrix[1][0];
    }
    float sumSubDet=0;
    for(int i=0;i<matrix.length;i++){
        float subMatrix[][]=new float[matrix.length-1][matrix.length-1];
        for(int column=0;column<subMatrix.length;column++){
            for(int row=0;row<subMatrix.length;row++){
                subMatrix[column][row]=matrix[column+1][row<i?row:row+1];
            }
        }
        sumSubDet+=(i%2==0?1:-1)*matrix[0][i]*determinant(subMatrix);
    }
    return sumSubDet;
}

float[] getNormalVector(float a[],float b[],float c[]){
    float normalVector[]={0,0,0};
    for(int i=0;i<3;i++){
        if(a[i]==b[i] && b[i]==c[i]){
            normalVector[i]=1;
            return normalVector;
        }
    }
    normalVector[0]=10;
    float matrix[][]=new float[2][2];
    for(int i=0;i<2;i++){
        matrix[0][i]=b[i+1]-a[i+1];
        matrix[1][i]=c[i+1]-a[i+1];
    }
    float detDefault=determinant(matrix);
    matrix[0][0]=-10*(b[0]-a[0]);
    matrix[1][0]=-10*(c[0]-a[0]);
    normalVector[1]=determinant(matrix)/detDefault;
    matrix[0][1]=-(b[1]-a[1]);
    matrix[1][1]=-(c[1]-a[1]);
    normalVector[2]=determinant(matrix)/detDefault;
    return normalVector;
}

boolean inRect(float surface[][],float target[]){
    float surfaceInWindow[][]=new float[4][2];
    for(int i=0;i<4;i++){
        for(int j=0;j<2;j++)surfaceInWindow[i][j]=surface[i][j]*600/surface[i][2];
    }
    float cross[]=new float[4];
    for(int i=0;i<4;i++){
        cross[i]=cross2D(vectorFromTo(surfaceInWindow[i],surfaceInWindow[(i+1)%4]),vectorFromTo(surfaceInWindow[i],target));
    }
    boolean flag=true;
    for(int i=0;i<4;i++)if(cross[i]>0)flag=false;
    if(flag)return true;
    flag=true;
    for(int i=0;i<4;i++)if(cross[i]<0)flag=false;
    return flag;
}

float getZ(float X,float Y,float surface[][]){
    float normalVector[]=getNormalVector(surface[0],surface[1],surface[2]);
    float vector[]={X/600,Y/600,1};
    return inner(normalVector,surface[0])/inner(normalVector,vector);
}

float inner(float a[],float b[]){
    float sum=0;
    for(int i=0;i<a.length;i++)sum+=a[i]*b[i];
    return sum;
}

float cross2D(float a[],float b[]){
    float matrix[][]={a,b};
    return determinant(matrix);
}

float[] vectorFromTo(float a[],float b[]){
    float vector[]=new float[a.length];
    for(int i=0;i<a.length;i++)vector[i]=b[i]-a[i];
    return vector;
}

void keyReleased(){
  key='\0';
  keyCode=0;
}
