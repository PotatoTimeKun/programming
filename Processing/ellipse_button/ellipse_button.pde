int ringColor=240,window=500;
float r=150,r_incr=0.5;
void settings(){
  size(window,window);
}
void draw(){
  frameRate(20);
  background(255);
  fill(ringColor);
  ellipse(window/2,window/2,2*r,2*r); //円の表示
  r=(r+r_incr)%(window/2); //半径の変化
}
void mousePressed(){ //マウスをクリックしたとき
  if(pow(mouseX-window/2,2)+pow(mouseY-window/2,2)<=pow(r,2)){ //円の不等式
    ringColor-=20; //色を変える
    if(ringColor<0)
      ringColor=240;
  }
  fill(255,0,0);
  ellipse(mouseX,mouseY,10,10); //クリックした場所を中心に赤い円を表示
}
