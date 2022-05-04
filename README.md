自作プログラムを公開してます。  
各プログラムのバージョン別等の説明はPotatoTimeKun/programmingレポジトリのWikiに書いてあります。  
ここではver0.8対応の説明を書きます。  

# C
C言語のソースコードが入っています。

## heron.c
**(関数化したものがnew_math.hに入っています。)**  
ヘロンの公式によって三角形の面積を求めるプログラムです。  
ヘロンの公式は、面積をSとして△ABCで次の式のようになります。  
S=√(s(s-a)(s-b)(s-c))  
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
5列に分けて暗号化・復号化を行います。  
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

## acceleration.h
加速度の単位を変換するための下の関数が入っています。  
double accchange(double 変換前の値,int 変換前の単位,int 変換後の単位)  
単位は以下の番号で指定します。  
 * 0番="m/s2":メートル毎秒毎秒(1m/s^2)
 * 1番="km/h/s":キロメートル毎時毎秒(0.27777777m/s^2)
 * 2番="ft/h/s":フィート毎時毎秒(0.00008466666666m/s^2)
 * 3番="ft/min/s":フィート毎分毎秒(0.00508m/s^2)
 * 4番="ft/s2":フィート毎秒毎秒(0.3048m/s^2)
 * 5番="in/min/s":インチ毎分毎秒(0.000423333333m/s^2)
 * 6番="in/s2":インチ毎秒毎秒(0.0254m/s^2)
 * 7番="mi/h/s":マイル毎時毎秒(0.44704m/s^2) 
 * 8番="mi/min/s":マイル毎分毎秒(26.8224m/s^2)
 * 9番="mi/s2":マイル毎秒毎秒(1609.344m/s^2)
 * 10番="kn/s":ノット毎秒(0.5144444m/s^2)
 * 11番="Gal":ガル(0.01m/s^2)
 * 12番="g":標準重力加速度(9.80665m/s^2)

doxygen追加済み

## area.h
面積の単位を変換するための下の関数が入っています。  
double areachange(double 変換前の値,int 変換前の単位,int 変換後の単位)  
単位は以下の番号で指定します。  
 * 0番="m2":平方メートル(1m^2)
 * 1番="km2":平方キロメートル(1000000m^2)
 * 2番="a":アール(100m^2)
 * 3番="ha":ヘクタール(10000m^2)
 * 4番="TUBO":坪(3.305785124m^2)
 * 5番="BU":歩(3.305785124m^2)
 * 6番="SE":畝(99.173554m^2)
 * 7番="TAN":反(991.736m^2)
 * 8番="CHOU":町(9917.35537m^2)
 * 9番="ft2":平方フィート(0.09290304m^2)
 * 10番="in2":平方インチ(0.00064516m^2)
 * 11番="yd2":平方ヤード(0.83612736m^2)

doxygen追加済み

## length.h
長さの単位を変換するための下の関数が入っています。  
double lengthchange(double 変換前の値,int 変換前の単位,int 変換後の単位)  
単位は以下の番号で指定します。  
 * 0番="m":メートル  
 * 1番="au":天文単位(149597870700m)  
 * 2番="KAIRI":海里(1852m)  
 * 3番="in":インチ(0.0254m)  
 * 4番="ft":フィート(0.3048m)  
 * 5番="yd":ヤード(0.9144m)  
 * 6番="mile":マイル(1604.344m)  
 * 7番="RI":里(3927.27m)  
 * 8番="HIRO":尋(1.1818m)  
 * 9番="KEN":間(1.1818m)  
 * 10番="SHAKU":尺(0.30303)  
 * 11番="SUN":寸(0.030303m)  
 * 12番="ly":光年(9460730472580800m) 

doxygen追加済み

## mass.h
質量の単位を変換するための下の関数が入っています。  
double masschange(double 変換前の値,int 変換前の単位,int 変換後の単位)  
単位は以下の番号で指定します。  
 * 0番="g":グラム
 * 1番="kg":キログラム(1000g)
 * 2番="t":トン(1000000g)
 * 3番="gamma":γ(0.000001g)
 * 4番="kt":カラット(0.2g)
 * 5番="oz":オンス(28.349523125g)
 * 6番="lb":ポンド(453.59237g)
 * 7番="q":キンタル(100000g)
 * 8番="mom":匁(3.75g)
 * 9番="KAN":貫(3750g)
 * 10番="RYOU":両(37.5g)
 * 11番="KIN":斤(600g)

