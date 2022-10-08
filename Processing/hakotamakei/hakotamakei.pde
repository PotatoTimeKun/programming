final int windowSize[]={1500, 100};
final int framerate=30;
timer countTimer;
hakotama movingHakotama;

void settings() {
  size(windowSize[0], windowSize[1]);
}

void setup() {
  countTimer=new timer(framerate, 1);
  final int tableArray[]={0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  final booleanTable table=new booleanTable(tableArray, 25);
  movingHakotama=new hakotama(table);
}

void draw() {
  frameRate(framerate);
  movingHakotama.getTable().show();
  countTimer.count();
  if (countTimer.isNotCounted())return;
  movingHakotama=movingHakotama.move();
}

class timer {
  final int framerate;
  final float countSecond;
  int counting;
  timer(int newFramerate, float newCountSecond) {
    framerate=newFramerate;
    countSecond=newCountSecond;
    counting=0;
  }
  void count() { // カウントを進める
    counting++;
    if (counting>int(countSecond*framerate))counting=0;
  }
  boolean isCounted() { // カウントが1周したときにtrue
    if (counting==int(countSecond*framerate))return true;
    return false;
  }
  boolean isNotCounted() {
    return !isCounted();
  }
}

class hakotama {
  final private booleanTable table;
  hakotama(booleanTable tama) {
    table=tama;
  }
  hakotama move() { // 玉を動かす
    boolean movingTable[]=new boolean[table.getLength()];
    int havingTrue=0;
    for (int i=0; i<table.getLength(); i++) {
      if (table.at(i)) {
        havingTrue++;
        movingTable[i]=false;
        continue;
      }
      if (havingTrue<=0) {
        movingTable[i]=false;
        continue;
      }
      havingTrue--;
      movingTable[i]=true;
    }
    booleanTable movedTable=new booleanTable(movingTable, table.getLength());
    final hakotama movedHakotama=new hakotama(movedTable);
    return movedHakotama;
  }
  booleanTable getTable() {
    return table;
  }
}

class booleanTable {
  final private boolean table[];
  final private int len;
  booleanTable(boolean newTable[], int newLength) {
    table=newTable;
    len=newLength;
  }
  booleanTable(int newTable[], int newLength) {
    boolean booleanArray[]=new boolean[newLength];
    for (int i=0; i<newLength; i++) {
      if (newTable[i]==0)booleanArray[i]=false;
      else booleanArray[i]=true;
    }
    table=booleanArray;
    len=newLength;
  }
  int getLength() {
    return len;
  }
  boolean[] getValue() {
    return table;
  }
  boolean at(int i) {
    return table[i];
  }
  void show() { // 箱と玉としてテーブルを画面出力
    final int hakoLength=windowSize[0]/len;
    for (int i=0; i<len; i++) {
      rect(i*hakoLength, 0, (i+1)*hakoLength, hakoLength);
      if (!table[i])continue;
      final float tamaCenter[]={(i+0.5)*hakoLength, hakoLength*0.5};
      final float tamaSize=hakoLength-4;
      ellipse(tamaCenter[0], tamaCenter[1], tamaSize, tamaSize);
    }
  }
}
