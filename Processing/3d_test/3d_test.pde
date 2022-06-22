float angle=0; // 立方体の角度
int x=0, z=0; // カメラの位置のずれ
boolean x_incr=false, z_incr=false, x_decr=false, z_decr=false; // カメラをずらすかどうか
void setup() {
  size(600, 600, P3D);
  colorMode(HSB); // 色の指定はHSB
}
void draw() {
  if (x_incr)x++;  //カメラの位置をずらす
  if (z_incr)z++;
  if (x_decr)x--;
  if (z_decr)z--;
  background(255);
  translate(300, 300); // 画面中心が(0,0)
  camera(0+x, 100, -100+z, 0+x, 0, 300+z, 0, -1, -1); // カメラの設定、位置の移動と軸を一般的なグラフと同じ向きに直す
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
  switch(key) { // キーが押されたら、カメラを移動
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
  }
}
void keyReleased() { // キーを離したら、カメラの移動を止める
  x_incr=false;
  x_decr=false;
  z_incr=false;
  z_decr=false;
}
