/**
 * @file area.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 面積の単位を変換するためのareachange関数が入っています。
 * 
 */
#ifndef AREA_LENGTH
#define AREA_LENGTH
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
#endif