doxygen追加済み

## prefix.h
接頭辞の単位を変換するための下の関数が入っています。  
double prefixchange(double 変換前の値,int 変換前の単位,int 変換後の単位)  
単位は以下の番号で指定します。  
 * 0番="normal":1
 * 1番="Y":10^24
 * 2番="Z":10^21
 * 3番="E":10^18
 * 4番="P":10^15
 * 5番="T":10^12
 * 6番="G":10^9
 * 7番="M":10^6
 * 8番="k":10^3
 * 9番="h":10^2
 * 10番="da":10
 * 11番="d":10^-1
 * 12番="c":10^-2
 * 13番="m":10^-3
 * 14番="micro":10^-6(μ)
 * 15番="n":10^-9
 * 16番="p":10^-12
 * 17番="f":10^-15
 * 18番="a":10^-18
 * 19番="z":10^-21
 * 20番="y":10^-24

doxygen追加済み

## speed.h
速度の単位を変換するための下の関数が入っています。  
double speedchange(double 変換前の値,int 変換前の単位,int 変換後の単位)  
単位は以下の番号で指定します。  
 * 0番="m/s":メートル毎秒(1m/s)
 * 1番="km/h":キロメートル毎時(0.2777778m/s)
 * 2番="ft/h":フィート毎時(0.00008466667m/s)
 * 3番="ft/min":フィート毎分(0.00508m/s)
 * 4番="ft/s":フィート毎秒(0.3048m/s)
 * 5番="in/min":インチ毎分(0.000423333m/s)
 * 6番="in/s":インチ毎秒(0.0254m/s)
 * 7番="mi/h":マイル毎時(0.44704m/s)
 * 8番="mi/min":マイル毎分(26.8224m/s) 
 * 9番="mi/s":マイル毎秒(1.609344m/s)
 * 10番="kn":ノット(0.514444m/s)
 * 11番="c":真空中の光速度(299792458m/s)

doxygen追加済み

## temperature.h
温度の単位を変換するための下の関数が入っています。  
double temperaturechange(double 変換前の値,int 変換前の単位,int 変換後の単位)  
単位は以下の番号で指定します。  
 * 0番="K":ケルビン
 * 1番="C":セルシウス度
 * 2番="F":ファーレンハイト度
 * 3番="Ra":ランキン度

doxygen追加済み

## time_unit.h
時間の単位を変換するための下の関数が入っています。  
double time_unitchange(double 変換前の値,int 変換前の単位,int 変換後の単位)  
単位は以下の番号で指定します。  
 * 0番="s":秒(1s)
 * 1番="shake":シェイク(0.00000001s)
 * 2番="TU":Time Unit(0.001024s)
 * 3番="jiffy_e":ジフィ(電子工学,東日本)(1/50)
 * 4番="jiffy_w":ジフィ(電子工学,西日本)(1/60)
 * 5番="min":分(60s)
 * 6番="moment":モーメント(90s)
 * 7番="KOKU":刻(中国,100刻制)(900s)
 * 8番="KOKU_old":刻(中国,96刻制)(864s)
 * 9番="h":時(60*60s)
 * 10番="d":日(606024s)
 * 11番="wk":週(606024*7s)
 * 12番="JUN":旬(606024*10s)
 * 13番="fortnight":フォートナイト(半月)(606024*14s)
 * 14番="SAKUBO":朔望月(2551442.27s)
 * 15番="mo":月(30d)(606024*30s)
 * 16番="quarter":四半期(7776000s)
 * 17番="semester":セメスター(10872000s)
 * 18番="y":年(365d)(31536000s)
 * 19番="greg":グレゴリオ年(31556952s)
 * 20番="juli":ユリウス年(31557600s)
 * 21番="year":恒星年(31558149.764928s)
 * 22番="c":世紀(365d*100)(3153600000s)

doxygen追加済み

