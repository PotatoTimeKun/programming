// 隣接行列
int adjacencyMatrix[][]=
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
int order=8;

void setup(){
  size(1000,600);
  strokeWeight(2);
  final PFont font = createFont("Yu Gothic", 20, true);
  textFont(font);
}

void draw(){
  background(255);
  drawVerteces(order);
  drawEdges(adjacencyMatrix,order);
  drawMatrix(adjacencyMatrix,order);
  fill(0);
  text("directed graph",200,500);
  text("adjacency matrix(red=1,blue=0)",600,500);
  fill(255);
  rect(100,540,200,50);
  rect(400,540,200,50);
  fill(0);
  text("order increase",120,570);
  text("order decrease",420,570);
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

void drawMatrix(int matrix[][],int order){
  for(int i=0;i<order;i++){
    for(int j=0;j<order;j++){
      fill(255,100,100);
      if(matrix[i][j]==0)fill(100,100,255);
      rect(500+460*j/order,20+460*i/order,460/order,460/order);
    }
  }
}

void mousePressed(){
  if(mouseY>=540 && mouseY<=590){
    if(mouseX>=100 && mouseX<=300){
      order+=1;
      adjacencyMatrix=new int[order][order];
      for(int i=0;i<order;i++)
        for(int j=0;j<order;j++)
          adjacencyMatrix[i][j]=0;
    }
    if(mouseX>=400 && mouseX<=700 && order>=2){
      order-=1;
      adjacencyMatrix=new int[order][order];
      for(int i=0;i<order;i++)
        for(int j=0;j<order;j++)
          adjacencyMatrix[i][j]=0;
    }
  }
  int i=int((mouseY-20.)*order/460),j=int((mouseX-500.)*order/460);
  if(i==j)return;
  if(i<0 || i>order-1 || j<0 || j>order-1)return;
  adjacencyMatrix[i][j]=adjacencyMatrix[i][j]==0?1:0;
  adjacencyMatrix[j][i]=adjacencyMatrix[i][j];
}