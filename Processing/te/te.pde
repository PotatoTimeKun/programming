static int WIDTH=10,HEIGHT=15;

PImage hand[][]=new PImage[7][4];
int table[][][]=new int[HEIGHT][WIDTH][3];

boolean gameEnd=false;

void settings(){
  size(WIDTH*50,HEIGHT*50);
}

void setup(){
  for(int i=0;i<7;i++){
    for(int j=0;j<4;j++){
      hand[i][j]=loadImage("pic/te"+str(i+1)+"_"+str(j+1)+".jpg");
      hand[i][j].resize(50,50);
    }
  }
  for(int i=0;i<WIDTH;i++){
    for(int j=0;j<HEIGHT;j++){
      table[j][i][0]=0;
    }
  }
  imageMode(CENTER);
  textAlign(CENTER);
}

int count=0;
boolean getBlock=true;
int block[]={0,0};

void draw(){
  background(255);
  if(gameEnd){
    fill(0);
    textSize(40);
    text(str(blockCount)+"Block\n"+str(clearedLine)+"Line",WIDTH*50/2,HEIGHT*50/2);
    return;
  }
  for(int i=0;i<HEIGHT;i++){
    for(int j=0;j<WIDTH;j++){
      if(table[i][j][0]==0)continue;
      pushMatrix();
        translate(50*j+25,50*i+25);
        rotate(table[i][j][2]*PI/2);
        image(hand[table[i][j][0]-1][table[i][j][1]-1],0,0);
      popMatrix();
    }
  }
  for(int i=0;i<shape.length;i++){
    for(int j=0;j<shape[0].length;j++){
      if(shape[i][j][0]==0)continue;
      pushMatrix();
        translate(50*(pos[1]+j)+25,50*(pos[0]+i)+25);
        rotate(shape[i][j][2]*PI/2);
        image(hand[shape[i][j][0]-1][shape[i][j][1]-1],0,0);
      popMatrix();
    }
  }
  count+=fallBoost;
  if(count>=60){
    next();
    count=0;
  }
}

int shape[][][]={{{0}}};
int pos[]={0,0};

int blockCount=0;
int clearedLine=0;