## volume.h
体積の単位を変換するための下の関数が入っています。  
double volumechange(double 変換前の値,int 変換前の単位,int 変換後の単位)  
単位は以下の番号で指定します。  
 * 0番="m3":立方メートル(1m^3)
 * 1番="L":リットル(0.001m^3)
 * 2番="KOSAJI":小さじ(0.000005m^3)
 * 3番="OSAJI":大さじ(0.000015m^3)
 * 4番="c":カップ(0.00025m^3)
 * 5番="lambda":λ(0.000000001m^3)
 * 6番="acft":エーカー・フィート(1233.48183754752m^3)
 * 7番="drop":ドロップ(0.00000005m^3)
 * 8番="in3":立方インチ(0.000016387064m^3)
 * 9番="ft3":立方フィート(0.028316846592m^3)
 * 10番="yd3":立方ヤード(0.764554857984m^3)
 * 11番="mi3":立方マイル(4168.181825440579584m^3)
 * 12番="KOKU":石(0.18039m^3)
 * 13番="TO":斗(0.018039m^3)
 * 14番="SHOU":升(0.0018039m^3)
 * 15番="GOU":合(0.00018039m^3)
 * 16番="SHAKU":勺(0.000018039m^3)

doxygen追加済み

## unit_change.h
以下のヘッダファイルの機能が全て入っています。  
* acceleration.h
* area.h
* length.h
* mass.h
* prefix.h
* speed.h
* temperature.h
* time_unit.h
* volume.h

doxygen追加済み

## rnd.h
疑似乱数を生成する関数が入っています。  
以下の関数があります。  
* void LCGs(int a,int b,int m,int n,int *return_array)
合同法乱数を計算します。
* void BBS(int p,int q,int a,int n,int *return_array)
B.B.S.で疑似乱数を生成します。

# Cpp
C++のソースコードが入っています。

## keisan_int.cpp
文字列として式を入力すると、値を多倍長整数として演算して結果を返します。  
多倍長整数は、同じフォルダで公開してる**newint.hをインポートして使っています**。  
doxygen追加済み

## newint.h
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
doxygen追加済み

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

## vij.hpp
**(ヴィジュネル暗号を扱う関数はChipher.hppにもあります。)**  
ヴィジュネル暗号を作成、解読する関数を扱います。  
以下の関数を持ちます。  
* string vij(string型の平文,string型の鍵)  
* string readvij(string型の暗号,string型の鍵)  

doxygen追加済み

## vijuneru_ango.cpp
標準入出力でヴィジュネル暗号の作成・解読を行います。  
**vij.hppをインポートして使っています。**  
doxygen追加済み

## math_C_P.cpp
標準入出力で数学の順列・組み合わせの計算を行います。  
doxygen追加済み

## babanuki.cpp
CPUとプレイヤーの1対1でのババ抜きです。  
(CUIのゲームです。)  
doxygen追加済み

## length.hpp
長さの単位を変換するための**length::change関数**が入っています。  
引数として(double 値, string 値の単位,string 変換後の単位)を渡し、戻り値はdoubleです。  
対応単位一覧  
* "m":メートル  
* "au":天文単位(149597870700m)  
* "KAIRI":海里(1852m)  
* "in":インチ(0.0254m)  
* "ft":フィート(0.3048m)  
* "yd":ヤード(0.9144m)  
* "mile":マイル(1604.344m)  
* "RI":里(3927.27m)  
* "HIRO":尋(1.1818m)  
* "KEN":間(1.1818m)  
* "SHAKU":尺(0.30303)  
* "SUN":寸(0.030303m)  
* "ly":光年(9460730472580800m)  

doxygen追加済み

## mass.hpp
重さの単位を変換するための**mass::change関数**が入っています。  
引数として(double 値, string 値の単位,string 変換後の単位)を渡し、戻り値はdoubleです。  
対応単位一覧  
* "g":グラム  
* "kg":キログラム(1000g)  
* "t":トン(1000000g)  
* "gamma":γ(0.000001g)  
* "kt":カラット(0.2g)  
* "oz":オンス(28.349523125g)  
* "lb":ポンド(453.59237g)  
* "q":キンタル(100000g)  
* "mom":匁(3.75g)  
* "KAN":貫(3750g)  
* "RYOU":両(37.5g)  
* "KIN":斤(600g)  

