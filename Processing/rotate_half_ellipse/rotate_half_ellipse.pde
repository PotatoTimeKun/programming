final int[] windowSize={550, 800};
final float r=10;
float mouseAngle=0;
PImage siki;
void settings() {
  size(windowSize[0], windowSize[1]);
  siki=loadImage("susiki.png");
}

void setup() {
  final PFont font = createFont("Yu Gothic", 20, true);
  textFont(font);
}

void draw() {
  background(255);

  final int ellipseWidth=300;
  pushMatrix();

  translate(ellipseWidth/2+50, ellipseWidth+110);
  float minAngle=PI/2;
  final float blueMenseki=menseki(mouseAngle, r);
  final float redMenseki=PI*r*r/2-blueMenseki; // 半円-青い部分
  for (float i=PI/2; menseki(i, r)<=redMenseki; i-=0.001)
    minAngle=i; // 赤い部分の面積になる角度を求める
  showHalfEllipse(0, ellipseWidth);
  stroke(255, 0, 0);
  for (float i=minAngle; i<PI/2; i+=0.01)
    showLineInEllipse(i, ellipseWidth); // 複数重ねてSの範囲を埋める

  translate(ellipseWidth/2, -ellipseWidth/2-10);
  showHalfEllipse(mouseAngle, ellipseWidth);
  stroke(0, 0, 255);
  for (float i=mouseAngle; i<PI/2; i+=0.01)
    showLineInEllipse(i, ellipseWidth);

  popMatrix();

  image(siki, (windowSize[0]-siki.width)/2, 20);

  translate(100, windowSize[1]-150);
  fill(255, 0, 0);
  showText(minAngle, r);

  translate(200, 0);
  fill(0, 0, 255);
  showText(mouseAngle, r);
}

void showHalfEllipse(final float angle, final int width) {
  // angle[rad]反時計回りに回転した直径widthの下向きの半円
  fill(255);
  strokeWeight(4);
  stroke(0);
  ellipse(0, 0, width+4, width+4);
  pushMatrix();
  rotate(-angle);
  stroke(255);
  rect(-(width/2+5), -width/2-4, width+10, width/2);
  popMatrix();
}

void showLineInEllipse(final float angle, final int width) {
  // 直径widthの円内で中心から-angle[rad]の向きの点からx軸に平行な直線
  strokeWeight(4);
  line(-width/2*cos(angle), width/2*sin(angle), width/2*cos(angle), width/2*sin(angle));
}

float menseki(final float angle, final float r) {
  // 半円と直線に囲まれた面積Sを求める、angle = 0 ~ pi/2
  return r*r*(PI-2*angle-sin(2*angle))/2;
}

void showText(float angle, float r) {
  // 文字情報の表示
  text("半径:r = "+r, 0, 0);
  text("傾き[rad]:θ = "+nf(angle, 1, 2), 0, 50);
  text("面積:S = "+round(menseki(angle, r)), 0, 100);
}

void mouseMoved() {
  // マウスを動かしたときにmouseAngleを更新
  if (mouseY<100)return;
  if (mouseY>windowSize[1]-100)return;
  mouseAngle=(float(mouseY)-100)/(windowSize[1]-200)*PI/2; // 0 ~ pi/2
}
