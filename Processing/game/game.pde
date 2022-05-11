int chaColor=0;    //キャラクターの色
int pt=0;    //現在の得点
int time=20;    //ゲームのタイムリミット
int framecount=0;    //1フレーム毎にインクリメントするカウント
int index=0;    //画面の切り替え用
int lineColor=100;    //ゲーム画面の下に表示する線の色
int co=3;    //ゲーム開始前のカウントダウン用

/*setup関数で色の指定をHSBに指定します
そのためCharacterクラス内の色指定はHSBの指定方法で書いています*/

class Character{//キャラクターのクラス
  private int x, y, x_move, y_move;//キャラクターのx,y座標、x,y方向に進む速さ
  
  Character(int _x,int _y,int _x_move,int _y_move){//キャラクターの情報を設定するコンストラクタ
    x=_x;
    y=_y;
    x_move=_x_move;
    y_move=_y_move;
    if(x_move==0 || y_move==0){//キャラクターが静止またはx,y軸に平行に移動しないようにする
      x_move=int(random(2,5.99));
      y_move=int(random(2,5.99));
    }
  }
  void move(){//キャラクターの移動をするメソッド
    x+=x_move;//x座標の移動
    y+=y_move;//y座標の移動
    if(x>1300){//右端にいるとき
      x=1300;
      x_move=int(random(-5.99,-2));//左向きに
    }
    if(x<100){//左端にいるとき
      x=100;
      x_move=int(random(2,5.99));//右向きに
    }
    if(y>600){//下端にいるとき
      y=600;
      y_move=int(random(-5.99,-2));//上向きに
      judgement();//得点を判定するメソッドを呼び出す
    }
    if(y<50){//上端にいるとき
      y=50;
      y_move=int(random(2,5.99));//下向きに
    }
  }
  void draws(){//キャラクターを描画するメソッド
    int arm=0;//手先の相対位置
    arm=(abs(time)%2==0)?40:-40;//タイムリミットの絶対値が偶数なら40(手先を上向きに),奇数なら-40(手先を下向きに)
    /*腕の描画*/
    strokeWeight(5);
    stroke(chaColor,100,100);
    line(x-50,y,x-90,y);//左腕
    line(x-90,y,x-90,y+arm);//左腕
    line(x+50,y,x+90,y);//右腕
    line(x+90,y,x+90,y+arm);//右腕
    /*体の描画*/
    fill(chaColor,100,100);
    noStroke();
    ellipse(x,y,100,100);
    /*目の描画*/
    strokeWeight(3);
    stroke(0,0,0);
    line(x-30,y-10,x-20,y-20);//左目の左側
    line(x-20,y-20,x-10,y-10);//左目の右側
    line(x+30,y-10,x+20,y-20);//右目の右側
    line(x+20,y-20,x+10,y-10);//右目の左側
    /*口の描画*/
    bezier(x,y+15,x,y+30,x-15,y+30,x-15,y+15);//左側の曲線
    bezier(x,y+15,x,y+30,x+15,y+30,x+15,y+15);//右側の曲線
  }
  void judgement(){//点数の判定をするメソッド
    if(x<=mouseX+170 && x>=mouseX-170 && time>0){//キャラクターが判定の中にあり制限時間が0より多いとき
      pt++;//ポイント追加
      lineColor=int(random(0,500.99));//棒の色を変化
      if(x<=mouseX+70 && x>=mouseX-70){//キャラクターが判定の中心にある時
        pt++;//さらにポイント追加
      }
    }
  }
}

Character[] cara=new Character[3];//キャラクターの配列を作る

void setup(){
  colorMode(HSB,500,100,100);//HSBモードに
  size(1400,750);
  background(0,0,100);
  int x,y,x_move,y_move;
  for(int i=0;i<3;++i){//キャラクターのx,y座標、進むx,y方向をランダムに決定
    x_move=int(random(-5.99,5.99));
    y_move=int(random(-5.99,5.99));
    x=int(random(100,1300));
    y=int(random(100,500));
    cara[i]=new Character(x,y,x_move,y_move);//キャラクタークラスのインスタンスを作り配列へ
  }
}

void draw(){
  frameRate(150);
  if(index==0){//タイトル画面の表示
    PFont font = createFont("日本語の文字化け回避用の存在しないフォント",64,true);//文字化け回避のフォントを作る
    textFont(font);//文字化け回避のフォントを設定
    fill(500,100,100);
    textSize(150);
    text("Hit Face!",350,150);
    fill(0,0,0);
    textSize(60);
    text("ルール：\n画面下にある棒をマウスで動かし\nキャラクターを跳ね返すと得点になります。",50,300);
    text("キーを押してスタート",350,600);
    if(keyPressed){//キーを押したら
      index=1;//次の画面へ
    }
  }
  else if(index==1){//ゲーム開始までカウントダウン
    background(0,0,100);
    fill(0,0,0);
    textSize(150);
    text(co,650,350);//カウントを表示
    framecount=(++framecount)%150;//フレーム数のカウント
    if(framecount==149){co-=1;}//カウントダウン
    if(co==0){index=2;}//カウント0で次の画面に
  }
  else if(index==2){//ゲーム画面の表示
    framecount=(++framecount)%150;//フレームのカウント
    if(framecount==149){time-=1;}//ゲームのタイムリミットを減らす
    chaColor=(chaColor+1)%501;//キャラクターの色を変える
    background(0,0,0);
    for(int i=0;i<3;i++){
      cara[i].move();//キャラクターを移動するメソッドを呼び出す
      cara[i].draws();//キャラクターを描画するメソッドを呼び出す
    }
    if(time>0){//タイムリミットが0より大きければ
      noStroke();
      fill(0,0,100);
      rect(0,0,250,60);//ポイント表示の背景
      fill(0,0,0);
      textSize(60);
      text(pt+"point",20,50);//ポイントの表示
      fill(0,0,100);
      text(time+"seconds",550,50);//タイムリミットの表示
      fill(lineColor,100,100);
      rect(mouseX-150,650,300,50);//棒を描画
      fill(500,100,100);
      rect(mouseX-50,650,100,50);//棒の中心を描画
    }
    if(time<=0){//タイムリミットが0以下なら
      fill(0,0,100);
      textSize(200);
      text("Finish!",400,400);//ゲームの終了を表示
    }
    if(time<=-1){//タイムリミットが-1以下なら
      if(keyPressed){//キーを押したら
        index=3;//次の画面へ
      }
      if((-1*time)%2==1){//タイムリミットの絶対値が奇数なら
        fill(0,0,100);
        textSize(100);
        text("result: "+pt+"point",400,550);//結果を表示
        textSize(50);
        text("キーを押すともう一度スタート",350,100);
      }
    }
  }
  else if(index==3){//ゲームの初期化
    int x,y,x_move,y_move;
    for(int i=0;i<3;i++){//キャラクターのx,y座標、進むx,y方向をランダムに設定
      x_move=int(random(-5.99,5.99));
      y_move=int(random(-5.99,5.99));
      x=int(random(100,1300));
      y=int(random(100,500));
      Character ca=new Character(x,y,x_move,y_move);//キャラクタークラスのインスタンスを宣言
      cara[i]=ca;//宣言したインスタンスをキャラクタークラスの配列へ
    }
    chaColor=0;//キャラクターの色を0に
    pt=0;//ポイントを0に
    time=20;//タイムリミットを20に
    framecount=0;//フレームのカウントを0に
    lineColor=100;//棒の色を100に
    co=3;//カウントダウンを3に
    index=1;//カウントダウン画面へ
  }
}
