int[] xm={0,0,0} , ym={0,0,0};    //キャラクターが進むそれぞれの向き
int[] x={0,0,0} , y={0,0,0};    //キャラクターのそれぞれの座標
int r=255 , g=0 , b=0;    //キャラクターの色
int i;    //現在操作しているキャラクターのインデックス
int pt=0;    //現在の得点
int time=18;    //ゲームのタイムリミット
int framecount=0;    //1フレーム毎にインクリメントするカウント
int index=0;    //draw関数内の処理の切り替え用
int lir=255 , lig=255 , lib=255;    //ゲーム画面の下に表示する線の色
int[] stop={0,0,0};    //ポイントが1度に2回分増えるバグを抑える為にポイントの追加を一時的にストップさせる為の配列

void setup(){
  size(1400,750);
  background(255);
  for(int a=0;a<3;a++){
    xm[a]=int(random(-5.9999999,5.9999999));
    ym[a]=int(random(-5.9999999,5.9999999));
    if(x[a]==0 && y[a]==0){
      y[a]=3;
    }
    x[a]=int(random(100,1300));
    y[a]=int(random(100,500));
  }
}

void setcolor()
{
  lir=int(random(10,255));
  lig=int(random(10,255));
  lib=int(random(10,255));
}

void changeRGB(){
  if(r==255&&g<255&&b==0){g+=5;}
  if(r>0&&g==255&&b==0){r-=5;}
  if(r==0&&g==255&&b<255){b+=5;}
  if(r==0&&g>0&&b==255){g-=5;}
  if(r<255&&g==0&&b==255){r+=5;}
  if(r==255&&g==0&&b>0){b-=5;}
}

void drawCharactor(){
  int arm=0;
  if(time>=0){
    arm=(time%2==0)?40:-40;
  }else{
    arm=(time*-1%2==0)?40:-40;
  }
  strokeWeight(5);
  stroke(r,g,b);
  line(x[i]-50,y[i],x[i]-90,y[i]);
  line(x[i]-90,y[i],x[i]-90,y[i]+arm);
  line(x[i]+50,y[i],x[i]+90,y[i]);
  line(x[i]+90,y[i],x[i]+90,y[i]+arm);
  fill(r,g,b);
  noStroke();
  ellipse(x[i],y[i],100,100);
  strokeWeight(3);
  stroke(0);
  line(x[i]-30,y[i]-10,x[i]-20,y[i]-20);
  line(x[i]-20,y[i]-20,x[i]-10,y[i]-10);
  line(x[i]+30,y[i]-10,x[i]+20,y[i]-20);
  line(x[i]+20,y[i]-20,x[i]+10,y[i]-10);
  bezier(x[i],y[i]+15,x[i],y[i]+30,x[i]-15,y[i]+30,x[i]-15,y[i]+15);
  bezier(x[i],y[i]+15,x[i],y[i]+30,x[i]+15,y[i]+30,x[i]+15,y[i]+15);
}

void judgement(){
  int mx=mouseX;
  if(x[i]<=mx+170 && x[i]>=mx-170 && time>0 && stop[i]==0){
    pt++;
    setcolor();
    if(x[i]<=mx+70 && x[i]>=mx-70){
      pt++;
    }
    stop[i]=5;
  }
}

void draw(){
  frameRate(150);
  
  if(index==0){
    PFont font = createFont("日本語の文字化け回避用の存在しないフォント",64,true);
    textFont(font);
    fill(255,0,0);
    textSize(150);
    text("Hit Face!",350,150);
    fill(0);
    textSize(60);
    text("ルール：\n画面下にある棒をマウスで動かし\nキャラクターを跳ね返すと得点になります。",50,300);
    text("キーを押してスタート",350,600);
    if(keyPressed){
      index=1;
    }
  }
  
  if(index==1){
    background(255);
    textSize(150);
    text(time-15,650,350);
    framecount=(++framecount)%150;
    if(framecount==149){time-=1;}
    if(time==15){index=2;}
  }
  
  if(index==2){
    framecount=(++framecount)%150;
    if(framecount==149){time-=1;}
    changeRGB();
    background(0);
    for(i=0;i<=2;i++){
      x[i]+=xm[i];
      y[i]+=ym[i];
      if(stop[i]!=0){
        stop[i]--;
      }
      if(x[i]>=1300&&y[i]>=600){
        xm[i]=int(random(-5.9999999,-1));
        ym[i]=int(random(-5.9999999,-1));
        judgement();
      }
      if(x[i]>100&&x[i]<1300&&y[i]>=600){
        xm[i]=int(random(-5.9999999,5.9999999));
        ym[i]=int(random(-5.9999999,-1));
        judgement();
      }
      if(y[i]>50&&y[i]<600&&x[i]>=1300){
        ym[i]=int(random(-5.9999999,5.9999999));
        xm[i]=int(random(-5.9999999,-1));
      }
      if(x[i]<=100&&y[i]<=50){
        xm[i]=int(random(1,5.9999999));
        ym[i]=int(random(1,5.9999999));
      }
      if(x[i]>100&&x[i]<1300&&y[i]<=50){
        xm[i]=int(random(-5.9999999,5.9999999));
        ym[i]=int(random(1,5.9999999));
      }
      if(y[i]>50&&y[i]<600&&x[i]<=100){
        ym[i]=int(random(-5.9999999,5.9999999));
        xm[i]=int(random(1,5.9999999));
      }
      if(x[i]>=1300&&y[i]<=50){
        xm[i]=int(random(-5.9999999,-1));
        ym[i]=int(random(1,5.9999999));
      }
      if(x[i]<=100&&y[i]>=600){
        xm[i]=int(random(1,5.9999999));
        ym[i]=int(random(-5.9999999,-1));
        judgement();
      }
      fill(lir,lig,lib);
      if(time>0){
        rect(mouseX-150,650,300,50);
        fill(255,0,0);
        rect(mouseX-50,650,100,50);
      }
      drawCharactor();
    }
    if(time>0){
      noStroke();
      fill(255);
      rect(0,0,250,60);
      fill(0);
      textSize(60);
      text(pt+"point",20,50);
      fill(255);
      text(time+"seconds",550,50);
    }
    if(time<=0){
      fill(255);
      textSize(200);
      text("Finish!",400,400);
    }
    if(time<=-1){
      if(keyPressed){
        index=3;
      }
      if((-1*time)%2==1){
        fill(255);
        textSize(100);
        text("result: "+pt+"point",400,550);
        textSize(50);
        text("キーを押すともう一度スタート",350,100);
      }
    }
  }
  
  if(index==3){
    for(int a=0;a<3;a++){
      xm[a]=int(random(-5.9999999,5.9999999));
      ym[a]=int(random(-5.9999999,5.9999999));
      if(x[a]==0 && y[a]==0){
        y[a]=3;
      }
      x[a]=int(random(100,1300));
      y[a]=int(random(100,500));
      stop[a]=0;
    }
    r=255;
    g=0;
    b=0;
    pt=0;
    time=18;
    framecount=0;
    lir=255;
    lig=255;
    lib=255;
    background(255);
    index=0;
  }
}
