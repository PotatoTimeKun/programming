final int windowX=800,windowY=600;
final int framerate=40;
boolean clicked=false;
boolean moveDirect[]={false,false,false,false}; // wasdに対応
page currentPage=new Start();

import ddf.minim.*;
Minim minim;

void settings(){
  size(windowX,windowY);
}
void setup(){
  final PFont font = createFont("Yu Gothic", 20, true);
  textFont(font);
  minim=new Minim(this);
}
void draw(){
  frameRate(framerate);
  currentPage=currentPage.next();
  currentPage.draws();
  clicked=false;
}

AudioPlayer sounds[]=new AudioPlayer[10];
int audioIndex=-1;
// 音をならす、10個まで重複可能
void sound(AudioPlayer audio){
  audioIndex=(audioIndex+1)%10;
  try{
    sounds[audioIndex].close();
  }
  catch(Exception e){}
  sounds[audioIndex]=audio;
  sounds[audioIndex].play();
}

// 表示画面
interface page{
  page next(); // 画面遷移
  void draws(); // 表示
}

class Start implements page{
  int charaColor;
  int sign;
  Background back;
  Start(){
    charaColor=0;
    sign=1;
    back=new Background();
  }
  page next(){
    charaColor+=sign*150/framerate;
    if(charaColor<0){
      charaColor=0;
      sign*=-1;
    }
    if(charaColor>255){
      charaColor=255;
      sign*=-1;
    }
    back.next();
    if(clicked)return new Count();
    return this;
  }
  void draws(){
    back.draws();
    textSize(30);
    textAlign(CENTER);
    fill(charaColor);
    text("-click to start-",windowX/2,windowY-100);
    textSize(50);
    fill(255);
    text("Space War II",windowX/2,windowY/2);
  }
}

class Count implements page{
  float timer;
  Count(){
    timer=3.99;
  }
  page next(){
    timer-=1./framerate;
    if(timer<1){
      key=' ';
      keyCode=0;
      return new Game();
    }
    return this;
  }
  void draws(){
    background(0);
    textSize(200*(timer-int(timer)));
    textAlign(CENTER);
    fill(255);
    text(str(int(timer)),windowX/2,windowY/2);
  }
}

class Game implements page{
  int point;
  Airplane airplane;
  Beams beams;
  Background back;
  HP hp;
  Enemy enemies[];
  float timer=2;
  float playTime=0;
  Game(){
    point=0;
    airplane=new Airplane();
    beams = new Beams();
    back=new Background();
    hp=new HP(100);
    enemies=new Enemy[10];
    for(int i=0;i<10;i++)enemies[i]=new EmptyEnemy();
  }
  page next(){
    playTime+=1./framerate;
    back.next();
    beams.move(1);
    if(clicked){
      beams.addBeam(airplane.x,airplane.y-20);
      sound(minim.loadFile("./sound/shot.mp3"));
    }
    for(int i=0;i<10;i++)enemies[i]=enemies[i].move(this);
    airplane.move();
    timer+=1./framerate;
    if(timer>3.5-(playTime/10)%3){
      EnemyPlane enemy=new EnemyPlane();
      enemy.moveSpeed+=playTime/20.;
      airplane.moveSpeed=6+playTime/30.;
      addEnemy(enemy);
      timer=0;
    }
    if(hp.isZero()){
      Result returnPage=new Result(point,airplane.x,airplane.y);
      returnPage.back=back;
      return returnPage;
    }
    return this;
  }
  void draws(){
    back.draws();
    beams.draws(false);
    for(int i=0;i<10;i++)enemies[i].draws();
    airplane.draws();
    hp.draws();
    textSize(30);
    textAlign(CENTER);
    fill(255);
    text("Score:"+str(point),windowX/2,30);
  }
  void addEnemy(Enemy enemy){
    for(int i=0;i<10;i++){
      if(!enemies[i].isEmpty())continue;
      enemies[i]=enemy;
      break;
    }
  }
}