void next(){
  if(getBlock){
    pos[0]=0;
    pos[1]=0;
    int shapeNumber=int(random(0,7));
    switch(shapeNumber){
      case 0:
        shape=new int[1][4][3];
        for(int i=0;i<4;i++){
          shape[0][i][0]=1;
          shape[0][i][1]=i+1;
          shape[0][i][2]=0;
        }
        break;
      case 1:
        shape=new int[2][2][3];
        for(int i=0;i<2;i++){
          for(int j=0;j<2;j++){
            shape[i][j][0]=2;
            shape[i][j][1]=i*2+j+1;
            shape[i][j][2]=0;
          }
        }
        break;
      case 2:
        shape=new int[2][3][3];
        for(int i=0;i<2;i++){
          for(int j=0;j<3;j++){
            shape[i][j][0]=3;
            shape[i][j][1]=0;
            shape[i][j][2]=0;
          }
        }
        shape[0][2][1]=1;
        shape[1][0][1]=2;
        shape[1][1][1]=3;
        shape[1][2][1]=4;
        shape[0][0][0]=0;
        shape[0][1][0]=0;
        break;
      case 3:
        shape=new int[2][3][3];
        for(int i=0;i<2;i++){
          for(int j=0;j<3;j++){
            shape[i][j][0]=4;
            shape[i][j][1]=0;
            shape[i][j][2]=0;
          }
        }
        shape[0][1][1]=1;
        shape[0][2][1]=2;
        shape[1][0][1]=3;
        shape[1][1][1]=4;
        shape[0][0][0]=0;
        shape[1][2][0]=0;
        break;
      case 4:
        shape=new int[2][3][3];
        for(int i=0;i<2;i++){
          for(int j=0;j<3;j++){
            shape[i][j][0]=5;
            shape[i][j][1]=0;
            shape[i][j][2]=0;
          }
        }
        shape[0][0][1]=1;
        shape[0][1][1]=2;
        shape[0][2][1]=3;
        shape[1][1][1]=4;
        shape[1][0][0]=0;
        shape[1][2][0]=0;
        break;
      case 5:
        shape=new int[2][3][3];
        for(int i=0;i<2;i++){
          for(int j=0;j<3;j++){
            shape[i][j][0]=6;
            shape[i][j][1]=0;
            shape[i][j][2]=0;
          }
        }
        shape[0][0][1]=1;
        shape[1][0][1]=2;
        shape[1][1][1]=3;
        shape[1][2][1]=4;
        shape[0][1][0]=0;
        shape[0][2][0]=0;
        break;
      case 6:
        shape=new int[2][3][3];
        for(int i=0;i<2;i++){
          for(int j=0;j<3;j++){
            shape[i][j][0]=7;
            shape[i][j][1]=0;
            shape[i][j][2]=0;
          }
        }
        shape[0][0][1]=1;
        shape[0][1][1]=2;
        shape[1][1][1]=3;
        shape[1][2][1]=4;
        shape[0][2][0]=0;
        shape[1][0][0]=0;
        break;
    }
    getBlock=false;
    for(int i=0;i<shape.length;i++){
      for(int j=0;j<shape[0].length;j++){
        if(shape[i][j][0]==0)continue;
        if(table[i][j][0]!=0)gameEnd=true;
      }
    }
    if(!gameEnd)blockCount++;
    return;
  }
  boolean canFall=true;
  for(int i=0;i<shape.length;i++){
    for(int j=0;j<shape[0].length;j++){
      if(table[pos[0]+i+1][pos[1]+j][0]!=0 && shape[i][j][0]!=0)canFall=false;
    }
  }
  if(canFall)pos[0]++;
  if(pos[0]+shape.length<HEIGHT){
    for(int i=0;i<shape.length;i++){
      for(int j=0;j<shape[0].length;j++){
        if(table[pos[0]+i+1][pos[1]+j][0]!=0 && shape[i][j][0]!=0)canFall=false;
      }
    }
  }
  if(pos[0]+shape.length>=HEIGHT || !canFall){
    for(int i=0;i<shape.length;i++){
      for(int j=0;j<shape[0].length;j++){
        if(shape[i][j][0]==0)continue;
        table[pos[0]+i][pos[1]+j]=shape[i][j];
      }
    }
    for(int i=0;i<HEIGHT;i++){
      boolean clear=true;
      for(int j=0;j<WIDTH;j++){
        if(table[i][j][0]==0)clear=false;
      }
      if(!clear)continue;
      clearedLine++;
      for(int j=0;j<WIDTH;j++){
        table[i][j][0]=0;
      }
      for(int j=i-1;j>0;j--){
        for(int k=0;k<WIDTH;k++){
          table[j+1][k]=table[j][k];
        }
      }
      for(int j=0;j<WIDTH;j++)table[0][j][0]=0;
    }
    getBlock=true;
  }
}

int fallBoost=1;

void keyPressed(){
  if(getBlock)return;
  if(key=='s')fallBoost=10;
  if(key=='e'){
    int newShape[][][]=new int[shape[0].length][shape.length][3];
    for(int i=0;i<shape.length;i++){
      for(int j=0;j<shape[0].length;j++){
        newShape[j][shape.length-1-i]=shape[i][j];
      }
    }
    boolean canRotate=true;
    for(int i=0;i<newShape.length;i++){
      for(int j=0;j<newShape[0].length;j++){
        if(newShape[i][j][0]==0)continue;
        if(pos[0]+i>=HEIGHT || pos[1]+j>=WIDTH){
          canRotate=false;
          continue;
        }
        if(table[pos[0]+i][pos[1]+j][0]!=0)canRotate=false;
      }
    }
    if(canRotate){
      shape=newShape;
      for(int i=0;i<newShape.length;i++){
        for(int j=0;j<newShape[0].length;j++){
          newShape[i][j][2]++;
        }
      }
    }
  }
  int move=0;
  if(key=='a')move--;
  if(key=='d')move++;
  if(pos[1]+move<0 || pos[1]+shape[0].length+move>WIDTH)return;
  boolean canMove=true;
  for(int i=0;i<shape.length;i++){
    for(int j=0;j<shape[0].length;j++){
      if(shape[i][j][0]==0)continue;
      if(table[pos[0]+i][pos[1]+j+move][0]!=0)canMove=false;
    }
  }
  if(!canMove)return;
  pos[1]+=move;
}
void keyReleased(){
  if(key=='s')fallBoost=1;
}
