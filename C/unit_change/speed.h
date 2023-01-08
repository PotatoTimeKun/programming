/**
 * @file speed.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 速度の単位を変換するためのspeedchange関数が入っています。
 * 
 */
#ifndef SPEED_LENGTH
#define SPEED_LENGTH
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
#endif