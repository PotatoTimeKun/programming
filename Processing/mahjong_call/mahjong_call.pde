int tileCount[]=new int[3*9+7];// 牌ごとの残り、最大4
int myTiles[]=new int[14];//手牌
int myTilesNum=0;//手牌の数
int reachTile[]=new int[14];//リーチ牌候補
void setup(){
  for(int i=0;i<3*9+7;i++)tileCount[i]=4;
  for(int i=0;i<14;i++){
    myTiles[i]=-1;
    reachTile[i]=-1;
  }
  PFont font=createFont("tekitou",20);
  textFont(font);
  size(800,600);
}
void draw(){
  background(255);
  String tileName[]={"筒","萬","索","東","南","西","北","白","發","中"};
  for(int i=0;i<3;i++){
    for(int j=0;j<9;j++){
      fill(255);
      rect(20+(800-20)*j/9,200+100*i,50,80);
      fill(0);
      text(str(j+1)+"\n"+tileName[i],40+(800-20)*j/9,230+100*i);
    }
  }
  for(int i=3;i<10;i++){
    fill(255);
    rect(20+(800-20)*(i-3)/9,500,50,80);
    fill(0);
    text(tileName[i],40+(800-20)*(i-3)/9,530);
  }
  for(int i=0;i<14;i++){
    if(myTiles[i]==-1)continue;
    fill(255);
    for(int j=0;j<14;j++)if(myTiles[i]==reachTile[j])fill(250,150,150);
    rect(20+(800-20)*i/14,100,50,80);
    fill(0);
    if(myTiles[i]<3*9)text(str(myTiles[i]%9+1)+"\n"+tileName[myTiles[i]/9],40+(800-20)*i/14,130);
    else text(tileName[myTiles[i]-3*9+3],40+(800-20)*i/14,130);
  }
  fill(255);
  rect(10,10,100,40);
  fill(0);
  text("reset",30,40);
}
void checkReach(){
  myTiles=sort(myTiles);
  for(int i=0;i<14;i++)checkJantouReach(i);
  for(int i=0;i<13;i++)checkMentuReach(i);
  for(int i=0;i<12;i++)checkTobiMentuReach(i);
}
void checkJantouReach(int num){ //雀頭が足りないときのリーチ
  int tiles[]=new int[14];//myTilesをコピー
  for(int i=0;i<14;i++)tiles[i]=myTiles[i];
  tiles[num]=-1;
  tiles=sort(tiles);
  for(int i=1;i<14;i++){ // リーチ牌を選択し、除く
    int copy[]=new int[14];
    for(int j=0;j<14;j++)copy[j]=tiles[j];
    int target=tiles[i];
    tiles[i]=-1;
    tiles=sort(tiles);
    boolean maked=true;
    for(int j=2;j<14;j+=3){ // すべて面子になるか確認->maked
      if(tiles[j]==tiles[j+1] && tiles[j+1]==tiles[j+2]){
        tiles[j]=-1;
        tiles[j+1]=-1;
        tiles[j+2]=-1;
        continue;
      }
      if(tiles[j]+1==tiles[j+1] && tiles[j+1]+1==tiles[j+2] && tiles[j]/9==tiles[j+2]/9 && tiles[j]/9<3){
        tiles[j]=-1;
        tiles[j+1]=-1;
        tiles[j+2]=-1;
        continue;
      }
      if(j+4>=14){
        maked=false;
        break;
      }
      if(tiles[j]+1==tiles[j+2] && tiles[j+2]+1==tiles[j+4] && tiles[j]/9==tiles[j+4]/9 && tiles[j]/9<3){
        tiles[j]=-1;
        tiles[j+2]=-1;
        tiles[j+4]=-1;
        tiles=sort(tiles);
        continue;
      }
      if(tiles[j]+1==tiles[j+4] && tiles[j+4]+1==tiles[j+5] && tiles[j]/9==tiles[j+5]/9 && tiles[j]/9<3){
        tiles[j]=-1;
        tiles[j+4]=-1;
        tiles[j+5]=-1;
        tiles=sort(tiles);
        continue;
      }
      maked=false;
      break;
    }
    if(maked){
      boolean exist=false;
      for(int j=0;j<14;j++)if(reachTile[j]==target)exist=true;
      if(!exist){
        for(int j=0;j<14;j++){
          if(reachTile[j]==-1){
            reachTile[j]=target;
            break;
          }
        }
      }
    }
    for(int j=0;j<14;j++)tiles[j]=copy[j];
  }
}

