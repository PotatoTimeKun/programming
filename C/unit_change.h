/**
 * @file unit_change.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 単位を変換するための各関数が入っています。
 * 関数一覧
 * accchange:加速度
 * areachange:面積
 * lengthchange:長さ
 * masschange:質量
 * prefixchange:接頭辞
 * speedchange:速度
 * temperaturechange:温度
 * time_unitchange:時間
 * volumechange:体積
 * 
 */
#ifndef INCLUDE_TANNI
#define INCLUDE_TANNI
const double ACC_TANNI[] = {1, 0.27777777,0.00008466666666,0.000423333333,0.00508,0.01,0.0254,0.3048,0.44704,0.5144444,9.80665,26.8224,1609.344};
    /**
    @brief 加速度の単位を変換します。
    対応単位一覧
    0番="m/s2":メートル毎秒毎秒(1m/s^2)
    1番="km/h/s":キロメートル毎時毎秒(0.27777777m/s^2)
    2番="ft/h/s":フィート毎時毎秒(0.00008466666666m/s^2)
    3番="ft/min/s":フィート毎分毎秒(0.00508m/s^2)
    4番="ft/s2":フィート毎秒毎秒(0.3048m/s^2)
    5番="in/min/s":インチ毎分毎秒(0.000423333333m/s^2)
    6番="in/s2":インチ毎秒毎秒(0.0254m/s^2)
    7番="mi/h/s":マイル毎時毎秒(0.44704m/s^2)
    8番="mi/min/s":マイル毎分毎秒(26.8224m/s^2)
    9番="mi/s2":マイル毎秒毎秒(1609.344m/s^2)
    10番="kn/s":ノット毎秒(0.5144444m/s^2)
    11番="Gal":ガル(0.01m/s^2)
    12番="g":標準重力加速度(9.80665m/s^2)
    @param from 値
    @param kigou 値の単位(番号)
    @param to_kigou 変換後の単位(番号)
    @return double 変換後の値 
     */
double accchange(double from, int kigou, int to_kigou)
{
    double to;
    to = from * ACC_TANNI[kigou];
    to = to / ACC_TANNI[to_kigou];
    return to;
}
const double AREA_TANNI[] = {1,100,10000,1000000,3.305785124,3.305785124,99.173554,991.736,9917.35537,0.09290304,0.00064516,0.83612736};
    /**
    @brief 温度の単位を変換します。
    対応単位一覧
    0番="m2":平方メートル(1m^2)
    1番="km2":平方キロメートル(1000000m^2)
    2番="a":アール(100m^2)
    3番="ha":ヘクタール(10000m^2)
    4番="TUBO":坪(3.305785124m^2)
    5番="BU":歩(3.305785124m^2)
    6番="SE":畝(99.173554m^2)
    7番="TAN":反(991.736m^2)
    8番="CHOU":町(9917.35537m^2)
    9番="ft2":平方フィート(0.09290304m^2)
    10番="in2":平方インチ(0.00064516m^2)
    11番="yd2":平方ヤード(0.83612736m^2)
    @param from 値
    @param kigou 値の単位(番号)
    @param to_kigou 変換後の単位(番号)
    @return double 変換後の値 
     */
double areachange(double from, int kigou, int to_kigou)
{
    double to;
    to = from * AREA_TANNI[kigou];
    to = to / AREA_TANNI[to_kigou];
    return to;
}
const double LENGTH_TANNI[]={1,149597870700,1852,0.0254,0.3048,0.9144,1604.344,3927.27,1.1818,1.1818,0.30303,0.030303,9460730472580800};
    /**
     * @brief 長さの単位を変換します。
     * 対応単位一覧  
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
     * @param from 値
     * @param kigou 値の単位(番号)
     * @param to_kigou 変換後の単位(番号)
     * @return double 変換後の値
     */
