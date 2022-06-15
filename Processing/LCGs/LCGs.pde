int[] rnd=new int[2000]; // 乱数を格納する配列

void setup(){
  size(600,600);
  background(0);
}

void draw(){
  noLoop();
  stroke(255);
  strokeWeight(5);
  makeRnd(33,2,1801,2000,rnd); // 乱数を生成
  for(int i=0;i<1999;i++){
    point(rnd[i]/3,rnd[i+1]/3); // (x[i],x[i+1])の点をプロット
  }
}

// 線形合同法で乱数を生成する関数、mは素数、a,bはm以下の整数、nは配列の要素数
// x[0]=b,x[i+1]=(x[i]*a)%m
void makeRnd(int a,int b,int m,int n,int[] return_array){
  return_array[0]=b; // x[0]=b
  for(int i=0;i<n-2;i++){
    return_array[i+1]=(a*return_array[i])%m; // 乱数を生成
    if(return_array[i+1]==b)print("周期="+(i+1)); // 周期を表示
  }
}