void checkMentuReach(int num){// 面子が足りないときのリーチ
  if( ! (myTiles[num]==myTiles[num+1] || (myTiles[num]+1==myTiles[num+1] || myTiles[num]+2==myTiles[num+1]) && myTiles[num]/9==myTiles[num+1]/9 && myTiles[num]/9<3 ))return;
  int tiles[]=new int[14];
  for(int i=0;i<14;i++)tiles[i]=myTiles[i];
  tiles[num]=-1;
  tiles[num+1]=-1;
  tiles=sort(tiles);
  for(int i=2;i<13;i++){// 雀頭を選択し、除く
    if(tiles[i]!=tiles[i+1])continue;
    int copy[]=new int[14];
    for(int j=0;j<14;j++)copy[j]=tiles[j];
    tiles[i]=-1;
    tiles[i+1]=-1;
    tiles=sort(tiles);
    for(int j=4;j<14;j++){// リーチ牌を選択し、除く
      int copy2[]=new int[14];
      for(int k=0;k<14;k++)copy2[k]=tiles[k];
      int target=tiles[j];
      tiles[j]=-1;
      tiles=sort(tiles);
      boolean maked=true;
      for(int k=5;k<14;k+=3){// すべて面子になるか確認->maked
        if(tiles[k]==tiles[k+1] && tiles[k+1]==tiles[k+2]){
          tiles[k]=-1;
          tiles[k+1]=-1;
          tiles[k+2]=-1;
          continue;
        }
        if(tiles[k]+1==tiles[k+1] && tiles[k+1]+1==tiles[k+2] && tiles[k]/9==tiles[k+2]/9 && tiles[k]/9<3){
          tiles[k]=-1;
          tiles[k+1]=-1;
          tiles[k+2]=-1;
          continue;
        }
        if(k+4>=14){
          maked=false;
          break;
        }
        if(tiles[k]+1==tiles[k+2] && tiles[k+2]+1==tiles[k+4] && tiles[k]/9==tiles[k+4]/9 && tiles[k]/9<3){
          tiles[k]=-1;
          tiles[k+2]=-1;
          tiles[k+4]=-1;
          tiles=sort(tiles);
          continue;
        }
        if(tiles[k]+1==tiles[k+4] && tiles[k+4]+1==tiles[k+5] && tiles[k]/9==tiles[k+5]/9 && tiles[k]/9<3){
          tiles[k]=-1;
          tiles[k+4]=-1;
          tiles[k+5]=-1;
          tiles=sort(tiles);
          continue;
        }
        maked=false;
        break;
      }
      if(maked){
        boolean exist=false;
        for(int k=0;k<14;k++)if(reachTile[k]==target)exist=true;
        if(!exist){
          for(int k=0;k<14;k++){
            if(reachTile[k]==-1){
              reachTile[k]=target;
              break;
            }
          }
        }
      }
      for(int k=0;k<14;k++)tiles[k]=copy2[k];
    }
    for(int j=0;j<14;j++)tiles[j]=copy[j];
  }
}

void checkTobiMentuReach(int num){// 面子が足りないときのリーチの補助、11233のような飛んだ形に対応
  int next=-1;
  for(int i=num;i<14;i++){
    if(myTiles[num]+2==myTiles[i]){
      next=i;
      break;
    }
  }
  if(next==-1)return;
  if(myTiles[num]/9!=myTiles[next]/9 || myTiles[num]/9>=3)return;
  int tiles[]=new int[14];
  for(int i=0;i<14;i++)tiles[i]=myTiles[i];
  tiles[num]=-1;
  tiles[next]=-1;
  tiles=sort(tiles);
  for(int i=2;i<13;i++){// 雀頭を選択し、除く
    if(tiles[i]!=tiles[i+1])continue;
    int copy[]=new int[14];
    for(int j=0;j<14;j++)copy[j]=tiles[j];
    tiles[i]=-1;
    tiles[i+1]=-1;
    tiles=sort(tiles);
    for(int j=4;j<14;j++){// リーチ牌を選択し、除く
      int copy2[]=new int[14];
      for(int k=0;k<14;k++)copy2[k]=tiles[k];
      int target=tiles[j];
      tiles[j]=-1;
      tiles=sort(tiles);
      boolean maked=true;
      for(int k=5;k<14;k+=3){// すべて面子になるか確認->maked
        if(tiles[k]==tiles[k+1] && tiles[k+1]==tiles[k+2]){
          tiles[k]=-1;
          tiles[k+1]=-1;
          tiles[k+2]=-1;
          continue;
        }
        if(tiles[k]+1==tiles[k+1] && tiles[k+1]+1==tiles[k+2] && tiles[k]/9==tiles[k+2]/9 && tiles[k]/9<3){
          tiles[k]=-1;
          tiles[k+1]=-1;
          tiles[k+2]=-1;
          continue;
        }
        if(k+4>=14){
          maked=false;
          break;
        }
        if(tiles[k]+1==tiles[k+2] && tiles[k+2]+1==tiles[k+4] && tiles[k]/9==tiles[k+4]/9 && tiles[k]/9<3){
          tiles[k]=-1;
          tiles[k+2]=-1;
          tiles[k+4]=-1;
          tiles=sort(tiles);
          continue;
        }
        if(tiles[k]+1==tiles[k+4] && tiles[k+4]+1==tiles[k+5] && tiles[k]/9==tiles[k+5]/9 && tiles[k]/9<3){
          tiles[k]=-1;
          tiles[k+4]=-1;
          tiles[k+5]=-1;
          tiles=sort(tiles);
          continue;
        }
        maked=false;
        break;
      }
      if(maked){
        boolean exist=false;
        for(int k=0;k<14;k++)if(reachTile[k]==target)exist=true;
        if(!exist){
          for(int k=0;k<14;k++){
            if(reachTile[k]==-1){
              reachTile[k]=target;
              break;
            }
          }
        }
      }
      for(int k=0;k<14;k++)tiles[k]=copy2[k];
    }
    for(int j=0;j<14;j++)tiles[j]=copy[j];
  }
}

void mousePressed(){
  for(int i=0;i<4;i++){
    for(int j=0;j<9;j++){
      if(mouseX<20+(800-20)*j/9 || mouseX>20+(800-20)*j/9+50 || mouseY<200+100*i || mouseY>200+100*i+80)
        continue;
      if(i*9+j>=3*9+7 || myTilesNum>=14)
        continue;
      if(tileCount[i*9+j]<=0)
        continue;
      tileCount[i*9+j]--;
      myTiles[myTilesNum++]=i*9+j;
    }
  }
  if(mouseX>=10 && mouseX<=110 && mouseY>=10 && mouseY<=50){
    for(int i=0;i<3*9+7;i++)tileCount[i]=4;
    for(int i=0;i<14;i++){
      myTiles[i]=-1;
      reachTile[i]=-1;
    }
    myTilesNum=0;
  }
  if(myTilesNum==14)checkReach();
}