doxygen追加済み

## temperature.hpp
温度の単位を変換するための**temperature::change関数**が入っています。  
引数として(double 値, string 値の単位,string 変換後の単位)を渡し、戻り値はdoubleです。  
対応単位一覧  
* "K":ケルビン  
* "C":セルシウス度  
* "F":ファーレンハイト度  
* "Ra":ランキン度

doxygen追加済み

## area.hpp
面積の単位を変換するための**area::change関数**が入っています。  
引数として(double 値, string 値の単位,string 変換後の単位)を渡し、戻り値はdoubleです。  
対応単位一覧  
* "m2":平方メートル(1m^2)  
* "km2":平方キロメートル(1000000m^2)  
* "a":アール(100m^2)  
* "ha":ヘクタール(10000m^2)  
* "TUBO":坪(3.305785124m^2)  
* "BU":歩(3.305785124m^2)  
* "SE":畝(99.173554m^2)  
* "TAN":反(991.736m^2)  
* "CHOU":町(9917.35537m^2)  
* "ft2":平方フィート(0.09290304m^2)  
* "in2":平方インチ(0.00064516m^2)  
* "yd2":平方ヤード(0.83612736m^2)  

doxygen追加済み

## volume.hpp
体積の単位を変換するための**volume::change関数**が入っています。  
引数として(double 値, string 値の単位,string 変換後の単位)を渡し、戻り値はdoubleです。  
対応単位一覧  
* "m3":立方メートル(1m^3)  
* "L":リットル(0.001m^3)  
* "KOSAJI":小さじ(0.000005m^3)  
* "OSAJI":大さじ(0.000015m^3)  
* "c":カップ(0.00025m^3)  
* "lambda":λ(0.000000001m^3)  
* "acft":エーカー・フィート(1233.48183754752m^3)  
* "drop":ドロップ(0.00000005m^3)  
* "in3":立方インチ(0.000016387064m^3)  
* "ft3":立方フィート(0.028316846592m^3)  
* "yd3":立方ヤード(0.764554857984m^3)  
* "mi3":立方マイル(4168.181825440579584m^3)  
* "KOKU":石(0.18039m^3)  
* "TO":斗(0.018039m^3)  
* "SHOU":升(0.0018039m^3)  
* "GOU":合(0.00018039m^3)  
* "SHAKU":勺(0.000018039m^3)  

doxygen追加済み

## prefix.hpp
接頭辞を変換するための**prefix::change関数**が入っています。  
引数として(double 値, string 値の接頭辞,string 変換後の接頭辞)を渡し、戻り値はdoubleです。  
今の時点ではSI単位の接頭辞に対応しています。  
対応単位一覧  
* "Y":10^24  
* "Z":10^21  
* "E":10^18  
* "P":10^15  
* "T":10^12  
* "G":10^9  
* "M":10^6  
* "k":10^3  
* "h":10^2  
* "da":10  
* "normal":1  
* "d":10^-1  
* "c":10^-2  
* "m":10^-3  
* "micro":10^-6(μ)  
* "n":10^-9  
* "p":10^-12  
* "f":10^-15  
* "a":10^-18  
* "z":10^-21  
* "y":10^-24  

doxygen追加済み

## speed.hpp
速度の単位を変換するための**speed::change関数**が入っています。  
引数として(double 値, string 値の単位,string 変換後の単位)を渡し、戻り値はdoubleです。  
対応単位一覧  
* "m/s":メートル毎秒(1m/s)  
* "km/h":キロメートル毎時(0.2777778m/s)  
* "ft/h":フィート毎時(0.00008466667m/s)  
* "ft/min":フィート毎分(0.00508m/s)  
* "ft/s":フィート毎秒(0.3048m/s)  
* "in/min":インチ毎分(0.000423333m/s)  
* "in/s":インチ毎秒(0.0254m/s)  
* "mi/h":マイル毎時(0.44704m/s)  
* "mi/min":マイル毎分(26.8224m/s)  
* "mi/s":マイル毎秒(1.609344m/s)  
* "kn":ノット(0.514444m/s)  
* "c":真空中の光速度(299792458m/s)  

