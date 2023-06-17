void setup(){
  size(800,600);
}
final float E=U(-16);
final float M=1;
float v=0;
float x=-16;
void draw(){
  frameRate(150);
  background(255);
  translate(400,400);
  stroke(0);
  line(-400,0,400,0);
  line(0,-500,0,200);
  // x軸は実際の1/20倍にして表示
  for(int x=-400;x<=400;x++)
  {
    line(x,-U(x/20.),x+1,-U((x+1)/20.));
  }
  line(-400,-E,400,-E);
  textSize(20);
  fill(0);
  text("E",5,-E-5);
  text("0",5,-5);
  v+=a(x)/500;
  x+=v/500;
  fill(255,0,0);
  ellipse(x*20,-E,10,10);
  fill(0,0,255);
  stroke(0,0,255);
  line(20*x,-E,20*x,-U(x));
  text("K="+str(round(E-U(x))),20*x,-E-10);
  fill(0);
  text("a="+str(round(a(x))),20*x,-E-40);
}
float U(float x){ // 位置エネルギー
  return pow(x,4)/100-2.2*pow(x,2)-5*x+30;
}
float a(float x){ // 加速度、1/m*(-dU/dx)
  return 1/M*(-4*pow(x,3)/100+4.4*x+5);
}
