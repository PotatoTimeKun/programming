float angle=0; // 立方体の角度
int x=0, y=0, z=0; // カメラの位置のずれ
float angle_xz=PI/2; // プレイヤーの向く向き(左右)
float angle_y=0; // プレイヤーの向く向き(上下)
boolean x_incr=false, z_incr=false, 
  x_decr=false, z_decr=false,
  y_incr=false, y_decr=false; // カメラをずらすかどうか
boolean right=false, left=false, up=false, down=false; //カメラを回転するかどうか
void setup() {
  size(1000, 600, P3D);
  colorMode(HSB); // 色の指定はHSB
}
void draw() {
  if (x_incr)x+=2;  //カメラの位置をずらす
  if (z_incr)z+=2;
  if (y_incr)y+=2;
  if (x_decr)x-=2;
  if (z_decr)z-=2;
  if (y_decr)y-=2;
  if (left)angle_xz=(angle_xz+PI/100)%(2*PI);  //カメラの向きをずらす
  if (right)angle_xz-=PI/100;
  if (angle_xz<0)angle_xz=2*PI;
  if (up)angle_y+=PI/100;
  if (down)angle_y-=PI/100;
  if (angle_y>PI/2)angle_y=PI/2-0.001; // 上下は-PI/2～PI/2(-PI/2とPI/2は含まない)
  if (angle_y<-PI/2)angle_y=-PI/2+0.001;
  background(255);
  pushMatrix();
  fill(0);
  translate(-50,30,200);
  rotateX(PI);
  text("w:forward\na:left\ns:back\nd:right\nspace:up\nshift:down\narrow:rotate camera", -170,-200,-100); // 操作方法の表示
  popMatrix();
  camera(0+x, 100+y, -100+z,
    abs(cos(angle_y))*cos(angle_xz)+x, sin(angle_y)+100+y,
    abs(cos(angle_y))*sin(angle_xz)-100+z, 0, -1, 0); // カメラの設定、位置の移動と軸を一般的なグラフと同じ向きに直す
  for (int i=0; i<30; i++) {
    for (int j=0; j<30; j++) {
      fill(( (i/60.+j/60.+angle/2)*255 )%255, 255, 255); // レインボーに
      pushMatrix();
      rotateX(PI/2); // z軸だった向きをy軸に
      rect(20*i-300, 20*j, 15, 15); // 床の描画
      popMatrix();
    }
  }
  pushMatrix();
  translate(0, 100, 300); // 立方体を置く位置に移動
  rotateY(angle*PI); // 正面の向きを変える
  fill(angle*255/2, 255, 255); // 色を向きによって変化させる
  box(50, 50, 50); // 全ての辺が50の立方体
  popMatrix();
  angle=(angle+0.01)%2; // 角度を変更
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