double lengthchange(double from,int kigou,int to_kigou){
    double to;
    to=from*LENGTH_TANNI[kigou];
    to=to/LENGTH_TANNI[to_kigou];
    return to;
}
const double MASS_TANNI[]={1,1000,1000000,0.000001,0.2,28.349523125,453.59237,100000,3.75,3750,37.5,600};
    /**
     * @brief 質量の単位を変換します。
     * 対応単位一覧
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
     * 
     * @param from 値
     * @param kigou 値の単位(番号)
     * @param to_kigou 変換後の単位(番号)
     * @return double 変換後の値 
     */
double masschange(double from,int kigou,int to_kigou){
    double to;
    to=from*MASS_TANNI[kigou];
    to=to/MASS_TANNI[to_kigou];
    return to;
}
const double PREFIX[] = {1,1000000000000000000000000,1000000000000000000000,1000000000000000000,1000000000000000,1000000000000,1000000000,1000000,1000,100,10,0.1,0.01,0.001,0.000001,0.000000001,0.000000000001,0.000000000000001,0.000000000000000001,0.000000000000000000001,0.000000000000000001};
    /**
    @brief 接頭辞の単位を変換します。
    対応単位一覧
    0番="normal":1
    1番="Y":10^24
    2番="Z":10^21
    3番="E":10^18
    4番="P":10^15
    5番="T":10^12
    6番="G":10^9
    7番="M":10^6
    8番="k":10^3
    9番="h":10^2
    10番="da":10
    11番="d":10^-1
    12番="c":10^-2
    13番="m":10^-3
    14番="micro":10^-6(μ)
    15番="n":10^-9
    16番="p":10^-12
    17番="f":10^-15
    18番="a":10^-18
    19番="z":10^-21
    20番="y":10^-24
    @param from 値
    @param kigou 値の単位(番号)
    @param to_kigou 変換後の単位(番号)
    @return double 変換後の値 
     */
double prefixchange(double from, int kigou, int to_kigou)
{
    double to;
    to = from * PREFIX[kigou];
    to = to / PREFIX[to_kigou];
    return to;
}
const double SPEED_TANNI[] = {1,0.00008466667,0.000423333,0.00508,0.0254,0.2777778,0.3048,0.44704,0.514444,26.8224,1.609344,299792458};
    /**
    @brief 速度の単位を変換します。
    対応単位一覧
    0番="m/s":メートル毎秒(1m/s)
    1番="km/h":キロメートル毎時(0.2777778m/s)
    2番="ft/h":フィート毎時(0.00008466667m/s)
    3番="ft/min":フィート毎分(0.00508m/s)
    4番="ft/s":フィート毎秒(0.3048m/s)
    5番="in/min":インチ毎分(0.000423333m/s)
    6番="in/s":インチ毎秒(0.0254m/s)
    7番="mi/h":マイル毎時(0.44704m/s)
    8番="mi/min":マイル毎分(26.8224m/s)
    9番="mi/s":マイル毎秒(1.609344m/s)
    10番="kn":ノット(0.514444m/s)
    11番="c":真空中の光速度(299792458m/s)
    @param from 値
    @param kigou 値の単位(番号)
    @param to_kigou 変換後の単位(番号)
    @return double 変換後の値 
     */
double speedchange(double from, int kigou, int to_kigou)
{
    double to;
    to = from * SPEED_TANNI[kigou];
    to = to / SPEED_TANNI[to_kigou];
    return to;
}
const double TEMP_TANNI_p[] = {0,237.15,459.67,0};
const double TEMP_TANNI_m[] = {1,1, 5 / 9, 5 / 9};
    /**
     * @brief 温度の単位を変換します。
     * 対応単位一覧
     * 0番="K":ケルビン
     * 1番="C":セルシウス度
     * 2番="F":ファーレンハイト度
     * 3番="Ra":ランキン度
     * @param from 値
     * @param kigou 値の単位(番号)
     * @param to_kigou 変換後の単位(番号)
     * @return double 変換後の値 
     */
