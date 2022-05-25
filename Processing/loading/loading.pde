float t=0; //時間
float r=150; // 半径
void setup(){
  size(600,600);
  strokeWeight(20);
  colorMode(HSB); // カラーモード指定
  frameRate(120);
}
void draw(){
  translate(300,300); // 中心を画面の真ん中に
  background(0);
  for(float i=0;i<PI;i+=0.4){
    stroke((t-1.5*PI+i)*40,255,255); // グラデーション
    if(t+i>1.5*PI && t+i<3.5*PI)
      point(r*cos(t+i),-r*sin(t+i)); // y軸の方向は数学と逆
  }
  t+=0.03;
  if(t>PI*4)
    t=0;
}
