final int x_window = 600, y_window = 700;
int power = 1;
float x, y, x_old, y_old, x_wide=1, y_wide=1;
void settings(){
  size(x_window, y_window+50);
}
void setup(){
  strokeWeight(3);
  show_graph(power);
  show_button();
}
void draw(){}
void show_graph(int x_pow){
  if(x_pow==power)show_graph(x_pow-1);
  else{
    background(0);
    stroke(255);
    line(0, y_window/2, x_window, y_window/2);
    line(x_window/2, 0, x_window/2, y_window);
  }
  x_old = 0;
  y_old = 0;
  x=0;
  y=0;
  stroke(255,0,0);
  if(x_pow!=power)stroke(0,0,255);
  if(x_pow==0){
    line(0, y_window/2, x_window, y_window/2);
    return;
  }
  while(y<y_window*y_wide && y!=Float.valueOf("Infinity")){
    y=pow(x,x_pow);
    if(x_pow!=power)y*=power;
    line(x/x_wide+x_window/2, -y/y_wide+y_window/2, x_old/x_wide+x_window/2, -y_old/y_wide+y_window/2);
    if(x_pow%2==0)line(-x/x_wide+x_window/2, -y/y_wide+y_window/2, -x_old/x_wide+x_window/2, -y_old/y_wide+y_window/2);
    else line(-x/x_wide+x_window/2, y/y_wide+y_window/2, -x_old/x_wide+x_window/2, y_old/y_wide+y_window/2);
    x_old=x;
    y_old=y;
    x++;
  }
}
void show_button(){
  stroke(255);
  fill(255);
  for(int i=0;i<6;i++){
    rect(70*i, y_window, 60, 50);
  }
  rect(x_window-50, y_window, 100, 50);
  textSize(20);
  text("0", x_window/2-20, y_window/2-10);
  text(int(x_window/2*x_wide), x_window-70, y_window/2-10);
  text(int(y_window/2*y_wide), x_window/2-50, 20);
  text("x", x_window-50, y_window/2+20);
  text("y", x_window/2-20, 40);
  fill(0);
  textSize(40);
  String[] st={"x*2","y*2","x/2","y/2","  +","  -"};
  for(int i=0;i<6;i++){
    text(st[i], 70*i+5, y_window+40);
  }
  text(power, x_window-50, y_window+40);
}
void mousePressed(){
  for(int i=0;i<6;i++){
    if(mouseY<y_window)break;
    if(mouseX>i*70 && mouseX<i*70+60){
      switch(i){
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
  show_graph(power);
  show_button();
}
