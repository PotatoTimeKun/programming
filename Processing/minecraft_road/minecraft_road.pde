import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.io.File;
import processing.awt.PSurfaceAWT;
import processing.awt.PSurfaceAWT.SmoothCanvas;
import java.awt.event.KeyEvent;

int WINDOW_WIDTH=1200,WINDOW_HEIGHT=830; // 画面の縦・横の大きさ

ArrayList<String> field=new ArrayList<String>();
/*
  画面上に表示するblockの保存
  x座標,y座標,回転の角度(0~3),ファイル名(ディレクトリ名は含まない)
*/

ArrayList<String> field_line=new ArrayList<String>();
/*
  画面上に表示するlineの保存
  x座標,y座標,回転の角度(0~3),ファイル名(ディレクトリ名は含まない)
*/

ArrayList<String> pfield=new ArrayList<String>();
ArrayList<String> pfield_line=new ArrayList<String>();
// 変更する1つ前のfield,field_line

ArrayList<PImage> img=new ArrayList<PImage>();
// 画像のキャッシュ

ArrayList<String> img_name=new ArrayList<String>();
// キャッシュされた画像のファイル名(ディレクトリ名は含まない)

ArrayList<String> file_name=new ArrayList<String>();
// blockとlineのファイル名一覧(先頭がblock)

int block_count;
// blockの種類の総数

void settings(){
  size(WINDOW_WIDTH,WINDOW_HEIGHT);
}

int page_index=0;
// 画面下に表示する一覧の現在のページ

int page_size=(WINDOW_WIDTH-100)/100;
// 画面下に表示する一覧の1ページ内の画像の最大数

int page_max;
// 画面下に表示する一覧のページの数

ArrayList<String> recent_file=new ArrayList<String>();
// 最近開いたファイル
ArrayList<String> recent_file_name=new ArrayList<String>();
// 最近開いたファイルの名前部分のみ(表示用)

JFrame jframe;
SmoothCanvas canvas;
void setup(){
  canvas = (SmoothCanvas) surface.getNative();
  jframe = (JFrame) canvas.getFrame();  
  for (WindowListener evt : jframe.getWindowListeners()) {
    jframe.removeWindowListener(evt);
  }
  jframe.addWindowListener(new WindowClosing());
  // あとで使うための処理(よく知らない)
  
  PFont font = createFont("hoge",64,true); // 日本語対応のためのフォント(実際に存在する必要はない)
  textFont(font); // これで多分OSのデフォルトのフォントが設定される
  
  imageMode(CENTER);
  
  File[] imageFiles=new File(dataPath("block")).listFiles();
  for(File file: imageFiles){
    file_name.add(file.getName());
  }
  block_count=imageFiles.length;
  // blockのファイル名を全て読み込む
  
  imageFiles=new File(dataPath("line")).listFiles();
  for(File file: imageFiles){
    file_name.add(file.getName());
  }
  // lineのファイル名を全て読み込む
  
  page_max=(file_name.size()+page_size-1)/page_size;
  show(0,0);// 最初の画面を表示しておく
  
  surface.setTitle("無題");
  surface.setIcon(searchImg("icon.png","icon"));
  // タイトルとアイコンを設定
  
  
  String[] recent=loadStrings(dataPath("setting")+"\\recent.txt");
  if(recent!=null){
    for(int i=0;i<recent.length/2;i++){
      recent_file.add(recent[i*2]);
      recent_file_name.add(recent[i*2+1]);
    }
  }
  // 最近開いたファイルを読み込み
}
void add_recent(String name,String directory){ // 最近開いたファイルに追加、add_recent(ファイル名,ディレクトリの絶対パス)
  for(int i=0;i<recent_file.size();i++){ // 既に追加されていた場合、末尾に移動
    if((recent_file.get(i)+recent_file_name.get(i)).equals(directory+name)){
      recent_file.remove(i);
      recent_file.add(directory);
      recent_file_name.remove(i);
      recent_file_name.add(name);
      return;
    }
  }
  recent_file.add(directory);
  recent_file_name.add(name);
  if(recent_file.size()>4){ // 4つまで保存
    recent_file.remove(0);
    recent_file_name.remove(0);
  }
}

boolean menu_hold[]={false,false,false,false,false,false},menu_click[]={false,false,false,false,false,false};
// 上部の各ボタンをホバーしているか / クリックしたか

String button_list[]={"menu.png","rotate.png","trush.png","select.png","back.png","move.png"};
// 上部の各ボタンの画像のファイル名

String button_name[]={"メニュー","回転","マス削除","単体選択","元に戻す","移動"};
// 上部の各ボタンに表示する文字

String menu_list[]={"マスのサイズ2倍","マスのサイズ半分","ファイル読み込み","ファイル書き込み","新規作成","最近開いたファイル"};
// 上部の1つ目のボタン(メニュー)を開いたときの各項目

boolean menu_do[]={false,false,false,false,false,false};
// メニューの各項目を実行するかどうか(クリックしたかどうか)

boolean menu_list_hold[]={false,false,false,false,false,false};
// メニューの各項目をホバーしているか

boolean recent_hold[]={false,false,false,false};
// 最近開いたファイルの各項目をホバーしているか

float grid_size=50;
// 1マスの大きさ

