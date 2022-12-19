// 隣接行列
int adjacencyMatrix[][]=
{
{1,1,0,0,0,0},
{1,1,0,0,0,0},
{0,0,1,1,1,0},
{0,0,1,1,1,0},
{0,0,1,1,1,0},
{0,0,0,0,0,1},
};

// 位数(=頂点数)
int order=6;

void setup(){
  size(1000,600);
  strokeWeight(2);
  final PFont font = createFont("Yu Gothic", 20, true);
  textFont(font);
}

void draw(){
  background(255);
  drawEdges(adjacencyMatrix,order);
  drawVerteces(order);
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
  if(i<0 || i>order-1 || j<0 || j>order-1)return;
  adjacencyMatrix[i][j]=adjacencyMatrix[i][j]==0?1:0;
}
