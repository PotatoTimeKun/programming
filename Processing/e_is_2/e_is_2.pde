float x=0, y=0, z=-100; // カメラの位置のずれ
float angle_xz=PI/2; // プレイヤーの向く向き(左右)
float angle_y=0; // プレイヤーの向く向き(上下)
boolean x_incr=false, z_incr=false,
  x_decr=false, z_decr=false,
  y_incr=false, y_decr=false; // カメラをずらすかどうか
boolean right=false, left=false, up=false, down=false; //カメラを回転するかどうか
Ball ball=new Ball(0, 30, 0, 20);
void setup() {
  size(600, 600, P3D);
}
class Ball { // ボールを扱うクラス
  float x, y, z; // ボールの位置
  float g=9.81; // 重力加速度
  float v=0; // 速さ
  float r; // 半径
  float x_min=0, x_max=4000; // xの最大値/最小値
  float e=2.0; // 反発係数
  Ball(float new_x, float new_y, float new_z, float new_r) { // コンストラクタ(値の設定)
    x=new_x;
    y=new_y;
    z=new_z;
    r=new_r;
  }
  void forward(float time) { // 指定の時間進める
    v-=time*g;
    y+=v*time;
    if (y<x_min+r) { // 床に当たったとき
      v*=-e;
      y=x_min+r;
    } else if (y>x_max-r) { // 天井に当たったとき
      v*=-e;
      y=x_max-r;
    }
  }
  void show() { // ボールを表示
    pushMatrix();
    translate(x, y, z);
    sphere(r);
    popMatrix();
  }
}
void draw() {
  frameRate(100);
  if (x_incr)x+=0.2;  //カメラの位置をずらす
  if (z_incr)z+=0.2;
  if (y_incr)y+=0.2;
  if (x_decr)x-=0.2;
  if (z_decr)z-=0.2;
  if (y_decr)y-=0.2;
  if (left)angle_xz=(angle_xz+PI/1000)%(2*PI);  //カメラの向きをずらす
  if (right)angle_xz-=PI/1000;
  if (angle_xz<0)angle_xz=2*PI;
  if (up)angle_y+=PI/1000;
  if (down)angle_y-=PI/1000;
  if (angle_y>PI/2)angle_y=PI/2-0.001; // 上下は-PI/2～PI/2(-PI/2とPI/2は含まない)
  if (angle_y<-PI/2)angle_y=-PI/2+0.001;
  background(255);
  camera(0+x, 100+y, -100+z,
    abs(cos(angle_y))*cos(angle_xz)+x, sin(angle_y)+100+y,
    abs(cos(angle_y))*sin(angle_xz)-100+z, 0, -1, 0); // カメラの設定、位置の移動と軸を一般的なグラフと同じ向きに直す
  fill(0, 0, 255);
  pushMatrix();
  rotateX(PI/2);
  rect(-1000, -1000, 2000, 2000); // 床
  popMatrix();
  pushMatrix();
  translate(0, 4000, 0);
  rotateX(PI/2);
  rect(-1000, -1000, 2000, 2000); // 天井
  popMatrix();
  stroke(0);
  strokeWeight(1);
  for (int i=-5; i<=5; i++) {
    for (int j=-5; j<=5; j++) {
      line(i*200, 0, j*200, i*200, 4000, j*200); // y軸と平行な補助線
    }
  }
  ball.forward(0.005);
  noStroke();
  fill(255, 0, 0);
  ball.show();
}
void keyPressed() {
  switch(key) { // キーが押されたら、カメラを移動・回転
  case 'w':
    z_incr=true;
    break;
  case 'a':
    x_decr=true;
    break;
  case 's':
    z_decr=true;
    break;
  case 'd':
    x_incr=true;
    break;
  case ' ':
    y_incr=true;
    break;
  }
  switch(keyCode) {
  case LEFT:
    left=true;
    break;
  case RIGHT:
    right=true;
    break;
  case UP:
    up=true;
    break;
  case DOWN:
    down=true;
    break;
  case SHIFT:
    y_decr=true;
    break;
  }
}
void keyReleased() { // キーを離したら、カメラの移動・移動を止める{
  switch(key) { // キーが押されたら、カメラを移動・回転
  case 'w':
    z_incr=false;
    break;
  case 'a':
    x_decr=false;
    break;
  case 's':
    z_decr=false;
    break;
  case 'd':
    x_incr=false;
    break;
  case ' ':
    y_incr=false;
    break;
  }
  switch(keyCode) {
  case LEFT:
    left=false;
    break;
  case RIGHT:
    right=false;
    break;
  case UP:
    up=false;
    break;
  case DOWN:
    down=false;
    break;
  case SHIFT:
    y_decr=false;
    break;
  }
}