int main_width=WINDOW_WIDTH,main_height=WINDOW_HEIGHT-30-100;
// マス目の表示画面の大きさ

int X=0,Y=0;
// 左上の最初のマス目の保存データ(fieldやfield_line)上の座標

int selected_mode=0;
/*
  選択したモード
  0:何も起こらない
  10:blockの配置
  11:lineの配置
  2:削除
  3:移動
*/

int selected_block=0;
// 選択中のblockまたはline(file_nameのインデックスと対応) 

int selecting_mode=0;
/*
  配置または削除のモード
  0:単体選択
  1:範囲選択
*/

int block_rotation=0;
// 新しく置くblockまたはlineの向き(0～3)

int select_start[]={0,0};
// 範囲選択時の始点(保存データ上の座標)

int select_end[]={0,0};
// 範囲選択時の終点(保存データ上の座標)

boolean set_start=false;
// 範囲選択時に始点を設定したかどうか

boolean set_end=false;
// 範囲選択時に終点を設定したかどうか

String opened_file_name="";
// 現在開いているファイルの名前(絶対パス)

boolean file_opened=false;
// ファイルを開いたかどうか(新規ではないかどうか)

void menu_button_0(){ // メニューの1つ目の項目を選択したときに実行
  grid_size*=2;
}
void menu_button_1(){ // メニューの2つ目の項目を選択したときに実行
  grid_size/=2;
}
void menu_button_2(){ // メニューの3つ目の項目を選択したときに実行
  FileDialog dialog=new FileDialog((Frame)null,"ファイル入力",FileDialog.LOAD);
  dialog.setVisible(true);
  // ファイル選択ダイアログの表示
  
  String filename=dialog.getFile();
  String directory=dialog.getDirectory();
  // ファイル名とディレクトリ名を取得
  
  if(filename==null)
    return;
  // キャンセルしたら実行しない
  
  field.clear();
  field_line.clear();
  String[] lines=loadStrings(directory+filename);
  boolean isLine=false;
  for(int i=0;i<lines.length;i++){
    if(lines[i].equals("line")){
      isLine=true;
      continue;
    }
    
    String[] check=match(lines[i],"(.*),(.*),(.*),(.*)");
    if(check==null)continue;
    try{
      for(int j=0;j<3;j++)
        Integer.parseInt(check[j]);
    }catch(Exception e){}
    // バリデーション
    
    if(isLine)field_line.add(lines[i]);
    else field.add(lines[i]);
  }
  // ファイルの読み込み
  
  X=0;
  Y=0;
  
  file_opened=true;
  opened_file_name=directory+filename;
  surface.setTitle(opened_file_name);
  // ファイル名をウィンドウタイトルに表示
  
  add_recent(filename,directory);
}
void menu_button_3(){ // メニューの4つ目の項目を選択したときに実行
  FileDialog dialog=new FileDialog((Frame)null,"ファイル出力",FileDialog.SAVE);
  dialog.setVisible(true);
  // ファイル選択ダイアログの表示
  
  String filename=dialog.getFile();
  String directory=dialog.getDirectory();
  // ファイル名とディレクトリ名を取得
  
  if(filename==null)
    return;
  // キャンセルしたら実行しない
  
  if(match(filename,"\\.txt$")==null)
    filename+=".txt";
  // 拡張子がないとき追加
  
  int field_size=field.size();
  int field_line_size=field_line.size();
  String[] array=new String[field_size+field_line_size+1];
  for(int i=0;i<field_size;i++)array[i]=field.get(i);
  array[field_size]="line";
  for(int i=0;i<field_line_size;i++)array[field_size+i+1]=field_line.get(i);
  saveStrings(directory+filename,array);
  // ファイルに書き込み
  
  file_opened=true;
  opened_file_name=directory+filename;
  surface.setTitle(opened_file_name);
  // ファイル名をウィンドウタイトルに表示
  
  add_recent(filename,directory);
}
void menu_button_4(){ // メニューの5つ目の項目を選択したときに実行
  JPanel panel=new JPanel();
  BoxLayout layout=new BoxLayout(panel,BoxLayout.Y_AXIS);
  panel.setLayout(layout);
  panel.add(new JLabel("保存した?"));
  int responce=JOptionPane.showConfirmDialog(null,panel,"確認",JOptionPane.YES_NO_OPTION,JOptionPane.INFORMATION_MESSAGE);
  // 確認ダイアログの表示
  
  if(responce==0){ // YESのとき
    field.clear();
    field_line.clear();
    X=0;
    Y=0;
    file_opened=false;
    surface.setTitle("新規");
    // データの初期化
  }
}
void menu_button_5(){ // メニューの6つ目の項目でファイルを選択したときに実行
  JPanel panel=new JPanel();
  BoxLayout layout=new BoxLayout(panel,BoxLayout.Y_AXIS);
  panel.setLayout(layout);
  panel.add(new JLabel("保存した?"));
  int responce=JOptionPane.showConfirmDialog(null,panel,"確認",JOptionPane.YES_NO_OPTION,JOptionPane.INFORMATION_MESSAGE);
  // 確認ダイアログの表示
  
  if(responce==0){ // YESのとき
    int index=0;
    for(int i=0;i<recent_file.size();i++){
      if(recent_hold[i])index=i;
    }
    String filepath=recent_file.get(index);
    String filename=recent_file_name.get(index);
    field.clear();
    field_line.clear();
    String[] lines=loadStrings(filepath+filename);
    if(lines==null){
      JPanel message_panel=new JPanel();
      message_panel.add(new JLabel("ファイル入出力エラー"));
      JOptionPane.showMessageDialog(null,message_panel);
      return;
    }
    boolean isLine=false;
    for(int i=0;i<lines.length;i++){
      if(lines[i].equals("line")){
        isLine=true;
        continue;
      }
      
      String[] check=match(lines[i],"(.*),(.*),(.*),(.*)");
      if(check==null)continue;
      try{
        for(int j=0;j<3;j++)
          Integer.parseInt(check[j]);
      }catch(Exception e){}
      // バリデーション
      
      if(isLine)field_line.add(lines[i]);
      else field.add(lines[i]);
    }
    // ファイルの読み込み
    
    X=0;
    Y=0;
    
    file_opened=true;
    opened_file_name=filepath+filename;
    surface.setTitle(opened_file_name);
    // ファイル名をウィンドウタイトルに表示
    
    add_recent(filename,filepath);
  }
}
void delete_at(int x,int y){ // 指定した座標(保存データ上の座標)のblockまたはlineを削除
  for(int i=0;i<field_line.size();i++){
    String data=field_line.get(i);
    String[] divide=match(data,"(.*),(.*),(.*),(.*)");
    int dataX=Integer.parseInt(divide[1]);
    int dataY=Integer.parseInt(divide[2]);
    if(dataX==x && dataY==y){
      field_line.remove(i);
      return;
    }
  }
  // lineを先に削除、削除が終わり次第終了
  
  for(int i=0;i<field.size();i++){
    String data=field.get(i);
    String[] divide=match(data,"(.*),(.*),(.*),(.*)");
    int dataX=Integer.parseInt(divide[1]);
    int dataY=Integer.parseInt(divide[2]);
    if(dataX==x && dataY==y){
      field.remove(i);
      return;
    }
  }
  // blockを削除
}
void add_block(int x,int y){ // 指定した座標(保存データ上の座標)にblockを配置
  for(int i=0;i<field.size();i++){
    String data=field.get(i);
    String[] divide=match(data,"(.*),(.*),(.*),(.*)");
    int dataX=Integer.parseInt(divide[1]);
    int dataY=Integer.parseInt(divide[2]);
    if(dataX==x && dataY==y){
      field.set(i,divide[1]+","+divide[2]+","+block_rotation+","+file_name.get(selected_block));
      return;
    }
  }
  // 既にその座標にblockがある場合、置き換えて終了
  
  field.add(x+","+y+","+block_rotation+","+file_name.get(selected_block));
  // 新規追加
}
void add_line(int x,int y){ // 指定した座標(保存データ上の座標)にlineを配置
  for(int i=0;i<field_line.size();i++){
    String data=field_line.get(i);
    String[] divide=match(data,"(.*),(.*),(.*),(.*)");
    int dataX=Integer.parseInt(divide[1]);
    int dataY=Integer.parseInt(divide[2]);
    if(dataX==x && dataY==y){
      field_line.set(i,divide[1]+","+divide[2]+","+block_rotation+","+file_name.get(selected_block));
      return;
    }
  }
  // 既にその座標にlineがある場合、置き換えて終了
  
  field_line.add(x+","+y+","+block_rotation+","+file_name.get(selected_block));
  // 新規追加
}
void back(){ // 元に戻す
  field.clear();
  field_line.clear();
  for(int i=0;i<pfield.size();i++)field.add(pfield.get(i));
  for(int i=0;i<pfield_line.size();i++)field_line.add(pfield_line.get(i));
  // データを削除して、前のデータを読み込む
  
  if(file_opened)
    surface.setTitle("*"+opened_file_name);
  else
    surface.setTitle("*"+"新規");
  // ウィンドウタイトルにファイル名を表示(*で変更したことを示す)
}
void move(int from_x,int from_y,int to_x,int to_y){ // 配置された座標へblockとlineを移動
  int rotation=0;
  String name=null;
  
  for(int i=0;i<field.size();i++){ // blockの移動
    String data=field.get(i);
    String[] divide=match(data,"(.*),(.*),(.*),(.*)");
    int dataX=Integer.parseInt(divide[1]);
    int dataY=Integer.parseInt(divide[2]);
    if(dataX==from_x && dataY==from_y){
      rotation=Integer.parseInt(divide[3]);
      name=divide[4];
      field.remove(i);
      
      boolean put=false;
      for(int j=0;j<field.size();j++){
        String to_data=field.get(j);
        String[] to_divide=match(to_data,"(.*),(.*),(.*),(.*)");
        int to_dataX=Integer.parseInt(to_divide[1]);
        int to_dataY=Integer.parseInt(to_divide[2]);
        if(to_dataX==to_x && to_dataY==to_y){
          field.set(j,to_divide[1]+","+to_divide[2]+","+rotation+","+name);
          put=true;
          break;
        }
      }
      // 既にその座標にblockがある場合、置き換え
      
      if(!put)field.add(to_x+","+to_y+","+rotation+","+name);
      // 新規追加
    }
  }
  
  for(int i=0;i<field_line.size();i++){ // lineの移動
    String data=field_line.get(i);
    String[] divide=match(data,"(.*),(.*),(.*),(.*)");
    int dataX=Integer.parseInt(divide[1]);
    int dataY=Integer.parseInt(divide[2]);
    if(dataX==from_x && dataY==from_y){
      rotation=Integer.parseInt(divide[3]);
      name=divide[4];
      field.remove(i);
      
      boolean put=false;
      for(int j=0;j<field_line.size();j++){
        String to_data=field.get(j);
        String[] to_divide=match(to_data,"(.*),(.*),(.*),(.*)");
        int to_dataX=Integer.parseInt(to_divide[1]);
        int to_dataY=Integer.parseInt(to_divide[2]);
        if(to_dataX==to_x && to_dataY==to_y){
          field_line.set(j,to_dataX+","+to_dataY+","+rotation+","+name);
          put=true;
          break;
        }
      }
      // 既にその座標にblockがある場合、置き換え
      
      if(!put)field.add(to_x+","+to_y+","+rotation+","+name);
      // 新規追加
    }
  }
}
void draw(){
  if(menu_do[0]){ // メニューの各項目を実行
    menu_button_0();
    menu_click[0]=false;
    show(X,Y);
    menu_do[0]=false;
  }else if(menu_do[1]){
    menu_button_1();
    menu_click[0]=false;
    show(X,Y);
    menu_do[1]=false;
  }else if(menu_do[2]){
    menu_button_2();
    menu_click[0]=false;
    show(X,Y);
    menu_do[2]=false;
  }else if(menu_do[3]){
    menu_button_3();
    menu_click[0]=false;
    show(X,Y);
    menu_do[3]=false;
  }else if(menu_do[4]){
    menu_button_4();
    menu_click[0]=false;
    show(X,Y);
    menu_do[4]=false;
  }else if(menu_do[5]){
    menu_button_5();
    menu_click[0]=false;
    show(X,Y);
    menu_do[5]=false;
  }
  else if(menu_click[1]){ // 上部の各ボタンを実行
    menu_click[1]=false;
    block_rotation++;
    if(block_rotation>=4)block_rotation=0;
    show(X,Y);
  }
  else if(menu_click[2]){
    menu_click[2]=false;
    selected_mode=2;
    show(X,Y);
  }
  else if(menu_click[3]){
    menu_click[3]=false;
    selecting_mode++;
    if(selecting_mode>=2)selecting_mode=0;
    if(selecting_mode==0)button_name[3]="単体選択";
    else if(selecting_mode==1)button_name[3]="範囲選択";
    show(X,Y);
  }else if(menu_click[4]){
    menu_click[4]=false;
    back();
    show(X,Y);
  }else if(menu_click[5]){
    menu_click[5]=false;
    selected_mode=3;
    show(X,Y);
  }
  if(control && s){ // CTRL+sの実行
    if(file_opened){ // ファイルを開いているとき、上書き保存
      int field_size=field.size();
      int field_line_size=field_line.size();
      String[] array=new String[field_size+field_line_size+1];
      for(int i=0;i<field_size;i++)array[i]=field.get(i);
      array[field_size]="line";
      for(int i=0;i<field_line_size;i++)array[field_size+i+1]=field_line.get(i);
      saveStrings(opened_file_name,array);
      surface.setTitle(opened_file_name);
    }else{
      menu_button_3();
    }
    control=false;
    s=false;
  }
  if(control && z){ // CTRL+zの実行
    back();
    show(X,Y);
    control=false;
    z=false;
  }
}
PImage searchImg(String name,String directory){ // 画像の取得、./data/A/B.pngのときsearchImg("B.png","A")
  for(int i=0;i<img_name.size();i++){
    if(img_name.get(i).equals(name)){
      return img.get(i);
    }
  }
  // 既に読み込まれているとき、それを返す
  PImage new_img;
  try{
    new_img=loadImage(dataPath(directory)+"\\"+name);
    image(new_img,0,0,0,0);
    img.add(new_img);
    img_name.add(name);
  }catch(Exception e){
    new_img=searchImg("error.png","system");
  }
  return new_img;
  // 読み込んで返す
}
void show(int x,int y){ // 画面の更新
  pushMatrix();
  translate(0,30);
  // 上部30pxだけ座標をずらしていることに注意
  
  background(255);
  
  for(int i=0;i<field.size();i++){
    String data=field.get(i);
    String[] divide=match(data,"(.*),(.*),(.*),(.*)");
    int dataX=Integer.parseInt(divide[1]);
    int dataY=Integer.parseInt(divide[2]);
    int rotation=Integer.parseInt(divide[3]);
    if(dataX>=x && dataX<x+main_width/grid_size && dataY>=y && dataY<y+main_height/grid_size){
      pushMatrix();
      translate((dataX-x)*grid_size+grid_size/2,(dataY-y)*grid_size+grid_size/2);
      rotate(rotation*PI/2);
      image(searchImg(divide[4],"block"),0,0,grid_size,grid_size);
      popMatrix();
    }
  }
  // blockの表示
  
  for(int i=0;i<field_line.size();i++){
    String data=field_line.get(i);
    String[] divide=match(data,"(.*),(.*),(.*),(.*)");
    int dataX=Integer.parseInt(divide[1]);
    int dataY=Integer.parseInt(divide[2]);
    int rotation=Integer.parseInt(divide[3]);
    if(dataX>=x && dataX<x+main_width/grid_size && dataY>=y && dataY<y+main_height/grid_size){
      pushMatrix();
      translate((dataX-x)*grid_size+grid_size/2,(dataY-y)*grid_size+grid_size/2);
      rotate(rotation*PI/2);
      image(searchImg(divide[4],"line"),0,0,grid_size,grid_size);
      popMatrix();
    }
  }
  // lineの表示
  
  stroke(0);
  for(int i=0;i<=main_height/grid_size;i++){
    line(0,i*grid_size,main_width,i*grid_size);
  }
  for(int i=0;i<=main_width/grid_size;i++){
    line(i*grid_size,0,i*grid_size,main_height);
  }
  // マス目の表示
  
  noStroke();
  if(set_start && selecting_mode==1){ // 範囲選択時に、範囲を赤く表示
    fill(255,0,0,100);
    int end_x=int(mouseX/grid_size),end_y=int((mouseY-30)/grid_size);
    if(set_end){
      end_x=select_end[0]-X;
      end_y=select_end[1]-Y;
    }
    int start_x=select_start[0]-X,start_y=select_start[1]-Y;
    int tmp;
    if(start_x>end_x){
      tmp=start_x;
      start_x=end_x;
      end_x=tmp;
    }
    if(start_y>end_y){
      tmp=start_y;
      start_y=end_y;
      end_y=tmp;
    }
    rect(start_x*grid_size,start_y*grid_size,(end_x-start_x+1)*grid_size,(end_y-start_y+1)*grid_size);
  }
  
  fill(200,200,255);
  rect(0,-30,WINDOW_WIDTH,30);
  rect(0,WINDOW_HEIGHT-30-100,WINDOW_WIDTH,WINDOW_HEIGHT-30);
  
  for(int i=0;i<button_list.length;i++){
    if(menu_hold[i])
      fill(100,100,255);
    else
      fill(200,200,255);
    rect(200*i,-30,200,30);
    textSize(20);
    fill(0);
    textAlign(LEFT,TOP);
    image(searchImg(button_list[i],"button"),15+200*i,-15,30,30);
    text(button_name[i],30+200*i,-30);
  }
  // 上部のボタンを表示
  
  if(menu_click[0]){ // メニューの各項目を表示
    for(int i=0;i<menu_list.length;i++){
      if(menu_list_hold[i])
        fill(200);
      else
        fill(255);
      rect(0,30*i,200,30);
      fill(0);
      text(menu_list[i],0,30*i);
    }
  }
  
  if(menu_click[0] && menu_list_hold[5]){ // 最近開いたファイルの表示
    textSize(20);
    textAlign(LEFT,TOP);
    for(int i=0;i<recent_file.size();i++){
      if(recent_hold[i])
        fill(200);
      else
        fill(255);
      rect(200,30*(5+i),400,30);
      fill(0);
      text(recent_file_name.get(i),205,30*(5+i));
    }
  }
  
  stroke(0);
  fill(200,200,255);
  rect(WINDOW_WIDTH-150,WINDOW_HEIGHT-30-100-150,150,150);
  fill(255);
  triangle((WINDOW_WIDTH-150/2)-150/2+10,(WINDOW_HEIGHT-30-100-150/2),(WINDOW_WIDTH-150/2)-150/2+30,(WINDOW_HEIGHT-30-100-150/2)+10,(WINDOW_WIDTH-150/2)-150/2+30,(WINDOW_HEIGHT-30-100-150/2)-10);
  triangle((WINDOW_WIDTH-150/2)+150/2-10,(WINDOW_HEIGHT-30-100-150/2),(WINDOW_WIDTH-150/2)+150/2-30,(WINDOW_HEIGHT-30-100-150/2)+10,(WINDOW_WIDTH-150/2)+150/2-30,(WINDOW_HEIGHT-30-100-150/2)-10);
  triangle((WINDOW_WIDTH-150/2),(WINDOW_HEIGHT-30-100-150/2)-150/2+10,(WINDOW_WIDTH-150/2)+10,(WINDOW_HEIGHT-30-100-150/2)-150/2+30,(WINDOW_WIDTH-150/2)-10,(WINDOW_HEIGHT-30-100-150/2)-150/2+30);
  triangle((WINDOW_WIDTH-150/2),(WINDOW_HEIGHT-30-100-150/2)+150/2-10,(WINDOW_WIDTH-150/2)+10,(WINDOW_HEIGHT-30-100-150/2)+150/2-30,(WINDOW_WIDTH-150/2)-10,(WINDOW_HEIGHT-30-100-150/2)+150/2-30);
  // 移動ボタンの表示
  
  triangle(10,WINDOW_HEIGHT-30-50,30,WINDOW_HEIGHT-30-60,30,WINDOW_HEIGHT-30-40);
  triangle(WINDOW_WIDTH-10,WINDOW_HEIGHT-30-50,WINDOW_WIDTH-30,WINDOW_HEIGHT-30-60,WINDOW_WIDTH-30,WINDOW_HEIGHT-30-40);
  textSize(10);
  textAlign(CENTER,TOP);
  fill(0);
  for(int i=0;i<page_size;i++){
    if(i+page_size*page_index>=file_name.size()){
      break;
    }
    if(i+page_size*page_index<block_count){
      image(searchImg(file_name.get(i+page_size*page_index),"block"),100+100*i,WINDOW_HEIGHT-30-50,50,50);
    }else{
      image(searchImg(file_name.get(i+page_size*page_index),"line"),100+100*i,WINDOW_HEIGHT-30-50,50,50);
    }
    text(match(file_name.get(i+page_size*page_index),"(.*)\\..*")[1],100+100*i,WINDOW_HEIGHT-30-20);
  }
  // 下部の一覧の表示
  
  fill(200,200,255);
  rect(WINDOW_WIDTH-150,WINDOW_HEIGHT-30-100-300,150,150);
  textAlign(CENTER,TOP);
  textSize(20);
  fill(0);
  text("選択中",WINDOW_WIDTH-150/2,WINDOW_HEIGHT-30-100-300+10);
  pushMatrix();
  translate(WINDOW_WIDTH-150/2,WINDOW_HEIGHT-30-100-300+150/2);
  rotate(block_rotation*PI/2);
  if(selected_mode==10){
    image(searchImg(file_name.get(selected_block),"block"),0,0,50,50);
  }
  else if(selected_mode==11){
    image(searchImg(file_name.get(selected_block),"line"),0,0,50,50);
  }
  popMatrix();
  if(selected_mode==2){
    image(searchImg("trush.png","button"),WINDOW_WIDTH-150/2,WINDOW_HEIGHT-30-100-300+150/2,50,50);
  }else if(selected_mode==3){
    image(searchImg("move.png","button"),WINDOW_WIDTH-150/2,WINDOW_HEIGHT-30-100-300+150/2,50,50);
  }
  // 選択モード・ブロックの表示

  popMatrix();
}

