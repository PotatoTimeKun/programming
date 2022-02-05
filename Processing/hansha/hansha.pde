int xm=5;
int ym=5;
int x=100;
int y=50;
void setup(){
  size(600,600);
}

void draw(){
  frameRate(150);
  background(0);
  x+=xm;
  y+=ym;
  if(x>=500&&y>=550){xm=int(random(-5.9999999,-1));
ym=int(random(-5.9999999,-1));
x+=xm;
y+=ym;
}
  if(x>100&&x<500&&y>=550){xm=int(random(-5.9999999,5.9999999));
ym=int(random(-5.9999999,-1));
x+=xm;
y+=ym;
}
  if(y>50&&y<550&&x>=500){ym=int(random(-5.9999999,5.9999999));
xm=int(random(-5.9999999,-1));
x+=xm;
y+=ym;
}
  if(x<=100&&y<=50){xm=int(random(1,5.9999999));
ym=int(random(1,5.9999999));
x+=xm;
y+=ym;
}
  if(x>100&&x<500&&y<=50){xm=int(random(-5.9999999,5.9999999));
ym=int(random(1,5.9999999));
x+=xm;
y+=ym;
}
  if(y>50&&y<550&&x<=100){ym=int(random(-5.9999999,5.9999999));
xm=int(random(1,5.9999999));
x+=xm;
y+=ym;
}
  if(x>=500&&y<=50){xm=int(random(-5.9999999,-1));
ym=int(random(1,5.9999999));
x+=xm;
y+=ym;
}
  if(x<=100&&y>=550){xm=int(random(1,5.9999999));
ym=int(random(-5.9999999,-1));
x+=xm;
y+=ym;
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