doxygen追加済み

## acceleration.hpp
加速度の単位を変換するための**acc::change関数**が入っています。  
引数として(double 値, string 値の単位,string 変換後の単位)を渡し、戻り値はdoubleです。  
対応単位一覧  
* "m/s2":メートル毎秒毎秒(1m/s^2)  
* "km/h/s":キロメートル毎時毎秒(0.27777777m/s^2)  
* "ft/h/s":フィート毎時毎秒(0.00008466666666m/s^2)  
* "ft/min/s":フィート毎分毎秒(0.00508m/s^2)  
* "ft/s2":フィート毎秒毎秒(0.3048m/s^2)  
* "in/min/s":インチ毎分毎秒(0.000423333333m/s^2)  
* "in/s2":インチ毎秒毎秒(0.0254m/s^2)  
* "mi/h/s":マイル毎時毎秒(0.44704m/s^2)  
* "mi/min/s":マイル毎分毎秒(26.8224m/s^2)  
* "mi/s2":マイル毎秒毎秒(1609.344m/s^2)  
* "kn/s":ノット毎秒(0.5144444m/s^2)  
* "Gal":ガル(0.01m/s^2)  
* "g":標準重力加速度(9.80665m/s^2)  

doxygen追加済み

## time_unit.hpp
時間の単位を変換するための**time_unit::change関数**が入っています。  
引数として(double 値, string 値の単位,string 変換後の単位)を渡し、戻り値はdoubleです。  
対応単位一覧  
* "s":秒(1s)  
* "shake":シェイク(0.00000001s)  
* "TU":Time Unit(0.001024s)  
* "jiffy_e":ジフィ(電子工学,東日本)(1/50)  
* "jiffy_w":ジフィ(電子工学,西日本)(1/60)  
* "min":分(60s)  
* "moment":モーメント(90s)  
* "KOKU":刻(中国,100刻制)(900s)  
* "KOKU_old":刻(中国,96刻制)(864s)  
* "h":時(60\*60s)  
* "d":日(60\*60\*24s)  
* "wk":週(60\*60\*24\*7s)  
* "JUN":旬(60\*60\*24\*10s)  
* "fortnight":フォートナイト(半月)(60\*60\*24\*14s)  
* "SAKUBO":朔望月(2551442.27s)  
* "mo":月(30d)(60\*60\*24\*30s)  
* "quarter":四半期(7776000s)  
* "semester":セメスター(10872000s)  
* "y":年(365d)(31536000s)  
* "greg":グレゴリオ年(31556952s)  
* "juli":ユリウス年(31557600s)  
* "year":恒星年(31558149.764928s)  
* "c":世紀(365d\*100)(3153600000s)  

doxygen追加済み

## unit_change.hpp
以下のヘッダファイルを1つのファイルにまとめたものです。  
* acceleration.hpp  
* area.hpp  
* length.hpp  
* mass.hpp  
* prefix.hpp  
* speed.hpp  
* temperature.hpp  
* time_unit.hpp  
* volume.hpp  

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
5列に分けて暗号化・復号化を行います。  
言語の仕様上変数の値を配列の要素数の宣言に使用できなかったので、500個(499文字)までに対応させました。  
マクロSCYTALE_LENGTHを書き換えることによって最大文字数を変更できます。  
SCYTALE_LENGTHは5の倍数にしてください。

doxygen追加済み

## soinsubunkai.hpp
void prime_fact(int,\*int)関数が入っています。第一引数には素因数分解したい整数値，第二引数には素因数分解後の結果を入れるための**要素数が101以上の配列**を渡してください(101以上の要素数の配列を渡しても結果は変わりません)。  
素因数を(重複する場合はそれぞれ別の値として格納し)最大100個まで先頭から格納します。  
**配列の使用されてないインデックス100以下の要素は―1で埋められます。**  
doxygen追加済み

## 2line.cpp
プログラムを2行にまとめてみました()  
2行でなくなるのでdoxygenは追加しません。

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
|メンバ名|データ型(関数は返り値)|実行結果・表すもの|
| --- | --- | --- |
|BrainPotato()|-|コンストラクタ(何もしない)|
|setCode(string)|void|ソースコードを設定する|
|runCode()|wstring プログラムの実行結果|プログラムを実行する|

