int[][] data={{-3,3},{-6,-1},{4,8},{-9,5},{2,-4},{3,3},{6,7},{-1,-2},{7,-6},{-10,-5},{-2,8}}; // x (x1,x2)
int[] label={-1,-1,1,1,-1,1,1,-1,1,1,1}; // y
final int _dataLen=11;  // データ数
float[] t={1,1,1,1}; // Θ
final float ETA=0.0001; // 学習率
void setup(){
  size(440,440);
}
void draw(){
  noLoop();
  translate(220,220);
  line(0,-220,0,220);
  line(-220,0,220,0);
  for(int i=0;i<100000;i++){ // 確率的勾配降下法
    int j=int(random(_dataLen)); // ランダムなインデックス
    for(int k=0;k<4;k++)t[k]+=ETA*(label[j]-(t[0]+t[1]*data[j][0]+t[2]*data[j][0]*data[j][0]+t[3]*data[j][1]))*pow(data[j][0],k%3)*pow(data[j][1],k/3);
    // Θ[j] = Θ[j]+ETA*(y[k]-f(x[k]))*x[k][j] (kはランダムなインデックス)
  }
  strokeWeight(4);
  float y=100,x_forw=-12.1,y_forw=100;
  for(float x=-12;x<=12;x+=0.1){ // ΘTx=0を表示
    y=-(t[0]+t[1]*x+t[2]*x*x)/t[3];
    line(x_forw*20,-y_forw*20,x*20,-y*20);
    x_forw=x;
    y_forw=y;
  }
  strokeWeight(7);
  for(int j=0;j<_dataLen;j++){ // プロットを表示
    if(label[j]==1)stroke(255,0,0);
    else stroke(0,0,255);
    point(data[j][0]*20,-data[j][1]*20);
  }
  print("Θ=("+t[0]+","+t[1]+","+t[2]+","+t[3]+")");
}
