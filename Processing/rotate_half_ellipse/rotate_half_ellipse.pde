final int[] windowSize={600, 700};
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

  pushMatrix();
  translate(windowSize[0]/2, 400/2+100);
  showHalfEllipse(mouseAngle, 400);
  for (float i=mouseAngle; i<PI/2; i+=0.01)
    showLineInEllipse(i, 400); // 複数重ねてSの範囲を埋める
  popMatrix();
  
  image(siki, (windowSize[0]-siki.width)/2, 20);
  
  // 文字情報の表示
  fill(0);
  text("半径:r = "+r, 100, 550);
  text("傾き[rad]:θ = "+nf(mouseAngle, 1, 2), 100, 600);
  text("青い部分の面積:S = "+int(menseki(mouseAngle, r)), 100, 650);
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
  stroke(0, 0, 255);
  line(-width/2*cos(angle), width/2*sin(angle), width/2*cos(angle), width/2*sin(angle));
}

float menseki(final float angle, final float r) {
  // 半円と直線に囲まれた面積Sを求める、angle = 0 ~ pi/2
  return r*r*(PI/2-angle)+r*r*sin(2*angle)-2*r*r*cos(angle)*sin(angle);
}

void mouseMoved() {
  // マウスを動かしたときにmouseAngleを更新
  if (mouseY<100)return;
  if (mouseY>windowSize[1]-100)return;
  mouseAngle=(float(mouseY)-100)/(windowSize[1]-200)*PI/2; // 0 ~ pi/2
}
