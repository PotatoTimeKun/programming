float t=0;
void setup(){
  size(700,500);
  stroke(100,150,255);
}
void draw(){
  background(255);
  drawF(t);
  t+=0.2;
}
void drawF(float t){
  int yMax[]=new int[700],yMin[]=new int[700];
  for(int i=0;i<700;i++){
    yMax[i]=0;
    yMin[i]=500;
  }
  int px_old=0,py_old=0;
  for(int i=0;i<100;i++){
    float y=-50+60.*i/60;
    for(int j=0;j<900;j++){
      float x=-40+60.*j/710;
      float z=f(x,y,t);
      int px=-200+j+2*i,py=500-int(z)-4*i;
      if (px >= 700 || px < 0){
        px_old=px;
        py_old=py;
        continue;
      }
      if(px==0){
        px_old=px;
        py_old=py;
        yMax[px] = yMax[px] < py ? py : yMax[px];
        yMin[px] = yMin[px] > py ? py : yMin[px];
        continue;
      }
      if (yMax[px]>py && yMin[px]<py) {
        float xBefore = -40 + 60.*(j-1) / 710;
        float zBefore = f(xBefore,y,t);
        int pyBefore = 500 - int(zBefore) - 5 * i;
        line(px_old,py_old, px, pyBefore == yMax[px - 1] ? yMax[px] : yMin[px]);
        px_old=px;
        py_old=pyBefore ==yMax[px - 1] ? yMax[px] : yMin[px];
        continue;
      }
      if (yMax[px] < py) {
        px_old=px-1;
        py_old=yMax[px-1];
        yMax[px] = py;
      }
      if (yMin[px] > py) {
        px_old=px-1;
        py_old=yMin[px-1];
        yMin[px] = py;
      }
      line(px_old,py_old,px,py);
      px_old=px;
      py_old=py;
    }
  }
}
float f(float x,float y,float t){
  float distance=sqrt(pow(x,2)+pow(y,2));
  return cos(distance-t)/exp(distance/10)*100;
}