class WindowClosing extends WindowAdapter {
  public void windowClosing(WindowEvent e) {// 終了ボタンを押したときにダイアログの表示
    JPanel panel=new JPanel();
    BoxLayout layout=new BoxLayout(panel,BoxLayout.Y_AXIS);
    panel.setLayout(layout);
    panel.add(new JLabel("本当に終了する?"));
    int ans = JOptionPane.showConfirmDialog(
      jframe, 
      panel,
      "終了確認",
      JOptionPane.YES_NO_OPTION,
      JOptionPane.INFORMATION_MESSAGE
      );
    if (ans == JOptionPane.YES_OPTION) {
      String[] array=new String[recent_file.size()*2];
      for(int i=0;i<recent_file.size();i++){
        array[2*i]=recent_file.get(i);
        array[2*i+1]=recent_file_name.get(i);
      }
      saveStrings(dataPath("setting")+"\\recent.txt",array);
      exit();
    } else {
      jframe.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
    }
  }
}

void mouseMoved(){
  for(int i=0;i<button_list.length;i++){
    if(mouseY>=0 && mouseY<=30 && mouseX>=200*i && mouseX<200*(i+1)){
      if(!menu_hold[i]){
        menu_hold[i]=true;
        show(X,Y);
      }
      menu_hold[i]=true;
    }else{
      if(menu_hold[i]){
        menu_hold[i]=false;
        show(X,Y);
      }
      menu_hold[i]=false;
    }
  }
  // 上部のボタンのホバーの判定
  
  if(menu_click[0]){
    for(int i=0;i<menu_list.length;i++){
      if(mouseY>=(i+1)*30 && mouseY<(i+2)*30 && mouseX>=0 && mouseX<200){
        if(!menu_list_hold[i]){
          menu_list_hold[i]=true;
          show(X,Y);
        }
      }else{
        if(menu_list_hold[i]){
          menu_list_hold[i]=false;
          if(i==5){
            menu_list_hold[i]=true;
            for(int j=0;j<recent_file.size();j++){ // 最近開いたファイルのホバーの判定
              if(mouseY>=(j+6)*30 && mouseY<(j+7)*30 && mouseX>=200 && mouseX<600){
                if(!recent_hold[j]){
                  recent_hold[j]=true;
                  show(X,Y);
                }
              }else{
                recent_hold[j]=false;
                show(X,Y);
              }
            }
            if(  !  (mouseY>=6*30 && mouseY<(6+recent_file.size())*30 && mouseX>=200 && mouseX<600) ){
              menu_list_hold[i]=false;
              show(X,Y);
            }
          }else
            show(X,Y);
        }
      }
    }
  }
  // メニューの各項目のホバーの判定
  
  if(set_start){
    if(int(mouseX/grid_size) != int(pmouseX/grid_size) || int((mouseY-30)/grid_size) != int((pmouseY-30)/grid_size))
      show(X,Y);
  }
  // 選択範囲の表示の更新
}
void mouseClicked(){
  if(set_start && !set_end && mouseButton==RIGHT){
    set_start=false;
    show(X,Y);
    return;
  }
  // 右クリックで範囲選択を中断
  
  boolean set_start_log=set_start;
  boolean set_end_log=set_end;
  set_start=false;
  // 一度範囲選択を解除(終点を決める以外の行動をしたとき解除したままになる)
  set_end=false;
  // 移動しなかったとき解除したまま
  
  if(menu_click[0]){
    for(int i=0;i<menu_list.length;i++){
      if(i==5)continue;
      if(mouseY>=(i+1)*30 && mouseY<(i+2)*30 && mouseX>=0 && mouseX<200){
        menu_do[i]=true;
        show(X,Y);
        return;
      }
    }
  }
  // メニューの各項目のクリック判定
  
  if(mouseY>=6*30 && mouseY<(6+recent_file.size())*30 && mouseX>=200 && mouseX<600){
    menu_do[5]=true;
  }
  // 最近開いたファイルのクリック判定
  
  if(menu_click[0]){
    menu_click[0]=false;
    show(X,Y);
    return;
  }
  // メニューを開きながら別のところをクリックしたとき、メニューを閉じる
  
  for(int i=0;i<button_list.length;i++){
    if(mouseY>=0 && mouseY<30 && mouseX>=200*i && mouseX<200*(i+1)){
      menu_click[i]=true;
      show(X,Y);
      return;
    }
  }
  // 上部のボタンのクリック判定
  
  if(mouseX>=WINDOW_WIDTH-150 && mouseX<WINDOW_WIDTH-150+50 && mouseY>=WINDOW_HEIGHT-100-150+50 && mouseY<WINDOW_HEIGHT-100-150+100){
    X--;
    show(X,Y);
    return;
  }
  if(mouseX>=WINDOW_WIDTH-50 && mouseX<WINDOW_WIDTH && mouseY>=WINDOW_HEIGHT-100-150+50 && mouseY<WINDOW_HEIGHT-100-150+100){
    X++;
    show(X,Y);
    return;
  }
  if(mouseX>=WINDOW_WIDTH-100 && mouseX<WINDOW_WIDTH-50 && mouseY>=WINDOW_HEIGHT-100-150 && mouseY<WINDOW_HEIGHT-100-100){
    Y--;
    show(X,Y);
    return;
  }
  if(mouseX>=WINDOW_WIDTH-100 && mouseX<WINDOW_WIDTH-50 && mouseY>=WINDOW_HEIGHT-100-50 && mouseY<WINDOW_HEIGHT-100){
    Y++;
    show(X,Y);
    return;
  }
  // 移動ボタンのクリック判定
  
  if(mouseX>=0 && mouseX<50 && mouseY>=WINDOW_HEIGHT-100 && mouseY<WINDOW_HEIGHT){
    page_index--;
    if(page_index<0)page_index=page_max-1;
    show(X,Y);
    return;
  }
  if(mouseX>=WINDOW_WIDTH-50 && mouseX<WINDOW_WIDTH && mouseY>=WINDOW_HEIGHT-100 && mouseY<WINDOW_HEIGHT){
    page_index++;
    if(page_index>=page_max)page_index=0;
    show(X,Y);
    return;
  }
  // 下部の一覧のページ変更ボタンのクリック判定
  
  for(int i=0;i<page_size;i++){
    if(mouseX>=50+100*i && mouseX<50+100*(i+1) && mouseY>=WINDOW_HEIGHT-100 && mouseY<WINDOW_HEIGHT){
      if(i+page_size*page_index>=file_name.size())return;
      if(i+page_size*page_index<block_count)selected_mode=10;
      else selected_mode=11;
      selected_block=i+page_size*page_index;
      show(X,Y);
      return;
    }
  }
  // 下部の一覧のクリック判定
  
  if(mouseX>=WINDOW_WIDTH-150 && mouseX<WINDOW_WIDTH && mouseY>=WINDOW_HEIGHT-100-300 && mouseY<WINDOW_HEIGHT-100){
    return;
  }
  // マス目部分のはみ出した部分(移動ボタンの余白や選択モード・ブロックの表示部分)を無効化
  
  set_start=set_start_log;
  set_end=set_end_log;
  if(mouseX>=0 && mouseX<main_width && mouseY>=30 && mouseY<main_width+30){ // マス目部分のクリック
    if(selecting_mode==1 && !set_start){ // 範囲選択時、始点が設定されてないなら設定
      select_start[0]=X+int(mouseX/grid_size);
      select_start[1]=Y+int((mouseY-30)/grid_size);
      set_start=true;
      show(X,Y);
      return;
    }
    if(selected_mode==10){ // blockの配置
      pfield.clear();
      pfield_line.clear();
      for(int i=0;i<field.size();i++)pfield.add(field.get(i));
      for(int i=0;i<field_line.size();i++)pfield_line.add(field_line.get(i));
      // 今の保存データを前の状態として保存
      
      if(selecting_mode==1){ // 範囲選択時
        int end_x=X+int(mouseX/grid_size),end_y=Y+int((mouseY-30)/grid_size);
        int tmp;
        if(select_start[0]>end_x){
          tmp=select_start[0];
          select_start[0]=end_x;
          end_x=tmp;
        }
        if(select_start[1]>end_y){
          tmp=select_start[1];
          select_start[1]=end_y;
          end_y=tmp;
        }
        for(int x=select_start[0];x<=end_x;x++){
          for(int y=select_start[1];y<=end_y;y++){
            add_block(x,y);
          }
        }
        set_start=false;
      }
      else
        add_block(X+int(mouseX/grid_size),Y+int((mouseY-30)/grid_size));
      
      show(X,Y);
      
      if(file_opened)
        surface.setTitle("*"+opened_file_name);
      else
        surface.setTitle("*"+"新規");
      // ウィンドウタイトルにファイル名を表示(*で変更したことを示す)
      
      return;
    }
    else if(selected_mode==11){ // lineの配置
      pfield.clear();
      pfield_line.clear();
      for(int i=0;i<field.size();i++)pfield.add(field.get(i));
      for(int i=0;i<field_line.size();i++)pfield_line.add(field_line.get(i));
      // 今の保存データを前の状態として保存
      
      if(selecting_mode==1){ // 範囲選択時
        int end_x=X+int(mouseX/grid_size),end_y=Y+int((mouseY-30)/grid_size);
        int tmp;
        if(select_start[0]>end_x){
          tmp=select_start[0];
          select_start[0]=end_x;
          end_x=tmp;
        }
        if(select_start[1]>end_y){
          tmp=select_start[1];
          select_start[1]=end_y;
          end_y=tmp;
        }
        for(int x=select_start[0];x<=end_x;x++){
          for(int y=select_start[1];y<=end_y;y++){
            add_line(x,y);
          }
        }
        set_start=false;
      }
      else
        add_line(X+int(mouseX/grid_size),Y+int((mouseY-30)/grid_size));
      
     
      
      show(X,Y);
      
      if(file_opened)
        surface.setTitle("*"+opened_file_name);
      else
        surface.setTitle("*"+"新規");
      // ウィンドウタイトルにファイル名を表示(*で変更したことを示す)
      
      return;
    }
    else if(selected_mode==2){ // ブロックの削除
      pfield.clear();
      pfield_line.clear();
      for(int i=0;i<field.size();i++)pfield.add(field.get(i));
      for(int i=0;i<field_line.size();i++)pfield_line.add(field_line.get(i));
      // 今の保存データを前の状態として保存
      
      if(selecting_mode==1){ // 範囲選択時
        int end_x=X+int(mouseX/grid_size),end_y=Y+int((mouseY-30)/grid_size);
        int tmp;
        if(select_start[0]>end_x){
          tmp=select_start[0];
          select_start[0]=end_x;
          end_x=tmp;
        }
        if(select_start[1]>end_y){
          tmp=select_start[1];
          select_start[1]=end_y;
          end_y=tmp;
        }
        for(int x=select_start[0];x<=end_x;x++){
          for(int y=select_start[1];y<=end_y;y++){
            delete_at(x,y);
          }
        }
        set_start=false;
      }
      else
        delete_at(X+int(mouseX/grid_size),Y+int((mouseY-30)/grid_size));
      
      show(X,Y);
      
      if(file_opened)
        surface.setTitle("*"+opened_file_name);
      else
        surface.setTitle("*"+"新規");
      // ウィンドウタイトルにファイル名を表示(*で変更したことを示す)
      
      return;
    }
    else if(selected_mode==3){
      pfield.clear();
      pfield_line.clear();
      for(int i=0;i<field.size();i++)pfield.add(field.get(i));
      for(int i=0;i<field_line.size();i++)pfield_line.add(field_line.get(i));
      // 今の保存データを前の状態として保存
      
      if(!set_start && selecting_mode==0){ // 単体選択でも始点を設定
        select_start[0]=X+int(mouseX/grid_size);
        select_start[1]=Y+int((mouseY-30)/grid_size);
        set_start=true;
        return;
      }
      
      if(!set_end && selecting_mode==1){  // 範囲選択のとき終点を設定
        select_end[0]=X+int(mouseX/grid_size);
        select_end[1]=Y+int((mouseY-30)/grid_size);
        set_end=true;
        return;
      }
      
      if(selecting_mode==1){ // 範囲選択時
        int to_x=X+int(mouseX/grid_size),to_y=Y+int((mouseY-30)/grid_size);
        int tmp;
        if(select_start[0]>select_end[0]){
          tmp=select_start[0];
          select_start[0]=select_end[0];
          select_end[0]=tmp;
        }
        if(select_start[1]>select_end[1]){
          tmp=select_start[1];
          select_start[1]=select_end[1];
          select_end[1]=tmp;
        }
        for(int i=0;i<=select_end[0]-select_start[0];i++){
          for(int j=0;j<=select_end[1]-select_start[1];j++){
            move(select_start[0]+i,select_start[1]+j,to_x+i,to_y+j);
          }
        }
        set_start=false;
        set_end=false;
      }
      else{
        move(select_start[0],select_start[1],X+int(mouseX/grid_size),Y+int((mouseY-30)/grid_size));
        set_start=false;
      }
      
      show(X,Y);
      
      if(file_opened)
        surface.setTitle("*"+opened_file_name);
      else
        surface.setTitle("*"+"新規");
      // ウィンドウタイトルにファイル名を表示(*で変更したことを示す)
      
      return;
    }
  }
}
boolean control=false,s=false,z=false;//CTRL,s,zを押したかどうか
void keyPressed(){
  if(keyCode==KeyEvent.VK_CONTROL)
    control=true;
  if(keyCode==KeyEvent.VK_S)
    s=true;
  if(keyCode==KeyEvent.VK_Z)
    z=true;
}
void keyReleased(){
  if(keyCode==KeyEvent.VK_CONTROL)
    control=false;
  if(keyCode==KeyEvent.VK_S)
    s=false;
  if(keyCode==KeyEvent.VK_Z)
    z=false;
}
