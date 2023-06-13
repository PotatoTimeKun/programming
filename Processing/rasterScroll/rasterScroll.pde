int data[][][]=new int[1500][500][3]; //画像データの代わり、各画素のRGBを記録
int x=0; // 最下層のスクロールされた画素数
void setup(){
  size(700,500);
  makeImage();
}
void draw(){
  background(255);
  // 手前を速く、奥を遅くスクロールする
  for(int i=0;i<500;i++){
    int px=int(x*(1+i*(-2./3/800))+i/3.);
    for(int j=0;j<700;j++){
      stroke(data[px+j][i][0],data[px+j][i][1],data[px+j][i][2]);
      point(j,499-i);
    }
  }
}
void keyPressed(){
  if(key=='a')x-=10;
  if(key=='d')x+=10;
  if(x<0)x=0;
  if(x>1499-700)x=1499-700;
}

void makeImage(){//側面の傾きが1/3の台形の画像を生成
  int yline=200;
  int ylinecount=0;
  int black[]={0,0,0};
  int back[]={100,100,200};
  for(int i=0;i<500;i++){
    for(int j=0;j<1500;j++){
      if(i==yline){
        data[j][i]=black;
        if(j==1499)yline+=200*pow(2./3,++ylinecount);
      }else data[j][i]=back;
    }
  }
  float katamuki=1./3;
  for(int i=0;i<5;i++){
    for(int j=0;j<500;j++){
      data[int(katamuki*j+1499./4*i)][j]=black;
    }
    katamuki-=1./6;
  }
}
