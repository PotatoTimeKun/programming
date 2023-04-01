final int windowX=800,windowY=600;
final int framerate=40;
boolean clicked=false;
boolean keyPress[]=new boolean[128];
page currentPage=new Start();
int hpBoost=0;
int heal=0;
float speedBoost=0;
boolean bigBeam=false;
boolean haveKnife=false;
boolean beamGod=false;

import ddf.minim.*;
Minim minim;

String tipsText[]={
  "ゲーム中にEnterキーを押すと一時停止する。",
  "ショップで買った効果は直後の1ゲームまで。",
  "右クリックでも左クリックでも射撃可能。",
  "敵宇宙船墜落2点、敵宇宙船逃亡-1点、1点=10cosmo。",
  "基本HPは100、光線1弾5ダメージ。",
  "キーボーｄｄｄｄｄｄｄｄｄｄッドが壊れた",
  "製作者Twitter @potato_time_",
  "全tipsコンプリートできるかな←",
  "tipsが役に立つ情報だけだと思うなよ?",
  "時間経過で自分のスピードは上がるが、敵はより速くなる。",
  "もう無理だと思ったら、一時停止メニューから\nリザルトに飛んで金を確実に取るのもあり。",
  "中途半端なオブジェクト指向を使っている気がする。",
  "負のポイントや大きい値は想定していない、\nオーバーフローさせようとか考えるなよ?←",
  "point.txtはセーブデータ、チート対策なくて草",
  "tipsはTwitterじゃない",
  "両端は安全地帯",
  "真空の宇宙空間で音は聞こえない、じゃあここは?",
  "自分の撃つビームはウィンドウ内に100弾存在可能。",
  "表示するtipsは今時計が何秒かで決まる。",
  "敵にぶつかると爆破して結構なダメージを食らう、\n具体的には40ダメージ。",
  "当たり判定は基本的に円と点で行う、\nなので宇宙船同士は見た目ほど当たらない。",
  "ナイフは強い武器ではあるが、1秒のクールダウンがある。",
  "ショップで買える「? ? ?」の効果は使って確かめてみて。",
  "500行だったこのゲームがver2で1000行になった。",
  "今のところ全ての敵は1撃で倒せるが、\n敵にもHPの概念は存在する",
  "回復玉はプログラム上「敵クラス」として実装している。",
  "ナイフシャワーも敵クラスだ、\nただし攻撃は入らないしHPの概念もない",
  "ナイフを敵が使えるなら自分も使える"
};

void settings(){
  size(windowX,windowY);
}
void setup(){
  final PFont font = createFont("Yu Gothic", 20, true);
  textFont(font);
  minim=new Minim(this);
  for(int i=0;i<128;i++)keyPress[i]=false;
}
void draw(){
  frameRate(framerate);
  currentPage=currentPage.next();
  currentPage.draws();
  clicked=false;
}

int saveMaxPoint(int gamePoint){
  int maxPoint=0;
  String lines[]=loadStrings("point.txt");
  try{
    maxPoint=int(lines[0]);
  }catch(Exception e){
    maxPoint=0;
    String newLines[]={"0"};
    lines=newLines;
  }
  if(maxPoint<gamePoint){
    maxPoint=gamePoint;
    lines[0]=str(maxPoint);
    saveStrings("point.txt",lines);
  }
  return maxPoint;
}

int getMoney(){
  int money=0;
  String lines[]=loadStrings("point.txt");
  try{
    money=int(lines[1]);
  }catch(Exception e){
    money=0;
  }
  return money;
}

