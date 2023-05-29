僕が書いたプログラムを公開してます。  

プログラムの説明以外の事項は[WiKi](https://github.com/PotatoTimeKun/programming/wiki)を確認してください。  

各プログラムのバージョン別の説明等はPotatoTimeKun/programmingレポジトリのWikiに書いてあります。  

ここでは最新バージョンの説明を書きます。  
Flutterで作ったwebページはflutter_webレポジトリにあります。  
(ビルド前のプロジェクト自体はこのレポジトリにあります。)  
  

# C

## heron.c
**(関数化したものがnew_math.hに入っています。)**  
ヘロンの公式によって三角形の面積を求めるプログラムです。  
ヘロンの公式は、面積をSとしてABCで次の式のようになります。  
S=(s(s-a)(s-b)(s-c))  
ただしs=(a+b+c)/2とする  
doxygen追加済み


## tousasuretu.c
**(関数化したものがnew_math.hに入っています。)**  
標準入出力で等差数列を扱います。  
また、値を求める処理は下のような関数として宣言しています。   
* int sum_tousa(int 初項,int 公差,int 項数) :総和を返します。  
* int tousa_kou(int 初項,int 公差,int n) :第n項を求めます。  

doxygen追加済み


## touhisuretu.c
**(関数化したものがnew_math.hに入っています。)**  
標準入出力で等比数列を扱います。  
また、値を求める処理は下のような関数として宣言しています。   
* int sum_touhi(int 初項,int 公比,int 項数) :総和を返します。  
* int touhi_kou(int 初項,int 公比,int n) :第n項を求めます。  

doxygen追加済み


## new_math.h
以下に示す数学関係の関数が入っています。  
* double heron(double a,double b,double c)  
:ヘロンの公式より面積を返します。  
* long long factorial(int n)  
:nの階乗を返します。  
* long long combination(int n,int r)  
:nCrを返します。  
* long long permutation(int n,int r)  
:nPrを返します。  
* double GP_sum(double a1,double r,int n)  
:a1を初項、rを公比とする等比数列の第n項までの総和を返します。  
* double GP_n(double a1,double r,int n)  
:等比数列の第n項を返します。  
* double AP_sum(double a1,double d,int n)  
:等差数列の総和を返します。(**dは公差**)  
* double AP_n(double a1,double d,int n)  
:等差数列の第n項を返します。  
* MATH_PI:円周率(3.141592653589793)  
* MATH_E:ネイピア数(2.718281828459045)  
* double circle(doubler)  
:円周を返します。(rは半径)  
* double circle_s(double r)  
:円の面積を返します。  
* double sphere(double r)  
:球の体積を返します。  
* double sphere(double r)  
:球の表面積を返します。  
* double dintance(double x1,double y1,double x2,double y2)  
:(x1,y1)と(x2,y2)の間の直線距離を返します。  
* void divide_point(double x1,double y1,double x2,double y2,double m,double n,double \*return_array)  
:(x1,y1)と(x2,y2)を結ぶ線分のm:nの内分点をreturn_arrayに返します。(return_arrayにおいてインデックス0はx,1はyです)  
* void tri_cent(double x1,double y1,double x2,double y2,double x3,double y3,double \*return_array)  
:三角形の重心をreturn_arrayに返します。  
* void focus(double a,double b,double \*return_array)  
:楕円(x^2/a^2 + y^2/b^2 = 1)の焦点をreturn_arrayに返します。(return_arrayにおいてインデックス0:x1, 1:y1, 2:x2, 3:y2) 
* void hyperbola_focus(double a,double b,int n,double \*return_array)  
:双曲線(x^2/a^2 + y^2/b^2 = n(n=1||-1))の焦点をreturn_arrayに返します。  
* double cos_theorem(double b,double c,double A)  
三角形の2辺とその間の角から、余剰定理により残りの1辺を求めます。  
* double sin_theorem(double A,double B,double a)  
三角形ABC(角A,B,Cに対する位置の辺をa,b,cとする)のaとA,Bから、正弦定理によりbを求めます。  
* double rad(double arc)  
MATH_PIを使って60分法の角度をラジアンに変換します。  
* double arc(double rad)  
MATH_PIを使ってラジアンを60分法に変換します。  
* double tri_S(double b,double c,double A)  
三角形の2辺とその間の角から三角形の面積を求めます。  

doxygen追加済み  


## Cipher.h
暗号を扱う関数が入っています。  
全ての関数の引数にある**modeという引数は暗号化を行うか復号化を行うかを決めるための引数で、'm'で暗号化，'r'で復号化となります。**  
以下の関数が入っています。  
* void ceaser(char mode, char \*sentence, int sen_size, int shift)  
シーザー暗号を扱います。modeにモード、sentenceに平文または暗号文(アドレス渡しなので渡した配列がそのまま変更されます)、sen_sizeにsentenceの要素数、shiftにシフトする数を渡してください。  
* void vegenere(char mode,char \*sentence,int sen_size,char key,int key_size)  
ヴィジュネル暗号を扱います。modeにモード、sentenceに平文または暗号文、sen_sizeにsentenceの要素数、keyに鍵、key_sizeに鍵の文字数(char配列keyの要素数ではありません。例えば要素数xで最後まで文字が入っている場合、基本的に最後の要素はヌル文字となるのでx-1を渡すことになります)を渡してください。  
* void substitution(char mode,char \*sentence,int sen_size,char \*key)  
単一換字式暗号を扱います。modeにモード、sentenceに平文または暗号文、sen_sizeにsentenceの要素数、keyに鍵(a-zに対応した変換後の文字を順に並べた文字列)を渡してください。  
* void polybius_square(char mode,char \*sentence,int sen_size,char \*return_array)  
:ポリュビオスの暗号表(5\*5)を扱います。  
5\*5の方式ではjとiの暗号が同じ結果になります。そのため、復号結果ではiはiのままjをiとします。
* void scytale(char mode,char\* sentence,int sen_size,char\* return_array)
スキュタレー暗号を扱います。  
5列に分けて暗号化復号化を行います。  
return_arrayは少し余裕をもって宣言しておいたほうがいいです。  
言語の仕様上変数の値を配列の要素数の宣言に使用できなかったので、500個(499文字)までに対応させました。  
マクロSCYTALE_LENGTHを書き換えることによって最大文字数を変更できます。  
SCYTALE_LENGTHは5の倍数にしてください。

doxygen追加済み


## sort.h
色々な整列アルゴリズムが入っています。  
**引数は(int型の整列対象配列,配列の要素数)です。**  
アドレス渡しのため渡した配列にそのまま変更を行います。  
以下の関数が使えます。
* void bubble(引数リスト):交換法  
* void select(引数リスト):選択法  
* void insert(引数リスト):挿入法  
* void shell(引数リスト):シェルソート  
* void quick(引数リスト):クイックソート  
* void marge(引数リスト):マージソート  

doxygen追加済み


## physics.h
物理関係の公式を使った関数が入っています。  
今の時点では高校物理の力学が中心です。  
各関数の引数等の細かい説明はdoxygenを見てください。  
定数一覧  
* const double \_g\_=9.80665
標準重力加速度  

関数一覧  
  
等速直線運動  
* double uniform_linear_x(double v,double t)
* double uniform_linear_v(double x,double t)
* double uniform_linear_t(double x,double v)

等加速度直線運動
* double uniform_acceleration_linear_x(double v0,double t,double a)
* double uniform_acceleration_linear_x_2(double v0,double v,double a)
* double uniform_acceleration_linear_v(double v0,double t,double a)
* double uniform_acceleration_linear_v_2(double v0,double x,double a)
* double uniform_acceleration_linear_a(double v0,double v,double x)
* double uniform_acceleration_linear_a_2(double v0,double v,double t)
* double uniform_acceleration_linear_a_3(double v0,double t,double x)

自由落下運動
* double free_fall_v(double t,double g=\_g\_)
* double free_fall_v_2(double y,double g=\_g\_)
* double free_fall_y(double t,double g=\_g\_)
* double free_fall_y_2(double v,double g=\_g\_)

doxygen追加済み


## rnd.h
疑似乱数を生成する関数が入っています。  
以下の関数があります。  
* void LCGs(int a,int b,int m,int n,int *return_array)
合同法乱数を計算します。
* void BBS(int p,int q,int a,int n,int *return_array)
B.B.S.で疑似乱数を生成します。


## my_list.h
構造体を使ったリストが入っています。  
対応しているデータ型は  
int,long long,float,double,char  
で、各データ型毎にリストが定義されています。  
下記の\[データ型\]を各データ型を先頭を大文字にして置き換えてください。(ex: int => Int)  
ただし、long longはLongとします。  
* \[データ型\]List *mk\[データ型\]List(インデックス0の要素の値)  
新しいリストを作ります。  
一応使ったらプログラム終了時等でdel\[データ型\]関数でメモリを解放させる方がいいかもしれないです。  
* void add\[データ型\](リスト, データ)  
末尾に要素を追加します。  
* void addAt\[データ型\](リスト, 値, インデックス)  
指定したインデックスに要素を追加します。  
指定したインデックス以降の要素はインデックスが1つずれます。  
* \[データ型\] at\[データ型\](リスト, インデックス)  
指定したインデックスの値を取り出します。  
関数の実行による要素の変更、削除等はないです。  
存在しないインデックスを指定した場合、データ型で返り値が変化します。  
* \[データ型\] delAt\[データ型\](リスト, インデックス)  
指定したインデックスの値を削除し、その値を返します。  
存在しないインデックスを指定した場合、データ型で返り値が変化します。  
* void del\[データ型\](リスト)  
全ての要素をメモリから解放します。  
(つまり指定したリストを削除します。)  

存在しないインデックスを指定した際の返り値  
* Int  
-2147483648  
* Long  
-9223372036854775807  
* Float  
-3.402823e+38  
* Double  
-1.797693e+308  
* Char  
0

以下の関数を追加しました。  
* void set[データ型]([データ型]List \*lis, [データ型] val, int list_index)  
指定したインデックスの要素を更新します。  

## new_tabaicho.h
リストによって、多倍長整数と多倍長整数間の四則演算を扱う関数が入ったヘッダファイルです。  
多倍長整数はmkList関数によって返されたTabaicho*型の変数を使用します。  
四則演算を行う関数はそれぞれsum,sub,mul,diviです。  
inputLongInt関数はキーボード入力によって得た多倍長整数を返します。  
outputLongInt関数は引数の多倍長整数を表示します。  
cmp関数は引数の多倍長整数同士の大きさを比較します。  
多倍長整数のリストは、my_list.hのリストと同じように使えます。  
(ただし、データ型は「」(つまりなし)として扱います。例外としてat関数は既にあったのでnumAt関数とします。)  


## tabaicho.c
new_tabaicho.hを用いています。  
キーボード入力で得た2つの多倍長整数から、四則演算を行って結果を返します。  


## marubatu.c
コンピュータとマルバツゲームを行います。  
コンピュータはその盤面で最適なマスを選んでxを付けます。  
(マルバツゲームにおける必勝法は使用してないです。それは使ったもん勝ちなのでwww)  


## pote_jp.c
日本語(2バイト文字もしくはASCII文字)をポテ語にします。  


## pote_jp_rev.c
ポテ語を日本語に直します。  

## mystr.h
string型のようなものを扱うヘッダファイルです。  
以下の関数が入っています。  
* string* makeStr()  
空の文字列を作成します。  
* void scanStr(string* str)  
改行を受け取るまでキーボード入力を受け取ります。  
* void printStr(string* str)  
文字列を表示します。  
* string* sumStr(string* str1,string* str2)  
str1+str2  
* void addStr(string* added,string* adding)  
added+=adding  
* string* subStr(string* str,int start,int end)  
start\~end-1の文字列を取得します。  
start,endの値が不適切な場合(文字列長を超える、負数値、大小が逆)、空の文字列を返します。  
* string* charsToStr(char* str)  
charによる文字列をstring*に変換します。  
* char* strToChars(string* str)  
stringによる文字列をchar*に変換します。  
* char atStr(string* str,int index)  
指定したインデックスの文字を取得します。  
* char delAtStr(string* str,int index)  
指定したインデックスの文字を削除します。  
* void delStr(string* str,int start,int end)  
start~end-1の文字を削除します。  
* void scanStrPs(string* str)  
ホワイトスペースがでるまでキーボード入力を受け取ります。  
scanfでいう%sです。  
* int strToInt(string* str)  
string*をintに変換します。  
+,-,0~9以外の文字があっても動きますが、おすすめはしません。  
* long long strToLong(string* str)  
long longに変換します。  
* float strToFloat(string* str)  
floatに変換します。  
* double strToDouble(string* str)  
doubleに変換します。  
* int indexStr(string* str,string* searched)  
文字列中で一致する場所を探し、最初のインデックスを返します。  
* int indexStrC(string* str,char* searched)  
indexStr関数と動きはほぼ同じです。  
* void printfStr(char *arg,...)  
printf関数のように、%Sをstringの値に書き換えて表示します。  
* void addStrC(string* added,char adding)  
文字列の最後に文字を追加します。  
* void printfs(char *arg,...)  
printf関数の形式で文字列を表示します。  
string*型は%Sで変換可能です。  
* void addAtStr(string\* added,string\* adding,int index)  
指定したインデックスに文字列を挿入します。  
* void reverseStr(string\* str)  
渡された文字列を逆順にします。  
* void setStr(string\* str,char value,int index)  
指定したインデックスの値を書き換えます。  
* string\* copyStr(string* str)  
文字列の中身の値をコピーした文字列を作成します。  
コピー元とコピー先のアドレスは干渉しません。  
*int checkDyck(string* str,char left,char right)  
leftを[,rightを]と見たとき、strがダイク言語かどうかを返します  
(すなわち、括弧が対応しているかどうか)  

## testStr.c
mystr.hを試すためのプログラムです。  

## rectangle.h
三角関数と逆三角関数が入っています。基本的にテイラー展開して求めています。  
関数はmySin(x),myCos(x),myTan(x),arcsin(x),arccos(x),arctan(x)です。  

## tree.h
2分木をリスト的に扱う構造体Treeとその操作を行う関数が入っています  
関数:  
* Tree\* newTree()  
新しい2分木を作成します  
* Tree\* getLeftTree(Tree\* tree)  
treeの左部分木を取得します  
* Tree\* getRightTree(Tree\* tree)  
同様に右部分木  
* Tree\* getSubtree(Tree\* tree,int index)  
指定したインデックスを根とする部分木を返します  
ただし、アドレスはtreeの要素と共有されています  
Treeにおいてのインデックスとは先行順で最初を0としたときの順序とします  
* stackInit(int size)  
sizeを最大の要素数とするTree*型のスタックを初期化します  
使用後はfree(stack)を実行することを推奨します(無駄なメモリ開放のため)  
* push(Tree\* data)  
スタックにプッシュします  
* Tree\* pop()  
スタックからポップします  
* deleteTree(Tree\* tree)  
2分木全体をメモリから開放します  
* setNotFollowed(Tree\* tree)  
Tree構造体にはその節にフラグを立てることができるようになっています(followedメンバ  
そのフラグを全て0にします  
* int addLeftChild(Tree\* tree,int index,string\* child)  
指定したインデックスの節に左の子を追加します  
成功で1,失敗で0を返します  
* addRightChild  
同様に右  
* addChild  
同様(左優先)  
* int addLeftTree(Tree\* tree,int index,Tree\* addedTree)  
treeの指定したインデックスの節に左部分木addedTreeを追加します  
ただし、アドレスは共有  
* addRightTree  
同様に右  
* addTree  
同様(左優先)  
  
Tree構造体のメンバ:  
* string\* root  
その節の値(stringはmystr.hより)  
* int followed  
フラグ(例えば、後行順で2分木を走査するときにたどったことを示すことなどで使います)  
* Tree\* leftTree  
左部分木  
* Tree\* rightTree  
右部分木  

## culcurateByTree.c
計算式を2分木に変換し、ポーランド記法と逆ポーランド記法にして出力します  

## Cipher2.h
暗号を扱う関数が入っています。  
* void ChaCha20(char\* message,int size,char* key,char\* nonce)  
message:平文or暗号文,size:messageの文字数,key:鍵(32バイト),nonce:ナンス(12バイト)  
chacha20によって暗号化または復号化を行います  
鍵は秘密にしますが、ナンスは公開しても問題ありません(同じ鍵とナンスの組み合わせを繰り返し使わないことを推奨します)  

## binary32.c
IEEE754のbinary32の浮動小数点数形式のデータが保存された配列binから、そのデータが表す数を表示します(初期値は最大値)  

# Cpp

## keisan_int.cpp
文字列として式を入力すると、値を多倍長整数として演算して結果を返します。  
多倍長整数は、同じフォルダで公開してる**newint.hをインポートして使っています**。  
doxygen追加済み


## ~newint.h~

## newint.hpp
**多倍長整数**を扱うヘッダファイルです。  
newintというクラス名で、インスタンスに対するpublicメンバ関数は以下のようになります。  
* void set(string):値を設定  
* string str(bool=false):文字列として値を返します、引数にtrueを与えると絶対値を返します。  
* string bin():2進数で値を返します。  
* string oct():8進数で値を返します。  
* string hex():16進数で値を返します。  

以下はコンストラクタ  
* newint():メンバに**値を代入せず**にインスタンスを作成。  
* newint(newint):値をコピーしてインスタンスを作成。  
* newint(string):渡した値を表すインスタンスを作成。  

また、newintインスタンス間での四則演算及び剰余の演算が可能です。  
++,--,\[\](絶対値でのインデックスの数値)と比較演算子も使用可能です。  

doxygen追加済み  


## tabaicho.hpp
newint.hppの多倍長整数を利用し、キーボード入力で受け取った値で四則演算等を行います。  


## newfloat.h
多倍長整数の小数版です。これにも**newint.hをインポートして使用**しています。  
除算に関しては小数点以下20桁以下程の小さい値には対応できないことがあります。  
newint.hと同じメンバ関数、コンストラクタを持ちます。  
doxygen追加済み


## sort.hpp
色々な整列アルゴリズムが入っています。  
**引数は(int型の整列対象配列,配列の要素数)です。**  
アドレス渡しのため渡した配列にそのまま変更を行います。  
以下の関数が使えます。
* void bubble(引数リスト):交換法  
* void select(引数リスト):選択法  
* void insert(引数リスト):挿入法  
* void shell(引数リスト):シェルソート  
* void quick(引数リスト):クイックソート  
* void heap(引数リスト):ヒープソート  
* void marge(引数リスト):マージソート  
因みにほとんどの場合でクイックソートが一番速いです。  
doxygen追加済み

ヒープソートについて、ヒープを作成する関数を作成して実装しました。  
ヒープを作成する関数はtoHeap(引数リスト)で、配列をヒープとして扱い、最小値を根とします。  
配列上において、インデックスnについて左の子のインデックスを2n+1、右を2n+2とします。  
降順の整列と最大値を根とするヒープを追加しました。  
それぞれの関数名の末尾に\_downを付けたものが新しい関数です。  

## vij.hpp
**(ヴィジュネル暗号を扱う関数はChipher.hppにもあります。)**  
ヴィジュネル暗号を作成、解読する関数を扱います。  
以下の関数を持ちます。  
* string vij(string型の平文,string型の鍵)  
* string readvij(string型の暗号,string型の鍵)  

doxygen追加済み


## vijuneru_ango.cpp
標準入出力でヴィジュネル暗号の作成解読を行います。  
**vij.hppをインポートして使っています。**  
doxygen追加済み


## math_C_P.cpp
標準入出力で数学の順列組み合わせの計算を行います。  
doxygen追加済み


## babanuki.cpp
CPUとプレイヤーの1対1でのババ抜きです。  
(CUIのゲームです。)  
doxygen追加済み


## Cipher.hpp
暗号を扱うCipherクラスが入っています。  
どの関数でも**モードは"m"で暗号化、"r"で解読です**。
以下の関数が入っています。  
* string Cipher::ceasar(string モード,string 平文or暗号文,int シフトする数)  
:シーザー暗号を扱います。
* string Cipher.vigenere(string モード，string 平文or暗号文，string 鍵)
:ヴィジュネル暗号を扱います。
* string Cipher::substitution(string モード，string 平文or暗号文，string 鍵)  
:単一換字式暗号を扱います。鍵にa~zに対応した文字列を渡します。
* string Cipher::polybius_square(string モード，string 平文or暗号文)  
:ポリュビオスの暗号表(5\*5)を扱います。  
5\*5の方式ではjとiの暗号が同じ結果になります。そのため、復号結果ではiはiのままjをiとします。
* string Cipher::scytale(string モード，string 平文or暗号文)
スキュタレー暗号を扱います。  
5列に分けて暗号化復号化を行います。  
言語の仕様上変数の値を配列の要素数の宣言に使用できなかったので、500個(499文字)までに対応させました。  
マクロSCYTALE_LENGTHを書き換えることによって最大文字数を変更できます。  
SCYTALE_LENGTHは5の倍数にしてください。

doxygen追加済み


## soinsubunkai.hpp
void prime_fact(int,\*int)関数が入っています。第一引数には素因数分解したい整数値，第二引数には素因数分解後の結果を入れるための**要素数が101以上の配列**を渡してください(101以上の要素数の配列を渡しても結果は変わりません)。  
素因数を(重複する場合はそれぞれ別の値として格納し)最大100個まで先頭から格納します。  
**配列の使用されてないインデックス100以下の要素は1で埋められます。**  
doxygen追加済み


## 2line.cpp
プログラムを2行にまとめてみました()  
2行でなくなるのでdoxygenは追加しません。


## vijuneru_ojosama.cpp
こちらのソースコードはお嬢様コーディングで書いたのですわ  


## BrainPotato_language.cpp
**GUIで使用できるC#版が別で存在します。言語の仕様上の変更点があります。**  
Brainf\*ck系の言語を作りました。  
Brainf\*ckより命令数を多くしました、potatotimekunとかpotatochipsみたいな単語は作れるんですけどpotatoのpo oでポインタのアドレスに問題が起きます(動かないことはないです)  
日本語に対応させました、ただしC\#のUnicodeではなくSHIFT-JISです。  
ソースコード中に日本語を使うのはやめた方がいいです。  
ちなみに命令に関係ない文字は無視されます。空白をはさんでも大丈夫です。  
最初のポインタより前のアドレスは使用しないことを勧めます。  
命令一覧:  
* p:ポインタのアドレスをインクリメント(ptr++)
* o:ポインタのアドレスをデクリメント(ptr--)
* t:ポインタの値をインクリメント(\*ptr+=1)
* m:ポインタの値をデクリメント(\*ptr-=1)
* k:ポインタの値をASCII文字として出力
* u:ポインタの値が0ならnまで飛ばす
* n:ポインタの値が0以外ならuまで戻る
* i:ポインタの値が0ならaかe(eはaで閉じる)まで飛ばす
* e:iで飛ばされた場合のみaまで実行する
* c:ポインタの値を2倍する(\*ptr\*=2)
* h:ポインタの値を1/2倍する(\*ptr/=2)
* s:キーボード入力を1文字受け取りポインタに格納する

BrainPotatoを実行する部分のクラスについて示します。  
クラス名:BrainPotato
|メンバ名|データ型(関数は返り値)|実行結果表すもの|
| --- | --- | --- |
|BrainPotato()|-|コンストラクタ(何もしない)|
|setCode(string)|void|ソースコードを設定する|
|runCode()|wstring プログラムの実行結果|プログラムを実行する|

runCode関数では日本語に対応させるためにwstringを使っています。  
出力する際はwcoutやwprintfを使ってください。  
doxygen追加
改行,空白を含むコードも打てるようになりました。  
コードの最後に.endと書いてください。  

# Java

## RPN.java
RPNとは、逆ポーランド記法という計算式の記述方法です。  
文字列で数式を与える(文字式ではなく数値で)とRPNに変換して出力し、また計算結果も出力します。  
String RPN.makeRPN関数は引数の文字列からRPNを作って文字列で返します。数値は"\[数値\]"のように表記されます。  
double RPN.RPN_cal関数はRPN(数値と四則演算記号のみの式を上の関数で変換した文字列)を計算し、結果を返します。  
Javadoc追加済み


## minecraft_endyosai.java
マインクラフトのエンド要塞の位置を特定するためのツールです。  
Javadoc追加済み


## nullpo.java
ネタです。  
Javadoc追加済み


## Cipher.java
暗号を扱うクラスが入っています。  
以下の関数が入っています。  
* String Cipher.ceasar(String モード,String 平文or暗号文,int シフトする数)  
:シーザー暗号を扱います。**モードは"m"で暗号化、"r"で解読です(他関数でも同じです)**。
* String Cipher.vigenere(String モード，String 平文or暗号文，String 鍵)  
:ヴィジュネル暗号を扱います。
* String Cipher.substitution(String モード，String 平文or暗号文，String 鍵)  
:単一換字式暗号を扱います。鍵にa~zに対応した文字列を渡します。  
* String Cipher.polybius_square(String モード，String 平文or暗号文)  
:ポリュビオスの暗号表(5\*5)を扱います。  
5\*5の方式ではjとiの暗号が同じ結果になります。そのため、復号結果ではiはiのままjをiとします。
* string Cipher.scytale(string モード，string 平文or暗号文)
スキュタレー暗号を扱います。  
5列に分けて暗号化復号化を行います。  

Javadoc追加済み


## calculate.java
引数の文字列の計算式から四則演算を行う**double calculate.normal関数**と、それを一部の数学関数にも対応させた**double calculate.adavance関数**が入っています。  
advance関数の対応関数一覧  
* sin()  
* cos()  
* tan()  
* ** :累乗  
* root() :  

Javadoc追加済み


## MyKusoGame/mainfile(Android)
AndroidStudioで開発したスマホアプリの主要なファイルが入っています。  
フォルダ名はフォルダ構成が"Android"の構成を基にしてつけてあります。  
MITライセンスなので、解析でも改変でも何でもしてください。  
AndroidStudioで作り直す場合、パッケージ名等に気をつけてください。


## nullpo_game.java
1/3の確率でぬるぽ(NullPointerException)が投げられます。  
ぬるぽを引かずにどこまで続けられるかというゲームです。


## mod
マイクラJava版用に作成したMODが入っています。  
サブフォルダはマイクラのバージョン毎に分けています。  
マイクラJava版とForge必須。  


## mod/1.16.5/test
MOD開発初歩の試作的な感じで作ったチートMODです。  
土から「新アイテム」が作られ、新アイテムから「新ブロック」が作れます。  
新アイテムをかまどで燃やすと、一瞬でダイアモンド1つと10万経験値が得られます。  
詳しくはフォルダ内のREADME.txtを見て下さい。  

## circle.java
原点を中心とする半径rの円で、-rからxまでをx軸に垂直な直線で区切った範囲の面積を返します。  

# Processing

## beki.pde
べき関数のグラフを表示します。  
コードを分かりやすいように書き直しました。  
青色で導関数も表示するようにしました。  
表示されない部分の演算をなくしました。  
(yがウィンドウサイズを超えるもしくは最大値(Infinity)に達するまで計算します。)  
べき関数の対称性を利用して、xが負数値の場合の演算をなくしました。  

緑色で積分関数を表示するようにしました。  

## game.pde
学校の課題で作ったゲームです。  


## hansha.pde
game.pdeのキャラが跳ね返るところだけを取り出したものです。


## po.pde
3次関数が回転します。


## jan_code_make.pde
キーボード入力した11桁の数をJANコード(バーコード)に変換して表示します。


## sin_wave.pde
正弦波を2つ組み合わせた波を表示します。  
実行中でも、各波の周期T,波長lambda,振幅Aを上の文字ボタンから変更できます。  
Enterでボタンが行う加算の符号を変化させます。  


## loading.pde
ロード画面みたいなものを表示します。


## ellipse_button.pde
円形のボタンを表示します。  
円の領域を示す不等式(x^2+y^2<=r^2)から、ボタンを押したかどうか判定します。  


## vector_clock.pde
秒針、分針、時針を長さが等しいベクトルと見て、総和のベクトルを表示する時計です。  


## LCGs.pde
線形合同法の疑似乱数の格子規則性がよく分かる図を計算で表示します。  


## test_3d.pde
3Dグラフィックのテストです。  
視点移動、回転ができます。  


## e_is_2.pde
床天井とボールの反発係数eが2になってます。  
重いのかよく落ちます。  


## triangle_center_py.pde
ProcessingでPythonを使うテストです。  
triリストが頂点を表す三角形を表示し、その重心を表示します。  

## logi_bunrui.pde
ロジスティクス回帰(x=(1,x1,x1**2,x2))で分類を行います。  

## hakotamakei.pde
数学における「箱玉系」の説明として使われたソリトン性を持つモデルをアニメーションにしました。  

## rotate_half_ellipse.pde
回転する半円と直線に囲まれた面積を積分で求めます。  

## rotate_half_sphere.pde
半球と平面に囲まれた体積を積分によって求めます。  

## indirected_graph.pde
隣接行列と位数から無向グラフを生成します  
自己ループは判定せず、j>iである(i,j)成分のみを判定し、このとき(j,i)成分も1であるかは判定しません  
隣接行列を表示して、クリックで隣接を切り替えられるようにしました  
(i,j)成分を変えると自動的に(j,i)成分も変わります(i=jになるときは操作が無効になります)  

## digraph.pde
隣接行列と位数から有向グラフを生成します  
右に隣接行列を表示し、クリックで隣接を切り替えられるようにしました  
位数も変更可能です  

## SpaceWarII.pde
インベーダーゲームのようなものを作りました  
効果音はフリー音源です(https://soundeffect-lab.info/sound/battle/battle2.htmlより)  

## line_3d
線で3次元空間を再現します、edges配列が線の始点と終点の情報を持ちます  

## surface_3d.pde
平面で立方体を表示します  
自分を中心に図形を視界の中心まで回転させて、一番遠い点の座標が遠い面から表示します  
(立方体では上手くいきましたが、三角錐では失敗しました)  

## zBuffer.pde
zバッファ法によって立方体を表示します  
球を追加しました  
並列化をしました(あまり速くはないです)  

## zBuffer_bitGet.pde
画面上の全ビットについて物体の位置を計算して(存在するかどうかも含む)zバッファ法を行います  

## sketch_3Dwave.pde
減衰振動にそって水の波を再現します  

## movePoint.pde
運動する点を表示します。  
速度などを変化させられます。  
赤い点によって吸い込まれます(遠いほど弱い、向きは現在の点から赤い点へまっすぐ)  

# Python

## hitohude.py
一筆書き迷路のゲームです。  


## oolong_game.py
ウーロンを探せゲームです。ゲシュタルト崩壊しそうになります()  


## reverse_char.py
標準入力で渡された文字列を、a-z,あ-んで右からx文字目の文字を左からx文字目の文字に変換して返します。


## souinsubunkai.py
引数の値で素因数分解を行い素因数をリストで返す(昇順重複あり)、prime_fact関数が入っています。  
他のプログラムでの使用もでき、メインで実行すると、引数をキーボード入力で受け取って結果を表示します。  
引数が1以下小数である場合、エラーとして\[-1\]が返されます。  
my_math.pyにも追加したので、インポートするならそっちでもいいと思います。  
docstring追加済み


## sosu.py
第一引数から第二引数-1までの素数をリストで返すprime_num関数が入っています。  
他のプログラムでの使用もでき、メインで実行すると、キーボード入力で引数を受け取り結果を表示します。  
my_math.pyにも追加したので、インポートするならそっちでもいいと思います。  
docstring追加済み


## sosuchecker.py
引数が素数かどうか判断し、素数ならTrue、素数でなければFalseを返すcheck_prime関数が入っています。  
他のプログラムでの使用もでき、メインで実行すると、引数をキーボード入力で受け取って結果を表示します。  
my_math.pyにも追加したので、インポートするならそっちでもいいと思います。  
docstring追加済み


## sugoroku.py
CUIでスゴロクができます。


## sugoroku_gui.py
GUIでスゴロクができます。


## toppo.py
文字列からtoppoを探し出します。


## vijuneru_ango_make.py
第一引数に鍵、第二引数に平文を受け取りヴィジュネル暗号の暗号文を返すmake_vij関数が入っています。  
他のプログラムからも使用でき、メインで実行しても使用できます。  
docstring追加済み


## vijuneru_ango_read.py
第一引数に鍵、第二引数に暗号文を受け取りヴィジュネル暗号の平文を返すread_vij関数が入っています。  
他のプログラムからも使用でき、メインで実行しても使用できます。  
docstring追加済み


## xor_char.py
標準入力で渡された文字列を、それぞれの文字が16bitのUnicodeポイントとしてビット反転して文字列を表示します。


## parity.py
odd_parity関数では奇数、even_parity関数では偶数のパリティビットを文字列で返します。  
引数には**データを文字列で(2進数の状態の数)渡してください。**  
水平垂直パリティの情報があまりないので一般的な方法かどうかは怪しいですが水平垂直パリティを追加しました。  
odd_v_l_parity (evenもあります)  
引数には**データを2進数で表した文字列**を渡します。それを**7個のまとまりに分けてそれぞれ垂直パリティを計算してまとまりの最後に追加**します。**まとまりの同じインデックス同士の列で水平パリティを計算し，最後のまとまりとして追加**します。  
計算したパリティのみを\["垂直パリティ","水平パリティ"\]の形で返します。  
docstring追加済み  
今までの全ての関数で引数のデータを数値で渡せるようにしました。  
また，strかint以外の型の値を渡すと"-1"が返されるようにしました。


## rightleftupdown.py
2次元配列を行列で動かします。  
動かして't','o','p','p','o'にしてみましょう(?)


## sortchar.py
文字列をUnicodeポイントで昇順に整列し、文字列を出力します。


## sort.py
色々な整列アルゴリズムが入っています。  
**引数は整列対象のリストです。**  
アドレス渡しのため渡した配列にそのまま変更を行います。  
以下の関数が使えます。
* bubble(リスト):交換法  
* select(リスト):選択法  
* insert(リスト):挿入法  
* shell(リスト):シェルソート  
* quick(リスト):クイックソート  
* marge(リスト):マージソート  

docstring追加済み


## Cipher.py
暗号を扱うクラスが入っています。  
以下の関数が入っています。  
* Cipher.ceasar(モード,平文or暗号文,シフトする数)  
:シーザー暗号を扱います。**モードは"m"で暗号化、"r"で解読です(他関数でも同じです)**。  
* Cipher.vigenere(モード,平文or暗号文,鍵) 
:ヴィジュネル暗号を扱います。
* Cipher.substitution(モード,平文or暗号文,鍵)  
:単一換字式暗号を扱います。鍵にa~zに対応した文字列を渡します。  
* Cipher.polybius_square(モード,平文or暗号文)  
:ポリュビオスの暗号表(5\*5)を扱います。  
5\*5の方式ではjとiの暗号が同じ結果になります。そのため、復号結果ではiはiのままjをiとします。 
* Cipher.scytale(モード,平文or暗号文)
:スキュタレー暗号を扱います。  
５列に分けて暗号化します。

docstring追加済み


## ABsize.py
AB判のサイズを返すABsize関数が入っています。  
引数に("A"か"B",サイズ番号)を渡します。  
指定したA判、B判のサイズをmmでリストを返します。  
リストは縦長になる向きで\[縦,横\]となります。  
docstring追加済み


## my_math.py
C\\new_math.hのpython版です。
docstring追加済み
ベクトルクラスmathVectorを追加しました。  
メソッド演算子として以下があります。
| メソッド演算子 | 説明 |
| --- | --- |
| \_\_init\_\_(self,v_x=0,v_y=0) | コンストラクタ。x成分,y成分から新しいベクトルを作成する。 |
| onGraph(self,x1,y1,x2,y2) | クラスメソッド。新しいベクトル(x1,y1)(x2,y2)を作成する。 |
| size(self) | ベクトルの大きさを返す。 |
| (ベクトル)+または-(ベクトル) | ベクトル同士の加減算 |
| (ベクトル)*または/(intまたはfloat) | ベクトルと数値の乗除法 |
| naiseki(self,otherVector) | 内積 |
| (ベクトル)==(オブジェクト) | 等価演算子 |
| (ベクトル)!=(オブジェクト) | not ((ベクトル)==(オブジェクト)) |

以下の関数を追加しました。  
* differential(func:function)->function  
引数に渡した関数を微分して導関数を返します。  
具体的にはlim\[h->0\](f(x+h)-f(x))/hにおいてh->0.00000000001にした関数を返します。
* dif_decimal(func:function)->function  
引数に渡した関数を微分して導関数を返します。  
値をすべてdecimal型で扱い、小数点以下15で切り捨てます。  
引数に渡す関数の処理においてもdecimal型を用いてください。  
導関数において微分係数を導く時の引数が小数ならそれもdecimal型にしてください。  
具体的には  
小数点以下100桁までの数を10進数で保持し、  
lim\[h->0\](f(x+h)-f(x))/hにおいて  
h->decimal.Decimal('0.00000000000000000000000000000001')にして  
計算結果を15桁で切り捨てる関数を返します。  
* show_table(func,firstList:list,secondList:list,strLen=10)->None:  
引数が2つある関数に、2つのリストから全ての場合で順に値を渡して、表を表示します。  
func (function): 関数  
firstList (list): 要素が関数の第一引数となるリスト  
secondList (list): 要素が関数の代に引数となるリスト  
strLen (int, デフォルト:10): 表の列の横幅(左寄せに使う)  
* prime_fact(i: int) -> int  
引数の値で素因数分解を行い、素因数をリストで返します。(昇順重複あり)  
引数が小数や1以下の場合\[-1\]が返されます。  
soinsubunkai.pyの関数と同じです。  
* yakubun(a, b)->str  
a/bを約分した状態の文字列を返します。  
bを0にするとエラーを返します。  
a,bは数字でも文字列でもいいですが、一応小数は文字列にすることをおすすめします  
* prime_num(start: int, end: int) -> list  
start\~end-1までの範囲で素数をリストで返します。  
* check_prime(i: int) -> bool  
引数が素数かどうかを判断し、素数ならTrueを返します。  

* asin(x),acos(x),atan(x)  
逆三角関数です。100桁計算してstrで返します。  
* gcd(a:int,b:int)->int  
a,bの最大公約数を返します  
* cramer(argument;list,equals:list)->list  
クラメルの公式を用いて連立方程式を解きます  
argumentは係数行列(2次元リスト),equalsは連立する式の定数(ax+by=cのc,リスト)  
解をリストで返す、解がない場合空リストを返す  
  
mathMatrixクラス  
行列を扱うためのクラス  
|メソッド,演算子|説明|  
|---|---|  
|コンストラクタ|行数,列数,内容(2次元リスト)の順で受け取る|  
|determinant()|行列式を返す|  
|inverse()|逆行列を返す|  
|transpose()|転置行列を返す|  
|+,-|加減法,行列同士のみ|  
|*|乗法,スカラー量または行列|  
|/|スカラー量のみ|  
|==,!=|行列の内容が等しいかどうか|  

## countfilechar.py
入力したパスのフォルダ内にある全てのファイルを文字列として読んで文字数を表示します。  
読み込んだファイルのパスを表示し、そのファイルを開けなかったり文字列として読めなかったときは"this file is not text"と表示します。


## count_time.py
処理を実行してから完了するまでの時間を計測するデコレータfuncTimerが入っています。  
計測結果は同ファイル内で宣言している変数countedに入っています。
docstring追加済み


## mouseclicking.py
指定した座標をマウスを動かすまでクリックし続けます。  


## pote_jp.py
日本語(SHIFT-JIS文字)をポテ語にします。  


## pote_jp_rev.py
ポテ語を日本語に直します。  


## change_str.py
pote_jp.pyとpote_jp_rev.pyの置き換える文字(ポとテ)を自由に変更できるようにしました。  
以下の関数が入っています。  
* printJPTo(jpStr,p,t)  
printJPPoteより  
* printToJP(ptStr,p,t)  
printJPより  

## potatoRPG
「ポテトしかおらんRPG」のソースコード等です。  
勝手にいじりまくっていいですが、一応他のところから画像素材借りてるのでREADMEは読んでおいてください。  

## kaiki.py
最急降下法によって、data.csvにあるデータの近くを通る関数を予測します。  

## bunrui.py
ロジスティクス回帰で分類を行います  
データはbunruiData.csvから入力します  

# JavaScript

## kakezann1000.html
掛け算を11から10001000まで表示します。  
重すぎるのかスマホからだと表示できなかったりします。


## game1.html
game1.cssとgame1.jsを使っています。  
ボタンを押して数字を揃えるゲームです。
JSDoc追加済み


## count_birthday.html
count_birthday.css/jsを使っています。  
誕生日の日数をカウントするページです。  
JSDoc追加済み


## tweetdeck_gaming.js
ChromeでTweetDeckを開いて、デベロッパーツールのコンソールでこのコードを実行するとTweetDeckがゲーミングします。


## serihu.js
文字列を装飾する関数が入っています。  
関数一覧  
* taoresou(sentence)  
セリフを渡すと倒れそうな感じのセリフに変換されます。  
,と、と。は変換時に消します。  
セリフは日本語のみの方が上手くいくと思います。  
* gyaku(sentence,split_str="")  
ABC逆から読んでもCBA   
split_str:逆から読んでもの両端につける文字列、デフォルトは""  
* sinjiro(sentence,{sentence2="",kobun=-1})  
進次郎構文を作成します。  
sentence2 任意、２回目の文(デフォルトは1回目の文)  
kobun 任意、構文番号(デフォルトはランダム)  
構文番号表

|番号|構文|
|---|---|
|-1|ランダムに決定|
|0|～と思います。だからこそ～と思っている|
|1|～です。なぜなら、～だからです。|
|2|～したいということは、～しているというわけではないです。|
|3|～ということは、～ということです。|
|4|～とは、～という意味です。|
|5|～です。なので、～です。|
|6|～を見て下さい、～があります。|


## test
JavaScriptの機能を試すためのファイルを入れてます。

## birthdayParadox.html/.js
誕生日パラドックスを実践的に体感するためのプログラムです。  

# Csharp

## babanuki.cs
ババ抜きを扱うクラスbabanukiが入っています。  
動作確認等はまだなので細かい説明は今のところなしです。


## unit_change.cs
Cpp/unit_change.cppのC#版です。ただし単位の指定はC/unit_change.cの番号方式を使っています。


## BrainPotato.cs
Cpp/BrainPotato.cppのC#版です。  
GUIとして使用でき、exeファイルにしたものがBrainPotato/BrainPotato.exeになります。  
Brainf\*ck系の言語を作りました。  
Brainf\*ckより命令数を多くしました、potatotimekunとかpotatochipsみたいな単語も作れます。  
ちなみに命令に関係ない文字は無視されます。  
C#なのでポインタではなく、リストを使用しています。  
最初のアドレスより前のアドレスに移動しようとするとその操作は無効化されます。  
また、おそらくUnicodeポイントを使用していて、日本語が使えます。  
命令一覧:  
* p:ポインタのアドレスをインクリメント(ptr++)
* o:ポインタのアドレスをデクリメント(ptr--)
* t:ポインタの値をインクリメント(\*ptr+=1)
* m:ポインタの値をデクリメント(\*ptr-=1)
* k:ポインタの値を文字として出力
* u:ポインタの値が0ならnまで飛ばす
* n:ポインタの値が0以外ならuまで戻る
* i:ポインタの値が0ならaかe(eはaで閉じる)まで飛ばす
* e:iで飛ばされた場合のみaまで実行する
* c:ポインタの値を2倍する(\*ptr\*=2)
* h:ポインタの値を1/2倍する(\*ptr/=2)
* s:キーボード入力を1文字受け取りポインタに格納する


## test
テスト用のファイルです。


# BrainPotato

## BrainPotato.exe
CSharp/BrainPotato.csをexe化したBrainPotatoを実行するためのGUIです。


## helloworld.brpt
"Hello World"を表示します。


## helloworld_ja.brpt
"ハローワールド"を表示します。


## shift_minus1.brpt
入力に  
文字数(1文字)文字(文字数分)  
を渡すと文字コードを-1して返します。  
例:"3あいう""ぁぃぅ"  
"4bcde""abcd"


## countwhile.brpt
他のプログラムで使う関数的なプログラムとすることを想定したプログラムです。  
インポート文なんてものはないのでコピー&ペーストです。  
入力でwhile文をループする回数を設定します。  
回数(複数文字化)/文字列(回数分以上)  
で文字列を出力します。  
例:"12/abcdefghijkl""abedefghijkl"  
"5/aaaaaaaa""aaaaa"


## Unicode_print.brpt
とにかくUnicode文字を順番に表示するだけのプログラムです。  
理論上1～2^16のUnicode文字を出力しますが、そこまで来るとどこかの時点で文字が定められてないUnicodeポイントもでてくるような感じですね。 


## Unicode_from_to.brpt
入力で  
数字列A/数字列B/  
と渡すと、数字列Aから数字列BまでのUnicode文字を出力します。  
例:"12353/12362/""ぁあぃいぅうぇえぉお"


## helloworld2.brpt
helloworldをできるだけコードを短く書こうと思ったのですが、helloworld.brptと大した差はありませんでした。  
原因はc命令の存在でそもそも短いのとBrainf*ck特有のwhile文の回数制限の構文の長さがあると思います

# Dart

## Cipher.dart
他言語のCipherプログラムと同じです。  
返り値はString型で返し、モードはString型で渡します。


## cipher
Cipher.dartを利用したFlutterプロジェクトです。



## shogi
(合同法)乱数による将棋です。  
自分の駒ですら自分の意志で動かせない将棋なのでばりばり運ゲーです...w


## test.dart
テスト用ファイルです。


## test
flutterのテストです。

# VBA

## Janken.xlsm
コンピュータとじゃんけんができます  