runCode関数では日本語に対応させるためにwstringを使っています。  
出力する際はwcoutやwprintfを使ってください。  
doxygen追加

# Java
Javaのソースコードが入っています。

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
5列に分けて暗号化・復号化を行います。  

Javadoc追加済み

## unit_change.java
Cpp\\**unit_change.hpp**のjava版です。  
Javadoc追加済み

## calculate.java
引数の文字列の計算式から四則演算を行う**double calculate.normal関数**と、それを一部の数学関数にも対応させた**double calculate.adavance関数**が入っています。  
advance関数の対応関数一覧  
* sin()  
* cos()  
* tan()  
* ** :累乗  
* root() :√  

Javadoc追加済み

## MyKusoGame/mainfile(Android)
Ver0.5～now:  
AndroidStudioで開発したスマホアプリの主要なファイルが入っています。  
フォルダ名はフォルダ構成が"Android"の構成を基にしてつけてあります。  
MITライセンスなので、解析でも改変でも何でもしてください。  
AndroidStudioで作り直す場合、パッケージ名等に気をつけてください。

## nullpo_game.java
1/3の確率でぬるぽ(NullPointerException)が投げられます。  
ぬるぽを引かずにどこまで続けられるかというゲームです。

# Processing
processingのソースコードが入っています。  

## beki.pde
べき関数のグラフを表示します。  

## game.pde
学校の課題で作ったゲームです。  

## hansha.pde
game.pdeのキャラが跳ね返るところだけを取り出したものです。

## po.pde
3次関数が回転します。

## jan_code_make.pde
キーボード入力した11桁の数をJANコード(バーコード)に変換して表示します。

# Python
Pythonのソースコードが入っています。

## hitohude.py
一筆書き迷路のゲームです。  

## oolong_game.py
ウーロンを探せゲームです。ゲシュタルト崩壊しそうになります()  

## reverse_char.py
標準入力で渡された文字列を、a-z,あ-んで右からx文字目の文字を左からx文字目の文字に変換して返します。

## souinsubunkai.py
引数の値で素因数分解を行い素因数をリストで返す(昇順・重複あり)、prime_fact関数が入っています。  
他のプログラムでの使用もでき、メインで実行すると、引数をキーボード入力で受け取って結果を表示します。  
引数が1以下・小数である場合、エラーとして\[-1\]が返されます。  
docstring追加済み

## sosu.py
第一引数から第二引数-1までの素数をリストで返すprime_num関数が入っています。  
他のプログラムでの使用もでき、メインで実行すると、キーボード入力で引数を受け取り結果を表示します。  
docstring追加済み

## sosuchecker.py
引数が素数かどうか判断し、素数ならTrue、素数でなければFalseを返すcheck_prime関数が入っています。  
他のプログラムでの使用もでき、メインで実行すると、引数をキーボード入力で受け取って結果を表示します。  
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

## unit_change.py
Cppファイルの**unit_change.hpp**と同じ方式のクラス、関数を扱います。  
ただしPythonの仕様上  
import unit_change  
とした場合  
unit_change.クラス名.change(引数)  
として扱うことになります。  
docstring追加済み

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
2次元配列を行・列で動かします。  
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
A・B判のサイズを返すABsize関数が入っています。  
引数に("A"か"B",サイズ番号)を渡します。  
指定したA判、B判のサイズをmmでリストを返します。  
リストは縦長になる向きで\[縦,横\]となります。  
docstring追加済み

## my_math.py
C\\new_math.hのpython版です。
docstring追加済み
ベクトルクラスmathVectorを追加しました。  
メソッド・演算子として以下があります。
| メソッド・演算子 | 説明 |
| --- | --- |
| \_\_init\_\_(self,v_x=0,v_y=0) | コンストラクタ。x成分,y成分から新しいベクトルを作成する。 |
| onGraph(x1,y1,x2,y2) | クラスメソッド。新しいベクトル→(x1,y1)(x2,y2)を作成する。 |
| (ベクトル)+または-(ベクトル) | ベクトル同士の加減算 |
| (ベクトル)*(intまたはfloat) | ベクトルと数値の乗法 |
| naiseki(self,otherVector) | 内積 |
| (ベクトル)==(オブジェクト) | 等価演算子 |
| (ベクトル)!=(オブジェクト) | not ((ベクトル)==(オブジェクト)) |