class Result implements page{
  int point;
  int charaColor;
  int sign;
  float timer=0;
  float x,y;
  int maxPoint;
  Background back;
  Result(int gamePoint,float airplaneX,float airplaneY){
    charaColor=255;
    point=gamePoint;
    sign=-1;
    x=airplaneX;
    y=airplaneY;
    back=new Background();
    timer=0;
    try{
      BufferedReader reader = createReader("point.txt");   
      String line = reader.readLine();
      maxPoint=int(line);
      reader.close();
    }catch(Exception e){
      maxPoint=0;
    }
    if(maxPoint<gamePoint){
      String strs[]={str(gamePoint)};
      saveStrings("point.txt",strs);
    }
  }
  page next(){
    back.next();
    timer+=1./framerate;
    charaColor+=sign*150/framerate;
    if(charaColor<0){
      charaColor=0;
      sign*=-1;
    }
    if(charaColor>255){
      charaColor=255;
      sign*=-1;
    }
    if(clicked && timer>1.5)return new Count();
    return this;
  }
  void draws(){
    back.draws();
    if(timer<1.5){
      stroke(200,150,150);
      strokeWeight(5);
      fill(255);
      for(int i=0;i<6;i++){
        point(x+15*(timer+1)*cos(2*PI*i/6),y+15*(timer+1)*sin(2*PI*i/6));
      }
    }
    textSize(50);
    fill(255);
    text(str(point)+"point",windowX/2,windowY/2);
    text("max:"+str(maxPoint)+"point",windowX/2,100);
    fill(charaColor);
    text("click to retry",windowX/2,windowY-100);
  }
}

// 飛行機(自分自身)
class Airplane{
  float x;
  float y;
  float moveSpeed=6;
  
  Airplane(){
    x=windowX/2;
    y=windowY-50;
  }
  void move(){
    if(moveDirect[0])y-=moveSpeed;
    if(moveDirect[1])x-=moveSpeed;
    if(moveDirect[2])y+=moveSpeed;
    if(moveDirect[3])x+=moveSpeed;
    if(x<20)x=20;
    if(x>windowX-20)x=windowX-20;
    if(y<20)y=20;
    if(y>windowY-20)y=windowY-20;
  }
  void draws(){
    noStroke();
    ellipse(x,y,10,40);
    triangle(x,y-10,x+20,y,x-20,y);
    triangle(x,y+15,x+10,y+20,x-10,y+20);
  }
}

class Beams{
  float x[];
  float y[];
  float moveSpeed=10;
  Beams(){
    x=new float[100];
    y=new float[100]; // -1 → 存在しない
    for(int i=0;i<100;i++){
      x[i]=-1;
      y[i]=-1;
    }
  }
  void move(int sign){ // 自分から見た正面を正の方向とする,1か-1でビームの動く向きを決める
    for(int i=0;i<100;i++){
      if(y[i]==-1)continue;
      y[i]-=sign*moveSpeed;
      if(y[i]<=-1)y[i]=-1;
      if(y[i]>windowY+20)y[i]=-1;
    }
  }
  void addBeam(float newX,float newY){
    for(int i=0;i<100;i++){
      if(y[i]!=-1)continue;
      x[i]=newX;
      y[i]=newY;
      break;
    }
  }
  void draws(boolean enemyBeam){
    fill(255);
    stroke(100,100,255);
    if(enemyBeam)stroke(255,100,100);
    strokeWeight(2);
    for(int i=0;i<100;i++){
      if(y[i]==-1)continue;
      line(x[i],y[i],x[i],y[i]+10);
    }
  }
}

interface Enemy{
  Enemy move(Game game);
  void draws();
  boolean isEmpty();
}

class EmptyEnemy implements Enemy{
  float x,y;
  Beams beams;
  EmptyEnemy(){
    x=-1;
    y=-1;
    beams=new Beams();
  }
  Enemy move(Game game){
    beams.move(-1);
    for(int i=0;i<100;i++){
      if(beams.y[i]==-1)continue;
      if(pow(game.airplane.x-beams.x[i],2)+pow(game.airplane.y-beams.y[i],2)>pow(20,2))continue;
      game.hp.sub(5);
      shotDamageSound();
      beams.y[i]=-1;
    }
    return this;
  }
  void draws(){
    beams.draws(true);
  }
  void shotDamageSound(){
    sound(minim.loadFile("./sound/shot_attack.mp3"));
  }
  boolean isEmpty(){return true;}
}

