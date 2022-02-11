int line_size=8,now=0;
int data[]=new int[12];
int num[][]={{3,2,1,1},{2,2,2,1},{2,1,2,2},{1,4,1,1},{1,1,3,2},{1,2,3,1},{1,1,1,4},{1,3,1,2},{1,2,1,3},{3,1,1,2}};
void setup(){
  size(900,500);
  background(255);
  strokeWeight(1);
  stroke(0);
  fill(0);
  textSize(30);
  for(int i=0;i<12;i++)data[i]=-1;
}
void make(){
  int s_o=0,s_e=0,ch;
  for(int i=0;i<11;i++){
    if(i%2==0)s_e+=data[i];
    else s_o+=data[i];
  }
  s_e*=3;
  ch=s_e+s_o;
  ch=10-(ch%10);
  if(ch==10)ch=0;
  data[11]=ch;
  println(ch);
  int start=55;
  text('0',start-20,400);
  for(int i=0;i<4;i++){
    start+=line_size;
    if(i%2==0){
      rect(start,0,line_size,400);
    }
  }
  for(int i=3;i>=0;i--){
    for(int j=0;j<num[data[0]][i];j++){
      if(i==0 && j==num[data[0]][i]-1)break;
      start+=line_size;
      if(i%2==0)rect(start,0,line_size,350);;
    }
  }
  text(data[0],start-20,400);
  for(int i=1;i<6;i++){
    for(int i2=0;i2<4;i2++){
      for(int j=0;j<num[data[i]][i2];j++){
        start+=line_size;
        if(i2%2==1)rect(start,0,line_size,350);
      }
    }
    text(data[i],start-20,400);
  }
  for(int i=0;i<5;i++){
    start+=line_size;
    if(i%2==1){
      rect(start,0,line_size,400);
    }
  }
  for(int i=6;i<12;i++){
    for(int i2=0;i2<4;i2++){
      for(int j=0;j<num[data[i]][i2];j++){
        start+=line_size;
        if(i2%2==0)rect(start,0,line_size,350);
      }
    }
    text(data[i],start-20,400);
  }
  for(int i=0;i<3;i++){
    start+=line_size;
    if(i%2==0){
      rect(start,0,line_size,400);
    }
  }
}
void draw(){
  boolean doing=true;
  for(int i=0;i<11;i++){
    if(data[i]==-1)doing=false;
  }
  if(doing){
    background(255);
    make();
    for(int i=0;i<11;i++)data[i]=-1;
    now=0;
  }
}
void keyPressed (){
  if(now<12){
    data[now]=key;
    data[now]-='0';
    print(data[now]);
    now++;
  }
}
