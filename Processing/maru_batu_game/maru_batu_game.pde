boolean even=true;
boolean filled[][]={{false,false,false},{false,false,false},{false,false,false}};
void setup(){
  size(600,600);
  background(255);
  strokeWeight(5);
  for(int i=0;i<=4;i++){
    line(200*i,0,200*i,600);
    line(0,200*i,600,200*i);
  }
}
void draw(){}
void mousePressed(){
  for(int x=200;x<=600;x+=200){
    if(x-200<mouseX && x>mouseX){
      for(int y=200;y<=600;y+=200){
        if(y-200<mouseY && y>mouseY){
          if(!filled[x/200-1][y/200-1]){
            if(even){
              stroke(255,0,0);
              ellipse(x-100,y-100,180,180);
            }else{
              stroke(0,0,255);
              line(x-10,y-10,x-190,y-190);
              line(x-190,y-10,x-10,y-190);
            }
            even=even?false:true;
            filled[x/200-1][y/200-1]=true;
          }
        }
      }
    }
  }
}
void keyPressed(){
  if(key==ENTER){
    stroke(0);
    background(255);
    for(int i=0;i<=4;i++){
      line(200*i,0,200*i,600);
      line(0,200*i,600,200*i);
    }
    for(int x=0;x<3;x++){for(int y=0;y<3;y++)filled[x][y]=false;}
  }
}
