final int window=600; // ウィンドウのサイズ(縦横同じ)
float[] xy=new float[6]; // 0,1=時針、2,3=分針、4,5=秒針(単位ベクトルの成分表示)
void settings(){
  size(window,window);
}
void setup(){
  textAlign(CENTER,CENTER); // 時計の数字の真ん中がその時刻になる
  strokeWeight(10);
  textSize(30);
}
void draw(){
  translate(window/2,window/2); // 原点を画面の中央に設定
  background(0);
  frameRate(1); // 1秒毎に更新
  stroke(255);
  fill(0);
  ellipse(0,0,window-20,window-20); // 時計のふち
  fill(255);
  for(int i=0;i<60;i++){ // 等間隔で円状に60回点を打つ
    // 単位円においてΘ度の点の座標は(cos(Θ),sin(Θ))
    point(cos(i/30.*PI)*window/2.2,-sin(i/30.*PI)*window/2.2); // ウィンドウのy軸の正向きは下なのでy座標は-を付ける、window/2.2は半径
  }
  for(int i=0;i<12;i++){ // 等間隔で円状に0~11の数字を表示する
    text(str(i),cos((-3+i)/6.*PI)*window/2.5,sin((-3+i)/6.*PI)*window/2.5); // y軸が下なので回転方向は時計回り、初期値を-PI/2ずらす
  }

  // 各針の単位ベクトルを計算
  xy[0]=cos((-3+hour())/6.*PI); // hour,minute,second関数はそれぞれの時間をintで返す
  xy[1]=sin((-3+hour())/6.*PI);
  xy[2]=cos((-15+minute())/30.*PI);
  xy[3]=sin((-15+minute())/30.*PI);
  xy[4]=cos((-15+second())/30.*PI);
  xy[5]=sin((-15+second())/30.*PI);

  int[] rgb={0,0,0}; // 線の色
  for(int i=0;i<3;i++){ // 各針の方向に色付きの点を打つ
    rgb[i]=255;
    stroke(rgb[0],rgb[1],rgb[2]); // 時=赤、分=緑、秒=青
    point(xy[i*2]*window/2.2,xy[i*2+1]*window/2.2);
    rgb[i]=0;
  }
  stroke(255);

  // ベクトルの線の表示
  line(0,0,(xy[0]+xy[2]+xy[4])*window/9.,(xy[1]+xy[3]+xy[5])*window/9.); // 各針を長さwindow/9のベクトルとし、全て足して線を引く

  // ベクトルの矢印の三角を表示
  translate((xy[0]+xy[2]+xy[4])*window/9.,(xy[1]+xy[3]+xy[5])*window/9.); // 引いた線の先端(原点ではない方)に原点を移動する
  if((xy[0]+xy[2]+xy[4])<0){ // ベクトルのx成分が負なら
    rotate(atan((xy[1]+xy[3]+xy[5])/(xy[0]+xy[2]+xy[4]))-PI/2); // 上向きをベクトルの向く方向に設定、( arctan(y/x)-π/2 )
    triangle(5,5,-5,5,0,0); // 三角形を表示
  }
  else if((xy[0]+xy[2]+xy[4])>0){ // ベクトルのx成分が正なら
    rotate(atan((xy[1]+xy[3]+xy[5])/(xy[0]+xy[2]+xy[4]))+PI/2); // 上向きをベクトルの向く方向に設定、( arctan(y/x)+π/2 )
    triangle(5,5,-5,5,0,0);
  }
}
