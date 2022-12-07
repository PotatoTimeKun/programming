// 隣接行列
final int adjacencyMatrix[][]=
{
{0,1,0,0,0},
{0,0,1,0,0},
{0,0,0,1,0},
{0,0,0,0,1},
{0,0,0,0,0}
};

// 位数(=頂点数)
final int order=5;

void setup(){
  size(500,500);
  strokeWeight(2);
  final PFont font = createFont("Yu Gothic", 20, true);
  textFont(font);
}

void draw(){
  background(255);
  drawEdges(adjacencyMatrix,order);
  drawVerteces(order);
  noLoop();
}

float getX(int n,int order){return 250+150*cos(2*PI*n/order);} // 頂点の座標
float getY(int n,int order){return 250-150*sin(2*PI*n/order);}

float getCharX(int n,int order){return 245+170*cos(2*PI*n/order);} // 頂点のラベルの座標
float getCharY(int n,int order){return 255-170*sin(2*PI*n/order);}

void drawVerteces(int order){ // 頂点(とその番号)の表示
  int r=5; // 半径
  for(int i=0;i<order;i++){
    fill(255,0,0);
    ellipse(getX(i,order),getY(i,order),2*r,2*r);
    text(str(i+1),getCharX(i,order),getCharY(i,order));
  }
}

void drawEdges(final int adjacencyMatrix[][],int order){ // 辺の表示
  if(adjacencyMatrix.length!=order || adjacencyMatrix[0].length!=order){ // 隣接行列は位数×位数の行列
    print("error:size of adjacency matrix must be order * order");
    return;
  }
  for(int i=0;i<order;i++){
    for(int j=0;j<order;j++){
      if(i==j && adjacencyMatrix[i][j]==1){
        drawLoop(i,order);
        continue;
      }
      if(adjacencyMatrix[i][j]==1)
        drawArrow(i,j,order);
    }
  }
}

void drawLoop(int n,int order){ // 自己ループ
  int r=20; // 半径
  noFill();
  ellipse(getX(n,order)+r/sqrt(2),getY(n,order)-r/sqrt(2),2*r,2*r);
  pushMatrix();
  translate(getX(n,order)-5,getY(n,order)-15);
  rotate(-2/3*PI);
  triangle(-5,0,5,0,0,10);
  popMatrix();
}


void drawArrow(int n0,int n1,int order){ // 有向辺n0->n1
  noFill();
  line(getX(n0,order),getY(n0,order),getX(n1,order),getY(n1,order));
  pushMatrix();
  translate(getX(n1,order),getY(n1,order));
  float x=getX(n1,order)-getX(n0,order);
  if(x==0)x=1;
  float y=getY(n1,order)-getY(n0,order);
  if(y==0)y=1;
  float angle=atan(x/y);
  if(y<0)angle+=PI;
  rotate(-angle);
  triangle(-5,-20,5,-20,0,-10);
  popMatrix();
}
