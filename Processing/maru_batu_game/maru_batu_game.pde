boolean turnIsCircle=true;
boolean filled[][]={{false, false, false}, {false, false, false}, {false, false, false}};
void setup() {
  size(600, 600);
  background(255);
  strokeWeight(5);
  for (int i=0; i<=4; i++) {
    line(200*i, 0, 200*i, 600);
    line(0, 200*i, 600, 200*i);
  }
}
void draw(){}
void mousePressed(){
  final int cellIndex[]={mouseX/200,mouseY/200};
  final int drawCenter[]={(cellIndex[0]+1)*200-100,(cellIndex[1]+1)*200-100};
  if (filled[cellIndex[0]][cellIndex[1]])return;
  if (turnIsCircle) {
    stroke(255, 0, 0);
    ellipse(drawCenter[0], drawCenter[1], 180, 180);
  } else {
    stroke(0, 0, 255);
    line(drawCenter[0]+90, drawCenter[1]+90, drawCenter[0]-90, drawCenter[1]-90);
    line(drawCenter[0]-90, drawCenter[1]+90, drawCenter[0]+90, drawCenter[1]-90);
  }
  filled[cellIndex[0]][cellIndex[1]]=true;
  turnIsCircle=!turnIsCircle;
}
void keyPressed(){
  if(key==ENTER){
    stroke(0);
    background(255);
    for(int i=0; i<=4; i++){
      line(200*i, 0, 200*i, 600);
      line(0, 200*i, 600, 200*i);
    }
    for (int x=0; x<3; x++) {
      for (int y=0; y<3; y++)filled[x][y]=false;
    }
  }
}
