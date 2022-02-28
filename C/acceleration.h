/**
 * @file acceleration.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 加速度の単位を変換するためのaccchange関数が入っています。
 * 
 */
#ifndef INCLUDE_ACC
#define INCLUDE_ACC
const int ACC_TANNI[] = {1, 0.27777777,0.00008466666666,0.000423333333,0.00508,0.01,0.0254,0.3048,0.44704,0.5144444,9.80665,26.8224,1609.344};
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
#endif