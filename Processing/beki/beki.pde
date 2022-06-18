final int x_window = 600, y_window = 700; // ウィンドウのサイズ
int power = 1; // 現在の指数
float x, y, x_old, y_old; // 座標
float x_wide=1, y_wide=1; // 表示するグラフの縮小率

void settings(){
  size(x_window, y_window+50); // ボタンの分yを50多く
}
void setup(){
  strokeWeight(3);
  show_graph(power);
  show_button();
}
void draw(){}

// グラフを表示する関数、引数は指数
void show_graph(int x_pow){
  if(x_pow==power)show_graph(x_pow-1); // 微分を表示(1度だけ)
  else{ // 表示するのが微分のグラフでないとき
    background(0);
    stroke(255);
    line(0, y_window/2, x_window, y_window/2);
    line(x_window/2, 0, x_window/2, y_window); // x,y軸を表示
  }
  x_old = 0; //座標は0で初期化しておく
  y_old = 0;
  x=0;
  y=0;
  stroke(255,0,0);
  if(x_pow!=power)stroke(0,0,255); // 微分を表示するときは線を青く
  if(x_pow==0){ // 0乗のグラフは直線を表示して終了
    line(0, y_window/2, x_window, y_window/2);
    return;
  }
  while(y<y_window*y_wide && y!=Float.valueOf("Infinity")){ // yが表示域を超える かつ yの値が∞でないとき
    y=pow(x,x_pow); // yを計算
    if(x_pow!=power)y*=power; // 微分のときは乗数をかける
    line(x/x_wide+x_window/2, -y/y_wide+y_window/2, x_old/x_wide+x_window/2, -y_old/y_wide+y_window/2); // 前回の点から計算した点を線でつなぐ
    if(x_pow%2==0)line(-x/x_wide+x_window/2, -y/y_wide+y_window/2, -x_old/x_wide+x_window/2, -y_old/y_wide+y_window/2); // 乗数が偶数なら、負方向はxを反転して表示
    else line(-x/x_wide+x_window/2, y/y_wide+y_window/2, -x_old/x_wide+x_window/2, y_old/y_wide+y_window/2); // 乗数が奇数なら、負方向はx,yを反転して表示
    x_old=x;
    y_old=y;
    x++;
  }
}

// ボタン等を表示する関数
void show_button(){
  stroke(255);
  fill(255);
  for(int i=0;i<6;i++){ // ボタンの枠を表示
    rect(70*i, y_window, 60, 50);
  }
  rect(x_window-50, y_window, 100, 50);
  textSize(20);
  text("0", x_window/2-20, y_window/2-10); // 原点
  text(int(x_window/2*x_wide), x_window-70, y_window/2-10); // x軸で表示できる最大値
  text(int(y_window/2*y_wide), x_window/2-50, 20); // y軸で表示できる最大値
  text("x", x_window-50, y_window/2+20); // x軸
  text("y", x_window/2-20, 40); // y軸
  fill(0);
  textSize(40);
  String[] st={"x*2","y*2","x/2","y/2","  +","  -"};
  for(int i=0;i<6;i++){ // 一定間隔でst配列の文字を表示
    text(st[i], 70*i+5, y_window+40);
  }
  text(power, x_window-50, y_window+40); // 乗数
}

// マウスをクリックした時のボタンの処理
void mousePressed(){
  for(int i=0;i<6;i++){
    if(mouseY<y_window)break;
    if(mouseX>i*70 && mouseX<i*70+60){
      switch(i){ // i=何番目のボタンを押したか
        case 0:
          x_wide*=2;
          break;
        case 1:
          y_wide*=2;
          break;
        case 2:
          x_wide/=2;
          break;
        case 3:
          y_wide/=2;
          break;
        case 4:
          if(x<99)power++;
          break;
        case 5:
          if(x>1)power--;
          break;
      }
    }
  }
  show_graph(power); // ボタンを押したら表示も変化する
  show_button();
}
