int x_move=5;
int y_move=5;
int x=100;
int y=50;
void setup(){
  size(600,600);
  frameRate(150);
}

void draw(){
  background(0);
  x+=x_move;//x座標の移動
  y+=y_move;//y座標の移動
  if(x>500){//右端にいるとき
    x=500;
    x_move=int(random(-5.99,-2));//左向きに
  }
  if(x<100){//左端にいるとき
    x=100;
    x_move=int(random(2,5.99));//右向きに
  }
  if(y>550){//下端にいるとき
    y=550;
    y_move=int(random(-5.99,-2));//上向きに
  }
  if(y<50){//上端にいるとき
    y=50;
    y_move=int(random(2,5.99));//下向きに
  }
  strokeWeight(5);
  stroke(255);
  line(x-50,y,x-100,y);
  line(x-100,y,x-100,y+50);
  line(x+50,y,x+100,y);
  line(x+100,y,x+100,y-50);
  fill(255);
  noStroke();
  ellipse(x,y,100,100);
  strokeWeight(3);
  stroke(0);
  line(x-30,y-10,x-20,y-20);
  line(x-20,y-20,x-10,y-10);
  line(x+30,y-10,x+20,y-20);
  line(x+20,y-20,x+10,y-10);
  bezier(x,y+15,x,y+30,x-15,y+30,x-15,y+15);
  bezier(x,y+15,x,y+30,x+15,y+30,x+15,y+15);
}