boolean addMoney(int adding){
  int money=getMoney();
  if(money+adding<0)return false;
  money+=adding;
  String lines[]=loadStrings("point.txt");
  if(lines.length<2){
    String newLines[]={str(saveMaxPoint(0)),"0"};
    lines=newLines;
  }
  lines[1]=str(money);
  saveStrings("point.txt",lines);
  return true;
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

void shotDamageSound(){
  sound(minim.loadFile("./sound/shot_attack.mp3"));
}
void shotSound(){
  sound(minim.loadFile("./sound/shot.mp3"));
}
void crashSound(){
  sound(minim.loadFile("./sound/bom.mp3"));
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
    back.next();
    charaColor+=sign*150/framerate;
    if(charaColor<0){
      charaColor=0;
      sign*=-1;
    }
    if(charaColor>255){
      charaColor=255;
      sign*=-1;
    }
    if(clicked)return new Menu();
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

class Menu implements page{
  int money;
  int select;
  float timer=0;
  Airplane upPlane;
  EnemyPlane downPlane;
  Menu(){
    money=getMoney();
    select=0;
    upPlane=new Airplane();
    downPlane=new EnemyPlane();
    upPlane.x=windowX/4;
    upPlane.y=windowY/3+windowY/4+70;
    downPlane.x=windowX*3/4;
    downPlane.y=windowY*2/3-windowY/4-70;
  }
  page next(){
    timer+=1./framerate;
    if(pow(mouseX-windowX/4,2)+pow(mouseY-windowY/3,2)<pow(windowY/4,2))
      select=0;
    if(pow(mouseX-windowX*3/4,2)+pow(mouseY-windowY*2/3,2)<pow(windowY/4,2))
      select=1;
    if(clicked && select==0)
      return new Count();
    if(clicked && select==1)
      return new Shop();
    return this;
  }
  void draws(){
    background(0);
    fill(100,100,200);
    if(select==0){
      fill(255);
      upPlane.draws();
      noStroke();
      fill(150,150,200);
    }
    ellipse(windowX/4,windowY/3,windowY/2,windowY/2);
    fill(100,100,200);
    if(select==1){
      downPlane.draws();
      noStroke();
      fill(150,150,200);
    }
    ellipse(windowX*3/4,windowY*2/3,windowY/2,windowY/2);
    float selectCenterX=windowX/4;
    float selectCenterY=windowY/3;
    if(select==1){
      selectCenterX*=3;
      selectCenterY*=2;
    }
    for(int i=0;i<20;i++){
      fill(150,150,200);
      ellipse(selectCenterX+(windowY/4+20)*cos(2*i*PI/20+timer),selectCenterY+(windowY/4+20)*sin(2*i*PI/20+timer),10,10);
    }
    textSize(40);
    textAlign(CENTER);
    fill(255);
    text("play",windowX/4,windowY/3+10);
    text("shop",windowX*3/4,windowY*2/3+10);
    textSize(20);
    text("("+str(money)+" cosmo)",windowX*3/4,windowY*2/3+30);
  }
}

class Shop implements page{
  Shop(){}
  page next(){
    if(pow(mouseX-50,2)+pow(mouseY-50,2)<pow(40,2)&&clicked)return new Menu();
    if(clicked&&pow(mouseX-windowX/6,2)+pow(mouseY-(windowY-100)/4-100,2)<pow((windowY-100)/4-20,2)){
      if(addMoney(-500))hpBoost+=10;
    }
    if(clicked&&pow(mouseX-windowX*3/6,2)+pow(mouseY-(windowY-100)/4-100,2)<pow((windowY-100)/4-20,2)){
      if(addMoney(-2000))heal+=1;
    }
    if(clicked&&pow(mouseX-windowX*5/6,2)+pow(mouseY-(windowY-100)/4-100,2)<pow((windowY-100)/4-20,2)){
      if(addMoney(-2000))speedBoost+=1;
    }
    if(clicked&&pow(mouseX-windowX/6,2)+pow(mouseY-(windowY-100)*3/4-100,2)<pow((windowY-100)/4-20,2)){
      if(bigBeam)return this;
      if(addMoney(-5000))bigBeam=true;
    }
    if(clicked&&pow(mouseX-windowX*3/6,2)+pow(mouseY-(windowY-100)*3/4-100,2)<pow((windowY-100)/4-20,2)){
      if(haveKnife)return this;
      if(addMoney(-10000))haveKnife=true;
    }
    if(clicked&&pow(mouseX-windowX*5/6,2)+pow(mouseY-(windowY-100)*3/4-100,2)<pow((windowY-100)/4-20,2)){
      if(beamGod)return this;
      if(addMoney(-100000))beamGod=true;
    }
    return this;
  }
  void draws(){
    background(0);
    noStroke();
    fill(255);
    ellipse(50,50,80,80);
    fill(100,100,200);
    ellipse(windowX/6,(windowY-100)/4+100,(windowY-100)/2-40,(windowY-100)/2-40);
    ellipse(windowX*3/6,(windowY-100)/4+100,(windowY-100)/2-40,(windowY-100)/2-40);
    ellipse(windowX*5/6,(windowY-100)/4+100,(windowY-100)/2-40,(windowY-100)/2-40);
    ellipse(windowX/6,(windowY-100)*3/4+100,(windowY-100)/2-40,(windowY-100)/2-40);
    ellipse(windowX*3/6,(windowY-100)*3/4+100,(windowY-100)/2-40,(windowY-100)/2-40);
    ellipse(windowX*5/6,(windowY-100)*3/4+100,(windowY-100)/2-40,(windowY-100)/2-40);
    fill(255);
    textSize(30);
    text(str(getMoney())+" cosmo",windowX/2,50);
    textSize(20);
    text("+10HP\n[500cosmo]",windowX/6,(windowY-100)/4+100);
    text("+1HP/5s\n[2000cosmo]",windowX*3/6,(windowY-100)/4+100);
    text("+40dot/s\n[2000cosmo]",windowX*5/6,(windowY-100)/4+100);
    text("ビーム改良\n[5000cosmo]",windowX/6,(windowY-100)*3/4+100);
    text("ナイフ\n[10000cosmo]",windowX*3/6,(windowY-100)*3/4+100);
    text("? ? ?\n[100000cosmo]",windowX*5/6,(windowY-100)*3/4+100);
    strokeWeight(5);
    stroke(0);
    fill(0);
    line(25,50,75,50);
    triangle(25,50,35,45,35,55);
  }
}

class Count implements page{
  float timer;
  String tips;
  Count(){
    timer=3.99;
    tips=tipsText[second()%tipsText.length];
  }
  page next(){
    timer-=1./framerate;
    if(timer<1)return new Game();
    return this;
  }
  void draws(){
    background(0);
    textSize(200*(timer-int(timer)));
    textAlign(CENTER);
    fill(255);
    text(str(int(timer)),windowX/2,windowY/2);
    textSize(20);
    text("tips:"+tips,windowX/2,windowY-50);
  }
}

class Game implements page{
  int point;
  Airplane airplane;
  Background back;
  Enemy enemies[];
  float timer=2;
  float healTimer=5;
  float playTime=0;
  boolean gameStop=false;
  Game(){
    point=0;
    airplane=new Airplane();
    airplane.hp=new HP(100+hpBoost);
    airplane.moveSpeed+=speedBoost;
    back=new Background();
    enemies=new Enemy[10];
    for(int i=0;i<10;i++)enemies[i]=new EmptyEnemy();
  }
  page next(){
    if(gameStop){
      if(keyPress[int('\n')]){
        gameStop=false;
        keyPress[int('\n')]=false;
      }
      if(!clicked)return this;
      if(mouseX>=150&&mouseX<=windowX-150&&mouseY>=(windowY-200)*2/4+60&&mouseY<=(windowY-200)*2/4+140)gameStop=false;
      if(mouseX>=150&&mouseX<=windowX-150&&mouseY>=(windowY-200)*3/4+60&&mouseY<=(windowY-200)*3/4+140){
        gameStop=false;
        draws();
        return new Result(point,airplane.x,airplane.y);
      }
      return this;
    }
    if(keyPress[int('\n')]){
      keyPress[int('\n')]=false;
      gameStop=true;
    }
    playTime+=1./framerate;
    healTimer-=1./framerate;
    back.next();
    for(int i=0;i<10;i++)enemies[i]=enemies[i].move(this);
    airplane.move();
    for(int i=0;i<10;i++){
      enemies[i].attack(airplane);
      point+=airplane.attack(enemies[i]);
      if(enemies[i].isCrossTo(airplane.x,airplane.y)){
        airplane.hp.sub(40);
        enemies[i].attacked(999999);
      }
    }
    timer+=1./framerate;
    if(timer>3.5-(playTime/10)%3){
      Enemy enemy=new EmptyEnemy();
      int enemyNumber=int(rand()*10);
      if(enemyNumber==1)enemy=new BomPlane();
      else if(enemyNumber==2){
        enemy=new KnifePlane();
        enemy.moveSpeed+=playTime/30.;
      }
      else if(enemyNumber==3){
        enemy=new HealBall();
      }
      else if(enemyNumber==4){
        enemy=new KnifeShower();
      }
      else{
        enemy=new EnemyPlane();
        enemy.moveSpeed+=playTime/20.;
      }
      airplane.moveSpeed=6+speedBoost+playTime/30.;
      addEnemy(enemy);
      timer=0;
    }
    if(healTimer<0){
      airplane.hp.add(heal);
      healTimer=5;
    }
    if(airplane.hp.isZero()){
      Result returnPage=new Result(point,airplane.x,airplane.y);
      returnPage.back=back;
      return returnPage;
    }
    return this;
  }
  void draws(){
    if(gameStop){
      noStroke();
      fill(255);
      rect(100,100,windowX-200,windowY-200);
      fill(0);
      textSize(40);
      textAlign(CENTER);
      text("Menu",windowX/2,150);
      text("Back to game",windowX/2,(windowY-200)*2/4+115);
      text("Go to result",windowX/2,(windowY-200)*3/4+115);
      noFill();
      strokeWeight(5);
      stroke(0);
      rect(150,(windowY-200)*2/4+60,windowX-300,80);
      rect(150,(windowY-200)*3/4+60,windowX-300,80);
      return;
    }
    back.draws();
    for(int i=0;i<10;i++)enemies[i].draws();
    airplane.draws();
    airplane.hp.draws();
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
    heal=0;
    hpBoost=0;
    speedBoost=0;
    bigBeam=false;
    haveKnife=false;
    beamGod=false;
    charaColor=255;
    point=gamePoint;
    sign=-1;
    x=airplaneX;
    y=airplaneY;
    back=new Background();
    timer=0;
    maxPoint=saveMaxPoint(gamePoint);
    if(gamePoint>0)addMoney(gamePoint*10);
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
    if(clicked && timer>1.5)return new Menu();
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
  HP hp;
  Beams beams[]={new Beams(),new Beams(),new Beams()};
  float timer=0;
  float knifeCoolDown=0;

  Airplane(){
    hp=new HP(100);
    x=windowX/2;
    y=windowY-50;
  }
  void move(){
    if(keyPress[int('w')] || keyPress[int('W')])y-=moveSpeed;
    if(keyPress[int('a')] || keyPress[int('A')])x-=moveSpeed;
    if(keyPress[int('s')] || keyPress[int('S')])y+=moveSpeed;
    if(keyPress[int('d')] || keyPress[int('D')])x+=moveSpeed;
    if(x<20)x=20;
    if(x>windowX-20)x=windowX-20;
    if(y<20)y=20;
    if(y>windowY-20)y=windowY-20;
    for(int i=0;i<3;i++)beams[i].move(1);
    if(clicked||beamGod){
      beams[0].addBeam(x,y-20);
      if(bigBeam){
        for(int i=0;i<2;i++)beams[i+1].addBeam(x+30-60*i,y-20);
      }
      sound(minim.loadFile("./sound/shot.mp3"));
    }
    timer+=1./framerate;
    knifeCoolDown-=1./framerate;
    if(knifeCoolDown<0)knifeCoolDown=0;
  }
  void draws(){
    fill(255);
    if(haveKnife){
      strokeWeight(4);
      stroke(255);
      for(int i=0;i<10;i++){
        line(x+100*cos(2*i*PI/10+timer),y+100*sin(2*i*PI/10+timer),x+70*cos(2*i*PI/10+timer),y+70*sin(2*i*PI/10+timer));
        line(x+80*cos(2*i*PI/10+timer-0.1),y+80*sin(2*i*PI/10+timer-0.1),x+80*cos(2*i*PI/10+timer+0.1),y+80*sin(2*i*PI/10+timer+0.1));
      }
    }
    noStroke();
    ellipse(x,y,10,40);
    triangle(x,y-10,x+20,y,x-20,y);
    triangle(x,y+15,x+10,y+20,x-10,y+20);
    for(int i=0;i<3;i++)beams[i].draws(false);
  }
  boolean isCrossTo(float X,float Y){
    if(pow(x-X,2)+pow(y-Y,2)<=20*20)return true;
    return false;
  }
  int attack(Enemy enemy){
    int point=0;
    for(int i=0;i<3;i++){
      for(int j=0;j<100;j++){
        if(beams[i].y[j]==-1)continue;
        if(enemy.isCrossTo(beams[i].x[j],beams[i].y[j])){
          beams[i].y[j]=-1;
          point+=enemy.attacked(5);
        }
      }
    }
    if(pow(enemy.x-x,2)+pow(enemy.y-y,2)<=100*100&&knifeCoolDown<=0&&haveKnife){
      point+=enemy.attacked(10);
      knifeCoolDown=1;
    }
    return point;
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

class Enemy{
  float x,y;
  float moveSpeed=4;
  Enemy(){};
  Enemy move(Game game){return this;};
  void draws(){};
  boolean isEmpty(){return true;};
  boolean isCrossTo(float X,float Y){return false;};
  int attacked(int damage){return 0;};
  void attack(Airplane airplane){};
}

class KnifeShower extends Enemy{
  boolean attacked=false;
  float timer=2;
  KnifeShower(){
    x=100+rand()*(windowX-200);
  }
  Enemy move(Game game){
    timer-=1./framerate;
    if(timer<-2)return new EmptyEnemy();
    return this;
  }
  void draws(){
    if(timer>=0){
      noStroke();
      fill(200,100,100,150*(timer%1));
      rect(x-50,0,100,windowY);
    }else{
      stroke(255);
      strokeWeight(2);
      fill(255);
      for(int i=0;i<100;i++){
        for(int j=0;j<3;j++){
          line(x-37.5+33*j,-100*i-1000*timer,x-37.5+33*j,-100*i-30-1000*timer);
          line(x-25+33*j,-100*i-20-1000*timer,x-50+33*j,-100*i-20-1000*timer);
        }
      }
    }
  }
  boolean isEmpty(){return false;}
  void attack(Airplane airplane){
    if(airplane.x>=x-50&&airplane.x<=x+50&&!attacked&&timer<0){
      airplane.hp.sub(15);
      attacked=true;
    }
  }
}

class HealBall extends Enemy{
  boolean healed=false;
  float timer=0;
  float xInit;
  HealBall(){
    y=-20;
    x=100+rand()*(windowX-200);
    xInit=x;
  }
  Enemy move(Game game){
    if(healed)return new EmptyEnemy();
    timer+=1./framerate;
    y+=moveSpeed;
    x=xInit+50*cos(timer);
    timer+=1./framerate;
    return this;
  }
  void draws(){
    noStroke();
    fill(100,200,100);
    ellipse(x,y,40,40);
    strokeWeight(6);
    stroke(0);
    line(x-15,y,x+15,y);
    line(x,y+15,x,y-15);
  }
  boolean isEmpty(){return false;}
  void attack(Airplane airplane){
    if(pow(airplane.x-x,2)+pow(airplane.y-y,2)<=pow(40,2)){
      airplane.hp.add(10);
      healed=true;
    }
  }
}

class EmptyEnemy extends Enemy{
  Beams beams;
  EmptyEnemy(){
    x=-1;
    y=-1;
    beams=new Beams();
  }
  Enemy move(Game game){
    beams.move(-1);
    return this;
  }
  void draws(){
    beams.draws(true);
  }
  boolean isEmpty(){return true;}
  boolean isCrossTo(float X,float Y){return false;}
  int attacked(int damage){return 0;}
  void attack(Airplane airplane){
    for(int i=0;i<100;i++){
      if(beams.y[i]==-1)continue;
      if(isCrossTo(beams.x[i],beams.y[i])){
        beams.y[i]=-1;
        airplane.hp.sub(5);
        shotDamageSound();
      }
    }
  }
}

class EnemyPlane extends Enemy{
  int attackCount;
  Beams beams;
  float timer=0;
  HP hp;
  EnemyPlane(){
    y=-20;
    x=100+rand()*(windowX-200);
    beams=new Beams();
    beams.moveSpeed=7;
    hp=new HP(5);
  }
  Enemy move(Game game){
    beams.move(-1);
    if(hp.isZero()){
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
    if(y>windowY+20){
      game.point--;
      return new EmptyEnemy();
    }
    return this;
  }
  void draws(){
    if(hp.isZero()){
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
  boolean isEmpty(){return false;}
  boolean isCrossTo(float X,float Y){
    if(hp.isZero())return false;
    if(pow(x-X,2)+pow(y-Y,2)<=20*20)return true;
    return false;
  }
  int attacked(int damage){
    if(hp.isZero())return 0;
    hp.sub(damage);
    if(hp.isZero()){
      crashSound();
      return 2;
    }
    return 0;
  }
  void attack(Airplane airplane){
    for(int i=0;i<100;i++){
      if(beams.y[i]==-1)continue;
      if(airplane.isCrossTo(beams.x[i],beams.y[i])){
        airplane.hp.sub(5);
        beams.y[i]=-1;
        shotDamageSound();
      }
    }
  }
}

class BomPlane extends EnemyPlane{
  boolean bom=false;
  boolean bomHit=false;
  float attackTimer=3;
  Enemy move(Game game){
    attackCount=0;
    attackTimer-=1./framerate;
    return super.move(game);
  }
  void draws(){
    if(!bom){
      super.draws();
      return;
    }
    stroke(200,150,150);
    strokeWeight(5);
    fill(255);
    for(int i=0;i<8;i++){
      point(x+20*(timer+1)*cos(2*PI*i/8),y+20*(timer+1)*sin(2*PI*i/8));
      point(x+40*(timer+1)*cos(2*PI*(i+0.5)/8),y+40*(timer+1)*sin(2*PI*(i+0.5)/8));
      point(x+60*(timer+1)*cos(2*PI*i/8),y+60*(timer+1)*sin(2*PI*i/8));
    }
  }
  boolean isEmpty(){return false;}
  void attack(Airplane airplane){
    if(hp.isZero() && !bom)return;
    if(bomHit)return;
    if(attackTimer>0)return;
    if(!bom)crashSound();
    bom=true;
    hp.sub(999999);
    if(pow(x-airplane.x,2)+pow(y-airplane.y,2)<=100*100){
      airplane.hp.sub(15);
      bomHit=true;
    }
  }
}

class KnifePlane extends EnemyPlane{
  float knifeCoolDown=0;
  float knifeTimer=0;
  Enemy move(Game game){
    knifeTimer+=1./framerate;
    knifeCoolDown-=1./framerate;
    if(knifeCoolDown<0)knifeCoolDown=0;
    return super.move(game);
  }
  void draws(){
    super.draws();
    if(hp.isZero())return;
    strokeWeight(4);
    stroke(255);
    for(int i=0;i<10;i++){
      line(x+100*cos(2*i*PI/10+knifeTimer),y+100*sin(2*i*PI/10+knifeTimer),x+70*cos(2*i*PI/10+knifeTimer),y+70*sin(2*i*PI/10+knifeTimer));
      line(x+80*cos(2*i*PI/10+knifeTimer-0.1),y+80*sin(2*i*PI/10+knifeTimer-0.1),x+80*cos(2*i*PI/10+knifeTimer+0.1),y+80*sin(2*i*PI/10+knifeTimer+0.1));
    }
  }
  int attacked(int damage){
    return super.attacked(damage)*2;
  }
  void attack(Airplane airplane){
    super.attack(airplane);
    if(pow(airplane.x-x,2)+pow(airplane.y-y,2)<=100*100&&knifeCoolDown<=0){
      airplane.hp.sub(10);
      knifeCoolDown=1;
    }
  }
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
  if(int(key)>=128)return;
  if(int(key)<0)return;
  keyPress[int(key)]=true;
}

void keyReleased(){
  if(int(key)>=128)return;
  if(int(key)<0)return;
  keyPress[int(key)]=false;
}

float randoms[]=new float[100];
int randIndex=100;
float rand(){
  if(randIndex>=100){
    int rnd[]=new int[100];
    makeRnd(second()+10,minute()+10,199,100,rnd);
    for(int i=0;i<100;i++)randoms[i]=rnd[i]/199.;
    randIndex=0;
  }
  return randoms[randIndex++];
}

// 線形合同法で乱数を生成する関数、mは素数、a,bはm以下の整数、nは配列の要素数
void makeRnd(int a,int b,int m,int n,int[] return_array){
  return_array[0]=b; // x[0]=b
  for(int i=0;i<n-1;i++){
    return_array[i+1]=(a*return_array[i])%m; // 乱数を生成
  }
}
