// 隣接行列
final int adjacencyMatrix[][]=
{
{0,0,0,1,0,1,0,0},
{0,0,0,0,1,0,1,0},
{0,0,0,0,0,1,0,1},
{1,0,0,0,0,0,1,0},
{0,1,0,0,0,0,0,1},
{1,0,1,0,0,0,0,0},
{0,1,0,1,0,0,0,0},
{0,0,1,0,1,0,0,0}
};

// 位数(=頂点数)
final int order=8;

void setup(){
  size(500,500);
  strokeWeight(2);
  final PFont font = createFont("Yu Gothic", 20, true);
  textFont(font);
}

void draw(){
  background(255);
  drawVerteces(order);
  drawEdges(adjacencyMatrix,order);
  noLoop();
}

float getX(int n,int order){return 250+150*cos(2*PI*n/order);} // 頂点の座標
float getY(int n,int order){return 250-150*sin(2*PI*n/order);}

float getCharX(int n,int order){return 245+170*cos(2*PI*n/order);} // 頂点のラベルの座標
float getCharY(int n,int order){return 255-170*sin(2*PI*n/order);}

void drawVerteces(int order){ // 頂点(とその番号)の表示
  fill(0);
  int r=5; // 半径
  for(int i=0;i<order;i++){
    ellipse(getX(i,order),getY(i,order),2*r,2*r);
    text(str(i+1),getCharX(i,order),getCharY(i,order));
  }
}

void drawEdges(final int adjacencyMatrix[][],int order){ // 辺の表示
  if(adjacencyMatrix.length!=order || adjacencyMatrix[0].length!=order){ // 隣接行列は位数×位数の行列
    print("error:size of adjacency matrix must be order * order");
    return;
  }
  for(int i=0;i<order-1;i++){
    for(int j=i+1;j<order;j++){
      if(adjacencyMatrix[i][j]==1)
        line(getX(i,order),getY(i,order),getX(j,order),getY(j,order));
    }
  }
}