double remperaturechange(double from, int kigou, int to_kigou)
{
    double to;
    to = from + TEMP_TANNI_p[kigou];
    to = to * TEMP_TANNI_m[kigou];
    to = to / TEMP_TANNI_m[to_kigou];
    to = to - TEMP_TANNI_p[to_kigou];
    return to;
}
const double TIME_TANNI[] = {1, 0.00000001, 0.001024, 1 / 50, 1 / 60, 60, 90, 900, 864, 60 * 60, 60 * 60 * 24, 60 * 60 * 24 * 7, 60 * 60 * 24 * 10, 60 * 60 * 24 * 14, 2551442.27, 60 * 60 * 24 * 30, 7776000, 10872000, 31536000, 31556952, 31557600, 31558149.764928, 3153600000};
    /**
    @brief 加速度の単位を変換します。
    対応単位一覧
    0番="s":秒(1s)
    1番="shake":シェイク(0.00000001s)
    2番="TU":Time Unit(0.001024s)
    3番="jiffy_e":ジフィ(電子工学,東日本)(1/50)
    4番="jiffy_w":ジフィ(電子工学,西日本)(1/60)
    5番="min":分(60s)
    6番="moment":モーメント(90s)
    7番="KOKU":刻(中国,100刻制)(900s)
    8番="KOKU_old":刻(中国,96刻制)(864s)
    9番="h":時(60*60s)
    10番="d":日(606024s)
    11番="wk":週(606024*7s)
    12番="JUN":旬(606024*10s)
    13番="fortnight":フォートナイト(半月)(606024*14s)
    14番="SAKUBO":朔望月(2551442.27s)
    15番="mo":月(30d)(606024*30s)
    16番="quarter":四半期(7776000s)
    17番="semester":セメスター(10872000s)
    18番="y":年(365d)(31536000s)
    19番="greg":グレゴリオ年(31556952s)
    20番="juli":ユリウス年(31557600s)
    21番="year":恒星年(31558149.764928s)
    22番="c":世紀(365d*100)(3153600000s)
    @param from 値
    @param kigou 値の単位(番号)
    @param to_kigou 変換後の単位(番号)
    @return double 変換後の値 
     */
double time_unitchange(double from, int kigou, int to_kigou)
{
    double to;
    to = from * TIME_TANNI[kigou];
    to = to / TIME_TANNI[to_kigou];
    return to;
}
const double VOLUME_TANNI[] = {1, 0.001, 0.000005, 0.000015, 0.00025, 0.000000001, 1233.48183754752, 0.00000005, 0.000016387064, 0.028316846592, 0.764554857984, 4168.181825440579584, 0.18039, 0.0018039, 0.00018039, 0.018039, 0.000018039};
    /**
    @brief 体積の単位を変換します。
    対応単位一覧
    0番="m3":立方メートル(1m^3)
    1番="L":リットル(0.001m^3)
    2番="KOSAJI":小さじ(0.000005m^3)
    3番="OSAJI":大さじ(0.000015m^3)
    4番="c":カップ(0.00025m^3)
    5番="lambda":λ(0.000000001m^3)
    6番="acft":エーカー・フィート(1233.48183754752m^3)
    7番="drop":ドロップ(0.00000005m^3)
    8番="in3":立方インチ(0.000016387064m^3)
    9番="ft3":立方フィート(0.028316846592m^3)
    10番="yd3":立方ヤード(0.764554857984m^3)
    11番="mi3":立方マイル(4168.181825440579584m^3)
    12番="KOKU":石(0.18039m^3)
    13番="TO":斗(0.018039m^3)
    14番="SHOU":升(0.0018039m^3)
    15番="GOU":合(0.00018039m^3)
    16番="SHAKU":勺(0.000018039m^3)
    @param from 値
    @param kigou 値の単位(番号)
    @param to_kigou 変換後の単位(番号)
    @return double 変換後の値 
     */
double volumechange(double from, int kigou,int to_kigou)
{
    double to;
    to = from * VOLUME_TANNI[kigou];
    to = to / VOLUME_TANNI[to_kigou];
    return to;
}
#endif