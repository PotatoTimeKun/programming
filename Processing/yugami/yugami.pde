final int yugami=30;
float t=0;
color data[][]=new color[1000][500];
PImage img;
void setup(){
  size(800,500);
  img=loadImage("potato.png");
  for(int i=0;i<1000;i++){
    for(int j=0;j<500;j++){
      data[i][j]=img.get(i,500-j);
    }
  }
  strokeWeight(2);
}
void draw(){
  for(int i=0;i<500;i++)
  {
    int xAdd=100+int(yugami*sin(i*2*PI/250+t*PI)+yugami);
    for(int j=0;j<800;j++){
      stroke(data[xAdd+j][i]);
      point(j,499-i);
    }
  }
  t+=0.1;
  if(t>2)t=0;
}