class EnemyPlane implements Enemy{
  float x,y;
  int attackCount;
  int rnd[];
  float moveSpeed=4;
  boolean crash;
  boolean crashDamage;
  Beams beams;
  float timer=0;
  EnemyPlane(){
    y=-20;
    rnd=new int[24];
    makeRnd(minute()/10+second()+10,second()+10,71,24,rnd);
    x=100+rnd[(hour()+second())%24]*(windowX-200)/71;
    crash=false;
    crashDamage=false;
    beams=new Beams();
    beams.moveSpeed=7;
  }
  Enemy move(Game game){
    beams.move(-1);
    for(int i=0;i<100;i++){
      if(beams.y[i]==-1)continue;
      if(pow(game.airplane.x-beams.x[i],2)+pow(game.airplane.y-beams.y[i],2)>pow(20,2))continue;
      game.hp.sub(5);
      shotDamageSound();
      beams.y[i]=-1;
    }
    if(crash){
      timer+=1./framerate;
      if(timer<1.5)return this;
      EmptyEnemy returnEnemy= new EmptyEnemy();
      returnEnemy.beams=beams;
      return returnEnemy;
    }
    y+=moveSpeed;
    attackCount++;
    if(attackCount>framerate){
       beams.addBeam(x,y+20);
       beams.moveSpeed=moveSpeed+3;
       attackCount=0;
    }
    for(int i=0;i<100;i++){
      if(game.beams.y[i]==-1)continue;
      if(pow(x-game.beams.x[i],2)+pow(y-game.beams.y[i],2)>pow(20,2))continue;
      crash=true;
      crashSound();
      timer=0;
      game.beams.y[i]=-1;
      game.point+=2;
      break;
    }
    if(pow(x-game.airplane.x,2)+pow(y-game.airplane.y,2)<=pow(20,2)){
      timer=0;
      crash=true;
      crashSound();
      game.hp.sub(40);
    }
    if(y>windowY+20){
      game.point--;
      return new EmptyEnemy();
    }
    return this;
  }
  void draws(){
    if(crash){
      stroke(200,150,150);
      strokeWeight(5);
      fill(255);
      for(int i=0;i<6;i++){
        point(x+15*(timer+1)*cos(2*PI*i/6),y+15*(timer+1)*sin(2*PI*i/6));
      }
      beams.draws(true);
      return;
    }
    noStroke();
    fill(255);
    ellipse(x,y,10,40);
    triangle(x,y+10,x+20,y,x-20,y);
    triangle(x,y-15,x+10,y-20,x-10,y-20);
    beams.draws(true);
  }
  void crashSound(){
    sound(minim.loadFile("./sound/bom.mp3"));
  }
  void shotDamageSound(){
    sound(minim.loadFile("./sound/shot_attack.mp3"));
  }
  boolean isEmpty(){return false;}
}

class HP{
  int value;
  int max;
  HP(int maxVal){
    max=maxVal;
    value=max;
  }
  void sub(int damage){
    value-=damage;
    if(value<0)value=0;
  }
  void add(int healing){
    value+=healing;
    if(value>max)value=max;
  }
  void draws(){
    noStroke();
    fill(255);
    rect(windowX-220,20,200,30);
    fill(100,255,100);
    rect(windowX-20,20,-value*200/max,30);
  }
  boolean isZero(){
    if(value==0)return true;
    return false;
  }
}

class Background{
  float timer;
  int rnd[];
  int loopSec=6;
  Background(){
    timer=0;
    rnd=new int[100];
    makeRnd(31,11,199,100,rnd);
  }
  void next(){
    timer+=1./framerate;
    if(timer>loopSec)timer=0;
  }
  void draws(){
    background(0);
    strokeWeight(2);
    stroke(255);
    for(int i=0;i<100;i+=2){
      point(rnd[i]*windowX/199,(timer/loopSec+rnd[i+1]/199.)*windowY);
      point(rnd[i]*windowX/199,(timer/loopSec+rnd[i+1]/199.-1)*windowY);
    }
  }
}

void mousePressed(){
  clicked=true;
}

void keyPressed(){
  if(key=='w' || keyCode==UP)   moveDirect[0]=true;
  if(key=='a' || keyCode==LEFT) moveDirect[1]=true;
  if(key=='s' || keyCode==DOWN) moveDirect[2]=true;
  if(key=='d' || keyCode==RIGHT)moveDirect[3]=true;
}

void keyReleased(){
  if(key=='w' || keyCode==UP)   moveDirect[0]=false;
  if(key=='a' || keyCode==LEFT) moveDirect[1]=false;
  if(key=='s' || keyCode==DOWN) moveDirect[2]=false;
  if(key=='d' || keyCode==RIGHT)moveDirect[3]=false;
}

// 線形合同法で乱数を生成する関数、mは素数、a,bはm以下の整数、nは配列の要素数
void makeRnd(int a,int b,int m,int n,int[] return_array){
  return_array[0]=b; // x[0]=b
  for(int i=0;i<n-1;i++){
    return_array[i+1]=(a*return_array[i])%m; // 乱数を生成
  }
}