以下の関数を追加しました。  
* vecValue(vec:mathVector)->float  
ベクトルvの大きさ(つまり|→v|)を調べます。  
* differential(function:function)->function  
引数に渡した関数を微分して導関数を返します。  
具体的にはlim\[h->0\](f(x+h)-f(x))/hにおいてh->0.00000000001にした関数を返します。
* dif_decimal(function:function)->function  
引数に渡した関数を微分して導関数を返します。  
値をすべてdecimal型で扱い、小数点以下15で切り捨てます。  
引数に渡す関数の処理においてもdecimal型を用いてください。  
導関数において微分係数を導く時の引数が小数ならそれもdecimal型にしてください。  
具体的には  
小数点以下100桁までの数を10進数で保持し、  
lim\[h->0\](f(x+h)-f(x))/hにおいて  
h->decimal.Decimal('0.00000000000000000000000000000001')にして  
計算結果を15桁で切り捨てる関数を返します。

## countfilechar.py
入力したパスのフォルダ内にある全てのファイルを文字列として読んで文字数を表示します。  
読み込んだファイルのパスを表示し、そのファイルを開けなかったり文字列として読めなかったときは"this file is not text"と表示します。

## count_time.py
処理を実行してから完了するまでの時間を計測するデコレータfuncTimerが入っています。  
計測結果は同ファイル内で宣言している変数countedに入っています。
docstring追加済み

## mouseclicking.py
指定した座標をマウスを動かすまでクリックし続けます。  

# JavaScript
JavaScriptとHTML・CSSが入っています。

## kakezann1000.html
掛け算を1×1から1000×1000まで表示します。  
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

## test
JavaScriptの機能を試すためのファイルを入れてます。

# Csharp
C#のソースコードが入っています。

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
BrainPotatoのソースコード等が入っています。(BrainPotato言語についてはCSharp/BrainPotato.csを参照)  
BrainPotatoのソースコードの拡張子名はbrptです。(テキストファイルとして認識できれば別の拡張子名のものを読み込んでも構いません)  
既定の命令以外は無視されますが、処理を分かりやすくするために改行や空白、インデントなどをつけています。  
また、プログラム中の数字は基本的にその時のリスト(仮想ポインタ)のインデックスです。  
メモは命令に被らないように日本語や大文字の英字を使っています。  

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
例:"3あいう"→"ぁぃぅ"  
"4bcde"→"abcd"

## countwhile.brpt
他のプログラムで使う関数的なプログラムとすることを想定したプログラムです。  
インポート文なんてものはないのでコピー&ペーストです。  
入力でwhile文をループする回数を設定します。  
回数(複数文字化)/文字列(回数分以上)  
で文字列を出力します。  
例:"12/abcdefghijkl"→"abedefghijkl"  
"5/aaaaaaaa"→"aaaaa"

## Unicode_print.brpt
とにかくUnicode文字を順番に表示するだけのプログラムです。  
理論上1～2^16のUnicode文字を出力しますが、そこまで来るとどこかの時点で文字が定められてないUnicodeポイントもでてくるような感じですね。 

## Unicode_from_to.brpt
入力で  
数字列A/数字列B/  
と渡すと、数字列Aから数字列BまでのUnicode文字を出力します。  
例:"12353/12362/"→"ぁあぃいぅうぇえぉお"

## helloworld2.brpt
helloworldをできるだけコードを短く書こうと思ったのですが、helloworld.brptと大した差はありませんでした。  
原因はc命令の存在でそもそも短いのとBrainf*ck特有のwhile文の回数制限の構文の長さがあると思います

# Dart
Dart言語のプログラムが入っています。

# Cipher.dart
他言語のCipherプログラムと同じです。  
返り値はString型で返し、モードはString型で渡します。  
今のところceaserとVigenereとsubstitutionがあります。

## test.dart
テスト用ファイルです。

## test
flutterのテストです。