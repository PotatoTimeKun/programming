int x,y,pw=1,xp=1,yp=1,ex,ey;
float xo=300,yo=300;
void setup(){
  size(600,650);
}
void draw(){
  xo=300;
  yo=300;
  if(keyPressed && keyCode==UP){
    yp+=1000000;
  }
  if(keyPressed && keyCode==DOWN){
    yp-=1000000;
    if(yp<1){yp=1;}
  }
  ex=300*xp;
  ey=300*yp;
  background(0);
  stroke(255);
  line(0,300,600,300);
  line(300,0,300,600);
  float xpp,ypp;
  if(xp==-9){
    xpp=0.1;
  }
  else{
    xpp=xp;
  }
  if(yp==-9){
    ypp=0.1;
  }
  else{
    ypp=yp;
  }
  for(x=-300;x<300;x++){
    y=int(pow(x,pw));
    if(x!=-300 && y!=int(pow(300,10)) && y!=int(pow(-300,5)) ){
      if(yo!=300)line(x/xpp+300,-y/ypp+300,xo,yo);
      xo=x/xpp+300;
      yo=-y/ypp+300;
    }
  }
  fill(255);
  for(int i=0;i<6;i++){
    rect(50*i+i*10,600,50,50);
  }
  rect(550,600,50,50);
  textSize(20);
  text("0",280,290);
  if(xp==-9){
    text("30",530,290);
  }else{
    text(ex,530,290);
  }
  if(yp==-9){
    text("30",250,20);
  }else{
    text(ey,250,20);
  }
  text("x",550,320);
  text("y",280,40);
  fill(0);
  textSize(40);
  String[] st={"x+","y+","x-","y-","+","-"};
  for(int i=0;i<6;i++){
    text(st[i],50*i+i*10,640);
  }
  text(pw,550,640);
}
void mousePressed(){
    for(int i=0;i<6;i++){
      if(mouseX>i*60 && mouseX<i*60+50){
        switch(i){
          case 0:
          xp+=10;
          break;
          case 1:
          yp+=10;
          break;
          case 2:
          xp-=10;
          break;
          case 3:
          yp-=10;
          break;
          case 4:
          pw++;
          break;
          case 5:
          pw--;
          break;
        }
        if(xp<-9){xp=-9;}
        if(yp<-9){yp=-9;}
      }
    }
  }
